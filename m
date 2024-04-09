Return-Path: <linux-nfs+bounces-2731-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD989DBC9
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4386F284A9C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EFE7F7D0;
	Tue,  9 Apr 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KofoDQJq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qx3eIRjG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6387F7CB
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671781; cv=fail; b=M/Vf19Scpgxhh436IuvMxjuY2HYMUE+JIaQ4QtPU3r98L/KMnXW3hpM3BapkOR+4YieqW0KTHFl17n+Il4fHwPOLr0+Qt++vYV1NG0SBn9oLRbO0mjO6r2vWyyyoA2tZSUS8Cak8HfA6bnfyrPJRB+ZCoJaASgWWxnrYCOa1NS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671781; c=relaxed/simple;
	bh=eQg71LwBKSMJ+xMAXHnVas8RVQQ+G5D/FUi5tJH2IT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PpvgUDnN4lgK7gdMHIptqJ5ek25SPlmIf3msUgqMuQtAGG4dWCVYoH4nMXwTIHfqHs/0NpkQGQrvE2IHAx+EJceWz8Mdh3/vmxMORNw5teZ4/AsDnWNWZebDcOvP9aK6YDPW6qSwa2dzS/b6Y+myjGeXdJn/Gg+XCIuMKR4o4Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KofoDQJq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qx3eIRjG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BYU9W005144;
	Tue, 9 Apr 2024 14:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=YfblMTTihjvdLeYOwyFBNAmfo4xkrJizCkRE98cE75Y=;
 b=KofoDQJqiZ4vKNbq3MlZVLyBlt816C/0et/7h2cvL6Lb4cK3j22f96yaMlx8GHPLh4+9
 7AxuR5aeVHbZvKCNZOiqKBlWuio8sgcauF5HVzA2a7DxSptbGn6Mibm1LRvt7NozT6JB
 nwFSooXBmkcWOhAH+jW4byFfd+vT9Z7YIVipVCHgOnI66sumOEDne8hYEv+7kbarfMaO
 8m1VDSwFjEzV/s+TC+O2U4SIkah94ZY3MOUOU3WWtiobVe5QcGRQYUv1nP6DIR/hTlAs
 OGcsnv/3i40cP/8SKdTtNQ5bWWQy3uUrPJXMoLc/WMT9kkJW2k7tEzJH403RBv+6Cr8o vQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw0253qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 14:09:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439DrHZe032329;
	Tue, 9 Apr 2024 14:09:18 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu77u7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 14:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMp8d6GNEveU+Fx9tAaXuziShPWrxLAoPChTUbxK3blbvnGT2BUivNsTqPMmw+abhrW2NPTpxbgsZuEwoDQuTeZ1Wtn6XOjyNaN0iTf3jgogUnGr5dCBMYroRfIn7pQUY0HfcDN/nNeG+YIv9VgZYdvFqMprKgWPjykQ5nvp+d9kx91O8QoYKTFCcFehuBI1f15rcjO43Fxurl96/TyZtp2xfF8UfsLMMS6EMv92Sh1gA/HWsZ+pg9oDSVXTr7JCx1phHEA0kk3ntiTp5MzjXKW6VCVCLWREzBU2iwv9iImX24rZPUmCSRpqvubI2iwVm7nNtO0hAsNdwcKeJIYoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfblMTTihjvdLeYOwyFBNAmfo4xkrJizCkRE98cE75Y=;
 b=VCw7XSJ+VxvKMz0Jt/fWIp9fWXqPWYQQElPoGnw1Vle+DRFZb2k37BtjTAwfPhTdiiwDNQp79nEhrNxCGlmpnD4MoHpMHEO15NUI2zC6+g5PeWskz18m2sPwMzvF3YKa+P9UzCf4xG+Z1jXUuPtjscoNHIh1HMPhXAtz7lGZ9AFretLBqCELQmuugS95Qkpq48nQsDX7X8XmFqqzoTEPiLFUOQCCeKMy8WoZnsjUTIW2RpPYDiGPm9i7zA8IVTq6Q7yGsrriLDq3sSN2VtQPZSyMlm80y0vtwBkORoIoZHuJk3nhgfinlk55HEWuJE4+46kt/5m/2ODJV280CeQ71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfblMTTihjvdLeYOwyFBNAmfo4xkrJizCkRE98cE75Y=;
 b=Qx3eIRjG9g9gvoX/E1+xhzNpZUeqeOTxOYrfo1Wt3YJcSuWIcZ2zgjJkNSmRcA615+U7f0Q4O2OXnhVA5l46dIwPfOglNNYNVTn0Ls+X2nK7rPyaw8JF4S3QYgS1N8MNCyWFJ7Cv5VFDO6gp9amnyuKxem+nAefgwzWgYEvv4Ec=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 14:09:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 14:09:15 +0000
