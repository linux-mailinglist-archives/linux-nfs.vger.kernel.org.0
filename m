Return-Path: <linux-nfs+bounces-9469-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1C2A194BB
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 16:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05ED37A1229
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED921420B;
	Wed, 22 Jan 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JQYxzSd1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GE/eq0U9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B72135CF;
	Wed, 22 Jan 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558613; cv=fail; b=QHlFhkJgHZawkpaelaAZxFKaYYuj/QCwYoBJ+kk/Rnc7Nm1hDCMnvgeszY1PUjjzeDpVITiu0giy8ZjmYQNuQaVt4fM0gYFggyR+VS5yOghvGEC4prfUWu2j+e0idpYxYL7zTfTMm8126frbD1IT4k0RzSYUTAUBNqqw1cLoejU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558613; c=relaxed/simple;
	bh=+Nkc3ATUTcV1/J2NDLCzftlQDJLDh95uUsZliCNDVc0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4MOxOJNAp53QikZJHFd4xBCpnJ+IFieOjfzMmw4l4PCQMSuvcbfOeK/RTGUNJ1dFAUqpZCLJAySSvv0Hj6fvalOpgsfNEZF+KpJlLrgvmGjfVlu1qMf7sFTBCY0wrq+M99A32Y3miP7kQJlHrqya/0y4QcuC6tlvIEWxO4uAmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JQYxzSd1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GE/eq0U9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MEXjEv014048;
	Wed, 22 Jan 2025 15:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/dTSyFmSdt6BAyZm1ePCR4i98GUHPq+1USdHRguU2Xo=; b=
	JQYxzSd1TEXvmzmFeZNhEHKj8PKmbBZtJ55QXgbTNnDgNHGB/nXTSLpH9Wpk9bzV
	QTeu+Mo3COKthNasZzVUasq5Y/tsrzTSKFApvHeVxHdvRC7czqq7BK6Z2tFZOft1
	chxYheyP4yNxHDH/cZOENiYg013hY0MPEeX251mxaZtDM5uLbGkti8kGeWag/9bS
	ruY6K+oEwXE86nKjQ0dKWFkfo42C0WBj1DByYWo+hCz6wq9a/986rZfObj5JUP6J
	NwFLhFEt1jbXBvurun0+/E+IBlIFZCne4JIqxk9VGj9ggTsgOb7Un+C43GyNF4Pc
	yQbeyxQYEmJ3WlEdO6be2g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qaqyt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 15:09:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MEYccx018765;
	Wed, 22 Jan 2025 15:09:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c3r902-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 15:09:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWzdHgyEv68zMMNPCyyTpcVCm4yMuDih0QGT3k/QJdZ6N4e1iA6p6fz3yPJEoHNhkuYXFVqAqrDAZk1naHc09Zjtkx2gDlcY8ITNPHw8bYf0SZNzDMFY2F4ebowYyC1mFWLCm9WMNy9D0Unr926qcLVtbthXxUO31dnRCNmefFlbObSnDTY4AZpjXji55DvwqNTKgB18jvijUzk5y3SNJh4N5tmBuaFomBcwdSYSh0x0JouFEtrWjwrxfFowa4UNQ3+flLME9B4s+xq47iA4daCWkw/xwQjcmH8aA0ESSqmPapw1EjomAP3dnjCtyNT8AiRYfozHdkc1LZuELzNMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dTSyFmSdt6BAyZm1ePCR4i98GUHPq+1USdHRguU2Xo=;
 b=y/btXvFK9a8efQzn0szQ+e1HcmdLRd7ocF7ZpmsishiLrmqvywrt361cXfsbgRCcPmFA0DHUkGXq/MBDSWekMCpLLxlq9HOs4W6NNqszVsNW/a93nvs12gDc9RcPu6U+eXm8bmhKz3a41OgN8yOB60zv9n9kFNjPg1/KfyUvCvKRa9ZnqBBzmMK9jVfKnZbRwk8RJEuPbHX/DLPcv4WTuwANvepr2GCS/A6cP/cbUpJ6efyhIumDJiOx3gnAqwkm4Uzu5xz6wqmKZFt3EUltMB5NW+5pi4flj/Q6tG5GlVQLWaJTOO9VOVXFbsSdOE8clF+URcGyr99gHe075HXR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dTSyFmSdt6BAyZm1ePCR4i98GUHPq+1USdHRguU2Xo=;
 b=GE/eq0U9zdSYf6W+k/rG+VFdR3QhIV54GD3Aqq7qXcMKXtI87LJBCunMsRiCIYL66PgG1ElcTuBwLJRWQcyBtWvbbFWv2zFHGaRC1GwqSP3epBRNvnR09hvPZU7ocYvnCvu9C84ym8kRgtHlEcETGUQEZrHvMLGxKHsy0R+Z8sE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7732.namprd10.prod.outlook.com (2603:10b6:510:2fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 15:09:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 15:09:49 +0000
Message-ID: <020629ee-99c0-45f2-8334-80d4cd6a5da6@oracle.com>
Date: Wed, 22 Jan 2025 10:09:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunrpc: add netns inum and srcaddr to debugfs rpc_xprt
 info
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250122-nfs-6-14-v1-1-164b0b5aa330@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250122-nfs-6-14-v1-1-164b0b5aa330@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4846bc-a8d6-4ce3-9a02-08dd3af6d0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHdLKzBUR1JDRmZSeFNxVEJNRUx0RHNPM2krQTRsNW9hMFJ3KzlyajUwN3Rx?=
 =?utf-8?B?NVNVTFFwYnM3aUJodmdKWVlORC8wdy9ndmRRYnpmbVBSYnFNSDRkelFVbDJz?=
 =?utf-8?B?V1FNZEtMdWhaczdOZzNyb3NtQ0FQRXhZeWNwZ25xalZWaVdJZGJuNkxHb3Ri?=
 =?utf-8?B?eWsxS1NUVFR5WU1keFh5cTNaek8xcFZ6MFhCVFE5WXlxU3N3TmRnQXFFVmkr?=
 =?utf-8?B?NGZRN2hGaW1uZVloU1hMdFA3dkRTODltcE1WMmN2bmhLanBmenRMNktKaTZM?=
 =?utf-8?B?Y1pLbEdKRThuN3RpQUpOY1NJRDV2NzJXU0xqaEovSjRObllrOVBvRElEUnNy?=
 =?utf-8?B?VXg3U2xlY1pkaWdsMlgwOGZBdXJrV3pmN1JhYTdMSm1IT1lpbm9JUEgxbHNP?=
 =?utf-8?B?cmFtRjdPbUs3WDF4dkVZMlJsRjRTZEg1SnJYSzJnR1JXSEFheHZIVHVnZkEv?=
 =?utf-8?B?c0tnU3FiM041RzB6L1FNL3RpWnNtK293cTNhRjNnNzlCWkNvcXJJeU5KZzhH?=
 =?utf-8?B?bWZGcThzeU5QVGloY0RnM050WHNGbDIwb05nczA1VTIwNmZRRnE0Vm5sYkQz?=
 =?utf-8?B?SHV3emJhYlBuQ0ZwUkp2RHdQdXdXOVJMV3JNa1JocjNqVWNzZnB1KzlKU2lz?=
 =?utf-8?B?UjhtT2RreGF1V0R1Z1MxN0tvT1Q3c3pJSWNsT2pPaUNWYTVFZ0VRSVZ5S29l?=
 =?utf-8?B?RjRjL2IwOWxNTnpqNjZUTzJLMSs2SFdJQW9KOXBJbE11aVZ6NGtoWXpva3U2?=
 =?utf-8?B?a2UzU1NyNWNxRG13SnprRnl1QTJvclZWNCtlMnhkSnM5MU5OamdWMWhIOTdq?=
 =?utf-8?B?SEYvaVh6WFdrNllLcER6NHozOHNsUy9RaFBNeWtBNVhWVklsZ3lSSmlsUnJR?=
 =?utf-8?B?K3ZyTmJkWDlqaUVpVzNrQXVaSWNPSUhlNVdiVW5QU0pvci9ET3Z6cG55Z1ZL?=
 =?utf-8?B?Wko2bTlLdFplSjVtU1Q5ZFBORmExai9TOVMrditoUmdGOVgwZVdESVlEK3lR?=
 =?utf-8?B?M2FkT2p6NExUT3BMWlFjL0s4dURWaThHQWJpL05VWFh6alB1MXJxcjNVcEFU?=
 =?utf-8?B?QlBYUG9BWjRIMTMwc2VIcXlKUFpVTTNqV0ZEcnJseHNMalZxSVlCWUJvKzJD?=
 =?utf-8?B?eDJneVZDaTQyZjJ5Ky9DcERHUDdYU0NBRDZwQVdyWVVxRy9zZmJ2aGZ1cnRG?=
 =?utf-8?B?Z1hCdFE1SjN0cllzN2htajF5dnZWU0VTS0NibUpLbEJMMWRCVDR1T1pIcllR?=
 =?utf-8?B?eHNaS0VJdlgvQ0dQZmZyV3dYQ2phZ0VCTWdaZ1hMQTlENFJiMUlvMTFkOGIx?=
 =?utf-8?B?SnBwQU1DOEkyUHNyRUZnRkRaZ2p2WVVkalpIdFQrNzdaZWFOL2ljb3FFNlhN?=
 =?utf-8?B?NHNheTZycldnVHF1eVlUQTRSNmRoVWVwUE16VEU2WUw5anNkOEk2cWN1MUxW?=
 =?utf-8?B?T1diOUR5aklGTXBzQXgvZ1hPRDJTbHpaUEFSKy9idzhrSGZ5RVllZzRBV2I2?=
 =?utf-8?B?TEl1cjlIaFdyZ3o1bmp3MjFPRTkySTI3M2lYQ2xCamJXVzJwVmE4bDFsM25o?=
 =?utf-8?B?aUtOdEpIYmR5b25nTC9OcEY2Y2MxbGh5aTFyNmFaSEpHcGE4ZGxXL1Zvd3l1?=
 =?utf-8?B?NkVQaUpTT0FGK2ZQcXUxS3JSeXRGbTIzSFBvN2VYQnM5MnNiQ1NwY0k1M2JF?=
 =?utf-8?B?T3BXOEpKTHBKa3dKNjdabGhxK0sxaitrbzdVUDUvU1MzU044NExnVjJ4OHR0?=
 =?utf-8?B?Sy9PbldQMVdKZGx0UzcvMEVhclFCSldJeXB5TXBpaFlMSEpJeThtZFdGcC9x?=
 =?utf-8?B?M3AyZEJrOWVlNzIvWFp1cXR2ZkgwTmMxL0JKR21wVVB2OThyR2pDZnkrbk9j?=
 =?utf-8?B?akdFRzdqcTg3WDZVSDB4RmtVYjJIenA0VnVWRWJaRDlneGVvT0prNDZneXFT?=
 =?utf-8?Q?mGSNxOeArsE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGRGQW1HbUlTYnhTN0FKb2dua2gzRHFSYTRaR0ltQjlTQW9OUkFBU3Y4Ynlw?=
 =?utf-8?B?aXBlWWxJdkxvUFZOblpEd0dFeWVOZ3ZCWEcxSmhFWC9qRU1ldzNFa0tyUVRI?=
 =?utf-8?B?WjJHUEJqeng4U0Fhd2s4TVIvTHI5VytEU1orUlpMV2FlT0JlcUhlTUY0N2E4?=
 =?utf-8?B?Y3FDMmRtT2Zkem1iZVZoSTJMeDVNNERLOVBRM0c3b3V0a1ArUkpERDFHeHhY?=
 =?utf-8?B?dG5ZcVNodmprMnZkb1NOMC9DWElFZVQ1aUg3U3M5VGhJVTN6MTd1b3ZyMTcx?=
 =?utf-8?B?LzlLL0xCSjhQT1g3NlpNM0JkUFByM1I0RlpGdTQ2TzAzdlczNFVaRElza0sw?=
 =?utf-8?B?MW16UXUyWDRUUmhBOWVMcGRkUUtOTDVoYTg0YXFVUlh2aEJDNDR3VTRNbzRP?=
 =?utf-8?B?KzJzelltWFYxbHF1ajFMaVo5ZW55NHo0TlQ2enBYbVJEaEpvOFlWK2xpNEpi?=
 =?utf-8?B?U0xRdzI0Z2dtc244TkZRTkpRNE13czBuNDZEU3FaVzdSbnp0cERZck8zcGNH?=
 =?utf-8?B?SlVjaDAxcjFhWWZnTjBRcUxPVG5aRFQ5a2N1SEpGWENsc01Gck45UXlCcmdG?=
 =?utf-8?B?aWZPb0YrZkhMNitkaWR3aUNKT2NJLzBOaEJFa0xPV0ppVXRNRGI2TnZBekQ1?=
 =?utf-8?B?TE5zRjkwOUladUdudlg5MnVVbmtmb0hSeWg0bzUwTCtLZ084aElCeWlvZGRD?=
 =?utf-8?B?T28wT2Y3dGZaUVRabDZPYjdZRmhMT09nakh3N0wrRDRzakN5OURKWWYzSEtu?=
 =?utf-8?B?dnZSWTdVcXhYcFJiVXJzUlBXMUoxVlZWSHNMUmNka1FIWjBQZnFibWg1YjRG?=
 =?utf-8?B?Si9VT3g0ZWlieGVJVTBKOTd5dHRyNngwK1VCOC9iNUFwVGwxUDZVU0xwMTdw?=
 =?utf-8?B?aXVIa2hCMmJ4SFYyK0p5cXR2c1hSZWZQSUhkWDZpT08zSDdtZ0EvRGRNaEQ3?=
 =?utf-8?B?NWNWS1hhY2IzVEtMQUxIY3Zidi9hMHpTU3YxN2gzMk82eGVmV0hIYjBjSi9T?=
 =?utf-8?B?VnhWelRweWl2SHRwa2Q5V0x4bFVtYTg0cjJhZmNWZFlYMFROTDlMc2FPQlZG?=
 =?utf-8?B?QmxmZlpHamFVMlFoaHVRY0NieDhTcllFZm5ZU0VpQ1ZwZEhkUElQL1FGVlJv?=
 =?utf-8?B?YlBBaXl2ejh5cS9QYmluY0gxbVJDd2VTWEF4dGR5bytJZ2EvRFRtSWhKYXkv?=
 =?utf-8?B?NW9GcGgxOERXblcwTkpQMGJDVTJPYXE3MStmMWlEMDlpZGI0cCs1ZTFjMDBS?=
 =?utf-8?B?ZktzSldXbGhjR0dtd1d4ajhMeXN0NUxmOWRBampqU1B4UmpXaUpkbitQZStK?=
 =?utf-8?B?NGZwQXRYeGZPM2hnV0U5Tit3OG9lR082OVdYZWJFMDVWTmRaeE9qbU03RUwz?=
 =?utf-8?B?QlhSMjdYTXBKeVpvZ2xKZkRMVmtESlNMeVdTcWpLMURDMVcwYTJ0ODYwbHl0?=
 =?utf-8?B?WWw2Uk43L05lSVBiYmFpc3pvbTM5c1dlenAwazdxTWJwejVBTkJPOU55M0Zu?=
 =?utf-8?B?cWg3MUFvSCtLRExaSmFKV0xSOG5RUUd3K1J3b211N25LU2tDUUJPR3B3RitT?=
 =?utf-8?B?em5RZmJLZzM5VW5NN3c4MHhRM1pXYlJzN085elR5U3BDbitBZ2k1WVE0Mlll?=
 =?utf-8?B?TWhrdVZsZkMvQnB1RnF0UXk1Nm02NmF2VDcwWmxmTGg4OTBnaFZyN3FtZU4x?=
 =?utf-8?B?cG4wTUZIdjJBdWx2b21QYy9JejFGT2RGSjFqVldtNGFIS1pKN0UrNno5bmtm?=
 =?utf-8?B?SjlHc05EY0p4aVZOM1ZjS2pEQWgzS2grZ3N6TENLUmNqUmhHdkJra1JJdEZs?=
 =?utf-8?B?dndIdkxJaVRGUCtSd2xBWmlqR3BRbGc3UWNhU2VJU2pHYTZmQ21xQnR4REhu?=
 =?utf-8?B?bDZ4WVZvb2pQbXBqN08wQ2xZdVlmNzYzaVJDeWxocWgxRzlwMHlORG1DSjFS?=
 =?utf-8?B?b2tTcDl6akJmZHF4MnVManlXSXJTLzBpc00wcWI2c3JxdWtRczUyM1JnT3Rt?=
 =?utf-8?B?YWxKS1duWHZIZGZkZ3F2K1NMODIzMHRjaWdiTFEzOGdmdExCRmhaQW82U2kw?=
 =?utf-8?B?YjBVbldEZ0JOcWI3OXRmSEkzZUxnenFxWXBUaFVSTmlkenZTT1h4cC95NGlL?=
 =?utf-8?B?U3dVejBhdm1DTCsvdkI2cW0yZUErZUw1eENvRFRyNlVXM0w4alVDR0VRSVUv?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b01StNEZS91Ma9M+aO/pTfO6h5MfO6c8HilmJFfNmWz0byKP0HQ0FLFiitvlcaW2Apbly4e+3ObegY0eN7XHoI36sWvzPC4clOv0ohSskWjLU3WyZeppMXylr/2TH2VKYD8ejl+Amsf/v0+8lkpJzMHFQBfmuh+Cs/MzA92PhMNweoXOFl/cm2Knxb0YaYn6uwTc6wOpWjpmo6ckX8XXJrsTvWsTiEaBFcq9sgMETSsS6GMEiXhGiQXw+JeAId8ditiiUuig7iGsHocAA22Fu7nLxcMshStBD4gosOtWFstNIGUjK04gy8cvPH+1zL/QUfLmStXSwOTDQQ+TwIMZNIKkuNg+Fe9qAvyEkN/agaxG/vJvH5nTVMLB0mrJKMuFl+Z056uOeJfR9HPvZLX4HoremzVs84tjOVjv5K6a9FR9xfQzzbLak1ogs3cRpcEM+eO7SwxCUSTiovXvmA+CcI8xLkgtdUpJBxgxDxNPlKr25HdLgly/pxmrFpM08P0UCncQwCnEqyH5nxzC66TqjgDucftK2k6YtiG5fYnGcrpsLxGv+kekolqviL+oqT6qbtS18iCZmmfhKpsRouqRtTy9CssRzckmE0oJKIrGsB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4846bc-a8d6-4ce3-9a02-08dd3af6d0ca
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 15:09:49.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUyVOaa9PxgqAqbWYboyR5VAe53brkFTsLZKaEggiQ5htzmmH35EcZX+9nkcxv8S+naWA5UA9laP9wdX6qVwRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501220112
X-Proofpoint-GUID: Vd923qMXEBHPKIJbjWjtk1m_UGZE8KZO
X-Proofpoint-ORIG-GUID: Vd923qMXEBHPKIJbjWjtk1m_UGZE8KZO

On 1/22/25 9:59 AM, Jeff Layton wrote:
> The output format should provide a value that matches the one in
> the /proc/<pid>/ns/net symlink. This makes it simpler to match the
> rpc_xprt and rpc_clnt to a particular container.
> 
> Also, when the xprt defines the get_srcaddr operation, use that to
> display the source address as well.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This is more client-side code, so I figure this should go in via the NFS
> client tree, but if Chuck would rather pick it up, then that's fine too.

Hi Jeff -

The change seems sensible to me, and it would be better for Anna or
Trond to handle it IMO.


> ---
>   net/sunrpc/debugfs.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
> index a176d5a0b0ee9a2c0ca1d1ed3131b67b782c3296..3b39493234d7079ff762a862bdd51725f36472dc 100644
> --- a/net/sunrpc/debugfs.c
> +++ b/net/sunrpc/debugfs.c
> @@ -179,6 +179,22 @@ xprt_info_show(struct seq_file *f, void *v)
>   	seq_printf(f, "addr:  %s\n", xprt->address_strings[RPC_DISPLAY_ADDR]);
>   	seq_printf(f, "port:  %s\n", xprt->address_strings[RPC_DISPLAY_PORT]);
>   	seq_printf(f, "state: 0x%lx\n", xprt->state);
> +	seq_printf(f, "netns: %u\n", xprt->xprt_net->ns.inum);

IIRC, net->ns.inum is also what the trace points use for this purpose.


> +
> +	if (xprt->ops->get_srcaddr) {
> +		int ret, buflen;
> +		char buf[INET6_ADDRSTRLEN];
> +
> +		buflen = ARRAY_SIZE(buf);
> +		ret = xprt->ops->get_srcaddr(xprt, buf, buflen);
> +		if (ret > 0) {
> +			if (ret < buflen - 1)
> +				buf[ret] = '\0';
> +		} else {
> +			ret = sprintf(buf, "<closed>");
> +		}
> +		seq_printf(f, "saddr: %s\n", buf);
> +	}
>   	return 0;
>   }
>   
> 
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250122-nfs-6-14-7f737deb6356
> 
> Best regards,


-- 
Chuck Lever

