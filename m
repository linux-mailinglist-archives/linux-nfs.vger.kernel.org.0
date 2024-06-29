Return-Path: <linux-nfs+bounces-4405-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6809891CDFF
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 17:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DE9283050
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 15:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DE13D994;
	Sat, 29 Jun 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e2m4uIUj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ci5iiLOJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F621364
	for <linux-nfs@vger.kernel.org>; Sat, 29 Jun 2024 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719676257; cv=fail; b=h3+ynbJmC3e8ZUBNS1LK9n6I63tvSoqPseoLf94UDFtH2Yjt9hZbzoKT+diRl6q78+R6rwp6R//IbJHMZtLuLvNQu8npakZxzU1NG/fKCl5VxfSUJpNT2RvnLJiLaYuHBl+fKQbFwTN1BrXjlJbW+j7cD4VuunI5fQvwGKTOdZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719676257; c=relaxed/simple;
	bh=6HTaP4di1PoxaHwVVeCwfkMXhl8TfBu2g16HZTg0xdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tgjSf3Z3SfvUpMTu9zQwQHf1X9QyH3tx7psUixFYWG4zHojzaRFsS5uFZYkipWfLiBQrvd9OWiGyEaxGIdUE2Gqr1n9Jmcou5hevOwh4Qft2CmnU+fhLitWVhMe+tZbswaUqR5MzhObzsGjEShIq0iSjq+th1SHgTQCIMOSLKbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e2m4uIUj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ci5iiLOJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45TDShjv008043;
	Sat, 29 Jun 2024 15:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=MwgfApyR4/3xpYp
	2Z0UUqK+x3CHS84PxYD1AhVQyJOk=; b=e2m4uIUjA2u2b6bz7Zk9iKaZQw+RILG
	KtRyIFAOFI+t/zPsWQnT7hdbN/+Mz4BWHyO/4LS50MUhx6aWNbnoSTtYDGdhZLw3
	KT6wRs/GSsKpo6C0EDcf5TfNlr1oYsrRn5WvCAMWPkGb+7oJ4splk61WD6uLgVap
	pa1xtgq74ZYkUhetFbUffZEd8ns7zefPCIgWQu74x0C9dDWElu2Pe6x0thFmu3Fg
	xnu3QnY/0JhvrHIppfDbOHYRX5hMbxgfSORJ041KjM/WtQkZYsEf1Xrd9+zziHH1
	xrm8zTuCgJSrcfVfngSt/hx0j+XWtlhWdIbCmEeJoXHfgMa7WzjueJA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a590eve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 15:50:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45TAeFWk017080;
	Sat, 29 Jun 2024 15:50:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbbxf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Jun 2024 15:50:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5LgMdwzqcVwkcs0oaupYB38vsHvKxK4EAxFHCyXsgbK19LYAxJpWcvXbZ7AuzBjDzEebmKReFZ/iFI/PghupjD+oaTmOFFXWAAIdIdmGkm4LqJxfOLY9ceZN1C+dyn1INYb/hnU3SMbTc3aZi0QglPv22Tis1IApLmNEZdCZ0s8sRf1fL0wbk9O6WA+etkKH7Es8uEReiWgMX1tEKx7aOD+4q61KT30okCWRKMFmgUmuX1Gs8ATyv9zrPxgAu2y3qX8uYHSQXYTZXoXdbGRQqIkOc4ZNEA/0+vYriJpNhoZ5WDQz6+3ie5ovwPzQCVr5WNKZJ/9hCk9adu/H5+u1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwgfApyR4/3xpYp2Z0UUqK+x3CHS84PxYD1AhVQyJOk=;
 b=UxSU1c3IvuFNmn0L0ePpKUPedt63A1CtMEgPnn/rWZypkYUhVJ8k88ECm4rgHyHB6wJqiAbVQ1ojVgTHSRFysTPX49h1PKq0NIrV2y1zInYMeO82UHCEvyVaMELlnJdEE9REHu77ViRo90GzTlhXREnII/mJr2CSfIZ2DSldzRbiaO8EHFcBZxzTjpoeuxHo4c+9dVu0m65SNrn9OSpSmracrR/c39nRvBe+byL5v6W0+4DN9RBZWVFozfk2eTa1Sm/4Sko4wqVomLeinZa7Gpov3PXAAjHxYuGcPME4oKEoJ1Adzrn/3meC/l94X2PkguiZA0ZkRgqt2hTNuDV+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwgfApyR4/3xpYp2Z0UUqK+x3CHS84PxYD1AhVQyJOk=;
 b=ci5iiLOJ8oggOyhvlUvxuJvGMBl34c6xNE8Xr3LLJE0j2kaPmF41VYcM5BhYbwNmXCNJZWK7FXOLNmhIkbjhbRpdQj6NKO/LMGRxFW8NxuM96ZKiE7wkaDkUhLeWFAC82Rccp5pIitSkEfCNWq8/dweoNKLTKv+cdRC+2VDAMJo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6996.namprd10.prod.outlook.com (2603:10b6:8:152::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sat, 29 Jun
 2024 15:50:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 15:50:42 +0000
Date: Sat, 29 Jun 2024 11:50:39 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        snitzer@hammerspace.com
Subject: Re: [PATCH v9 07/19] nfs/localio: fix nfs_localio_vfs_getattr() to
 properly support v4
Message-ID: <ZoAtT4M3jCIF8pIC@tissot.1015granger.net>
References: <20240628211105.54736-1-snitzer@kernel.org>
 <20240628211105.54736-8-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628211105.54736-8-snitzer@kernel.org>
X-ClientProxiedBy: CH0PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:610:75::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7007e3-9026-4a0a-ab92-08dc98533b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?W8xyP4qBmylWMdrabWSTbuZLw5AwXNO1GrXXB9sandUp4THobQyfzZQSSXhR?=
 =?us-ascii?Q?BDktjVbWkvbYZf5AI/aCwzH0sRoWXF7ilSlTI1A5lMQ3SjjdQtXmHTOb9Tpy?=
 =?us-ascii?Q?8hsktYwQLsK4OvWj++8mQDfa+ltQUH2YyonUJJDM+TaOPFqMzRp4ukYEGo1K?=
 =?us-ascii?Q?RAEnsNtGowCP8UOizLsCXNdlMoyrOYI2VvcSFDUrfkffkg9C5ceX7Pa38L59?=
 =?us-ascii?Q?0pjhOtRhm16g6teUlhg6HzI/r+2p324nu9G5IQFQj4GxS2BP6SP+cr0zrSu3?=
 =?us-ascii?Q?gtyvIYcFr32+Xl5hDWuAtKZjd5+eZy6Ak6iR8/zoaQDAX7KlrtrQwr6OxiCn?=
 =?us-ascii?Q?jXLP4+31orrIDdnxlITh+8zeJFGzAKiIQXCV5yxpEepBvTb8uY3LecVed6W4?=
 =?us-ascii?Q?qgrzGKb6D435qTcbnhPBkJcwO0Mw2FpYIgEgp30EcBhZipAsemBmVNurjDj0?=
 =?us-ascii?Q?TLrNIkeWDo1hz5Hvbpu6XauXezeAb86qrioQ/yA/v5iOxzqPgIvv2EnBu87J?=
 =?us-ascii?Q?oER0KPxNQhLTC0tuNeYSxLomXv7+SddfM3qYmE++i5BmxQdODsP43Qx5qo5X?=
 =?us-ascii?Q?/eEkTaCy1qDn9CeLglKS0YW2k6GdYRw51XZBqOg8WsOSHxIaP+B936+77zK6?=
 =?us-ascii?Q?B5ObPNnj/9hBsdMJy84OhfneJC81XEkI1e47pft0VEKwXsCCfYdLUlnuM2IB?=
 =?us-ascii?Q?6THLB9/rfOKj1dO/lwdPxSpHuypKDRmZ6prKBPsJZ4QAbmnfiXk8fUsEyWR/?=
 =?us-ascii?Q?txgD+fVUUtchwWsK9HL61l7t8BJrptfVnbr3S3Zfpa5pTVzEmmWUxbPx55zl?=
 =?us-ascii?Q?xhdvOIjYVVDctXlgjhaal9TNwWrb3B+2HKhqatyRxvQ5zK66kdA1jNBF/Lyr?=
 =?us-ascii?Q?7RxO32VpAn0TD0W7dKDiperkmX/ftTB9iR1pwQUcBFQGkHB+yCcGBUbJmpor?=
 =?us-ascii?Q?j+dL5V1eaa7dwMt7GMexkvpPxM0cdoG281r2Qe3+UscDWlxD1I7sJvKqAgXN?=
 =?us-ascii?Q?R4Xv+XjnLwqDZaBuDhgOxDnjE8jWqJ4rBa5CNquzE0WreSWTqUTcmQWIg/5+?=
 =?us-ascii?Q?yYrei7eMrYjliX/5qszo1k1hEx+a//2pMFdCEWqb6DSo2oCM6IWbkAz6++Gn?=
 =?us-ascii?Q?2IHibruK1Fzx/iSkatqbg9/EI6wWfMou+3TyuvrFJ9NNU+PPdEy1KPg/BtML?=
 =?us-ascii?Q?nBn9NJfQpWDABBd2C+rR1Tq0xl5Oh4WFs9ofrCLQL+WTabhM0br3MfKMYOI2?=
 =?us-ascii?Q?cq0tlGx2VrGqW1RnoJ30V5GYhPYG5k3tj5rT00a1QBZyePEbKIOqScstTq7k?=
 =?us-ascii?Q?K2QRo9sErScpURHYzaTZs2Ed2hwOdUMmJ0hMc7KXWwOtsA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?81mT/3qfdzJMUJC3oTVj1NUSuxikroii3BzsJB8tKtSYDfE2aapDCYfK6YOV?=
 =?us-ascii?Q?rh+HPyu0PSXXJoZvxe4wwJ+3yhvd9rwggs77VUPK9OSzgp7eRz7upDbFpVrl?=
 =?us-ascii?Q?ptBaP11Z6qstsej8u+hdFf2JR498+8IIp/pwNVSvOVv+eJsHzIHIJj6CGjZh?=
 =?us-ascii?Q?lR45KB4vYVJdPypB2mlnuhuFqUsfKbPDAgM+l06cg7cKdXKZQvbOJiAOuT05?=
 =?us-ascii?Q?1ABuwLULhhb9F17W9wy8AfV7L2F/3j1cOACdVAblYriQiHgEfd8AxyLwscXS?=
 =?us-ascii?Q?5VPwPRkrsfjdqGxp6i+RRHk0ZrIzwOBsDAdqTM/gugqlqImi2oHkHBF0yFlD?=
 =?us-ascii?Q?TTHbgQfEuq0b1nwOrnwGS25E+r4RD6rpJSKg1Omx3OvCMkVsIp0lpyusVGcK?=
 =?us-ascii?Q?GcCFKffCXSqL/ug0+BckJ+oE7WKy6zroz2gsesIO+EXzxYq72DOqyqtMUZd0?=
 =?us-ascii?Q?YcL951cTD0Grp9yB21pGxNrmjzkPKJbsDyWy4tsParrRA9wT3k0JVEcQkOH/?=
 =?us-ascii?Q?zx8xkZIbMaclfQqF+Dn8Ygq0lJsPQtg2QAw9XAwDfpF16Pasde+aXs6crlIB?=
 =?us-ascii?Q?hWVxYFOUL1ZqZ9182kHb1ERkCeoV5tdqAJrOjsGvWFPGATZ6bCTtos0A4WE0?=
 =?us-ascii?Q?xCocBVum2ZScLfMwEzR20S0bL1rBbiPY+GCG4I6nmzUSVTJ2aihFvJMPCJUQ?=
 =?us-ascii?Q?BZlQAz3bRW5OgVIAQk/qCMgvSpmAb4D3hotQQCZb12rW3nNkygWYDIdDYYRg?=
 =?us-ascii?Q?SwyhzGm+3g3dUXzsQdIkSvE3Wi68vLsOYYSk7Gowg3+z192w5xvaYXrxcgVf?=
 =?us-ascii?Q?dE1ev13gt0gkpCCSfolH93otZuDoVQGIvnaTsfYbXuJadvKRcjpIqY59WgME?=
 =?us-ascii?Q?gLvtE3nJFQ6O8pOBAOxOUDq+x2BRZ7xIc2nOaGwnTMGAli9bNuE2a3w+FbxU?=
 =?us-ascii?Q?wPBX5tX9rd8XZ9RX2G+RBaMMIyp3N1HI7ESEdi2CCZwS+1VN8LvsZKyuXqea?=
 =?us-ascii?Q?sBG0EP+LSYTFNZhuGXPF6LUkmvmllHGTUCWvW7W3Sr7Hw3kJZhp2+wQyml+h?=
 =?us-ascii?Q?Idbl7KbFgoN8MzQdtSR+LVzi3UCENyNl/rR9IGM0xpBvRJKreFwaYBNf8LhV?=
 =?us-ascii?Q?BerwBH3/L7rHlaPPwAvXkGLFkXFyLaoq/gt2bU6swVE+8BSth1ItIE2RbWB6?=
 =?us-ascii?Q?8KYbwDAc38PkSiKmLWE17knEIyTu+FX+HmL1oV6xTLjaAK7n8iBuX0AhvDfE?=
 =?us-ascii?Q?VknJMTAXjGyY7KP6QggFdRh0Hwvtjyo3ol7RN5PNY7C1yuSUeJq1pSjdEsMm?=
 =?us-ascii?Q?FNTaMVlsEZKFxlxzS1TbesY6GbuoBbPX5EZfY25PTsNkhqnfaAj6yS7AP33o?=
 =?us-ascii?Q?W6XebqhrKMO+XkXjOmMGs7lPF03SykhsZi1w4vytcD6YaTm54K+G1kYCEG36?=
 =?us-ascii?Q?VuAAmrQkD2PayejMOHYtv4u0S6H9qmvQPoDHV/zJRgrWhH4lr/1Cw800NLmZ?=
 =?us-ascii?Q?s+m79zCarNShpkF/MipderRLY14FqVOfO/0Qqj02q8yQudazCmeV7oIjkxcP?=
 =?us-ascii?Q?u6Wfg0CSVcPlW9Wpk3grZ84Y+p9bdmR9fdaXtcpi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rx+jw1PgWQMfJW62P2iWhw68zXqI6YL3nfQyzjQFircMcTaa23pyqrhTlO/Q7lBgvvK40dsFbW98wcBaOXJxQBoWIUGxQyEuVx05Q95IMpbigB/8KfX1yhis/VE47MZB+wuaGsLJekovl6S7G2y81X5qlPiP2NaLRlAEqwvC6wzHq42BXnNthnGN2a8GBWg3oz0YqLtHjdPSyTvhoyCwFGxiUDaIZOkzGHfxVU2Wr4lcV8Bsa6IPcNn5B3fnK/UIPreSHvVEFtWwiiUu+4LO3ocNYQrL8TZ68DsoPmIIZweWAfszKy0iXbN41Y2+aEAo1kCSVV2fq4HKWCcv0s5V4gWg/H7LK1cU0bdY11Gm7KTNbztTC+kqG+kaQYbUhWwpAQy/fmLkDw4Epi9YHmf8/hbHlw5rAticWr26epONNevTD3GMVsZ+8FAtlJeEV8C8Eclmf5ZVuYWjDTRlzMlytct3m3PyU3aHR6nkmQSsxywT8KxYSIq9H+/Vv4H9KoX+m6s4Tl7cWqLwT9NF4IDGLmx5Idu5HUtRSiVSxIUuSV5BU+Roy5QSSPm5CSvLHkInBet/J7QejexKRDTPmzrkvQwWanLUua+9sEvRVhAKQeg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7007e3-9026-4a0a-ab92-08dc98533b65
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 15:50:42.7409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gXLNJrqsd3sQ9C8AuO4/forxkThXlsDdgTc0yNA53GT8xJ24h5qiMoyniM2t0MYYa/b6QZEI+5HhNkUijWvGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406290112
X-Proofpoint-GUID: RpSwXXEUlB0TRz6UCZiCBskJwn3Fqkt4
X-Proofpoint-ORIG-GUID: RpSwXXEUlB0TRz6UCZiCBskJwn3Fqkt4

On Fri, Jun 28, 2024 at 05:10:53PM -0400, Mike Snitzer wrote:
> This is nfs-localio code which blurs the boundary between server and
> client...
> 
> The change_attr is used by NFS to detect if a file might have changed.
> This code is used to get the attributes after a write request.  NFS
> uses a GETATTR request to the server at other times.  The change_attr
> should be consistent between the two else comparisons will be
> meaningless.
> 
> So nfs_localio_vfs_getattr() should use the same change_attr as the
> one that would be used if the NFS GETATTR request were made.  For
> NFSv3, that is nfs_timespec_to_change_attr() as was already
> implemented.  For NFSv4 it is something different (as implemented in
> this commit).
> 
> [above header derived from linux-nfs message Neil sent on this topic]

Instead of this note, I recommend:

Message-Id: <171918165963.14261.959545364150864599@noble.neil.brown.name>


> Suggested-by: NeilBrown <neil@brown.name>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/localio.c | 48 +++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 0f7d6d55087b..fe96f05ba8ca 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -364,21 +364,47 @@ nfs_set_local_verifier(struct inode *inode,
>  	verf->committed = how;
>  }
>  
> +/* Factored out from fs/nfsd/vfs.h:fh_getattr() */
> +static int __vfs_getattr(struct path *p, struct kstat *stat, int version)
> +{
> +	u32 request_mask = STATX_BASIC_STATS;
> +
> +	if (version == 4)
> +		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
> +	return vfs_getattr(p, stat, request_mask, AT_STATX_SYNC_AS_STAT);
> +}
> +
> +/*
> + * Copied from fs/nfsd/nfsfh.c:nfsd4_change_attribute(),
> + * FIXME: factor out to common code.
> + */
> +static u64 __nfsd4_change_attribute(const struct kstat *stat,
> +				    const struct inode *inode)
> +{
> +	u64 chattr;
> +
> +	if (stat->result_mask & STATX_CHANGE_COOKIE) {
> +		chattr = stat->change_cookie;
> +		if (S_ISREG(inode->i_mode) &&
> +		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
> +			chattr += (u64)stat->ctime.tv_sec << 30;
> +			chattr += stat->ctime.tv_nsec;
> +		}
> +	} else {
> +		chattr = time_to_chattr(&stat->ctime);
> +	}
> +	return chattr;
> +}
> +
>  static void nfs_local_vfs_getattr(struct nfs_local_kiocb *iocb)
>  {
>  	struct kstat stat;
>  	struct file *filp = iocb->kiocb.ki_filp;
>  	struct nfs_pgio_header *hdr = iocb->hdr;
>  	struct nfs_fattr *fattr = hdr->res.fattr;
> +	int version = NFS_PROTO(hdr->inode)->version;
>  
> -	if (unlikely(!fattr) || vfs_getattr(&filp->f_path, &stat,
> -					    STATX_INO |
> -					    STATX_ATIME |
> -					    STATX_MTIME |
> -					    STATX_CTIME |
> -					    STATX_SIZE |
> -					    STATX_BLOCKS,
> -					    AT_STATX_SYNC_AS_STAT))
> +	if (unlikely(!fattr) || __vfs_getattr(&filp->f_path, &stat, version))
>  		return;
>  
>  	fattr->valid = (NFS_ATTR_FATTR_FILEID |
> @@ -394,7 +420,11 @@ static void nfs_local_vfs_getattr(struct nfs_local_kiocb *iocb)
>  	fattr->atime = stat.atime;
>  	fattr->mtime = stat.mtime;
>  	fattr->ctime = stat.ctime;
> -	fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
> +	if (version == 4) {
> +		fattr->change_attr =
> +			__nfsd4_change_attribute(&stat, file_inode(filp));
> +	} else
> +		fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
>  	fattr->du.nfs3.used = stat.blocks << 9;
>  }
>  
> -- 
> 2.44.0
> 

-- 
Chuck Lever

