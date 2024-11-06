Return-Path: <linux-nfs+bounces-7718-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025CB9BEF25
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 14:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 484C3B235D1
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 13:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E61F9AB3;
	Wed,  6 Nov 2024 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a0zD4j8A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pRbclrQX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19B1DE4CA
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900142; cv=fail; b=T9AdRPY+Dwj2C1DtStJDjTosBLj7tAzlDkN6McrnOPs2K88tqUEFoueD6ZkVevSDS57tJnrZgvfREHa11BeJaF/eYZZ/0H7a4ZsjmtqPuuIXjinnwNpowFFg1kwl2opNd4Zrt2kbqEICffhLuqbU5VEdRVLE9KANNyyzO6RQM+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900142; c=relaxed/simple;
	bh=Pzgk+9VDG2jAN7kiF5Tu90QyrabfiouXSX06LVRHNvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WOR1VHf2NlXDNFeSXKWH9m4vNibjKeuOwe7c34E6sb83YupYnDqLjSYKghGIsMd3+yjOiWt1z7u1YWi/IkhmiOyfkjLN7n83L3a7rrhQfxFcfjXq1I6Olx7p4eH94mkAlSTCB5/m5TnaP34yNNV7VvtgFq5UUCaqLeDuPMECQ44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a0zD4j8A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pRbclrQX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Ci7LW027491;
	Wed, 6 Nov 2024 13:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jMjxKcGR4BA7cnF1ZY
	NXcKFeT57rcbfvLd8ong+kMp4=; b=a0zD4j8A/8jf29M4qGJxlU3swhUZwcyMrh
	XdRZeysPAcuPG6RcBKxuWnMPSrPEPo/38tOSxTPhtZD4k9QhX0aBcB7zOUvirFpw
	sBjyh9Mi+QXcR1UC4ftBpkkv4PkAX7958khCPipyHtxQXH/Jn/AV0Vy4Gn7RjiWZ
	lP0YqPOUQ/Zn71S4aLzniYJH3OZUV0vnTJX/r0wgBFgaFwFh3GhQ8bDxrFQPG+R4
	kc07ID+S4BkgNVc6IRXHZYsQbkIqIY+59oBryhdp/ZlRg0zFLITHoXDedWnxYrtW
	CNmG/FgGWiIgxUoqQfBJejmmBYRDEmkycwYGjJA//fEbg4VhZiSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmt7rnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 13:35:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6BlH1A035232;
	Wed, 6 Nov 2024 13:35:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42naheuhnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 13:35:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKKI8mepPftC4cqImHeEaPXX+z56inmhptvgo+jyvcLWDdCbPWU1tdvvzify4w4680G0JBDlBYvF23V0o14YN90gsOj3HKY6YO7CI5sUOHECZ4pUv3Ff1VY3qKYFMF7QhJ8SYsz9yXyGLKcxr/IZB+asXrvvy47Rcod/i68o4HeWgx4kYE5YOXUlkxu18/k2AudEqq/AsSyvZA6nbkosY3OVdqxNu0+IhdMs3+afJ7fBD5L86dsdoXLYfhW+uOXBKNlJTKq9zp6V1GTg+z5EWe32FUpEIgsI0dgtZyGB5OhSweegtTZjwGSw+k62chWjCSXmv7WAxMywFBVTpzb8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMjxKcGR4BA7cnF1ZYNXcKFeT57rcbfvLd8ong+kMp4=;
 b=yHNQmrPnd9cXfg1dYME7NkuQr7nRXKBMyhXRkiQF44WG9Hjv9T1h4hrBT7/zFcD+/1Bjb+CI9A3pnhR6D2M6x2xdusGBNwWbe1KhYuUlqfRnTsCevYbPS4+0bEA8h/97t9FprGgvj8I8GJTzvpQ2BxTsfwUqRdewAJSEMTTYWD4p9g9YHPFTiuXY0TZO3fqT0xNY9UwkQUkWPT/XO99OiIiDd8ze8bYdpodpPuCgsaKv8FOonPBk0lAKu79cVr/gYpwSz5KKf5AgV9LOvc+prLetDcs1ZtLHM8qe6lqcJb2XEEQ4NA5PKs/5WwhZI+ULG8n8Cm1pV7zqqBDvj69ezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMjxKcGR4BA7cnF1ZYNXcKFeT57rcbfvLd8ong+kMp4=;
 b=pRbclrQXfDnKnbkAqT0LXOxrpJgf95KM57LIdL62FZ73ENcNsV923eXln/EKvLGBSi6eVxPfiSnxxVRmgKoT1Z0tdkNoT0RxnvNi76ZAWPEYIHv435Cn6pPSfiRfc+7pEdVbxjz2XzjYbUW/ndaf62oJGpV0gB6WfD11smPm0kg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6072.namprd10.prod.outlook.com (2603:10b6:930:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 13:35:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 13:35:05 +0000
Date: Wed, 6 Nov 2024 08:35:02 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Yang Erkun <yangerkun@huaweicloud.com>
Cc: jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trondmy@kernel.org, linux-nfs@vger.kernel.org,
        yangerkun@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v3] nfsd: fix nfs4_openowner leak when concurrent
 nfsd4_open occur
