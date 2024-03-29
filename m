Return-Path: <linux-nfs+bounces-2562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E189201F
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 16:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5942F288DD7
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Mar 2024 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AD314BFA7;
	Fri, 29 Mar 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B3qmyFOV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kpNrXVA4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7B14BF9F
	for <linux-nfs@vger.kernel.org>; Fri, 29 Mar 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724166; cv=fail; b=mlbteU70pxc6/4mTlI535c1AL9To2QlwpBTdUn6+asq9Nj+fWWz87+4xDBIfI87qcuLH+H4p29L/am6zUgrImee5syqBu+l4LP/A2jqlAFuotIUkwo6UiB5bzeJivwKJ77X9xyU3xV0E3Lt5lBjv2Wbz4uI9soVuFlbxfpElSFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724166; c=relaxed/simple;
	bh=MXHe74dUcFNcrLjBw6XlKUm8AxFIhJiCcHQPwrd3mdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=odsPqjJXEa1teEV3dfdZX4M5dpyIJcvmg9BPoAjZg8T0tanHzQwNoKFi56PAQ9lUMSXYK1JqEHQU7X2CY15LpdglEJuvzLYWk9vKg49JAwvoIi8AMvFMOJujfX1joRXvULoD+Mm1qvTxpms2XMRJH2iSL1F3zIljPlxgW4qct/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B3qmyFOV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kpNrXVA4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42T0PlPB020173;
	Fri, 29 Mar 2024 14:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=lqo6d37Rvvp/zPxAPjTu13cL4D/LwmmfjwuppjOcfAY=;
 b=B3qmyFOV0QoeyI2lw1KD++NAE5xc9aJjIUb1z6cAN7H5l/uBqKuNp/+OHqFxWUSHCCuY
 HcO7x6HzBh7ytYbcSaaLFEmg8yy1gi9M2y513JM7Xk9zTaBndyGQQGOkP9EFaS9INWX3
 RoStrsuQk9ZM4MkTJhExqjIJQcwSFuKXCLsTq3OqvrWXorM10GeIe8XRNThQwji2k4DK
 DSqBVjKz/VoD0hfaoGcbWeoiMJBax8dqunoCOS220FTYithue34F1bsXN9/ZL2lBBv5l
 BHyDqPRlDJbA9ErkqsvS2KORJqGaA1jvMgGdTOHRmy3D3/712ocAHymv/SBpgsGoYuP4 ZA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ctb4jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 14:56:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42TDdTeO008809;
	Fri, 29 Mar 2024 14:56:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhbtd1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 14:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aitelSBvrsB6ODOjNrSbcJ3GhHXVOZ/AK3u8F+C9SyRrN/T1+vlHLYYite4GjANz3Llw2uQj3lD+d+fQRjtK6KU5qfuc2/pNFGK/iFxU8c3VEqI81t9hO8K8QYqPuxLiJk4bIZTiPJrw72xXEOScN+tPVQ40YsohJQS+RkHuPfHiQS0SO4AgTyvhtO18JUT/tgHiOwkxuRgJIW+ONHx47MeGOR85M2iFx0bD2RK58ktMWk7TpPibny5+oraoIHMnfh/Ysqg+MlrykrlVw9vv9Mkde1o8rMOWH/C99G3nDeZnf9Z3LEzTmZcegllsGbWU9j/qLz5gVRV9uaNeMNsf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqo6d37Rvvp/zPxAPjTu13cL4D/LwmmfjwuppjOcfAY=;
 b=lzYv/ELqELjdVYM8RE9fQ1YM2Twxz5qyjox6WbdjoB6P+wSWHrv0DvVH6bNoHpH9/eQyJDyXKSMnc3EPW/P/IDBW6+uuEInBPvHvOrsOeOngnSpEuZxhAw1bzS3S74DuEhU7MQR5lifpiTr9mEOTm7ezJTfuniBKYuI3epvAifgmQFb4JR7ceG00smYoUHmBRAuhdblFoS36mUQ2kUkItarryMpIT16oDbt80f0s731AfUaXKG/i14C316mzfY7VSibon1ehteyILfk6BFeiD8GneuxfEJWcHUnh8SjO7mM36IwDxhABFIvJa/GgPO3w382EqjAiMK+5yy78UvOoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqo6d37Rvvp/zPxAPjTu13cL4D/LwmmfjwuppjOcfAY=;
 b=kpNrXVA4xj3ZjfaJqNFLEOlXZFr9XFfEf39b0w348Om4HvJZynF6dOxzuwRkZjK2A2ja5fP0kIOt7yOq0MfXqPNJ9zA66sPCMv2g/Vgj4n91SrslXOkM/s1sZtuhQJvfywcl688KBGWqKRuJ3Sy7aEyFO6OWmaLojrryKPWGqJw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5870.namprd10.prod.outlook.com (2603:10b6:510:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Fri, 29 Mar
 2024 14:55:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 14:55:57 +0000
Date: Fri, 29 Mar 2024 10:55:54 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Message-ID: <ZgbWevtNp8Vust4A@tissot.1015granger.net>
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
 <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
 <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
 <ZgV5zwR0q/vjBAtI@tissot.1015granger.net>
 <88fac8af-c194-452b-94eb-7658b9056246@oracle.com>
 <c97be8b9-c0ba-4f2d-9340-78368008ba4b@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c97be8b9-c0ba-4f2d-9340-78368008ba4b@oracle.com>
X-ClientProxiedBy: CH2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:610:4f::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5870:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BTfAEpRoUVIssxrQKSAOj3T4LFFQHIr+XrFFE2V3yLjS5slSdutaoMnVnIKK48YpvbxecQBwF2UOQJ2ysWGq8TwwsUM0E7NnD1d52oS+HthYAbsYPtNiZyzlOeQCYpOAAh5yKgtO+Zxw94mWxXKn9d3yupIfyudSViui/lle0bu9/YCYCdKn6T2VSy4qhUtmBk+0Qo5nT6HUxtFHItKLj5t0DLcYlAaPyocfvPLRCkNusJW1BXfadkJOnLGtAoXm2TM7JEFHZzFjA9OdYTAWMsEaLKlbrWAsZYlX+5cWRRlk/tJkkihQip/2qTRrzPJWya800cigduv5BiiyeIHkeNMh8RnRtUekmCZJVuS1K/IDOS10QXv7E6YhwaC2VXGPtnnlCna1CwohrT6ljaP3fC7I9dMt20Eslwk4x8ZlURqyHJZ4e3Dsw9ja3lukmq5IpZ5ZEERZlJIXtRlfrvDsPciZ7RroDGswlmbOaO59/Mj0b6yWVTG3NPRxfffvQzgnjuQd+r/1AsMbs5HT7Y0KZvmHlnIktz906CnAZoeDD61a6Dmfpqw9Mj2OseiCbauwyUckZf7MXgA6sWLbrKPVIQmRkUrcrwXY+pngqhaAkQU5/vuLlC1bFSlgz65ALLjgdomSbnlYZSEzB/QR6+OQJ7ns5c6yypn1iU5FCtxrFJo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4vKiUVPRaqOtzoDC8pE+pZjvbhDCt2E/k7cB90pMFhsqGrDnJmG1vElmfatn?=
 =?us-ascii?Q?LrwfgQzrsSZU5QMWd2LF/EhFTlciNTIBrhTbt71AXHgPIxX5NpHzcEQ8zA27?=
 =?us-ascii?Q?mKk7dw72cwEF6n9pXDuOo+uAWNVCSWy9D9POAyWxZo+Fm3OXJD0kXEX9KpX/?=
 =?us-ascii?Q?wqvmsslLUccwwguonYXmsgseZ9G2jakjc2u3/weLS2PAQl2fGl95K7XO1ALK?=
 =?us-ascii?Q?F6uUIYrSdGCZdXNvkwZHkxpJWBUv8omBI0XEMIX9R2FErc7xamjAoimJRsvt?=
 =?us-ascii?Q?abiQoqCFfgY16WAWoUE9LakwLQZGRg5hbLfFgdooBXYGYDvpkDMeAhlwxCJA?=
 =?us-ascii?Q?vomDYzTMZWty2CR8tUkn5DIRaqyV4sV93lHwgZRhEOWvlODC9G0HKFIg4GAW?=
 =?us-ascii?Q?eY7+Uegh+Ge6VcW/EZb4E32+S7TM30tDgdl3df84Lwx1Jm8LZPys8icaM4/T?=
 =?us-ascii?Q?yP36VzpAsZLWSwfk4v5vozKOI+SHWf01mGsiaTUtNEAIwHXPs7e0V0s8lhgI?=
 =?us-ascii?Q?ab1YLxzc4qYpHm9N0iA3qME5MpzaweU50KBXMnqcIWJiGeSxFase8AEmCCjE?=
 =?us-ascii?Q?6evISTqjZMwx4o8S8QxDq5pM23zsUyxNtnX/MM8wNt+NvohET+5HVJwT7fQV?=
 =?us-ascii?Q?XSHW3O+PKbajevq9fJ0Nw2sdXiv5+sujd44GPIJ2Wym6plj7zCkqRZVtrnhT?=
 =?us-ascii?Q?n18jEewPstSthNEKKNqL+LpBLPAEu8n6aSnQ5hrDCOQ6rptoNlHn6zFMzg9i?=
 =?us-ascii?Q?wv6KeQp0Fg7RlHA6LsoL3IWvu1Rt3CeMtYQHkyW1AvN89Znby0gq5ZpJnrN5?=
 =?us-ascii?Q?yIze5XhK/pKSh9Y/i6kSBrJTcoqBtP2KdPh4Mo4KrnMOS+y2EMA+o/YvR5PQ?=
 =?us-ascii?Q?4MH7KdNQqR/ORlJysB3G5xDJTM0txOccOTGsNysvEIQ++oPuTn4mAcZfks9/?=
 =?us-ascii?Q?ax/fmx6hnb3kLKdFPsizspXICbPDpizc8vBULv2DQaWCFErnK1gmPr9DDzTg?=
 =?us-ascii?Q?zsLwUPubeeGA6uA8mbMRxZVfPIDXXwfzxCzbI7xPYG/EaJR018ZohaX6D2et?=
 =?us-ascii?Q?YXN8/nqfueHiWwVDHrFTQgA6HCcPoTv3TUJIcIgWEwQ4c0BpTsq3oCsvh5Q1?=
 =?us-ascii?Q?1wU+hZ3vD7gI9ClVCOcOr904CBV6cieOLfJV6wLPnpJrFj67FlVVXP7ZsVku?=
 =?us-ascii?Q?wVKofOXfeiFiMbCwHaI3bilr2Nj2zs2b/PnGVwMX/o7g/Qsia+mlmyCTead2?=
 =?us-ascii?Q?pX0nSJxTwtHMop6v1uRNMn2VKAn6hib/035tTD0zK7gY/xMnxQ5eYSNNtMkx?=
 =?us-ascii?Q?y22k9+vlB/GyNikyxHL6b7G2LHeoX7bkK4hSZngbSXuB5vKOP7c/j+H/FNP0?=
 =?us-ascii?Q?OmGlFPJ1x4LjWeBL5/vk5x7c9ngySIZECt18MPjRQK0yd9v274QZb4pPSu65?=
 =?us-ascii?Q?1/rwGSm/KNWVEZ4k5VAiwC7U2ErYsZXjHuFC78MQ2w3CT9mxEhSVCNs0865Z?=
 =?us-ascii?Q?7hpoCkUiZC6Lb/hUtKmtQYZVJS78cCAIYxWF5kT3zFVfDeqYM3rVIMtowiTn?=
 =?us-ascii?Q?C9EdNd02+FiEgpRrWS/MAX5ouZosd+qdX0p+f+rZzmBl6K4ij+9XNd/CKBCl?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XpoveokdhQZOxDWSLdYC4Q93TBCgsKqqrWIda+aGJGXfpnNXQ228PG+/XtPcOOai65sNBqb/CH3s5AEAHyezFC/kDlMV5pxZoBO9IDnnRY5G+Yn3Q4JOyGgM3II753XDpUKhAonLaFCQJ2DEr0r/T6uOMHgCNuiZL3UU0Gb9WZubzYYxRkMSa5PjvxH0ea8YMKz6gwBrXk9nibZcp46J45Q0uYlQy6W6mWZXDdMgzcbAPkTZWde4V2ypuAW2+R+Cjy8eWdq4ldDvu57qpaGTjOoaDypL5bCV82B3ilDpbfE2lVhIJ2WqOcchGnEDaVscagOBGfU2tYCmQZnvakJVM+SFPUOADzrgBHPtFiCpbOF7nEXmh3rOgQf4l45mgQdF4McOC5yLkjQfbZE13eXfm7DgSBRSVyuV5Cjr8P8vqCpXRwCwjkrWseWCChuyhKWXqNFXSVJQ/2kU9p3DTnw01Kzp6oPacAtdsk/F/aiQ33nnJxTusxORSkIqVbocT89QszQT1ATsYzY7MTO4nwzZNRLpJfxcI1+1W7qD9SiLIsMPRam9hmIzJR9mtGi7DafNbRkUiJi85t8VSKJUQd66KRBgrzJi70E3P5zq++Ze77s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01475e2-a6bb-40ee-4094-08dc50005774
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 14:55:57.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmbbNj31MdkNHV6+qmJwRC/WsG+7c9UMuSEuq0u7WYbgY6kA1m8e2KRNQzjtrCcYG0j4AK/YG5EXALb7n4Ogbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290131
X-Proofpoint-GUID: bmIwhbAOQ4WwbUqG3Lb9xcTrpo0xdWUb
X-Proofpoint-ORIG-GUID: bmIwhbAOQ4WwbUqG3Lb9xcTrpo0xdWUb

On Thu, Mar 28, 2024 at 05:31:02PM -0700, Dai Ngo wrote:
> 
> On 3/28/24 11:14 AM, Dai Ngo wrote:
> > 
> > On 3/28/24 7:08 AM, Chuck Lever wrote:
> > > On Wed, Mar 27, 2024 at 06:09:28PM -0700, Dai Ngo wrote:
> > > > On 3/26/24 11:27 AM, Chuck Lever wrote:
> > > > > On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wrote:
> > > > > > Currently when a nfs4_client is destroyed we wait for
> > > > > > the cb_recall_any
> > > > > > callback to complete before proceed. This adds
> > > > > > unnecessary delay to the
> > > > > > __destroy_client call if there is problem communicating
> > > > > > with the client.
> > > > > By "unnecessary delay" do you mean only the seven-second RPC
> > > > > retransmit timeout, or is there something else?
> > > > when the client network interface is down, the RPC task takes ~9s to
> > > > send the callback, waits for the reply and gets ETIMEDOUT. This process
> > > > repeats in a loop with the same RPC task before being stopped by
> > > > rpc_shutdown_client after client lease expires.
> > > I'll have to review this code again, but rpc_shutdown_client
> > > should cause these RPCs to terminate immediately and safely. Can't
> > > we use that?
> > 
> > rpc_shutdown_client works, it terminated the RPC call to stop the loop.
> > 
> > > 
> > > 
> > > > It takes a total of about 1m20s before the CB_RECALL is terminated.
> > > > For CB_RECALL_ANY and CB_OFFLOAD, this process gets in to a infinite
> > > > loop since there is no delegation conflict and the client is allowed
> > > > to stay in courtesy state.
> > > > 
> > > > The loop happens because in nfsd4_cb_sequence_done if cb_seq_status
> > > > is 1 (an RPC Reply was never received) it calls nfsd4_mark_cb_fault
> > > > to set the NFSD4_CB_FAULT bit. It then sets cb_need_restart to true.
> > > > When nfsd4_cb_release is called, it checks cb_need_restart bit and
> > > > re-queues the work again.
> > > Something in the sequence_done path should check if the server is
> > > tearing down this callback connection. If it doesn't, that is a bug
> > > IMO.
> 
> TCP terminated the connection after retrying for 16 minutes and
> notified the RPC layer which deleted the nfsd4_conn.

The server should have closed this connection already. Is it stuck
waiting for the client to respond to a FIN or something?


> But when nfsd4_run_cb_work ran again, it got into the infinite
> loop caused by:
>      /*
>       * XXX: Ideally, we could wait for the client to
>       *      reconnect, but I haven't figured out how
>       *      to do that yet.
>       */
>       nfsd4_queue_cb_delayed(cb, 25);
> 
> which was introduced by c1ccfcf1a9bf. Note that I'm using 6.9-rc1.

The whole paragraph is:

1503         clnt = clp->cl_cb_client;
1504         if (!clnt) {
1505                 if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
1506                         nfsd41_destroy_cb(cb);
1507                 else {
1508                         /*
1509                          * XXX: Ideally, we could wait for the client to
1510                          *      reconnect, but I haven't figured out how
1511                          *      to do that yet.
1512                          */
1513                         nfsd4_queue_cb_delayed(cb, 25);
1514                 }
1515                 return;
1516         }

When there's no rpc_clnt and CB_KILL is set, the callback
operation should be destroyed immediately. CB_KILL is set by
nfsd4_shutdown_callback. It's only caller is
__destroy_client().

Why isn't NFSD4_CLIENT_CB_KILL set?


-- 
Chuck Lever

