Return-Path: <linux-nfs+bounces-13203-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 124A0B0EB33
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 09:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328471C8230F
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 07:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9B42A8C;
	Wed, 23 Jul 2025 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qlpBq1pR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mk0lBOBF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D1214A94
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254169; cv=fail; b=WNm3jW+IiAzqs1uUi5+nbLmVUTernSXzHdsYMKeVPMf8fD5WXObs/GL/dKwdx4dDA5q7dikKvoqE7rBDcJZjoC/dHV9L7o2BU9YZH0SYqu+CmbXQSQgOYaxnjhs1twdvznkvihbt4flZwiw4+wNzxCIm/DX+rGGPiljUcyJxKyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254169; c=relaxed/simple;
	bh=2D+tYNdnYCLqnc/03JdG3zqLQDFPDakpUL7A3kVMAW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i9790fdKw8en3j4J4cmqkwTEOI8ieAHDToMtnykcEmNAgsC6R35tozTyIIf8cyeFUvpm3ku2l9KDk9RbV4C2EDpkdG7ODXP5ZAT3nUjB7hOO9JsOzvLeUUfCyeRwn2DUmp/5PiTfXkvlOuc7IRL6PGOFSC2IURvVLmdgmrY9TSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qlpBq1pR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mk0lBOBF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMQkCg032608;
	Wed, 23 Jul 2025 07:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=enWb9BsPb4IZUihVF3UfG2AG2CiGbasu0iOc/x77Iq0=; b=
	qlpBq1pRJlYql/vHzx/U6/ukIZ51lh03lKKEmm1whjlmzJIZStgp8l1tzqhlRQs6
	HcGomq4lhGGLw+kYVXIs1VYovtr12onJemMnbW3rddBd1Q/jKFa+kqigSDtGaOw3
	jgiuCnUdKB7/TnAAilWh0nV/vszIwfCBlJzT1cDfKgxHN8Svr4//7dqkMKkBhv2G
	Tv0+x4CPRYiZJjSeX8hdd5ogYNdXmMKE2mFsyr2WwecY+B3vg5hv7U9m5xNApTjf
	LC2GcrIpcFNIEJ8ovXOwZ/cxGGEmPkXqdS673q0YUHXAqSI/aNANdGkG4G0cA77i
	DxOfnBUquLxLEcPdgWfcRQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx6xs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 07:02:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56N5Ks46037748;
	Wed, 23 Jul 2025 07:02:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801ta8u4w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 07:02:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTGY00S0C4wB/XRNt6oyrb6ypwsSX4dcfJOnRd1MlDawwa5rlJVTlQvZr+1GEaegkj3xefihTSoRM3wxwtPgGOEcIs1ICwh4MrBdx6bqC7sWeWxsiA72RpMADsJeEdkH0VW1brh4cUdQ5DYig8Z4i+Pe+gF2RoJy4qSeZrBFrxHU5xdov0IOyyEE51sGw5gVbnNqje51Cj3P/khbDiPwiu6i0QxuvdnGM5RTq1Jr/L1raximMaCCXgLPTzoCy3AkMIAwCdH/vATpfGfW7mX+OYlzOQQEjeTd1949bOp0ZqSB51bTi52Drmmjy9XVLpygDDs0gtB5GMIlP1dqlrmYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enWb9BsPb4IZUihVF3UfG2AG2CiGbasu0iOc/x77Iq0=;
 b=T7oSgSlkfM6bB1iz/vOSmoloIgcj67qVQJ5igHuzuGnvIWyaxqfUygIfAde0tbNgoZuCJlorEmVLwFSlMPcrnxffPx1ZkSP8NltojDfBCKMadPOw08yYkOg3utMQlPz8fV6hOFSi229QSI8abPOwhczf/p2x9bK/xCeuVcSE3RC2fFzZzZYYGb96Bs6uMyuj429gIULcn5rts+lrdk13pbZ6ZN/S8wKjLxDUGLL4bkXuxx0LnyPdbP0X/yucAJwrDIWQ/aOBHE6oT7DR/Gh4gbuKf+t2opBxnUVenNZ94Frgwu+WdCKqwwdR18GPZimTxrZo76HoL1s9De0zVpf2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enWb9BsPb4IZUihVF3UfG2AG2CiGbasu0iOc/x77Iq0=;
 b=Mk0lBOBF4rVzAO4DwkbhnlBvTpOW5DxHzXSaY0kGAHY7BdczEhjmj7i4PTSJdVWZSMNS5kHJ0OBlIPzi9GFVy3SNdFhHFO+LCyUYLZK0zxvWE4f1dILjwewLTYAObJ5CbeNcfXwb9N94ZrVX5AVN0p3861Mcg+I3H7fXaYsiLDI=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by SJ2PR10MB7828.namprd10.prod.outlook.com (2603:10b6:a03:56c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 23 Jul
 2025 07:02:25 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::7213:6bdc:800d:d019%4]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 07:02:25 +0000
