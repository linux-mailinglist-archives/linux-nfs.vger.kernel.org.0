Return-Path: <linux-nfs+bounces-6185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4E496C017
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 16:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6941F22D4D
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2024 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760F01D79AB;
	Wed,  4 Sep 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZcsCmktN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hP/hBzrg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA111D79B2;
	Wed,  4 Sep 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459499; cv=fail; b=twwBH3/03nDWVXkTXGwOfmFKR8O6rLgVjvQWTUq1+ZyQnr4DJ9+WlwOlIUQWj68P2rVmNyUA67trdEIwdr3F409DjhK3Zpqn6Ldp6rxVNmyEHHBxwEHAAheyPTtnAs8xAQ1rYJfyKC4r6XhYWU7qzGtMMUnBi31H31n+U6s3jyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459499; c=relaxed/simple;
	bh=rG/Vr5qYAfC8myn4RpuVmYk0XjQGl6B2LJNx8p9QGIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q3zX6ElZRnHlPWTb4Q3uQ9GvG9gDpfw6EKWpWPDrRYxIFxBEQG7eD7m2QqaSQ9DKBrsg8MD50jsrKn/g3qMTDcYIsyyUJONKxWrr2K/d5HzJeF/HNSbRLCsyeQ6G4dFr7/rjXH0Mz9XqXk5TRaVQXPhKplVbKJR5i/nqw5pAwZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZcsCmktN; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hP/hBzrg reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484DXWEK023869;
	Wed, 4 Sep 2024 14:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=aPFB0ncSGAzAc77qsPb5CjV1kXxrbFPK6m8JcUBbqIs=; b=
	ZcsCmktNewmODIzbwZAmVxbuEDo1K02FThxTwRwKb9LGcjJRHWIXobpd+SZ/i4pd
	HWHvtXEuHPH+pvgEyZoqjvt0N9T/r793p27T4jlRVZlzVFaDT+WShQX62hkbSaf8
	Kkdh3wlcWbQ0yLK/OCFaN/4FybXSsDWJqjrGqH5uMeFEGZkLm2GTzTisrckfJKr+
	Okcw8hOHnI68akp+v9HYY5pS4CGQJlfbJw+2N/jExUyEXDsdLNZ7PY8eiVB0n6xT
	FPO7gxDcw3SapSup45gLeKdvLAV4wfr17+zAKL6TelPMs2/TUyCDcgj8byGoo18/
	zqvp4C9cYpKSemSRZdmaAg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dr0juy6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 14:16:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484E5qag001684;
	Wed, 4 Sep 2024 14:16:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmgemfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 14:16:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YujKCh1EdP6qR2NBzRHqMc7MEQK8+0cg20gKwL8PDsdS7CZAZtdTLLMaRlRRPrmDe7pz+Y+B1aZvuF8E19Wd2tT9Y5ZSHZAnIpKimjMopIv4dTPg5sipjJlltpwAu71T7jxe9HYJYhBuwKvWKif+5OrwatnjT8aHHg7poduKE1B6GD7VP59ZvOb3ZmnMqhKFfhbrLHtqeTw6B69YZq/HhFSo1v6dO1USxILDjwcAH/3n0jrj0yPQpm05vTu9SpsgjRgn8lxFiGnXdLxNicDmluWEUDaLp9lFzu49hp+cSMMMuKyYnCUI6u2BtcZ6UKgxPbZSvi5aDZzrVrMsvsi+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhwidUi0z9wuJQshDXkq8mrYvrHyVvEt03kDJpWBKGk=;
 b=uvA3CGXIOxogHrIReABbcKTCwpY2AGA3XEEhHKeFruZ8h0HL6Y0SY4yvbK3nrCj3WY1T1BVptpnTcMA7lLciG43l+v89fQU9fk/DDrJrKAFHdra/tYQVDWkUf+EIDVwiqfvXThXUHEWUufsEY4PB87YsaFTejIT3GBkZUzdBTQQLJ+t2WI+QxEYKvsFJqjbSbtbIveo+P6gBFM/bvNIO+WyToo8Mf10rAfF9lGe3JCdTVnFo69TyDALJojDkezX4KM3t0UDi5q/Xwe/krBQGBmx62VpsS7AgHHl13O3B+lgZfy7bVG7n6yXeUv9YgwuLw2yvBg/fem7EY5YgfT2iVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhwidUi0z9wuJQshDXkq8mrYvrHyVvEt03kDJpWBKGk=;
 b=hP/hBzrgD8uIjgrjnLZuItuzMCtXHODgrkrZjA8PFlNs9FDmzVnqzyziAqbIjn+Q9/eeikV6YL9Ifpj3fS9NICuowZ1SooRfeHaLWhV2dL/pSR+QrJrM0GkqudEFa54t4cXgQnMnatQQtb7OQqW4cjP+FlUcvU6mHqXdYlo+YM0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 14:16:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 14:16:35 +0000