Message-ID: <Zytwhv08T2lKhGwv@tissot.1015granger.net>
References: <20241105110314.2122967-1-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105110314.2122967-1-yangerkun@huaweicloud.com>
X-ClientProxiedBy: CH0PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:610:76::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY5PR10MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 4104133a-ab93-436c-3fd9-08dcfe67d2e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EQaAUhKosDeh2Gsf7v1AmWYqL1jBnx8N+R1Pbq+VDO2ldJOt6iMCiYEHLw46?=
 =?us-ascii?Q?skpoIT5OeaZZVHicoJQow6BwgrkxrXKSgJ27tjaKk+MGL0gx294WdEtTQ2wz?=
 =?us-ascii?Q?t404J138huuWV8ypoxZET7b95ITZXN7p2SDNMmNRgqYjG2SWO5pWNuTBoNSc?=
 =?us-ascii?Q?iG6Ge2rAt30Ac90W+uSLCWhyWbynNlJaPpIGvlPJ0JI0dcKZDn8fTjVEUvOa?=
 =?us-ascii?Q?O6X4FU55Zysi04Xq4Uv4jNH/Sfppo9PU6hIYa114oB0OhG1vwSzCR8Iy5HME?=
 =?us-ascii?Q?SCeo18niikVoosFPlMG7I0jSaUgswuT6GnC2EY7rouC7dxbJf2Quhmm5af0N?=
 =?us-ascii?Q?oWQi816zFVWoP4sUAI7lvBm4t1/b5Xhb1m9Ki0HrzX0G8m4tEMw7sS4VrIa9?=
 =?us-ascii?Q?re48Jmjdjw1PMI4iTN2vb81ZdGiJXJ2w7tYUzBk+coRT4KnIKlKoOxYOguw7?=
 =?us-ascii?Q?rnc77z38I+CrE8YL/2iBqLIUGV2lk0NZeB2aJvqAgmMTdiMElBojPMr92E6s?=
 =?us-ascii?Q?rELwIugdn4zEKblxy9BZ56dD4sQMSc4lEy9fY5siRXLoaoF6zOoAefTYCdjF?=
 =?us-ascii?Q?N1PI2+eVuDaRUt+vZNWqeaYaZEtCLFMepJQj1MUA1vJMgPgMao/mj8xEJCwL?=
 =?us-ascii?Q?lLGQ6tLWaTZonu4EH5Al7eLjLN7fnD8HtA4veiyjyughOxUK7MI5jm7cwHdB?=
 =?us-ascii?Q?i9ROiABNwZrgLH+8vXMXe8qYy/WX1pXQvA43JTkPGt6gNCAUhgNB2dOU53hA?=
 =?us-ascii?Q?JnOjVhsS4SdZxjmaSB9X6c9aSJ9mYYSFUyrzst0pWOCbwgvxXgpJdzUqYtJZ?=
 =?us-ascii?Q?F68elyVMzRE4YGFq7RCt8Lekm4l9Y4CTJ8J2fTHpihGoRy5YylOGXPQ/tSvE?=
 =?us-ascii?Q?DgqZg+zn6s9bZXqnTZ51xEfsSTqhiZlCCY99ee4qzt/9CTOs3GtsFnRK1MRb?=
 =?us-ascii?Q?+3Us8TWlZ6bsf8tux6XdZQWxFrAOzgPe/FaOAWQH+N5G9pM1D7wPlwNjzfaO?=
 =?us-ascii?Q?rLwrWWX4PH7UdLDpQkh1RiCFAAZEfNcx8TNr3DQugssOVmlg3JluCL12DOzB?=
 =?us-ascii?Q?aAboFHW5Zu/up8sl1QziNlwGriWQKJCXvb4qSsabPTR4+9OUwnL5xh20O8Ex?=
 =?us-ascii?Q?k8V2WWriYAHJbZWgWmNMalGrf4JPHM2UU8PtIulgZhSoIu9VBlxJxBsL59jH?=
 =?us-ascii?Q?fHGOG9Sg3JXe4zQSIVUzby8XbE/zO+52AQgrkqMVkLgn1Sa4AMSvWDXho0iW?=
 =?us-ascii?Q?t2LyTwMRwc7bY4HuNEeTXinRoMpMhaXtSbTHxEoHoCaUqxeL85/tT494LQOv?=
 =?us-ascii?Q?vQ2X1BK7JDpba1FPBmpgzRZI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2FF0DV9DkvqhjI7qJbEjEOihottyqtaOvmq8nhyYh//vI/OUFC3PUzptT+I4?=
 =?us-ascii?Q?VgxBTANgDtNIjhyoD3+5pQMSoC4o/ikTTsPZ9OavGcATO1JfExfSsOIRGi4s?=
 =?us-ascii?Q?qGTV4wAre9eLilzChgtxuKMLEGggPqoFlCYNLGFkymPM1b1prHpE1y9o5s20?=
 =?us-ascii?Q?4S/r/KEJEP9fUOh5/0lvGZ74ZCU6UGOSHSGmnOab+DfhauaCEueXlcD9mtcy?=
 =?us-ascii?Q?Hzq4H9MsUfdWBJ+s8WjSHbo95Px56lFUCBqNwSVw3X0/4SFia2b/jhtmFFo6?=
 =?us-ascii?Q?k0m3xUI86zZyZ6tGG+Pwq1i6UFTaVcDVURMaINaEjEyVRuVJgajGg2v6+6Nr?=
 =?us-ascii?Q?d1PwT9rpGucnlNtxfRYwy/sSqX0hcKg9rp1k1BGyRFU/ubFJC2y5/jin4UBK?=
 =?us-ascii?Q?ogHDv1Etgg1qa4MBVA0K5vfGu5oFtm+Ma76MuKoySMB9kH6BA7GM6tV+Zfy1?=
 =?us-ascii?Q?HiR/eVsEg7/RhLznp/IlwM9qa5ZKvHEND/iLUxn5DPzYSRvhkkJ63QLiAbd0?=
 =?us-ascii?Q?Uy76toi4WLfNHzd36aw28QITC0lXzjQ10CCj/hc8myxXJklgt6MruwwSrZYl?=
 =?us-ascii?Q?lalnMVsnMc9sMSLvzpfS0LCHfNB4MmvJAGkzoJNSMQUTx8b65OzDqRDJzylB?=
 =?us-ascii?Q?WYGKPTPgaoo9hTs3ynUkdQor83xdyftyuTXvJwxPgWhbuun9MsskRARGbcZp?=
 =?us-ascii?Q?XmyZFoR7MhC4Xxj+nrL5DaCuTMiiYp+j7vq9eZ1sjU+7RbfoRv5bE8EcFQHw?=
 =?us-ascii?Q?EKAtFtUddDlWhkUxmxS6qawuKJSygXaE+H/T3U90LJdms79sbHn4BDEQbpaH?=
 =?us-ascii?Q?SpjbVX0WMy5FprPikZ0046yA+vv9gFQAmi44XnS6BrHWV6dnEtyDcEqs+M6g?=
 =?us-ascii?Q?jMcWf0EyiUTiLcNF0bn7jTarITAqOmAchoKuR8lg7OYD8I7RFJjb8BQL2br5?=
 =?us-ascii?Q?S828pPA4tFPTHpSGmsK+AmM61Rtu0W47ClqssCPMTavTqhlusmE0jlgGA4S0?=
 =?us-ascii?Q?zwj+7SNn/6H40yPIh1yST+EoIuYK6hqqSF09b/QxvdS5g1Qf1CA3vqV4g063?=
 =?us-ascii?Q?i35kis48I8t3CF6GbkF2oqCytm5SHtsvAVr38zfo2YuAM28vZNNOrkaV5Y8i?=
 =?us-ascii?Q?YXCX1sbxyLWTOt3XKaP2sjQqy09mCk3qkTZXu8IBtIn4tFRsuG4OeOdvhwoN?=
 =?us-ascii?Q?HFQASnmRYrSKyzML+OOOR+jy68JsjiafANy2gZNuS/o9a9V6niQyQp1ys3A4?=
 =?us-ascii?Q?fHZi+1MNuiQXRopVX0xXr5kLO5tTi2X9h19f/Kpvf6h2n7mamvHEPUiUkbze?=
 =?us-ascii?Q?a74WvxV3dndu1K2lvfONwGcwWP3Wr35OaJA0E7DrNN8GFO32Bx3UzkFnxP4J?=
 =?us-ascii?Q?wV5fbYBlQF8DDRqctrnz2yKrQJUKFEwfYCYFVv0ClMtWCsfrCCOLAfJOVA/A?=
 =?us-ascii?Q?DBuhXVqsrRLVr90IM1MoVnuhlTTWNhildEpDSAlQaEnHuOdRHHBwS/f60hrv?=
 =?us-ascii?Q?pTifae3Q2HHwjVrzbX7NYhNSY54f0pevT+Ow8gYJwa+Ujcy5nEIlQaMWZI5l?=
 =?us-ascii?Q?c1+biMeJh+3N+hacBAplmjCMtczx/Iycnkt6hHh6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GkL6E7DyFrHXPp0zK+JtCImKgZ3d+UlI5oHnKBvYQNw4kkPB/a6Q4MfUoTe16njm6rk0NoOTeb4Ui5suQguoSWchFj4y1eI+mEXTu7H0PzvRVTgvlSIIjNzLG3c4ghBe3Z52uexne0iPB/HNNrwR8uJ9MQvJr4Mbk5aKqh+Sl8LF3ShxitFE/p4y+6nPfgoDwD/N/Pbrrek3XXsB6E920vAfdMH79KMkAg1bOP0DZvlFW/7NDUrp4F5tMDWjUapI01SQyspp4RyWaHjP6b3yiIw2gTgWgSr+MQocuhWgSfNIaNV2rHjfdsUgfJxYPnbW0nnQUMI0SVye/4Rd+JvkYMdNY4dmuKwhxyGhjvhBMHiB6Q/TF22DJSBIArHs4rCC4/0E+OW7BKHw3FnW0kWCbhXbvLyoHMVAW9ppP84yTubIyZtA+Tbhl3nWgF0KPjGdv4aPxe+HtSifJt5zShtxUa5BwH173JVB3CXkxTWqYi+pE5u+o9CRkPWBIpeH9t3fwENIJ5k14d4lY+Oap3ySVuhi1J6NlYzSV9a7d76WpLCa+c31dxBfxwIlfx9xcU2y979LHSJp4jJnyViL5+Arv7rQ4y/5n1unwgA8QkDwDTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4104133a-ab93-436c-3fd9-08dcfe67d2e4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 13:35:05.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3kJ1w6AZNO1D+eUBIZuJBLom/G6OGflvlAvwdvWUNRsc7HvOVWZlrkDf1ONQAgRiaJe6rjMnjJWjKxmGum5gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_07,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411060110