Message-ID: <ddaf94dd-30a2-4136-8dff-542b4433308c@oracle.com>
Date: Wed, 23 Jul 2025 12:32:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
To: Mark Brown <broonie@kernel.org>, trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, Aishwarya.TCV@arm.com, ltp@lists.linux.it,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Anna Schumaker <anna@kernel.org>
References: <f301a88d04e1929a313c458bd8ce1218903b648a.1743183579.git.trond.myklebust@hammerspace.com>
 <7d4d57b0-39a3-49f1-8ada-60364743e3b4@sirena.org.uk>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <7d4d57b0-39a3-49f1-8ada-60364743e3b4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|SJ2PR10MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: e5eb0eaf-0b05-4e45-a50e-08ddc9b6e0af
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V01yRVJzUnpldHI2cDdYQm91R0Y1L3pQNEwvOGZnR0wxWWlZbXBPSm9nODRR?=
 =?utf-8?B?Q08zMjNLTXRQZWxOSEhTSmJGV1FmdVdnNnlmakRXZHJ3SGtBV3oyYk5qcDBa?=
 =?utf-8?B?d3BmaGc1ZVZOK2s1TUxXemJVNVdweTZpS2treFRuQlAzRjVTYVpCclZvRUg2?=
 =?utf-8?B?NDUxeXFXWjgydUYzWGM3blhrMXJ3akhOckcvMlZzb3BNUENkMXd4ZWlPZ3dm?=
 =?utf-8?B?N0U1TkNqV29pcC9TOHRkNlRyWTdDVG5ZRWUrQm9kN1VnazR2cmUvSVAvb0VI?=
 =?utf-8?B?NmZ2c2VwUmRSV3ZYQlh5RWVlV3NwbjA4QjR1S3RDMmU0NHQ0TWR0cldIS3FX?=
 =?utf-8?B?TXFxNzgxQXAzVitOQWtRUFBTTzlWNlk2aDFZZ2o1dml4cW5QanBPVk84YzFD?=
 =?utf-8?B?Ykk5QkZqUE1GVEgwQ3Y2WEhCRGE2WXhsY2NPand6bW1naWtRaS9jUWR5Mzcr?=
 =?utf-8?B?Y0wwc2pib0ZGSEFrbWxINFdxamxVS3IrWDBmU2ZOUVNLcVBLTGhIem9JYkNl?=
 =?utf-8?B?UVpKbHM4Mm1YNUxQak52RlhDQld6cDBSZ0hqZHRKdGFxR1NtZTdiY2dPUnRo?=
 =?utf-8?B?M2JMYlh4SVI5bTNsQ1poN3EzaFM5bjF3NEY5UWVDUE81ZjVBWUlVMnVtYlRm?=
 =?utf-8?B?dlRiTXFxbVgyUVVyM2pFcHZYZ3RoY1VYMFJsVVkyY2ZjQkxlbktsS3VUY215?=
 =?utf-8?B?RmdoK1dXZmI3dmRUWmtYTUdtK1RzU2p2OWdPSkI0czVLS3lVNTlkVkdCM2VW?=
 =?utf-8?B?cE5QcnRHMkl4QTdwc0lNOWltdDRkNURNZU5qTVZpUWlFZzdIaXQyOWcwai83?=
 =?utf-8?B?T3pzVk50MnBTNUUwdE55NzZNS3BHUWx6ekp0U3hIWDg3cWVPTXRvcnAyMm9R?=
 =?utf-8?B?ZnVzbm5lL2ZDSE1UdWtaZE9qbzFaVHZKeThsT1BxRWVXRjN6eHJOdFFPb2lP?=
 =?utf-8?B?QXZkUGJHUkhTLzROU1ZwY0hHKzFkR0NzYWFOYXpaR2J0U0pIT0VCUWw0SjJm?=
 =?utf-8?B?aVpBQUlrR21LRWJ3QlZxZHhuaU4rdW9YeisxYWpsaWgvVDNVVlJ3VGdrSTRn?=
 =?utf-8?B?cWQ2RFl0b3RUemh3VVZFYlVYWU5peEZEcUY0YmVlQWt4RTdwdGNhb3o5ZnM1?=
 =?utf-8?B?b2YrVDdQTGtKY2F3Y3pOaEtBTmdRVjZtOVJDNStLZ3lpQ0NCdHJVSHFjUThJ?=
 =?utf-8?B?SzJhVUtwemVuc0VrVTMrZGFvdUpaQXhBVndzOStCR1RiRmZCbVZDSWRNWFBF?=
 =?utf-8?B?L1hGWXR4V3VIeGlxNGFaWmJYTWVFV0FKZlhFamNhazNKNG04TERIaitDcnZy?=
 =?utf-8?B?NnIxWkw5YXhnZjNJb3o1c0d1Znl5WDJwQ3JBWHJMdlB2N3VsamtzNm5KeFJs?=
 =?utf-8?B?MUJQUXVnNzFCVEFxL2IyS3FnSVFxdlR0SFF0dlZKOHJ2MngvR2piNGd4MW14?=
 =?utf-8?B?RkxOZjNLR0tzK3p2MmM5dVRKdXdjZURLaFVBQzE4WE40ZnhaMElZa01sZzFY?=
 =?utf-8?B?Vnd3bDJvMHUzNy9uVXdVYXp6a2dSdHhGc09ZaCtDWXdERUlEQlFvYnp4Wnpr?=
 =?utf-8?B?cThxTFVKMGNzU1NQaTdaZDQ4aFZURUdFUWVJc1V1ZVc4QlFZMDlLNE9XM3Fk?=
 =?utf-8?B?VHRYSU56ZDlWMm4zaHlKWWNyYXJDSTBhaTZiTVBxVzJVU1NESXBlRmk5YlY2?=
 =?utf-8?B?U3NaTjB2UHo1MEEyZ3ZWN0h1K1Y2TUhnKzhRaVlOQXBzL2FWaWRTMmRsYUlI?=
 =?utf-8?B?N29vY1FUdTFJek85Tlg0d3JwajB4alpINVRDOUNZR0JTT1NiNmd3Sm16MnZX?=
 =?utf-8?B?YnR2SGlVY0ZIbnZSczE1S0tMakdlTzhrZ3lDNDVkcWo5YnFiUkxZZkUrNUlW?=
 =?utf-8?B?dFlTVGVCRDhRSU52aHJ1MkhzTkUraTkyckpERDdUTFNOLzVKdGVwdGpzYUg5?=
 =?utf-8?Q?aqqvs2eiEAQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q0dXdmFnanUyc1cxc2pEaEpZZkF5Q2luRkw2ZFBXRlZHVWh6NkRvRzNwNGRr?=
 =?utf-8?B?Smo3aFVsSkZmell0UzFsdnA3dStuL3I4V05XcitxMHpsVnlPWmw1SGpueXB0?=
 =?utf-8?B?V1k3WEdsSjFvL1RkaUh4aThsc0JOT1pCZkdyV0pnWGthZ0hUSG43VkE5RWU3?=
 =?utf-8?B?VmtCaE91OUovNWlvNnlWd1NPTmVtdEYxRDd0eDFPcysvVkV6YnRVYWFXeGpk?=
 =?utf-8?B?QlpYYUNjcHh1KzVYQzBYdXY0R0RkN0thcmlaSmdOQm01cHp5d2hUMVFTVjdM?=
 =?utf-8?B?RndmeFRKaXZDT0tnWlg5MXU1ZlhCT2NYYlBZdmdzcTVGY3QzNnFRUVZGck56?=
 =?utf-8?B?WmV1VzV3WTNPa3d5UU5rRVRKdThMaENEa0FKV20yeExIWm92L3dpTW9ZcXpx?=
 =?utf-8?B?Skp5VzdQU0FYWXdxUkZHKzRLZ2FXYU1jNXBwMEFJdU90VFpYaU1HOERINWtn?=
 =?utf-8?B?U2RXQldhUFA1RkxFQ241K3oxWldsN2NoenNya1hIbVcvV0FsYmg2bE9IWnRt?=
 =?utf-8?B?WkRFZ2JMeVl0Z1J0NWhMaTRtQ1Q3RFBFWVFiMVFONWh6Q3JEaHJheDBVRnUw?=
 =?utf-8?B?bWpieHRhNW5NdklySzZjRWZ6djJBeWFLZUJybTlsQ3A3OHd6MHFIUnA1akRi?=
 =?utf-8?B?ckF2aStwcUgrV2NWN204R1BxSXJxOW1qK2Y5aENiWk40cEdGYUxTTUhZYlZM?=
 =?utf-8?B?aWhHeG9OdDMrMFg0di9DRDVwdDRLaEZpL3ZzZCtCbkRaVVVVajJEMHRJbHFP?=
 =?utf-8?B?VW5Xb2NBcFBFTG1JK2toU3VDQUo1VEZ4Y1BqYnRmODdQb3VjZlllNUJCNDdx?=
 =?utf-8?B?VnpzUUZvLzlrUTNNblZKM2RZemVIdVJENEpoZDFJMFFYM0lXOFM2SXVEOEFF?=
 =?utf-8?B?cFE0MVZ3OU1mZXFyb0c1eU16c0RkY29kazdKQWF0eWh6KzdrdUljc2h4VUky?=
 =?utf-8?B?MkRldlF3cW5yVERBK2xMbzZweUxkRERzNlI5S1FKQTMvQlRJUVJtRXFVYWFC?=
 =?utf-8?B?dHFJVlJ4aE9rMzNBL250NnlPa3g5Uk1LenM3YXJkUEp2NGpBdk9zN3lCOGs3?=
 =?utf-8?B?YnhzVXk4VXV0MzR3RWk3UXlKRWRYV0xoSDlNUUtpVWJ1LzhpNlZQdmlVOWgv?=
 =?utf-8?B?QzRuVDBQdXRMQ0F4MFg3VEdmY2dwTks5RHU3S1RVM3NGeS94YTZRTXlKUUFh?=
 =?utf-8?B?TWNPQ2xpWkpDazNkaHFFRTU4em9XYVBvVFdZRlVqckJtREZFRmtFYU1wT2ZX?=
 =?utf-8?B?UndDd21Vd2R5UHRQNzV5NnRQOXFZcVZENUVFY2VTQU5STWJadmRMT0xBS1Bh?=
 =?utf-8?B?cHl3SHBFWkNiMTZLcHFPNy8ra2Y0UWRBNFFJODVrNG50ZnNFS0d0bk5nczE5?=
 =?utf-8?B?aEQ0WVJ3Q3NkTEsybmVvc2cyblBqVzhKeWRDbGR2WFozYnphd2RnYnJuYVpQ?=
 =?utf-8?B?MzNlUVIraml3RnZ1c2NwaCs5aXNHZTZwQTlSdEVwQ2NseWw5Y0dBT3V5N0cz?=
 =?utf-8?B?YWU4UFVpRHg1TEpiQ2JzN3BXenkzcmFiVkpJNUVQV1EvR3I5WmxjZ3B4bGZG?=
 =?utf-8?B?WTBkNXJkV043RUw0VjM1bkZMOFdzQlBqSGtvOTBudU9LS09XRUdtTmpjbzQ1?=
 =?utf-8?B?SHJrRU5INm9WcVdyc3JpY2tGeHAvL3kvT2NnRGZ4OXNHb0RWSUFsaUZwYmJJ?=
 =?utf-8?B?SU43OE5QZ29oWFExZElicVdhdDBWRmVvNmY2cUw1elhmWWZRb0VZT3VkZE1V?=
 =?utf-8?B?Umg2T2tmNjJna0RXQ0NRRWN2NndCM3RJNUQ5VnZGVVRCWTd6S1V3czlqaHQ4?=
 =?utf-8?B?dGVZVUtvcTVjU0VSMk5CZWkvTHFya3lUMWhMSWY3UDhjUFZ5OWxkaEplQUpn?=
 =?utf-8?B?bmpWaUY1SFBMeW1tM08zN1owT2F5bWptMHNmVzlKQnhnbUJjdHNyYm01YUN4?=
 =?utf-8?B?NE1VZWJ1UzRnNW4vV1k0VEtrWTU5Y0JsdjdwMmJsYjZ4M29rVjdPQXVoNmti?=
 =?utf-8?B?eVdvb1dnNk1CKzhUY0hYL3krN3ZBd0x1dmt4R3RKaVVJamZleWFJTHNIQjk4?=
 =?utf-8?B?S2VMOXd2L0cwekwwR1pTNFBLWHJaUk5uUVhVQjY2NG9taWp2YmwzcVFPN0pk?=
 =?utf-8?B?YkF6ekdTWU8rQTR5VXFSQyt1UXQ4cnVuaE0xMFYyeUFpQUNoeUhnNHZhU3p4?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nj40p+m8G1CgPBWu0Xmpagez5DyqtwVar6QDqavzy2MoRoFy8+YFChRb8K5Ya/VFZJNcaF/wz/d75FN4eRuJHK1oEtBEh9dIVH3nN6W6gQ06QYm7D4O1smL3o6Bm3TbadSzjnEVe10F7pF88hFZYIsax15BlozltYrINfe1LC9fdbzny1Ue8WxAZL69MN4RvJ4jqGlyrKAHLs68VuVjSJzUqR8S3EN83I1eK41QJKthiWAvy/peW4CwmcK+38EdHAeW5wo84hQcAkJ3JAxTWfrIvdXCSY35fLIDEw40Eq50ywhFG/h20/PpkH2fnQJhwkAmoDovgbBHT5u5h6NCHEeAK2qL4zK2M6luEOUsMQIwukH/jTY6ErYbs7TnODeD58NHW028xx/2O/A9PiacKFhFszT1jJBxInAZNngIljD8o08BbDC+AG3WY9tdeeKD+akraH6yHFgFMZa/5uWHeT/GyPdGAR4NRhDoWTFR5eDmYGST+D4tIvUhn8w/EPUji7T6HBVh0ycPJ63Cj6F3qdW7P65pHmM2CFgtTpUpE0GvfVQ0Wm9fordb2wH8H7rH/vG0mP3+FbOLt9p2zo9/UZFt9dfEVZ7A56BgiOP6o+js=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eb0eaf-0b05-4e45-a50e-08ddc9b6e0af
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:02:25.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcT0R6h8KHSSbXxiFcM8+CyjjpOCDRSFStpp119XvwZBL9jeNl407m5jv+XJBvdRsUtRS2UjuUJHeGmxAGFeDL3Wo27KoUpNbm5lik2tF/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230058
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA1OCBTYWx0ZWRfX4jDxWC6LlcAP
 SXhy8T+KbBPj2fjgd2vGzFkvuUaJaOkBU8oBpCCGSmOXO5VYS/UoKtjwL78VsyHlp9IZWrC0uPw
 Y2E6uM0k4StfovN+8LhtnxsCwuL5GQDJsxJAWQHinQqPNzo1fB3+/XCuN64AWwQktjqwNrgCjen
 T9Ob5gZf5shxcgiJoLpMReCoxUjoMO6yVdx+m0bIvInpXvW4mIlu2rHAG0BjqTIRxtFQrdj7Rbx
 Pvxfn6Ts5kKPqEMTaLMieMI3OFAK2Z5ZmqcGKOsOFOrQVLaMlHSFHuPu8oe08VR8hU0rB3G15gv
 VDniRwAFRQZI5SD/VUgk6YsVliUFlyMTh3KPyirGAfjhoIDure3u8B/lzePu2VTatfiGJ0eHbDT
 LBZ8KFPbX7w1Kk+vNnEEXlnld7LE5HWp5VN45cs2jprwhLCbSXULSlSJ7dwEW2ZDPomSzTba