Date: Tue, 9 Apr 2024 10:09:12 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: remove redundant dprintk in exp_rootfh
Message-ID: <ZhVMCHHIUn8pobje@tissot.1015granger.net>
References: <>
 <ZhSjEGEMyVuyApha@tissot.1015granger.net>
 <171263196068.17212.17916891599918470772@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171263196068.17212.17916891599918470772@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:610:e4::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB7045:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SLh4Ul8wzsdUQwsPXPkundXhBU8nX4ayAKNpC2lj2Yf68ObdcEb7zCc2Sv6XOt9k/M3rp0J/kBuuVmNdWBJwzPF86XAbeSApUK+9+lJ0rCIxYktKXcJT0IIdcHqAVc+iWl25q2iGtdT3FHfNeSKPv1in7HwwTyD6e1WpPotKHFqHMp75Tee4XSoA8UaB7pJ1caoIbx0xjfkI38ExT5VR4eNgckhApitE8/b3wU6oh1jnc9Q8EIskN5qW+h0i3LSlXfhbXRt+wTtg9a/NhCyefW5Eh45qCOcVTurCVvEDvlC+oa7q8dEg8Qz4vb6oeWH0zP10WWpwFZz6wjucGgI07Ayx5MkZugGWJppyTIPdn01ALsyP41G4ca/oOhkHOdwGtawq95GkJT3A4rsp1YBLkmx/pYpXaTpJYBBY6eM+hbw5tlqjsuB6Zmq6GaJptV7BeurScCISREq/X2anj5jHMfgXd7Fl6+HLsNd9EeyxAK3Y2A47GAwdhSt2IQUwsa40f2SuUY94DfPSiHHmnb9WfVjbswxZFqLhy9ZPa966j1AGdieiLArBZDjCP0uVqj6bsFeLlxCQVpV/1ap1XRqSgAIuS7DgsLdTqC0XjhzGs58wY3MPnRMlt/JkVoJQscAZ+uzUAW9gr42Bb4Vvo1MtOp/aEkpKyZmeP0qwAHCrt2M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hVmehWseXVzpubBgjG7aLKsZUkeFpyu7/k4P2w8IOC/0RePGx8f4PRXge5Zh?=
 =?us-ascii?Q?o6eOAin98Pb5hOW4sQz6/ftDiV9WfNb/w21vrlrYt5JnBX1TM95Ducv/ty75?=
 =?us-ascii?Q?94UVrOykRoNEXIAF63uuEMGhbGDxbaNI3pePh4v91WmrdFyf2G+TI0xZGNfB?=
 =?us-ascii?Q?NoXKqh770qqJzbn9CNoL4osvK1HEOt7pfwxaHssrcjtesHxKHmt6JnO++fux?=
 =?us-ascii?Q?L16u4a1XNR7U9BwGQAJgQI4UPKFCwZSuJ1+L/uNZWzQCwG3BdyipyvPE3MmY?=
 =?us-ascii?Q?WZGbVEwWlIG/VeLZpNMammIymI/DjXz+hnbtRcOH1Ksyhu2aGqeb/PlhUi+s?=
 =?us-ascii?Q?84Zfg2vyoen9abgdzmNOsUCqSQeAxAL7WWWZOvgGFmuDtsnXoXIcEx/GzB+l?=
 =?us-ascii?Q?LVtK4MubS8x35xZ6MQxl/niHORYRZoSV6eO1cQnmA56sjc+RbIk3K0iJf/Hr?=
 =?us-ascii?Q?fKZklV5krWFLHEhytSBXyt5rUajXZxdo+HdkfD7c5OmnaBLyOCgOnGP7bh/2?=
 =?us-ascii?Q?5nXQbC8lYPL3VstHsYRPOvYy4QJa3DSKlJU6lS8BiOyzqN8mVOWHxuyJjSGg?=
 =?us-ascii?Q?doe9O8phmWhZHf9l4HgKUF/VW3DVFN4htbV9YUccUyDqibhn3ohe+vIgBwwg?=
 =?us-ascii?Q?9NvxA8EJv3/aeJv2kOLSrZHhSo2USiaiquNapciGQ5bsuO2WiCa4D9pRKaeB?=
 =?us-ascii?Q?xRBJxEJI+6RxY0ALWl9i52Pl3Cw5YOg3/Re6zWGF6W5WcufiaBOTaNRA6bct?=
 =?us-ascii?Q?UwMD+n6hP7eufxq8prEwKLjq3Rv/Xocg4A62rUgC+H4VIR8h6IHEW1/SsZ/X?=
 =?us-ascii?Q?rr0n0fnCC68iwa1EVOgLVcwkJQYLQQbKpaybFcFqk0xx3lNYifQrrszSkcHj?=
 =?us-ascii?Q?QkJkRaSjTQzVpQ14ACRMzTP86HTM4t9IEO2jfGIjJDyS7zr+OmLiV3GUJekj?=
 =?us-ascii?Q?i0KkWpETKtkkfDR4/7vd+1UKTJUiEClK9HrFBu5jzNkhm7NwpBaTNQO4qJAf?=
 =?us-ascii?Q?bI0J6GRnHSakO8N3Pz1V9b6s7uPRYfB7YKzQLiwWYEVYyTGhgOH6gT0a6Vj9?=
 =?us-ascii?Q?bKUKQhrkNJ1yPlN3DI6stT+WtzEfYMEhJ56ryE4Rh6U1noNmYWl59ZTTKxuw?=
 =?us-ascii?Q?BDJ4UtDDEuHuPuKaqH0xYxkiMGqliVjlgqjPXlNCh4Q4FOje7xlmU0MB5Vy3?=
 =?us-ascii?Q?PhxLDlQ5oMhT0mHr01LZ59C3bMvuJ5wOcuzZhEHr4UwSESnW0cfMQ3HwS1JU?=
 =?us-ascii?Q?m4izL7yWWMO+pJ1+x7EJoRnyLfYwNVeYPyr8W4Uai01ZHWbR2d0xkIdqarub?=
 =?us-ascii?Q?ch8INjVGucKUUJl1EYi6igF9wLpeyK+L9fGvO/n+w2ybuoYO/XcCmV6JF4LC?=
 =?us-ascii?Q?i4NCKWThNRf//WICVUl5E4s6MlFqITMWR27AmGQ9oVAMKWIkVzpkpWx0AxTj?=
 =?us-ascii?Q?TJk1LKgYJsPF7/B5b88ksAGjY3H67+PvLdZiFm9g59BkX+WSF+GM1yCCODt/?=
 =?us-ascii?Q?+1eWeYmygE3CCmoabOsJClEz8S8Zed//0bVDwv6PK3s8jYtxFraH3fsgGXl1?=
 =?us-ascii?Q?+4EsY27nsd/lt1R6ilqniPO+jW0VgGJeJzl/KgCi/9BYzE7urXV6uK5mxke5?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tiADcnH9RqMWXTgDGHShfojog7t3/GaMFsxww4XyB/6x4KQBFy+M+8ch7OVUmaTeWK5c0P0n/RqtqCTsyfzp1ItqGPLPkZxeEl9eybiuOaKWzl81BHC2I7PsdZGRw7G/fRpaBpUDRCmqp179uN617WBye0mdd8tLnmtBcZCgPYKfMiLYCGOP2/iYetxxCC2Vd6DRTmdcnK2iPWoFDVt3Nocjfn0+tysQ+doRi7a45nA/81k1bmdOAgADNqBhG1zm76LOAeFWZQ/Su11ZQsrSDmanklNtlbh7cdnQp/nvYynu0b7rGC0HPiUHMTtzQtRWgna3YNkkm/dnTfukluqvOkzklnpCpk/wMrFWL40F9c9Q4Zm9M6j02yvkGXrxVOT23zSmoLGj8Edb6WmARkeZRea4JiXt0pB98pODuPyOVPTPzhmSAf+EEfEpYy70o1b567LPzkibyMov3l+K8PHPNyC4ujbUnCXtcYeZ1IxqhkIVayOHZWSyWOGq5g9Si5Ns5+mgRKGY+Uem1TXUfUiV4n3aJRRbCz098+jijoCqAZWxxbEJzG9SvMpdjB/j7WC1IwrMhhZp8Oz1hOjd1XJ9qe5Id0ssFS2+oMTZ0wocTwk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de438ea0-7894-49a6-26da-08dc589ea3aa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 14:09:15.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2BTALjqIqcyKbaBd+VGNw60kX/8OXpd1WvNqAq4JpFFfeuBauPRsPJ0UrE7TRFYIQhgpiIgjTUniac3jLDYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090092
