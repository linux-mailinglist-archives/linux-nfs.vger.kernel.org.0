Return-Path: <linux-nfs+bounces-6988-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1424999760B
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 21:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5B71F219C3
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2024 19:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9021E1A12;
	Wed,  9 Oct 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CxNbvV9I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hJuB2gy0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CD81E0DAD;
	Wed,  9 Oct 2024 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728503722; cv=fail; b=c75ZhxD1BIHi/7by0JMjfro6V3cybhz7TbkCxp350GU/JpRn/lOSEEKYoXfqle73qR4IjWhZlHkV0b50Q17YT8IED6TWrUz/kKhMQZthSpmuPNRv2KXEJcbv2VNfhLCExhNtsq4nQfUUVUNknbeue5RDrxN7p+JwCE/cV3l9ZzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728503722; c=relaxed/simple;
	bh=h35UCPmqlvPwPKY3OyDAsMH5swsG4Ijhrn9Iz9OrOu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NGbCTyCk2YSWqUp5y82zcrfPwC0GO6Y6hh+Cxf/YvEHcPEuVsHKhsnpeogw4e7Y8FYlQxqfqlGxRW2VwZn2v5Qh+3YBJLuB4oEe5+GKOg2QljsDlDM7MNCRo9xcbhkgvGp+1qOBAE0GoQBr+hcVGF4zdlynvQGpAPa167rUGpkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CxNbvV9I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hJuB2gy0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IISGJ023531;
	Wed, 9 Oct 2024 19:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zB0QuFqZga182GB9Yv
	8rbfwPlr4P8DOlJEGRQCC4e6A=; b=CxNbvV9IxYpZJz3FZva17KjaXQajAqz20f
	no6z9tUPDBwgwMzbytsaJKcI1tCJTt/yflJ52/y5k9qvM80m9CWcG4UbqzL6mtYv
	uWLItdFDM9jFGiPgizEvBQN7XMjlA6b/CvhFTWy4tqvn+JQ1BNP3YyIGyjPad5tf
	9zvuWwb7WKoZ8V2yT3ye+ok3gu4xINdRxpFQvxL0CkHu/1efsWTC6vh8aqhlLwKq
	3qaRCByjetnjDppX5gK11jJ6nveOeuedShRC60iptgUocqWzsSaAchzkPslbI4xl
	lcfsiMsjldv9LZezf5OQ525DIVkhtc9RAIajzUUbscyBXBAQTELQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv9ade-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 19:55:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499IjMIx011689;
	Wed, 9 Oct 2024 19:55:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwfe3xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 19:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dxa0WPSDORPzpD9/OT4b2Jy5jHBA0E+lbZH2omuWQSJ6qNcCGRQcw+UZLZEUGswGibquZlNBB0EmQNoLwKl0QrsKCuYOprES0XJVThfLT+wON868/0pTfrASiGplSmli3rvNiPI+BVNjSql1HDclcODku71ZnVDhNkTChYTou/YzVgXs3aNoD/sW3GBULsh+nLnehJ45YSVPCg7aWPq7qXhBZz5+VwDTF91vGIMfVKyPtOcylqmJY9hL5XHNE2Gb9N0JombxBa+SzyGnbHuRML0589xO/CzcY+8mekDK9Cv4ShokC32BCoi409atF3YjV7OvenpakPheKELjjhFm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB0QuFqZga182GB9Yv8rbfwPlr4P8DOlJEGRQCC4e6A=;
 b=GFFP6sI4W1+Rn8Rme08iGneIYSjlaXJB1TX2Uk3nK9f1ZPirTBnq3+XisK8a/IpH1nvzRwdDtO+hMQXMaibhM2db8hSwsAruBJ5PTb8yz1/5NZJV0/GcQDZvfDRBP8R2XCUCTZXl8Cej2gFyOvwgSaDDAloAoSRpS9uTyjjNppoo8XImHIkPQzPtVaBHoQXlkIqfK37vb+1uZoTwnsJuUGJbCJnObS+G1zpemMzroYwREFlOqoa02LxPZ+TfT7a9u6vao7MQRIbZ2P94JjQrdxtsqo9Vc/S7eTy23YJfycrvm1S0owTkE4qRTwdr3Y5rm34j2Y6kyMmsyb4q+OGsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB0QuFqZga182GB9Yv8rbfwPlr4P8DOlJEGRQCC4e6A=;
 b=hJuB2gy02Gda444pF2bNud7uNRDSdLdZns5iYKJSAUcc2SO8w16EzrJsqtWEPUMwlmJRpDfZGeZ4W6zsJIjIBBBUkmE68+UT5/JRzSreGgmxgZ5Mkn2TmgwOsD4KpW4O7fsXcC2eWKujsCX494M8dmgdgQ3X6XBAybL8dHaL3sU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 19:55:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 19:55:09 +0000
