Return-Path: <linux-nfs+bounces-7671-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA5F9BCFB4
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 15:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26931F23030
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228EA3BB48;
	Tue,  5 Nov 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OkgXBVuV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oZiw/11b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47226EAD2
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818118; cv=fail; b=p/kMLHKjGdnqobzDj6J07701aPjkHqkF0rOFygb3RJMSy9QpzulmySSqyuFx0xmrAyXwgHfphm8ttAtTtaVeMpHuNFXY4tObKA0Jj97UPeJbK2/rhrlfZxlYBOSUJ+EERmQDBWqNUb9bbelNArtX3sQpiEq40icfxIfFXYm7jzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818118; c=relaxed/simple;
	bh=HOnrIXvvAZXnGbW9/Q2mmWQa/r6tF8V557kqwqdNuFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZcZphy1n00+69ljioMblvx38hgZEjG4sEIxkeYruELtXR4rqo1JgmvuSaN7jSNYpsGKy0BR+0UL8TyVsVq2EvG1qTZiOnSMfP8tMC2Iw8kCbaiC6CXd21qTm8OM0T4ieUOzvLkv33NBw1cFh/7WieCcIeGImOJqPoL3/tDgPTyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OkgXBVuV; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oZiw/11b reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DiWOm030762;
	Tue, 5 Nov 2024 14:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4jZ0p8JU5YFhCguyMQlnNGJ7Oa9kKCcK0EpFSwT2Sp0=; b=
	OkgXBVuVlsIJNJi27AAjhjq1OCSGzlTvRHv5dpJE2ncaVuM89ggWcvPfx+/BtZj7
	749w+BCiByPHxdB+lhd2Fn2I2DnamIYFWKtTNi2VW1aLjABDZl7W4Yl5PSFWevb2
	n7wrNogT4f3gtbNggU84KD4Jkqdr6LXD53LpCAkh0ofMzK+tsOnpAUH2QFrEqXH8
	irLQk2h6/XMRqOrjImXCA1oIrIwOoc7HGXwh21RhUItv4R8bqf/GBgm8y3dxfYhg
	zF5OdZdWuO/3FkrAt+o+RAJT5XH+3IU+pllMm2G8QINNb3LVw1D/QX7j95sWcFdK
	3p3El9ds7qWD5dNmaYuLKA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpsngft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 14:48:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DhXuA031320;
	Tue, 5 Nov 2024 14:48:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah6yd3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 14:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWNQ906x5ul0f9weh5zTxqpM4aCN+fxfsTBIRYq+NvDYyuxUED5HHPWkbU4kHm3DU208IGU/aGYKp/P+PW3Ve6y4SMn5SXMVym6MdmHK8tqUxhnFWVD+rMej5zvuN8AXKH7ElKUjl6E7FOnorU6R9mrRERMOzaYQMvj6q2qm+fzEaOPgHouiic0Ts0Yx3sitmUiI3qotdNJ6fhzvSxTKz+jc9bcUI8ZpQHEZvu/5pvNL6c1tZ9xB1D+QXYMB1mzTS7gy17xKfJLlIqs1PUpA6eGbD1CzGSOHVe1fRhO/PZJtWPYOWpggSlOOYKBcYUxAkuHDnFZ060n6INxsPGlS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hru/QFnulCoBVXDYCuE8Gjjm3VtJSKUL6qzv0ISct4I=;
 b=Qh90o2mNF4FK2jGsj5jvGmoj0NIANbhDFZKOBWQSnXQvkq68Y/OplB12atSi/jlnLoY/xbHAzv3s4aJVvifE/39QSVKnp4R4D3odunQrPJVkqJ2AiZ+qaAGrDxOiEjryxZCuQikf+9w0Mnh5E+L3YdjGHCjDfYkzmSdQZW+hhYgdWHmzd+jLBXnx12L27jyEa1x6B+IUQOr2W9XqmVNfyhZHIZpvfbFl4ZAvRfzR/4a52pzqL31Esaw3on0tH2GTAMpjbu7EZUiwuhXMWkpc/UtJB1ehREnw6/pMPN7tZ6PQFPnfScALrWeeOF+yz1Ju5yIBFTqNxaMchGsR19SNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hru/QFnulCoBVXDYCuE8Gjjm3VtJSKUL6qzv0ISct4I=;
 b=oZiw/11bHUCqybaqsJJkypzhVsVQa9MUVM3rJZjo54eHiCgLTd0hJJJq38iE5+gyiivi2HXkV7+btBdDoeNPrCggBWJic+ww/Xc6T1S7VMEb6lsIoeefpq38uVrefjJzlMKbqggIhODp9zdyNXOL/XGyoKGO5YBe9NatvKUqJMc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB8180.namprd10.prod.outlook.com (2603:10b6:408:286::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 14:48:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 14:48:09 +0000
Date: Tue, 5 Nov 2024 09:48:06 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna.schumaker@oracle.com" <anna.schumaker@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Soft lockup with fstests on NFSv3 and NFSv4.0
Message-ID: <ZyowJnLYLCiKdX8q@tissot.1015granger.net>
References: <9F6400FB-AF3C-4B56-B38F-E964B60B508D@oracle.com>
 <727185b6375cbb9138edd46a7bd37186de83670c.camel@hammerspace.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <727185b6375cbb9138edd46a7bd37186de83670c.camel@hammerspace.com>
X-ClientProxiedBy: CH5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: d54c0fbb-3d68-41dc-0496-08dcfda8dd81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?3cWYnbHd1w4v+UZEqPhqc3mbCmKoQ0uiicDaOtr2RNvlyMk7LbWRE7lozE?=
 =?iso-8859-1?Q?4lE6+j+FiIzK6GZRUTD3myXU2jPlzEDRB6uKOGvba6LQlOJFD/jKYSq6W/?=
 =?iso-8859-1?Q?ToJFOxtgekMCdHOvfkBEOtD9p2dc0nYhtsE4WPGmSvxk71TA9VlFJcgJXz?=
 =?iso-8859-1?Q?mT+hHBS9TJFYMOKUA6p5nBktA32YeHQS/WQjipw2aOiu/4JxWT58NvHR29?=
 =?iso-8859-1?Q?p9aB2EzYRyl91QMRHYC9XNISoa2O+BH7+xCoCN/utNtegtOshMWK3OFDC9?=
 =?iso-8859-1?Q?gz0sWR+EKvyJC5gFzAwu5hREEwFHe82QIlqsbdEiykS+QF9i2Nk5X3QUAJ?=
 =?iso-8859-1?Q?GHilF1T5/SdAe1FW8eTke6Qmj4svOjAnGu4gEnjb1j8gZTGHRm0ch8VZ99?=
 =?iso-8859-1?Q?fmGpTOuaG8+pp6VS+6zRwYocyHdtZgpoOy+S84UGffcDNH3cVB/Kg3lN5K?=
 =?iso-8859-1?Q?J2s5WkZDU9jeynz+dzORcxgqYNKVAREIjNa5Ea4Af1MPZ8vCr3oF35D79r?=
 =?iso-8859-1?Q?M1Qn4tKVev9luGKPGXxkRX7OR6yAM19S0X/2Kb0ZOkls3Uf56Y1birG/8X?=
 =?iso-8859-1?Q?iUuycg2goOwKUr7MNYUAInfpWloaFRh4KgMlIHJeZ2tvSt9LB40eyyuo60?=
 =?iso-8859-1?Q?i0+Jl/g2I0XVtoQ344WMTcKQj6gGuEMXVQWJ4bkUoQTTWNaQdgRT3u6Ca6?=
 =?iso-8859-1?Q?mVyyMh2p4KmZdG+ghFfSlg3Pn9WKd1bwv5TBUKltoA2u5ZqcT0wv4v4Jc9?=
 =?iso-8859-1?Q?nSYvMlFQ5CzvqE5rkSN9Os7bdLHVyS1Xvbkhyai7qoB/81zSpz+EbNTqVx?=
 =?iso-8859-1?Q?30EHygQ38pRiFijP62EQYp9xTpXAu3qJA1t2UK5eM3OiCoiTwGB0TfMXfq?=
 =?iso-8859-1?Q?c6hiJKRm47tu5umrUCwv8KraZyTDETm/FBJ2hxTBkS6ewaeeOgQ9KuiSt2?=
 =?iso-8859-1?Q?zeXTiyeU3AgHHL8k/vipbMUt7ccndx1l0IvL0kSjJh3eiPRu77qoA7LQPZ?=
 =?iso-8859-1?Q?ggPadnFjSXRZNcU6vUsB/HJqM1eA2a8rSDnO7cgZs9YwLf+TvhadD4/NCv?=
 =?iso-8859-1?Q?6DIatfKfFMxLa8B8g7SMrU1cXMsgDC+y3mo3axmUedyszNmSiMxVIfpelw?=
 =?iso-8859-1?Q?DaHyzM/0rbDa00wXC0opIcy79Qq0gkfmBybh7tHhYssibm1xNaR1+K24fW?=
 =?iso-8859-1?Q?xacLgKTPfTC2JYsR8gCoFXQySkA29SaJ5HeSF0AQg98hTo08kCqM2JtzgS?=
 =?iso-8859-1?Q?Fnzucx+VNnoYysaqA/ehAjDQeMPBl6+wQPEXAO+BusfK/KVadezOwxMkWk?=
 =?iso-8859-1?Q?uCJRrdCpezUGgy8jk+vmVnxjiJECipDIjtUTeLFovWkf9qVgwkPhQQQcHP?=
 =?iso-8859-1?Q?eYQjv4LLn+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?266r9oHwucGlddHDSBLRNKv5zBGWgjLlhnegWGW53N3WH2rtuxcNaciZ0b?=
 =?iso-8859-1?Q?aEy2RaYBsECiUMlgcH6Na9ed3HZbqQQRU0Y4qbo2Oj7ZtiKvDb8mUdQtnc?=
 =?iso-8859-1?Q?KqqgeiXORw1YannqZKcxZNNSH4N4UmVFcXiKFbXbDo8CEvKkWpyau5Zq1Q?=
 =?iso-8859-1?Q?0HWD6L71UDmJa6hEhch8UGvSW95mfAokNdMw+Yxg9qs/UCB9O/v/RjwNnc?=
 =?iso-8859-1?Q?xpOo0cVFtvcVAj4s2pSVwngU11h8zqrx6vUXcl/Ldk61Pdy4d0BBOmEA/F?=
 =?iso-8859-1?Q?rrsBjVRLp2VJMY+0+mF7g0In9kB0rypaLbyBHd/A9lLN+p0WYRVspV8g+P?=
 =?iso-8859-1?Q?4F5CwcvOkrgMvyqWuW/RrmmUpslpD3HPrjKgzbj0H2EG4hqhBiI7cV4i7C?=
 =?iso-8859-1?Q?NZUO4CEi/NqgCmbGhy/WPMRWa2C83uMGiqJQK7N2r9BjfSvUj2FaJJDNR6?=
 =?iso-8859-1?Q?TFGVDkAfmeToflc2EKo3WU5YEHUabWiwcJz/EogdXYaU/delKKAI4PsDpa?=
 =?iso-8859-1?Q?bLZNu2PtQUTbHhIihk7Scxt/MDDxemUQWQNOoEKsGBZjyaaulQZQi07MVV?=
 =?iso-8859-1?Q?b6wF9U0MH5en+Oiuk/MweydJHYAB6CcSEMbRVQdlVmBY5DFhGHmK+WHFyW?=
 =?iso-8859-1?Q?spc6UKOmOYZeZ+PqIXAzZlJAcBqd/rhOqK0dBKz8hHiNUM1VnP0ibQ7zUI?=
 =?iso-8859-1?Q?vZcE8L0dcj8vTI2ZH08ag2f0NeEc/ALX8xzsqBBjk7P4kok9dbbhihlGuT?=
 =?iso-8859-1?Q?kyq+IDglC39C080ECWxHk7/69s8AauzxMoiIvHAj3NHyglVf6baflmpEt5?=
 =?iso-8859-1?Q?km0Cq0WE7vBwZ1+xMMgRPqTu8lsfbEbarApsNkHkecjGAAyOGB4PwoVNLa?=
 =?iso-8859-1?Q?PcBW63VPjJLY17JCuZ7iVTyvcmxCtxvNApQudeaodBWimfU7uMmNi+uPVE?=
 =?iso-8859-1?Q?eVjBCQMl18NPTkbrsTlEBtyARFHFMGbH7CNL+rap8pM1kn8v5BuMR1q9I3?=
 =?iso-8859-1?Q?87CvaVbnrOGknV9uOXflEobeCknWtDRORVbFAnz75soLvjkj5BsGMAtFAa?=
 =?iso-8859-1?Q?sSho9bVO17XAcHEw7ThBI2iFBFaL/GNZiO0skKlHxrQGxkEif5HCtN4K9L?=
 =?iso-8859-1?Q?4FMDaVcwEqXBhlphVNyocaPhthIb2TVJRSYPwVPrzCgCHMzPT6C9JeEB7j?=
 =?iso-8859-1?Q?VOTAcIw7uak5vo/xyDqpXjZg7Wk+4l/fOqXEiIZgQuDxteo6iiPJiEIQB/?=
 =?iso-8859-1?Q?ZTYkFYe4+55fSqajy02cRPkU1gpVLwyQzhVVxAfera3Ckd0/GkKDjtoqrC?=
 =?iso-8859-1?Q?5pwvh+7gM7+W9S/AtvwRu44sOAvaWwCDbtXoumetpq8OzV7QLIa5kR6o7n?=
 =?iso-8859-1?Q?Z3wr0lCd64OXk0shfuo8/lzD5gLf8X2BRlE5EpRHSl5UM5asAK9+14LjN8?=
 =?iso-8859-1?Q?Hkzi12pLt42wJS/hq5miy+vaisckUP0G+hZzuRsla0mK/WYr5TyfRdu1Rj?=
 =?iso-8859-1?Q?V9UvLFd0h3k2oWnOL7GB+rmPGxz3sKWA9ickxQYw7GXGDB3ZU8MNAM03yV?=
 =?iso-8859-1?Q?Dy0gNC+YNx6geNXMWt6JvH1vsVeK2oXuZR/3FL22N+kL26nQVmxp81J7i/?=
 =?iso-8859-1?Q?8l+WoExHhu4gF4a7TIRfJP7AeRn9ID+027GDdog1i7Op5rGyT5W7WYrA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7cUtXDSn+jsTVNGBFEt7rdZmYLERASu0tTaKknvO5jY8H69RutcRa3x0mYd0ErqZfssUUv8LMWdgLDhPAAwZq4LGVVa7+xz8V1+y3nIZy6AsWMnEJ6vg3gAbmZvd6SIgWpUto5cn/4KXbnHr0cDxzg2VhBVgblqVoH4ZQUQPNdQ5tj0AKg9Xb0wfTskR62hbd4ExMg5DHxVYCUW+mq9A1wEQFwdNpRss7p7vn0J8U4lLJoBBzyntWM5ugUC/9mLVOx9MQhY4UQIRNF1zbhzlK+aK6v1Grp02j6/rbb37OfJEPNRhWK3ESG4rf5K+vdcl431k+fUCIsTgmtKrITKEzGKpnZjrQmlni+IXEciMRkkD76ezrHF3vwgvspwT2zBcHzsHt+WgbAfWolncaxn9i5VWZKuwpO4W1FUAg2rrm+a7NxK1aK+UdyA68mRiV6dz/5eeSreZF+54ay/Yn9pmPC3VeLrRkKgryW96LI8BkVzsxXhNkMyPQwR1mdgMPgs9P2jqnrcCDDU1qgDiK3FItIv8EcjK+mGvsnqDZ5VJT33sZnadmM3N5jT1gvNEukDG03i9uVGLIwZGnoAlXxMmWqgQlFZhDsNw+qKaskhfPNA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54c0fbb-3d68-41dc-0496-08dcfda8dd81
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:48:09.3589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DDUPy2x67Qi7ShTeIfaGkrHmrPIl4jaEQljWjuKcWRt6N7aQkAYMko3HmXIsxJgWZ2BNeubaG1hc4f4poBSQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050115
X-Proofpoint-ORIG-GUID: CJnIlFAc9p4YeuEfUn6OZrlDOfAXxZN7
X-Proofpoint-GUID: CJnIlFAc9p4YeuEfUn6OZrlDOfAXxZN7

On Mon, Nov 04, 2024 at 06:04:21PM +0000, Trond Myklebust wrote:
> On Sat, 2024-11-02 at 15:32 +0000, Chuck Lever III wrote:
> > Hi-
> > 
> > I've noticed that my nightly fstests runs have been hanging
> > for the past few days for the fs-current and fs-next and
> > linux-6.11.y kernels.
> > 
> > I checked in on one of the NFSv3 clients, and the console
> > had this, over and over (same with the NFSv4.0 client):
> > 
> > 
> > [23860.805728] watchdog: BUG: soft lockup - CPU#2 stuck for 17446s!
> > [751:691784]
> > [23860.806601] Modules linked in: nfsv3 nfs_acl nfs lockd grace
> > nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> > nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
> > nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill nf_tables nfnetlink
> > siw intel_rapl_msr intel_rapl_common sunrpc ib_core kvm_intel
> > iTCO_wdt intel_pmc_bxt iTCO_vendor_support snd_pcsp snd_pcm kvm
> > snd_timer snd soundcore rapl i2c_i801 virtio_balloon lpc_ich
> > i2c_smbus virtio_net net_failover failover joydev loop fuse zram xfs
> > crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
> > polyval_generic ghash_clmulni_intel virtio_console sha512_ssse3
> > virtio_blk serio_raw qemu_fw_cfg
> > [23860.812638] CPU: 2 UID: 0 PID: 691784 Comm: 751 Tainted:
> > G             L     6.12.0-rc5-g8c4f6fa04f3d #1
> > [23860.813529] Tainted: [L]=SOFTLOCKUP
> > [23860.813926] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.16.3-2.fc40 04/01/2014
> > [23860.814745] RIP: 0010:_raw_spin_lock+0x1b/0x30
> > [23860.815218] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> > 0f 1e fa 0f 1f 44 00 00 65 ff 05 48 02 ee 61 31 c0 ba 01 00 00 00 f0
> > 0f b1 17 <75> 05 c3 cc cc cc cc 89 c6 e8 77 04 00 00 90 c3 cc cc cc
> > cc 90 90
> > [23860.817076] RSP: 0018:ff55e5e888aef550 EFLAGS: 00000246
> > [23860.817687] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> > 0000000000000002
> > [23860.818459] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
> > ff29918f86f43ebc
> > [23860.819147] RBP: ff95ae8744fd8000 R08: 0000000000000000 R09:
> > 0000000000100000
> > [23860.819984] R10: 0000000000000000 R11: 000000000003ed8c R12:
> > ff29918f86f43ebc
> > [23860.820805] R13: ff95ae8744fd8000 R14: 0000000000000001 R15:
> > 0000000000000000
> > [23860.821602] FS:  00007f591e707740(0000) GS:ff299192afb00000(0000)
> > knlGS:0000000000000000
> > [23860.822464] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [23860.823030] CR2: 00007f6f6d2f1050 CR3: 0000000111ba0006 CR4:
> > 0000000000773ef0
> > [23860.823708] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [23860.824389] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [23860.825107] PKRU: 55555554
> > [23860.825406] Call Trace:
> > [23860.825721]  <IRQ>
> > [23860.825996]  ? watchdog_timer_fn+0x1e0/0x260
> > [23860.826434]  ? __pfx_watchdog_timer_fn+0x10/0x10
> > [23860.826902]  ? __hrtimer_run_queues+0x113/0x280
> > [23860.827362]  ? ktime_get+0x3e/0xf0
> > [23860.827781]  ? hrtimer_interrupt+0xfa/0x230
> > [23860.828283]  ? __sysvec_apic_timer_interrupt+0x55/0x120
> > [23860.828861]  ? sysvec_apic_timer_interrupt+0x6c/0x90
> > [23860.829356]  </IRQ>
> > [23860.829591]  <TASK>
> > [23860.829827]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> > [23860.830428]  ? _raw_spin_lock+0x1b/0x30
> > [23860.830842]  nfs_folio_find_head_request+0x29/0x90 [nfs]
> > [23860.831398]  nfs_lock_and_join_requests+0x64/0x270 [nfs]
> > [23860.831953]  nfs_page_async_flush+0x1b/0x1f0 [nfs]
> > [23860.832447]  nfs_wb_folio+0x1a4/0x290 [nfs]
> > [23860.832903]  nfs_release_folio+0x62/0xb0 [nfs]
> > [23860.833376]  split_huge_page_to_list_to_order+0x453/0x1140
> > [23860.833930]  split_huge_pages_write+0x601/0xb30
> > [23860.834421]  ? syscall_exit_to_user_mode+0x10/0x210
> > [23860.835000]  ? do_syscall_64+0x8e/0x160
> > [23860.835399]  ? inode_security+0x22/0x60
> > [23860.835810]  full_proxy_write+0x54/0x80
> > [23860.836211]  vfs_write+0xf8/0x450
> > [23860.836560]  ? __x64_sys_fcntl+0x9b/0xe0
> > [23860.837023]  ? syscall_exit_to_user_mode+0x10/0x210
> > [23860.837589]  ksys_write+0x6f/0xf0
> > [23860.837950]  do_syscall_64+0x82/0x160
> > [23860.838396]  ? __x64_sys_fcntl+0x9b/0xe0
> > [23860.838871]  ? syscall_exit_to_user_mode+0x10/0x210
> > [23860.839433]  ? do_syscall_64+0x8e/0x160
> > [23860.839910]  ? syscall_exit_to_user_mode+0x10/0x210
> > [23860.840481]  ? do_syscall_64+0x8e/0x160
> > [23860.840950]  ? get_close_on_exec+0x34/0x40
> > [23860.841363]  ? do_fcntl+0x2d0/0x730
> > [23860.841727]  ? __x64_sys_fcntl+0x9b/0xe0
> > [23860.842168]  ? syscall_exit_to_user_mode+0x10/0x210
> > [23860.842684]  ? do_syscall_64+0x8e/0x160
> > [23860.843084]  ? clear_bhb_loop+0x25/0x80
> > [23860.843490]  ? clear_bhb_loop+0x25/0x80
> > [23860.843897]  ? clear_bhb_loop+0x25/0x80
> > [23860.844271]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [23860.844845] RIP: 0033:0x7f591e812f64
> > [23860.845242] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f
> > 84 00 00 00 00 00 f3 0f 1e fa 80 3d 05 74 0d 00 00 74 13 b8 01 00 00
> > 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec
> > 20 48 89
> > [23860.847175] RSP: 002b:00007ffc19051998 EFLAGS: 00000202 ORIG_RAX:
> > 0000000000000001
> > [23860.847923] RAX: ffffffffffffffda RBX: 0000000000000002 RCX:
> > 00007f591e812f64
> > [23860.848702] RDX: 0000000000000002 RSI: 0000562caf357b00 RDI:
> > 0000000000000001
> > [23860.849402] RBP: 00007ffc190519c0 R08: 0000000000000073 R09:
> > 0000000000000001
> > [23860.850081] R10: 0000000000000000 R11: 0000000000000202 R12:
> > 0000000000000002
> > [23860.850794] R13: 0000562caf357b00 R14: 00007f591e8e35c0 R15:
> > 00007f591e8e0f00
> > [23860.851592]  </TASK>
> > 
> 
> I suspect it might be commit b571cfcb9dca ("nfs: don't reuse partially
> completed requests in nfs_lock_and_join_requests").
> That patch appears to assume that if one request is complete, then the
> others will complete too before unlocking. I don't think that is a
> valid assumption, since other requests could hit a non-fatal error or a
> short write that would cause them not to complete.
> 
> So can you please try reverting only that patch and seeing if that
> fixes the problem?

I was not able to report publicly yesterday evening, but I did
report this privately to Trond and Anna.

Reverting b571cfcb9dca causes earlier breakage -- the test run does
not even get to the soft lockup without that commit applied.

-- 
Chuck Lever