X-Proofpoint-GUID: 8baBSdd37E_m5FyNEnaO7H-qH72lBKa-
X-Proofpoint-ORIG-GUID: 8baBSdd37E_m5FyNEnaO7H-qH72lBKa-

On Tue, Nov 05, 2024 at 07:03:14PM +0800, Yang Erkun wrote:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> The action force umount(umount -f) will attempt to kill all rpc_task even
> umount operation may ultimately fail if some files remain open.
> Consequently, if an action attempts to open a file, it can potentially
> send two rpc_task to nfs server.
> 
>                    NFS CLIENT
> thread1                             thread2
> open("file")
> ...
> nfs4_do_open
>  _nfs4_do_open
>   _nfs4_open_and_get_state
>    _nfs4_proc_open
>     nfs4_run_open_task
>      /* rpc_task1 */
>      rpc_run_task
>      rpc_wait_for_completion_task
> 
>                                     umount -f
>                                     nfs_umount_begin
>                                      rpc_killall_tasks
>                                       rpc_signal_task
>      rpc_task1 been wakeup
>      and return -512
>  _nfs4_do_open // while loop
>     ...
>     nfs4_run_open_task
>      /* rpc_task2 */
>      rpc_run_task
>      rpc_wait_for_completion_task
> 
> While processing an open request, nfsd will first attempt to find or
> allocate an nfs4_openowner. If it finds an nfs4_openowner that is not
> marked as NFS4_OO_CONFIRMED, this nfs4_openowner will released. Since
> two rpc_task can attempt to open the same file simultaneously from the
> client to server, and because two instances of nfsd can run
> concurrently, this situation can lead to lots of memory leak.
> Additionally, when we echo 0 to /proc/fs/nfsd/threads, warning will be
> triggered.
> 
>                     NFS SERVER
> nfsd1                  nfsd2       echo 0 > /proc/fs/nfsd/threads
> 
> nfsd4_open
>  nfsd4_process_open1
>   find_or_alloc_open_stateowner
>    // alloc oo1, stateid1
>                        nfsd4_open
>                         nfsd4_process_open1
>                         find_or_alloc_open_stateowner
>                         // find oo1, without NFS4_OO_CONFIRMED
>                          release_openowner
>                           unhash_openowner_locked
>                           list_del_init(&oo->oo_perclient)
>                           // cannot find this oo
>                           // from client, LEAK!!!
>                          alloc_stateowner // alloc oo2
> 
>  nfsd4_process_open2
>   init_open_stateid
>   // associate oo1
>   // with stateid1, stateid1 LEAK!!!
>   nfs4_get_vfs_file
>   // alloc nfsd_file1 and nfsd_file_mark1
>   // all LEAK!!!
> 
>                          nfsd4_process_open2
>                          ...
> 
>                                     write_threads
>                                      ...
>                                      nfsd_destroy_serv
>                                       nfsd_shutdown_net
>                                        nfs4_state_shutdown_net
>                                         nfs4_state_destroy_net
>                                          destroy_client
>                                           __destroy_client
>                                           // won't find oo1!!!
>                                      nfsd_shutdown_generic
>                                       nfsd_file_cache_shutdown
>                                        kmem_cache_destroy
>                                        for nfsd_file_slab
>                                        and nfsd_file_mark_slab
>                                        // bark since nfsd_file1
>                                        // and nfsd_file_mark1
>                                        // still alive
> 
> =======================================================================
> BUG nfsd_file (Not tainted): Objects remaining in nfsd_file on
> __kmem_cache_shutdown()
> -----------------------------------------------------------------------
> 
> Slab 0xffd4000004438a80 objects=34 used=1 fp=0xff11000110e2ad28
> flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
> CPU: 4 UID: 0 PID: 757 Comm: sh Not tainted 6.12.0-rc6+ #19
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x53/0x70
>  slab_err+0xb0/0xf0
>  __kmem_cache_shutdown+0x15c/0x310
>  kmem_cache_destroy+0x66/0x160
>  nfsd_file_cache_shutdown+0xac/0x210 [nfsd]
>  nfsd_destroy_serv+0x251/0x2a0 [nfsd]
>  nfsd_svc+0x125/0x1e0 [nfsd]
>  write_threads+0x16a/0x2a0 [nfsd]
>  nfsctl_transaction_write+0x74/0xa0 [nfsd]
>  vfs_write+0x1ae/0x6d0
>  ksys_write+0xc1/0x160
>  do_syscall_64+0x5f/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Disabling lock debugging due to kernel taint
> Object 0xff11000110e2ac38 @offset=3128
> Allocated in nfsd_file_do_acquire+0x20f/0xa30 [nfsd] age=1635 cpu=3
> pid=800
>  nfsd_file_do_acquire+0x20f/0xa30 [nfsd]
>  nfsd_file_acquire_opened+0x5f/0x90 [nfsd]
>  nfs4_get_vfs_file+0x4c9/0x570 [nfsd]
>  nfsd4_process_open2+0x713/0x1070 [nfsd]
>  nfsd4_open+0x74b/0x8b0 [nfsd]
>  nfsd4_proc_compound+0x70b/0xc20 [nfsd]
>  nfsd_dispatch+0x1b4/0x3a0 [nfsd]
>  svc_process_common+0x5b8/0xc50 [sunrpc]
>  svc_process+0x2ab/0x3b0 [sunrpc]
>  svc_handle_xprt+0x681/0xa20 [sunrpc]
>  nfsd+0x183/0x220 [nfsd]
>  kthread+0x199/0x1e0
>  ret_from_fork+0x31/0x60
>  ret_from_fork_asm+0x1a/0x30
> 
> Add nfs4_openowner_unhashed to help found unhashed nfs4_openowner, and
> break nfsd4_open process to fix this problem.
> 
> Cc: stable@vger.kernel.org # 2.6