Date: Wed, 4 Sep 2024 10:16:31 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng@huaweicloud.com
Subject: Re: [PATCH] nfsd: return -EINVAL when namelen is 0
Message-ID: <Zthrv/SXT/TtU+zp@tissot.1015granger.net>
References: <20240903111446.659884-1-lilingfeng3@huawei.com>
 <ea328b17-ba60-c7c3-3bab-52df1dd60fef@linux.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea328b17-ba60-c7c3-3bab-52df1dd60fef@linux.dev>
X-ClientProxiedBy: CH0PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:610:e4::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d49e06-de49-4807-7bd2-08dcccec2f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?8+i0WaW4mEyA+lnvBnD4izyCX++rb+OSGrBmOYnzMfO7vypUspcYTzmYVb?=
 =?iso-8859-1?Q?8AyV5Ehk+3GjTA9f/hStvoWssTadPVuRakYaf4ruI2YFKTJCWQLotoCCTk?=
 =?iso-8859-1?Q?TmhqndgJRPpmETv61doANd2s/D2ZvX7bk/V25pInf/jyXmMCvRfyEdMGh2?=
 =?iso-8859-1?Q?kcj5KW1Qy/LxjK+1A7LSpfyYrROz/WTx67u4B6BqxeNbympLj7YscdvTem?=
 =?iso-8859-1?Q?mEIa2XskhHDMKE00+daInEKzz5h9/addKW2opvRWJdLDBaN8ZtSRUh2V6q?=
 =?iso-8859-1?Q?ZcwOXesh8aujnUrSdLdHKtVv6l7FXTBwEZQ7HnEMlJ02Uq1Ump9vs/OQGy?=
 =?iso-8859-1?Q?M6jfJf/oMFNdQMsdQTR74H9uggpdUBw9PNBGyqxwzRyVKxHX2jeObRLqu9?=
 =?iso-8859-1?Q?ZXjM1rMtTaci3mZ+LaLhh1Sowcj+J8mugcTbUtFJQR0HXZhtHkO0gcqCuC?=
 =?iso-8859-1?Q?svPtuccpOAge3W/kJYS5899cwDqOL/MhiDIdstpevDt3OTGvow93aIgOMU?=
 =?iso-8859-1?Q?fD7Rld3vidN3TWXEOSZCWcFDik/yyDJFs3T4P4Ds/ye0Jlzs3db4tgjqwM?=
 =?iso-8859-1?Q?ipntkEpW4OR6r2ORDeZD5AWc8pzFfCOQS2XmLLcFyktOoSsip16a7Lvis3?=
 =?iso-8859-1?Q?Hw7oAD1rWpWSFy7gFshUmQffHlUHfu9Ye6im1zZJqRwqw9Q8F3FkanpKn1?=
 =?iso-8859-1?Q?09RivAyky5XRHficbOeL/d28ZCXKmDTjF970ArDQU1QjjxsmDieCxv0/8o?=
 =?iso-8859-1?Q?Ul3SNGeA6YUgcrbJplGZAJNKba4KB899LsO2k3Jjx2SXjBZ4UF9b9bubBw?=
 =?iso-8859-1?Q?1kEm93AdVc9+Ve/QS/5NnxvXcvbiCXD0lZZDajPxz1AVFZNCHxlcJ0QrT1?=
 =?iso-8859-1?Q?Z4sd5ktlI32slZxBzapEi7Qsmo2IJp8H63iKMJvGK9UNVZYX44k0A/BJIy?=
 =?iso-8859-1?Q?FfIuar5vpXTvxoloNtZ+KgycPe70SuCcgXJHiXM8kmoCGtbm+4pf9EpxxU?=
 =?iso-8859-1?Q?rqcpYze9HbbUqrd0V5JgjKP/69bMsg5+NZA42nLM+RXHr0t4QWOShaSnak?=
 =?iso-8859-1?Q?uI7mFWSI7g5NaKfGsJYri3rxF5P73IypambFibJ4gb2Tgyhi7LdQFOfiOX?=
 =?iso-8859-1?Q?xdkq3xNKJTOewzbKOTdO1+R7wtk6rEMSkgEanDx/1aiWKj8ROg+uIzSm9w?=
 =?iso-8859-1?Q?FLXwT3E+jY9M9L+JW+vs4U4t3ywuFw9sLmM2lpAPKOkXCfxreKROqT47A7?=
 =?iso-8859-1?Q?Q4tCFsEX48254spSUv9BGV6MVqQKiTqvdeS2zmupVjSmrKZJ3Y/Yfs30JD?=
 =?iso-8859-1?Q?Y8YOpyJMHhbhxGb2Kg3PmntV2P/hiQ6bgV+r60PSIzYsKK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?hXWaDI8LOE458Zwb4rZT+7OAIoeGW4I1Ivy1Ew77DUDI5RP0wn5+DzAKX4?=
 =?iso-8859-1?Q?GArmAHNPNjjlPMfmfQugd7JwxJIeGRLSoG2gsoo8KJ7rdlygxoX7PhD5p4?=
 =?iso-8859-1?Q?5YG/k36Qkp1/vVGDXR8egwzn084w/8RuyOV9/AwfsiXhlrdVo0x8T2NgRW?=
 =?iso-8859-1?Q?MgfyTzLZIOSbVB9LxKaT0WY3n5YX1UQ53OVR54gjmk2VhJiUdws1FiUuYp?=
 =?iso-8859-1?Q?3Ioq0AkDrm6bOyozVMBQ61nZBwj82uJPyaK1rnF2G05Jomqa45niFosAAi?=
 =?iso-8859-1?Q?wIyFR7839dR10KF0Fimcg4uSUrHC8fNP1qZew99se+sQ6vHD5hbtF4dVsG?=
 =?iso-8859-1?Q?VPOycknbFmfssSfEASkzymiyIGXzz9q2/DRXU3gLtGs6bml0ubCuJIF3gl?=
 =?iso-8859-1?Q?eKOt+O9OtWTaWcDuF4TSbVIcu9iBhaSrHfnv1VBMuH0ltqLR3gLdSFWy+8?=
 =?iso-8859-1?Q?VdS3TeW8y9riz3SlIFS7Uqs5CGQFpYrEL3Ocg1BdVflqK6GGZsPw84GUkp?=
 =?iso-8859-1?Q?WFfpnvl5YQeLLfhmX5pjD16UMEO2kN59vYG4oUa0fTnTKf4Y29DLOBzWbW?=
 =?iso-8859-1?Q?dxSwcd+cjO4kgwf3j58JVrpphtkRqPB+qWDzPAZeGQ1zGiodY7fMG0t8LT?=
 =?iso-8859-1?Q?i3DLeQ/H+EqwSi6OSQ5gMfi4TU5oYeWjJJjWs5l7X+ujrNN/0M/PQM3mW+?=
 =?iso-8859-1?Q?iuf8bqr2PvcgvCpEYm0MNLkvkhF2bRq8mfXIQK+mZWQLXxNXZLl9qQtoAL?=
 =?iso-8859-1?Q?W8spXkIDYdaY/KFxBHBwFvY7ZYglviAh7Tb/u31m5vOGYcqvd5nkUdVBF8?=
 =?iso-8859-1?Q?tTNF9yzj1tERMuUxeqpeN6slmBpUtWzeAsbCTIFFUEoIZrU4rXhPV9xfEB?=
 =?iso-8859-1?Q?tp8KVJf3S13KeWvK9Z63hmVHQtQ/r9AoCvn+Go2RRGTjbltgKugHHxd285?=
 =?iso-8859-1?Q?mZPngDtlCLi1LsOWzXUNjzyho/kWb6I+0DEYeuM1ZspzsbLewClAuS28uX?=
 =?iso-8859-1?Q?8XIzzCoT3GJCUBqIKV1sW72KxTdWdZmEN35uR9jXjSjnYCxGtvomMWtf7D?=
 =?iso-8859-1?Q?MGs6WtMDTCQxIJ50+TMqqyu1OiANPkeF/3uLKcj65vH6WP1xC1qkxNWxMx?=
 =?iso-8859-1?Q?Kx4LGFrrN3LoUgZYPGL07eoD2uXhH/7XlhtEbws/rWfw5uQzJyaFWMglWi?=
 =?iso-8859-1?Q?SP3yvWsHfzta71k481584/3y1dIdY+hYE7o/iX5R+od8X0MSZ+g1m2r3Vs?=
 =?iso-8859-1?Q?lLAaTqardMsXYtfuTpc6QRrNFP7a/9kCF322n/3NnjYkxA2rrg/Qz92uUR?=
 =?iso-8859-1?Q?zPs6KS3EH/E7/CtIYU7/O8ocq+MZjfiasiF1k7h++FlXIVqdgMund1N7X9?=
 =?iso-8859-1?Q?OMzPdE+dIznPmMsmyfxkv+27OonDapTrSpATmnY476Jj5G8xUqtdcjccQd?=
 =?iso-8859-1?Q?hFCWFVckr80gVZA1mVOlK3DacCpprEjACNlJzmEN8zlGj0qVAYJbfww/jG?=
 =?iso-8859-1?Q?nnV9sbas2wlXdgF1RtmL1tuMTbHFnZbYFNqzgzumyvFC4FxXwHWYpcWmOe?=
 =?iso-8859-1?Q?cVEQWdMB852dgG2z09GXlXCH96vlH/BNc3qWh2wTqKFmWRzJFcajZ3oNfC?=
 =?iso-8859-1?Q?DC62q1Sgl1G1RFatsjgY3uaweg01VZ/U6/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XhK+zy/5qYogLsYTNawObtkSGn8e0c3fKZwEG6uSwlsbAi30dNXWRcOjTyQ6Ztglu8If/+c+tL6jLivke2MJLRoylW45sH3wJ8gcGBnP98H8aaIxAg4eWZnzrICNUZE3IH8YS8bnRukZFU2gl1Dzd57TxiNsNxMvfJgFASxxnwTX3QrIrkkrSfKS3YYet2zFpkZ1/GHhc30MIpfpnv8R5h9aWPCr6xYMIWFvEyLeFaR4qtBNSi6b1xSPKvrrgnB7HHxlXOuKQSLguzbx7vITh14F2BD3kjWc81O8gcztA8vzn40TvSD12eYXMVWLUsXgZtB19aE8UMwiAfukZD2tqyRrRzX4+CUl90VW58Qd5X1gK8MCsr3fxjBBZn24tTsUNBggUfvwOZaDtJeHDsJv45U6kbwaEfZPV6rTz/Bxt9I2qna3hVvbSmrKH1f9Kk40ZSVBfa46Suf8SNArFQq2nJ8FFiG9LrQtFvPqDHVkJq323aAlaadKOm7JBdbiwRMHMYVB5cEzHJBNx3AYjsQ+9Dn9bsnPJRvVzO8T4H6OJ9xUKKYbEu5Q5olZs1hw0jAuDWyeSBuUmkyWw8IYMJNq2gUfuHk7P6duH5KUyDNERsM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d49e06-de49-4807-7bd2-08dcccec2f16
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:16:35.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uEFog/d1qxisxfQ29CGlvKHx4vZ4jwPwFKSchSYtJB9NXLl7tcAlakFGeDZLnmjDyhX88TFnK/HBMGHwPWKag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_11,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040107
X-Proofpoint-GUID: Xkv8E_EQzK8AUYislW5AQvWzi9c52nr1
X-Proofpoint-ORIG-GUID: Xkv8E_EQzK8AUYislW5AQvWzi9c52nr1

