Return-Path: <linux-nfs+bounces-5862-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6281E96298D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 16:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEFF286360
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3E6381C2;
	Wed, 28 Aug 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h7w+KgrI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X6IRrP5B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC71DA53;
	Wed, 28 Aug 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853629; cv=fail; b=ht31TZUOH7qQaRNfxjiGRhYkl0du9fqsG9JkoQDOOTgKrE1rrum2OQgy4VixMtSCMVaS4MYl70DLdOKPjriWpfq6JOoT6tG0XciUYjY2jQH1vIOEFRyjkEIoIKDAK4J885U6EpZEpOc6untDaJIbTIxj8QpMjp+oLHAEJzT8FF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853629; c=relaxed/simple;
	bh=E8U++ZVAPSkJdFxhaXL8hdxmRRPdF406rrZePQXA5YU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=a91LBPA7tsaF/3eIhDYqf1kk1r2AVNAfhNbB1i1pBUUzi8KIudOoORZ9r027YS3K5DXBXMrLUgT/aXfV4+itPYuDQcw80Jm1+3LKWiMUWZ/jPNdiKv5lVivwEk5XDN3x5JNSR0uw+iOVhYZo3l9pLKkQQVApnlXN362D3zXGTKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h7w+KgrI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X6IRrP5B; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SCMXYm020752;
	Wed, 28 Aug 2024 14:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=2uZgmlBZ0DMouZszhiTG/zh4KPas8c2IDhkqu4PADxU=; b=
	h7w+KgrIvESH8KLMXJGQqGnm0kkxTOiOVo106ElDjHZCWkzAO1Fm58OQiRomYVBz
	5XTA45yFWeDlCpCaoI4ov7EVp4OyxOdPVEoQzHPNRc0Z2bSh2TxcDB+QEjA5FLSR
	IvGZ14VIezWvlnUurLx1ythUOiEBMQlq969mCsQKbBx/nVVmWIEy9eVGtvKLR8Pz
	wUl2AX2MDlbrVISrr0mrxDC0saMiZVlJg9RXS2Zb0sfcryRERmUZucb6ZZR0nua4
	35ccff3fGyqe2f3zrWdNQhIBv6553UuLxxapmBR8aJoNiU2nIkKlKrNl/GzExkNw
	flK/Iv72DidoM0j0AJjUjg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pukscgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 14:00:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SDHK5F031852;
	Wed, 28 Aug 2024 14:00:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0vbj35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 14:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO1SrUN4wYs5feHZ0zsZsoVySQiyvRGQkZmnNxrkN4c2t1JDp4KqnDqG9oVjtxZQgXqiU8o0qWCper4wbICHNR2Eacr1OkMCIt53Kn+cF9Bpu3kwSQMynLJOHgPnuCf6DRVT7UfXliv+7/kkGIXkJ0W3A0tTIokkDHdKW/LcdTqEAZKFu0W8mfdSeqrOr13y25tpXsMpLoHpgbbhgEJOs0ct/5RiBqrYf4SaTMgUC/io/KjvJ8wQMF3bT36IsVfN+SFljccMQphAa33TxmK6e97q3IwnLU7H0yQ5Lk0SWPcT65BDRWu49q7ec7TYpwa6TQDgmZqSmYgMNA4DkIFxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uZgmlBZ0DMouZszhiTG/zh4KPas8c2IDhkqu4PADxU=;
 b=purtMsopBSGa4cV0wxW3Tjpt0/xm4G3REg1qYgcQFVWapXFzKVAVVY4SbbLPT/FLeDowecKpGPJQDceQjtVL+d5x3Z/98bQCbDsFVbRbHfdHxzkAelhgCayTkLx0Buzr3i9Ll3pzY1XuKSDMWDIW2E+ohVo3MF0YrGgGIo0IPNq9WEiaYFYUiwbNxbriY03qcFRMqKMmsBVXjkIJUuasZMdkheNdjN9sbjH41YaAFCzKvQbGsVxL5+GQvPvBKnXGl46tN2EJBTPIYST3kpOvPcA2boP7BmIhf959+sP2URpch7mg8c7ftkdckS7cAunUg3bAgUCMXYzcTNRStQn4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uZgmlBZ0DMouZszhiTG/zh4KPas8c2IDhkqu4PADxU=;
 b=X6IRrP5B5nvv1UOFNmTuZW/n17j7RnkVfw5fofXFftnNI2FKkfzrYsSMTyna/hR6bccIuQ4r3G0AILpGGSqMbtikfKBAzl5gqHTeNIUqYmbR4URsCOJTXIXmZgVa6rJFzpcD5HjoZFyWQMsOJepb4T6+LBBx9GPia9t4N7df0sA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6179.namprd10.prod.outlook.com (2603:10b6:510:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 14:00:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Wed, 28 Aug 2024
 14:00:14 +0000
Date: Wed, 28 Aug 2024 10:00:11 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] More NFSD fixes for v6.11-rc
Message-ID: <Zs8ta1ytpxZFAu6m@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH5P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: dc75883b-b331-4c84-6056-08dcc769bd6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EFvkO8ps/pukDRdXtY/553NWRZOde3utkeQIj1ZxLaqZKozxWKOsxf/+oYst?=
 =?us-ascii?Q?CIg+NA2o4N36zN8WzpQTgb49g9hebcfzjCmWnyGTLUniB+MDAA9PFSnfTAe7?=
 =?us-ascii?Q?h6p6KxZzEeCdyJ5uF2IVpLYrUYHnoPRwgdWlLOlD55rAjNlDCMHPXfXeW6TP?=
 =?us-ascii?Q?hU4pjOMxDe6Mz3eMXwYAfEyplMlbOAFPaSbO+51/szBSdJwtciu6Auw9f68H?=
 =?us-ascii?Q?MCpSOWJYQc46QtrrqueaErifoEUtnFpt1lPP7eQNh9w3pGOUajRMXYlEOU36?=
 =?us-ascii?Q?9sH2lQpABo77r/pkxJgn1epD43yNidkZkNHq5R5chkPtimi7QPEzxHzTg8/L?=
 =?us-ascii?Q?AaUWbIVJgnb97B5hkGEmx8piS85X5kytoLmu5bUZAJc1Q+iIvAi2kttxSXie?=
 =?us-ascii?Q?QGtJJNG5+764Fhlwu9t/gGj1d49u/pMcCUuxXdBZuNsmLgOkz2U6UBdMWmql?=
 =?us-ascii?Q?MpkbfkwRQt14yShr5KfVIxXLGX9csS5wfgPpYrmbwTX8iEzEN4DKsmf15J36?=
 =?us-ascii?Q?9Ombt2CA70mSC2Ae9V7RhqcDv47s2rbQc8TTcos/hGVK1dt2qctpv4KBGOCc?=
 =?us-ascii?Q?Rev+bAdeqHoeOzbwdvAO3jHT92FIMNkDSO0FGmcTFfrCxGj0x3CuGePxdlKI?=
 =?us-ascii?Q?WUjq1sitFL/hup9U8aw1G99sLj91P/6ZeLSTu7lrlRGxk15h2UfdkUysnWeK?=
 =?us-ascii?Q?prYyCU/iYvG45bG3K1iSXUtFfQ6xwYKwcKBOycZEVMVP2SeDnuMJzKusE8Y7?=
 =?us-ascii?Q?zTX4w/RuD5RCpe/hUzv94x/Rzxlwvkt3UrcDl2khnk1FhjkFLM9/bS4KozxG?=
 =?us-ascii?Q?YL28NSCopP4HpliI5oWBADWJIbnk06lubaFC3VlvLtFV3oeyrhI/d/A+0vDx?=
 =?us-ascii?Q?MPrpfE3d7wmnxi2sIcPU7BhlWio0BfUW4po9uhglAoljcixIszl0odKgKeez?=
 =?us-ascii?Q?2mK+lFx5ICwKYVT7QMVvooXFvFItbLi4VDDNN4CbPfNa4BuPWSO+EkpYx9sk?=
 =?us-ascii?Q?Y6KnlGF6X3WpNTB+mk/AygNaF9+KOU9VHycp3aNwfgbN4JIJTKzZCt5x5983?=
 =?us-ascii?Q?OpEXEHmuFacHuCh+ilDYa7rOo/QRJc490SeY50jBWVig5i2n9CwFNxCNh53d?=
 =?us-ascii?Q?XaCkTINddrRDuYriRF6Eusc+4yAciZlYaoJeNOtCUHnrQcWxi7Pz2i6LkVYl?=
 =?us-ascii?Q?PDv/9pMFzrVqnKuahQNUlUIldpi497b93XxEtL/O3uUNnHetxC4I6Mfu5ur1?=
 =?us-ascii?Q?TTSqieK2eXoddB0vU5is+u5mQaOm7iz6ga9okMw6esO4jEV4JM06R2nsB2rt?=
 =?us-ascii?Q?d8Aw1mfh2sB36TOMQIzr6uycek0HnoaPY25lnJTp8hlN2DBhDmZjdmNV/rZU?=
 =?us-ascii?Q?TfQa2CY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MeEG3ilLOjsNiOn7pPKL39l6E1bjHAFs5yElSondHHpcznEZmzd3FhLkc4FQ?=
 =?us-ascii?Q?fgetOlMsinFRi+h94yDirLFwHngAmP7SxRmxf/S2n5Kt53kF2XLFuD2i3o8R?=
 =?us-ascii?Q?mpziq6zGfdLX/RfEkRvzvO9XxjrIPCk2bOp3Msh7s/GUDlGWRem4Tkxypuy/?=
 =?us-ascii?Q?QMopVYBGCOLQZUtMA6TLaPiv0VLneBKXlj8LxunfsQ2NMf0Yuw5Zsxvp3kmU?=
 =?us-ascii?Q?Icn3IohkIKkoEJSDkBc+XHmuDhmWHEywGdjr/xr8eRenLgqEIEg85jLZg7xU?=
 =?us-ascii?Q?hVc/uasPFAmgSazf74PR481F3BRyVI2TyGI1GsG+JsOyvZNpKApKGYQ7tLiR?=
 =?us-ascii?Q?OFCW46h8jJ9btWfg/teoDNHLRQLBTlfwsAC9Oi7sEfyL3ztr+8NghuIxmkra?=
 =?us-ascii?Q?6dev46WMZfiUB3J709UGlII1DiDQuFxuIVity5VkB9X6K+fKQzDySPq44UGk?=
 =?us-ascii?Q?DgS87DfAXMUDNRghKadvWdm0aeyC+ZNmaGzeX/r8K7hNMqFc3O/dHsmdg/sJ?=
 =?us-ascii?Q?AkflTSTfO/Wgd3e8wOgncNqHafcvtjlUElfFFKLR5Pqvhr2fRUug4Zzq+M+g?=
 =?us-ascii?Q?kQZzIN3f+LdkFtv+pdBU4lXFL+AZbHJ8F74OEU/sC2AdtznqNASjjOCQWDSi?=
 =?us-ascii?Q?pS5uubEulsO1KCsdSrayArJlDk70JtVEZiG3b7WXfDjmZrc3XKQQZvyFOkEb?=
 =?us-ascii?Q?Sr3LHABOGWbi3Ze8XLhtxGuOhc8SrRHirqQJVqVv/JFMP5iHaYanvGoQiwyl?=
 =?us-ascii?Q?JLEa/XErpuYKX7TfoRbjAxeQu7/vzY8tnnPF5Ceb9/Fim66OaIgI5ZFNqCIy?=
 =?us-ascii?Q?SoRiYpSzklOl1aYhVawxAFgP8+eEj9Rb7A9sD/LJzF16YCfNhnXUsIryPkQ+?=
 =?us-ascii?Q?ETTPrw74M18gmkRfDkssXzqtg8z1iLReXEYXi2/d6krLKVgFAqZH4Gvd1WGH?=
 =?us-ascii?Q?7snvsPg7rFEtaYXLvMvqelQLYbZ0QDrVxp10h9ucvD+RwdUPCx7dnGDpnaZl?=
 =?us-ascii?Q?HRw/KHcsOcom+B9VuelHNlqVGDWKWCP4BWr0Gz4HD3XHRaEhWRoVAOSYTWW5?=
 =?us-ascii?Q?rtdtndPk2UuruWZwRbNj+pr5aXn4lW0vbegC/C9My5eIqY5FJ4pZuf2HiK5L?=
 =?us-ascii?Q?KCC0/Zagn4NDSjNZCCPozX5Bb9OEnya7WdLo3CXA1MDJWBDllMYxTQQf8Hvj?=
 =?us-ascii?Q?gr18yrnQ0IF320WdzZ+glTaxx9E5ios+ZzgR7SE9JIFtdGyApGeeX3lUytgT?=
 =?us-ascii?Q?jGiBk9Y7I589iiLdB91EAfrKnK0anz54bzvcFkpvXW76Mao8/eNrRop5fRgq?=
 =?us-ascii?Q?OUdoL7DpYomBQnk4ticBwyh8pg0QM86YWkpoVGnRoe4gA+9MCAVq+kub4Vfh?=
 =?us-ascii?Q?SiJGz6BirL1AF7Ey+gpHVOqLniQKskEszomp4G8X6PVfa0MsJdm3zBOa5szo?=
 =?us-ascii?Q?e4CiBaySq9FKLr1jSg7HSLqzEkmaSJSl6zUVmxc+/BDyNsFPfwxOLEaQ41g+?=
 =?us-ascii?Q?Ig3PzQVcE/dhUxrvkMNy9ngOg1ATJUccqQcY3LzLMidqu2LBYy+ac00vpY3Y?=
 =?us-ascii?Q?u1VNBUjw8JNtq9rzbezGjxywQwr4ThBMTYi4HcQo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F0DMxduoJjGB4Oi6ZQXPGP0fMe6nVytvm2688MYwBfv+8tO7bUigNvCegmcmyIXeUx889Zy5J6Nl/HJ95QV3IjWQBAr1jLNlcNtoMNsZcJfxI9n9dmg4eW+cLIx0rRA6uRsXxvcaxU/yoid7XsSxRf16HTSySRfE+a0y6DaclI1ImBLfUoQndTnqpcHFdHKwtWbyOOuY4Ab0z25iSr0YRGn2dyQh0yLGiq9ZHRFmWEkTyE0mmCi4ZI+eSiJfZwzrezS5+Xk/IGrrOQ5pPPj/VHWq+GA3zhmz4o0X89baJ/1+LCn8cBeIc2/dnHtdWEFZC13U2IJLWZiBi8lb5Gy29xBlHj+Sm64e4tJNa0G1HhhVaK6kYktR9Yn6KdHgwxLxjGSJiAJnH6BetFD5DO36MiiAVcauy/RcUpmI2Tndb+kOzUn3U5SAyrnklhO5Nn05KKxYhxDBtiBMPkgHY0YIzXZH4r3hadWGf+SbLewsbrhEWPNWlC9X6jGiLgkxFOeWXMHgC1eemB2f0vO95fWmwvDak2lJo9AvS3m+7zr7JqqErYNQDJSzvX+WJsl1T14kUFt8LuWx0dZvC5gGo+NwNFumdSO28koYWVKNT034bho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc75883b-b331-4c84-6056-08dcc769bd6f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 14:00:14.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iz87pF9kDDf6fiqHKqQecqVNA7gKyn0gmZkW2xEmkPIEJrY223QD+Kdqul6NTiqZaRqWqoxiXY1OR9vt1ohxvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_05,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=809 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280100