X-Proofpoint-GUID: QvBs60CRm6kQVuVyPwyygqIUUrLAhX5b
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=68808907 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=SEtKQCMJAAAA:8 a=BA2yZEeYayGtxIKhgvYA:9 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: QvBs60CRm6kQVuVyPwyygqIUUrLAhX5b


On 08/04/25 4:01 PM, Mark Brown wrote:
> On Fri, Mar 28, 2025 at 01:40:44PM -0400, trondmy@kernel.org wrote:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> Once a task calls exit_signals() it can no longer be signalled. So do
>> not allow it to do killable waits.
> We're seeing the LTP acct02 test failing in kernels with this patch
> applied, testing on systems with NFS root filesystems:
>
> 10271 05:03:09.064993  tst_test.c:1900: TINFO: LTP version: 20250130-1-g60fe84aaf
> 10272 05:03:09.076425  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc1 #1 SMP PREEMPT Sun Apr  6 21:18:14 UTC 2025 aarch64
> 10273 05:03:09.076733  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> 10274 05:03:09.087803  tst_test.c:1722: TINFO: Overall timeout per run is 0h 01m 30s
> 10275 05:03:09.088107  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> 10276 05:03:09.093097  acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
> 10277 05:03:09.093400  acct02.c:240: TINFO: Verifying using 'struct acct_v3'
> 10278 05:03:10.053504  <6>[   98.043143] Process accounting resumed
> 10279 05:03:10.053935  <6>[   98.043143] Process accounting resumed
> 10280 05:03:10.064653  acct02.c:193: TINFO: == entry 1 ==
> 10281 05:03:10.064953  acct02.c:84: TINFO: ac_comm != 'acct02_helper' ('acct02')
> 10282 05:03:10.076029  acct02.c:133: TINFO: ac_exitcode != 32768 (0)
> 10283 05:03:10.076331  acct02.c:141: TINFO: ac_ppid != 2466 (2461)
> 10284 05:03:10.076572  acct02.c:183: TFAIL: end of file reached
> 10285 05:03:10.076790  
> 10286 05:03:10.087439  HINT: You _MAY_ be missing kernel fixes:
> 10287 05:03:10.087741  
> 10288 05:03:10.087979  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d9570158b626
> 10289 05:03:10.088201  
> 10290 05:03:10.088414  Summary:
> 10291 05:03:10.088618  passed   0
> 10292 05:03:10.098852  failed   1
> 10293 05:03:10.099212  broken   0
> 10294 05:03:10.099454  skipped  0
> 10295 05:03:10.099675  warnings 0
>
> I ran a bisect which zeroed in on this commit (log below), I didn't look
> into it properly but the test does start and exit a test program to
> verify that accounting records get created properly which does look
> relevant.

