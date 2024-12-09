Return-Path: <linux-nfs+bounces-8465-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF269E9AD2
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 16:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23477165837
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DB23B796;
	Mon,  9 Dec 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f8f6leKa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sZLgfJfu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971173D76
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759172; cv=fail; b=SM2z3BCgNBuXM7tSopWOQYjt2wGGXdxUeGjcqPktMXWkCKGMKQcxwtzKJG8kt1AvltQs6W/dSoxfaJU5s+/mt6Se32/sDvUo5pNdqWiHiKvkkmFPa45XvCpY7JMmYQDy5ryfZ3dKUJ1q6X4DYshqzeLsf8gVcfJzLvYbkOMB42Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759172; c=relaxed/simple;
	bh=QD/4WFQtfAqNudUdDmYZWRGMVZLw/5bTHYSmUesB66I=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=OIRYuMIjj6XufAhUPtRF69LlB1Zs7Tf5x5jae9N2FI1+q+s7ybsaynaP/0aNMWzscXCvJ/Wg9ktzFoYzOgxNUUS1/9Wys/W01Yh6MArgX9y7b2Dn0djMKYZxdsFq1/RdY7iXd6rk/TDXvOrb9oTFt/NpJYeQzWHTCyaOS/atn0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f8f6leKa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sZLgfJfu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98gElM020341;
	Mon, 9 Dec 2024 15:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/y/lpJk/oeoP3Wa+Ip+U2E63x8WClUPo3GimFCqAQlE=; b=
	f8f6leKatRwUPsi/UzBgfpXtCLlm01xn0baqdoxZjXU/lf762yACKAkJbENLNuSm
	rmDl8E2y4NdvbZQL9MD84As1K9+hM3PQKfjZuCiulpZVOYiVs1f3KFEo/39dBnKD
	Q0Iy1sVVW6AUr1VuQlTgBgGauzpoqjOTGEuPYM4hqx1Wd7R4jetn0RfzgP7FMkT6
	4NpelGENCBml+ydTuLPHQKw1rAtmsuT/l5ZTtrYkA7btVAoo6FLY7p7KsHbaRGRn
	Qb9HK7nzPM0VG9iGXSVpgDfWw7+nzMH1Urokdn0cu4XdBFC6HRSJR40lUe9pnIqx
	fWc1K29M3EDF0GITLy4DuQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdysuh0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:46:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FWQBp019344;
	Mon, 9 Dec 2024 15:46:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct7dpdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:46:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omng2mh8iY2/UBY26oWygxW35E51t+BXxuMumCwomNkwdi8oENpGYxkr8JOhfz/Te05y2Uv5oHWbvBeCfYitCO79Mny/AR5chq0C0idNV1/Aqf7cB+kI6zZfgQvLQreS05iGPck2CKvt/4sBu/4XprTxz94i4unkPuNR/CDhBIuPa20M0y1xJ5np/RAsONxHFZzVDkKAYkikEcOY1NsQ8kN3Jylj8Tb5kbJpWWHQJc4Ih7Q7+QLzzq+5G1avjhX6txoTwM0hrkCHhIQEKqk/XThrfp23+mkX8foCRSq3572DrZgzpEQY0WoNadMkhCuL3MoKuw4qt/O/0WbIM67Tvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y/lpJk/oeoP3Wa+Ip+U2E63x8WClUPo3GimFCqAQlE=;
 b=cSNxDX2YrFUIeESFhgXtmAfyRFiFRdx7LYlZkEvrtf2dxece/YPlcchZgpPcJQNY8q5iCf3CFDzNiA5D1GWD+SH0+jZU52/Lz0EF8//P7jobOTLzj7bz7t/EzuCCOOs9HDJGfDM414HyTOXB9H316KduI1P1txm0TFSsqavFTNMR30NAIHrkok1O+RD2Q206dNkds0pbngtHiJm5wKW/NB6O0VmG0rIqgwgiyzuPtNGevMGesV2POfNna/zpdrV7AP2g4pTGvnCxckowCNiAw3A8mbs5NrhPGYAf0lYGnGsEDabQoPFRu1qmnTOreQ5smTRgnGSUI9htEsHM5tXhAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y/lpJk/oeoP3Wa+Ip+U2E63x8WClUPo3GimFCqAQlE=;
 b=sZLgfJfuriIVtKHLPT3512GVQOgh+3zkfJAzRUct0wW50gaK3SG05EE42gOHIlp4Opr0RRU1TTgNyIrv6iNvgvjTpLio4HB6s4h2X8DLteMX/7xxKafSN+cVX2vo0W+SkfpZT/qOGfGTbJZegaalwuzG+KllWztaOGr1Qvk4uD4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5979.namprd10.prod.outlook.com (2603:10b6:a03:45e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 15:46:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 15:46:03 +0000
Message-ID: <44a889de-df3d-4d8c-a334-9b0ca9753188@oracle.com>
Date: Mon, 9 Dec 2024 10:46:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
To: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
References: <cce34896-f8fe-42fa-a8aa-4a26cd42498c@oracle.com>
 <173362855836.1734440.12419990006245500946@noble.neil.brown.name>
 <4be7ab28-3ca1-4815-9e9d-9c3a06e126b3@oracle.com>
 <CALWcw=HA6zOrpyi5zPjYq88vLVRjaqx3Jiy2yoFbFieMoQsKAA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <CALWcw=HA6zOrpyi5zPjYq88vLVRjaqx3Jiy2yoFbFieMoQsKAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ1PR10MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: ab28cea2-68d4-49b6-90fb-08dd18689665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjI4b0xKRnM0NDJsVUVKc3dqNi91NDRleCs4cm43S1NHaDZ6VllmSjRQVFZQ?=
 =?utf-8?B?RGEyQjFxbkNlMkJ1bm1sS3o5N1hiQnRWcm5UY2NpelE4ZjJWcHRKNUI4MVdT?=
 =?utf-8?B?OWtaNGhWWlhPMVBJSlZDVmEwa2ViQW5nYWhodnVHL1A0RmVmanNLdERwYXZt?=
 =?utf-8?B?Q0dsZldFV3JlUi9BanVCMTdKN0FqOExEQ25CckE2aGdxb2RRRHl2SFF1QU1L?=
 =?utf-8?B?YjNhQk5nSklQMmoxTk4rQThQc3h6Q0Q4T2N4dFpVWGp4VUdEb1JCYkVGM1dM?=
 =?utf-8?B?NWRsN0xFZmQvS20rdThsQkMrYm5TYW43MHlqd1Y3WkJXWTcraTlkaERyeTJ5?=
 =?utf-8?B?RGN5RXlwcVpETi83TVNBV2txNkRLTUlSL0dyc0VFblZqRjdwYW5ZWlFhTlM5?=
 =?utf-8?B?QVprRk9LS0lLaVFmRG9WeWxyTHRuWCs0ZzdnbkI1dUc3VCs0c3hWeFdMQVBR?=
 =?utf-8?B?U210WmE2SWFqbmpZYlR2QzJqZEVkbUZMZDJEVi9UZ1Bxbmd4MUpuelZhRmJP?=
 =?utf-8?B?Ukx6ZDBKTTdkVWo4UUhVQkRTdSt0YTAweWRkQzRFTFFpVGRORy9BTGQrbTBZ?=
 =?utf-8?B?MjFkckJhYUpGVDlkVnB1WDgwN1Q5WUpLbnFldUJrbnBBVVhtcFJjdmp5TTJV?=
 =?utf-8?B?SlE2QmlWb1lWRVFiTkttZjhvQUNlMjhJVkVxV3pmdU9MV2FhNGowY3dMWThP?=
 =?utf-8?B?QS9FcDlDSUhqL2FqZDFDTlFYazZFeHpWQXlxTmp3T3FZbG9GRVRxT1FFMFMr?=
 =?utf-8?B?R2czZVlnVE9jYXJmWU5XL3pKME5sL1ZXUjdWd3BHRWh6RFU4cDJ1SFZ4WW9n?=
 =?utf-8?B?eDRSVjRrVnVWOTFlcDFtMHBaVlAxNjNaTEw1elFIa2I2OUhMMEZmL3AzZGJM?=
 =?utf-8?B?U2c0WTVGeGRFMmY0QWNnbGJjYS9sSWUwTVp6WXBLQVcvY2FhY2I2OHJSOFlv?=
 =?utf-8?B?ZUZsTDRkSTFnUDFWYThhaFIyMFd4Z0E1Tm9RTldFYzFWRFVNallKODlOMlg5?=
 =?utf-8?B?b3pwdy9KWVkxTEJtRU5jbjJGcTltVnV0VEpmTDRmM3BuVFhxQUhQWW9ZeHRr?=
 =?utf-8?B?cUZFQVhZRFBFendyZHJEN0ZpZmovc3NnOVNvakJzNzlZSlVRRG9yd1U4KzhE?=
 =?utf-8?B?U3lhT1ZkRmdJY3lyNGZqMDd3RkowR2Zzb2RKODU3Njg1OXh3eHlqNG1PWHh2?=
 =?utf-8?B?N1FMNE9sbzZkT1FUeVlteU1Mc3VLVHFRclZZMjFKUXFVOW9ZMSs3cFdmU0Ji?=
 =?utf-8?B?SzdpaFJhZjVKSUVtMFdvQk9IRzU1UDFIbWx0RGFxMmIzOUFFZ1c1cjJ4UE5r?=
 =?utf-8?B?RHN4dFNGTFFzMDUwZ3lPQjJ2eUVoOEY0TTc2Y0lOQlBPcTlNMmpGdm5WVlhp?=
 =?utf-8?B?NzAzdkRXMTJBMm9MUmR3TWpHL3NySmo2ZEI3VVlGMmxsamNNcEMzZml3U29H?=
 =?utf-8?B?aWZuWmZaUXdWeSszOFFoTHE0Ry9iWG5Qbkw5RlhGQ0R5Z3JCMEtuaU1HZ3RU?=
 =?utf-8?B?RkhadVRBb1dDY1JWSEF4eTEwdU5jZG9qQ1hPNEgvNnRYUmg1TE5DSG85c256?=
 =?utf-8?B?TXlrSGpUZnQzSldVeFE5WmpRMEl1L2k0U0FQbkwrR1YwRlpZMVlkem9uYTkr?=
 =?utf-8?B?eVptdXdlOFVGNG9RN1NwMys4R3NhZ29uQzdRcjFPaVRtTzMwOGc2bENSajFF?=
 =?utf-8?B?L0tTeGVTSmlOV3ZMRzlzU05uMDBOOUJuZkNRbVZBMDBVbHhXWjlyM1FDc3Jn?=
 =?utf-8?Q?RoGnon87g1k+MymkXY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2JpdW9jczh4aUNvNDlKQnJpV3F1RkhLeDljSGhsa2lJQi9XVU9uQ3IvWTFy?=
 =?utf-8?B?d1BnQmFQak9iN1JYSm8yMU9SL1FUbTRUSUlVZzFjK2ZhUDRVVU5vbG04dy9R?=
 =?utf-8?B?WFlOZWZmTDFUc0hQbDcxeUNZMktidnBlOWhxUXFBNldiQmJXYnM4Wmx5YTdR?=
 =?utf-8?B?V3RSZzF5ZmdXMERnYlUwemhBc3ZCRHIxMXI5YXdXRkNEV2MxWFVwMXkwSHgv?=
 =?utf-8?B?TlhZeWVEL1RmeGV5MmoybFdBdW5ZVnVwZVRjR0dIWUJ3anZjdlIvUVZ6SFJX?=
 =?utf-8?B?VWc0Z1V1aUZWS2ZuNTI0cjBkb0lvc3duTGtKVWxndFBNTUFJcTJvckRid2dX?=
 =?utf-8?B?Y3N6T0xGSEM4S1oxMDN5Vjk3Q05tZXlVajJ1OXJ0TUcrcDZ2V2o2YVRrcHpL?=
 =?utf-8?B?TCt1SVhvZ0xaNTZtMUQwUlZ1Wnh3aUFZdUN3TnNNd2pPM0o3V2VWaGUrbkhj?=
 =?utf-8?B?c1FuWUZiNzVGeEFOTVpUVXhUSXR0MjhQK21STVU0dElnV2g4TXpmbmlwRDht?=
 =?utf-8?B?a1Q5RmdDVFhLTEdET3Y0cnhVSUFyWnFRZ1VRd2F1M1ZvU3lGbzB6NmVzVHF0?=
 =?utf-8?B?K2pwUnY0eFNHVm9QWTlBTm9oMC9haFhnTFYzdnB5NzNPalFQeHFIMlRpUjVX?=
 =?utf-8?B?YkkrVkVEM1FpaTVZMFYxZjNiVzdkVEZCY1MrM3FUcXg3SVQ3UXE1S3Awc096?=
 =?utf-8?B?c004VmVOQzlYam5ENVZ3eWJJeWZuby85NWxqSlRiakc4cjRlMWZramo1OHVD?=
 =?utf-8?B?djdGZWNDRUtNK0YwR052TXdJVUR0Z2lGdG8yNll2d01SMnlESnlWOXd6WGps?=
 =?utf-8?B?MWphWkE1MnhYTmZmR0xnM1hTTzdXSGpsZTUyUkkvZEZnL1BJcnFvaHdwODhy?=
 =?utf-8?B?VG84UXFsUjNBK05sREVJbHV5a3QzdjI5bjdXT21uV050Z2JZUmFuTFJtVGdD?=
 =?utf-8?B?Y1hTd3E4Z3V0SCtJVlJqdnJZZWsyRWMvckVrV0hFbFk1TnpBZ0VlWU51dy9V?=
 =?utf-8?B?VS9rVWZTY09yQWMzcXRPV1lSQW1yZERRMU9mSTRSclVmOGNUZ0hTYStCdSt1?=
 =?utf-8?B?MzREMVoydVFLbDdaOFVRaUExVEVjb3FCa2tsLytuYlpxSURGb3lZbjJWWXdt?=
 =?utf-8?B?Rys4ZzF2d3oxY2YrZWhYcE9GL2krVWQ5YXpJZ3A3TGV5UWg1MnYrblY2anhK?=
 =?utf-8?B?QjRqd0FHY0NFdXVSQThmMUNpRG90YVZLVkRKSlArMzJLVU8vcGJFbWFzUjNK?=
 =?utf-8?B?Skk5eWRnQTA4cmVxd3FFeW90VWg0QkwwUnBQdHlncmRUQ25iNmx6MzBOS0tj?=
 =?utf-8?B?LzNya1pyd3RhTTJWOGpmS1FXek1nV2RQd2taSllCNUVJdFpmSGt5MlhoN3VS?=
 =?utf-8?B?b3pzTWRqL0lnMnZJN291Qm1HNGRYWFF1cThhNGR2NDloc3RQZzdQMDZvQSti?=
 =?utf-8?B?MWVVUVZzM1hZMmkwS091dXVoQjZzTEpkVlFEWWUzVmRzVFBva2xGaElnczdt?=
 =?utf-8?B?N3kxMGxIcDFwLzFFeXducGJ2K3FjUHRJUlA5TkFMZTdmRGlMaDB3TDRiSjh4?=
 =?utf-8?B?dXZyb1ZjOEdPNEZpcHVzRW80SEc4MkNsUE1VZFcyazRKS0lBbCtXOERHRVUz?=
 =?utf-8?B?dnREUjFJUTJhUzdJRW1ZblVjWldHdzZkS3dSdnNENU5yaGZrL3VMQzYvNTJZ?=
 =?utf-8?B?WXBSaGMwVS9xY3BQYnJPZlVjalRnWTJ5MDRxSVl5elZ5QTA5VStya3NBc3Bz?=
 =?utf-8?B?YjFyeDlFTVR3MjhRYUsyMWlQbEVhTVk3L1lSVWI0Y2FmU01DL1RpRU9TZmkz?=
 =?utf-8?B?UCtCaW9QMTloV2FOWStpRHF6SGdISENLQ2Y0a0dXMjdhM2RnZnFNQ2FtNE9B?=
 =?utf-8?B?bkt5d3BjUmFQdkNSR2x2WDc5TjdGcnBIYis2YW9vTnc2UGVna08xSWRLTnhz?=
 =?utf-8?B?RzZyY2xHMFVzVWtXR1lROVNPcys3OTUvaVlDbjZFUTFQcGxBSEJ4UzFxZTBR?=
 =?utf-8?B?elhoLzdTUHlSeTMxU29jbE9DWUJ0ak5qck5LUHNNWmxJdDRVMkswVEVuTjN2?=
 =?utf-8?B?SkVOQjlRTTJyUlJMb3Z5cHhGVGFTUmVyem0zd0t1SmVUOVZvRGJNazVqWmR1?=
 =?utf-8?B?czRKeERDNi9ZRk9jR1UrVFUwOWpSVnpPTytOb1B1S2pkNlJIeFVEYXNwRWtD?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QmmyMwfAV98/IHHnojxmE7xfPAwYUOD8zHmGDGFgO1NqNiO2cMMqUV8T5/Xu4XquduCfMO7Gnae6vMinZcm91quHcLcyh1bimUaOnub44f81gyrc4IRDscZvosJdK+atumXo7WpZieta5adMGNM5bMhaDNNneJquxdsoZf+qvT2bPrqWv/n/pKfKetnKLjH3alDxyYu3qeJMa/45G03pTqIVt7f6veA8mXQB+XFX0u6Y1aWAZMl3L1CsdHDqeTTQ/clU6Wikb7N9Tx3mZsFSfR2lb+lZIavw+FXdYH9s2nO9mTkDFL58z7JRYMzU4wlwFJn6DCIsj/1K4Poga9xOGJjpYArnTOOdSBpe/fhWdq8cGCpVqNT2cuLI9ZC7EJsKsBHF4kLI1fppBzz43QkFzDvAoEXNgP4RTYR4Oc60mulkV6eM/TBLnSmrxnx5Va6B0K1LQOHmjOAKWG7Ip1aGJM58cwP+xEyfR4r3HXeanaxnvXu8CYjWdidq9jU77kdSDSx4XXRK56XWhJ0+6OW8guZhU+snI48PHd+/37w73y8+BX1+z8DwRc4YSuRpfjY3E1/13jG5+7TLo8Kf9JccdMjqAMJn9Ma/NxWcUK03zyQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab28cea2-68d4-49b6-90fb-08dd18689665
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:46:03.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pY+wacso6LVcqdsYJgl5WXceydZCC88vM6GUx8KeeIz1GzAFwvtacpnp0oLgfYRnjFLPYJBSm0RIbZki2kAIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_12,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412090123
X-Proofpoint-ORIG-GUID: iZg8uENOQgLiElXLcVPdpbh_sPa92IQo
X-Proofpoint-GUID: iZg8uENOQgLiElXLcVPdpbh_sPa92IQo

On 12/9/24 10:15 AM, Takeshi Nishimura wrote:
> On Sun, Dec 8, 2024 at 4:58 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 12/7/24 10:29 PM, NeilBrown wrote:
>>> On Sun, 08 Dec 2024, Chuck Lever wrote:
>>>> On 12/7/24 3:53 PM, NeilBrown wrote:
>>>>> On Sat, 07 Dec 2024, Chuck Lever wrote:
>>>>>> Hi Roland, thanks for posting.
>>>>>>
>>>>>> Here are some initial review comments to get the ball rolling.
>>>>>>
>>>>>>
>>>>>> On 12/6/24 5:54 AM, Roland Mainz wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>> ----
>>>>>>>
>>>>>>> Below (and also available at https://nrubsig.kpaste.net/b37) is a
>>>>>>> patch which adds support for nfs://-URLs in mount.nfs4, as alternative
>>>>>>> to the traditional hostname:/path+-o port=<tcp-port> notation.
>>>>>>>
>>>>>>> * Main advantages are:
>>>>>>> - Single-line notation with the familiar URL syntax, which includes
>>>>>>> hostname, path *AND* TCP port number (last one is a common generator
>>>>>>> of *PAIN* with ISPs) in ONE string
>>>>>>> - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
>>>>>>
>>>>>> s/mount points/export paths
>>>>>>
>>>>>> (When/if you need to repost, you should move this introductory text into
>>>>>> a cover letter.)
>>>>>>
>>>>>>
>>>>>>> Japanese, ...) characters, which is typically a big problem if you try
>>>>>>> to transfer such mount point information across email/chat/clipboard
>>>>>>> etc., which tends to mangle such characters to death (e.g.
>>>>>>> transliteration, adding of ZWSP or just '?').
>>>>>>> - URL parameters are supported, providing support for future extensions
>>>>>>
>>>>>> IMO, any support for URL parameters should be dropped from this
>>>>>> patch and then added later when we know what the parameters look
>>>>>> like. Generally, we avoid adding extra code until we have actual
>>>>>> use cases. Keeps things simple and reduces technical debt and dead
>>>>>> code.
>>>>>>
>>>>>>
>>>>>>> * Notes:
>>>>>>> - Similar support for nfs://-URLs exists in other NFSv4.*
>>>>>>> implementations, including Illumos, Windows ms-nfs41-client,
>>>>>>> sahlberg/libnfs, ...
>>>>>>
>>>>>> The key here is that this proposal is implementing a /standard/
>>>>>> (RFC 2224).
>>>>>
>>>>> Actually it isn't.  You have already discussed the pub/root filehandle
>>>>> difference.
>>>>
>>>> RFC 2224 specifies both. Pub vs. root filehandles are discussed
>>>> there, along with how standard NFS URLs describe either situation.
>>>>
>>>>
>>>>> The RFC doesn't know about v4.  The RFC explicitly isn't a
>>>>> standard.
>>>>
>>>> RFC 7532 contains the NFSv4 bits. RFC 2224 is not a Normative
>>>> standard, like all early NFS-related RFCs, but it is a
>>>> specification that other implementations cleave to. RFC 7532
>>>> /is/ a Normative standard.
>>>
>>> The usage in RFC 7532 is certainly more convincing than 2224.
>>>
>>>>
>>>>
>>>>> So I wonder if this is the right approach to solve the need.
>>>>>
>>>>> What is the needed?
>>>>> Part of it seems to be non-ascii host names.  Shouldn't we fix that for
>>>>> the existing syntax?  What are the barriers?
>>>>
>>>> Both non-ASCII hostnames (iDNA) and export paths can contain
>>>> components with non-ASCII characters.
>>>
>>> But they cannot contain non-Unicode characters, so UTF-8 should be
>>> sufficient.
>>>
>>>>
>>>> The issue is how to specify certain code points when the client's
>>>> locale might not support them. Using a URL seems to be the mechanism
>>>> chosen by several other NFS implementations to deal with this problem.
>>>
>>> If locale-mismatch is a problem, it isn't clear to me that "mount.nfs"
>>> is the place to solve it.
>>>
>>> The problem is presented as:
>>>
>>>    to transfer such mount point information across email/chat/clipboard
>>>    etc., which tends to mangle such characters to death (e.g.
>>>    transliteration, adding of ZWSP or just '?').
>>>
>>> So it sounds like the problem is copy/paste.  I doubt that NFS addresses
>>> are the only things that can get corrupted.
>>> Maybe a more generic tool would be appropriate.
>>
>> I agree. The cited copy/paste use case is pretty weak.
> 
> What a bold statement. Classic English-only user.

Dude, settle yourself. That comment is out of line and you are reading
something into my remark that is not there. Let's stick with technical
comments.

The central problem, as you've laid out below, is that copy-paste isn't
working for you. If copy-paste is a problem for NFS, it is a problem
elsewhere too, thus it should be addressed where it can do the most
good. Neil and I are both pointing out that there might be a better
place to address this issue; we are not saying it's not consequential.

In order to make a clear rationale for NFS URLs based on copy-paste,
the below details are important to include. But we also need to
understand why NFS (which has no notion of command line copy-paste)
needs to tackle this problem.


> Have you ever worked in a mixed language environment? Used VMware with
> Japanese Windows, and Japanese MAC OSX, and used clipboard between all
> these virtual machines?
> For example if you use MS File Explorer, and use "Copy Address", not
> "Copy Address As Text"? You'll find Unicode zero width space markers
> (class ZWSP), characters which are not displayed, to mark the begin
> and end of a Win32 object file name.
> Just Linux clipboard doesn't know about that little detail, worse, in
> UTF8 locales the characters are still invisible, because they use zero
> terminal cells (wcwidth() returns 0 for ZWSP characters!) you are
> literally screwed over.
> So copy in Windows, paste in Linux, paths will not work, unless you
> paste in the Linux terminal, then select&copy in the terminal the SAME
> path, and then paste it again. That works because it eliminates the
> ZWSP.

Our point is: why not fix copy-paste, then? Please provide rationale
for why this issue should be addressed by piecemeal changes to every
system utility rather than addressing the copy-paste mechanism.

If the issue has already been addressed in many other system utilities
in this way, then please include examples in the patch description.


> BIDI (Bidirectional Text Layout) also uses such markers, depending on
> application. Shitty .NET apps for example.
> 
> Finally, there is CTL, Complex Text Layout, for languages like Hindi
> (just 600 million people speak that as first or second language, so no
> need to care about them).
> Wanna hear what inter-OS clipboard usage does to such paths?


-- 
Chuck Lever