Date: Wed, 9 Oct 2024 15:55:05 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and
 NFSD_MAY_BYPASS_GSS_ON_ROOT
Message-ID: <Zwbfmf3L5XphaiGs@tissot.1015granger.net>
References: <>
 <ZwWArwU0XO8Y+Ctb@tissot.1015granger.net>
 <172842407597.3184596.2141619392088505446@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172842407597.3184596.2141619392088505446@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:59::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 762a61fe-97b0-4e24-239b-08dce89c4746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vbnzv3f1kUGmnyPi187FdqsFyxJ6iPEiBUWW/vzIM825KC0mGBm1Ob+Pv2l3?=
 =?us-ascii?Q?3h+//wjXWQItyNTcoqpxHcEUp06i905ZpvmiWiCEaE0HHiG+zNfdsjkKub+X?=
 =?us-ascii?Q?JUQfIF00389PiZe0uq/9GmnliQDhdfOjRjXKCzLO4ktn3ueIldqmgN7KwC4F?=
 =?us-ascii?Q?Zv6/wxzZ6x+VEp5Vx2vT/sNdgetktGMaHNZUob2b8RP0yb+LNkpVltYyTiFe?=
 =?us-ascii?Q?cpJsbd7kHLOiVUu2d3cbNkse/RDyxVC5gKgl5UatkiqpmMxlpxeVCw1YkORO?=
 =?us-ascii?Q?gQCg0GrCMaLAq8rlfaQLJvC6Glua/Y+COPjHulN8EswesAdRHJqvTfjEHbPK?=
 =?us-ascii?Q?qtVmFNomWNpb2aAdh4HtOaUOSPDh2nipAg5HnGVw7co+TheAaTE3a8EB1Q53?=
 =?us-ascii?Q?2E7eOWqbVmKIf5zu3XVFE6rP8HtgzFOm8QWDP8ynzMwC27IEb2XGkYKdBCfq?=
 =?us-ascii?Q?OixPa4Yn7j8vmCUxAjYQp2676LiVy/lS2GCvrxZBoaVs3T0/BGUlnjdbGpG5?=
 =?us-ascii?Q?4zyfUqb6HScUEm2kzXAxSSPfroSQVhodevdzEe2+6tlCKE+ptRRBke/3U1WW?=
 =?us-ascii?Q?fAP3OI4Ju/F4wBfg2vEe20AAQWed5RdVJbW6Rgic32TYH8v88nybKGQly0cc?=
 =?us-ascii?Q?kCHP1grD7CnpL0tPij8iimDEVXPjFdMWjFDKQrVJKsZyguk1eA+Y11ioowXu?=
 =?us-ascii?Q?PrjnTyIM0WOMTWCuVvITIVsf3AdVVjt5uRuDuGW3PCgfJs9q6mUyUD+wIN96?=
 =?us-ascii?Q?J1j/KbcOBlizZYaodBFK2FkaQFR7x2F4ukqeV6Rr9+Pt6k2vDEYKXbmhAkk6?=
 =?us-ascii?Q?AqxHSOs9l1Usc5ehwIbqVEQHh0eCzHBP52h2psd2Lo0j/2UCryRmec5ZsAJX?=
 =?us-ascii?Q?T2YxjVyCxH25HRLPzDztJ6OWiyf++sjq2dX3rr56Pthaqr//ewhwCc7qAkE/?=
 =?us-ascii?Q?m6Mq916bhhaj3Gq+YA+bLd9sHvjVsuDWu7an0C4Mvkqph714SZZE4WTYrhxm?=
 =?us-ascii?Q?56Y3gouAaRAQWzyeWC8IEteSctUxFaXOylzzxYSNS+NSGq/65dUaW8/LmMf3?=
 =?us-ascii?Q?Z/WOfnKmvPcALDWR2PNv8QaizlBoDPHW2B1nXW/y6IDK76I55EXloKGJjw86?=
 =?us-ascii?Q?wxesCpx4PlYXXiseSit253PeeqRL+2554Uijdv3AN4obxtvjA1Zmppd6yuYl?=
 =?us-ascii?Q?M3lbByqWl0HXB6+2rmHlHjheA7utf8FZBEnOEEYrwcfcymxv5k15kmzdBwtZ?=
 =?us-ascii?Q?8TfT1GpjIPO5piSyBAOKChRwTAhVh0Dt0GKIaOFrsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXwM6cXr4bcfcmtz3sf6jQxr1VBIH0fxPYpa08bf4yEMjzpGSFcp9EQ1ok4g?=
 =?us-ascii?Q?Qoj/YxL85/AY2OlJAbCxRQ2OVM0N0HrcqQLDW2iIOBhpOpIBW8kG+FQCUnrU?=
 =?us-ascii?Q?bnNmAXv9jVHnMr+p0qJCcY5Y6ARt7VLKck3rB6veLRnGMvxYnanH3j4R+ycD?=
 =?us-ascii?Q?1s4Y4gcpocHo7nV3BrQAp3dCem2UBMZhTK+Jsg+gG/bqVg2gNe/OZq/zYVWX?=
 =?us-ascii?Q?xpKBkHYElPj3pmClWdVgJKRhatG9awv2cOh2tnsdazIx3NQwOiOsN4o41B+Q?=
 =?us-ascii?Q?/EBglPTJl6U+BisaAIamsr3cX/Orj2YQsuizLLmQ7ro9Rr/cTcpwA0QpTGyB?=
 =?us-ascii?Q?C4+I9/kaTl3gJLVKMPSYRuZc2bngsONCWkHBYNz4aAtcafbgNeIrMeux7paO?=
 =?us-ascii?Q?gqC+BDA11yqMjHFdcJPXbzUc3FlEAQ8geCriHtzcUpJiJHG5jxsuvPqoV/TQ?=
 =?us-ascii?Q?bDLpISyd5N4lIyHPXC4xCxSzx9px/WDXh4E6mAPWuKZb0RkrIrTEKAyHo0Yh?=
 =?us-ascii?Q?Bx009QsMvgKn3vgKAuDrKO6Y29Drr5BYsb4UxnH5n89c0dwmB6Fq7UOz5EiD?=
 =?us-ascii?Q?C5m5CxOBNaTaKbZBKOASfWHuIkGZE+QbIewYQ0DFMVebhjUilihMQHxg89B4?=
 =?us-ascii?Q?OtU7TlKmXx8bR3ovN9xznzRLuiBTyFpMBBxWDzsNWf7m2L1TBOfGqKntdAhW?=
 =?us-ascii?Q?CU6vYBIBS43vZ69j0T7XdO9i9pYgY2fSPwkqqg+zxO2HunEjuT4eSyP1jwEq?=
 =?us-ascii?Q?/9168p8jqWNhAewfFDuHFjdh8fARo5d3sHf034Ggym5ZDrJDBfdPtY3kSRmW?=
 =?us-ascii?Q?mz6vx4vP8x7PQz1jeTFr+lKhfYxc3Q/7NNMiHFR9rh2KFEt1y/X/tkgIr3s/?=
 =?us-ascii?Q?crKtBgztYTHmi/woPipMK3rNepwEy3m4WIhm2KmFsHSLXxsORPVZZgc3nDYU?=
 =?us-ascii?Q?2Ejjev8Q18gYbK4E2dCnJ3cxLP4H/NVJKaij9oLc3eUDA/xkQS5cqe8b1OaW?=
 =?us-ascii?Q?gWVXxwNcG0E2WSij+CecKB0QBlKJ42JCFonvSFOsuawalvAcJG1jkfjHHyMG?=
 =?us-ascii?Q?dv4A9hJ8DknQch4s2kwhIv9FbQT6FPc71WDMIys6YegdRW48g1dE2Mfl3rgR?=
 =?us-ascii?Q?VrytLikpB2IcaDpjmX1j2Fa2TMb1JD0NbhMzaCdC+q6iaWpm9tzbEYLzAz+/?=
 =?us-ascii?Q?ZicsXFMwRChd1OrcIBc7J4ET3+rDhXiQi6AtQG9DeXa1eIEi3NawOFAkYsof?=
 =?us-ascii?Q?mcvp6fG//fP7G7hWxxEo7TZlDQDQw+Nz+v8kNjPX8yA7Bxnjq5O+XFFKuA3l?=
 =?us-ascii?Q?PPCO8QWNdpapY1qecIZswg7TPXKElF18v80bfOqY4w81kLcC2Dyk5hkKF6X5?=
 =?us-ascii?Q?Jhwdk6zKvuTOfBLWyNmapJl7bBcjlCHK4zJ+eJT/3galcO1ziU72lNiEM9LI?=
 =?us-ascii?Q?7OCb4scrv8qVchdIYSfOhrmEdm4PiePASXcnZz8En03MAzvJicQpnS9kW1oI?=
 =?us-ascii?Q?kn2AmPdXyhssgBUCsOR5lQehfZJU8WdDbgT7SSlNUIeK8+qBjHP73SNos5/D?=
 =?us-ascii?Q?O/BQ8xOhbBWiFYCEBpzZdX9jZp8QQgbcGROhMqRk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YhH1Mav0YXh32FzpIm7LnU5WMeIIE0pDJr/VQjNmPPP9Ep5O/M2HkZCXa+vCSmowhxgf5OsC3cj6gNmvGNr0YO2GBGMBWAOPEO1trTeRs155i6odnCXHEEaWrRWzL1srGddwRP1FgaBWeclaB+ek06fAaL67ET9Lp4OPz+L1uFWoFol144EXWwpISAtI82lYGPPAF7ZNxUaE/Y6UUcnjg2QXQFqIWQ242kKMp7h99hbUu7TEH5pZJ6PghEFlEkcWkK0yWX0BdN5Dti8ZV/A4XfEuC4sBICKNmLxfRBmK3M0TfgCwWgmCHpoZTmyiUMXzVb6v4YO5FmqSfdaNlu2LB0uEsBtXx87LFjDhJe5PocdhgTR0VgtTOll1Fnv6WU5xJFHcTGGb5TYJ077vsqU0A8ld5lywaEgEAVWJknBV9oZ6wyc6w8ZUn6hFJIfRHn4S5WrSTsNll3iOSrhxGZkyHAJyMUcm2kIHHAP3h1EIJIvY04kckpc35IadNm1fk/by6X9U2yg8Xpx+nYNqjwyjR/OEtWjmAzElm8Fc1jc792oWNwIHHFAImgHziz3oWrUpmErjioFHpiwCfRFnb0exiPawTaMiS0d4MFS5si2hRBs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762a61fe-97b0-4e24-239b-08dce89c4746
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:55:09.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8z9cqRWlT66Mi2WtS1hWxbZhzLEBXmXqYBiMNHlywewIwUdtQG4d91TMgZ7u8OESphYmWhSSKvdAFdWGk59DUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_18,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=687
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090124
X-Proofpoint-GUID: UDDJa8ZW3N7ahyXNrhpOyd9f_FHEulNh
X-Proofpoint-ORIG-GUID: UDDJa8ZW3N7ahyXNrhpOyd9f_FHEulNh

