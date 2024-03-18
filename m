Return-Path: <linux-nfs+bounces-2376-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5666587F0F9
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 21:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF04F1F23FB1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Mar 2024 20:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E235A57339;
	Mon, 18 Mar 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="THq84/Z8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Swiug4te"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316F57326
	for <linux-nfs@vger.kernel.org>; Mon, 18 Mar 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792750; cv=fail; b=B8SaVO+YE4PtpLfQiNl8mMWbp7keGtqHFhf4fxN5RkCm1/cHbv/hJ45quyD2x3XyXjfgu9XsdwtNxVXirJIycwCPODSHQYLokbwljjYxdilqmaloh91JVuA/ejBcj+9YU1UQBh9qzqsR7PvTwCjrg3bcfiPTZft4Ag5CN65icKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792750; c=relaxed/simple;
	bh=Puh6Z7qq3Zoy8+kEIa17mDX+F/uQ107F+5Hohy0/w1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IFsTWCYYTT8XtEu8/435AWqxLtFxiiw5l+1tnFHapWsWPMk+zNNhI/DzR9+UBczlE4LXmxY+n2lIMg+wSn1hDFx0I17r8zDsFpsxzFJGXGAhVQfpZJ4uhW/GL3PMArCPKG6Kl1kYrhnq4RX3TNmRgwKw30SgYrTNu1JDitfDjW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=THq84/Z8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Swiug4te; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IDO42L010595;
	Mon, 18 Mar 2024 20:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=L2Ulep1k/dhAtJUNqyHFTN8eH9ABOkRhY68IkHE6S4M=;
 b=THq84/Z8L7BGOqSiVYFHOnWaMJ+C28n3ueIiFvQawCqqlAYu2jng8vUQE0DyZdBle0zr
 kOEYsCVd3xzrE+22eqU05qRL3ZtUUjbdG2WqZdQUhMliy7F203K4aJsG6MNuNcNWmWuf
 XNWgd43S3fMzE8upahS5k9MpfVkuCsX9uZyVC+nEEi9MGQdOBzNm7uwwygjiszYF/t8u
 CgYf/+TLvt0ruyjQNFvEdriHax17rDD9r3X2zCdIu6mMRFiWGK70JoOO2xpJRth20K+U
 TOQucnF2N2Tz5MDbDFG/XqroZFLSUHgswqXr31T2HSlnlZEkktw7XsCrRUr61rsnS9by 0g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1udbxb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 20:12:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42IJ0tYL003720;
	Mon, 18 Mar 2024 20:12:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v5axbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 20:12:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeqoCuboiPf3Q1BNdsyI+vLAktagL+ueULdfQGTd/WQcCXOfXUpB0lvG2flOdy+9hypuPrQ4lorgrNWOT+E920qxSJoKsdFQ4MYL2w9tNWZeD8RsJSMA0KwuqKcQK+0lKS+kgd9kdWR6FkEXEak8IP/35AvMecOya3Cy2bhzAskClxFenmFmf6b5VUntlErq9Q77FCya9gxR9zuJezfCilBzKpPIeu3uJOpUst/b9bQTfVJpEjLahGEp28Vfn2/znaqFw7769yVsL8f1Qvn1g3n+8Prqz3wAavlFlyknQYtjA/715MAITHtRisT+SKk6GyTS63Su/esAyo80bIucOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2Ulep1k/dhAtJUNqyHFTN8eH9ABOkRhY68IkHE6S4M=;
 b=YujeDtMdUS7I5vbmnusYQM9shODQ9USzvzUbpAAW8H9VOjdZfUwu1lA5l/2u83WAHUuqrVjqR9GF+etvVI6/7vL8ER68tdqmLp9M2yAxf7792ZsdV4Lv7OC0kKMUojkueOx/2aN9f+cQEiw+65znuuY+xJbA47DRV8cqBbJEc/vmdFAoatLH7g3rO7qPbDGayy58qTu90z9UbbXWRC9Io+HfO6P3DecS61mQHjWBWr6B1zPjWQOWnpua2V/PpT6MqUt1T3byO9JTRPFOvP4BY45k2orngn5Wt38epnVHIPJRxp0kQYg7/kZ3E8pZ2OvpXhLyS1cDA+gCv7q+tAE61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2Ulep1k/dhAtJUNqyHFTN8eH9ABOkRhY68IkHE6S4M=;
 b=Swiug4telXJv7/2Bzx+3Q1yq9eRvGp46pKvP5hqzhFTZ5KwfXgbNmnbvRfnXWdTvQPOn4hBAdDq4/DiY6INie0jmbxiiBne8MKDgoH1s8oqbgDUVYnr5V+s76PcBsz86XVnsDL/G7dqpMX6XqXqr+mByr4f+RRTg0tuOzf6tYjc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7310.namprd10.prod.outlook.com (2603:10b6:208:3ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 20:12:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 20:12:20 +0000
Date: Mon, 18 Mar 2024 16:12:17 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: Fix error cleanup path in nfsd_rename()
Message-ID: <ZfigId5Anil0U3cs@manet.1015granger.net>
References: <20240318163209.26493-1-jack@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318163209.26493-1-jack@suse.cz>
X-ClientProxiedBy: CH2PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:610:4e::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7310:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z3pLzieUC7/gq3oddCg1Y7B0lQktHtLB5v0REeDAgudMt939PTS0oIohUDzrquJCojJpPhKuhEjl8VOMGTBYBTf/xJIM5qcbyuT0wM0MmST0r5z6l1SL5Zb4CprLHcXGgNtLj5B8/93Icn0sZyy504WV48/4SnBYRlK2mZunjFadiIQHJW4NPM9y5BA4Cdvl0bKh0rdgzru89TZYwibsWbksuwSPhReUCj0pp9mCNcXO8FApngPIj8BDLvsrbv3SgLc9RvbDyPeLKPCzBMVFjtfHrNroBkLTWv4R5tOgTSXWd0olD6TB3KuAXSWk9QcMKMrs6sreLiKV1yeP3gKmNFTSgXU6TkUZVttTXp+XLEDrV+bZVoxm4F6EGf1mSmPYWiJkS4xKeH9txl2Iq90rWj+P8qKCyGjmIvjBo5KpCKf66LmvQfEa33+LkdRcTDeBiN+1RGiKn4fCciWYovDHstMyZ/Y6AnnI4+maxj+0hkHl8Xfg/LlDTNHSzmm18C91gwcckWEnViZQvmDY1v6Gpvv9w/+YjExrvemhh00P2GLtBT8/VThGwEVytfgKZznZsUVltmzMmXFx1RhYpqJi8suDbTNhqJbjeGx2pa5b0+XKsvA0yMVLoEpgtf58+Lj57rAwA1+h1LyzogLE5BoUnZSxmOBxIPBht9tZJUZjJ8k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9xJa4K7eFuuFZVuVbKyk7ujmyfcAc3iKYMyrENI8RdEP4a2JHLvqnH3kaHW5?=
 =?us-ascii?Q?e03K6/QWSTGX1Y+8AQXvrSw0RsPkoRHGQe+dtXDExnAzV+KvRoK7DXsnKJ3M?=
 =?us-ascii?Q?nAb7ee+nQPdY8mrqLVch2QU2z32PKo6ojo3P7Ol1Ujb0ROTzl9G8i8c4+Hsb?=
 =?us-ascii?Q?T1GEB+jLCENa/ly8NiKQGxBcEULyOkE+2qL3/R7sECBPy54voPVnNVbPemPA?=
 =?us-ascii?Q?JRkIvHr7zfRuXthQglAZEJHnzSpvWlMR45NbWDM5ndsQqqxG533JeUCtzsqW?=
 =?us-ascii?Q?r4Es9do+4UsNsnZo0VcdQAj6Egm9WXCZvXIrm2XalRk1Gl26W5H3kMyrq/Tm?=
 =?us-ascii?Q?stRC8scZgXKTBwFMtq98jDh3WjViSM0PAU2TZGofs423CS+IhIO8zc91yJc2?=
 =?us-ascii?Q?Y4L0MbW5qwEST3wXsF8VkT4LJmKihhGI5tW4W1J2MsKO2EvTvCRX4gnmuK7P?=
 =?us-ascii?Q?avpQttOke9J3xIHNWrU+aP3TD6fBocB/Ih3z0jrQ+1LUPuVOo5bsTkeGLTgP?=
 =?us-ascii?Q?AZ5pf3xu/IXFr+Cjny3nAu9cwca/HfhO0XddPaNWgt4PWp+j1TMElZB2Xqu5?=
 =?us-ascii?Q?e3kKLW9Y0Uks30TufV4iJUbzQajaH7wkjZcprOIvllfuYZLy+fthzdM9ko+J?=
 =?us-ascii?Q?Xs6UsJDMLTKkgmDuOg7XiCG4YAncs/lfR/oa2gsP5X/G7XkS1Ek0GSByV3UK?=
 =?us-ascii?Q?IasXk9xi2DoEU22MkR8hrTtWPkZME8/ZmBvEWlG7yS1FUtOq3aFxpcYgvtK/?=
 =?us-ascii?Q?51pCDGfC4XGrhxDVXtrzv+Sr3XyWa2PCc+gGb4Lekd1xMDAkTPEz6GHZlKm6?=
 =?us-ascii?Q?ktr7KEkNRqSNSXPET7R5ySDo0gHGg+awo4GXYOnSzM/a12HtuH8oxBk8KNnx?=
 =?us-ascii?Q?SkmmorGlKxEu6bnB9eohKDhnu6rQ2Qcf8fqfuSLAZM71D6s2qLCGb/rdJ7XQ?=
 =?us-ascii?Q?TRnePaxKOB5ll5aHec4/swNG1O4DN8aT72sg77IqkNZoPHiysCbgRGNNONOz?=
 =?us-ascii?Q?0E/GaH2vXMbHPOz0j0lx2v6glpMOpmTShFI3doHxJlx4d0+2HEgBhxaJVtDn?=
 =?us-ascii?Q?9Q6bNcZyySdCkZ8TJvRTbAJZH6FjskXEf8n+iWmeOm/lhIrcp/Wz6JRePTd4?=
 =?us-ascii?Q?MVPJ83dFlZrCjTyDrGj/xQE6MWv2iRWMYu38AZV5HcZrnhcd7pmnref1lDzj?=
 =?us-ascii?Q?+WiOuRaGXBwOkI6WHgRDfjbr+BNyYp4+WM/N9yRoKw4WuTaC+MepSAbW4lAL?=
 =?us-ascii?Q?ZTHXjsixE5RrHFqNMEL+nIS08W5kFpXejzkH0ljoAgp2dMBCB+N31hqaVobX?=
 =?us-ascii?Q?MXdfTgQAsrB2cg0vcRRz5WNnK/IhHLVSWC6H8NSKl+OvRgCrhctQRNKwUs0Z?=
 =?us-ascii?Q?BElwzPXVEac64ZlkkamDegwh6Yn9BRHCO+IDSpTP1s1zVIelseUmp5HsuJEN?=
 =?us-ascii?Q?er0oDZLNpabKulow6zsp+ExaryN96K5c0Kzp4ivCvSDEsgGXYeicRk6oYhfF?=
 =?us-ascii?Q?l7UXAC+Xu+6TXYXPi8h15frnb8x7H1mAZTtIng1h6hYKDTXr0+2Flih7EeNW?=
 =?us-ascii?Q?quytqvszspe9jGeGHJeO4T4Aiej3LWKOAg/ZsFP4xYefH0v8p7yaMZNUkHSI?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sCy5TPTV6majpTB2bGbezAMialLxgA/hpzU8jmG7/yUzRPCypWxZKUK2osXzl79YbWtLRbdS45PCkduaVeOSRnKmqkYWUBsJvF2Gi4BwTOrgyUEvX8fVQ+NRzVTb1HkzePATw7ytD5eFrvw0HN/4r0SqeAS4w3Z08QU6A30Uj+A0mnK68IcPyElL7TpnpAW09HjsYyBmCLWfzHXLXEqLzw+S+QBFk11bP0DnYiuW89npeYxd6xYips+tPSqw0aFO6HagR4xsvpxXNoRDHWMNVCRzuT7OzIrYw0M0S0wDVEA6KWRjgB6fdmO6vpuNMlr45HA4Ayel6NucFcoQMo/q9AVmkfyfBZY/7bdN7rQfxFIKydd0zImlUvCj+kq6p3heKjrjFm/Fp+2TP5bDEaf+vFpQVbUwkuA4hRn/niOtxSOahWgzeA/LC+BP6etFqytIpDLHpO/TRbl8hLxLlUSgfWLptWiSzwd4+aag4a7CctUFIxRDNApcV6FzWYXe041aDNaKpr9l3QUbSbH2pkPgkXTycVF3DvdjnRyBoBXKPh2T7VQZR2AI0OkrNLOAp95iMPhO6NkPXJb3Fi8TbIkz2JvnKkhD9EYQ0/J3UHbgK+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33dff2f-c889-4e14-c65d-08dc4787b79b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:12:20.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6R7rjGhsoG8d6a1qT20tqIUYJ+i94G46exSyYqffI9QYiwECkgI8X5n1rUAMh1oYKqT39uRPD/ibp6vT9Mr3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403180153
X-Proofpoint-GUID: imHFKDkcj_uyNiDcZ1mRZoOvpRZBPA9-
X-Proofpoint-ORIG-GUID: imHFKDkcj_uyNiDcZ1mRZoOvpRZBPA9-

On Mon, Mar 18, 2024 at 05:32:09PM +0100, Jan Kara wrote:
> Commit a8b0026847b8 ("rename(): avoid a deadlock in the case of parents
> having no common ancestor") added an error bail out path. However this
> path does not drop the remount protection that has been acquired. Fix
> the cleanup path to properly drop the remount protection.
> 
> Fixes: a8b0026847b8 ("rename(): avoid a deadlock in the case of parents having no common ancestor")
> Signed-off-by: Jan Kara <jack@suse.cz>

Al, Jan, let me know if you'd like me to take this through the
nfsd tree for v6.9-rc. If not:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  fs/nfsd/vfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 6a9464262fae..2e41eb4c3cec 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1852,7 +1852,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	trap = lock_rename(tdentry, fdentry);
>  	if (IS_ERR(trap)) {
>  		err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
> -		goto out;
> +		goto out_want_write;
>  	}
>  	err = fh_fill_pre_attrs(ffhp);
>  	if (err != nfs_ok)
> @@ -1922,6 +1922,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	}
>  out_unlock:
>  	unlock_rename(tdentry, fdentry);
> +out_want_write:
>  	fh_drop_write(ffhp);
>  
>  	/*
> -- 
> 2.35.3
> 

-- 
Chuck Lever

