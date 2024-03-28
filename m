Return-Path: <linux-nfs+bounces-2546-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33082890830
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 19:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C661F24B7A
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 18:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2427C81AAA;
	Thu, 28 Mar 2024 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JZIGxG32";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IuAVgwGw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC7A1879;
	Thu, 28 Mar 2024 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650342; cv=fail; b=KjubSxyXVVzig3VaGWMnIRNF6RyqewtVZzULA+jRpFxvejNaQ03/Ayfj+R5AVOU/A3TyVBVmC6uive+R29z8Em/ymkyyL9ibR7ShyhSp9YufwRpKEfiD0/xiSG/Xmz5rlmUbEicjZXmzOXxLM5/MDGpyosn6iOJ5QTZzKE1yKgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650342; c=relaxed/simple;
	bh=qp2jNytE2RlD651aMFcwWDgAT3g1Z7LhJVw1K8skARU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QNvjPxeAqlZrbI8fApZayoElmXck/9uZWf04wBwVG3xADWsNjGZZMWsC5JuElNwF3LCp5PIt47ADXqUuk8gIYA79tmyyqlkqk4U8PQ0fX1PYT6Eo0rruTwrbnGBs/f7OT0RbWnpTGg5N/vrTU1VHhD9B6QEg5D/Axb8c78Gq7Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JZIGxG32; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IuAVgwGw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SHx5ke004723;
	Thu, 28 Mar 2024 18:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=pjUPenEqrZ+dSxFg8JypWG2GtT84/CeyTtDyc6K0Yo4=;
 b=JZIGxG32UIZg+tpxEn1G51ezizod9yD47CDGnjHMzsknRtMfMAJy4mwBhC4GjVj6TUfc
 tAqN2Jew0VvOXa8LoMsq48sqIbRYHRq/EOHYdKZKlUjSJ7ftHOZXCDmjIdG9NneGgJ90
 sgY5tJlLRiBWbUW/n5WZ/vxyunzkWPjXnOsPDR5HDe2QOofMKm2yv19XXLww+5AQVjNZ
 9NkO9un12ah4aSde8TW+n25B4DLX4bbsoOmdoMJpq8tqu8k7IG8/dE/EkTxMRhY1+eA0
 KEOJ8ckFt/EKXYCRcDzC+N/hOBQTYVabIgVX+/F2rqRttjcZMFlbSAVHNXQur6mipu22 8A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1nv4aapn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 18:25:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42SIAkgR019155;
	Thu, 28 Mar 2024 18:25:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhgmx0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 18:25:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLWPc5jiqdAflh91CyBicnr8tz30uogajg/oaG35oIW8mIgLV1wxN5l2oNhZwc3N+LsPo9He4EBB7fhI2T4C2sjYVsontfGdRPWYgLYFVgrN8TZ+NAL3tOekPj9AxlzEfEZeEoOmTYDA1tRNpCXdeTauQRjAfZsNISium+y2X1tCiP+GStKFZWhXRLBLFLt1N8Lk3PhcHpZMm45ZILYcFbuCGq8Ej2Ak38mAadCHufwl4T4jNCe2dlcmYavKhaRYEfR2jdW2AdxrFlRvhLhn5GUITcvdKULsftfGmoIK0Vpa8ytvIv5x4tnbgct0CWSD0dA9m+7VDiRpghmByZ6IRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjUPenEqrZ+dSxFg8JypWG2GtT84/CeyTtDyc6K0Yo4=;
 b=JJWX3/xh1xarL85F2GyyPP82gho/HFUfc9wdw1tuLBNW2Vm5AVusrGv93QLry0a7Zt/O/L5HZKMOWxo/0xkI6pqrAvYSaDKvugRLpZYMPjzVpdugheC/bR0OVVqvtK7rk/KSTPYr8Y8n0c7lHrJr9ILBUtSB0th0DxqFYJZYttxAX/sMpmSUHoL/h4kuW05h/bSg17rVloWjvanqwolYUfvl0T0Ci5VAuw3WLPm0EXYLfxgPj4vt9zsidPEL/P13V+DQThewIdWLDi/r68GZ7DlOImHQbMbExic1oYe3GC4QAqkUE503BvtavPVn2yqgqK4yA3/KR3/JQqd7jg8NWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjUPenEqrZ+dSxFg8JypWG2GtT84/CeyTtDyc6K0Yo4=;
 b=IuAVgwGw8CVw6IW93Ra8uMzLuaUnggxcAKVbWOmCYQ6ptOA7NLinyxTDCCMmQTHZ0Pr59HnpPcFnOyrQi0a+qZ2a4nFSOBdcwK7tFz7PREyoeZHuByD2urhJico1lqLRCYLeY6Cgs/om5IS1MzI2VPAJSI6v+BioVdw96jjoIlE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6464.namprd10.prod.outlook.com (2603:10b6:303:222::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 18:25:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.039; Thu, 28 Mar 2024
 18:25:31 +0000
Date: Thu, 28 Mar 2024 14:25:29 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] first round of NFSD fixes for v6.9
Message-ID: <ZgW2GVcXbJaPlT8z@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:610:b0::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6464:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	T5j2xrTzH76yzKodw46hcAef7kDEb5ZkO5HAaumzGAprE9Z+AuK5aAHQRoThd7xuK2aqJ6yL3OOWFqZ+JyYIiYooWjk9Sh/CN2MomK4ILGxy+lg/11Ie5IY+nQk9lQc2K2qO3s6NFQX56wAOlxxdHTD/nAXQrUBvL4tl2hgBJ7P/qOOtDaD9LqD0JYLeFASE+Xg/ZCJpMB6W1kMsHEZCjKvXLK9MWVK4OPiRkirnlLj+xyS9wSc0cXi2fxy16lh75VJcvtjy5f9M61hXEo2lF9T4uIBwirP1RQiKt1wcsJZEyAGgGIW1lSX+acLuwpZYSlT7OhYhFMb8pojNX6cHJVPNq0IVF/9diw4ayXid9H7fvO+OZgEZMDCyGvSI9XpNiduOU+gm2V8WpG6C3aEDMBK8hiW+l9YdYO0wh/He0WxRPCYe8AhLuoyo86xd7bzRin3rxoS5dZ5By9pPIhhtrM2UrQvJ0spRzo4vYOY58LGDep69tAyBAHgMHBkjTBZwAsdQut62C+juHscCYz2wYu7UC8fVPqbcz1XQisFcRD2znIk4VJ1GXdab+VVwgTiKWFF20v1JUGSsv0eB7nmn+Pexm1dhbaR8yCCnZWbNe0A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lJT7diZo6fkP0A34sTywZx2tZ+H2YAITIXLvt7rulJxqYC3yBop04UwkOd+C?=
 =?us-ascii?Q?7dR3ipfXw+MsL1cEC/X14r4EW5Xfs3Oh4TnAI0ugY8+/11BFCNgeB7wYy75A?=
 =?us-ascii?Q?35giMGSsKHSgW8Xqm1tGpKDNlie/vJaY36YDqQcLGBjI5lU14nfm+dwZRFxu?=
 =?us-ascii?Q?cPgCGwj1BCk9Xz0+NKJlpaMCrRQRft/Hf2wqlvLH2ceCk5IO8yljuaQeFiw2?=
 =?us-ascii?Q?P0BoTws5qjFtLV5QawvNsXociBYc03CLb0lpcJlspVY4imvrTv+cHW9JNE2p?=
 =?us-ascii?Q?KXvySh2kAUOQGyheA00pbiygTnO/BEgILZl4K2D14PBnzZAzyF76e+a7w0Nx?=
 =?us-ascii?Q?kAmCPwWB4R2QY43XmEzzNOqkjnE7gyJrSz44JqOahG+AuFf+jTomynPofmA0?=
 =?us-ascii?Q?qkM8ubSUPsMfluwo+1r4gijBBXm0NzLzuK7tUjXOeMIrRooSyGCWqikF4UO9?=
 =?us-ascii?Q?Mcc2f/wzIrVrvfVJAtiEBgTEg/ms4HbBplc1tm1fNriK2V00v7aGLYpc1cT2?=
 =?us-ascii?Q?fyxEzineadqm4Qwej89lBxvuvHf2JR+OlqLSsGRVuvbFcshRFqbhQUoq6WSG?=
 =?us-ascii?Q?q3jrI7polZJuqtVn4FJ4NA/WQ/amTkus43crroV8ZgyVofkN9+VuAdV4liw6?=
 =?us-ascii?Q?yL1Bj3mddATQd0mcWGO1KpWfoH76d/2eYut8rW7lZZ/0ibql58f0k4CFjzNx?=
 =?us-ascii?Q?X9Ty5Ux2o9XcOn6oSubqEjepwDzM6/Ab/SwZiioORiLXpAxcKm9TdQQxRlgf?=
 =?us-ascii?Q?1zmWRx4h4ziinkrXl561AkJMYRpiOPr4c0vRA6wTptEnC0tGLN0J7AjSXTjK?=
 =?us-ascii?Q?YHVXD7IIwj3INSZl64dY4QQHvcS2Feumf5ibsgdJlWt5qc2b6832j8+bnsEV?=
 =?us-ascii?Q?AC14mOOrm2NOWRJxVB6LE43jgEKBMd0dHjiuHBWefnT+eYpL4iKDguRylDu8?=
 =?us-ascii?Q?zFNYsTRifVoC4aX2WfeB5AUJcRfHzcQ2OapDh1ZGqBe486oCaxlZ4OaEdQh8?=
 =?us-ascii?Q?5feqjVE0zNteWWF+RzPJHyOlZTRF3HnWAVldIor9eTEDf11IyvTtNbAC8eUk?=
 =?us-ascii?Q?DmqHQrhmi+1zdm8h6wVAerhsuxRtQi7YHjlsRpz3cgiJjTFgxnvxh5dbOHIr?=
 =?us-ascii?Q?0Ahik1SMLMzUZQore92bvIXGWXJW8ECyuOYLkDv5smNQThST52z/035EZHw+?=
 =?us-ascii?Q?dXSl/cSIxFTOWAQXgViQ4ITWFeHYeVidY92JT2ECJdRSwvqOjSBhzTkhVR88?=
 =?us-ascii?Q?MXwpTuteEK0P7GQYOF9cez4o6FMfJ6f5000CBoVwNjoyEYjb8u5YYBf7JOFq?=
 =?us-ascii?Q?5kNErRloNGkLPmu1c1mK/CU3KpRuLqOfxbMtvJn7Obm7n6Snav09I5Z+/0DA?=
 =?us-ascii?Q?CdXxsHpME9UkO8Q3XdVPxXbpTVST8cyaQIl/UjNVZ7hZRXG3fiKGUTWTeZH8?=
 =?us-ascii?Q?gnFhh/b4j6xwmob/jqWE1Pg7c5Q2iLfemKgJ4rghYsqLOph1VKPOOpmGdV+9?=
 =?us-ascii?Q?pL4N20Iv4EGdlsLdXUODGUikoFcGewe4RCmm89YUTl7miwdLCSuT24AL4BNn?=
 =?us-ascii?Q?eDgfxu9IldQq2btrkjePqj+Rq3vDHaQRY5ObueLiOfrG9P1kaGX6bx/tUrde?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Xvr31kvvVJS5vxtgdAV4Otxz4cu1necCXaCLTE3ai7yPlKL0mWSHk0vdfXM8gZabkuVRDgHUw2NwkpnestPSfGF8omZdngEHeaBp96jq04drd+eY81zRo+PvJypXoUKYVcJUfi4o+LR9GCWPx5FaPZODJDNLMLv2/xQ2x/XOU7xsBMX4X0l0oX+WRZRs74QGW4QtwBKspzRSUAAUf6Mdke47OP2xr/3JlqRU26QX49irzbY2/4NUHO3eOnmAI04EJSFN6/EbCRJHEhjEy4HsZcZJBJckDkEUAGeVsmxUGRcE/Y6rHOoD5TfzDPO/SsXygxWdZXGY4G9B97pAbqGb1hfSg8nWq/WeVYRs7xZmrZBiqAX5ug7pTsMG8dk++/oPW9N5EnzjpGFXfjzmqYu5KapdBIMFFEN1EA76zxXS3/9L0t6+PWMpe5opVa6DFJ11BJM0rAQOfeT7XIhhZZ5lEmGD3WacVyLHA34LW533HiNpnygcrcYUXEYevog7vn56CZnxmQbbHOj95d5S+qpCFF/YJaHxehd1CS403yj1OYV4IVwR+g/VaHq2YiTMef3ZIhZNZNxjVBNOCv55sNYZieDFgvPEtw313HT8Y6CjZnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb4e3ea-5b01-40bb-d1a6-08dc4f5473b2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 18:25:31.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYGsKMcKhzW8sab59Iuqu+iuiKZGegsJ4UtV5vqSGk7AFldDF60Rg0ZMqeLLtV5yFv+wWXCw1nt5oe+XU36cAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280129
