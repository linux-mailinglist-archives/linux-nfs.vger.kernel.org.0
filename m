Return-Path: <linux-nfs+bounces-2917-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF78AD427
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 20:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66611B23EB3
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0441154C0B;
	Mon, 22 Apr 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UrWjcCTC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HfLMEATD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE0154453;
	Mon, 22 Apr 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811516; cv=fail; b=Lj1w/J1h3nv5ycLgKyMgrB3jh2SlVFIoTkUmxVBIUBrN8UKznSUSP5e7SoSMtKfJIu/+FU9LCIJwo4xyG+qoAydH54dUif66UT6DBI3uZrJE8Xcn7OcLP7kFXzF30cCnOoJSZdhYNjEcbzeD+zf9tFYEFqlbtjwsZnPMZoqqEWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811516; c=relaxed/simple;
	bh=OnJjerJ2TaQarPqs/FJe4AiyySZ/UX1lKLCq5HBxKDc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=XSgl8vHnGRawU5ZzG/I/iH63kqAFD/uDonARDZcSCPcgRteiYCYdmaYWDbRu0unB5jgZQ6KF4CxoUxrxVk1de36A/aQZnGDJIAFkgRJWEVO78sFo46KjcA40bU1p+AD21SB6PIQ5EJW4X9KRFP149QIhdwAS0Wmx5LGj0bOIWHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UrWjcCTC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HfLMEATD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHmjQu017368;
	Mon, 22 Apr 2024 18:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=e9Q/PK5WgAGyPIeSkdBHc8YWGlkE6RcD6ZBbv7CZh7I=;
 b=UrWjcCTCN3csm7TdGKxhIISdlSuwWJ4NTYOqe/AYxdwQu5EWbWvRMl5F739nYWSTw3nu
 7D3+4Bv5oyTlNfi9vMSAL6UIh/8zVLIpu6fZOb8wiqVQuj/fGJ1s78z9k0r5CvL35Q+Z
 gfcNyx9ek++SVQsIAWgNEvlMpDJ6f9AGwVGL7Yny4Z2Ng3m11gaveshu4JXBDczhJeFJ
 lzEFyIrmB4H0//4G6Ck8xbd9ZS4hX6JSGtUJ7yrAS8IhcfkhOR8g0f/V5nZDief+6w+x
 qtvhGehN5ETr5QT2yTYF+vPmudU2RrCy0DDRuTpdYmwnNqVIk525OpbAYUMyQC+KQy/I 1g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4beu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 18:45:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MIeTid020017;
	Mon, 22 Apr 2024 18:45:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45ck3pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 18:45:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Smeo9uFB48Ujo/UNvVOVfYBNGKlG+YxokIpvj1lExCNa72wAaWf4TTvUZnAgE8RfqLoPrHKm7+IYkI7q0SI2Oj8ZeIDj8M78pelYy80jYpQrtyAwwv4YqSPclYzTfEXdl/TQM4rkmyPt3XCNERYu9fFAUDUD1secsqhZ5ha4RFkP/U8eWsQ7+/E6lrmrHP3fPRlFagRfvXbDTTXc/LBHz0HtOBeeHAAI5Oae7//Oki6y6TeDmyzF695kqt6h7l3V9MD5j1dFUiPR6Qs3kSJRfRmmpPmO6l583bjRMlJlwF0+kDdxW2xW/c0VkqyGFewufqGPNEPtq0RxOYHOYzy2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9Q/PK5WgAGyPIeSkdBHc8YWGlkE6RcD6ZBbv7CZh7I=;
 b=et5tBYI3WuoGUd4eqzOiXFTbMcSaahf4UJNOewxnof8QWLY3njn7/rQI71Loy+WmK0pDKeUEEeuBZ//CzOV9grQFYgdDK20Dj3z2Rq/lP4NpuQqZAc7Pta1jSUB+lyWjy/9KVWWbmKxWNNMilQJo3n65a7Jewprvb+zcHKKMR3EkAjKsH5Byh+DyqlhP2FlLOfvu/IsUXgLTyaSfslSp6/mBKc5hvglruMuPDYKkBE+f7GeTUaCPV6puoSFHOxjyEJ8rhFcg/asYNQtrQFXO5OUqn+dvqzUIE5mPNzCzFRk7VeZynWTOrskhACCR3z1sHXT5mHYRXQriBKCqMl04EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9Q/PK5WgAGyPIeSkdBHc8YWGlkE6RcD6ZBbv7CZh7I=;
 b=HfLMEATDKVb5p+z/fSCNaO0gd0laww0IyGJVYs10h8WHLU4BrgRsmo6gR+f2Gjb7d0FVN+/gmEW0MOTgMlyNMjpH8Deyhoo6wuzvq7c3P6OSHzFbnJi8LIzVd7ilulLZ5d1HhFW9Gl4y3ET8oz4HxqO0QvWVzbUlohm3aM5+hd0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6450.namprd10.prod.outlook.com (2603:10b6:806:2a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 18:45:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 18:45:08 +0000
Date: Mon, 22 Apr 2024 14:45:05 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] 4th round of fixes for NFSD
Message-ID: <ZiawMYH0M7pXJWau@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:610:cc::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eeb431d-d8e6-4921-d24b-08dc62fc558c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rTVXdkA7FRqVogGeozzppTKaGcYpVuk0a8b0tHxyc7LM0J0WgaEvDXzyX1Rg?=
 =?us-ascii?Q?NxQdhc0oY+w3e/qkZxGk+1WER8+2edTRhVN69ENd7tZEivzseuHvzSpq6s+M?=
 =?us-ascii?Q?or1DahUa4NGDzpF6JBWuOc/Tvdm6VbYC5GR4mIgI/k+rJBQ9ELc3GkHHl2Z4?=
 =?us-ascii?Q?gxJhYSsGoTCbPqcYtY9EUagRjqF1GdGbLvdzpHAr9CVemt1Q8BZXwpDG+5Du?=
 =?us-ascii?Q?vloRB2EnqQvIqtCBsdPqVJJ1d1TWxmysAzr8NQF8cjRey3DnkOPd6eo64G/2?=
 =?us-ascii?Q?m7EPoLYgqQhpN3T40B3rmm8tSHJzF+xI49IzC61HtSQ68U0VzdfrdKMcvCO8?=
 =?us-ascii?Q?ixudQn+TyetU7dexhiH2fuatwrUNgzf6Hv2uFkHOa0n83qvhZUW9Vp0z8l4W?=
 =?us-ascii?Q?+LDq2oXZRluBCSY4dG/y9Y4HT5tW2l/LuKt1OarHNCVf5Akqj03W9B7VC0ad?=
 =?us-ascii?Q?YKzULKVRQp1NluhGuDz4+BbybSKjeAXCVKNXiHaprVmKjjYbHt+FCUG62gbV?=
 =?us-ascii?Q?T6WGZ5oemXQJWwsc8sllHqHt5kh9Mr9aS+flV6R6McaS8jfQrtgsBHf92WhJ?=
 =?us-ascii?Q?fKFBzHwqfLudi/0PHq7/tZXwQOYeGxLCbkZOlpLZyfyZdCv/Ik3aQ0U9003A?=
 =?us-ascii?Q?Z5tXd0bKs3NnIQYJBdfAkKYMIVEOI8iGDiV8uwI7aA5+t97AeTG3hg0q3BAQ?=
 =?us-ascii?Q?bDALsuuD0fFGvcA2AnBec4jOuuBAUhR8dCVtI1kr3JsCJE5/ibbIBjaPxbYg?=
 =?us-ascii?Q?Q3VHURmDf2znF1Gx4fEwF0qnaWhR3AaOFeqHfAZIQjDKP9R+A8/wPGWMz4m7?=
 =?us-ascii?Q?lz7Tjpto0iYXLq5/BdEaLAviNLp2zGbTSYtmIGVzLMVOU65FxfzUEx3ay5cv?=
 =?us-ascii?Q?lIPf/bGlXT7PNtFUpbGQqSTTGmiwJdvKY/MqdO63/2WtEtDYlzncxR7MY20f?=
 =?us-ascii?Q?/CxUOOWCbjt8PQZKdEZe+glts5MmQY93H2/CYPP9c7kIJ59efHm+k1lSqxrh?=
 =?us-ascii?Q?NNhDm1OQQ8+7GCFQ/AvgO3Q0CriwXcnPEKCNO6AFSL89dJmSr3qNLJtufG8m?=
 =?us-ascii?Q?tuQdfWBui31xP/ewo7GiLeyXQhq6yWS9twZpg3YiIeBTvVqGf8t43yXWRzXi?=
 =?us-ascii?Q?wA2uAf8fJH/LpmBr9mmwDRKBpcsd9+P1pOeihni5+npvCvrryb3v5HqC41QP?=
 =?us-ascii?Q?ixoOD0Ae22n662fVHeZGE+BnXUyWxap5hCht4h+QrWUTm0b/UQ1vz0QoysPU?=
 =?us-ascii?Q?I25UGYh3n67lfL2R3esscZz60hLcN2SMnlVwISr6wA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nOkwF+FKmp1IrispqeWD1RWxFd9raUvJ9Cy8ypxo+SqwiZln5ThEsqjrCwUZ?=
 =?us-ascii?Q?iTTYFgbPuXX2mzvYF+cC+VpGhqx0pqzbDWEvZ2z4nvXZtA66SaHkuoCR+f87?=
 =?us-ascii?Q?NkDh5wiFtEVFMoNsbJi73S8KOda7GguHBzXrqu/K2RwFsdpBUFpoOVTxuTYL?=
 =?us-ascii?Q?9FDDr98IDaNOfSrwtqtjBjTOIVtyp7vvy+j8bNpLwi7o37mW5MAy2AFcjipr?=
 =?us-ascii?Q?Ga+ONuxitcIKmOK5MwFq+wYm4s8PJ2s4t7igI8D4ggDQh2UN/9VQZqFcvZlF?=
 =?us-ascii?Q?Fl62KGm5YsxviKAnhOvDpF/IipzNvsIX4VddZNZFK0NzvG2rNgDMKiUdGXqH?=
 =?us-ascii?Q?F0MOKnYtDqpnv6yBmzoukDXl2FyysQ0w+bmTSeKMh9lBTrOrrTC/vOL6ETAq?=
 =?us-ascii?Q?HwDKFoVYYrdRy7RSl8bVLCw6ZWiHU8cFqMCe0MwACCZupHBkyoFvUhZgrc2b?=
 =?us-ascii?Q?zAYONzfc9onSsokHky1ad3SStWBoNj0TvhyJJf88GIsLg86iOym0T1zOkjFT?=
 =?us-ascii?Q?FnJzwKuHr3K/3YXsjdH0yQXyinSEcDp2/AgZBjbsJkcDpOSjs5vfmqpIksjB?=
 =?us-ascii?Q?oXRPgbbGyXS2Ksp4n+SiH3Kgpzi2gVPGzirbLVQ/8u6wrIsblUQn1fZeBDmT?=
 =?us-ascii?Q?mU7ePp8RL+KZMytw5l0/yCnEuRRM+pxZv1EIP5KFD+p+5983wmVUH/npIoPZ?=
 =?us-ascii?Q?2tLfigVpLeHGOJQMN9Tg4zk9m6FVbQs8qbS0YaA4dWRAR3yLR4tnHlb9WZs+?=
 =?us-ascii?Q?WntkF599xTGfy8NSQ157qzgHR2x223uORpqUbQ0NC88Dt9nMFsmRN1EqOJaG?=
 =?us-ascii?Q?QIQgO9J90+w14fk2gfNHYdESt4NAeZnJ5mwVldbGjkUz1EyssaSJJjJerfmc?=
 =?us-ascii?Q?uGxiffC5eyMeIDaKry98yHvDLCK+LxuRg1nMhP778VP+bW1m5sJ86AaRETjz?=
 =?us-ascii?Q?z87Am/YDgD7PHsbf5XW2y/YdTSjAP+nYufK1kTpQqTRCdMfaLsYfckNCq57b?=
 =?us-ascii?Q?68AIX9IFljkIq5Ad9dUuf2uvQA2JlTL1wA8LHx2+I3FFnb3ReZ9NWdNgWtRJ?=
 =?us-ascii?Q?ryNzd9SQZrC5tsv8JRfQ0w3rSTap9BmqWJ4JbiIrPEvZUnrQp6MOnDc3HlpT?=
 =?us-ascii?Q?2thXJG8iqtePIFWndsYGWbYdW1dsHilLBtCSiGL/wcroi2j6XSsCyFgy/KlW?=
 =?us-ascii?Q?dzWe87OELU42I6+AaYQbqIS5eq/0xK5UaiYz/ZqJGsLcONNroEGz2s9IkX0M?=
 =?us-ascii?Q?7c7SHBjlBlNipd+IZGlUphq7enIFjyfqvlzu73IIHCktPB/NeYc+yDS7XyJc?=
 =?us-ascii?Q?m3MpR5Z5lnuEaWsH/9GbVUFlzBssB5r2Vl0/g8x2gUxdrTbLjTdSjJoKDfbB?=
 =?us-ascii?Q?K0ZyFoaqSfaWN6cYtZ0MCNMC6HjFjLgjy3kC4CnJESlY9XXskyyvT7v+jbZY?=
 =?us-ascii?Q?ckJfQKE9OPzPBeccDPZM4YACUClO3tfUl7XqVYMJLjPq7LDO+3EG6wg/UX/Q?=
 =?us-ascii?Q?/QaMiErI7/HqYb0qqOpvoabnjF/mW913YbPQu2v+INwcFKiWEUhyHpxLidFP?=
 =?us-ascii?Q?D8JyvJv490vaJHuaBPXJyQsEs5QTp5z6+WpsNSUOINUl7T4TSLwhnoykjtMG?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kca0bK8Df3WHlsknomZMEn91e84SqKtGXlOTqKoLBkNUvMGq1nIADDYfQo2CEggBFpYIWe5+4KHGNyPjm8GLefuh5qUjIm4pY+a4zQXzq1gXx+YJz9sVmAgbYEcjN2i1eVaTAJBFSYSCe3+wYSOXwNRwzrFRlTlersCB20PTV/wiAN+QzyvQ3nKGxAvNuhgN53Lo9NFADSkANuPQwEfbgzoUdvYpte27+5s0ksjcHHhVBcWPstWQ0rZ5BN+LXTGAU9s66Ferz/vOjVEG4uw9iRfaVdPLWQEKb8kh2RRgc4yss218WrBBV0RaonT3Voha9vEXJuTINKQGbSIL8dH/n7Oo7edTWmKC/KYh+s+dtkk3jZzt7iCmL5gEWrbnT+jcDbDLaACE+OZ9C/tVn6ftYtYH3Rnm+BPwMdBcARw2hOF2xpdNFG38KHBIm4C50dSvXZvT2DepXHdoMHNDnF7Wj+79fvtTMCbJvMSWuY/zq+ngy4fnKp0MQ3TXb2NA+2w2rfcR/Pgpc/pEdamZ0ow0c1uuMbr7ah1qZI2h9BKYaNAIVXLvpTy4PDbo2EDxRMEJHg+cs6DyD9/T8OfPsEFBtsdIZQXO6y4uBo9paef9oiI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eeb431d-d8e6-4921-d24b-08dc62fc558c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 18:45:08.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSf3KcHxhCV8SmBurBpKyV0gZWRgyV94KInFQR74XF0xDpQXQGMjPfOT1Q6UbbmZ7SvWMJqku05NRJSIZqxmhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_13,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=808 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220079
X-Proofpoint-GUID: TZ1aOOSQssgdJ15evegXRToewVPeQAL1
X-Proofpoint-ORIG-GUID: TZ1aOOSQssgdJ15evegXRToewVPeQAL1

Hi Linus-

The following changes since commit f488138b526715c6d2568d7329c4477911be4210:

  NFSD: fix endianness issue in nfsd4_encode_fattr4 (2024-04-11 09:21:06 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-4

for you to fetch changes up to 32cf5a4eda464d76d553ee3f1b06c4d33d796c52:

  Revert "svcrdma: Add Write chunk WRs to the RPC's Send WR chain" (2024-04-20 11:20:41 -0400)

----------------------------------------------------------------
nfsd-6.9 fixes:
- Fix an NFS/RDMA performance regression in v6.9-rc

----------------------------------------------------------------
Chuck Lever (1):
      Revert "svcrdma: Add Write chunk WRs to the RPC's Send WR chain"

 include/linux/sunrpc/svc_rdma.h       | 13 +++----------
 net/sunrpc/xprtrdma/svc_rdma_rw.c     | 86 ++++++++++++++++++++++----------------------------------------------------------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |  5 +----
 3 files changed, 26 insertions(+), 78 deletions(-)

-- 
Chuck Lever

