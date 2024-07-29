Return-Path: <linux-nfs+bounces-5151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC2993F9D6
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 17:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD857B220AC
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34113156661;
	Mon, 29 Jul 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DLJnGA4X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ndVpNiUh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E863155CAF
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268174; cv=fail; b=uMRDBXJG9DWcplU6bJ6MbT9mm3MgBJMxjluZ6c5IQcUHgaz7ERvFDHPAvEsZZoFAZ/T/rRnOZe4ftnAwj90LSLIPtX4Vnj0BYutRh4VLuNXJpqkCiE7iJvHdS1fJpVAoZ7UXHiJTuFpeOu2QuXsjzRWNiGammhso/IDDKUTDXN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268174; c=relaxed/simple;
	bh=8SYftYGdMqBZ1LVzKeH4hjKTJFeIBDWl7IVWo4ny5NU=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=ktkVWeMAblpzILjyqlsgp0vF2Uaiqy3V7MnJVfMFoMbgQp2NZyNIOxEhS52DTHBEDZbze2kKvv5F4Q34YIyLCnZdGqNUOklI0YoufV15mk1V+zOfsYJjfm6JmIUswRjC0DefpRDHwHUKsCx8s8VrEw3V+KcX2gDvpXEsmIdyAss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DLJnGA4X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ndVpNiUh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TFMm9W020420
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 15:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=jtlVjT1LdTYU06T/iFj2lX1UDyuQf9zfb9FzxjB6O38=; b=
	DLJnGA4X4B0M3hNMkwhI6NRZDMRjdqqetBjC8a54Agfb6/QbfVnvzcjXwDsX6JXi
	dgdRGT51kpJqkji3cAul5zPxuqP9y0F6jcC+xanLWHT62ciWx9/hWXW5PttmchYK
	y6mIgeA1TFGGyCZlj1peo/i3T9a3d9AMukELrCEJf1WDvMENLWTdnUsHdp6/rX5h
	4nZYeWW1+rWQrBLFg5YSlQsWJr3VjFVjwaleCrB046EZ+1lq1BdooeUAY7holyqM
	C7l8UBR0UWvDlGBENJNgmUv7O7lehXCRk0imju+pf3vxP/ka8FyuK50FXZOhNp9A
	FgWRG4sH+AcB92WYd72pXQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfyb0a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 15:49:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TEKSRL010104
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 15:49:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nrn60jsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 15:49:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeexmhB18fk0W0p8kIjyg60ShQ+Dz9UumADRcUXRLNMcGuvoD+33y37ujpJHBkQLaX6FwkamViYhSrAQyurR7692XA5o0rxcN+gEB3fABcnJlwYlffgPbCdejgvasKtld7AdRGbou/cvRnM3G0cElScFmNNef90mFGHC4mbGV0AnQkh8gNwQCRYOocfIWif4kjHhDzj34cw+oQqCTdqHi9opyiEoOxMYmzqhGBf7r31dEx47NqLyhIVyNktkhtJCW7aFsmipXctkyWYXZ8BeiKtSxzopaAFaPIHKUzSVEp5q56pEhzyDw2SH7mB05zO/hAZMUkG0VyMZk7DDae7Bkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtlVjT1LdTYU06T/iFj2lX1UDyuQf9zfb9FzxjB6O38=;
 b=tG5XUHCaS7gBq+tDtkxiJa8bm8O6gWyq8zC0YLrb933cKcBwcPUundVyYvOjp9HwZsicyq5lgLIhiVqQ8L64frN94R6LMO/+4pJPUocpxtQVHwD5PoKsYTLQJ4fC3dX3LdxKLwf7i4TmAsz2iFibxFEgfsAZ4M61qG1ce7tPqjim+HXton0UiFCk4nMJnr/f9ps6YrKhHWRtH5yb1LfyeKm9jytiscAkAmQHp10dY4qdHVtLH+qF7TCXTJ6135rMwlCsPPfixjY8IEfGXxok1jAflKUWh0nBUdILl7QKTAlHdd+EX4ZAYk7AqWAC5CCemIW88iug4BSDysRAG/rd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtlVjT1LdTYU06T/iFj2lX1UDyuQf9zfb9FzxjB6O38=;
 b=ndVpNiUh9huJgg9S+8jwSraHj7zin0rbnSp8CcrUGBdCptHNL66elzjNw0N8I+ANbjbqZwPB70fXdaaWJ6vmqe5YeHzPVpWfvOKJYhXFDuSqzg9Dp2cXt8jBigvSC5J7yL0FyqwPwQxusG5eDY4efngzjCAKPy+gVOUXufivh+U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6616.namprd10.prod.outlook.com (2603:10b6:806:2b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Mon, 29 Jul
 2024 15:49:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 15:49:27 +0000
Date: Mon, 29 Jul 2024 11:49:24 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <Zqe6BMbBtQWd45IV@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:610:60::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e06e0bb-4afe-4db1-7da6-08dcafe60709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GiDp8/qC/io+vIymqymTacvHKpEarkhgfEBxBkMHtFH2umMfk52o1wrql3EU?=
 =?us-ascii?Q?zP5+YvVBRpikIAFx/Av/HnzmNn+gHZdFT5mJuH3O8rnXLI0pY1ESmDbkNAhF?=
 =?us-ascii?Q?pHEGY2d3uB2QwLXqk0a3SOgUPZnWg2FCKZvUAaMhCZ4a8aEqBMFrb3bCE6Ac?=
 =?us-ascii?Q?US36q6FTatthjNymGkKdfCdEsp/48E1HbGpAevu73Dtp9cuwEp8O60DC978J?=
 =?us-ascii?Q?C1vxOjsNzR9XHsNgDdjXWo2LKvSd3PnOwSHj9n3xhDBED/PmhclXP+f8VJIX?=
 =?us-ascii?Q?ia0yBmvAAZ4VjtaKPk4Zu5tTYPiwTzGQ7u8IhMVNxc+2fWuHfq3lwB/Zy7dL?=
 =?us-ascii?Q?UlsTEixdCdWx+WLEgURuY1zlw8OJrpJTge1hPvRABA0lVPGeRC20/laNrX/N?=
 =?us-ascii?Q?ZwFM7UQRo1MV2MEIModPZd+UIVL7+yqC0+nxMILgRebDdTxQwUUz0Xd03LPm?=
 =?us-ascii?Q?VD+AZAFg7KO3oC627uaBKkwu8nZUFz54CtrZuVoMBlGAUL/mU4wo6XsGbIQY?=
 =?us-ascii?Q?U6gp8m0RrZrLu0foFdXmf9tAPzI31BmkjJYd9vFOAaLksQtJTeUb1iCcDRDt?=
 =?us-ascii?Q?M3HyzMyH3Xf3G789P9Lta6Gepd5FhlZTONScTS2kcwye92ihUdbLUDp2jlia?=
 =?us-ascii?Q?DjyZ7ofkbND4vNhXObtIjYGeF6LdpN8eBpQjR9WTvLRbSm5LqXr1wb6UriTG?=
 =?us-ascii?Q?EvlTrhX60eimMXLyUnPjM3hIX784uC6XUqbJh5Eo5UcSf1KgVtg+Z2HdT909?=
 =?us-ascii?Q?o43GdUyizzzVPYQc/Oz877ZdNBThuwExDJ+Hutw6dIo6Yara7UVKfgdhmxB0?=
 =?us-ascii?Q?SMyaEnja1CSd+9QyMoeQ9BOz1i71p8Xf2uTWFpYPMoVgwKEPIBFi5UeMbQdD?=
 =?us-ascii?Q?CwFBUSym2VHtKSjLeBJ54KF4wjkke9VdhaAkmhOOth8jEFTcfbbW3vvVidbX?=
 =?us-ascii?Q?v+cEqODfufLbQzMNoMNC+65NuDFFSlY7+jheS+Ya4FHJmfErYfs6B0LTUX8p?=
 =?us-ascii?Q?Tg3bc3skhNcTrLQ6Rohe23C5lhBklzmenfmDy7yCy3jpRZw9HL/cpXasMNKi?=
 =?us-ascii?Q?qOPEXvUnAgcFr2VHp+2QmLhTl2Nv1GyD7ufCGjMjJFBvKTA8GWs2RoGlqjKp?=
 =?us-ascii?Q?Phb228DiyCsJkxa3ljIykqoAGaZm9YJ0fAtZSJoYMY5U8MN6i84AsmrigMgs?=
 =?us-ascii?Q?LM4gFvg4MQXvxJvHsB/Hda9Xi8zysyo7cS971jIAUvjtNz4Y5qNH3MGlwCTr?=
 =?us-ascii?Q?1YdqwAzLfZKDSHxUXbiqdIQ+ccswivjDZw3c8li0eMqHeUcrbiEWf+tN2d8A?=
 =?us-ascii?Q?E20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RYfmZutYUw0/yZDMeQbvf9Bz/2kASbzsBXz7yOTydqYV1HMZt4z6Eg9JpPHv?=
 =?us-ascii?Q?8XuYa/q0wzeazFXto5Ykhgc53jazLrmDIFSwi8k3OJrzhWMCbFPBfAAAsjsd?=
 =?us-ascii?Q?qP9tq42CQudHJ44BzgupoEUUWDAelnba1IzvmQpgwmji/z/EcZbkUS5gWLnq?=
 =?us-ascii?Q?9eq4xcA/puTGA8kjU11dqGUajJd1UVBglnvCcRXio5TSZunGnJQfSHhDo5CS?=
 =?us-ascii?Q?/ogp/rx0Dq31jxqCvQGoldJYPZht4XDgAfFdhGRerF3WFyOW95BcLxKFr+TE?=
 =?us-ascii?Q?HGg4nkxRP7noWbS2JpT5hSnEEj62ZPJ05Po99QAo/PkEmfa+Ay4eoqfNneSU?=
 =?us-ascii?Q?1zZQCUT7F/Xb75R0cBHjDEDNP8c99x5j+lWQbjwwrD1+QO93g15tmWkEMsoe?=
 =?us-ascii?Q?N0TRqyQwml0cD6u28ftRQWlu6BzqziLXdPznHqD9nEcNSPfKY42ZqjnYKw5y?=
 =?us-ascii?Q?Lefj8DStzpOrHhVG0ZiWsAK7FIyZDnNVJWvk/WA4JJ8o3jJZSHIWQi2bwHmZ?=
 =?us-ascii?Q?x3SsMsV7aQR/TQBsANHdqIcDONBZadCXz+iMZlFRUuhBWKImKjcm+q6Iux6N?=
 =?us-ascii?Q?GsUFAWQkIznHPOiw5Qcsoonu/yN0fc/wJ/nwmE6AwNAsCfns1w+cJQM3kJpp?=
 =?us-ascii?Q?iES3Aw/RK44CCFjVkYUX2j1aPu0gSr+S+f2SVHNmxO4gGaexaEXsMR1qyOX7?=
 =?us-ascii?Q?syJ0PWf3F1Bi8ixowXH5EUFJiZ3OvJ1Q7bZYcOjukoKnxVj472fkEj4U+0rj?=
 =?us-ascii?Q?HyFCtOxRcjtfEosDBlUANDee2IK3tx2x6Oev0TRuE/5I6WkGVztkiB/zOv2d?=
 =?us-ascii?Q?jr5xdSzwX6hfOziIqXOd2tHeqfQiqZPL+UzihACNsmFZ/kUSOOdWnT/UOMf+?=
 =?us-ascii?Q?al7MK+53QLXtc4j+FvO2lZ7xWNupdZ5v0gpuguFHerZhsYmpdyEptr/HzKwJ?=
 =?us-ascii?Q?+g1iRKP2At7F34Wm0AHjF4hb2ZquuuGiAnox0NU/WvebrIdMDWfGzqvURfK+?=
 =?us-ascii?Q?1x9uP9m6zHIQT+DHMSNvt8Jm5FJd3+KPc0jHIpqP5ptfh+566YYRNz+X0Eta?=
 =?us-ascii?Q?bPETkJqpqClrIr+NwSGkiuyFujNabjLbPkzLk3j6mypR1gqpXA3c9l23t8su?=
 =?us-ascii?Q?J2q2VthYXP7sTKhiNrKbm6O8Bfud9UR/vpSBqO7HreKDPPSrWhaiUx366p3a?=
 =?us-ascii?Q?L8IGufp4/YH9X+ciuY2EPxCb408lg3yC1Lg/pB8+HoIr12cuiL4P1hc4NBjf?=
 =?us-ascii?Q?gpW+OHhA/CuiAHTdT2j9PsuR6pfe2E7Kgu7V3fDpzHoH+Zq4oQY/9SDXLZD3?=
 =?us-ascii?Q?rShlXZPWDWPSStLT6O+Lj84XIMYgbDEqyIVmBh5+OeypyGQ/TuNSckw50JO1?=
 =?us-ascii?Q?mqSbkhw+Mqo5TouiWBR1Goenvduo5yGJ5KOpBC1EdiCmXqXy3FXPh82FusDe?=
 =?us-ascii?Q?GFuuRem8+tifArrgcO3VjZT4H+6gaMbpGzATzWuL+ObKnUen7cOd/YK8GKBF?=
 =?us-ascii?Q?ud1IFE2s6+JHHxyvdGUhN+zMlOQ5+DUx7zYD1c66M2L1C68mz0MJENMmcYfU?=
 =?us-ascii?Q?QWym/M37FuyqJWO3qrWr/6QJUGClEjCWMq5FHorFHYWvEX6bGqhVVwmyVJcj?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hEtXqzsgjHWTtAxqJT2FLlVxgIUbIMNOQ1aPolfZ11yiei250bKOVGPzfriCdcxWurUnQJ9XzXoWflMTeqyo6+xa7S1GXtXKLqi4H6fuOD9nTDTQDBty0wbEHgmXIJvW5siSmSlUHtGgxtYXbkPL0HlWjKWHqqzWgGftExUWp215kfhcM4IlxDTTGUbUyS6FLCKT2juI6NOvMYJQuNLRoXk/gKsI7C1D+18rYOZ+3s8TE1qZ9U1vY7Wd5tpdwfU/Z+7YhPGEaMe5jAC4G4mpFWfq1d+/aQyrS4dBaRkfG+kCnKJcF2zSCBJ15TMmIUtPOqieiScVecEl06HfHefmMPK3XfR25VFPKpqoqUlmyJIpKYBUvxARlQbRrIa2amMqZG/90X9i730MWY5gkysSGYK8130Tajnlh4C21FUocPbmrzs/i4jAG6POjAEhPYMqymb/5VL0USjKq3BXJI2eJuTulsi2kYXNMapYWkdlJ2x/3rgOILj9+RY6y+JWdkxy7z6v3qXZZBqvWzp6uwh2YlPt1CHWRq8ghvi20vBritlgqh/1V6MMvQhOwRqnlgjxAMTFvfmqJNEg48dkIX7WYBO8+P8GeVFReEfv9O7MBp4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e06e0bb-4afe-4db1-7da6-08dcafe60709
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 15:49:27.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJWfi4yPgJ2SbfNHyLrMvfb/lHKBurY+d/xHV/N+C6IT/Cq+TuPYGF0ttkFv4FwnAJOvpvKweAGMtNG0rU+npw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_14,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290106
X-Proofpoint-GUID: LlOQn8j73C2hOmFDdQeCjZ9f6GlCGSF8
X-Proofpoint-ORIG-GUID: LlOQn8j73C2hOmFDdQeCjZ9f6GlCGSF8

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. These backports are destined for the official
LTS kernel branches so that distributions can easily integrate them
into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


Out-of-kernel follow-up work

Amir Goldstein made these review requests:

- Adjust the LTP test fanotify09 to update the comment with the
appropriate 5.15.y version
- Update fanotify_init(2) "FAN_REPORT_TARGET_FID (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_MARK_EVICTABLE (since Linux 5.19)"
- Update fanotify_mark(2) "FAN_RENAME (since Linux 5.17)"
- Update fanotify_mark(2) "FAN_FS_ERROR (since Linux 5.16 and 5.15.???)"

The man page updates have been committed to the upstream man page
git repository.

The final remaining work item is updating ltp's fanotify09.

This is the final status update for the file cache backports.


-- 
Chuck Lever