X-Proofpoint-ORIG-GUID: GFPQTeNaC11Lmk_5WFH-5fhsMZIeniRC
X-Proofpoint-GUID: GFPQTeNaC11Lmk_5WFH-5fhsMZIeniRC

On Tue, Apr 09, 2024 at 01:06:00PM +1000, NeilBrown wrote:
> On Tue, 09 Apr 2024, Chuck Lever wrote:
> > On Tue, Apr 09, 2024 at 11:12:12AM +1000, NeilBrown wrote:
> > > On Tue, 09 Apr 2024, Chuck Lever wrote:
> > > > On Tue, Apr 09, 2024 at 09:21:54AM +1000, NeilBrown wrote:
> > > > > On Tue, 09 Apr 2024, Chen Hanxiao wrote:
> > > > > > trace_nfsd_ctl_filehandle in write_filehandle has
> > > > > > some similar infos.
> > > > > 
> > > > > Not all that similar.  The dprintk you are removing includes the inode
> > > > > number and sb->s_id which the trace point don't include.
> > > > > 
> > > > > Why do you think that information isn't needed?
> > > > 
> > > > I asked him to remove that dprintk.
> > > > 
> > > > Can you say why you think that information is useful to provide
> > > > via a dprintk? It doesn't seem useful to system administrators,
> > > > IMO.
> > > 
> > > I'm not saying it is useful, but I don't think the onus is on me.
> > 
> > No the onus isn't on you. I'm merely asking for feedback (and I
> > explain why below).
> > 
> > 
> > > When removing tracing information, the commit message should at least
> > > acknowledge what is being removed and make some attempt to justify it.
> > > In this case the commit message claimed that nothing was being removed,
> > > which is clearly false.  Maybe just the commit message needs to be
> > > fixed.
> > 
> > Agreed, the patch description could have more detail and a proper
> > justification.
> > 
> > 
> > > I don't think these tracepoints are just for system administrators.
> > > They are also for tech support when they are trying to remotely diagnose
> > > a customer problem.  It is really hard to know what will actually be
> > > useful.  Many times I have found that the particular information that I
> > > want isn't available in any tracing.  I expect this is inevitable.  We
> > > cannot trace EVERYTHING so there will always be gaps.
> > 
> > When there is no in-code tracepoint available, the usual course of
> > action these days is to wheel out BPF, systemtap, or drgn. Distro
> > support engineers know how to do that. Server administrators might
> > not be so well trained, so I consider dprintk() of primary
> > importance to them.
> 
> Point for clarification: do you see tracepoints and dprintk as having
> different audiences, or do you see them as serving the same purpose with
> dprintk being a legacy implementation which is slowly being transitioned
> to tracepoints?  I had assumed the latter but your language above makes
> me wonder.

