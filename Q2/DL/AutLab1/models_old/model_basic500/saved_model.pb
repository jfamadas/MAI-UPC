??
?$?#
9
Add
x"T
y"T
z"T"
Ttype:
2	
?
	ApplyAdam
var"T?	
m"T?	
v"T?
beta1_power"T
beta2_power"T
lr"T

beta1"T

beta2"T
epsilon"T	
grad"T
out"T?"
Ttype:
2	"
use_lockingbool( 
l
ArgMax

input"T
	dimension"Tidx

output	"
Ttype:
2	"
Tidxtype0:
2	
x
Assign
ref"T?

value"T

output_ref"T?"	
Ttype"
validate_shapebool("
use_lockingbool(?
R
BroadcastGradientArgs
s0"T
s1"T
r0"T
r1"T"
Ttype0:
2	
8
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
?
Conv2D

input"T
filter"T
output"T"
Ttype:
2"
strides	list(int)"
use_cudnn_on_gpubool(""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW
?
Conv2DBackpropFilter

input"T
filter_sizes
out_backprop"T
output"T"
Ttype:
2"
strides	list(int)"
use_cudnn_on_gpubool(""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW
?
Conv2DBackpropInput
input_sizes
filter"T
out_backprop"T
output"T"
Ttype:
2"
strides	list(int)"
use_cudnn_on_gpubool(""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW
A
Equal
x"T
y"T
z
"
Ttype:
2	
?
W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
4
Fill
dims

value"T
output"T"	
Ttype
>
FloorDiv
x"T
y"T
z"T"
Ttype:
2	
.
Identity

input"T
output"T"	
Ttype
o
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2
?
MaxPool

input"T
output"T"
Ttype0:
2"
ksize	list(int)(0"
strides	list(int)(0""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW
?
MaxPoolGrad

orig_input"T
orig_output"T	
grad"T
output"T"
ksize	list(int)(0"
strides	list(int)(0""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW"
Ttype0:
2
:
Maximum
x"T
y"T
z"T"
Ttype:	
2	?
?
Mean

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( "
Ttype:
2	"
Tidxtype0:
2	
b
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(
<
Mul
x"T
y"T
z"T"
Ttype:
2	?

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
A
Placeholder
output"dtype"
dtypetype"
shapeshape: 
?
Prod

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( "
Ttype:
2	"
Tidxtype0:
2	
=
RealDiv
x"T
y"T
z"T"
Ttype:
2	
A
Relu
features"T
activations"T"
Ttype:
2		
S
ReluGrad
	gradients"T
features"T
	backprops"T"
Ttype:
2		
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
l
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
i
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
a
Slice

input"T
begin"Index
size"Index
output"T"	
Ttype"
Indextype:
2	
i
SoftmaxCrossEntropyWithLogits
features"T
labels"T	
loss"T
backprop"T"
Ttype:
2
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
5
Sub
x"T
y"T
z"T"
Ttype:
	2	
?
Sum

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( "
Ttype:
2	"
Tidxtype0:
2	
c
Tile

input"T
	multiples"
Tmultiples
output"T"	
Ttype"

Tmultiplestype0:
2	

TruncatedNormal

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	?
s

VariableV2
ref"dtype?"
shapeshape"
dtypetype"
	containerstring "
shared_namestring ?
&
	ZerosLike
x"T
y"T"	
Ttype"t"r"a"i"n"i"n"g*1.1.02
b'unknown'??
[
xPlaceholder*
dtype0*
shape: */
_output_shapes
:?????????  
X
y_realPlaceholder*
dtype0*
shape: *'
_output_shapes
:?????????

o
truncated_normal/shapeConst*%
valueB"             *
dtype0*
_output_shapes
:
Z
truncated_normal/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
\
truncated_normal/stddevConst*
valueB
 *???=*
dtype0*
_output_shapes
: 
?
 truncated_normal/TruncatedNormalTruncatedNormaltruncated_normal/shape*

seed *
seed2 *
dtype0*
T0*&
_output_shapes
: 
?
truncated_normal/mulMul truncated_normal/TruncatedNormaltruncated_normal/stddev*
T0*&
_output_shapes
: 
u
truncated_normalAddtruncated_normal/multruncated_normal/mean*
T0*&
_output_shapes
: 
?
W_conv1
VariableV2*
shape: *
dtype0*
	container *
shared_name *&
_output_shapes
: 
?
W_conv1/AssignAssignW_conv1truncated_normal*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
n
W_conv1/readIdentityW_conv1*
T0*
_class
loc:@W_conv1*&
_output_shapes
: 
R
ConstConst*
valueB *???=*
dtype0*
_output_shapes
: 
s
b_conv1
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_output_shapes
: 
?
b_conv1/AssignAssignb_conv1Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
b
b_conv1/readIdentityb_conv1*
T0*
_class
loc:@b_conv1*
_output_shapes
: 
?
conv2dConv2DxW_conv1/read*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*/
_output_shapes
:?????????   
Z
addAddconv2db_conv1/read*
T0*/
_output_shapes
:?????????   
N
h_conv1Reluadd*
T0*/
_output_shapes
:?????????   
?
h_pool1MaxPoolh_conv1*
T0*
ksize
*
strides
*
paddingSAME*
data_formatNHWC*/
_output_shapes
:????????? 
q
truncated_normal_1/shapeConst*%
valueB"          @   *
dtype0*
_output_shapes
:
\
truncated_normal_1/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
^
truncated_normal_1/stddevConst*
valueB
 *???=*
dtype0*
_output_shapes
: 
?
"truncated_normal_1/TruncatedNormalTruncatedNormaltruncated_normal_1/shape*

seed *
seed2 *
dtype0*
T0*&
_output_shapes
: @
?
truncated_normal_1/mulMul"truncated_normal_1/TruncatedNormaltruncated_normal_1/stddev*
T0*&
_output_shapes
: @
{
truncated_normal_1Addtruncated_normal_1/multruncated_normal_1/mean*
T0*&
_output_shapes
: @
?
W_conv2
VariableV2*
shape: @*
dtype0*
	container *
shared_name *&
_output_shapes
: @
?
W_conv2/AssignAssignW_conv2truncated_normal_1*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
n
W_conv2/readIdentityW_conv2*
T0*
_class
loc:@W_conv2*&
_output_shapes
: @
T
Const_1Const*
valueB@*???=*
dtype0*
_output_shapes
:@
s
b_conv2
VariableV2*
shape:@*
dtype0*
	container *
shared_name *
_output_shapes
:@
?
b_conv2/AssignAssignb_conv2Const_1*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
b
b_conv2/readIdentityb_conv2*
T0*
_class
loc:@b_conv2*
_output_shapes
:@
?
conv2d_1Conv2Dh_pool1W_conv2/read*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*/
_output_shapes
:?????????@
^
add_1Addconv2d_1b_conv2/read*
T0*/
_output_shapes
:?????????@
P
h_conv2Reluadd_1*
T0*/
_output_shapes
:?????????@
?
h_pool2MaxPoolh_conv2*
T0*
ksize
*
strides
*
paddingSAME*
data_formatNHWC*/
_output_shapes
:?????????@
i
truncated_normal_2/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
\
truncated_normal_2/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
^
truncated_normal_2/stddevConst*
valueB
 *???=*
dtype0*
_output_shapes
: 
?
"truncated_normal_2/TruncatedNormalTruncatedNormaltruncated_normal_2/shape*

seed *
seed2 *
dtype0*
T0* 
_output_shapes
:
? ?
?
truncated_normal_2/mulMul"truncated_normal_2/TruncatedNormaltruncated_normal_2/stddev*
T0* 
_output_shapes
:
? ?
u
truncated_normal_2Addtruncated_normal_2/multruncated_normal_2/mean*
T0* 
_output_shapes
:
? ?
}
W_fc1
VariableV2*
shape:
? ?*
dtype0*
	container *
shared_name * 
_output_shapes
:
? ?
?
W_fc1/AssignAssignW_fc1truncated_normal_2*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
b

W_fc1/readIdentityW_fc1*
T0*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
V
Const_2Const*
valueB?*???=*
dtype0*
_output_shapes	
:?
s
b_fc1
VariableV2*
shape:?*
dtype0*
	container *
shared_name *
_output_shapes	
:?
?
b_fc1/AssignAssignb_fc1Const_2*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
]

b_fc1/readIdentityb_fc1*
T0*
_class

loc:@b_fc1*
_output_shapes	
:?
f
h_pool2_reshape/shapeConst*
valueB"????   *
dtype0*
_output_shapes
:
{
h_pool2_reshapeReshapeh_pool2h_pool2_reshape/shape*
T0*
Tshape0*(
_output_shapes
:?????????? 
?
MatMulMatMulh_pool2_reshape
W_fc1/read*
transpose_a( *
transpose_b( *
T0*(
_output_shapes
:??????????
S
add_2AddMatMul
b_fc1/read*
T0*(
_output_shapes
:??????????
G
h_fc1Reluadd_2*
T0*(
_output_shapes
:??????????
i
truncated_normal_3/shapeConst*
valueB"   
   *
dtype0*
_output_shapes
:
\
truncated_normal_3/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
^
truncated_normal_3/stddevConst*
valueB
 *???=*
dtype0*
_output_shapes
: 
?
"truncated_normal_3/TruncatedNormalTruncatedNormaltruncated_normal_3/shape*

seed *
seed2 *
dtype0*
T0*
_output_shapes
:	?

?
truncated_normal_3/mulMul"truncated_normal_3/TruncatedNormaltruncated_normal_3/stddev*
T0*
_output_shapes
:	?

t
truncated_normal_3Addtruncated_normal_3/multruncated_normal_3/mean*
T0*
_output_shapes
:	?

{
W_fc2
VariableV2*
shape:	?
*
dtype0*
	container *
shared_name *
_output_shapes
:	?

?
W_fc2/AssignAssignW_fc2truncated_normal_3*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

a

W_fc2/readIdentityW_fc2*
T0*
_class

loc:@W_fc2*
_output_shapes
:	?

T
Const_3Const*
valueB
*???=*
dtype0*
_output_shapes
:

q
b_fc2
VariableV2*
shape:
*
dtype0*
	container *
shared_name *
_output_shapes
:

?
b_fc2/AssignAssignb_fc2Const_3*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

\

b_fc2/readIdentityb_fc2*
T0*
_class

loc:@b_fc2*
_output_shapes
:

}
MatMul_1MatMulh_fc1
W_fc2/read*
transpose_a( *
transpose_b( *
T0*'
_output_shapes
:?????????

]
labels_predictAddMatMul_1
b_fc2/read*
T0*'
_output_shapes
:?????????

F
RankConst*
value	B :*
dtype0*
_output_shapes
: 
S
ShapeShapelabels_predict*
T0*
out_type0*
_output_shapes
:
H
Rank_1Const*
value	B :*
dtype0*
_output_shapes
: 
U
Shape_1Shapelabels_predict*
T0*
out_type0*
_output_shapes
:
G
Sub/yConst*
value	B :*
dtype0*
_output_shapes
: 
:
SubSubRank_1Sub/y*
T0*
_output_shapes
: 
R
Slice/beginPackSub*
N*
T0*

axis *
_output_shapes
:
T

Slice/sizeConst*
valueB:*
dtype0*
_output_shapes
:
b
SliceSliceShape_1Slice/begin
Slice/size*
T0*
Index0*
_output_shapes
:
b
concat/values_0Const*
valueB:
?????????*
dtype0*
_output_shapes
:
M
concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
q
concatConcatV2concat/values_0Sliceconcat/axis*
N*
T0*

Tidx0*
_output_shapes
:
s
ReshapeReshapelabels_predictconcat*
T0*
Tshape0*0
_output_shapes
:??????????????????
H
Rank_2Const*
value	B :*
dtype0*
_output_shapes
: 
M
Shape_2Shapey_real*
T0*
out_type0*
_output_shapes
:
I
Sub_1/yConst*
value	B :*
dtype0*
_output_shapes
: 
>
Sub_1SubRank_2Sub_1/y*
T0*
_output_shapes
: 
V
Slice_1/beginPackSub_1*
N*
T0*

axis *
_output_shapes
:
V
Slice_1/sizeConst*
valueB:*
dtype0*
_output_shapes
:
h
Slice_1SliceShape_2Slice_1/beginSlice_1/size*
T0*
Index0*
_output_shapes
:
d
concat_1/values_0Const*
valueB:
?????????*
dtype0*
_output_shapes
:
O
concat_1/axisConst*
value	B : *
dtype0*
_output_shapes
: 
y
concat_1ConcatV2concat_1/values_0Slice_1concat_1/axis*
N*
T0*

Tidx0*
_output_shapes
:
o
	Reshape_1Reshapey_realconcat_1*
T0*
Tshape0*0
_output_shapes
:??????????????????
?
SoftmaxCrossEntropyWithLogitsSoftmaxCrossEntropyWithLogitsReshape	Reshape_1*
T0*?
_output_shapes-
+:?????????:??????????????????
I
Sub_2/yConst*
value	B :*
dtype0*
_output_shapes
: 
<
Sub_2SubRankSub_2/y*
T0*
_output_shapes
: 
W
Slice_2/beginConst*
valueB: *
dtype0*
_output_shapes
:
U
Slice_2/sizePackSub_2*
N*
T0*

axis *
_output_shapes
:
o
Slice_2SliceShapeSlice_2/beginSlice_2/size*
T0*
Index0*#
_output_shapes
:?????????
x
	Reshape_2ReshapeSoftmaxCrossEntropyWithLogitsSlice_2*
T0*
Tshape0*#
_output_shapes
:?????????
Q
Const_4Const*
valueB: *
dtype0*
_output_shapes
:
[
JMean	Reshape_2Const_4*
	keep_dims( *
T0*

Tidx0*
_output_shapes
: 
R
gradients/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
T
gradients/ConstConst*
valueB
 *  ??*
dtype0*
_output_shapes
: 
Y
gradients/FillFillgradients/Shapegradients/Const*
T0*
_output_shapes
: 
h
gradients/J_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
?
gradients/J_grad/ReshapeReshapegradients/Fillgradients/J_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
_
gradients/J_grad/ShapeShape	Reshape_2*
T0*
out_type0*
_output_shapes
:
?
gradients/J_grad/TileTilegradients/J_grad/Reshapegradients/J_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:?????????
a
gradients/J_grad/Shape_1Shape	Reshape_2*
T0*
out_type0*
_output_shapes
:
[
gradients/J_grad/Shape_2Const*
valueB *
dtype0*
_output_shapes
: 
`
gradients/J_grad/ConstConst*
valueB: *
dtype0*
_output_shapes
:
?
gradients/J_grad/ProdProdgradients/J_grad/Shape_1gradients/J_grad/Const*
	keep_dims( *
T0*

Tidx0*
_output_shapes
: 
b
gradients/J_grad/Const_1Const*
valueB: *
dtype0*
_output_shapes
:
?
gradients/J_grad/Prod_1Prodgradients/J_grad/Shape_2gradients/J_grad/Const_1*
	keep_dims( *
T0*

Tidx0*
_output_shapes
: 
\
gradients/J_grad/Maximum/yConst*
value	B :*
dtype0*
_output_shapes
: 
y
gradients/J_grad/MaximumMaximumgradients/J_grad/Prod_1gradients/J_grad/Maximum/y*
T0*
_output_shapes
: 
w
gradients/J_grad/floordivFloorDivgradients/J_grad/Prodgradients/J_grad/Maximum*
T0*
_output_shapes
: 
h
gradients/J_grad/CastCastgradients/J_grad/floordiv*

SrcT0*

DstT0*
_output_shapes
: 

gradients/J_grad/truedivRealDivgradients/J_grad/Tilegradients/J_grad/Cast*
T0*#
_output_shapes
:?????????
{
gradients/Reshape_2_grad/ShapeShapeSoftmaxCrossEntropyWithLogits*
T0*
out_type0*
_output_shapes
:
?
 gradients/Reshape_2_grad/ReshapeReshapegradients/J_grad/truedivgradients/Reshape_2_grad/Shape*
T0*
Tshape0*#
_output_shapes
:?????????
}
gradients/zeros_like	ZerosLikeSoftmaxCrossEntropyWithLogits:1*
T0*0
_output_shapes
:??????????????????
?
;gradients/SoftmaxCrossEntropyWithLogits_grad/ExpandDims/dimConst*
valueB :
?????????*
dtype0*
_output_shapes
: 
?
7gradients/SoftmaxCrossEntropyWithLogits_grad/ExpandDims
ExpandDims gradients/Reshape_2_grad/Reshape;gradients/SoftmaxCrossEntropyWithLogits_grad/ExpandDims/dim*
T0*

Tdim0*'
_output_shapes
:?????????
?
0gradients/SoftmaxCrossEntropyWithLogits_grad/mulMul7gradients/SoftmaxCrossEntropyWithLogits_grad/ExpandDimsSoftmaxCrossEntropyWithLogits:1*
T0*0
_output_shapes
:??????????????????
j
gradients/Reshape_grad/ShapeShapelabels_predict*
T0*
out_type0*
_output_shapes
:
?
gradients/Reshape_grad/ReshapeReshape0gradients/SoftmaxCrossEntropyWithLogits_grad/mulgradients/Reshape_grad/Shape*
T0*
Tshape0*'
_output_shapes
:?????????

k
#gradients/labels_predict_grad/ShapeShapeMatMul_1*
T0*
out_type0*
_output_shapes
:
o
%gradients/labels_predict_grad/Shape_1Const*
valueB:
*
dtype0*
_output_shapes
:
?
3gradients/labels_predict_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients/labels_predict_grad/Shape%gradients/labels_predict_grad/Shape_1*
T0*2
_output_shapes 
:?????????:?????????
?
!gradients/labels_predict_grad/SumSumgradients/Reshape_grad/Reshape3gradients/labels_predict_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
%gradients/labels_predict_grad/ReshapeReshape!gradients/labels_predict_grad/Sum#gradients/labels_predict_grad/Shape*
T0*
Tshape0*'
_output_shapes
:?????????

?
#gradients/labels_predict_grad/Sum_1Sumgradients/Reshape_grad/Reshape5gradients/labels_predict_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
'gradients/labels_predict_grad/Reshape_1Reshape#gradients/labels_predict_grad/Sum_1%gradients/labels_predict_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:

?
.gradients/labels_predict_grad/tuple/group_depsNoOp&^gradients/labels_predict_grad/Reshape(^gradients/labels_predict_grad/Reshape_1
?
6gradients/labels_predict_grad/tuple/control_dependencyIdentity%gradients/labels_predict_grad/Reshape/^gradients/labels_predict_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/labels_predict_grad/Reshape*'
_output_shapes
:?????????

?
8gradients/labels_predict_grad/tuple/control_dependency_1Identity'gradients/labels_predict_grad/Reshape_1/^gradients/labels_predict_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/labels_predict_grad/Reshape_1*
_output_shapes
:

?
gradients/MatMul_1_grad/MatMulMatMul6gradients/labels_predict_grad/tuple/control_dependency
W_fc2/read*
transpose_a( *
transpose_b(*
T0*(
_output_shapes
:??????????
?
 gradients/MatMul_1_grad/MatMul_1MatMulh_fc16gradients/labels_predict_grad/tuple/control_dependency*
transpose_a(*
transpose_b( *
T0*
_output_shapes
:	?

t
(gradients/MatMul_1_grad/tuple/group_depsNoOp^gradients/MatMul_1_grad/MatMul!^gradients/MatMul_1_grad/MatMul_1
?
0gradients/MatMul_1_grad/tuple/control_dependencyIdentitygradients/MatMul_1_grad/MatMul)^gradients/MatMul_1_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/MatMul_1_grad/MatMul*(
_output_shapes
:??????????
?
2gradients/MatMul_1_grad/tuple/control_dependency_1Identity gradients/MatMul_1_grad/MatMul_1)^gradients/MatMul_1_grad/tuple/group_deps*
T0*3
_class)
'%loc:@gradients/MatMul_1_grad/MatMul_1*
_output_shapes
:	?

?
gradients/h_fc1_grad/ReluGradReluGrad0gradients/MatMul_1_grad/tuple/control_dependencyh_fc1*
T0*(
_output_shapes
:??????????
`
gradients/add_2_grad/ShapeShapeMatMul*
T0*
out_type0*
_output_shapes
:
g
gradients/add_2_grad/Shape_1Const*
valueB:?*
dtype0*
_output_shapes
:
?
*gradients/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/add_2_grad/Shapegradients/add_2_grad/Shape_1*
T0*2
_output_shapes 
:?????????:?????????
?
gradients/add_2_grad/SumSumgradients/h_fc1_grad/ReluGrad*gradients/add_2_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_2_grad/ReshapeReshapegradients/add_2_grad/Sumgradients/add_2_grad/Shape*
T0*
Tshape0*(
_output_shapes
:??????????
?
gradients/add_2_grad/Sum_1Sumgradients/h_fc1_grad/ReluGrad,gradients/add_2_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_2_grad/Reshape_1Reshapegradients/add_2_grad/Sum_1gradients/add_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes	
:?
m
%gradients/add_2_grad/tuple/group_depsNoOp^gradients/add_2_grad/Reshape^gradients/add_2_grad/Reshape_1
?
-gradients/add_2_grad/tuple/control_dependencyIdentitygradients/add_2_grad/Reshape&^gradients/add_2_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/add_2_grad/Reshape*(
_output_shapes
:??????????
?
/gradients/add_2_grad/tuple/control_dependency_1Identitygradients/add_2_grad/Reshape_1&^gradients/add_2_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/add_2_grad/Reshape_1*
_output_shapes	
:?
?
gradients/MatMul_grad/MatMulMatMul-gradients/add_2_grad/tuple/control_dependency
W_fc1/read*
transpose_a( *
transpose_b(*
T0*(
_output_shapes
:?????????? 
?
gradients/MatMul_grad/MatMul_1MatMulh_pool2_reshape-gradients/add_2_grad/tuple/control_dependency*
transpose_a(*
transpose_b( *
T0* 
_output_shapes
:
? ?
n
&gradients/MatMul_grad/tuple/group_depsNoOp^gradients/MatMul_grad/MatMul^gradients/MatMul_grad/MatMul_1
?
.gradients/MatMul_grad/tuple/control_dependencyIdentitygradients/MatMul_grad/MatMul'^gradients/MatMul_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/MatMul_grad/MatMul*(
_output_shapes
:?????????? 
?
0gradients/MatMul_grad/tuple/control_dependency_1Identitygradients/MatMul_grad/MatMul_1'^gradients/MatMul_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/MatMul_grad/MatMul_1* 
_output_shapes
:
? ?
k
$gradients/h_pool2_reshape_grad/ShapeShapeh_pool2*
T0*
out_type0*
_output_shapes
:
?
&gradients/h_pool2_reshape_grad/ReshapeReshape.gradients/MatMul_grad/tuple/control_dependency$gradients/h_pool2_reshape_grad/Shape*
T0*
Tshape0*/
_output_shapes
:?????????@
?
"gradients/h_pool2_grad/MaxPoolGradMaxPoolGradh_conv2h_pool2&gradients/h_pool2_reshape_grad/Reshape*
ksize
*
strides
*
paddingSAME*
data_formatNHWC*
T0*/
_output_shapes
:?????????@
?
gradients/h_conv2_grad/ReluGradReluGrad"gradients/h_pool2_grad/MaxPoolGradh_conv2*
T0*/
_output_shapes
:?????????@
b
gradients/add_1_grad/ShapeShapeconv2d_1*
T0*
out_type0*
_output_shapes
:
f
gradients/add_1_grad/Shape_1Const*
valueB:@*
dtype0*
_output_shapes
:
?
*gradients/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/add_1_grad/Shapegradients/add_1_grad/Shape_1*
T0*2
_output_shapes 
:?????????:?????????
?
gradients/add_1_grad/SumSumgradients/h_conv2_grad/ReluGrad*gradients/add_1_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_1_grad/ReshapeReshapegradients/add_1_grad/Sumgradients/add_1_grad/Shape*
T0*
Tshape0*/
_output_shapes
:?????????@
?
gradients/add_1_grad/Sum_1Sumgradients/h_conv2_grad/ReluGrad,gradients/add_1_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_1_grad/Reshape_1Reshapegradients/add_1_grad/Sum_1gradients/add_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:@
m
%gradients/add_1_grad/tuple/group_depsNoOp^gradients/add_1_grad/Reshape^gradients/add_1_grad/Reshape_1
?
-gradients/add_1_grad/tuple/control_dependencyIdentitygradients/add_1_grad/Reshape&^gradients/add_1_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/add_1_grad/Reshape*/
_output_shapes
:?????????@
?
/gradients/add_1_grad/tuple/control_dependency_1Identitygradients/add_1_grad/Reshape_1&^gradients/add_1_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/add_1_grad/Reshape_1*
_output_shapes
:@
d
gradients/conv2d_1_grad/ShapeShapeh_pool1*
T0*
out_type0*
_output_shapes
:
?
+gradients/conv2d_1_grad/Conv2DBackpropInputConv2DBackpropInputgradients/conv2d_1_grad/ShapeW_conv2/read-gradients/add_1_grad/tuple/control_dependency*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*J
_output_shapes8
6:4????????????????????????????????????
x
gradients/conv2d_1_grad/Shape_1Const*%
valueB"          @   *
dtype0*
_output_shapes
:
?
,gradients/conv2d_1_grad/Conv2DBackpropFilterConv2DBackpropFilterh_pool1gradients/conv2d_1_grad/Shape_1-gradients/add_1_grad/tuple/control_dependency*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*&
_output_shapes
: @
?
(gradients/conv2d_1_grad/tuple/group_depsNoOp,^gradients/conv2d_1_grad/Conv2DBackpropInput-^gradients/conv2d_1_grad/Conv2DBackpropFilter
?
0gradients/conv2d_1_grad/tuple/control_dependencyIdentity+gradients/conv2d_1_grad/Conv2DBackpropInput)^gradients/conv2d_1_grad/tuple/group_deps*
T0*>
_class4
20loc:@gradients/conv2d_1_grad/Conv2DBackpropInput*/
_output_shapes
:????????? 
?
2gradients/conv2d_1_grad/tuple/control_dependency_1Identity,gradients/conv2d_1_grad/Conv2DBackpropFilter)^gradients/conv2d_1_grad/tuple/group_deps*
T0*?
_class5
31loc:@gradients/conv2d_1_grad/Conv2DBackpropFilter*&
_output_shapes
: @
?
"gradients/h_pool1_grad/MaxPoolGradMaxPoolGradh_conv1h_pool10gradients/conv2d_1_grad/tuple/control_dependency*
ksize
*
strides
*
paddingSAME*
data_formatNHWC*
T0*/
_output_shapes
:?????????   
?
gradients/h_conv1_grad/ReluGradReluGrad"gradients/h_pool1_grad/MaxPoolGradh_conv1*
T0*/
_output_shapes
:?????????   
^
gradients/add_grad/ShapeShapeconv2d*
T0*
out_type0*
_output_shapes
:
d
gradients/add_grad/Shape_1Const*
valueB: *
dtype0*
_output_shapes
:
?
(gradients/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/add_grad/Shapegradients/add_grad/Shape_1*
T0*2
_output_shapes 
:?????????:?????????
?
gradients/add_grad/SumSumgradients/h_conv1_grad/ReluGrad(gradients/add_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_grad/ReshapeReshapegradients/add_grad/Sumgradients/add_grad/Shape*
T0*
Tshape0*/
_output_shapes
:?????????   
?
gradients/add_grad/Sum_1Sumgradients/h_conv1_grad/ReluGrad*gradients/add_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_grad/Reshape_1Reshapegradients/add_grad/Sum_1gradients/add_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
g
#gradients/add_grad/tuple/group_depsNoOp^gradients/add_grad/Reshape^gradients/add_grad/Reshape_1
?
+gradients/add_grad/tuple/control_dependencyIdentitygradients/add_grad/Reshape$^gradients/add_grad/tuple/group_deps*
T0*-
_class#
!loc:@gradients/add_grad/Reshape*/
_output_shapes
:?????????   
?
-gradients/add_grad/tuple/control_dependency_1Identitygradients/add_grad/Reshape_1$^gradients/add_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/add_grad/Reshape_1*
_output_shapes
: 
\
gradients/conv2d_grad/ShapeShapex*
T0*
out_type0*
_output_shapes
:
?
)gradients/conv2d_grad/Conv2DBackpropInputConv2DBackpropInputgradients/conv2d_grad/ShapeW_conv1/read+gradients/add_grad/tuple/control_dependency*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*J
_output_shapes8
6:4????????????????????????????????????
v
gradients/conv2d_grad/Shape_1Const*%
valueB"             *
dtype0*
_output_shapes
:
?
*gradients/conv2d_grad/Conv2DBackpropFilterConv2DBackpropFilterxgradients/conv2d_grad/Shape_1+gradients/add_grad/tuple/control_dependency*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*&
_output_shapes
: 
?
&gradients/conv2d_grad/tuple/group_depsNoOp*^gradients/conv2d_grad/Conv2DBackpropInput+^gradients/conv2d_grad/Conv2DBackpropFilter
?
.gradients/conv2d_grad/tuple/control_dependencyIdentity)gradients/conv2d_grad/Conv2DBackpropInput'^gradients/conv2d_grad/tuple/group_deps*
T0*<
_class2
0.loc:@gradients/conv2d_grad/Conv2DBackpropInput*/
_output_shapes
:?????????  
?
0gradients/conv2d_grad/tuple/control_dependency_1Identity*gradients/conv2d_grad/Conv2DBackpropFilter'^gradients/conv2d_grad/tuple/group_deps*
T0*=
_class3
1/loc:@gradients/conv2d_grad/Conv2DBackpropFilter*&
_output_shapes
: 
z
beta1_power/initial_valueConst*
valueB
 *fff?*
dtype0*
_class
loc:@W_conv1*
_output_shapes
: 
?
beta1_power
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@W_conv1*
_output_shapes
: 
?
beta1_power/AssignAssignbeta1_powerbeta1_power/initial_value*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*
_output_shapes
: 
f
beta1_power/readIdentitybeta1_power*
T0*
_class
loc:@W_conv1*
_output_shapes
: 
z
beta2_power/initial_valueConst*
valueB
 *w??*
dtype0*
_class
loc:@W_conv1*
_output_shapes
: 
?
beta2_power
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@W_conv1*
_output_shapes
: 
?
beta2_power/AssignAssignbeta2_powerbeta2_power/initial_value*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*
_output_shapes
: 
f
beta2_power/readIdentitybeta2_power*
T0*
_class
loc:@W_conv1*
_output_shapes
: 
?
$W_conv1/train_step/Initializer/ConstConst*%
valueB *    *
dtype0*
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step/AssignAssignW_conv1/train_step$W_conv1/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step/readIdentityW_conv1/train_step*
T0*
_class
loc:@W_conv1*&
_output_shapes
: 
?
&W_conv1/train_step_1/Initializer/ConstConst*%
valueB *    *
dtype0*
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step_1
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step_1/AssignAssignW_conv1/train_step_1&W_conv1/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step_1/readIdentityW_conv1/train_step_1*
T0*
_class
loc:@W_conv1*&
_output_shapes
: 
?
$b_conv1/train_step/Initializer/ConstConst*
valueB *    *
dtype0*
_class
loc:@b_conv1*
_output_shapes
: 
?
b_conv1/train_step
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@b_conv1*
_output_shapes
: 
?
b_conv1/train_step/AssignAssignb_conv1/train_step$b_conv1/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
x
b_conv1/train_step/readIdentityb_conv1/train_step*
T0*
_class
loc:@b_conv1*
_output_shapes
: 
?
&b_conv1/train_step_1/Initializer/ConstConst*
valueB *    *
dtype0*
_class
loc:@b_conv1*
_output_shapes
: 
?
b_conv1/train_step_1
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@b_conv1*
_output_shapes
: 
?
b_conv1/train_step_1/AssignAssignb_conv1/train_step_1&b_conv1/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
|
b_conv1/train_step_1/readIdentityb_conv1/train_step_1*
T0*
_class
loc:@b_conv1*
_output_shapes
: 
?
$W_conv2/train_step/Initializer/ConstConst*%
valueB @*    *
dtype0*
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step
VariableV2*
shape: @*
dtype0*
	container *
shared_name *
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step/AssignAssignW_conv2/train_step$W_conv2/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step/readIdentityW_conv2/train_step*
T0*
_class
loc:@W_conv2*&
_output_shapes
: @
?
&W_conv2/train_step_1/Initializer/ConstConst*%
valueB @*    *
dtype0*
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step_1
VariableV2*
shape: @*
dtype0*
	container *
shared_name *
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step_1/AssignAssignW_conv2/train_step_1&W_conv2/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step_1/readIdentityW_conv2/train_step_1*
T0*
_class
loc:@W_conv2*&
_output_shapes
: @
?
$b_conv2/train_step/Initializer/ConstConst*
valueB@*    *
dtype0*
_class
loc:@b_conv2*
_output_shapes
:@
?
b_conv2/train_step
VariableV2*
shape:@*
dtype0*
	container *
shared_name *
_class
loc:@b_conv2*
_output_shapes
:@
?
b_conv2/train_step/AssignAssignb_conv2/train_step$b_conv2/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
x
b_conv2/train_step/readIdentityb_conv2/train_step*
T0*
_class
loc:@b_conv2*
_output_shapes
:@
?
&b_conv2/train_step_1/Initializer/ConstConst*
valueB@*    *
dtype0*
_class
loc:@b_conv2*
_output_shapes
:@
?
b_conv2/train_step_1
VariableV2*
shape:@*
dtype0*
	container *
shared_name *
_class
loc:@b_conv2*
_output_shapes
:@
?
b_conv2/train_step_1/AssignAssignb_conv2/train_step_1&b_conv2/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
|
b_conv2/train_step_1/readIdentityb_conv2/train_step_1*
T0*
_class
loc:@b_conv2*
_output_shapes
:@
?
"W_fc1/train_step/Initializer/ConstConst*
valueB
? ?*    *
dtype0*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
W_fc1/train_step
VariableV2*
shape:
? ?*
dtype0*
	container *
shared_name *
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
W_fc1/train_step/AssignAssignW_fc1/train_step"W_fc1/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
x
W_fc1/train_step/readIdentityW_fc1/train_step*
T0*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
$W_fc1/train_step_1/Initializer/ConstConst*
valueB
? ?*    *
dtype0*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
W_fc1/train_step_1
VariableV2*
shape:
? ?*
dtype0*
	container *
shared_name *
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
W_fc1/train_step_1/AssignAssignW_fc1/train_step_1$W_fc1/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
|
W_fc1/train_step_1/readIdentityW_fc1/train_step_1*
T0*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
"b_fc1/train_step/Initializer/ConstConst*
valueB?*    *
dtype0*
_class

loc:@b_fc1*
_output_shapes	
:?
?
b_fc1/train_step
VariableV2*
shape:?*
dtype0*
	container *
shared_name *
_class

loc:@b_fc1*
_output_shapes	
:?
?
b_fc1/train_step/AssignAssignb_fc1/train_step"b_fc1/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
s
b_fc1/train_step/readIdentityb_fc1/train_step*
T0*
_class

loc:@b_fc1*
_output_shapes	
:?
?
$b_fc1/train_step_1/Initializer/ConstConst*
valueB?*    *
dtype0*
_class

loc:@b_fc1*
_output_shapes	
:?
?
b_fc1/train_step_1
VariableV2*
shape:?*
dtype0*
	container *
shared_name *
_class

loc:@b_fc1*
_output_shapes	
:?
?
b_fc1/train_step_1/AssignAssignb_fc1/train_step_1$b_fc1/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
w
b_fc1/train_step_1/readIdentityb_fc1/train_step_1*
T0*
_class

loc:@b_fc1*
_output_shapes	
:?
?
"W_fc2/train_step/Initializer/ConstConst*
valueB	?
*    *
dtype0*
_class

loc:@W_fc2*
_output_shapes
:	?

?
W_fc2/train_step
VariableV2*
shape:	?
*
dtype0*
	container *
shared_name *
_class

loc:@W_fc2*
_output_shapes
:	?

?
W_fc2/train_step/AssignAssignW_fc2/train_step"W_fc2/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

w
W_fc2/train_step/readIdentityW_fc2/train_step*
T0*
_class

loc:@W_fc2*
_output_shapes
:	?

?
$W_fc2/train_step_1/Initializer/ConstConst*
valueB	?
*    *
dtype0*
_class

loc:@W_fc2*
_output_shapes
:	?

?
W_fc2/train_step_1
VariableV2*
shape:	?
*
dtype0*
	container *
shared_name *
_class

loc:@W_fc2*
_output_shapes
:	?

?
W_fc2/train_step_1/AssignAssignW_fc2/train_step_1$W_fc2/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

{
W_fc2/train_step_1/readIdentityW_fc2/train_step_1*
T0*
_class

loc:@W_fc2*
_output_shapes
:	?

?
"b_fc2/train_step/Initializer/ConstConst*
valueB
*    *
dtype0*
_class

loc:@b_fc2*
_output_shapes
:

?
b_fc2/train_step
VariableV2*
shape:
*
dtype0*
	container *
shared_name *
_class

loc:@b_fc2*
_output_shapes
:

?
b_fc2/train_step/AssignAssignb_fc2/train_step"b_fc2/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

r
b_fc2/train_step/readIdentityb_fc2/train_step*
T0*
_class

loc:@b_fc2*
_output_shapes
:

?
$b_fc2/train_step_1/Initializer/ConstConst*
valueB
*    *
dtype0*
_class

loc:@b_fc2*
_output_shapes
:

?
b_fc2/train_step_1
VariableV2*
shape:
*
dtype0*
	container *
shared_name *
_class

loc:@b_fc2*
_output_shapes
:

?
b_fc2/train_step_1/AssignAssignb_fc2/train_step_1$b_fc2/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

v
b_fc2/train_step_1/readIdentityb_fc2/train_step_1*
T0*
_class

loc:@b_fc2*
_output_shapes
:

]
train_step/learning_rateConst*
valueB
 *??8*
dtype0*
_output_shapes
: 
U
train_step/beta1Const*
valueB
 *fff?*
dtype0*
_output_shapes
: 
U
train_step/beta2Const*
valueB
 *w??*
dtype0*
_output_shapes
: 
W
train_step/epsilonConst*
valueB
 *w?+2*
dtype0*
_output_shapes
: 
?
#train_step/update_W_conv1/ApplyAdam	ApplyAdamW_conv1W_conv1/train_stepW_conv1/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon0gradients/conv2d_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@W_conv1*&
_output_shapes
: 
?
#train_step/update_b_conv1/ApplyAdam	ApplyAdamb_conv1b_conv1/train_stepb_conv1/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon-gradients/add_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@b_conv1*
_output_shapes
: 
?
#train_step/update_W_conv2/ApplyAdam	ApplyAdamW_conv2W_conv2/train_stepW_conv2/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon2gradients/conv2d_1_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@W_conv2*&
_output_shapes
: @
?
#train_step/update_b_conv2/ApplyAdam	ApplyAdamb_conv2b_conv2/train_stepb_conv2/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon/gradients/add_1_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@b_conv2*
_output_shapes
:@
?
!train_step/update_W_fc1/ApplyAdam	ApplyAdamW_fc1W_fc1/train_stepW_fc1/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon0gradients/MatMul_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
!train_step/update_b_fc1/ApplyAdam	ApplyAdamb_fc1b_fc1/train_stepb_fc1/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon/gradients/add_2_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class

loc:@b_fc1*
_output_shapes	
:?
?
!train_step/update_W_fc2/ApplyAdam	ApplyAdamW_fc2W_fc2/train_stepW_fc2/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon2gradients/MatMul_1_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class

loc:@W_fc2*
_output_shapes
:	?

?
!train_step/update_b_fc2/ApplyAdam	ApplyAdamb_fc2b_fc2/train_stepb_fc2/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon8gradients/labels_predict_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class

loc:@b_fc2*
_output_shapes
:

?
train_step/mulMulbeta1_power/readtrain_step/beta1$^train_step/update_W_conv1/ApplyAdam$^train_step/update_b_conv1/ApplyAdam$^train_step/update_W_conv2/ApplyAdam$^train_step/update_b_conv2/ApplyAdam"^train_step/update_W_fc1/ApplyAdam"^train_step/update_b_fc1/ApplyAdam"^train_step/update_W_fc2/ApplyAdam"^train_step/update_b_fc2/ApplyAdam*
T0*
_class
loc:@W_conv1*
_output_shapes
: 
?
train_step/AssignAssignbeta1_powertrain_step/mul*
T0*
validate_shape(*
use_locking( *
_class
loc:@W_conv1*
_output_shapes
: 
?
train_step/mul_1Mulbeta2_power/readtrain_step/beta2$^train_step/update_W_conv1/ApplyAdam$^train_step/update_b_conv1/ApplyAdam$^train_step/update_W_conv2/ApplyAdam$^train_step/update_b_conv2/ApplyAdam"^train_step/update_W_fc1/ApplyAdam"^train_step/update_b_fc1/ApplyAdam"^train_step/update_W_fc2/ApplyAdam"^train_step/update_b_fc2/ApplyAdam*
T0*
_class
loc:@W_conv1*
_output_shapes
: 
?
train_step/Assign_1Assignbeta2_powertrain_step/mul_1*
T0*
validate_shape(*
use_locking( *
_class
loc:@W_conv1*
_output_shapes
: 
?

train_stepNoOp$^train_step/update_W_conv1/ApplyAdam$^train_step/update_b_conv1/ApplyAdam$^train_step/update_W_conv2/ApplyAdam$^train_step/update_b_conv2/ApplyAdam"^train_step/update_W_fc1/ApplyAdam"^train_step/update_b_fc1/ApplyAdam"^train_step/update_W_fc2/ApplyAdam"^train_step/update_b_fc2/ApplyAdam^train_step/Assign^train_step/Assign_1
R
ArgMax/dimensionConst*
value	B :*
dtype0*
_output_shapes
: 
d
ArgMaxArgMaxy_realArgMax/dimension*
T0*

Tidx0*#
_output_shapes
:?????????
T
ArgMax_1/dimensionConst*
value	B :*
dtype0*
_output_shapes
: 
p
ArgMax_1ArgMaxlabels_predictArgMax_1/dimension*
T0*

Tidx0*#
_output_shapes
:?????????
[
correct_predictionEqualArgMaxArgMax_1*
T0	*#
_output_shapes
:?????????
_
Cast_1Castcorrect_prediction*

SrcT0
*

DstT0*#
_output_shapes
:?????????
Q
Const_5Const*
valueB: *
dtype0*
_output_shapes
:
_
accuracyMeanCast_1Const_5*
	keep_dims( *
T0*

Tidx0*
_output_shapes
: 
?
initNoOp^W_conv1/Assign^b_conv1/Assign^W_conv2/Assign^b_conv2/Assign^W_fc1/Assign^b_fc1/Assign^W_fc2/Assign^b_fc2/Assign^beta1_power/Assign^beta2_power/Assign^W_conv1/train_step/Assign^W_conv1/train_step_1/Assign^b_conv1/train_step/Assign^b_conv1/train_step_1/Assign^W_conv2/train_step/Assign^W_conv2/train_step_1/Assign^b_conv2/train_step/Assign^b_conv2/train_step_1/Assign^W_fc1/train_step/Assign^W_fc1/train_step_1/Assign^b_fc1/train_step/Assign^b_fc1/train_step_1/Assign^W_fc2/train_step/Assign^W_fc2/train_step_1/Assign^b_fc2/train_step/Assign^b_fc2/train_step_1/Assign
P

save/ConstConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
?
save/StringJoin/inputs_1Const*<
value3B1 B+_temp_cb228f924be244b4aef28c500093e969/part*
dtype0*
_output_shapes
: 
u
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
N*
	separator *
_output_shapes
: 
Q
save/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
\
save/ShardedFilename/shardConst*
value	B : *
dtype0*
_output_shapes
: 
}
save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards*
_output_shapes
: 
?
save/SaveV2/tensor_namesConst*?
value?B?BW_conv1BW_conv1/train_stepBW_conv1/train_step_1BW_conv2BW_conv2/train_stepBW_conv2/train_step_1BW_fc1BW_fc1/train_stepBW_fc1/train_step_1BW_fc2BW_fc2/train_stepBW_fc2/train_step_1Bb_conv1Bb_conv1/train_stepBb_conv1/train_step_1Bb_conv2Bb_conv2/train_stepBb_conv2/train_step_1Bb_fc1Bb_fc1/train_stepBb_fc1/train_step_1Bb_fc2Bb_fc2/train_stepBb_fc2/train_step_1Bbeta1_powerBbeta2_power*
dtype0*
_output_shapes
:
?
save/SaveV2/shape_and_slicesConst*G
value>B<B B B B B B B B B B B B B B B B B B B B B B B B B B *
dtype0*
_output_shapes
:
?
save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesW_conv1W_conv1/train_stepW_conv1/train_step_1W_conv2W_conv2/train_stepW_conv2/train_step_1W_fc1W_fc1/train_stepW_fc1/train_step_1W_fc2W_fc2/train_stepW_fc2/train_step_1b_conv1b_conv1/train_stepb_conv1/train_step_1b_conv2b_conv2/train_stepb_conv2/train_step_1b_fc1b_fc1/train_stepb_fc1/train_step_1b_fc2b_fc2/train_stepb_fc2/train_step_1beta1_powerbeta2_power*(
dtypes
2
?
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2*
T0*'
_class
loc:@save/ShardedFilename*
_output_shapes
: 
?
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency*
N*
T0*

axis *
_output_shapes
:
}
save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const*
delete_old_dirs(
z
save/IdentityIdentity
save/Const^save/control_dependency^save/MergeV2Checkpoints*
T0*
_output_shapes
: 
k
save/RestoreV2/tensor_namesConst*
valueBBW_conv1*
dtype0*
_output_shapes
:
h
save/RestoreV2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/AssignAssignW_conv1save/RestoreV2*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
x
save/RestoreV2_1/tensor_namesConst*'
valueBBW_conv1/train_step*
dtype0*
_output_shapes
:
j
!save/RestoreV2_1/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_1	RestoreV2
save/Constsave/RestoreV2_1/tensor_names!save/RestoreV2_1/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_1AssignW_conv1/train_stepsave/RestoreV2_1*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
z
save/RestoreV2_2/tensor_namesConst*)
value BBW_conv1/train_step_1*
dtype0*
_output_shapes
:
j
!save/RestoreV2_2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_2	RestoreV2
save/Constsave/RestoreV2_2/tensor_names!save/RestoreV2_2/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_2AssignW_conv1/train_step_1save/RestoreV2_2*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
m
save/RestoreV2_3/tensor_namesConst*
valueBBW_conv2*
dtype0*
_output_shapes
:
j
!save/RestoreV2_3/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_3	RestoreV2
save/Constsave/RestoreV2_3/tensor_names!save/RestoreV2_3/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_3AssignW_conv2save/RestoreV2_3*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
x
save/RestoreV2_4/tensor_namesConst*'
valueBBW_conv2/train_step*
dtype0*
_output_shapes
:
j
!save/RestoreV2_4/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_4	RestoreV2
save/Constsave/RestoreV2_4/tensor_names!save/RestoreV2_4/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_4AssignW_conv2/train_stepsave/RestoreV2_4*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
z
save/RestoreV2_5/tensor_namesConst*)
value BBW_conv2/train_step_1*
dtype0*
_output_shapes
:
j
!save/RestoreV2_5/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_5	RestoreV2
save/Constsave/RestoreV2_5/tensor_names!save/RestoreV2_5/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_5AssignW_conv2/train_step_1save/RestoreV2_5*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
k
save/RestoreV2_6/tensor_namesConst*
valueBBW_fc1*
dtype0*
_output_shapes
:
j
!save/RestoreV2_6/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_6	RestoreV2
save/Constsave/RestoreV2_6/tensor_names!save/RestoreV2_6/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_6AssignW_fc1save/RestoreV2_6*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
v
save/RestoreV2_7/tensor_namesConst*%
valueBBW_fc1/train_step*
dtype0*
_output_shapes
:
j
!save/RestoreV2_7/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_7	RestoreV2
save/Constsave/RestoreV2_7/tensor_names!save/RestoreV2_7/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_7AssignW_fc1/train_stepsave/RestoreV2_7*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
x
save/RestoreV2_8/tensor_namesConst*'
valueBBW_fc1/train_step_1*
dtype0*
_output_shapes
:
j
!save/RestoreV2_8/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_8	RestoreV2
save/Constsave/RestoreV2_8/tensor_names!save/RestoreV2_8/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_8AssignW_fc1/train_step_1save/RestoreV2_8*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
k
save/RestoreV2_9/tensor_namesConst*
valueBBW_fc2*
dtype0*
_output_shapes
:
j
!save/RestoreV2_9/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_9	RestoreV2
save/Constsave/RestoreV2_9/tensor_names!save/RestoreV2_9/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_9AssignW_fc2save/RestoreV2_9*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

w
save/RestoreV2_10/tensor_namesConst*%
valueBBW_fc2/train_step*
dtype0*
_output_shapes
:
k
"save/RestoreV2_10/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_10	RestoreV2
save/Constsave/RestoreV2_10/tensor_names"save/RestoreV2_10/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_10AssignW_fc2/train_stepsave/RestoreV2_10*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

y
save/RestoreV2_11/tensor_namesConst*'
valueBBW_fc2/train_step_1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_11/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_11	RestoreV2
save/Constsave/RestoreV2_11/tensor_names"save/RestoreV2_11/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_11AssignW_fc2/train_step_1save/RestoreV2_11*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

n
save/RestoreV2_12/tensor_namesConst*
valueBBb_conv1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_12/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_12	RestoreV2
save/Constsave/RestoreV2_12/tensor_names"save/RestoreV2_12/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_12Assignb_conv1save/RestoreV2_12*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
y
save/RestoreV2_13/tensor_namesConst*'
valueBBb_conv1/train_step*
dtype0*
_output_shapes
:
k
"save/RestoreV2_13/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_13	RestoreV2
save/Constsave/RestoreV2_13/tensor_names"save/RestoreV2_13/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_13Assignb_conv1/train_stepsave/RestoreV2_13*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
{
save/RestoreV2_14/tensor_namesConst*)
value BBb_conv1/train_step_1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_14/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_14	RestoreV2
save/Constsave/RestoreV2_14/tensor_names"save/RestoreV2_14/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_14Assignb_conv1/train_step_1save/RestoreV2_14*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
n
save/RestoreV2_15/tensor_namesConst*
valueBBb_conv2*
dtype0*
_output_shapes
:
k
"save/RestoreV2_15/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_15	RestoreV2
save/Constsave/RestoreV2_15/tensor_names"save/RestoreV2_15/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_15Assignb_conv2save/RestoreV2_15*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
y
save/RestoreV2_16/tensor_namesConst*'
valueBBb_conv2/train_step*
dtype0*
_output_shapes
:
k
"save/RestoreV2_16/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_16	RestoreV2
save/Constsave/RestoreV2_16/tensor_names"save/RestoreV2_16/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_16Assignb_conv2/train_stepsave/RestoreV2_16*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
{
save/RestoreV2_17/tensor_namesConst*)
value BBb_conv2/train_step_1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_17/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_17	RestoreV2
save/Constsave/RestoreV2_17/tensor_names"save/RestoreV2_17/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_17Assignb_conv2/train_step_1save/RestoreV2_17*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
l
save/RestoreV2_18/tensor_namesConst*
valueBBb_fc1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_18/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_18	RestoreV2
save/Constsave/RestoreV2_18/tensor_names"save/RestoreV2_18/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_18Assignb_fc1save/RestoreV2_18*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
w
save/RestoreV2_19/tensor_namesConst*%
valueBBb_fc1/train_step*
dtype0*
_output_shapes
:
k
"save/RestoreV2_19/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_19	RestoreV2
save/Constsave/RestoreV2_19/tensor_names"save/RestoreV2_19/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_19Assignb_fc1/train_stepsave/RestoreV2_19*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
y
save/RestoreV2_20/tensor_namesConst*'
valueBBb_fc1/train_step_1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_20/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_20	RestoreV2
save/Constsave/RestoreV2_20/tensor_names"save/RestoreV2_20/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_20Assignb_fc1/train_step_1save/RestoreV2_20*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
l
save/RestoreV2_21/tensor_namesConst*
valueBBb_fc2*
dtype0*
_output_shapes
:
k
"save/RestoreV2_21/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_21	RestoreV2
save/Constsave/RestoreV2_21/tensor_names"save/RestoreV2_21/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_21Assignb_fc2save/RestoreV2_21*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

w
save/RestoreV2_22/tensor_namesConst*%
valueBBb_fc2/train_step*
dtype0*
_output_shapes
:
k
"save/RestoreV2_22/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_22	RestoreV2
save/Constsave/RestoreV2_22/tensor_names"save/RestoreV2_22/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_22Assignb_fc2/train_stepsave/RestoreV2_22*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

y
save/RestoreV2_23/tensor_namesConst*'
valueBBb_fc2/train_step_1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_23/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_23	RestoreV2
save/Constsave/RestoreV2_23/tensor_names"save/RestoreV2_23/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_23Assignb_fc2/train_step_1save/RestoreV2_23*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

r
save/RestoreV2_24/tensor_namesConst* 
valueBBbeta1_power*
dtype0*
_output_shapes
:
k
"save/RestoreV2_24/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_24	RestoreV2
save/Constsave/RestoreV2_24/tensor_names"save/RestoreV2_24/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_24Assignbeta1_powersave/RestoreV2_24*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*
_output_shapes
: 
r
save/RestoreV2_25/tensor_namesConst* 
valueBBbeta2_power*
dtype0*
_output_shapes
:
k
"save/RestoreV2_25/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_25	RestoreV2
save/Constsave/RestoreV2_25/tensor_names"save/RestoreV2_25/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_25Assignbeta2_powersave/RestoreV2_25*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*
_output_shapes
: 
?
save/restore_shardNoOp^save/Assign^save/Assign_1^save/Assign_2^save/Assign_3^save/Assign_4^save/Assign_5^save/Assign_6^save/Assign_7^save/Assign_8^save/Assign_9^save/Assign_10^save/Assign_11^save/Assign_12^save/Assign_13^save/Assign_14^save/Assign_15^save/Assign_16^save/Assign_17^save/Assign_18^save/Assign_19^save/Assign_20^save/Assign_21^save/Assign_22^save/Assign_23^save/Assign_24^save/Assign_25
-
save/restore_allNoOp^save/restore_shard"<
save/Const:0save/Identity:0save/restore_all (5 @F8"?
	variables??
+
	W_conv1:0W_conv1/AssignW_conv1/read:0
+
	b_conv1:0b_conv1/Assignb_conv1/read:0
+
	W_conv2:0W_conv2/AssignW_conv2/read:0
+
	b_conv2:0b_conv2/Assignb_conv2/read:0
%
W_fc1:0W_fc1/AssignW_fc1/read:0
%
b_fc1:0b_fc1/Assignb_fc1/read:0
%
W_fc2:0W_fc2/AssignW_fc2/read:0
%
b_fc2:0b_fc2/Assignb_fc2/read:0
7
beta1_power:0beta1_power/Assignbeta1_power/read:0
7
beta2_power:0beta2_power/Assignbeta2_power/read:0
L
W_conv1/train_step:0W_conv1/train_step/AssignW_conv1/train_step/read:0
R
W_conv1/train_step_1:0W_conv1/train_step_1/AssignW_conv1/train_step_1/read:0
L
b_conv1/train_step:0b_conv1/train_step/Assignb_conv1/train_step/read:0
R
b_conv1/train_step_1:0b_conv1/train_step_1/Assignb_conv1/train_step_1/read:0
L
W_conv2/train_step:0W_conv2/train_step/AssignW_conv2/train_step/read:0
R
W_conv2/train_step_1:0W_conv2/train_step_1/AssignW_conv2/train_step_1/read:0
L
b_conv2/train_step:0b_conv2/train_step/Assignb_conv2/train_step/read:0
R
b_conv2/train_step_1:0b_conv2/train_step_1/Assignb_conv2/train_step_1/read:0
F
W_fc1/train_step:0W_fc1/train_step/AssignW_fc1/train_step/read:0
L
W_fc1/train_step_1:0W_fc1/train_step_1/AssignW_fc1/train_step_1/read:0
F
b_fc1/train_step:0b_fc1/train_step/Assignb_fc1/train_step/read:0
L
b_fc1/train_step_1:0b_fc1/train_step_1/Assignb_fc1/train_step_1/read:0
F
W_fc2/train_step:0W_fc2/train_step/AssignW_fc2/train_step/read:0
L
W_fc2/train_step_1:0W_fc2/train_step_1/AssignW_fc2/train_step_1/read:0
F
b_fc2/train_step:0b_fc2/train_step/Assignb_fc2/train_step/read:0
L
b_fc2/train_step_1:0b_fc2/train_step_1/Assignb_fc2/train_step_1/read:0"?
trainable_variables??
+
	W_conv1:0W_conv1/AssignW_conv1/read:0
+
	b_conv1:0b_conv1/Assignb_conv1/read:0
+
	W_conv2:0W_conv2/AssignW_conv2/read:0
+
	b_conv2:0b_conv2/Assignb_conv2/read:0
%
W_fc1:0W_fc1/AssignW_fc1/read:0
%
b_fc1:0b_fc1/Assignb_fc1/read:0
%
W_fc2:0W_fc2/AssignW_fc2/read:0
%
b_fc2:0b_fc2/Assignb_fc2/read:0"
train_op


train_step??
?#?#
9
Add
x"T
y"T
z"T"
Ttype:
2	
?
	ApplyAdam
var"T?	
m"T?	
v"T?
beta1_power"T
beta2_power"T
lr"T

beta1"T

beta2"T
epsilon"T	
grad"T
out"T?"
Ttype:
2	"
use_lockingbool( 
l
ArgMax

input"T
	dimension"Tidx

output	"
Ttype:
2	"
Tidxtype0:
2	
x
Assign
ref"T?

value"T

output_ref"T?"	
Ttype"
validate_shapebool("
use_lockingbool(?
R
BroadcastGradientArgs
s0"T
s1"T
r0"T
r1"T"
Ttype0:
2	
8
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
?
Conv2D

input"T
filter"T
output"T"
Ttype:
2"
strides	list(int)"
use_cudnn_on_gpubool(""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW
?
Conv2DBackpropFilter

input"T
filter_sizes
out_backprop"T
output"T"
Ttype:
2"
strides	list(int)"
use_cudnn_on_gpubool(""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW
?
Conv2DBackpropInput
input_sizes
filter"T
out_backprop"T
output"T"
Ttype:
2"
strides	list(int)"
use_cudnn_on_gpubool(""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW
A
Equal
x"T
y"T
z
"
Ttype:
2	
?
W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
4
Fill
dims

value"T
output"T"	
Ttype
>
FloorDiv
x"T
y"T
z"T"
Ttype:
2	
.
Identity

input"T
output"T"	
Ttype
o
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2
?
MaxPool

input"T
output"T"
Ttype0:
2"
ksize	list(int)(0"
strides	list(int)(0""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW
?
MaxPoolGrad

orig_input"T
orig_output"T	
grad"T
output"T"
ksize	list(int)(0"
strides	list(int)(0""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW"
Ttype0:
2
:
Maximum
x"T
y"T
z"T"
Ttype:	
2	?
?
Mean

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( "
Ttype:
2	"
Tidxtype0:
2	
b
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(
<
Mul
x"T
y"T
z"T"
Ttype:
2	?

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
A
Placeholder
output"dtype"
dtypetype"
shapeshape: 
?
Prod

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( "
Ttype:
2	"
Tidxtype0:
2	
=
RealDiv
x"T
y"T
z"T"
Ttype:
2	
A
Relu
features"T
activations"T"
Ttype:
2		
S
ReluGrad
	gradients"T
features"T
	backprops"T"
Ttype:
2		
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
l
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
i
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
a
Slice

input"T
begin"Index
size"Index
output"T"	
Ttype"
Indextype:
2	
i
SoftmaxCrossEntropyWithLogits
features"T
labels"T	
loss"T
backprop"T"
Ttype:
2
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
5
Sub
x"T
y"T
z"T"
Ttype:
	2	
?
Sum

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( "
Ttype:
2	"
Tidxtype0:
2	
c
Tile

input"T
	multiples"
Tmultiples
output"T"	
Ttype"

Tmultiplestype0:
2	

TruncatedNormal

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	?
s

VariableV2
ref"dtype?"
shapeshape"
dtypetype"
	containerstring "
shared_namestring ?
&
	ZerosLike
x"T
y"T"	
Ttype"s"e"r"v"i"n"g*1.1.02
b'unknown'??
[
xPlaceholder*
dtype0*
shape: */
_output_shapes
:?????????  
X
y_realPlaceholder*
dtype0*
shape: *'
_output_shapes
:?????????

o
truncated_normal/shapeConst*%
valueB"             *
dtype0*
_output_shapes
:
Z
truncated_normal/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
\
truncated_normal/stddevConst*
valueB
 *???=*
dtype0*
_output_shapes
: 
?
 truncated_normal/TruncatedNormalTruncatedNormaltruncated_normal/shape*

seed *
seed2 *
dtype0*
T0*&
_output_shapes
: 
?
truncated_normal/mulMul truncated_normal/TruncatedNormaltruncated_normal/stddev*
T0*&
_output_shapes
: 
u
truncated_normalAddtruncated_normal/multruncated_normal/mean*
T0*&
_output_shapes
: 
?
W_conv1
VariableV2*
shape: *
dtype0*
	container *
shared_name *&
_output_shapes
: 
?
W_conv1/AssignAssignW_conv1truncated_normal*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
n
W_conv1/readIdentityW_conv1*
T0*
_class
loc:@W_conv1*&
_output_shapes
: 
R
ConstConst*
valueB *???=*
dtype0*
_output_shapes
: 
s
b_conv1
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_output_shapes
: 
?
b_conv1/AssignAssignb_conv1Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
b
b_conv1/readIdentityb_conv1*
T0*
_class
loc:@b_conv1*
_output_shapes
: 
?
conv2dConv2DxW_conv1/read*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*/
_output_shapes
:?????????   
Z
addAddconv2db_conv1/read*
T0*/
_output_shapes
:?????????   
N
h_conv1Reluadd*
T0*/
_output_shapes
:?????????   
?
h_pool1MaxPoolh_conv1*
T0*
ksize
*
strides
*
paddingSAME*
data_formatNHWC*/
_output_shapes
:????????? 
q
truncated_normal_1/shapeConst*%
valueB"          @   *
dtype0*
_output_shapes
:
\
truncated_normal_1/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
^
truncated_normal_1/stddevConst*
valueB
 *???=*
dtype0*
_output_shapes
: 
?
"truncated_normal_1/TruncatedNormalTruncatedNormaltruncated_normal_1/shape*

seed *
seed2 *
dtype0*
T0*&
_output_shapes
: @
?
truncated_normal_1/mulMul"truncated_normal_1/TruncatedNormaltruncated_normal_1/stddev*
T0*&
_output_shapes
: @
{
truncated_normal_1Addtruncated_normal_1/multruncated_normal_1/mean*
T0*&
_output_shapes
: @
?
W_conv2
VariableV2*
shape: @*
dtype0*
	container *
shared_name *&
_output_shapes
: @
?
W_conv2/AssignAssignW_conv2truncated_normal_1*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
n
W_conv2/readIdentityW_conv2*
T0*
_class
loc:@W_conv2*&
_output_shapes
: @
T
Const_1Const*
valueB@*???=*
dtype0*
_output_shapes
:@
s
b_conv2
VariableV2*
shape:@*
dtype0*
	container *
shared_name *
_output_shapes
:@
?
b_conv2/AssignAssignb_conv2Const_1*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
b
b_conv2/readIdentityb_conv2*
T0*
_class
loc:@b_conv2*
_output_shapes
:@
?
conv2d_1Conv2Dh_pool1W_conv2/read*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*/
_output_shapes
:?????????@
^
add_1Addconv2d_1b_conv2/read*
T0*/
_output_shapes
:?????????@
P
h_conv2Reluadd_1*
T0*/
_output_shapes
:?????????@
?
h_pool2MaxPoolh_conv2*
T0*
ksize
*
strides
*
paddingSAME*
data_formatNHWC*/
_output_shapes
:?????????@
i
truncated_normal_2/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
\
truncated_normal_2/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
^
truncated_normal_2/stddevConst*
valueB
 *???=*
dtype0*
_output_shapes
: 
?
"truncated_normal_2/TruncatedNormalTruncatedNormaltruncated_normal_2/shape*

seed *
seed2 *
dtype0*
T0* 
_output_shapes
:
? ?
?
truncated_normal_2/mulMul"truncated_normal_2/TruncatedNormaltruncated_normal_2/stddev*
T0* 
_output_shapes
:
? ?
u
truncated_normal_2Addtruncated_normal_2/multruncated_normal_2/mean*
T0* 
_output_shapes
:
? ?
}
W_fc1
VariableV2*
shape:
? ?*
dtype0*
	container *
shared_name * 
_output_shapes
:
? ?
?
W_fc1/AssignAssignW_fc1truncated_normal_2*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
b

W_fc1/readIdentityW_fc1*
T0*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
V
Const_2Const*
valueB?*???=*
dtype0*
_output_shapes	
:?
s
b_fc1
VariableV2*
shape:?*
dtype0*
	container *
shared_name *
_output_shapes	
:?
?
b_fc1/AssignAssignb_fc1Const_2*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
]

b_fc1/readIdentityb_fc1*
T0*
_class

loc:@b_fc1*
_output_shapes	
:?
f
h_pool2_reshape/shapeConst*
valueB"????   *
dtype0*
_output_shapes
:
{
h_pool2_reshapeReshapeh_pool2h_pool2_reshape/shape*
T0*
Tshape0*(
_output_shapes
:?????????? 
?
MatMulMatMulh_pool2_reshape
W_fc1/read*
transpose_a( *
transpose_b( *
T0*(
_output_shapes
:??????????
S
add_2AddMatMul
b_fc1/read*
T0*(
_output_shapes
:??????????
G
h_fc1Reluadd_2*
T0*(
_output_shapes
:??????????
i
truncated_normal_3/shapeConst*
valueB"   
   *
dtype0*
_output_shapes
:
\
truncated_normal_3/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
^
truncated_normal_3/stddevConst*
valueB
 *???=*
dtype0*
_output_shapes
: 
?
"truncated_normal_3/TruncatedNormalTruncatedNormaltruncated_normal_3/shape*

seed *
seed2 *
dtype0*
T0*
_output_shapes
:	?

?
truncated_normal_3/mulMul"truncated_normal_3/TruncatedNormaltruncated_normal_3/stddev*
T0*
_output_shapes
:	?

t
truncated_normal_3Addtruncated_normal_3/multruncated_normal_3/mean*
T0*
_output_shapes
:	?

{
W_fc2
VariableV2*
shape:	?
*
dtype0*
	container *
shared_name *
_output_shapes
:	?

?
W_fc2/AssignAssignW_fc2truncated_normal_3*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

a

W_fc2/readIdentityW_fc2*
T0*
_class

loc:@W_fc2*
_output_shapes
:	?

T
Const_3Const*
valueB
*???=*
dtype0*
_output_shapes
:

q
b_fc2
VariableV2*
shape:
*
dtype0*
	container *
shared_name *
_output_shapes
:

?
b_fc2/AssignAssignb_fc2Const_3*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

\

b_fc2/readIdentityb_fc2*
T0*
_class

loc:@b_fc2*
_output_shapes
:

}
MatMul_1MatMulh_fc1
W_fc2/read*
transpose_a( *
transpose_b( *
T0*'
_output_shapes
:?????????

]
labels_predictAddMatMul_1
b_fc2/read*
T0*'
_output_shapes
:?????????

F
RankConst*
value	B :*
dtype0*
_output_shapes
: 
S
ShapeShapelabels_predict*
T0*
out_type0*
_output_shapes
:
H
Rank_1Const*
value	B :*
dtype0*
_output_shapes
: 
U
Shape_1Shapelabels_predict*
T0*
out_type0*
_output_shapes
:
G
Sub/yConst*
value	B :*
dtype0*
_output_shapes
: 
:
SubSubRank_1Sub/y*
T0*
_output_shapes
: 
R
Slice/beginPackSub*
N*
T0*

axis *
_output_shapes
:
T

Slice/sizeConst*
valueB:*
dtype0*
_output_shapes
:
b
SliceSliceShape_1Slice/begin
Slice/size*
T0*
Index0*
_output_shapes
:
b
concat/values_0Const*
valueB:
?????????*
dtype0*
_output_shapes
:
M
concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
q
concatConcatV2concat/values_0Sliceconcat/axis*
N*
T0*

Tidx0*
_output_shapes
:
s
ReshapeReshapelabels_predictconcat*
T0*
Tshape0*0
_output_shapes
:??????????????????
H
Rank_2Const*
value	B :*
dtype0*
_output_shapes
: 
M
Shape_2Shapey_real*
T0*
out_type0*
_output_shapes
:
I
Sub_1/yConst*
value	B :*
dtype0*
_output_shapes
: 
>
Sub_1SubRank_2Sub_1/y*
T0*
_output_shapes
: 
V
Slice_1/beginPackSub_1*
N*
T0*

axis *
_output_shapes
:
V
Slice_1/sizeConst*
valueB:*
dtype0*
_output_shapes
:
h
Slice_1SliceShape_2Slice_1/beginSlice_1/size*
T0*
Index0*
_output_shapes
:
d
concat_1/values_0Const*
valueB:
?????????*
dtype0*
_output_shapes
:
O
concat_1/axisConst*
value	B : *
dtype0*
_output_shapes
: 
y
concat_1ConcatV2concat_1/values_0Slice_1concat_1/axis*
N*
T0*

Tidx0*
_output_shapes
:
o
	Reshape_1Reshapey_realconcat_1*
T0*
Tshape0*0
_output_shapes
:??????????????????
?
SoftmaxCrossEntropyWithLogitsSoftmaxCrossEntropyWithLogitsReshape	Reshape_1*
T0*?
_output_shapes-
+:?????????:??????????????????
I
Sub_2/yConst*
value	B :*
dtype0*
_output_shapes
: 
<
Sub_2SubRankSub_2/y*
T0*
_output_shapes
: 
W
Slice_2/beginConst*
valueB: *
dtype0*
_output_shapes
:
U
Slice_2/sizePackSub_2*
N*
T0*

axis *
_output_shapes
:
o
Slice_2SliceShapeSlice_2/beginSlice_2/size*
T0*
Index0*#
_output_shapes
:?????????
x
	Reshape_2ReshapeSoftmaxCrossEntropyWithLogitsSlice_2*
T0*
Tshape0*#
_output_shapes
:?????????
Q
Const_4Const*
valueB: *
dtype0*
_output_shapes
:
[
JMean	Reshape_2Const_4*
	keep_dims( *
T0*

Tidx0*
_output_shapes
: 
R
gradients/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
T
gradients/ConstConst*
valueB
 *  ??*
dtype0*
_output_shapes
: 
Y
gradients/FillFillgradients/Shapegradients/Const*
T0*
_output_shapes
: 
h
gradients/J_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
?
gradients/J_grad/ReshapeReshapegradients/Fillgradients/J_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
_
gradients/J_grad/ShapeShape	Reshape_2*
T0*
out_type0*
_output_shapes
:
?
gradients/J_grad/TileTilegradients/J_grad/Reshapegradients/J_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:?????????
a
gradients/J_grad/Shape_1Shape	Reshape_2*
T0*
out_type0*
_output_shapes
:
[
gradients/J_grad/Shape_2Const*
valueB *
dtype0*
_output_shapes
: 
`
gradients/J_grad/ConstConst*
valueB: *
dtype0*
_output_shapes
:
?
gradients/J_grad/ProdProdgradients/J_grad/Shape_1gradients/J_grad/Const*
	keep_dims( *
T0*

Tidx0*
_output_shapes
: 
b
gradients/J_grad/Const_1Const*
valueB: *
dtype0*
_output_shapes
:
?
gradients/J_grad/Prod_1Prodgradients/J_grad/Shape_2gradients/J_grad/Const_1*
	keep_dims( *
T0*

Tidx0*
_output_shapes
: 
\
gradients/J_grad/Maximum/yConst*
value	B :*
dtype0*
_output_shapes
: 
y
gradients/J_grad/MaximumMaximumgradients/J_grad/Prod_1gradients/J_grad/Maximum/y*
T0*
_output_shapes
: 
w
gradients/J_grad/floordivFloorDivgradients/J_grad/Prodgradients/J_grad/Maximum*
T0*
_output_shapes
: 
h
gradients/J_grad/CastCastgradients/J_grad/floordiv*

SrcT0*

DstT0*
_output_shapes
: 

gradients/J_grad/truedivRealDivgradients/J_grad/Tilegradients/J_grad/Cast*
T0*#
_output_shapes
:?????????
{
gradients/Reshape_2_grad/ShapeShapeSoftmaxCrossEntropyWithLogits*
T0*
out_type0*
_output_shapes
:
?
 gradients/Reshape_2_grad/ReshapeReshapegradients/J_grad/truedivgradients/Reshape_2_grad/Shape*
T0*
Tshape0*#
_output_shapes
:?????????
}
gradients/zeros_like	ZerosLikeSoftmaxCrossEntropyWithLogits:1*
T0*0
_output_shapes
:??????????????????
?
;gradients/SoftmaxCrossEntropyWithLogits_grad/ExpandDims/dimConst*
valueB :
?????????*
dtype0*
_output_shapes
: 
?
7gradients/SoftmaxCrossEntropyWithLogits_grad/ExpandDims
ExpandDims gradients/Reshape_2_grad/Reshape;gradients/SoftmaxCrossEntropyWithLogits_grad/ExpandDims/dim*
T0*

Tdim0*'
_output_shapes
:?????????
?
0gradients/SoftmaxCrossEntropyWithLogits_grad/mulMul7gradients/SoftmaxCrossEntropyWithLogits_grad/ExpandDimsSoftmaxCrossEntropyWithLogits:1*
T0*0
_output_shapes
:??????????????????
j
gradients/Reshape_grad/ShapeShapelabels_predict*
T0*
out_type0*
_output_shapes
:
?
gradients/Reshape_grad/ReshapeReshape0gradients/SoftmaxCrossEntropyWithLogits_grad/mulgradients/Reshape_grad/Shape*
T0*
Tshape0*'
_output_shapes
:?????????

k
#gradients/labels_predict_grad/ShapeShapeMatMul_1*
T0*
out_type0*
_output_shapes
:
o
%gradients/labels_predict_grad/Shape_1Const*
valueB:
*
dtype0*
_output_shapes
:
?
3gradients/labels_predict_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients/labels_predict_grad/Shape%gradients/labels_predict_grad/Shape_1*
T0*2
_output_shapes 
:?????????:?????????
?
!gradients/labels_predict_grad/SumSumgradients/Reshape_grad/Reshape3gradients/labels_predict_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
%gradients/labels_predict_grad/ReshapeReshape!gradients/labels_predict_grad/Sum#gradients/labels_predict_grad/Shape*
T0*
Tshape0*'
_output_shapes
:?????????

?
#gradients/labels_predict_grad/Sum_1Sumgradients/Reshape_grad/Reshape5gradients/labels_predict_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
'gradients/labels_predict_grad/Reshape_1Reshape#gradients/labels_predict_grad/Sum_1%gradients/labels_predict_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:

?
.gradients/labels_predict_grad/tuple/group_depsNoOp&^gradients/labels_predict_grad/Reshape(^gradients/labels_predict_grad/Reshape_1
?
6gradients/labels_predict_grad/tuple/control_dependencyIdentity%gradients/labels_predict_grad/Reshape/^gradients/labels_predict_grad/tuple/group_deps*
T0*8
_class.
,*loc:@gradients/labels_predict_grad/Reshape*'
_output_shapes
:?????????

?
8gradients/labels_predict_grad/tuple/control_dependency_1Identity'gradients/labels_predict_grad/Reshape_1/^gradients/labels_predict_grad/tuple/group_deps*
T0*:
_class0
.,loc:@gradients/labels_predict_grad/Reshape_1*
_output_shapes
:

?
gradients/MatMul_1_grad/MatMulMatMul6gradients/labels_predict_grad/tuple/control_dependency
W_fc2/read*
transpose_a( *
transpose_b(*
T0*(
_output_shapes
:??????????
?
 gradients/MatMul_1_grad/MatMul_1MatMulh_fc16gradients/labels_predict_grad/tuple/control_dependency*
transpose_a(*
transpose_b( *
T0*
_output_shapes
:	?

t
(gradients/MatMul_1_grad/tuple/group_depsNoOp^gradients/MatMul_1_grad/MatMul!^gradients/MatMul_1_grad/MatMul_1
?
0gradients/MatMul_1_grad/tuple/control_dependencyIdentitygradients/MatMul_1_grad/MatMul)^gradients/MatMul_1_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/MatMul_1_grad/MatMul*(
_output_shapes
:??????????
?
2gradients/MatMul_1_grad/tuple/control_dependency_1Identity gradients/MatMul_1_grad/MatMul_1)^gradients/MatMul_1_grad/tuple/group_deps*
T0*3
_class)
'%loc:@gradients/MatMul_1_grad/MatMul_1*
_output_shapes
:	?

?
gradients/h_fc1_grad/ReluGradReluGrad0gradients/MatMul_1_grad/tuple/control_dependencyh_fc1*
T0*(
_output_shapes
:??????????
`
gradients/add_2_grad/ShapeShapeMatMul*
T0*
out_type0*
_output_shapes
:
g
gradients/add_2_grad/Shape_1Const*
valueB:?*
dtype0*
_output_shapes
:
?
*gradients/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/add_2_grad/Shapegradients/add_2_grad/Shape_1*
T0*2
_output_shapes 
:?????????:?????????
?
gradients/add_2_grad/SumSumgradients/h_fc1_grad/ReluGrad*gradients/add_2_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_2_grad/ReshapeReshapegradients/add_2_grad/Sumgradients/add_2_grad/Shape*
T0*
Tshape0*(
_output_shapes
:??????????
?
gradients/add_2_grad/Sum_1Sumgradients/h_fc1_grad/ReluGrad,gradients/add_2_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_2_grad/Reshape_1Reshapegradients/add_2_grad/Sum_1gradients/add_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes	
:?
m
%gradients/add_2_grad/tuple/group_depsNoOp^gradients/add_2_grad/Reshape^gradients/add_2_grad/Reshape_1
?
-gradients/add_2_grad/tuple/control_dependencyIdentitygradients/add_2_grad/Reshape&^gradients/add_2_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/add_2_grad/Reshape*(
_output_shapes
:??????????
?
/gradients/add_2_grad/tuple/control_dependency_1Identitygradients/add_2_grad/Reshape_1&^gradients/add_2_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/add_2_grad/Reshape_1*
_output_shapes	
:?
?
gradients/MatMul_grad/MatMulMatMul-gradients/add_2_grad/tuple/control_dependency
W_fc1/read*
transpose_a( *
transpose_b(*
T0*(
_output_shapes
:?????????? 
?
gradients/MatMul_grad/MatMul_1MatMulh_pool2_reshape-gradients/add_2_grad/tuple/control_dependency*
transpose_a(*
transpose_b( *
T0* 
_output_shapes
:
? ?
n
&gradients/MatMul_grad/tuple/group_depsNoOp^gradients/MatMul_grad/MatMul^gradients/MatMul_grad/MatMul_1
?
.gradients/MatMul_grad/tuple/control_dependencyIdentitygradients/MatMul_grad/MatMul'^gradients/MatMul_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/MatMul_grad/MatMul*(
_output_shapes
:?????????? 
?
0gradients/MatMul_grad/tuple/control_dependency_1Identitygradients/MatMul_grad/MatMul_1'^gradients/MatMul_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/MatMul_grad/MatMul_1* 
_output_shapes
:
? ?
k
$gradients/h_pool2_reshape_grad/ShapeShapeh_pool2*
T0*
out_type0*
_output_shapes
:
?
&gradients/h_pool2_reshape_grad/ReshapeReshape.gradients/MatMul_grad/tuple/control_dependency$gradients/h_pool2_reshape_grad/Shape*
T0*
Tshape0*/
_output_shapes
:?????????@
?
"gradients/h_pool2_grad/MaxPoolGradMaxPoolGradh_conv2h_pool2&gradients/h_pool2_reshape_grad/Reshape*
ksize
*
strides
*
paddingSAME*
data_formatNHWC*
T0*/
_output_shapes
:?????????@
?
gradients/h_conv2_grad/ReluGradReluGrad"gradients/h_pool2_grad/MaxPoolGradh_conv2*
T0*/
_output_shapes
:?????????@
b
gradients/add_1_grad/ShapeShapeconv2d_1*
T0*
out_type0*
_output_shapes
:
f
gradients/add_1_grad/Shape_1Const*
valueB:@*
dtype0*
_output_shapes
:
?
*gradients/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/add_1_grad/Shapegradients/add_1_grad/Shape_1*
T0*2
_output_shapes 
:?????????:?????????
?
gradients/add_1_grad/SumSumgradients/h_conv2_grad/ReluGrad*gradients/add_1_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_1_grad/ReshapeReshapegradients/add_1_grad/Sumgradients/add_1_grad/Shape*
T0*
Tshape0*/
_output_shapes
:?????????@
?
gradients/add_1_grad/Sum_1Sumgradients/h_conv2_grad/ReluGrad,gradients/add_1_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_1_grad/Reshape_1Reshapegradients/add_1_grad/Sum_1gradients/add_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:@
m
%gradients/add_1_grad/tuple/group_depsNoOp^gradients/add_1_grad/Reshape^gradients/add_1_grad/Reshape_1
?
-gradients/add_1_grad/tuple/control_dependencyIdentitygradients/add_1_grad/Reshape&^gradients/add_1_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/add_1_grad/Reshape*/
_output_shapes
:?????????@
?
/gradients/add_1_grad/tuple/control_dependency_1Identitygradients/add_1_grad/Reshape_1&^gradients/add_1_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/add_1_grad/Reshape_1*
_output_shapes
:@
d
gradients/conv2d_1_grad/ShapeShapeh_pool1*
T0*
out_type0*
_output_shapes
:
?
+gradients/conv2d_1_grad/Conv2DBackpropInputConv2DBackpropInputgradients/conv2d_1_grad/ShapeW_conv2/read-gradients/add_1_grad/tuple/control_dependency*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*J
_output_shapes8
6:4????????????????????????????????????
x
gradients/conv2d_1_grad/Shape_1Const*%
valueB"          @   *
dtype0*
_output_shapes
:
?
,gradients/conv2d_1_grad/Conv2DBackpropFilterConv2DBackpropFilterh_pool1gradients/conv2d_1_grad/Shape_1-gradients/add_1_grad/tuple/control_dependency*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*&
_output_shapes
: @
?
(gradients/conv2d_1_grad/tuple/group_depsNoOp,^gradients/conv2d_1_grad/Conv2DBackpropInput-^gradients/conv2d_1_grad/Conv2DBackpropFilter
?
0gradients/conv2d_1_grad/tuple/control_dependencyIdentity+gradients/conv2d_1_grad/Conv2DBackpropInput)^gradients/conv2d_1_grad/tuple/group_deps*
T0*>
_class4
20loc:@gradients/conv2d_1_grad/Conv2DBackpropInput*/
_output_shapes
:????????? 
?
2gradients/conv2d_1_grad/tuple/control_dependency_1Identity,gradients/conv2d_1_grad/Conv2DBackpropFilter)^gradients/conv2d_1_grad/tuple/group_deps*
T0*?
_class5
31loc:@gradients/conv2d_1_grad/Conv2DBackpropFilter*&
_output_shapes
: @
?
"gradients/h_pool1_grad/MaxPoolGradMaxPoolGradh_conv1h_pool10gradients/conv2d_1_grad/tuple/control_dependency*
ksize
*
strides
*
paddingSAME*
data_formatNHWC*
T0*/
_output_shapes
:?????????   
?
gradients/h_conv1_grad/ReluGradReluGrad"gradients/h_pool1_grad/MaxPoolGradh_conv1*
T0*/
_output_shapes
:?????????   
^
gradients/add_grad/ShapeShapeconv2d*
T0*
out_type0*
_output_shapes
:
d
gradients/add_grad/Shape_1Const*
valueB: *
dtype0*
_output_shapes
:
?
(gradients/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/add_grad/Shapegradients/add_grad/Shape_1*
T0*2
_output_shapes 
:?????????:?????????
?
gradients/add_grad/SumSumgradients/h_conv1_grad/ReluGrad(gradients/add_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_grad/ReshapeReshapegradients/add_grad/Sumgradients/add_grad/Shape*
T0*
Tshape0*/
_output_shapes
:?????????   
?
gradients/add_grad/Sum_1Sumgradients/h_conv1_grad/ReluGrad*gradients/add_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0*
_output_shapes
:
?
gradients/add_grad/Reshape_1Reshapegradients/add_grad/Sum_1gradients/add_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
g
#gradients/add_grad/tuple/group_depsNoOp^gradients/add_grad/Reshape^gradients/add_grad/Reshape_1
?
+gradients/add_grad/tuple/control_dependencyIdentitygradients/add_grad/Reshape$^gradients/add_grad/tuple/group_deps*
T0*-
_class#
!loc:@gradients/add_grad/Reshape*/
_output_shapes
:?????????   
?
-gradients/add_grad/tuple/control_dependency_1Identitygradients/add_grad/Reshape_1$^gradients/add_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/add_grad/Reshape_1*
_output_shapes
: 
\
gradients/conv2d_grad/ShapeShapex*
T0*
out_type0*
_output_shapes
:
?
)gradients/conv2d_grad/Conv2DBackpropInputConv2DBackpropInputgradients/conv2d_grad/ShapeW_conv1/read+gradients/add_grad/tuple/control_dependency*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*J
_output_shapes8
6:4????????????????????????????????????
v
gradients/conv2d_grad/Shape_1Const*%
valueB"             *
dtype0*
_output_shapes
:
?
*gradients/conv2d_grad/Conv2DBackpropFilterConv2DBackpropFilterxgradients/conv2d_grad/Shape_1+gradients/add_grad/tuple/control_dependency*
T0*
strides
*
use_cudnn_on_gpu(*
paddingSAME*
data_formatNHWC*&
_output_shapes
: 
?
&gradients/conv2d_grad/tuple/group_depsNoOp*^gradients/conv2d_grad/Conv2DBackpropInput+^gradients/conv2d_grad/Conv2DBackpropFilter
?
.gradients/conv2d_grad/tuple/control_dependencyIdentity)gradients/conv2d_grad/Conv2DBackpropInput'^gradients/conv2d_grad/tuple/group_deps*
T0*<
_class2
0.loc:@gradients/conv2d_grad/Conv2DBackpropInput*/
_output_shapes
:?????????  
?
0gradients/conv2d_grad/tuple/control_dependency_1Identity*gradients/conv2d_grad/Conv2DBackpropFilter'^gradients/conv2d_grad/tuple/group_deps*
T0*=
_class3
1/loc:@gradients/conv2d_grad/Conv2DBackpropFilter*&
_output_shapes
: 
z
beta1_power/initial_valueConst*
valueB
 *fff?*
dtype0*
_class
loc:@W_conv1*
_output_shapes
: 
?
beta1_power
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@W_conv1*
_output_shapes
: 
?
beta1_power/AssignAssignbeta1_powerbeta1_power/initial_value*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*
_output_shapes
: 
f
beta1_power/readIdentitybeta1_power*
T0*
_class
loc:@W_conv1*
_output_shapes
: 
z
beta2_power/initial_valueConst*
valueB
 *w??*
dtype0*
_class
loc:@W_conv1*
_output_shapes
: 
?
beta2_power
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@W_conv1*
_output_shapes
: 
?
beta2_power/AssignAssignbeta2_powerbeta2_power/initial_value*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*
_output_shapes
: 
f
beta2_power/readIdentitybeta2_power*
T0*
_class
loc:@W_conv1*
_output_shapes
: 
?
$W_conv1/train_step/Initializer/ConstConst*%
valueB *    *
dtype0*
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step/AssignAssignW_conv1/train_step$W_conv1/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step/readIdentityW_conv1/train_step*
T0*
_class
loc:@W_conv1*&
_output_shapes
: 
?
&W_conv1/train_step_1/Initializer/ConstConst*%
valueB *    *
dtype0*
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step_1
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step_1/AssignAssignW_conv1/train_step_1&W_conv1/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
?
W_conv1/train_step_1/readIdentityW_conv1/train_step_1*
T0*
_class
loc:@W_conv1*&
_output_shapes
: 
?
$b_conv1/train_step/Initializer/ConstConst*
valueB *    *
dtype0*
_class
loc:@b_conv1*
_output_shapes
: 
?
b_conv1/train_step
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@b_conv1*
_output_shapes
: 
?
b_conv1/train_step/AssignAssignb_conv1/train_step$b_conv1/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
x
b_conv1/train_step/readIdentityb_conv1/train_step*
T0*
_class
loc:@b_conv1*
_output_shapes
: 
?
&b_conv1/train_step_1/Initializer/ConstConst*
valueB *    *
dtype0*
_class
loc:@b_conv1*
_output_shapes
: 
?
b_conv1/train_step_1
VariableV2*
shape: *
dtype0*
	container *
shared_name *
_class
loc:@b_conv1*
_output_shapes
: 
?
b_conv1/train_step_1/AssignAssignb_conv1/train_step_1&b_conv1/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
|
b_conv1/train_step_1/readIdentityb_conv1/train_step_1*
T0*
_class
loc:@b_conv1*
_output_shapes
: 
?
$W_conv2/train_step/Initializer/ConstConst*%
valueB @*    *
dtype0*
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step
VariableV2*
shape: @*
dtype0*
	container *
shared_name *
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step/AssignAssignW_conv2/train_step$W_conv2/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step/readIdentityW_conv2/train_step*
T0*
_class
loc:@W_conv2*&
_output_shapes
: @
?
&W_conv2/train_step_1/Initializer/ConstConst*%
valueB @*    *
dtype0*
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step_1
VariableV2*
shape: @*
dtype0*
	container *
shared_name *
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step_1/AssignAssignW_conv2/train_step_1&W_conv2/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
?
W_conv2/train_step_1/readIdentityW_conv2/train_step_1*
T0*
_class
loc:@W_conv2*&
_output_shapes
: @
?
$b_conv2/train_step/Initializer/ConstConst*
valueB@*    *
dtype0*
_class
loc:@b_conv2*
_output_shapes
:@
?
b_conv2/train_step
VariableV2*
shape:@*
dtype0*
	container *
shared_name *
_class
loc:@b_conv2*
_output_shapes
:@
?
b_conv2/train_step/AssignAssignb_conv2/train_step$b_conv2/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
x
b_conv2/train_step/readIdentityb_conv2/train_step*
T0*
_class
loc:@b_conv2*
_output_shapes
:@
?
&b_conv2/train_step_1/Initializer/ConstConst*
valueB@*    *
dtype0*
_class
loc:@b_conv2*
_output_shapes
:@
?
b_conv2/train_step_1
VariableV2*
shape:@*
dtype0*
	container *
shared_name *
_class
loc:@b_conv2*
_output_shapes
:@
?
b_conv2/train_step_1/AssignAssignb_conv2/train_step_1&b_conv2/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
|
b_conv2/train_step_1/readIdentityb_conv2/train_step_1*
T0*
_class
loc:@b_conv2*
_output_shapes
:@
?
"W_fc1/train_step/Initializer/ConstConst*
valueB
? ?*    *
dtype0*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
W_fc1/train_step
VariableV2*
shape:
? ?*
dtype0*
	container *
shared_name *
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
W_fc1/train_step/AssignAssignW_fc1/train_step"W_fc1/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
x
W_fc1/train_step/readIdentityW_fc1/train_step*
T0*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
$W_fc1/train_step_1/Initializer/ConstConst*
valueB
? ?*    *
dtype0*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
W_fc1/train_step_1
VariableV2*
shape:
? ?*
dtype0*
	container *
shared_name *
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
W_fc1/train_step_1/AssignAssignW_fc1/train_step_1$W_fc1/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
|
W_fc1/train_step_1/readIdentityW_fc1/train_step_1*
T0*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
"b_fc1/train_step/Initializer/ConstConst*
valueB?*    *
dtype0*
_class

loc:@b_fc1*
_output_shapes	
:?
?
b_fc1/train_step
VariableV2*
shape:?*
dtype0*
	container *
shared_name *
_class

loc:@b_fc1*
_output_shapes	
:?
?
b_fc1/train_step/AssignAssignb_fc1/train_step"b_fc1/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
s
b_fc1/train_step/readIdentityb_fc1/train_step*
T0*
_class

loc:@b_fc1*
_output_shapes	
:?
?
$b_fc1/train_step_1/Initializer/ConstConst*
valueB?*    *
dtype0*
_class

loc:@b_fc1*
_output_shapes	
:?
?
b_fc1/train_step_1
VariableV2*
shape:?*
dtype0*
	container *
shared_name *
_class

loc:@b_fc1*
_output_shapes	
:?
?
b_fc1/train_step_1/AssignAssignb_fc1/train_step_1$b_fc1/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
w
b_fc1/train_step_1/readIdentityb_fc1/train_step_1*
T0*
_class

loc:@b_fc1*
_output_shapes	
:?
?
"W_fc2/train_step/Initializer/ConstConst*
valueB	?
*    *
dtype0*
_class

loc:@W_fc2*
_output_shapes
:	?

?
W_fc2/train_step
VariableV2*
shape:	?
*
dtype0*
	container *
shared_name *
_class

loc:@W_fc2*
_output_shapes
:	?

?
W_fc2/train_step/AssignAssignW_fc2/train_step"W_fc2/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

w
W_fc2/train_step/readIdentityW_fc2/train_step*
T0*
_class

loc:@W_fc2*
_output_shapes
:	?

?
$W_fc2/train_step_1/Initializer/ConstConst*
valueB	?
*    *
dtype0*
_class

loc:@W_fc2*
_output_shapes
:	?

?
W_fc2/train_step_1
VariableV2*
shape:	?
*
dtype0*
	container *
shared_name *
_class

loc:@W_fc2*
_output_shapes
:	?

?
W_fc2/train_step_1/AssignAssignW_fc2/train_step_1$W_fc2/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

{
W_fc2/train_step_1/readIdentityW_fc2/train_step_1*
T0*
_class

loc:@W_fc2*
_output_shapes
:	?

?
"b_fc2/train_step/Initializer/ConstConst*
valueB
*    *
dtype0*
_class

loc:@b_fc2*
_output_shapes
:

?
b_fc2/train_step
VariableV2*
shape:
*
dtype0*
	container *
shared_name *
_class

loc:@b_fc2*
_output_shapes
:

?
b_fc2/train_step/AssignAssignb_fc2/train_step"b_fc2/train_step/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

r
b_fc2/train_step/readIdentityb_fc2/train_step*
T0*
_class

loc:@b_fc2*
_output_shapes
:

?
$b_fc2/train_step_1/Initializer/ConstConst*
valueB
*    *
dtype0*
_class

loc:@b_fc2*
_output_shapes
:

?
b_fc2/train_step_1
VariableV2*
shape:
*
dtype0*
	container *
shared_name *
_class

loc:@b_fc2*
_output_shapes
:

?
b_fc2/train_step_1/AssignAssignb_fc2/train_step_1$b_fc2/train_step_1/Initializer/Const*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

v
b_fc2/train_step_1/readIdentityb_fc2/train_step_1*
T0*
_class

loc:@b_fc2*
_output_shapes
:

]
train_step/learning_rateConst*
valueB
 *??8*
dtype0*
_output_shapes
: 
U
train_step/beta1Const*
valueB
 *fff?*
dtype0*
_output_shapes
: 
U
train_step/beta2Const*
valueB
 *w??*
dtype0*
_output_shapes
: 
W
train_step/epsilonConst*
valueB
 *w?+2*
dtype0*
_output_shapes
: 
?
#train_step/update_W_conv1/ApplyAdam	ApplyAdamW_conv1W_conv1/train_stepW_conv1/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon0gradients/conv2d_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@W_conv1*&
_output_shapes
: 
?
#train_step/update_b_conv1/ApplyAdam	ApplyAdamb_conv1b_conv1/train_stepb_conv1/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon-gradients/add_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@b_conv1*
_output_shapes
: 
?
#train_step/update_W_conv2/ApplyAdam	ApplyAdamW_conv2W_conv2/train_stepW_conv2/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon2gradients/conv2d_1_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@W_conv2*&
_output_shapes
: @
?
#train_step/update_b_conv2/ApplyAdam	ApplyAdamb_conv2b_conv2/train_stepb_conv2/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon/gradients/add_1_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@b_conv2*
_output_shapes
:@
?
!train_step/update_W_fc1/ApplyAdam	ApplyAdamW_fc1W_fc1/train_stepW_fc1/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon0gradients/MatMul_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class

loc:@W_fc1* 
_output_shapes
:
? ?
?
!train_step/update_b_fc1/ApplyAdam	ApplyAdamb_fc1b_fc1/train_stepb_fc1/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon/gradients/add_2_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class

loc:@b_fc1*
_output_shapes	
:?
?
!train_step/update_W_fc2/ApplyAdam	ApplyAdamW_fc2W_fc2/train_stepW_fc2/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon2gradients/MatMul_1_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class

loc:@W_fc2*
_output_shapes
:	?

?
!train_step/update_b_fc2/ApplyAdam	ApplyAdamb_fc2b_fc2/train_stepb_fc2/train_step_1beta1_power/readbeta2_power/readtrain_step/learning_ratetrain_step/beta1train_step/beta2train_step/epsilon8gradients/labels_predict_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class

loc:@b_fc2*
_output_shapes
:

?
train_step/mulMulbeta1_power/readtrain_step/beta1$^train_step/update_W_conv1/ApplyAdam$^train_step/update_b_conv1/ApplyAdam$^train_step/update_W_conv2/ApplyAdam$^train_step/update_b_conv2/ApplyAdam"^train_step/update_W_fc1/ApplyAdam"^train_step/update_b_fc1/ApplyAdam"^train_step/update_W_fc2/ApplyAdam"^train_step/update_b_fc2/ApplyAdam*
T0*
_class
loc:@W_conv1*
_output_shapes
: 
?
train_step/AssignAssignbeta1_powertrain_step/mul*
T0*
validate_shape(*
use_locking( *
_class
loc:@W_conv1*
_output_shapes
: 
?
train_step/mul_1Mulbeta2_power/readtrain_step/beta2$^train_step/update_W_conv1/ApplyAdam$^train_step/update_b_conv1/ApplyAdam$^train_step/update_W_conv2/ApplyAdam$^train_step/update_b_conv2/ApplyAdam"^train_step/update_W_fc1/ApplyAdam"^train_step/update_b_fc1/ApplyAdam"^train_step/update_W_fc2/ApplyAdam"^train_step/update_b_fc2/ApplyAdam*
T0*
_class
loc:@W_conv1*
_output_shapes
: 
?
train_step/Assign_1Assignbeta2_powertrain_step/mul_1*
T0*
validate_shape(*
use_locking( *
_class
loc:@W_conv1*
_output_shapes
: 
?

train_stepNoOp$^train_step/update_W_conv1/ApplyAdam$^train_step/update_b_conv1/ApplyAdam$^train_step/update_W_conv2/ApplyAdam$^train_step/update_b_conv2/ApplyAdam"^train_step/update_W_fc1/ApplyAdam"^train_step/update_b_fc1/ApplyAdam"^train_step/update_W_fc2/ApplyAdam"^train_step/update_b_fc2/ApplyAdam^train_step/Assign^train_step/Assign_1
R
ArgMax/dimensionConst*
value	B :*
dtype0*
_output_shapes
: 
d
ArgMaxArgMaxy_realArgMax/dimension*
T0*

Tidx0*#
_output_shapes
:?????????
T
ArgMax_1/dimensionConst*
value	B :*
dtype0*
_output_shapes
: 
p
ArgMax_1ArgMaxlabels_predictArgMax_1/dimension*
T0*

Tidx0*#
_output_shapes
:?????????
[
correct_predictionEqualArgMaxArgMax_1*
T0	*#
_output_shapes
:?????????
_
Cast_1Castcorrect_prediction*

SrcT0
*

DstT0*#
_output_shapes
:?????????
Q
Const_5Const*
valueB: *
dtype0*
_output_shapes
:
_
accuracyMeanCast_1Const_5*
	keep_dims( *
T0*

Tidx0*
_output_shapes
: 
?
initNoOp^W_conv1/Assign^b_conv1/Assign^W_conv2/Assign^b_conv2/Assign^W_fc1/Assign^b_fc1/Assign^W_fc2/Assign^b_fc2/Assign^beta1_power/Assign^beta2_power/Assign^W_conv1/train_step/Assign^W_conv1/train_step_1/Assign^b_conv1/train_step/Assign^b_conv1/train_step_1/Assign^W_conv2/train_step/Assign^W_conv2/train_step_1/Assign^b_conv2/train_step/Assign^b_conv2/train_step_1/Assign^W_fc1/train_step/Assign^W_fc1/train_step_1/Assign^b_fc1/train_step/Assign^b_fc1/train_step_1/Assign^W_fc2/train_step/Assign^W_fc2/train_step_1/Assign^b_fc2/train_step/Assign^b_fc2/train_step_1/Assign
P

save/ConstConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
?
save/StringJoin/inputs_1Const*<
value3B1 B+_temp_cb228f924be244b4aef28c500093e969/part*
dtype0*
_output_shapes
: 
u
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
N*
	separator *
_output_shapes
: 
Q
save/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
\
save/ShardedFilename/shardConst*
value	B : *
dtype0*
_output_shapes
: 
}
save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards*
_output_shapes
: 
?
save/SaveV2/tensor_namesConst*?
value?B?BW_conv1BW_conv1/train_stepBW_conv1/train_step_1BW_conv2BW_conv2/train_stepBW_conv2/train_step_1BW_fc1BW_fc1/train_stepBW_fc1/train_step_1BW_fc2BW_fc2/train_stepBW_fc2/train_step_1Bb_conv1Bb_conv1/train_stepBb_conv1/train_step_1Bb_conv2Bb_conv2/train_stepBb_conv2/train_step_1Bb_fc1Bb_fc1/train_stepBb_fc1/train_step_1Bb_fc2Bb_fc2/train_stepBb_fc2/train_step_1Bbeta1_powerBbeta2_power*
dtype0*
_output_shapes
:
?
save/SaveV2/shape_and_slicesConst*G
value>B<B B B B B B B B B B B B B B B B B B B B B B B B B B *
dtype0*
_output_shapes
:
?
save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesW_conv1W_conv1/train_stepW_conv1/train_step_1W_conv2W_conv2/train_stepW_conv2/train_step_1W_fc1W_fc1/train_stepW_fc1/train_step_1W_fc2W_fc2/train_stepW_fc2/train_step_1b_conv1b_conv1/train_stepb_conv1/train_step_1b_conv2b_conv2/train_stepb_conv2/train_step_1b_fc1b_fc1/train_stepb_fc1/train_step_1b_fc2b_fc2/train_stepb_fc2/train_step_1beta1_powerbeta2_power*(
dtypes
2
?
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2*
T0*'
_class
loc:@save/ShardedFilename*
_output_shapes
: 
?
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency*
N*
T0*

axis *
_output_shapes
:
}
save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const*
delete_old_dirs(
z
save/IdentityIdentity
save/Const^save/control_dependency^save/MergeV2Checkpoints*
T0*
_output_shapes
: 
k
save/RestoreV2/tensor_namesConst*
valueBBW_conv1*
dtype0*
_output_shapes
:
h
save/RestoreV2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/AssignAssignW_conv1save/RestoreV2*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
x
save/RestoreV2_1/tensor_namesConst*'
valueBBW_conv1/train_step*
dtype0*
_output_shapes
:
j
!save/RestoreV2_1/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_1	RestoreV2
save/Constsave/RestoreV2_1/tensor_names!save/RestoreV2_1/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_1AssignW_conv1/train_stepsave/RestoreV2_1*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
z
save/RestoreV2_2/tensor_namesConst*)
value BBW_conv1/train_step_1*
dtype0*
_output_shapes
:
j
!save/RestoreV2_2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_2	RestoreV2
save/Constsave/RestoreV2_2/tensor_names!save/RestoreV2_2/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_2AssignW_conv1/train_step_1save/RestoreV2_2*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
m
save/RestoreV2_3/tensor_namesConst*
valueBBW_conv2*
dtype0*
_output_shapes
:
j
!save/RestoreV2_3/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_3	RestoreV2
save/Constsave/RestoreV2_3/tensor_names!save/RestoreV2_3/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_3AssignW_conv2save/RestoreV2_3*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
x
save/RestoreV2_4/tensor_namesConst*'
valueBBW_conv2/train_step*
dtype0*
_output_shapes
:
j
!save/RestoreV2_4/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_4	RestoreV2
save/Constsave/RestoreV2_4/tensor_names!save/RestoreV2_4/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_4AssignW_conv2/train_stepsave/RestoreV2_4*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
z
save/RestoreV2_5/tensor_namesConst*)
value BBW_conv2/train_step_1*
dtype0*
_output_shapes
:
j
!save/RestoreV2_5/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_5	RestoreV2
save/Constsave/RestoreV2_5/tensor_names!save/RestoreV2_5/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_5AssignW_conv2/train_step_1save/RestoreV2_5*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
k
save/RestoreV2_6/tensor_namesConst*
valueBBW_fc1*
dtype0*
_output_shapes
:
j
!save/RestoreV2_6/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_6	RestoreV2
save/Constsave/RestoreV2_6/tensor_names!save/RestoreV2_6/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_6AssignW_fc1save/RestoreV2_6*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
v
save/RestoreV2_7/tensor_namesConst*%
valueBBW_fc1/train_step*
dtype0*
_output_shapes
:
j
!save/RestoreV2_7/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_7	RestoreV2
save/Constsave/RestoreV2_7/tensor_names!save/RestoreV2_7/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_7AssignW_fc1/train_stepsave/RestoreV2_7*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
x
save/RestoreV2_8/tensor_namesConst*'
valueBBW_fc1/train_step_1*
dtype0*
_output_shapes
:
j
!save/RestoreV2_8/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_8	RestoreV2
save/Constsave/RestoreV2_8/tensor_names!save/RestoreV2_8/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_8AssignW_fc1/train_step_1save/RestoreV2_8*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
k
save/RestoreV2_9/tensor_namesConst*
valueBBW_fc2*
dtype0*
_output_shapes
:
j
!save/RestoreV2_9/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_9	RestoreV2
save/Constsave/RestoreV2_9/tensor_names!save/RestoreV2_9/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_9AssignW_fc2save/RestoreV2_9*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

w
save/RestoreV2_10/tensor_namesConst*%
valueBBW_fc2/train_step*
dtype0*
_output_shapes
:
k
"save/RestoreV2_10/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_10	RestoreV2
save/Constsave/RestoreV2_10/tensor_names"save/RestoreV2_10/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_10AssignW_fc2/train_stepsave/RestoreV2_10*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

y
save/RestoreV2_11/tensor_namesConst*'
valueBBW_fc2/train_step_1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_11/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_11	RestoreV2
save/Constsave/RestoreV2_11/tensor_names"save/RestoreV2_11/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_11AssignW_fc2/train_step_1save/RestoreV2_11*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

n
save/RestoreV2_12/tensor_namesConst*
valueBBb_conv1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_12/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_12	RestoreV2
save/Constsave/RestoreV2_12/tensor_names"save/RestoreV2_12/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_12Assignb_conv1save/RestoreV2_12*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
y
save/RestoreV2_13/tensor_namesConst*'
valueBBb_conv1/train_step*
dtype0*
_output_shapes
:
k
"save/RestoreV2_13/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_13	RestoreV2
save/Constsave/RestoreV2_13/tensor_names"save/RestoreV2_13/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_13Assignb_conv1/train_stepsave/RestoreV2_13*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
{
save/RestoreV2_14/tensor_namesConst*)
value BBb_conv1/train_step_1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_14/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_14	RestoreV2
save/Constsave/RestoreV2_14/tensor_names"save/RestoreV2_14/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_14Assignb_conv1/train_step_1save/RestoreV2_14*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
n
save/RestoreV2_15/tensor_namesConst*
valueBBb_conv2*
dtype0*
_output_shapes
:
k
"save/RestoreV2_15/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_15	RestoreV2
save/Constsave/RestoreV2_15/tensor_names"save/RestoreV2_15/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_15Assignb_conv2save/RestoreV2_15*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
y
save/RestoreV2_16/tensor_namesConst*'
valueBBb_conv2/train_step*
dtype0*
_output_shapes
:
k
"save/RestoreV2_16/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_16	RestoreV2
save/Constsave/RestoreV2_16/tensor_names"save/RestoreV2_16/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_16Assignb_conv2/train_stepsave/RestoreV2_16*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
{
save/RestoreV2_17/tensor_namesConst*)
value BBb_conv2/train_step_1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_17/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_17	RestoreV2
save/Constsave/RestoreV2_17/tensor_names"save/RestoreV2_17/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_17Assignb_conv2/train_step_1save/RestoreV2_17*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
l
save/RestoreV2_18/tensor_namesConst*
valueBBb_fc1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_18/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_18	RestoreV2
save/Constsave/RestoreV2_18/tensor_names"save/RestoreV2_18/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_18Assignb_fc1save/RestoreV2_18*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
w
save/RestoreV2_19/tensor_namesConst*%
valueBBb_fc1/train_step*
dtype0*
_output_shapes
:
k
"save/RestoreV2_19/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_19	RestoreV2
save/Constsave/RestoreV2_19/tensor_names"save/RestoreV2_19/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_19Assignb_fc1/train_stepsave/RestoreV2_19*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
y
save/RestoreV2_20/tensor_namesConst*'
valueBBb_fc1/train_step_1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_20/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_20	RestoreV2
save/Constsave/RestoreV2_20/tensor_names"save/RestoreV2_20/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_20Assignb_fc1/train_step_1save/RestoreV2_20*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
l
save/RestoreV2_21/tensor_namesConst*
valueBBb_fc2*
dtype0*
_output_shapes
:
k
"save/RestoreV2_21/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_21	RestoreV2
save/Constsave/RestoreV2_21/tensor_names"save/RestoreV2_21/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_21Assignb_fc2save/RestoreV2_21*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

w
save/RestoreV2_22/tensor_namesConst*%
valueBBb_fc2/train_step*
dtype0*
_output_shapes
:
k
"save/RestoreV2_22/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_22	RestoreV2
save/Constsave/RestoreV2_22/tensor_names"save/RestoreV2_22/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_22Assignb_fc2/train_stepsave/RestoreV2_22*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

y
save/RestoreV2_23/tensor_namesConst*'
valueBBb_fc2/train_step_1*
dtype0*
_output_shapes
:
k
"save/RestoreV2_23/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_23	RestoreV2
save/Constsave/RestoreV2_23/tensor_names"save/RestoreV2_23/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_23Assignb_fc2/train_step_1save/RestoreV2_23*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

r
save/RestoreV2_24/tensor_namesConst* 
valueBBbeta1_power*
dtype0*
_output_shapes
:
k
"save/RestoreV2_24/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_24	RestoreV2
save/Constsave/RestoreV2_24/tensor_names"save/RestoreV2_24/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_24Assignbeta1_powersave/RestoreV2_24*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*
_output_shapes
: 
r
save/RestoreV2_25/tensor_namesConst* 
valueBBbeta2_power*
dtype0*
_output_shapes
:
k
"save/RestoreV2_25/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save/RestoreV2_25	RestoreV2
save/Constsave/RestoreV2_25/tensor_names"save/RestoreV2_25/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save/Assign_25Assignbeta2_powersave/RestoreV2_25*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*
_output_shapes
: 
?
save/restore_shardNoOp^save/Assign^save/Assign_1^save/Assign_2^save/Assign_3^save/Assign_4^save/Assign_5^save/Assign_6^save/Assign_7^save/Assign_8^save/Assign_9^save/Assign_10^save/Assign_11^save/Assign_12^save/Assign_13^save/Assign_14^save/Assign_15^save/Assign_16^save/Assign_17^save/Assign_18^save/Assign_19^save/Assign_20^save/Assign_21^save/Assign_22^save/Assign_23^save/Assign_24^save/Assign_25
-
save/restore_allNoOp^save/restore_shard
R
save_1/ConstConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
?
save_1/StringJoin/inputs_1Const*<
value3B1 B+_temp_279e346114324739882ecdf8df40df84/part*
dtype0*
_output_shapes
: 
{
save_1/StringJoin
StringJoinsave_1/Constsave_1/StringJoin/inputs_1*
N*
	separator *
_output_shapes
: 
S
save_1/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
^
save_1/ShardedFilename/shardConst*
value	B : *
dtype0*
_output_shapes
: 
?
save_1/ShardedFilenameShardedFilenamesave_1/StringJoinsave_1/ShardedFilename/shardsave_1/num_shards*
_output_shapes
: 
?
save_1/SaveV2/tensor_namesConst*?
value?B?BW_conv1BW_conv1/train_stepBW_conv1/train_step_1BW_conv2BW_conv2/train_stepBW_conv2/train_step_1BW_fc1BW_fc1/train_stepBW_fc1/train_step_1BW_fc2BW_fc2/train_stepBW_fc2/train_step_1Bb_conv1Bb_conv1/train_stepBb_conv1/train_step_1Bb_conv2Bb_conv2/train_stepBb_conv2/train_step_1Bb_fc1Bb_fc1/train_stepBb_fc1/train_step_1Bb_fc2Bb_fc2/train_stepBb_fc2/train_step_1Bbeta1_powerBbeta2_power*
dtype0*
_output_shapes
:
?
save_1/SaveV2/shape_and_slicesConst*G
value>B<B B B B B B B B B B B B B B B B B B B B B B B B B B *
dtype0*
_output_shapes
:
?
save_1/SaveV2SaveV2save_1/ShardedFilenamesave_1/SaveV2/tensor_namessave_1/SaveV2/shape_and_slicesW_conv1W_conv1/train_stepW_conv1/train_step_1W_conv2W_conv2/train_stepW_conv2/train_step_1W_fc1W_fc1/train_stepW_fc1/train_step_1W_fc2W_fc2/train_stepW_fc2/train_step_1b_conv1b_conv1/train_stepb_conv1/train_step_1b_conv2b_conv2/train_stepb_conv2/train_step_1b_fc1b_fc1/train_stepb_fc1/train_step_1b_fc2b_fc2/train_stepb_fc2/train_step_1beta1_powerbeta2_power*(
dtypes
2
?
save_1/control_dependencyIdentitysave_1/ShardedFilename^save_1/SaveV2*
T0*)
_class
loc:@save_1/ShardedFilename*
_output_shapes
: 
?
-save_1/MergeV2Checkpoints/checkpoint_prefixesPacksave_1/ShardedFilename^save_1/control_dependency*
N*
T0*

axis *
_output_shapes
:
?
save_1/MergeV2CheckpointsMergeV2Checkpoints-save_1/MergeV2Checkpoints/checkpoint_prefixessave_1/Const*
delete_old_dirs(
?
save_1/IdentityIdentitysave_1/Const^save_1/control_dependency^save_1/MergeV2Checkpoints*
T0*
_output_shapes
: 
m
save_1/RestoreV2/tensor_namesConst*
valueBBW_conv1*
dtype0*
_output_shapes
:
j
!save_1/RestoreV2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2	RestoreV2save_1/Constsave_1/RestoreV2/tensor_names!save_1/RestoreV2/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/AssignAssignW_conv1save_1/RestoreV2*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
z
save_1/RestoreV2_1/tensor_namesConst*'
valueBBW_conv1/train_step*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_1/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_1	RestoreV2save_1/Constsave_1/RestoreV2_1/tensor_names#save_1/RestoreV2_1/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_1AssignW_conv1/train_stepsave_1/RestoreV2_1*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
|
save_1/RestoreV2_2/tensor_namesConst*)
value BBW_conv1/train_step_1*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_2/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_2	RestoreV2save_1/Constsave_1/RestoreV2_2/tensor_names#save_1/RestoreV2_2/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_2AssignW_conv1/train_step_1save_1/RestoreV2_2*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*&
_output_shapes
: 
o
save_1/RestoreV2_3/tensor_namesConst*
valueBBW_conv2*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_3/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_3	RestoreV2save_1/Constsave_1/RestoreV2_3/tensor_names#save_1/RestoreV2_3/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_3AssignW_conv2save_1/RestoreV2_3*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
z
save_1/RestoreV2_4/tensor_namesConst*'
valueBBW_conv2/train_step*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_4/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_4	RestoreV2save_1/Constsave_1/RestoreV2_4/tensor_names#save_1/RestoreV2_4/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_4AssignW_conv2/train_stepsave_1/RestoreV2_4*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
|
save_1/RestoreV2_5/tensor_namesConst*)
value BBW_conv2/train_step_1*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_5/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_5	RestoreV2save_1/Constsave_1/RestoreV2_5/tensor_names#save_1/RestoreV2_5/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_5AssignW_conv2/train_step_1save_1/RestoreV2_5*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv2*&
_output_shapes
: @
m
save_1/RestoreV2_6/tensor_namesConst*
valueBBW_fc1*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_6/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_6	RestoreV2save_1/Constsave_1/RestoreV2_6/tensor_names#save_1/RestoreV2_6/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_6AssignW_fc1save_1/RestoreV2_6*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
x
save_1/RestoreV2_7/tensor_namesConst*%
valueBBW_fc1/train_step*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_7/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_7	RestoreV2save_1/Constsave_1/RestoreV2_7/tensor_names#save_1/RestoreV2_7/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_7AssignW_fc1/train_stepsave_1/RestoreV2_7*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
z
save_1/RestoreV2_8/tensor_namesConst*'
valueBBW_fc1/train_step_1*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_8/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_8	RestoreV2save_1/Constsave_1/RestoreV2_8/tensor_names#save_1/RestoreV2_8/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_8AssignW_fc1/train_step_1save_1/RestoreV2_8*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc1* 
_output_shapes
:
? ?
m
save_1/RestoreV2_9/tensor_namesConst*
valueBBW_fc2*
dtype0*
_output_shapes
:
l
#save_1/RestoreV2_9/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_9	RestoreV2save_1/Constsave_1/RestoreV2_9/tensor_names#save_1/RestoreV2_9/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_9AssignW_fc2save_1/RestoreV2_9*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

y
 save_1/RestoreV2_10/tensor_namesConst*%
valueBBW_fc2/train_step*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_10/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_10	RestoreV2save_1/Const save_1/RestoreV2_10/tensor_names$save_1/RestoreV2_10/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_10AssignW_fc2/train_stepsave_1/RestoreV2_10*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

{
 save_1/RestoreV2_11/tensor_namesConst*'
valueBBW_fc2/train_step_1*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_11/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_11	RestoreV2save_1/Const save_1/RestoreV2_11/tensor_names$save_1/RestoreV2_11/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_11AssignW_fc2/train_step_1save_1/RestoreV2_11*
T0*
validate_shape(*
use_locking(*
_class

loc:@W_fc2*
_output_shapes
:	?

p
 save_1/RestoreV2_12/tensor_namesConst*
valueBBb_conv1*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_12/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_12	RestoreV2save_1/Const save_1/RestoreV2_12/tensor_names$save_1/RestoreV2_12/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_12Assignb_conv1save_1/RestoreV2_12*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
{
 save_1/RestoreV2_13/tensor_namesConst*'
valueBBb_conv1/train_step*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_13/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_13	RestoreV2save_1/Const save_1/RestoreV2_13/tensor_names$save_1/RestoreV2_13/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_13Assignb_conv1/train_stepsave_1/RestoreV2_13*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
}
 save_1/RestoreV2_14/tensor_namesConst*)
value BBb_conv1/train_step_1*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_14/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_14	RestoreV2save_1/Const save_1/RestoreV2_14/tensor_names$save_1/RestoreV2_14/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_14Assignb_conv1/train_step_1save_1/RestoreV2_14*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv1*
_output_shapes
: 
p
 save_1/RestoreV2_15/tensor_namesConst*
valueBBb_conv2*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_15/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_15	RestoreV2save_1/Const save_1/RestoreV2_15/tensor_names$save_1/RestoreV2_15/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_15Assignb_conv2save_1/RestoreV2_15*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
{
 save_1/RestoreV2_16/tensor_namesConst*'
valueBBb_conv2/train_step*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_16/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_16	RestoreV2save_1/Const save_1/RestoreV2_16/tensor_names$save_1/RestoreV2_16/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_16Assignb_conv2/train_stepsave_1/RestoreV2_16*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
}
 save_1/RestoreV2_17/tensor_namesConst*)
value BBb_conv2/train_step_1*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_17/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_17	RestoreV2save_1/Const save_1/RestoreV2_17/tensor_names$save_1/RestoreV2_17/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_17Assignb_conv2/train_step_1save_1/RestoreV2_17*
T0*
validate_shape(*
use_locking(*
_class
loc:@b_conv2*
_output_shapes
:@
n
 save_1/RestoreV2_18/tensor_namesConst*
valueBBb_fc1*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_18/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_18	RestoreV2save_1/Const save_1/RestoreV2_18/tensor_names$save_1/RestoreV2_18/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_18Assignb_fc1save_1/RestoreV2_18*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
y
 save_1/RestoreV2_19/tensor_namesConst*%
valueBBb_fc1/train_step*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_19/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_19	RestoreV2save_1/Const save_1/RestoreV2_19/tensor_names$save_1/RestoreV2_19/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_19Assignb_fc1/train_stepsave_1/RestoreV2_19*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
{
 save_1/RestoreV2_20/tensor_namesConst*'
valueBBb_fc1/train_step_1*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_20/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_20	RestoreV2save_1/Const save_1/RestoreV2_20/tensor_names$save_1/RestoreV2_20/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_20Assignb_fc1/train_step_1save_1/RestoreV2_20*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc1*
_output_shapes	
:?
n
 save_1/RestoreV2_21/tensor_namesConst*
valueBBb_fc2*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_21/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_21	RestoreV2save_1/Const save_1/RestoreV2_21/tensor_names$save_1/RestoreV2_21/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_21Assignb_fc2save_1/RestoreV2_21*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

y
 save_1/RestoreV2_22/tensor_namesConst*%
valueBBb_fc2/train_step*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_22/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_22	RestoreV2save_1/Const save_1/RestoreV2_22/tensor_names$save_1/RestoreV2_22/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_22Assignb_fc2/train_stepsave_1/RestoreV2_22*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

{
 save_1/RestoreV2_23/tensor_namesConst*'
valueBBb_fc2/train_step_1*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_23/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_23	RestoreV2save_1/Const save_1/RestoreV2_23/tensor_names$save_1/RestoreV2_23/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_23Assignb_fc2/train_step_1save_1/RestoreV2_23*
T0*
validate_shape(*
use_locking(*
_class

loc:@b_fc2*
_output_shapes
:

t
 save_1/RestoreV2_24/tensor_namesConst* 
valueBBbeta1_power*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_24/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_24	RestoreV2save_1/Const save_1/RestoreV2_24/tensor_names$save_1/RestoreV2_24/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_24Assignbeta1_powersave_1/RestoreV2_24*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*
_output_shapes
: 
t
 save_1/RestoreV2_25/tensor_namesConst* 
valueBBbeta2_power*
dtype0*
_output_shapes
:
m
$save_1/RestoreV2_25/shape_and_slicesConst*
valueB
B *
dtype0*
_output_shapes
:
?
save_1/RestoreV2_25	RestoreV2save_1/Const save_1/RestoreV2_25/tensor_names$save_1/RestoreV2_25/shape_and_slices*
dtypes
2*
_output_shapes
:
?
save_1/Assign_25Assignbeta2_powersave_1/RestoreV2_25*
T0*
validate_shape(*
use_locking(*
_class
loc:@W_conv1*
_output_shapes
: 
?
save_1/restore_shardNoOp^save_1/Assign^save_1/Assign_1^save_1/Assign_2^save_1/Assign_3^save_1/Assign_4^save_1/Assign_5^save_1/Assign_6^save_1/Assign_7^save_1/Assign_8^save_1/Assign_9^save_1/Assign_10^save_1/Assign_11^save_1/Assign_12^save_1/Assign_13^save_1/Assign_14^save_1/Assign_15^save_1/Assign_16^save_1/Assign_17^save_1/Assign_18^save_1/Assign_19^save_1/Assign_20^save_1/Assign_21^save_1/Assign_22^save_1/Assign_23^save_1/Assign_24^save_1/Assign_25
1
save_1/restore_allNoOp^save_1/restore_shard"B
save_1/Const:0save_1/Identity:0save_1/restore_all (5 @F8"?
	variables??
+
	W_conv1:0W_conv1/AssignW_conv1/read:0
+
	b_conv1:0b_conv1/Assignb_conv1/read:0
+
	W_conv2:0W_conv2/AssignW_conv2/read:0
+
	b_conv2:0b_conv2/Assignb_conv2/read:0
%
W_fc1:0W_fc1/AssignW_fc1/read:0
%
b_fc1:0b_fc1/Assignb_fc1/read:0
%
W_fc2:0W_fc2/AssignW_fc2/read:0
%
b_fc2:0b_fc2/Assignb_fc2/read:0
7
beta1_power:0beta1_power/Assignbeta1_power/read:0
7
beta2_power:0beta2_power/Assignbeta2_power/read:0
L
W_conv1/train_step:0W_conv1/train_step/AssignW_conv1/train_step/read:0
R
W_conv1/train_step_1:0W_conv1/train_step_1/AssignW_conv1/train_step_1/read:0
L
b_conv1/train_step:0b_conv1/train_step/Assignb_conv1/train_step/read:0
R
b_conv1/train_step_1:0b_conv1/train_step_1/Assignb_conv1/train_step_1/read:0
L
W_conv2/train_step:0W_conv2/train_step/AssignW_conv2/train_step/read:0
R
W_conv2/train_step_1:0W_conv2/train_step_1/AssignW_conv2/train_step_1/read:0
L
b_conv2/train_step:0b_conv2/train_step/Assignb_conv2/train_step/read:0
R
b_conv2/train_step_1:0b_conv2/train_step_1/Assignb_conv2/train_step_1/read:0
F
W_fc1/train_step:0W_fc1/train_step/AssignW_fc1/train_step/read:0
L
W_fc1/train_step_1:0W_fc1/train_step_1/AssignW_fc1/train_step_1/read:0
F
b_fc1/train_step:0b_fc1/train_step/Assignb_fc1/train_step/read:0
L
b_fc1/train_step_1:0b_fc1/train_step_1/Assignb_fc1/train_step_1/read:0
F
W_fc2/train_step:0W_fc2/train_step/AssignW_fc2/train_step/read:0
L
W_fc2/train_step_1:0W_fc2/train_step_1/AssignW_fc2/train_step_1/read:0
F
b_fc2/train_step:0b_fc2/train_step/Assignb_fc2/train_step/read:0
L
b_fc2/train_step_1:0b_fc2/train_step_1/Assignb_fc2/train_step_1/read:0"?
trainable_variables??
+
	W_conv1:0W_conv1/AssignW_conv1/read:0
+
	b_conv1:0b_conv1/Assignb_conv1/read:0
+
	W_conv2:0W_conv2/AssignW_conv2/read:0
+
	b_conv2:0b_conv2/Assignb_conv2/read:0
%
W_fc1:0W_fc1/AssignW_fc1/read:0
%
b_fc1:0b_fc1/Assignb_fc1/read:0
%
W_fc2:0W_fc2/AssignW_fc2/read:0
%
b_fc2:0b_fc2/Assignb_fc2/read:0"
train_op


train_step