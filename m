Return-Path: <linux-nfs+bounces-2088-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D18867818
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972CC28940B
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E781129A62;
	Mon, 26 Feb 2024 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HnM4ovEc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="siW+rwUm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D5129A60
	for <linux-nfs@vger.kernel.org>; Mon, 26 Feb 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957316; cv=fail; b=NJlhGahrtqfVdzkLEOwHgQlbkX2/ISqj9lsvum2HwWPmv+tDkaKFX8wpsY+i9ebBlbtZWWJKdVVh52XKqbA4UazoB0msdNLmSuILyypWFZB78ZoB1Ng1PwDUhETCZs1ApBwaZ1VeEShEwgxIH2IJqPyWPoUnnV1ivIHTNsZJ0UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957316; c=relaxed/simple;
	bh=KVijcvr3g93oqnAfOIVNHLiXPscQnT2typOCqgieln8=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=PAr1rDKO6tR/AIANpO2UXzcXOWQ7KTvGtG1yxQh5TDeFUP9gKaxAk/6NZrzBrd23dBm/Kd6BJv1/WKdUB5F8UZYwCVitS5sRkh1ZyfydYRNqx55LF4N+d7+zl8vtlAY8E5RPZ7lkcnsEQPDZyjHFwH76rNh3y68s7eAJyEUhEcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HnM4ovEc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=siW+rwUm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QDLNMr031452;
	Mon, 26 Feb 2024 14:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=KPoHIOM/ooRpQE6g+Q/SR3nJ3864HnN9qDmVCQQ/RU4=;
 b=HnM4ovEciOLjOOYsz7sckf7T+np8GRWJA228mBgdkIL94/EJTWBrcokpAraDrDOVH51k
 sv+cwNepIiqYaxGXZcqEJ0yTbsRHOjCjiz/J4Sysg9cGD3cWn0Ap/7c3dmsUxAUbgt4V
 ZZ2O0/jQeb2sWsbTsbdN9FcamDrBwGQGnVnpsMFdhY8h3OcFGbDcEFhcBHaVAktiJ/Ax
 +nsAe7u1dLIRCG+uYfvIlfta23168JuW0IS6m9gMBPorfjLPVENFZ55gJnHQWFDNIexl
 3zeVR0e6IbdZxug0ONPxRo/M2lRD9RgIDzBv0nUuPkWYgiH3x8+2KDzX1/dOr1f7GXNx lA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v4kun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 14:21:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QCegxQ009796;
	Mon, 26 Feb 2024 14:21:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w5kxut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 14:21:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4JFBU0JFP2mjZeaXX8R5vGmr7ah/Nw3MCtR1Gw5rxrRDZPrGx41N6GrYWU7do86sP3QljrOBOiyCCeIXBi7spFLFVdS2qU5xpjIqYYhxjGwRB2i0lDcpD27E+Fxp9A1noLt4tnH0fOoRvkNpV3CKwPeW+u42EOVeRm5K5rXUDSK76AIcASjOhbhwHzK9WBAO/d801knRaQ0vVi/uQ7/2bawwKAlOS0gWTGNxqGMDykMWgFjGt45f2Gi2d0jQS4RiIZ0RH3uFqIHNkv2w7FAfhX9b8+FKTNgLmjfCAl5rRIJXo6/6lHrQ57jNBu76A8RnABjbf0JRklpYKysvhSTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPoHIOM/ooRpQE6g+Q/SR3nJ3864HnN9qDmVCQQ/RU4=;
 b=Xn/m+yqWKd9TLjkDrCkxkuh52Hd9XXq3W7CxxLvtuEvMl5lN9LmThOiZfVFIrGB5t6pUi4YGqE6S5oNYKdSkZ9ht2Yk2sS9lrNueTZyIl0X1qbJJoAZlTJuzOvFO/P1L/RjrfTnc4pjz0K1Huzn9BNxywXSdtq2nOvs05Brnz71u1FOq1779jPkUEY5dgnS5z2Lhw4TVKp2dlZQaI7QCT2CSnOgMoPvOlPWi+to9rSUre8fAooqQWfSs2qXrtBZS6D14Oe+b0WsUfphFvSf95Y2sY9dk3iJru3OVEb6jslYjIKC68deHzc+acAYsm90rITCVPu1BXsqC7x9ifVoF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPoHIOM/ooRpQE6g+Q/SR3nJ3864HnN9qDmVCQQ/RU4=;
 b=siW+rwUm8iZFPTb8mdNqvupfcc4L6qbolhQVMuE1fMkLCFN932rOYVyWtlRt9PjxhW6cpfoJ+04EYU2pR3CPxWZ4bBEYDVJqgLP8uQJJhXc5pZcbWkb78vWwJyIWqrkCrwOBGWVtGqiMejpqMD7r3yPQlmaPg+bhGq2IwhQH7Ek=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5886.namprd10.prod.outlook.com (2603:10b6:806:232::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 14:21:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 14:21:48 +0000
Date: Mon, 26 Feb 2024 09:21:40 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZdyedKSSsIARB4ZC@manet.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 15393e6f-3590-4f4e-d9dd-08dc36d644c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	p0FqJ63hnqca9LPEnD6SdPliCbwQ4VC7QUjtSNRKerqkE7mCUKVpWH+S8kjbZ25gsHhzLJ/TIjZo00/VVAzfcIptKSVFJWjtrjegXJ8B+NfMBg5GyaJvFqfKf9xZGpN3tsmVOTuienPioyvs0Nk54ReM6czlN5ZDpUPvbJDzNXbmhHgjIdiuCzUVS1Stirn/ArJ2u7p8W7y02yAM1UfiZd9Q+hOG4gKFIJq8AAus5lPF9TVB0sWWM2qRrkjUGGBY7+Ph73DiNHEkhcWdf2F5rehJw+AaXAfMdFzKQZb6aCSkIqgdZeapntJWURrgVGS7n3A812NqI7rB2WXNWc+kV6se3jzbdmPpXwAWwpl3EqgYeWHsWhPU47amICwz2VwfwkNscYiBUtfsIkIkC0e0+jxFGd6zfXlkguumXOYXOUhoO7e7e2IdSv7kOMxdjN7ZMpfUJjSCC1BJagQAAE8JNm4/j4gRDRux6Hb6j8GdAIEoO+VMwywEuFCoczuAvdr8U1UG5GOWK9mZQDMzSfjUJ4yC4gGRb9Q7hLKhTJJcvSrWlx94JGic1XtEPro4UGjxiHGcYjwqNP6qPf08QN6aAmYVOcwXa5InU8t62oWuP9jYjq6LRYa6N5MhqBudHHJ9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TpH4NOc0HJjOsGw3YKW4XG7mUeAvfzvHjGs5vZPM1JXrS3EnQAnVqcbAyGoE?=
 =?us-ascii?Q?QFjP9LwG0pYDzGvXnHklG2sxOH8J7S5WP1ke2x0utS9fqZ1c4/aKLdHwt4IM?=
 =?us-ascii?Q?QE655bnspC01PAsgnSAll0cP1rduYtQmWZLZ2a9vtGQK0Hx/e6DXvOYP8UKK?=
 =?us-ascii?Q?XzLiGmB2rG0kPneKFmrMiSfYfcU+ng8fitj4o1i5VAielRreNNChV4vlG6mC?=
 =?us-ascii?Q?wzcwHgY6dlU6KgBSoRuEsncByNMX5uxUnxxrNSVeDsXr+ZNon6+zdgRaQWFK?=
 =?us-ascii?Q?tTDEO0Tz2a1wE+Mqqpl6E8zkvdZQT5w5vJvE6bmNL7D24bzvvVnwMs6ebLJy?=
 =?us-ascii?Q?zpzk5MhJOQB7utelArHqZTGAfOkXhsveN1V2Uu+c+s77a77oPUZWFs0ysYkK?=
 =?us-ascii?Q?hQTwaJH585K7zMaF5l8GRsJrCQRCvUpRo3NJWSh3CslmTmXbvJ34UgaCkS+e?=
 =?us-ascii?Q?mdeM1Tj/LZ97BfzTdbDcQpQZ7huUkVRHYgvaoJAeapZR2hTSoGyQy+VlVjU+?=
 =?us-ascii?Q?CHrEim0u8IPioes3b5YlslsoEM6s+m/2SJrqos6cT9PG2GikiLIOGEoPHb4N?=
 =?us-ascii?Q?n8ir8cwV8b3hGko5IwVOjDppl3mHazR/6IyJ7PHkvMN/42o7YKV0o+0sHQYq?=
 =?us-ascii?Q?40W0S8ILVV23r9ezLK5FmJNTZ4gD0fmn4kIa7Nqc2hI+Z6hb/qR6zGjYS8dx?=
 =?us-ascii?Q?zW69pHuZD/RtsuPcSEAHEe7LNr6p6jQrku/2faKoNJKrzvb+y7zumzXuikus?=
 =?us-ascii?Q?emiQczMll4z/8mNjms1jUTpOpkiyJUjRqIvl0BvHIMoTPOtC49GkEx/vMU9E?=
 =?us-ascii?Q?tUzHJ/vUW5BDFyFTm7P022RKqrIY+u4+LW0Qr7rB84jauYjL3QodD1C9JIF/?=
 =?us-ascii?Q?t6zemkNlMEDGY23X4eLJ36qI3V9+Usc070ZZczpeQkN+HNDCTAD9Aw34d91d?=
 =?us-ascii?Q?0GWeViDYVT5l4Hy7mwKJJr0iwi3xO+UTL3o65JhEcFJda6eS+czy30IDhxkN?=
 =?us-ascii?Q?nTP4NUD+x0TWdelgFdS73ZykEDnmWnnwx6khooAFDqwUPAw9O/RY/J+ZNjhJ?=
 =?us-ascii?Q?qZoS7j1t+QIL6AU6PFOzDVXjG3EFhUQ11YUyNqbNoCXdRhILt3yOQq/GSAZ3?=
 =?us-ascii?Q?N7L1tAgaUn+KOTKEsv3mK6E57gAMk/gvFIAJsAf9ENCSHlI4fY/lQOn6rJ+e?=
 =?us-ascii?Q?zf1WOK1gLb6qI7UkcP14++GMfy99egIh75xr3f39o0ozmGBLlZ4xnowK0iIY?=
 =?us-ascii?Q?0/4Dy77lAbyd+z+bgE6EN0fUByKfTMKLemOt4Hm+XYSY1EuppI2ID6ySMpEW?=
 =?us-ascii?Q?VMVI+ugnTzXU0trHDVekm3zs5Of5xgPs81Wyoc9s2aMr/DguedHNob5dTfbW?=
 =?us-ascii?Q?Pg3O/UIQ2WTk6Y+ucD0Vj2yUR2NDRVJoCLDl/m/Gzngh1yv45xWgRV/ePzaQ?=
 =?us-ascii?Q?2fK2TlghZuRq1msVxYbhtbRoLOVPOIX1dEU4q5Q2z7hxQbZ4hTQyMXz1visZ?=
 =?us-ascii?Q?qGlcSNKumU0LXk61cxpBKS74nmswhiu12Z04Ed+K0uI5zOyw0GufMRxDPfyq?=
 =?us-ascii?Q?qoLeTs7tMJTUik+WwS0b8iV3qSYosaXG8/Uz+p4vnq1eMbftfSTseI8wY7zd?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qRgQ5s+2faTIJFaqBaVfaqbI4BGbIdIP26HJdZa1csQzIGNZjxB4/bT2yec1vzp0dTLm0CTVKSQSAXWknRCekNiv9jan3UpN6iDGBiZSfAgWj6m0CWa+DfvzZkJFdK35WWOYb9ZeD6x2YVlp1cst7s4CujvlroorpCGyB4K0U6Hhya8MxfZ84TpJKSebd/OUE2iUZCHu9LX0zrWOYmyVlrbldfSYH9PlPI9Wv3l9WkBF68hOqpjDIE4KAATXUudYl3wLuDpJ440c9UiPA2IIt6T3mDr8lCQkN+IT1jN//kBJI2xkem4OscwFp13o81zxhh8VUlzOyngQmYG7PtV57kiMkeyJHQaU8LvceJaN3gCzQMKDlfF1bZQvzmt7BvfDZawVn6zXEb5SnOj0a3c4r793qA5mDR9lKYf4AkPGiEkjBrciaAbrI+HD6XAUKFtseoZzo422s8RU0cswEvVb3ue1aLuKqrhxPKuSPuQkZL4IGn0Sz3beXf8LPYhE525n8GDifuZ5Z931g25fQULJyoZAlfz9uChEm+3qUthbCMGbRWx0x7Di9zghbfqbvoDwnx5jIkqXMqmldhXbVMBb9gZQ70qdHqZHEPuwn+mg4oA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15393e6f-3590-4f4e-d9dd-08dc36d644c3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 14:21:48.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cbE/BjA3N9FEYy4glMQfzoecjhFuKWy/o22wmiF7Flb54Gb+w4awd2g1a1n8XAM9hLrZBwfjg5Y0nKwZ3QaMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5886
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_09,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260108
X-Proofpoint-GUID: dOnZA-BnFOlQix8wNaggmLxLlArXU26U
X-Proofpoint-ORIG-GUID: dOnZA-BnFOlQix8wNaggmLxLlArXU26U

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in those kernels.

Therefore I've started an effort to backport NFSD-related fixes to
long-term stable kernels.

I consulted with GregKH and Sasha to ask their preferences about how
this should be done. They said a full subsystem backport is
preferred. Here's a status update.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes.


LTS v6.1.y

I've backported NFSD patches from v6.2 to v6.1.79 and am just now
completing our usual CI testing on this. You can find these patches
in the "nfsd-6.1.y" branch in the above repo.


LTS v5.15.y

I've backported NFSD patches from v6.2 through v5.16 to v5.15.149.
I have not begun testing this work. You can find these patches in
the "nfsd-5.15.y" branch in the above repo.


LTS v5.10.y

I've started backporting NFSD patches from v6.2 through v5.11 to
v5.10.210. I've gotten up to v5.15 so far. You can find these
patches in the "nfsd-5.10.y" branch in the above repo.


LTS v5.4.y

I'm not certain whether to pursue a backport for v5.4.y, as
backporting from v6.latest becomes increasingly difficult on older
kernels, and the user base for these is dwindling.

-- 
Chuck Lever