I'm leaving some dprintk call sites in place when they can report
information that system administrators can use to troubleshoot
local configuration or network issues, say.

tracepoints can serve a similar purpose, but can also be used for
deeper introspection because they can be left persistently enabled,
can handle a much higher volume of traffic, and have a higher signal
to noise ratio.


> Certainly systemtap and other are invaluable and should be understood by
> support engineers, but its a whole lot easier (and quicker) if the
> useful information is easily available.  Our first-level support can
> easily ask for a rpcdebug or trace-cmd trace and if we can get all the
> useful information from there, that is a big win.
> (It'll be nice when we can stop using rpcdebug and only ask for
> trace-cmd output).
> 
> > Here the dprintk() is reporting information that seems useful only
> > to kernel developers. That's a code smell IMO. And the guidance in
> > these cases, historically, has been to remove such observability
> > either before a patch is merged, or after the fact, as we're doing
> > here.
> 
> Interesting...  I had always assumed that dprintk/trace was largely
> useless without some understanding of the inner workings of the kernel. 
> I certainly need to dig around before I can work out how to interpret
> the trace information.  So I think of all of it as "useful only to
> kernel developers" ... or potential developers.

In the past, dprintk call sites were a mix of information for kernel
developers and local administrators. The trend on the client side
has been to remove or replace the dprintk call sites that were used
to develop code and are not helpful to system administrators.

That is probably due to the coarse granularity of dprintk: when you
enable a class, you get a whole bunch at the same time.

Now that the system journal is rate-throttled, the amount of noise
this can generate makes dprintk pretty useless for more than one or
two messages.


> > I'm not hearing a convincing specific justification for maintaining
> > observability here.... but we have a few more weeks before making a
> > more permanent decision.
> > 
> 
> I'm not seeing a significant cost in maintaining observability.  But I
> don't know that I care quite enough to write a patch.  So I'll leave it
> up to you.

The only intention was code clean up.


-- 
Chuck Lever