On Wed, Sep 04, 2024 at 09:06:07PM +0800, Guoqing Jiang wrote:
> 
> 
> On 9/3/24 19:14, Li Lingfeng wrote:
> > When we have a corrupted main.sqlite in /var/lib/nfs/nfsdcld/, it may
> > result in namelen being 0, which will cause memdup_user() to return
> > ZERO_SIZE_PTR.
> > When we access the name.data that has been assigned the value of
> > ZERO_SIZE_PTR in nfs4_client_to_reclaim(), null pointer dereference is
> > triggered.
> > 
> > [ T1205] ==================================================================
> > [ T1205] BUG: KASAN: null-ptr-deref in nfs4_client_to_reclaim+0xe9/0x260
> > [ T1205] Read of size 1 at addr 0000000000000010 by task nfsdcld/1205
> > [ T1205]
> > [ T1205] CPU: 11 PID: 1205 Comm: nfsdcld Not tainted 5.10.0-00003-g2c1423731b8d #406
> > [ T1205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
> > [ T1205] Call Trace:
> > [ T1205]  dump_stack+0x9a/0xd0
> > [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> > [ T1205]  __kasan_report.cold+0x34/0x84
> > [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> > [ T1205]  kasan_report+0x3a/0x50
> > [ T1205]  nfs4_client_to_reclaim+0xe9/0x260
> > [ T1205]  ? nfsd4_release_lockowner+0x410/0x410
> > [ T1205]  cld_pipe_downcall+0x5ca/0x760
> > [ T1205]  ? nfsd4_cld_tracking_exit+0x1d0/0x1d0
> > [ T1205]  ? down_write_killable_nested+0x170/0x170
> > [ T1205]  ? avc_policy_seqno+0x28/0x40
> > [ T1205]  ? selinux_file_permission+0x1b4/0x1e0
> > [ T1205]  rpc_pipe_write+0x84/0xb0
> > [ T1205]  vfs_write+0x143/0x520
> > [ T1205]  ksys_write+0xc9/0x170
> > [ T1205]  ? __ia32_sys_read+0x50/0x50
> > [ T1205]  ? ktime_get_coarse_real_ts64+0xfe/0x110
> > [ T1205]  ? ktime_get_coarse_real_ts64+0xa2/0x110
> > [ T1205]  do_syscall_64+0x33/0x40
> > [ T1205]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> > [ T1205] RIP: 0033:0x7fdbdb761bc7
> > [ T1205] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 514
> > [ T1205] RSP: 002b:00007fff8c4b7248 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > [ T1205] RAX: ffffffffffffffda RBX: 000000000000042b RCX: 00007fdbdb761bc7
> > [ T1205] RDX: 000000000000042b RSI: 00007fff8c4b75f0 RDI: 0000000000000008
> > [ T1205] RBP: 00007fdbdb761bb0 R08: 0000000000000000 R09: 0000000000000001
> > [ T1205] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000042b
> > [ T1205] R13: 0000000000000008 R14: 00007fff8c4b75f0 R15: 0000000000000000
> > [ T1205] ==================================================================
> > 
> > Fix it by checking namelen.
> > 
> > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > ---
> >   fs/nfsd/nfs4recover.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index 67d8673a9391..69a3a84e159e 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -809,6 +809,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
> >   			ci = &cmsg->cm_u.cm_clntinfo;
> >   			if (get_user(namelen, &ci->cc_name.cn_len))
> >   				return -EFAULT;
> 
> If namelen is 0, I think the func should return -EFAULT above per below
> comment in [1].  Or can get_user return success with x was set to zero?

It's legitimate in general to find a zero stored at &ptr. x can also
be set to zero if a fault occurs.

Clearly, get_user() succeeds in the crashing case; otherwise the
flow cannot reach the memdup_user() call that returns ZERO_SIZE_PTR.


>  * Return: zero on success, or -EFAULT on error.
>  * On error, the variable @x is set to zero.
>  */
> #define get_user(x,ptr) ({ might_fault(); do_get_user_call(get_user,x,ptr);
> })
> 
> [1]. https://elixir.bootlin.com/linux/v6.11-rc6/source/arch/x86/include/asm/uaccess.h#L108
> 
> > +			if (!namelen) {
> > +				dprintk("%s: namelen should not be zero", __func__);
> > +				return -EINVAL;
> > +			}
> >   			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
> >   			if (IS_ERR(name.data))
> >   				return PTR_ERR(name.data);
> > @@ -831,6 +835,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
> >   			cnm = &cmsg->cm_u.cm_name;
> >   			if (get_user(namelen, &cnm->cn_len))
> >   				return -EFAULT;
> > +			if (!namelen) {
> > +				dprintk("%s: namelen should not be zero", __func__);
> > +				return -EINVAL;
> > +			}
> >   			name.data = memdup_user(&cnm->cn_id, namelen);
> >   			if (IS_ERR(name.data))
> >   				return PTR_ERR(name.data);
> 
> Thanks,
> Guoqing

-- 
Chuck Lever

