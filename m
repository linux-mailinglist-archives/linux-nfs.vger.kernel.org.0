Return-Path: <linux-nfs+bounces-2581-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C1A893C2F
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 16:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16EFB210C9
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB57040BFD;
	Mon,  1 Apr 2024 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QTRJ7qyZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jy+4kztc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB143AB3
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981352; cv=fail; b=LmUNNkVmJuGdyeBTKcEGFNT5hyxGLSveRPImRyOFH0/Se0QBYnz1MHZLgRKydayVyupRTVfnWw1cobJ7fsIi0R27DHhvvFc5Dcud1+zgXXBjEPLqQaqOexZG1/RG9xtOn5ijzbE6e99h5qETZ0fDQXb2CzDL2mxfHN2nHh2g1M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981352; c=relaxed/simple;
	bh=cRMzvx1fWg33+Z3NtwJg3Fv4fKut2JnvqQybDPmWZGg=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=Nh+30fcxqhtZq0ysgeXtHR6cv/manuy4oQkbzv8Gt21LHCOJiJgF35mROUitBWjLjVdlpO5Lv/IC/j2RYn7wqjjbCw5GmWatFszeZMzLpHNLAZPI3BbLNOBEbeh0m1BOdPPofNs5kjY9FfZRE4tflcMLBwP/ms+NlW6iwYak7h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QTRJ7qyZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jy+4kztc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4318j0d8006795
	for <linux-nfs@vger.kernel.org>; Mon, 1 Apr 2024 14:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=H2yslsFFvSVP1GcPxjWfWu4qzuoEGNWJ5r4mj2KQWzA=;
 b=QTRJ7qyZqs9zjZUrIJU1mQB7gX+y4ngk52zslf5BtsMG6xIea17XOmibK20LEaq74HPX
 JFJzXLPjVC0T2vPh4r7hWsrBsOhemsJYSRNr94e3mFkBsD+ENqzgXN4YIebqrVRGawW+
 RjnQ1FruBTuc//slB2Q9MzZnULNuJiloLmU/h7nTLxfmphywdQ3WSe2AfZQpr7zGCdhC
 8SYtgkIaQOBhcZl1e0ALVpRUHfXUO1iVnb7ZRUx6isVZ3ZkACmULLCcrxj4IeUYzC9bV
 bW3aaRwno6IMS6XRR2Q+XA7HH75n6t8SDe35V0mqZixZzOpYRko0IgNaWdmoABoeWyQI FQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x69ncjg9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 01 Apr 2024 14:22:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 431Dgv45011647
	for <linux-nfs@vger.kernel.org>; Mon, 1 Apr 2024 14:22:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x696bxqr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 01 Apr 2024 14:22:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwU+fFCY1y/6XUXXtZZedt0izf5wTLzwSnn9kuSmwh1tT11K+/MoFgdao5a1P9YqvkZenQqqXUGAuRhgCmQcru8AA8megtL8aWrJPHNiN0S49P+qvSBxIQBPwBStRYXVKmEdhrMjMo+Vu2YN6jyhPnghgNxO9AdmL7hM5Mty/mkk96dtEHDgx1Ghwu4ecDb1OcNOhZDlthqQ9pmFWSIFs0xP/m/qlW7yp8drEdGIS6NxzdJq65DrA1q4AqvRat6gn2NBTkNp48ISKqJYddiDcYHmQbKJrV0h41PcjnQ6PKrGo7elmUFXfOGaf/KgLA5Kbusf6gf0R1y5xsV5I1cSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2yslsFFvSVP1GcPxjWfWu4qzuoEGNWJ5r4mj2KQWzA=;
 b=TeKMal5r7znt3N4+8v671DTbpOjvB49cg3f7uU+/KxOwMwiaqK1xOs2VhBwCymt/XxmD1g4G5BiLBA8J1QyB72872ij1s1z/GuLIJWtwtmlf6a/c5ffGwNBcqFy40NoeLyUweLmxscpZA+T4a26VylrjPlijABmJJ5EPgOcXyv505bxVJI8zE4hcWEFnlNHsDY2m6RkgaILpRHC3RekVmksk/lvubmhmCQU70R6SY9Tcdx5z23hFkNDvcwQXE/u21eDuXXcm3cGcovWl7S1vODHV3rGJIdYUa/Nncj4U+cTx6GIF7jxp9xozf03zQFFq4CbPecw/7JsSZUKNzEzpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2yslsFFvSVP1GcPxjWfWu4qzuoEGNWJ5r4mj2KQWzA=;
 b=Jy+4kztcvlH3e1F+O1cjC+gxwFYUgLdcfa8jLeV9cFkMN/ZSuZib4q/AeyGh1rw5nDnnGTYJwProIrYh+I1TZ1lMJrRAH80bI0P5gBeun3FQ6/8zE7I6miV2K7Sq0pwbQJNuZTaZ7UDOGKT1WDRlPpNgCS6yaJ1xuJJ1fpmrhDw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7267.namprd10.prod.outlook.com (2603:10b6:930:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 14:22:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 14:22:25 +0000
Date: Mon, 1 Apr 2024 10:22:22 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZgrDHmiOCixMnRlu@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH5P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7267:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+6YSY7gCoSuEvgfGQ8L0IxFAJ2EBsm5JjAVf5R5HwCdZleiFQdTnBQyMRLBZJimiJ3SSySr1H8XyDAYYfrULfeVWDwGaVzqJ9W3I14W8tCEejnxleEGElCtfgjtGLkmLR9hdH7EquLNvb9dLxPQ9sCXRH2n1S+r7560brcBUqYNmYMg6n5q3AKh7nKub8bQINA14evkXaXf8naxE/NounYTYlw3ZONQrKIGLoJiw49hoZb1DYkfs8LEzxE34hTKhrl7g2fiicuXjGVRXJ8WaknwmGp65qQ9YVcVp/xxcvE4gQf2rLnbYyKgTyypFjiH7OVb2u+iD8CAj0lmoImMLsXHHWNZQUO2w/NYe3AKk106JBkTXpFKyKJVsGc3sd9zq88XLXCm1bwhBjwOO1WEe2UYw8umIx9H95Go4W9Wev8qcpcUDoVVCkpxCIQo+04ZTuKZYe4C3/1H++xR1rvXbjCeMeN43S+C4IXID1Li9kXTaGXG0C02gF9JfmMbLpjEnP5CUH2Yr5qdMgoP4DFwhk693OW8zbI0ZzRvhtkLYMH0Xytu2gClBgaTvisooLwvV/EnrlEE2VquCcqIRvympw/yB0eJbE45hqmSxADqtVGI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YvV/62kxBbdVQ5KqAWFaVWGpValgoIejmxBXLmBC/2H5+2YjTHaEWPZei9hk?=
 =?us-ascii?Q?brpbo45qeUKQDkW6Wm45RPTJz+Pzu8SUtcRV6MpHNes/qwbTwB5MmWCacm8r?=
 =?us-ascii?Q?yNcfJc+44DyMxV0bJ0MQHM3+Q7bI9egoA1OyLG+an3Hc84rtL73ziwdicZCT?=
 =?us-ascii?Q?jdvXccEHOlTC2Tm+2IeO7fewawmEn03KTcK2jzbapQm76+gMvEMF5uRG1/FY?=
 =?us-ascii?Q?pHGsebkaUA2xs6L/8vO/vfr1BU4u2QzNGNfv5+3tplPqV2UtHJ/KU5IKl0bb?=
 =?us-ascii?Q?LMBE2PONXEmGru9WxbCb7PdTy2qOwKt7vWRoJnxX0rzkqYbQeQT0Aq0Xm96P?=
 =?us-ascii?Q?PbQUpPY83MNwGFm0nfwHpfQdZMVYCnskKDPXoI09z8Jk9Ih3mYncCGWMuswh?=
 =?us-ascii?Q?iPFYZi9YCiyA3+VNH1CeJxIakz2Co6CQHa3kM6vsByPBX3yj1TmZuYl8l4/+?=
 =?us-ascii?Q?sSXxOVVRy0dr5HPUvZabYrXSVmaofEsucBQEjMaoVWWGoXcMUXZrpzpmHGRV?=
 =?us-ascii?Q?p+MeL/0thZUkVD3y9dXSKA4R2ITfJPOLa/5tUcNwB725ZsVz3wnXmPlCZu2y?=
 =?us-ascii?Q?fPckyL8gP8AP3bthahW2EA3oFV4zdy4QlYKPcgZ08RMG/AOztF6YNLYGax+Q?=
 =?us-ascii?Q?XXUlN6IMLxqX8f+qniygzY6YRjNeveltHNES9YvGd+vpNJCCActq38dPEP28?=
 =?us-ascii?Q?POvvatuixjTQ6CH2EaU2E3CaMsnjZR1vI9oCJVdbjRuqLTGX7YQeknw75sj9?=
 =?us-ascii?Q?my/K6Zp6F9Ed+2Wy3c2qi99mBspPpnViWzN9frYq3ZDxe6n2zFPRiDURTSYc?=
 =?us-ascii?Q?It3ArbTYl3NJeKHzolG3LPzhy1W22kIIRWP3gyH8yrqa1mIm9pq2Z7eAzLYD?=
 =?us-ascii?Q?dMuczODENbKglM7iLpeTXMkrmy1GhxrizqGNuJfV811vyOPt1Wzif95nl80F?=
 =?us-ascii?Q?cKknLaRw7ijtVL0xpBiLlwm6vat9/XME7Jw7CnjvAUEix35jFAA43MV+9qvs?=
 =?us-ascii?Q?Z1UG34rXh0iDgyGQOwqwPZQI3v0DlvswbOewFiSPtMCT8z21k/dQ0SCSpSib?=
 =?us-ascii?Q?JkVejN/+86VSTkn++06/mKkhNBrz8/5/ANzV/Q5xAkJIGVVD865+PIRXijbN?=
 =?us-ascii?Q?jLkU2bdmChvo3LtKJJt3tBhVGUORXUe4crG54gT+WhFJb7lYjZSGNR7238T3?=
 =?us-ascii?Q?dayvjOg127KTsg4LL2QyYmH1NjY9os1hmNmk71TOldTbQV/xDXGCeTH9kO+x?=
 =?us-ascii?Q?9zubg7ai0oNXAQBnjsYksrc4Wr5FhvwzWaGlI9YnlWJRpJSNmyxuztHTSIxs?=
 =?us-ascii?Q?Vk4yoWlUOS5hXZ3aGGnXMBP7WFU4F8X9BSwcw8r12LIn/PqdKcVvFUPxRanF?=
 =?us-ascii?Q?BwqGgPg5xOW5m4/ImYwqykSw+zCF7ncG10DBe91zpq+fniuGa/3jsayQfSqA?=
 =?us-ascii?Q?10rGQp61IrHZZSg5PyVRjSox4KKMvnjBokN0zilUOySqam3yTxdgm8melL0b?=
 =?us-ascii?Q?AAb1ckIOKkgdA2t03U6zwSWopwlRjHgSCHblqgZpqhb+IJsuQ77UtaVbNX9o?=
 =?us-ascii?Q?F2sSEFW/5lALi/x4wSvEQm6B7bhaLpqrOUhOiMMRvgwbHfT2wdTt4ieRGfbA?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ue3qXzcdv1XX8G+y8cJSsHuYOdNaeNxz5/UplFDpDw/Dg0ldPQJ3PqNWQbBCcDvlNWj4KCd2aOCJPfxkX55CW+Oia4lN3YzgotozLmf5FaRGsNebCqCSftlZj8PlUhOthJg+T9MwcIF3QHoiIqVzSFiiIksNMyKIOKF1+wEx1L5f/wnOm17+S9rijSEKw23RUH53oc2kAt2piM7UBv66Nv4gn5GMckn6MGCYqkT5jBLkUMYvhwX7p4sL2KuCqhUzX9LtWERdwgZi8l+X9SrqzFzYTcwh/JIqSefhedfGj4L8+nMweVGPjR3udagnCM72rtxJ1fWd/fckEIc1G3MacsryMAQB+N9cwl2DK3WiAj0WIV69oxgRJE1OTxCwOzyiXaUI161qm0VbeOuzfysD/M9lNvZc/yzbFffOx6LjV77TDFURlIX5jYjXRbVeVTifLcnbHY/kw0J+iT+0Y4tNLaW48uqaAxoRg92bBTfKZ6w1PhtoywvBoh9wbtDT9TrkUwirccTwDlTFkGHwjnf00xhItTvWsM76a12NPTJuRK3QOBATYuqukBQOv/hJuUsPQ9pScY3OtpJIatLI9fzrQQP4F0C8rQtgsHToKWUm0Bs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2590031-3e80-43fe-81b4-08dc52572775
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 14:22:25.8397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58QDihd7+ivBSAc7mB/U6wKDeYPKe95CXW74L2WOSH32Iz2rGNvQwH3ENtbn4ZaaKb51RTVUA51ZN/OGiDLmZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=874
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010102
X-Proofpoint-GUID: HovizFQ9vJezgptfgawFcn3sGmncWO8F
X-Proofpoint-ORIG-GUID: HovizFQ9vJezgptfgawFcn3sGmncWO8F

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. The backported commits are destined for the
official LTS kernel branches so that distributions can easily
integrate them into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

Here's a status update.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v6.1.y

This part of the project is complete, and this branch has been
removed from my repo.


LTS v5.15.y

This branch has been rebased on 5.15.153 and resubmitted to the
stable maintainers. Once it is merged, there are several fanotify-
related user documentation changes that are needed.

You can find these patches in the "nfsd-5.15.y" branch in the above
repo.


LTS v5.10.y

This branch has been rebased on 5.10.214. I've done some reworking
on this one, but it is not yet complete. Once v5.15.y is complete,
I will start work on this branch again in earnest.

You can find these patches in the "nfsd-5.10.y" branch in the above
repo.


-- 
Chuck Lever