X-Proofpoint-ORIG-GUID: FXqCmW--U6rKURSEI-4pqRbfOjK9KQWy
X-Proofpoint-GUID: FXqCmW--U6rKURSEI-4pqRbfOjK9KQWy

The following changes since commit 91da337e5d506f2c065d20529d105ca40090e320:

  nfsd: don't set SVC_SOCK_ANONYMOUS when creating nfsd sockets (2024-07-22 09:47:39 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.11-2

for you to fetch changes up to 7e8ae8486e4471513e2111aba6ac29f2357bed2a:

  fs/nfsd: fix update of inode attrs in CB_GETATTR (2024-08-26 19:04:00 -0400)

----------------------------------------------------------------
nfsd-6.11 fixes:
- Fix a number of crashers
- Update email address for an NFSD reviewer

----------------------------------------------------------------
Chuck Lever (1):
      MAINTAINERS: Update Olga Kornievskaia's email address

Jeff Layton (4):
      nfsd: ensure that nfsd4_fattr_args.context is zeroed out
      nfsd: hold reference to delegation when updating it for cb_getattr
      nfsd: fix potential UAF in nfsd4_cb_getattr_release
      fs/nfsd: fix update of inode attrs in CB_GETATTR

Olga Kornievskaia (1):
      nfsd: prevent panic for nfsv4.0 closed files in nfs4_show_open

 MAINTAINERS         |  2 +-
 fs/attr.c           | 14 +++++++++++---
 fs/nfsd/nfs4state.c | 51 +++++++++++++++++++++++++++++++++------------------
 fs/nfsd/nfs4xdr.c   |  6 ++++--
 fs/nfsd/state.h     |  2 +-
 include/linux/fs.h  |  1 +
 6 files changed, 51 insertions(+), 25 deletions(-)

-- 
Chuck Lever