X-Proofpoint-ORIG-GUID: ny_ztd-4PVQbuUqQggCQpXt4deUUnBTm
X-Proofpoint-GUID: ny_ztd-4PVQbuUqQggCQpXt4deUUnBTm

Hi Linus-

The following changes since commit 9b350d3e349f2c4ba4e046001446d533471844a7:

  NFSD: Clean up nfsd4_encode_replay() (2024-03-09 13:57:50 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-1

for you to fetch changes up to 99dc2ef0397d082b63404c01cf841cf80f1418dc:

  NFSD: CREATE_SESSION must never cache NFS4ERR_DELAY replies (2024-03-27 13:19:47 -0400)

----------------------------------------------------------------
nfsd-6.9 fixes:
- Address three recently introduced regressions

----------------------------------------------------------------
Chuck Lever (2):
      SUNRPC: Revert 561141dd494382217bace4d1a51d08168420eace
      NFSD: CREATE_SESSION must never cache NFS4ERR_DELAY replies

Jan Kara (1):
      nfsd: Fix error cleanup path in nfsd_rename()

 fs/nfsd/nfs4state.c                   | 36 +++++++++++++++++++++++++-----------
 fs/nfsd/vfs.c                         |  3 ++-
 net/sunrpc/auth_gss/gss_krb5_crypto.c | 14 ++++++++------
 3 files changed, 35 insertions(+), 18 deletions(-)

-- 
Chuck Lever

