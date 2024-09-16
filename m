Return-Path: <linux-nfs+bounces-6516-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EC997A571
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 17:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E2828255B
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D9A158851;
	Mon, 16 Sep 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KcRCutgD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="og3sGM0+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5A1494A5;
	Mon, 16 Sep 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726501477; cv=fail; b=qYCD7b/Q11sfrnFSc0iOWkJY+ADgXfVtVspdgHeVeI9j33yOAC2s4QKpl82wWedCcMouCB4V/dOfL0s7Nl9Nds/TG7IX2ZjQ23TbUijD9tZA5nCyLQ+27z/d+0TQHSV3dF0F7JOBq9aQHsX6uNowknxvnku3Kw3qtc+6mRBjCYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726501477; c=relaxed/simple;
	bh=hzX+zM8QNQjHUfyYHeHNoi0txJqT6wcqpuggsGmbV9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pwo/Cl6X20CfOh4CwvphGKei3ps474s2WACUVF/zzbOB09p/G+Jmd09MXqnPFLGaEOWpqO2D1i0nbDERJ9Yp64GJTZsCJDwePfzBS8lITWG4RmNE+W4mXmMMnf8cTmZjEVU1qBETbBR+hB8cI8PeV29ZB47I1WuEVI2xjzg4Xl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KcRCutgD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=og3sGM0+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GEMYZk001021;
	Mon, 16 Sep 2024 15:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=cKN6DAWyJlWV0SZ
	oG6LF7ZPNe8LsAe8b/GI0hgyIt9Y=; b=KcRCutgDohPFFrcdieisoKO0Sk0Bz33
	6OKPDsrUhNitaxuomE+5l/NqLCFeTyCg4/DFq44OrYLhOY2P1kc/Vv8Oi+u5coND
	owkMFfpuXI9yB55BCfhNRdFdBm653kF4g9dm3yZuY65yjbwLyFrFRJ2dwky1RHg1
	+SzpQpe5TnbGJy+OaCrolK2ALbTKAE0ipblSjrzQcFvB2ogI1sD9DGLcyEOpSy3y
	sZxn/k6H84QxystQ8zzlG11SC6zK2Gxpyoc9Xlg++0Hc/7TBjDWltx0VRvA2LF8R
	ZJnlxSeQl1d0cd+hQXDiij3MeKRptTF5mtZa7y82Qn0xjrYBm0rnAtQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfkrsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 15:44:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GFBFgv010460;
	Mon, 16 Sep 2024 15:44:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyb5sau7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 15:44:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0Ydd41wF3R1HS4LS2nuiSvm0ZgKL7DZm66QRzcLokdsdfKqQNibtqsnK+tocx8ntGQORIVe/HKUYRrMgtohHbDKIyIjv2PkFU23PrqRqlIY+JJu5aty0jm+OmnXTHkyJAjyvD2ROfLuywzAUXG1XaLQqdJAyuzzeslw00cCaj3T9HGMY/fQaUGAPy2rGvXdSnpHLJYJTWIGol7cPABsQOA+V1eHE/aBLjFVj9fkhEvxNJt1PpT+GNknPoREDJgaItYUDkpeo1wlfPhpspHU951Fhu/hmuCEl3CKhIcybjffMMYWbRvuietCorbh0try4p/guVX6DYh0z15TKI5nhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKN6DAWyJlWV0SZoG6LF7ZPNe8LsAe8b/GI0hgyIt9Y=;
 b=LIjSNjIH/OSA4KKIHQALpWz6sISRJiRm2kvVK8AWtQ3k27VCCNjPovcQVZGFRRQhkql7rLNwp3ITNGIVx1adAwdqlOy4KiGtH/WgVfI0lg+zZWQx3jPBtJgH4+MMLPu5jdYyqUMAhHc4JQ4COxxXTuec1fDgcZ4XNz119aUZ2aP8Zv7NO+3y6n1x+muxQ81ZPMZe/OCJa/yMjOSw11oUpGH1kqtg61yuiFgk16xgNw46W8L8mVbl2Ec5r2wo5CT19rJ565tWSEJgt18H42ppGAVAvF9BA+Nd/w8twiZc5E0S93GtVfrER5LMY9i06Bj1AtKmsalLcpjBhWoONRxT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKN6DAWyJlWV0SZoG6LF7ZPNe8LsAe8b/GI0hgyIt9Y=;
 b=og3sGM0+/OuY0YfUnnVe1r2sV/bUPGRrPa96k2pe67eaRMkc0eQtbw0rcX9HU5aNGTf8KMtVF9cB6V/CZRJimCxv8c2KCzeZEWkqBRPnM5X1jxofaU+tU89KpVmetlH0ROo/B9YXlVOdNMk1JM7qH7u98FoA0H+MruQVwqBNeq4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4352.namprd10.prod.outlook.com (2603:10b6:208:1de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.14; Mon, 16 Sep
 2024 15:44:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.012; Mon, 16 Sep 2024
 15:44:18 +0000
Date: Mon, 16 Sep 2024 11:44:13 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nfsd: prevent integer overflow in
 decode_cb_compound4res()
Message-ID: <ZuhSTekyyM2mNu+B@tissot.1015granger.net>
References: <65cdbbab-7dca-4a73-af07-29863ab8f526@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cdbbab-7dca-4a73-af07-29863ab8f526@stanley.mountain>
X-ClientProxiedBy: DM6PR06CA0042.namprd06.prod.outlook.com
 (2603:10b6:5:54::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 550723f8-fa7c-45b9-cf6b-08dcd6666ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sd1G13z0KlEndDKT/M9x8h7GmrRc3JFCRWWm/vKGiMSkJS6t2iZaPM0bD2C0?=
 =?us-ascii?Q?vENdj71Erw+Jchz7gUWkOAL6KKDBPnk28+fNg8LKOL55IzDOYZjtgQk3+NE6?=
 =?us-ascii?Q?YBQXcAAvdlYJBk0mOCeo15KXw0ZCNkCDVhqJD3CYGeW1MSQIJpAqTkypca7U?=
 =?us-ascii?Q?593q1UfSGvdrA1HQI9pnIpd70ntgiSVmWOaKGv/vMXj2+Tl45EYWmo2lr1By?=
 =?us-ascii?Q?iaDO+cZ7sMWM+a+vlVDFY/g9ZYAJsVaUR3ssmWH+/KYDYDI/RxrX22DJq+R9?=
 =?us-ascii?Q?mQuE56yUlm/ZxwfQGNuQlRvtHEWwOOx+ystCmvFTy29Xe1fU8FiqWP0rtNeO?=
 =?us-ascii?Q?OWvPrnvGCzhUEQ/E8qE+1MFQgJDazGGqvGx/43aMnMEKyGKQsdqF1bv3fUvW?=
 =?us-ascii?Q?/sR8XVPcZcWSJU4TK26Ts3x6QIG8VGQSb4PWPlCjkju1Lvfq9/gSo1uQPTN2?=
 =?us-ascii?Q?+iLBVigqmWkkV93YYB7wfU9LDnZpKCV1ff6heGnuPRIKm+FJwKC8PjFEg8Wv?=
 =?us-ascii?Q?8qzXS4usMkKDZcQRlFasX9Jdq/F/jJNRolDPosYe6pYHowFWjH7nWA12GCmH?=
 =?us-ascii?Q?6p6Rt1uuCp10NDPDn0Fq48NTWKZSh9cNmm+wQZ9JErZ0M06VrLz+cvsVRlc9?=
 =?us-ascii?Q?VE9A3gD1COzDZ5PvwIFhicfxrTAcS68MhK/o3hqyEXdAU81iWPY9ckT6cIe9?=
 =?us-ascii?Q?+SQ4j1Py3yRZFWgmBx3vSb6WY1A1yJoiUW6zIj8WEwObNaxBeCIR4Y3idity?=
 =?us-ascii?Q?O33+boryJ2MT5NIzkgSJPfrWN1L94xxVRgsNXiTu2rxhLLCZ08NkjCv6WOoa?=
 =?us-ascii?Q?CI1aJLedwhbuaD5/WBak5V8zM5mdl824gcfMbdsmy8WTAsbjQz+aR78EwORl?=
 =?us-ascii?Q?vmZCZqlrZetIFiwK+oLkqgOCbEWnN8qjg+ThBJcbNzIT+I9oKANCKRPhqU2e?=
 =?us-ascii?Q?mTTi3WwQV/FoJxj8uqzWtbIE0/UuBRAca+QjX+u5pBqS8pb5pjDPEh15r80X?=
 =?us-ascii?Q?JHcT0RQQr29bDPLa9OWSIKN8b3/BJ+xD0iHJukb8Ovu1NoDOgMMAG00CTJY8?=
 =?us-ascii?Q?NKAs136hgjGs2AfJVszIFEUjBbcBhVFJMFT43e9l7hrhGOlbItPEetaDmQam?=
 =?us-ascii?Q?ykTeI7YU5CeHHh6Vh8U5uPn9akCtvJfcsx1PDIx89t7dVmwQ0xvcvE1/IV1o?=
 =?us-ascii?Q?Qu2Gv3V/Pa+i1d742R1fPRl04H/dtbgK0LwCoOnJK3PwBZbJ6KCFWQHrw4br?=
 =?us-ascii?Q?tQC7naxPX0mh24bnq5ANI9QD6Wi67n4luPWCKfHjAKkb1ut84CsrefMVL6Pp?=
 =?us-ascii?Q?pDoDvPTSUDFPjQSH18dL4/AeD3oKSETgPJRRdPAgI0DSZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZO/2EQFuZH+NZKI8GzTwE2WXNXDIxJc0Qhi8nWpDemguLQfBvnNesucFMd64?=
 =?us-ascii?Q?2jGFFgobOVIzNet0MS5zNhzYfIUrvjXdP/0bopt3/3nZnx6cNFEXEKUKg6TE?=
 =?us-ascii?Q?V2esCAZeH5xmb/fo4Mg3LRBdL8kDsN4kBh6v24La6Up/3JzX/jNoNiLaR5HX?=
 =?us-ascii?Q?6GQpB96igmuUDW5tCM2SqtSekWeMoOYQJuMBNb39smWnwm8JLMkQ5T5uudON?=
 =?us-ascii?Q?m3iBHOPWJSLoxHa88XoUnSzbmIh4JDOc2myqaRDdLCt82Z08U63Kn7IHIp0G?=
 =?us-ascii?Q?UjTZ43gmuDbo9aq4NM4a+Y1IjrACsXJN0rvYs5mlXSodFzEBRapaCIlRi8ji?=
 =?us-ascii?Q?sSiCcV1QlLcICHZmFehH/Ho3RTCcIogU1og3Jr+8IkazriKp+uI7bsNSK66A?=
 =?us-ascii?Q?VayIPFAG2CDiq/GOeYmfU5bC/djAJfeTcqF++s4aV/761MZpN+pp7edjd/SU?=
 =?us-ascii?Q?+3tWkqEp09NxZ32w7j5Yv8JLeIsrSns3B75/CTN9IDmYTWOd+1FmIsIQF0QJ?=
 =?us-ascii?Q?wx8oti1y1KtdlfNwwLeKN21ORSuLILhwtR2LzRbrO6J/ZhDCxC5e/Z5x8G2x?=
 =?us-ascii?Q?AiIrzmUFRNa9AJQGGXW3/2GHlC8ZJ8qpIF8fy5u1TfWm8HhlTyAWDWgPDZe+?=
 =?us-ascii?Q?EE73io0VU/TNGWrZ2eqHCwnZfa8L7RccCoI+5uwZvOiuRUpaq67p9QvH7ivj?=
 =?us-ascii?Q?CbykX9F7z6tgS3SNgbzB/SloOetfPda/FcS5Kj4C32Afc5h9bZXfn6fZbGMF?=
 =?us-ascii?Q?zKG7xUP2uzwQ8YKNMHQZzkoYfwwQf5ng0cLLt6QmDJKx4yDyxl4e7zO7uvLH?=
 =?us-ascii?Q?U96k+yEOehpREs9Lg06BiQGEThHtAD98aclvT+vjbrX9ZMBHaoTJfGyK8OWp?=
 =?us-ascii?Q?AoHKoS6Vu0cxxbGdxYv8BMj3qnZDhE0zZUeDm/DfObnIcav0qtdIk4cQSgEL?=
 =?us-ascii?Q?I/ZJwQ+vxCr/91ZYgubKXPvwvqKi2ZwNBzRmTaYINQ8OqeoicNzEad9ogrWY?=
 =?us-ascii?Q?xkcLHg+XeIR2AEYKSY+U7tkJSTtCuqSjt5zQvGc0cwwASe/0NHs2tIjQXMz8?=
 =?us-ascii?Q?O+d7DNQOvZWcFqbL/7Kn9xR4hXDiZau3hF00EwJpccxA4l3ogQdZ7uviCXzO?=
 =?us-ascii?Q?d0ra7irpa6MYzklxer9VdOXKO/C+I1zmBNzduixhMk5nUV8mJqfvTdLR1u/w?=
 =?us-ascii?Q?2Qi0gqLACTuVNPKkVtPKVntq2bwTkIMSX2lHLCENyzzOEbIkSuCU6IprcBGc?=
 =?us-ascii?Q?mnKgNjFtq4oIQ9YWl04sqfcg/fwOmb+1BrcyGzi9NbZhdIAmpCTG5dIxn80o?=
 =?us-ascii?Q?4dVOBPyf+IIegSZ6hptzMb03TAfmivOAT5c25+vpI4UbwgB8HkjnKk7dEntc?=
 =?us-ascii?Q?0SJPYn3C5er4qsSY0kc0i+EixrTb7mCItkF55I41nlGM5/wWQVYaFLzZ+864?=
 =?us-ascii?Q?MJ22fwbuPwtMDbk7ssOCHiX+VAQewENZ1zWnGHVh+cbBibd7f5LWfogLVLEn?=
 =?us-ascii?Q?fxNbtSHTo+SgtEzSNmTJQIUGODveiZTE2BRK0RjYODDScx0P55x1fhdtT9KX?=
 =?us-ascii?Q?79I+48yE8DvOVPz/c2A4GYHUkKgAhRKbiRukqvZc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w22BXyLIauQspibBKB8Ga3oGlzSoxM8pnblKGR0zD42uqLZvT22f1zuacS4JKGQdqSssWpU6hZGrxsGEzL0xxrpfY1DHEey5tcwDcxFzxrux3BTIP6GfYdUALRWKPdyiTgYGwK54B3g4747UfJz+W3peK+V/aaIkDRGVFF6LoB9v/5giXxrQ7+5cTfraaAkwbP2ZE7R2tbj5EndQfsRPVCJpbeifWXPVUK8GIlGLjqy9VkNKWoiYFSSMIZEUZsObXIEWkAaTxBZSkSfozb6vuX7mUsaFUQa6O0GGelm8sOjRWDuSI0TsTvVLR1Id+CgjvsafquMz5l2zy+ROsqlGKSTb95bhhpXIHZwTWr6GURayoUqnKO75xO6ErrgzCDRGFLpy2GQXpQY5vfgew6TbuErjDjMbBKPghCm4HtU9pOcUgtxMC8zXzCQUOc0eCbFKBmhHX57kuBS3BsKrxNsYCPO5dIIF9ufVRumenZgqrZdYT4oZUJVOTEA0vMZTrFP07AEb/iaA0ujj2oWBf7SnZf1OQ/ud4AStVGuizS4VJ/fkG/OnrWLiWV+Tk/DV/JcpF5GDDxz0dBKxP7ZNi//Z6dfjDX+8AX6qJnuJK0t17wo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550723f8-fa7c-45b9-cf6b-08dcd6666ce7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 15:44:18.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Sf1SICPoutHcOq5WpJTlhdl22zLUiaLMx8E7o+PPP7aOiabDBETZSlA6Dy9qDulFw0M9nMWSnuMr3ijvk5Q2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_12,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=965 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160102
X-Proofpoint-GUID: JTLjlU9zz6Whze9d5-Kd-XZHZBEqWd8Y
X-Proofpoint-ORIG-GUID: JTLjlU9zz6Whze9d5-Kd-XZHZBEqWd8Y

On Mon, Sep 16, 2024 at 06:14:15PM +0300, Dan Carpenter wrote:
> If "length" is >= U32_MAX - 3 then the "length + 4" addition can result
> in an integer overflow.  The impact of this bug is not totally clear to
> me, but it's safer to not allow the integer overflow.
> 
> There is also some math in xdr_inline_decode() which could overflow, so
> really it's ">= U32_MAX - 7" which is problematic.  Let's just check
> against INT_MAX and make it easy.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/nfsd/nfs4callback.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 43b8320c8255..12b44c9246d1 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -317,6 +317,8 @@ static int decode_cb_compound4res(struct xdr_stream *xdr,
>  	hdr->status = be32_to_cpup(p++);
>  	/* Ignore the tag */
>  	length = be32_to_cpup(p++);
> +	if (unlikely(length > INT_MAX))
> +		goto out_overflow;

I think we assume (wrongly) that xdr_inline_decode() will kick
back any length request that is larger than the xdr_stream's
xdr_buf. Here, the test could be the same: any @length value that is
larger than xdr->buf->len is bogus.

Another way to avoid the overflow would be to split the decode of
the tag and the following op count field. Untested:

        length = be32_to_cpup(p);
        p = xdr_inline_decode(xdr, length);
        if (unlikely(p == NULL))
                goto out_overflow;
	if (xdr_stream_decode_u32(xdr, &hdr->nops) < 0)
                goto out_overflow;

I have generally been using this approach in other NFSD XDR decoding
functions.

I wonder how many other xdr_inline_decode() call sites have a
similar issue.


>  	p = xdr_inline_decode(xdr, length + 4);
>  	if (unlikely(p == NULL))
>  		goto out_overflow;
> -- 
> 2.45.2
> 

-- 
Chuck Lever

