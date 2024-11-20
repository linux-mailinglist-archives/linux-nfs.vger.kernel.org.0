Return-Path: <linux-nfs+bounces-8142-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A959D3161
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 01:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3864283C35
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 00:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1274A3C;
	Wed, 20 Nov 2024 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ITao/CzU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YM2HmDno"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E414647
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732062121; cv=fail; b=mkQoHUL0vCb3rGnKJxjycFKukyGqh1oWbDjRij+sEo9N7yZmSLqxFO2oqLhmOkIvPKKOvV+vs/h4HKAAF2f+t44S7heb6vsPoa3v6+GYJDbBnmhD09B7sfqmenQUQ6tZBbgDKxPSFUywTAHNGjcbNUZq39lmDjDPLNieSt74y1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732062121; c=relaxed/simple;
	bh=lmWAR2i2CNFG2C/djNIxbDL5alHCrtnbwMmSMgMP2SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qMbOJ2WHmr+4ua/dUTF+32Uv3BoyaoA3TZ4+ucz5P3xp30A8ggXs178NyDp5XOHVdMIyiWV3heRm4PUg8NfL59H29zSoZZsqABUfD/ioCBKHGVz6wX0JqkOQoST6gfByuiHnv5oFMkaDGD7jMhtv7pCzF7GWvSSnSTJw+60FaT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ITao/CzU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YM2HmDno; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJMfYFa012155;
	Wed, 20 Nov 2024 00:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=USpVx/Faor6Virh7lG
	xiBOVttxwaifSBJGjo45V4SWM=; b=ITao/CzUHhU4uAGtryS7eA8BsS6MQHhmlc
	AhJyus73GjrmPoCqWOeZESiFWgU2xqTRaYCEVwBI2jpSOkO1McAZZKBkhpsbV4Ac
	tgkxjOA72RSz/Uap5aNcnS0EuX4/MVZlAwsWVPZf2URNfp8JlYPQiCVgKs2SVqbD
	eIHRuzY7EuSKORqNhY562cTOmcNFtHBZ2To7rwEE0HRsnRFJQNOKTkpsNpeTQNlp
	WfLRaAW72eJxgT0lcTrOZUq7+ZcXFW23pOCPLeFUNMrpQDKWNhk2sGcyiweIFsLL
	V7Nk/vjS4L49lBp69sDFR5rfJ6HJw4ZJjglDD+4JdafCC/QG7xwQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc6bca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 00:21:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJLtrUM037148;
	Wed, 20 Nov 2024 00:21:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu9bxf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 00:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWcExiUXiWFQokl3rF4K6B+woE4u+hqxp5JCT8HklqZh5zY7zW8SyCtG3u+jUrpC5bRfmUfT4Hp5yEyDmyDwlvJRSusU9tCQvH4pCmdYenQXN23OAm2rb807oz1Uhk02FEaP0XSEqgkM9vbplWOaJ4VYiEn7JICAULHfq67/sEW1Bp7CUSTTAg0JbZ/TC0GeeyMQyqeonw/ulCVyJRcGqsbygG5CVhGH90ZYJXpbk0PG25tLWfSKfg0/GHn+hu6lQgQeqoqSj4EsjB6VLmxkzRJfrk/FBPu6Y65PiD5UE5sTJgVhr3oubMe8PoGKrK4hSvlN4fbdsCTnaeOavkAIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USpVx/Faor6Virh7lGxiBOVttxwaifSBJGjo45V4SWM=;
 b=JotT0WD6yDVAqbyuST7BwzZaQWrBJpUkIh+ekBCdcioBh2hbFXiNVnVfu4nStX7cnm2OhBsfuTWPXEHnYsKMlMkd4JhyBgCkjxLw2w6g//40jAt/ZRUaudYML0TD07nBQYOuFsV2i0B2/joThlyDc3fGkid1hn8gKFYH1wMKgTbJR3wBMFX3f1rViDqZmMzWt8TNQmkVfFrcQAT8uxWFL1aDiKhLu7NoYvfPsGiouEQIN7zj7Cn7ZXIMRu7OVxZm9VdpjLeP40kkv+8Jgc1CmD2WqvRrkbg+FzdYURrbl0Nxs8iwAJnWHLK+WCct0vQrk9AYg4mJjCV+p623+imxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USpVx/Faor6Virh7lGxiBOVttxwaifSBJGjo45V4SWM=;
 b=YM2HmDnoEr4BGv3CoI4Da3RgeSmp24FDGMf7uBYeHCAb+JKJUwi9WtmQbPYtrXXOnOtN7GDG9mN5v+uDOcMQ4B+kN/ZyLxHQ7U5hZ7DJiqj13IVo+dVoDoairH5Z9tkN81nOWfMshfiwkI5hlnoEcME/Zt/NrV7fVp+kHqF9Mp8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB6959.namprd10.prod.outlook.com (2603:10b6:510:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 00:21:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 00:21:47 +0000
Date: Tue, 19 Nov 2024 19:21:44 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/6] nfsd: add session slot count to
 /proc/fs/nfsd/clients/*/info
Message-ID: <Zz0rmE5Htx3xVbDQ@tissot.1015granger.net>
References: <>
 <Zzzjjln34sdtnEkI@tissot.1015granger.net>
 <173205497998.1734440.4810487064683118888@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173205497998.1734440.4810487064683118888@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:610:59::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe50d63-a033-4737-4a13-08dd08f951ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTtqvd27yqQl9fiHV/2539C+w0W+vRuOcdzYPbvBnR4kxzmxISt2CNs9hyvE?=
 =?us-ascii?Q?DrNgrRowUZcwQjFQt8tFXQabLX+cQyzXXFvh372Axs8cT3tyFY18X15PjEzq?=
 =?us-ascii?Q?DKUnyXAH8ulmWWwriong5kJm0Z82kaoo60GnxkN7O7wJm2vL6ZtBE5FCjd0D?=
 =?us-ascii?Q?YnBfVEMhZlW0R2aqLD5uxOkGdo5PTq8rzWK/5XFjnbOi8db4R4+PBls4MZRz?=
 =?us-ascii?Q?aFKRXrlVu7H5w1IGnEv/mOQn//c6BkSJudor+Wfi/MWVeca4HQK7CzZAfwNL?=
 =?us-ascii?Q?UOP2iU/e6Mnb6dkeXr2RxzxR1GkRmR1c4o1zpts+OebKWpnYDSiphHI1e9tT?=
 =?us-ascii?Q?NjjthR0cWx6lIt+L8qX+D5ij/YMXkqgDyT8LveebjH2oaRgznaTBw/SmRXwX?=
 =?us-ascii?Q?83+VoQ53LqrOyHE1Cpxg1pJlSuqJIMNrCC1nnDTtnb8UtKv66Hx7Y2qiMrz6?=
 =?us-ascii?Q?SDjjDEEks5SbITSVQ1ezdcUEldz6srfT42r6HR8x/wlYPFwetzc0HPUC0Z+l?=
 =?us-ascii?Q?moElksvTl4bPFPxmZqI3MF6fk+AEcVbXPYNTpiirQlNvxBe7d7gkY8fwrOIv?=
 =?us-ascii?Q?7r9pskzI0+KUI+Haru6NNwDcBnfcpIOIrUIhySEo6mmEXKxAqBRKNjxP+QRE?=
 =?us-ascii?Q?5uvVEx9CHKDIGGnfYQEOaBcWCDVLpK68eFrZ2hFzBk8iIqh4btKN95i+XK1h?=
 =?us-ascii?Q?COhSCFWLCbvks4aTk2+l1ufPlujGpwHyRRHtPqmRhNzr7eYcd3yFYLHIQPCe?=
 =?us-ascii?Q?jH/QASWBgcbEg4VSRJQJmKtT8mDdk4BbReu6sV/YQes8mo0nAB1CQ0vsf+Sv?=
 =?us-ascii?Q?d6f3hgYacOMR9iANkB1R2uYIv07Aj6s1QCMLPegNjdJADxJWtJ+kbon/Xocn?=
 =?us-ascii?Q?BHFlL7fagVj+64z3BRvgLcmNVYuLL7Y5PjjvZpIZSjN23LMNVmgbV/MyKz3J?=
 =?us-ascii?Q?WMfsilQiTLpCEsi+qtLDXHLkijDlBbcv3rNzW2DwI/JdBB3VjwD8p8ryFmJ9?=
 =?us-ascii?Q?YFeFyRLpB6a8CF1dw+eqwJ6IRVhgr4GHgi2PrdSAQf90FWU7zX5Psk6Ev8j+?=
 =?us-ascii?Q?PA4BKSDvWJEsvdyjbKj9dX6Dy+C0cvsjmz3Xpk2JLRJGbafLkH4xFhisNNz1?=
 =?us-ascii?Q?mTASKYyuBmni4fmDqWqHAYq4aeKN02HJBGmJj/97StT2OyNxYSfxzWyD5QJf?=
 =?us-ascii?Q?CtqedJ2EubSFaTl7dmDuxbHsc52R/YTJLfE9ZlmFBQ34Y9wpY146x8hQzXNg?=
 =?us-ascii?Q?3kG0iB0B+AvNS05PBzBm25/IZoxnlrZ9P/CJ5RYgVSjJEL5SpTja49PICfRF?=
 =?us-ascii?Q?oOM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+VF5Gp9m4IntsZm1RDXV4lHvFD2jUxg0EtIoiCumWxHrYa0In96ZlaeR+0Es?=
 =?us-ascii?Q?au9GCIOgx3yDkyDl9r3zscwfKuRRTGZZVG1FnC/RrzZwY6hYOpWmXBLpBrK2?=
 =?us-ascii?Q?xGR3lHiJ5WfBWA8/lEH4zDsIKLF/z7AJaGFSnssiHp9gNSPr7xlANDqTOSbA?=
 =?us-ascii?Q?kcTvBiTQ/TTCubfbjdqIoZdbYK5HsaMa+h3Z6CNlESB/kHOTuehBdkhAeCz4?=
 =?us-ascii?Q?Vo0vFHCzs1AkcA06Thl47f5Wfha0gTkrvmGwUtR9BiK2RTuXpIwrdR9Zg4FC?=
 =?us-ascii?Q?tiGWbh3x2OGHzms1nLcHURnWXGW3AMBzlO25+/QjhY1PrxpaxLXUR0des7OQ?=
 =?us-ascii?Q?tMe/+vi9reGddUj6S/l0ttoSqeJ49LRVJCdHs2kZ4WCzTaGlzoB0McVrVrR6?=
 =?us-ascii?Q?Y+piBrrPaip2Fy5j0vvyEmxU3DY0jbiFl+HSK+9L3bE6AcrDbXlnfvuxxjZC?=
 =?us-ascii?Q?eNpG/rxSiSvPotk7+8+e++99dMBTol3TCIt6wMi+5X9FRTmBHI4suhz3FU55?=
 =?us-ascii?Q?nezCUS3YbMvLarSkE4tzcyHFx7fG2U/Ny+jwkfU/yNA5+5z8S0IBGN/HA2yg?=
 =?us-ascii?Q?K9EhLmcTvtQAWV/hOIhD/vzcmGw2RS9XLmHQUsepp9TIDb2Yj4W6kPYJsB/W?=
 =?us-ascii?Q?1Cw1dCD1fU0gUbtPvbaOuSKZSt0A+rf7cNYyf6mhanHxXXeszTQA/4pOBHGa?=
 =?us-ascii?Q?JiAbMMXJRX1s1w1zcxhzr/kS5QfEVaJ7rP4UEVTvwQTLGw/porKxAvdz+0E5?=
 =?us-ascii?Q?z4R53MZAro/jWVmNqA8eVEAypG33IgRHfk35qA+lfpngsOb02ryjIrkheRkj?=
 =?us-ascii?Q?KvB45zUlAnADckhS8pbD8uN7z0w7aCd8QAemer7+59CgYnD3nNgk8/4Je8A5?=
 =?us-ascii?Q?BlNXLMIcd+31X20DaSJ5CEDcs8iH4jDe+rQ2D6Vk/uMyRfp8i5bL6fJaLKUo?=
 =?us-ascii?Q?YKmcAAHyk1UYr04VWjwGEi0DX6EJgYFx7rbqeG00GqfTUK5QaLHXdhJK7tFk?=
 =?us-ascii?Q?TLpWMJqZbRDKfL0Px9QiAhsFW90iOmRIE2ivceiC3aadZEQHlGwVm5hUOdBL?=
 =?us-ascii?Q?dKG/8EZPQPFwf8RgGlbu5ud5eVYXP/EP+t94Tz9r7zzehHletI6cUmeCsviZ?=
 =?us-ascii?Q?1zQyEo+0jPXMK9uADxLIZIMp3gWXDz9DL7lsCQTx7kebD+WIjmAFljF+V4Sq?=
 =?us-ascii?Q?w8LecZE+S+tz58Su3F3HLQhS+Z7lzc0cDYkcozu4q33Md7KKrnS0HkMFm4oQ?=
 =?us-ascii?Q?H+YT7eF3ZTCwqklc6WkPe8y047eMXvodc1riOCw4JcAMoI5jLafCl6aUt1ht?=
 =?us-ascii?Q?jxSBxC0Q2947qf/jtz/9ucQIJIEguI0Q1VggeyyULxF6YhRUc8iFifZwb1v7?=
 =?us-ascii?Q?/V8tri3n7///VECI1JRRQjNPZ08ZuaNXVF2ALuXvka2wq3+4R5DswTyo1iD5?=
 =?us-ascii?Q?uq5JEMKECehDni/9XmTtPPWZMWSqpUJNqYeaGhSgtLuIXkzJ4f02+77QtXcT?=
 =?us-ascii?Q?OnM9p+THKNM3FLYMYABx6RVvyJxBXSMFes7mJZWznycI3gVkqMrr7GOV5awR?=
 =?us-ascii?Q?HjcmjgndVPevCB8YULXLGicPRUXkoRensjc265jdb93CWk/dKDh96oSNhZXl?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fsQMfWUGSySpkxPMKZ6nF2e9A67aHHaUynea/9qRanCh1el5WcVfwHtKffhnUThjGuU1R7X+VJSo/8IJw4OfTCdTMLjXq0l77CJ5cQiRK4BmE0qqkB9avMPBdVbqlDBFVKOTJi+Ifdqkz/4xekG1i1qA5CWLv4X/WCSj9xhn9Qv0chbF9BnTDY4oeCt20T0271xYP9kRZhLkl8Jm9g2XcjPIKwhbjSZ3pHNxgg/0wijPMamwCGorjYulo3Ppqyzet7tkjgw618VuPZx2wyqIHjXt5ZD5KhQyA3dVg9GO3MQeO92mVgXzvxQzNQ4eVrpQ1LdCoIFJXDCuPFVefODR1Op81gmN8U5I4kPf9xBAQE122rAwYeOHAwx5L5xdMiuZOA8XgkWjhchsLnBsZUcx9lCdmUuB/ELIPxFFzIciUZKm49aBygaaz4kDUIIe5ue25QvR+b9e3WbGEe5V8M0yrxlLRscBOWZb/crUM7lYgqshB0af+rcnf+mzWJBzHiatoXiSr3T9w8WEWpX/YE0AuZo4bZVsQJQVtEtXH1nnjek6pyyab0AHmstqn/wWYqZ41awt4fqrwz8GsJtQJlLQqiqZKWpGF5ufzXmz4ugskUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe50d63-a033-4737-4a13-08dd08f951ca
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:21:46.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1MkDJCPi3X9mpOnBZKpyY3T5Wz/LTOaBt5shxRdEbUoMkdIhqM5cFIZbWUFHFOYXjpv8CQmQ89Cya3X7kdavw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_15,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200001
X-Proofpoint-GUID: t26bUWOplwOL5JDLrCWv5rOad0dIxQZk
X-Proofpoint-ORIG-GUID: t26bUWOplwOL5JDLrCWv5rOad0dIxQZk

On Wed, Nov 20, 2024 at 09:22:59AM +1100, NeilBrown wrote:
> On Wed, 20 Nov 2024, Chuck Lever wrote:
> > On Tue, Nov 19, 2024 at 11:41:30AM +1100, NeilBrown wrote:
> > > Each client now reports the number of slots allocated in each session.
> > 
> > Can this file also report the target slot count? Ie, is the server
> > matching the client's requested slot count, or is it over or under
> > by some number?
> 
> I could.  Would you like to suggest a syntax?
> Usually the numbers would be the same except for short transition
> periods, so I'm not convinced of the value.

That's precisely the kind of situation I would like to be able
catch -- the two are unequal longer than expected.


> Currently if the target is reduced while the client is idle there can be
> a longer delay before the slots are actually freed, but I think 2
> lease-renewal SEQUENCE ops would do it.  If/when we add use of the
> CB_RECALL_SLOT callback the delay should disappear.
> 
> > Would it be useful for a server tester or administrator to poke a
> > target slot count value into this file and watch the machinery
> > adjust?
> 
> Maybe.  By echo 3 > drop_caches does a pretty good job.  I don't see
> that we need more.

Fair enough.

-- 
Chuck Lever

