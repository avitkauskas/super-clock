import * as df from 'date-fns'
import * as helpers from './helpers'

export tag clock-view
	prop down = false
	prop deleting = false
	prop date\Date
	prop onDots

	css pos:absolute t:50% l:50% x:-50% y:-51%
	css svg pe:none
		.target fill:transparent pe:fill
		.dot stroke-width:1.5px c:$fg fill:$bg .on:$fg stroke:$fg
			tween:all 200ms ease-out transform-box:fill-box origin:center
		&@not(.down) .dotgroup@hover .dot scale:1.3
		.center-dot fill:$fg
		.hand stroke:$fg stroke-width:5px
		.minutes stroke:red4 stroke-width:2px
		.numbers text fill:$fg
		.bezel stroke:$fg stroke-width:1.5px
		.lines path stroke:$fg stroke-width:1.5px stroke-opacity:0.75
		# show the target areas, for debugging:
		# .target fill:red5/50

	def render

		# find what percent into the day we are, this will be used to position the hand
		const percent = helpers.getPercentIntoToday(date)

		# find what percent into the current hour we are, this will be used to position the hand
		const minutes = helpers.getPercentIntoCurrentHour(date)

		# convert a dot index into the corresponding time for label
		def getTitle index
			const startOfDay = df.startOfDay(date)
			const time = df.addMinutes startOfDay, (index + 1) * 30
			df.format(time, "hh:mm a")

		<self>

			# this tag is essentially all SVG code. The code is included directly
			# in the tag so that I can attach some event handlers, and logic for 
			# turning the dot on/off, and displaying the tooltips. It might make more
			# sense to generate the graphic, to keep the code smaller, but I went
			# the manual way for now.

			<svg$svg
				viewBox="0 0 1014 1014"
				fill="none"
				xmlns="http://www.w3.org/2000/svg"
				.down=down
				.deleting=deleting
				.adding=(deleting === false)
				@touch.prevent.emit('clockTouch')
			>
			
				# clock bezel outline
				<circle .bezel cx="506.5" cy="506.5" r="505" stroke="black" stroke-width="3">

				# clock center dot
				<circle .center-dot cx="507" cy="507" r="10" stroke="black" stroke-width="3" fill="black" />
								
				# clock hand, transformed to rotate 'percent' amount
				<path.hand transform="rotate({percent * 360}, 507, 507)" d="M507 92L507 505" stroke="black" stroke-width="3" stroke-linecap="round" >

				# minutes hand, transformed to rotate 'minutes' amount
				<path.minutes transform="rotate({minutes * 360}, 507, 507)" d="M507 88L507 505" stroke="black" stroke-width="3" stroke-linecap="round" >

				# these are the dots, and their touch areas
				<g.dotgroup>
					<path  .dot .on=(onDots.includes(0)) d="M565.476 64.3327C572.868 65.3059 579.649 60.1023 580.623 52.7103C581.596 45.3182 576.392 38.5369 569 37.5637C561.608 36.5905 554.827 41.794 553.853 49.1861C552.88 56.5781 558.084 63.3595 565.476 64.3327Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M587.627 99.6842C570.29 96.28 552.616 93.967 534.69 92.811L540.643 1.98844C562.568 3.40223 584.184 6.23587 605.385 10.4083L587.627 99.6842Z" >
					# <title> getTitle(0)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(1)) d="M622.951 75.7652C630.153 77.6949 637.555 73.4211 639.485 66.2193C641.415 59.0175 637.141 51.6149 629.939 49.6852C622.737 47.7555 615.335 52.0294 613.405 59.2312C611.475 66.433 615.749 73.8355 622.951 75.7652Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M640.19 113.658C623.405 107.989 606.181 103.373 588.608 99.8781L606.366 10.6024C627.858 14.8764 648.922 20.5266 669.447 27.4683L640.19 113.658Z" >
					# <title> getTitle(1)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(2)) d="M678.443 94.6021C685.331 97.4553 693.228 94.1842 696.081 87.2959C698.935 80.4076 695.664 72.5105 688.775 69.6573C681.887 66.8041 673.99 70.0752 671.137 76.9635C668.283 83.8518 671.554 91.7488 678.443 94.6021Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M690.469 134.405C674.534 126.573 658.06 119.741 641.137 113.979L670.394 27.7895C691.091 34.835 711.238 43.1945 730.721 52.7811L690.469 134.405Z" >
					# <title> getTitle(2)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(3)) d="M731 120.52C737.457 124.248 745.713 122.036 749.441 115.579C753.169 109.122 750.957 100.866 744.5 97.1377C738.043 93.4097 729.787 95.6221 726.059 102.079C722.331 108.536 724.543 116.792 731 120.52Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M737.614 161.534C722.808 151.677 707.36 142.758 691.365 134.847L731.618 53.2235C751.179 62.8965 770.069 73.8076 788.171 85.8687L737.614 161.534Z" >
					# <title> getTitle(3)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(4)) d="M779.726 153.078C785.641 157.617 794.115 156.501 798.654 150.586C803.193 144.671 802.077 136.197 796.162 131.658C790.247 127.119 781.773 128.235 777.234 134.15C772.695 140.065 773.811 148.539 779.726 153.078Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M780.837 194.56C767.414 182.845 753.253 171.997 738.446 162.089L789.003 86.424C807.112 98.5404 824.429 111.809 840.839 126.142L780.837 194.56Z" >
					# <title> getTitle(4)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(5)) d="M823.784 191.716C829.056 196.988 837.604 196.988 842.876 191.716C848.148 186.444 848.148 177.896 842.876 172.624C837.604 167.352 829.056 167.352 823.784 172.624C818.512 177.896 818.512 186.444 823.784 191.716Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M819.408 232.929C807.603 219.544 794.966 206.949 781.59 195.219L841.591 126.8C857.949 141.145 873.402 156.548 887.833 172.922L819.408 232.929Z" >
					# <title> getTitle(5)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(6)) d="M862.423 235.775C866.962 241.69 875.436 242.806 881.351 238.267C887.266 233.728 888.382 225.254 883.843 219.339C879.304 213.424 870.83 212.308 864.915 216.847C859 221.386 857.884 229.86 862.423 235.775Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M852.651 276.01C842.678 261.165 831.786 247.031 820.069 233.68L888.493 173.673C902.824 189.998 916.141 207.283 928.332 225.442L852.651 276.01Z" >
					# <title> getTitle(6)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(7)) d="M894.98 284.5C898.708 290.957 906.964 293.169 913.421 289.441C919.878 285.713 922.09 277.457 918.362 271C914.634 264.543 906.378 262.331 899.921 266.059C893.464 269.787 891.252 278.043 894.98 284.5Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M879.959 323.087C872.006 307.019 863.059 291.581 853.208 276.841L928.888 226.273C940.937 244.296 951.876 263.176 961.597 282.827L879.959 323.087Z" >
					# <title> getTitle(7)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(8)) d="M920.899 337.058C923.752 343.947 931.649 347.218 938.537 344.364C945.426 341.511 948.697 333.614 945.843 326.726C942.99 319.837 935.093 316.566 928.205 319.42C921.316 322.273 918.045 330.17 920.899 337.058Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M900.833 373.35C895.047 356.328 888.208 339.851 880.402 323.983L962.039 283.724C971.588 303.125 979.951 323.276 987.02 344.094L900.833 373.35Z" >
					# <title> getTitle(8)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(9)) d="M939.735 392.549C941.665 399.751 949.067 404.025 956.269 402.095C963.471 400.165 967.745 392.763 965.815 385.561C963.885 378.359 956.483 374.085 949.281 376.015C942.079 377.945 937.805 385.347 939.735 392.549Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M914.927 425.914C911.404 408.228 906.786 391.002 901.153 374.298L987.341 345.041C994.231 365.466 999.878 386.531 1004.18 408.161L914.927 425.914Z" >
					# <title> getTitle(9)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(10)) d="M951.168 450.024C952.141 457.416 958.922 462.62 966.314 461.647C973.706 460.673 978.91 453.892 977.937 446.5C976.963 439.108 970.182 433.904 962.79 434.877C955.398 435.851 950.194 442.632 951.168 450.024Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M922.094 479.858C921.497 471.029 920.616 462.162 919.445 453.266C918.274 444.371 916.83 435.578 915.122 426.895L1004.38 409.142C1006.47 419.758 1008.23 430.51 1009.67 441.388C1011.1 452.267 1012.17 463.11 1012.9 473.906L922.094 479.858Z" >
					# <title> getTitle(10)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(11)) d="M955 508.5C955 515.956 961.044 522 968.5 522C975.956 522 982 515.956 982 508.5C982 501.044 975.956 495 968.5 495C961.044 495 955 501.044 955 508.5Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M922.215 534.278C923.332 516.686 923.335 498.851 922.161 480.856L1012.97 474.904C1014.41 496.91 1014.41 518.719 1013.04 540.231L922.215 534.278Z" >
					# <title> getTitle(11)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(12)) d="M951.167 566.976C950.194 574.368 955.398 581.149 962.79 582.123C970.182 583.096 976.963 577.892 977.937 570.5C978.91 563.108 973.706 556.327 966.314 555.353C958.922 554.38 952.141 559.584 951.167 566.976Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M915.193 588.249C918.627 570.902 920.968 553.216 922.151 535.276L1012.97 541.229C1011.53 563.168 1008.67 584.796 1004.47 606.007L915.193 588.249Z" >
					# <title> getTitle(12)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(13)) d="M939.735 624.451C937.805 631.653 942.079 639.055 949.281 640.985C956.483 642.915 963.885 638.641 965.815 631.439C967.745 624.237 963.471 616.835 956.269 614.905C949.067 612.975 941.665 617.249 939.735 624.451Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M901.127 640.824C906.827 624.036 911.474 606.808 914.998 589.23L1004.27 606.988C999.97 628.486 994.29 649.554 987.317 670.081L901.127 640.824Z" >
					# <title> getTitle(13)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(14)) d="M920.899 679.942C918.045 686.83 921.317 694.727 928.205 697.58C935.093 700.434 942.99 697.162 945.843 690.274C948.697 683.386 945.426 675.489 938.537 672.636C931.649 669.782 923.752 673.053 920.899 679.942Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M880.288 691.091C888.151 675.162 895.013 658.691 900.804 641.77L986.994 671.028C979.919 691.723 971.529 711.866 961.912 731.344L880.288 691.091Z" >
					# <title> getTitle(14)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(15)) d="M894.98 732.5C891.252 738.957 893.464 747.213 899.921 750.941C906.378 754.669 914.634 752.457 918.362 746C922.09 739.543 919.878 731.287 913.421 727.559C906.964 723.831 898.708 726.043 894.98 732.5Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M853.075 738.201C862.959 723.408 871.906 707.972 879.844 691.987L961.468 732.24C951.767 751.791 940.828 770.669 928.74 788.758L853.075 738.201Z" >
					# <title> getTitle(15)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(16)) d="M862.423 781.225C857.884 787.14 859 795.614 864.915 800.153C870.83 804.692 879.304 803.576 883.843 797.661C888.382 791.746 887.266 783.272 881.351 778.733C875.436 774.194 866.962 775.31 862.423 781.225Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M819.975 781.368C831.713 767.965 842.585 753.822 852.518 739.032L928.183 789.589C916.042 807.681 902.749 824.979 888.394 841.37L819.975 781.368Z" >
					# <title> getTitle(16)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(17)) d="M823.784 825.284C818.512 830.556 818.512 839.104 823.784 844.376C829.056 849.648 837.604 849.648 842.876 844.376C848.148 839.104 848.148 830.556 842.876 825.284C837.604 820.012 829.056 820.012 823.784 825.284Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M781.55 819.866C794.953 808.086 807.565 795.473 819.316 782.12L887.734 842.121C873.37 858.457 857.948 873.885 841.557 888.291L781.55 819.866Z" >
					# <title> getTitle(17)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(18)) d="M779.726 863.923C773.811 868.462 772.695 876.936 777.234 882.851C781.773 888.766 790.247 889.882 796.162 885.343C802.077 880.804 803.193 872.33 798.654 866.415C794.115 860.5 785.641 859.384 779.726 863.923Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M738.434 853.024C753.289 843.079 767.434 832.215 780.799 820.526L840.805 888.95C824.467 903.253 807.17 916.542 789.002 928.705L738.434 853.024Z" >
					# <title> getTitle(18)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(19)) d="M731 896.48C724.543 900.208 722.331 908.464 726.059 914.921C729.787 921.378 738.043 923.59 744.5 919.862C750.957 916.134 753.169 907.878 749.441 901.421C745.713 894.964 737.457 892.752 731 896.48Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M691.345 880.24L731.604 961.878C751.258 952.187 770.141 941.277 788.17 929.26L737.602 853.579C722.856 863.399 707.414 872.316 691.345 880.24Z" >
					# <title> getTitle(19)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(20)) d="M678.443 922.398C671.554 925.251 668.283 933.148 671.137 940.036C673.99 946.925 681.887 950.196 688.775 947.342C695.664 944.489 698.935 936.592 696.081 929.704C693.228 922.815 685.331 919.544 678.443 922.398Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M690.447 880.681C674.582 888.457 658.109 895.265 641.093 901.022L670.349 987.209C691.161 980.169 711.308 971.837 730.707 962.319L690.447 880.681Z" >
					# <title> getTitle(20)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(21)) d="M622.951 941.235C615.749 943.165 611.475 950.567 613.405 957.769C615.335 964.971 622.737 969.245 629.939 967.315C637.141 965.385 641.415 957.983 639.485 950.781C637.555 943.579 630.153 939.305 622.951 941.235Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M588.564 915.031L606.318 1004.29C627.933 1000.01 648.987 994.389 669.402 987.528L640.145 901.341C623.451 906.943 606.236 911.534 588.564 915.031Z" >
					# <title> getTitle(21)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(22)) d="M569 979.437C576.392 978.463 581.596 971.682 580.622 964.29C579.649 956.898 572.868 951.694 565.476 952.668C558.084 953.641 552.88 960.422 553.853 967.814C554.827 975.206 561.608 980.41 569 979.437Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M534.677 922.125L540.629 1012.93C551.578 1012.21 562.577 1011.12 573.611 1009.67C584.312 1008.26 594.89 1006.53 605.337 1004.48L587.583 915.224C579.07 916.888 570.451 918.298 561.734 919.445C552.681 920.637 543.659 921.528 534.677 922.125Z" >
					# <title> getTitle(22)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(23)) d="M507 983.5C514.456 983.5 520.5 977.456 520.5 970C520.5 962.544 514.456 956.5 507 956.5C499.544 956.5 493.5 962.544 493.5 970C493.5 977.456 499.544 983.5 507 983.5Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M480.329 922.19L474.377 1013.01C495.864 1014.4 517.649 1014.42 539.631 1013L533.679 922.191C515.708 923.343 497.898 923.322 480.329 922.19Z" >
					# <title> getTitle(23)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(24)) d="M445 979.437C452.392 980.41 459.173 975.206 460.146 967.814C461.12 960.422 455.916 953.641 448.524 952.667C441.132 951.694 434.351 956.898 433.377 964.29C432.404 971.682 437.608 978.463 445 979.437Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M426.444 915.132L408.686 1004.41C429.869 1008.62 451.469 1011.49 473.379 1012.95L479.331 922.125C461.421 920.927 443.763 918.574 426.444 915.132Z" >
					# <title> getTitle(24)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(25)) d="M384.061 967.315C391.263 969.245 398.665 964.971 400.595 957.769C402.525 950.567 398.251 943.165 391.049 941.235C383.847 939.305 376.445 943.579 374.515 950.781C372.585 957.983 376.859 965.385 384.061 967.315Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M373.961 901.054L344.703 987.244C365.201 994.217 386.239 999.901 407.705 1004.21L425.463 914.936C407.916 911.404 390.719 906.754 373.961 901.054Z" >
					# <title> getTitle(25)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(26)) d="M325.226 947.342C332.114 950.196 340.011 946.925 342.864 940.036C345.718 933.148 342.447 925.251 335.558 922.398C328.67 919.544 320.773 922.815 317.92 929.704C315.066 936.592 318.337 944.489 325.226 947.342Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M323.785 880.227L283.533 961.851C302.981 971.46 323.094 979.846 343.757 986.921L373.015 900.731C356.125 894.94 339.685 888.082 323.785 880.227Z" >
					# <title> getTitle(26)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(27)) d="M269.5 919.862C275.957 923.59 284.213 921.378 287.941 914.921C291.669 908.464 289.457 900.208 283 896.48C276.543 892.752 268.287 894.964 264.559 901.421C260.831 907.878 263.043 916.134 269.5 919.862Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M276.761 853.049L226.203 928.714C244.266 940.787 263.115 951.714 282.636 961.407L322.889 879.783C306.934 871.853 291.527 862.918 276.761 853.049Z" >
					# <title> getTitle(27)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(28)) d="M217.839 885.343C223.754 889.882 232.228 888.766 236.767 882.851C241.306 876.936 240.19 868.462 234.275 863.923C228.36 859.384 219.886 860.5 215.347 866.415C210.808 872.33 211.924 880.804 217.839 885.343Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M233.666 820.006L173.665 888.424C190.033 902.758 207.308 916.032 225.372 928.157L275.93 852.493C261.167 842.575 247.048 831.722 233.666 820.006Z" >
					# <title> getTitle(28)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(29)) d="M171.125 844.376C176.397 849.648 184.945 849.648 190.217 844.376C195.489 839.104 195.489 830.556 190.217 825.284C184.945 820.012 176.397 820.012 171.125 825.284C165.853 830.556 165.853 839.104 171.125 844.376Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M195.224 781.654L126.8 841.661C141.19 858.025 156.6 873.422 172.913 887.765L232.915 819.346C219.583 807.617 206.989 795.029 195.224 781.654Z" >
					# <title> getTitle(29)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(30)) d="M130.158 797.661C134.697 803.576 143.171 804.692 149.086 800.153C155.001 795.614 156.117 787.14 151.578 781.225C147.039 775.31 138.565 774.194 132.65 778.733C126.735 783.272 125.619 791.746 130.158 797.661Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M162.102 738.623L86.4218 789.191C98.5754 807.328 111.853 824.597 126.14 840.909L194.565 780.902C182.89 767.564 172.039 753.447 162.102 738.623Z" >
					# <title> getTitle(30)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(31)) d="M95.6387 746C99.3666 752.457 107.623 754.669 114.08 750.941C120.537 747.213 122.749 738.957 119.021 732.5C115.293 726.043 107.037 723.831 100.58 727.559C94.1231 731.287 91.9108 739.543 95.6387 746Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M134.898 691.625L53.2605 731.884C62.9508 751.506 73.8559 770.359 85.866 788.359L161.547 737.791C151.734 723.074 142.821 707.662 134.898 691.625Z" >
					# <title> getTitle(31)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(32)) d="M68.1575 690.274C71.0108 697.162 78.9078 700.434 85.7961 697.58C92.6844 694.727 95.9555 686.83 93.1023 679.942C90.2491 673.053 82.352 669.782 75.4637 672.636C68.5754 675.489 65.3043 683.386 68.1575 690.274Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M114.104 641.465L27.9172 670.721C34.9648 691.502 43.3004 711.617 52.8186 730.987L134.456 690.728C126.68 674.892 119.868 658.449 114.104 641.465Z" >
					# <title> getTitle(32)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(33)) d="M48.1857 631.439C50.1154 638.641 57.518 642.915 64.7198 640.985C71.9215 639.055 76.1954 631.653 74.2657 624.451C72.336 617.249 64.9334 612.975 57.7316 614.905C50.5298 616.835 46.256 624.237 48.1857 631.439Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M100.06 589.021L10.805 606.775C15.0975 628.362 20.7278 649.387 27.597 669.774L113.784 640.517C108.173 623.851 103.572 606.665 100.06 589.021Z" >
					# <title> getTitle(33)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(34)) d="M36.064 570.5C37.0372 577.892 43.8186 583.096 51.2106 582.122C58.6027 581.149 63.8062 574.368 62.833 566.976C61.8598 559.584 55.0785 554.38 47.6864 555.353C40.2944 556.327 35.0908 563.108 36.064 570.5Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M92.9102 535.207L2.10173 541.159C2.82981 551.934 3.90392 562.755 5.33319 573.612C6.76246 584.468 8.5257 595.198 10.6111 605.794L99.8658 588.04C98.1631 579.379 96.7229 570.607 95.5547 561.734C94.3864 552.86 93.5073 544.015 92.9102 535.207Z" >
					# <title> getTitle(34)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(35)) d="M32.0005 508.5C32.0005 515.956 38.0446 522 45.5005 522C52.9563 522 59.0005 515.956 59.0005 508.5C59.0005 501.044 52.9563 495 45.5005 495C38.0446 495 32.0005 501.044 32.0005 508.5Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M92.7723 480.916L1.94966 474.963C0.591163 496.434 0.594308 518.2 2.03513 540.162L92.8437 534.21C91.6696 516.258 91.6664 498.467 92.7723 480.916Z" >
					# <title> getTitle(35)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(36)) d="M36.064 446.5C35.0908 453.892 40.2944 460.673 47.6864 461.646C55.0785 462.62 61.8598 457.416 62.833 450.024C63.8062 442.632 58.6027 435.851 51.2106 434.877C43.8186 433.904 37.0372 439.108 36.064 446.5Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M99.7445 427.066L10.4687 409.308C6.28809 430.481 3.44288 452.069 2.01381 473.965L92.8364 479.918C94.0076 462.021 96.3322 444.375 99.7445 427.066Z" >
					# <title> getTitle(36)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(37)) d="M48.1858 385.561C46.2561 392.763 50.53 400.165 57.7317 402.095C64.9335 404.025 72.3361 399.751 74.2658 392.549C76.1955 385.347 71.9217 377.945 64.7199 376.015C57.5181 374.085 50.1155 378.359 48.1858 385.561Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M113.731 374.595L27.5411 345.337C20.5992 365.833 14.9452 386.866 10.6634 408.327L99.9392 426.085C103.442 408.543 108.062 391.35 113.731 374.595Z" >
					# <title> getTitle(37)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(38)) d="M68.1574 326.726C65.3042 333.614 68.5753 341.511 75.4636 344.364C82.3519 347.218 90.2489 343.947 93.1022 337.058C95.9554 330.17 92.6843 322.273 85.796 319.42C78.9077 316.566 71.0107 319.837 68.1574 326.726Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M134.466 324.407L52.8422 284.155C43.2632 303.609 34.908 323.725 27.8629 344.39L114.053 373.648C119.814 356.757 126.641 340.312 134.466 324.407Z" >
					# <title> getTitle(38)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(39)) d="M95.6386 271C91.9107 277.457 94.123 285.713 100.58 289.441C107.037 293.169 115.293 290.957 119.021 284.5C122.749 278.043 120.537 269.787 114.08 266.059C107.623 262.331 99.3666 264.543 95.6386 271Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M161.559 277.348L85.8944 226.79C73.8486 244.866 62.9494 263.727 53.2848 283.258L134.909 323.511C142.811 307.546 151.718 292.127 161.559 277.348Z" >
					# <title> getTitle(39)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(40)) d="M130.158 219.339C125.619 225.254 126.735 233.728 132.65 238.267C138.565 242.806 147.039 241.69 151.578 235.775C156.117 229.86 155.001 221.386 149.086 216.847C143.171 212.308 134.697 213.424 130.158 219.339Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M194.53 234.198L126.111 174.196C111.801 190.584 98.5507 207.877 86.4498 225.958L162.115 276.516C172.008 261.736 182.837 247.598 194.53 234.198Z" >
					# <title> getTitle(40)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(41)) d="M171.125 172.624C165.853 177.896 165.853 186.444 171.125 191.716C176.397 196.988 184.945 196.988 190.217 191.716C195.489 186.444 195.489 177.896 190.217 172.624C184.945 167.352 176.397 167.352 171.125 172.624Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M232.826 195.683L172.819 127.258C156.472 141.673 141.093 157.107 126.77 173.444L195.188 233.445C206.897 220.09 219.467 207.472 232.826 195.683Z" >
					# <title> getTitle(41)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(42)) d="M217.839 131.658C211.924 136.197 210.808 144.671 215.347 150.586C219.886 156.501 228.36 157.617 234.275 153.078C240.19 148.539 241.306 140.065 236.767 134.15C232.228 128.235 223.754 127.119 217.839 131.658Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M275.822 162.476L225.253 86.7948C207.125 98.9768 189.869 112.282 173.57 126.597L233.576 195.022C246.901 183.32 261.007 172.44 275.822 162.476Z" >
					# <title> getTitle(42)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(43)) d="M269.5 97.1376C263.043 100.866 260.831 109.122 264.559 115.579C268.287 122.036 276.543 124.248 283 120.52C289.457 116.792 291.669 108.536 287.941 102.079C284.213 95.622 275.957 93.4097 269.5 97.1376Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M322.806 135.179L282.547 53.5416C262.928 63.2618 244.078 74.1972 226.084 86.2379L276.652 161.919C291.363 152.075 306.771 143.132 322.806 135.179Z" >
					# <title> getTitle(43)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(44)) d="M325.226 69.6572C318.337 72.5104 315.066 80.4075 317.92 87.2958C320.773 94.1841 328.67 97.4552 335.558 94.602C342.447 91.7487 345.718 83.8517 342.864 76.9634C340.011 70.0751 332.114 66.804 325.226 69.6572Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M372.979 114.294L343.722 28.1065C322.935 35.1832 302.816 43.5491 283.444 53.0987L323.703 134.736C339.541 126.929 355.988 120.086 372.979 114.294Z" >
					# <title> getTitle(44)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(45)) d="M384.062 49.6854C376.86 51.6151 372.586 59.0177 374.516 66.2194C376.446 73.4212 383.848 77.6951 391.05 75.7654C398.252 73.8357 402.526 66.4331 400.596 59.2313C398.666 52.0295 391.264 47.7557 384.062 49.6854Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M425.457 100.164L407.703 10.9091C386.103 15.2276 365.066 20.8861 344.669 27.7852L373.925 113.972C390.602 108.332 407.8 103.702 425.457 100.164Z" >
					# <title> getTitle(45)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(46)) d="M448.524 64.3327C455.916 63.3595 461.12 56.5782 460.147 49.1861C459.173 41.794 452.392 36.5905 445 37.5637C437.608 38.5369 432.404 45.3183 433.377 52.7103C434.351 60.1024 441.132 65.3059 448.524 64.3327Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M479.327 92.9421L473.375 2.13341C462.755 2.86081 452.089 3.92452 441.388 5.33321C430.354 6.78594 419.449 8.5836 408.684 10.714L426.438 99.9687C435.269 98.2211 444.214 96.7464 453.266 95.5547C461.984 94.407 470.674 93.5384 479.327 92.9421Z" >
					# <title> getTitle(46)
				<g.dotgroup>
					<path .dot .on=(onDots.includes(47)) d="M507 60.5C514.456 60.5 520.5 54.4558 520.5 47C520.5 39.5442 514.456 33.5 507 33.5C499.544 33.5 493.5 39.5442 493.5 47C493.5 54.4558 499.544 60.5 507 60.5Z" fill="white" stroke="black" stroke-width="3">
					<path .target d="M474.373 2.06596C496.359 0.60337 518.149 0.581913 539.645 1.92511L533.692 92.7479C516.116 91.6572 498.3 91.6787 480.325 92.8744L474.373 2.06596Z" >
					# <title> getTitle(47)

				# tick mark lines longer (main hours)
				<g.lines>
					<path d="M507 845V925" stroke="black" stroke-linecap="round">
					<path d="M507 92V172" stroke="black" stroke-linecap="round">
					<path d="M924 509H844" stroke="black" stroke-linecap="round">
					<path d="M181 508H91" stroke="black" stroke-linecap="round">

				# tick mark lines shorter (minutes)
				<g.lines>
					<path d="M318.75 834.559L298.75 869.2" stroke="black" stroke-linecap="round">
					<path d="M180.941 696.75L146.3 716.75" stroke="black" stroke-linecap="round">
					<path d="M180.941 320.25L146.3 300.25" stroke="black" stroke-linecap="round">
					<path d="M318.75 182.441L298.75 147.8" stroke="black" stroke-linecap="round">
					<path d="M715.25 147.8L695.25 182.441" stroke="black" stroke-linecap="round">
					<path d="M867.699 300.25L833.058 320.25" stroke="black" stroke-linecap="round">
					<path d="M867.699 716.75L833.058 696.75" stroke="black" stroke-linecap="round">
					<path d="M715.25 869.2L695.25 834.559" stroke="black" stroke-linecap="round">

				# tick mark lines shorter (other)
				# <g.lines>
				# 	<path d="M409.554 872.171L399.201 910.808" stroke="black" stroke-linecap="round">				
				# 	<path d="M240.774 774.726L212.49 803.01" stroke="black" stroke-linecap="round">
				# 	<path d="M143.328 605.945L104.691 616.298" stroke="black" stroke-linecap="round">
				# 	<path d="M143.328 411.054L104.691 400.702" stroke="black" stroke-linecap="round">
				# 	<path d="M240.774 242.274L212.49 213.99" stroke="black" stroke-linecap="round">
				# 	<path d="M409.554 144.829L399.202 106.192" stroke="black" stroke-linecap="round">
				# 	<path d="M614.798 106.192L604.445 144.829" stroke="black" stroke-linecap="round">
				# 	<path d="M801.51 213.99L773.225 242.274" stroke="black" stroke-linecap="round">
				# 	<path d="M909.308 400.702L870.671 411.055" stroke="black" stroke-linecap="round">
				# 	<path d="M909.308 616.298L870.671 605.945" stroke="black" stroke-linecap="round">
				# 	<path d="M801.51 803.01L773.225 774.726" stroke="black" stroke-linecap="round">
				# 	<path d="M614.798 910.808L604.445 872.171" stroke="black" stroke-linecap="round">

				# hour numbers
				<g.numbers>
					<text x="503" y="20" fill="black"> '0'
					<text x="630" y="38" fill="black"> '1'
					<text x="748" y="86" fill="black"> '2'
					<text x="849" y="163" fill="black"> '3'
					<text x="928" y="266" fill="black"> '4'
					<text x="979" y="388" fill="black"> '5'
					<text x="996" y="515" fill="black"> '6'
					<text x="979" y="644" fill="black"> '7'
					<text x="928" y="760" fill="black"> '8'
					<text x="852" y="860" fill="black"> '9'
					<text x="743" y="939" fill="black"> '10'
					<text x="627" y="988" fill="black"> '11'
					<text x="499" y="1004" fill="black"> '12'
					<text x="370" y="988" fill="black"> '13'
					<text x="254" y="939" fill="black"> '14'
					<text x="153" y="862" fill="black"> '15'
					<text x="73" y="760" fill="black"> '16'
					<text x="24" y="642" fill="black"> '17'
					<text x="6" y="515" fill="black"> '18'
					<text x="24" y="388" fill="black"> '19'
					<text x="73" y="266" fill="black"> '20'
					<text x="153" y="163" fill="black"> '21'
					<text x="254" y="86" fill="black"> '22'
					<text x="370" y="38" fill="black"> '23'