Hi -

Questions about the "stable@" tag:

 - You refer above to a leak of nfsd_file objects, but the nfsd_file
   cache was added in v5.4. Any thoughts about what might be leaked,
   if anything, in kernels earlier than v5.4?

 - Have you tried applying this patch to LTS kernels?


> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>  fs/nfsd/nfs4state.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> v2->v3:
> 1. add reviewed-by
> 2. add lockdep_assert_held in nfs4_openowner_unhashed
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9ddb91d088ae..37888562b436 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1660,6 +1660,14 @@ static void release_open_stateid(struct nfs4_ol_stateid *stp)
>  	free_ol_stateid_reaplist(&reaplist);
>  }
>  
> +static bool nfs4_openowner_unhashed(struct nfs4_openowner *oo)
> +{
> +	lockdep_assert_held(&oo->oo_owner.so_client->cl_lock);
> +
> +	return list_empty(&oo->oo_owner.so_strhash) &&
> +		list_empty(&oo->oo_perclient);
> +}
> +
>  static void unhash_openowner_locked(struct nfs4_openowner *oo)
>  {
>  	struct nfs4_client *clp = oo->oo_owner.so_client;
> @@ -4979,6 +4987,12 @@ init_open_stateid(struct nfs4_file *fp, struct nfsd4_open *open)
>  	spin_lock(&oo->oo_owner.so_client->cl_lock);
>  	spin_lock(&fp->fi_lock);
>  
> +	if (nfs4_openowner_unhashed(oo)) {
> +		mutex_unlock(&stp->st_mutex);
> +		stp = NULL;
> +		goto out_unlock;
> +	}
> +
>  	retstp = nfsd4_find_existing_open(fp, open);
>  	if (retstp)
>  		goto out_unlock;
> @@ -6131,6 +6145,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  
>  	if (!stp) {
>  		stp = init_open_stateid(fp, open);
> +		if (!stp) {
> +			status = nfserr_jukebox;
> +			goto out;
> +		}
> +
>  		if (!open->op_stp)
>  			new_stp = true;
>  	}
> -- 
> 2.39.2
> 
> 

-- 
Chuck Lever