On Tue, Oct 08, 2024 at 05:47:55PM -0400, NeilBrown wrote:
> And NFSD_MAY_LOCK should be discarded, and nlm_fopen() should set
> NFSD_MAY_BYPASS_SEC.

366         /*                                                                      
367          * pseudoflavor restrictions are not enforced on NLM,                   

Wrt the mention of "NLM", nfsd4_lock() also sets NFSD_MAY_LOCK.

368          * which clients virtually always use auth_sys for,                     
369          * even while using RPCSEC_GSS for NFS.                                 
370          */                                                                     
371         if (access & NFSD_MAY_LOCK)                                             
372                 goto skip_pseudoflavor_check;                                   
373         if (access & NFSD_MAY_BYPASS_GSS)                                       
374                 may_bypass_gss = true;
375         /*                                                                      
376          * Clients may expect to be able to use auth_sys during mount,          
377          * even if they use gss for everything else; see section 2.3.2          
378          * of rfc 2623.                                                         
379          */                                                                     
380         if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT                                
381                         && exp->ex_path.dentry == dentry)                       
382                 may_bypass_gss = true;                                          
383                                                                                 
384         error = check_nfsd_access(exp, rqstp, may_bypass_gss);                  
385         if (error)                                                              
386                 goto out;                                                       
387                                                                                 
388 skip_pseudoflavor_check:                                                        
389         /* Finally, check access permissions. */                                
390         error = nfsd_permission(cred, exp, dentry, access);     

MAY_LOCK is checked in nfsd_permission() and __fh_verify().

But MAY_BYPASS_GSS is set in loads of places that use those two
functions. How can we be certain that the two flags are equivalent? 

Though I agree, simplifying this hot path would both help
performance scalability and reduce reader headaches. It might be a
little nicer to pass the NFSD_MAY flags directly to
check_nfsd_access(), for example.


-- 
Chuck Lever