Hi there,
I faced the same issue and reverting this patch fixed the issue.
Is this an issue introduced by this patch or it's due to the ltp
testcase being outdated?

Thanks & Regards,
Harshvardhan

>
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [0af2f6be1b4281385b618cb86ad946eded089ac8] Linux 6.15-rc1
> git bisect bad 0af2f6be1b4281385b618cb86ad946eded089ac8
> # status: waiting for good commit(s), bad commit known
> # good: [38fec10eb60d687e30c8c6b5420d86e8149f7557] Linux 6.14
> git bisect good 38fec10eb60d687e30c8c6b5420d86e8149f7557
> # good: [fd71def6d9abc5ae362fb9995d46049b7b0ed391] Merge tag 'for-6.15-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> git bisect good fd71def6d9abc5ae362fb9995d46049b7b0ed391
> # good: [93d52288679e29aaa44a6f12d5a02e8a90e742c5] Merge tag 'backlight-next-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
> git bisect good 93d52288679e29aaa44a6f12d5a02e8a90e742c5
> # good: [2cd5769fb0b78b8ef583ab4c0015c2c48d525dac] Merge tag 'driver-core-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> git bisect good 2cd5769fb0b78b8ef583ab4c0015c2c48d525dac
> # bad: [25757984d77da731922bed5001431673b6daf5ac] Merge tag 'staging-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect bad 25757984d77da731922bed5001431673b6daf5ac
> # good: [28a1b05678f4e88de90b0987b06e13c454ad9bd6] Merge tag 'i2c-for-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> git bisect good 28a1b05678f4e88de90b0987b06e13c454ad9bd6
> # good: [92b71befc349587d58fdbbe6cdd68fb67f4933a8] Merge tag 'objtool-urgent-2025-04-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 92b71befc349587d58fdbbe6cdd68fb67f4933a8
> # good: [5e17b5c71729d8ce936c83a579ed45f65efcb456] Merge tag 'fuse-update-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
> git bisect good 5e17b5c71729d8ce936c83a579ed45f65efcb456
> # good: [344a50b0f4eecc160c61d780f53d2f75586016ce] staging: gpib: lpvo_usb_gpib: struct gpib_board
> git bisect good 344a50b0f4eecc160c61d780f53d2f75586016ce
> # bad: [9e8f324bd44c1fe026b582b75213de4eccfa1163] NFSv4: Check for delegation validity in nfs_start_delegation_return_locked()
> git bisect bad 9e8f324bd44c1fe026b582b75213de4eccfa1163
> # good: [df210d9b0951d714c1668c511ca5c8ff38cf6916] sunrpc: Add a sysfs file for adding a new xprt
> git bisect good df210d9b0951d714c1668c511ca5c8ff38cf6916
> # good: [bf9be373b830a3e48117da5d89bb6145a575f880] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
> git bisect good bf9be373b830a3e48117da5d89bb6145a575f880
> # good: [c81d5bcb7b38ab0322aea93152c091451b82d3f3] NFSv4: clp->cl_cons_state < 0 signifies an invalid nfs_client
> git bisect good c81d5bcb7b38ab0322aea93152c091451b82d3f3
> # bad: [14e41b16e8cb677bb440dca2edba8b041646c742] SUNRPC: Don't allow waiting for exiting tasks
> git bisect bad 14e41b16e8cb677bb440dca2edba8b041646c742
> # good: [0af5fb5ed3d2fd9e110c6112271f022b744a849a] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
> git bisect good 0af5fb5ed3d2fd9e110c6112271f022b744a849a
> # first bad commit: [14e41b16e8cb677bb440dca2edba8b041646c742] SUNRPC: Don't allow waiting for exiting tasks

