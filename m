Return-Path: <linux-nfs+bounces-13938-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E77AB3A43E
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 17:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39E217A14F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 15:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C969221FC4;
	Thu, 28 Aug 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z7EM8hj4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QcrjJrzf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8B221F29
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394484; cv=fail; b=IoOukH+Fd7Em3R8kn161fR0X9mJCTThlsL36PUXRmnI2u9svbXurb0R8IsYrfECnkNGnmG+VFXgtrQP8GbF3sofN5vcjLCU2VT31bQ/bichqHVSWoL904jtCRm7xCaT9q6Sphz12DVaqVc2PtKAVsdQIPtwKowyOyACFxAu4ceQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394484; c=relaxed/simple;
	bh=tEV0Ktodm6J6uIYiyK6G6eh0m8OXYY/XJmIBXQM/Cdw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TAgq70ywEh2juRjHTDptwD5ZeVVdmGJKZUQ4VbRK9qpRBACbuSEd/9eu7XctKv/YLV6Kwe+i+V1I7q3AMsVDOKEkAs+wa74UEkHp5lj0iPKm/Mlo2lDcpF5NkgWxB57ztEuvD/AK4RAkGktDTksVjY2NVyguYXnwmPCs3el1SKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z7EM8hj4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QcrjJrzf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SENCMX016319;
	Thu, 28 Aug 2025 15:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r23Exf+0luGqA87haAjiHCwaQ/kw09wJwnYyAqTiypc=; b=
	Z7EM8hj4YtLFbm0rTiqNaFz3nSlep/C4pQuK4haDEAfLrsGWPOX7MRqAvUp2JmH9
	iSub5PRvHIlEDFUTJvkHnLpp0Dih1ahmw8Pt+0XFetDTBjT6c18671jFSEvyTYaF
	2KyfchcZZgXoSjv0Q3gKH+tGiY0u7rzh2c/Gaq+sMNXuNGpGzkvAq0TuuxSAgX3D
	GZvqAyBfTYzb9trlOVPNcUwWn5GbcQTSV1lX8coRDmLb0nLrCJstlJh6pzurrkfe
	V3vUXA9NtL1BcaYPwjS5afsWDVG90z/lfh0G7se9gbAargj9fTjxR1+5owXRGr5t
	fg++cxc9OQ8RJ2RvEqb4hw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t8m3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 15:21:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SDrncZ018928;
	Thu, 28 Aug 2025 15:21:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43c45yd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 15:21:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMPqN23dWLq8bxcqVmJN1aqHQOO3X7toNs4J216icNEYmBq6GNGmzPk9/SNqkoKBkzSEiF1MwS3rlT+qRt9aQfTFemPw/1UUAXJvoxLWRu+4FkbZKRpdOiNoW9NQrkmU9tp31f6d029REMdEM4RppgA/06q6f0LUaysqij/1iywXvh1c8MeC+SDT+N9S7Cl3aMyLAcCNFzXgH6m16fWPxeGKADXkPvIeTFlDRZk6tMaGubpNM9E/UbdxQJelH8AfZsqf8asMmSWZ0XwlhhaPgAzDAfD1e79PeAcxm3sH9tFvgO119Skm7gqXD14MB+nUTicHzwX4Uc2a9h9jJyWbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r23Exf+0luGqA87haAjiHCwaQ/kw09wJwnYyAqTiypc=;
 b=EDHsaLN7NiQ7Qd0Zeh92Tp4jViDYSaCrzbUDrBb627wzTsMFmebgbS64c+rJW9xg8R5gYHeJJoYUrfFmsja003LBb8io8tAE/6bjKr1XqZuwphGd2Xa50F4F56s8WZsRtkp4DNf3pqQjybTotPIIzqrqx7NJZv977nFGZZsWHgGr7VytSFAo+ytLzaIJhBh5F5ephcCcT+C3LGz5tuE0YY/PNCEeSc0gsRyY0/1p+yJaP/O6xw7Pt1hu+g7F/EgY3HODwUDPLWD75BlFuKwGYcJFJXA1xB71CgCsqz5z4HRZG9tQ0VJKxnHgzVA/w7iPDgenPGMn9mXkwgIMmjSrdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r23Exf+0luGqA87haAjiHCwaQ/kw09wJwnYyAqTiypc=;
 b=QcrjJrzfmmqSF11AhID81+axSHKX6wvKoFLc6vyTMdF6mwt0EnGwoXsLS5DQpvrBJkCdbDC5Mloy/axqVvdotUlZAC9weeXyPfyXAmP+00Ut4V10JRxnRgv/6LONA0hEOo1QlmBkjNuBpA8hHDSFt0I4LQa9CCTK5OCJDDwd4xw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Thu, 28 Aug
 2025 15:21:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 15:21:04 +0000
Message-ID: <a641de95-07d3-479d-be64-11d99e56e08b@oracle.com>
Date: Thu, 28 Aug 2025 11:21:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] nfsd: rework how a listener is removed
From: Chuck Lever <chuck.lever@oracle.com>
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, neil@brown.name, Dai.Ngo@oracle.com,
        tom@talpey.com
References: <20250826220001.8235-1-okorniev@redhat.com>
 <41502e2f-0d97-48a3-876f-62c33ae6d657@oracle.com>
Content-Language: en-US
In-Reply-To: <41502e2f-0d97-48a3-876f-62c33ae6d657@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0003.namprd19.prod.outlook.com
 (2603:10b6:610:4d::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 2550d5de-771e-4ef4-0753-08dde6468107
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cGxaQ1c1SU1YemR6ZkppNHV2cDlHNkNOZjRMUEFCckdscExDR3RqZ2NIR080?=
 =?utf-8?B?aC9Zci9yU0N4Y2lsNDVBV0tPSTFVOEpkcUMwdUo0K1lFdVp1OFRmZGZzb2Vj?=
 =?utf-8?B?VlN3ZXB0RnNWSS9xbjBGTTQyWlRYRitVNE1RNHJqR3dVWjcrL3VHY2EwUTRE?=
 =?utf-8?B?YmFyd2I1cDlnbzgzWWNEeUpWTG9DUDB6QTNnd1JVQ1hpaDdIVTFHV0NCOTNI?=
 =?utf-8?B?a01pcllnKy9MdHlHdkhMWUlXN2MxNGRzYzhLS0RNZmVoREFGMk0rbmN6UkJQ?=
 =?utf-8?B?VjNWTDN1OW1DTUNwNnpwTmZzMU1PL2JaSWNhc3Q1UHJ1akduOEFtMEhqLzU3?=
 =?utf-8?B?Y1pwVmRWYm4rZE5MZG5WSlN2VGhxekFqKytua0RWTDVKbXlPbEJVaG9hYVZP?=
 =?utf-8?B?Y3hYTEVkdG5sREFDWDRDSVk1VUFBT3hsQ1M1QWk2RDZwK1hwc0RPYnRrRDRJ?=
 =?utf-8?B?RnlPTm1IckJMNE45ZThEWmp2TkF5K2pvSEJvWHZHYVRQUysvYWFpcjJDOHR0?=
 =?utf-8?B?bEVob1BpaVl3RmVPNGxNTGhrMXM1d3FRMXRiaC9vcHU0QzVmQTdJRjZpZCth?=
 =?utf-8?B?UWYwcjd4ejd0T0I0L1dWN1NHZ1QrcW1qTW5WV01iNEFwNXJiYzhPNk1GcWVD?=
 =?utf-8?B?cXgybklxYmJtczBQZDFkWHNpcmljYTZzUWdaYUZkL3VjTmduMUlKalErSG1Y?=
 =?utf-8?B?cGdlN3VNbVEzU0w3djdES1JCMXdTN1V6ODM0M1l3aStrcHRPbExTd1M1WVVO?=
 =?utf-8?B?TjZiVm5zdkZXcTEzcHVtUmdFdzJ2V3dsNWV0OERmOUk1V0pFY3dzYW5EVEdG?=
 =?utf-8?B?RFNja3c1YTBueTE1blpFbjNrbkl2UFFJM0V4clQzY28xeHhqajVkMzBBS25r?=
 =?utf-8?B?a3llVnZWQ1N5S3BBMFZjdXY1YW1YOEtJTnBJcXcvOStxNXEyTEU2a3UzSHZF?=
 =?utf-8?B?TmFDRDFrT1dkOGZKRVdUNkZxdVQ1VElwVVZHOHp1L3M2RVMyVDA4dzVlajY0?=
 =?utf-8?B?TXlENmpPdUQ4SmJLWGVad0c2ajZKOXo4VVBHK2ErZlIrUEduN1d2YlRxcnZq?=
 =?utf-8?B?WUdMdVNmbzFaNGkzYlhFMGd1VnhnSTQ3cVVjU3ZneEpERStVL3NDYjV1cUlG?=
 =?utf-8?B?N2tBVWxqRnIvNGk4VFVyOTVRalk2K0swSGdCcXlCSUk3UmFQWC96N1gzRnFT?=
 =?utf-8?B?bWVkOWxIZUUrMHlNTDJlT1B4eE12aFFFT3oxNWFYU29uUmpBaWJZZmZ5WW9Z?=
 =?utf-8?B?aUNsbXd0SjFWbHBNUVhQblg4eklLMlJUZTh0STFvSXE4emhSWTZZS1hUZnhW?=
 =?utf-8?B?dzVaWXhDNy82elpFZm1EN0JWUFdNNFRmRTc4MTdFYitEKzZsTWZQRG42dStY?=
 =?utf-8?B?bXRPNEt5cUFZd0I3M24wUE00ZkhFSTZMbzFrSnBoNERGUGJFN1NQemF2cEo5?=
 =?utf-8?B?Z0Vwc0NEUFlDRHQxeTY2VWdrMUZhSXB0NjNWWmd1L3U3MEkvREo3NVQyZEwv?=
 =?utf-8?B?VGhMLzBpakZjbTQrL3U1Z3pURWVqVjFUY3F1WHV4Y1BIK2xNeURqS042UVFW?=
 =?utf-8?B?OUpOcU5RSmdkREtjdWM2c09nOFpvWjY0NkJ2NXhBNTlUSmZkNHlrVDMxWmhS?=
 =?utf-8?B?OWJpRVp0RUp2Y3RxQm8xeVJURU9OVWZ4eUpiUXZFWUxtazFMZHREa0YrVE1n?=
 =?utf-8?B?ejllR1c4Q29SczFUTHFZbXBYMUZENjR1dDBETmpaVGg4emJ2LzNRUlQ2SDRq?=
 =?utf-8?B?TWs3RTgvQk5LM2oxZDhsNWRuZDVGOEhWT0l6bk01RTJDemlrTEI4RFdxa2RQ?=
 =?utf-8?B?VElKUGZBK0ZsNmVTZ1hBT1FYV2IraUo1UEdER0ord3pOU2dMSWVrTzduOWx6?=
 =?utf-8?B?UmMrTm0vb2RlWHpYc245MWV1UEdqVUFxS012Slk0L0Y1WVozajR3eERCZ2lM?=
 =?utf-8?Q?qr+8IZqcKB0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?amIrSVY4SURJSytIYTlQcEZQaXhPanBMRWRPMVFmeVRlU0U3MTNlY1Z2bGpB?=
 =?utf-8?B?enNPTnNPM0JTN2xHM0V6Z2JBa1VnNC84UXZ1Um5ndVY4Y2Qvamx3eUNkTjV6?=
 =?utf-8?B?L3VCL0pIeExMS25ScEhQYXFFRlVZRXQ5UGFKS1ozcHczSWxidnFla3ZDSDYz?=
 =?utf-8?B?bi9PeWpxa0YrSEhoK3NwSHVacGxQT2JZZ2pWdmVXd1JIdzJkMm0xRFU5a25m?=
 =?utf-8?B?MktRMlo1bVVqU0k4NDAxTkw1K0JLM0pkTXpOMFlpS2p0YnRNVEg3cXpkc0tO?=
 =?utf-8?B?T0x6MVV6TllyT3ZFOFFWK3A3dDkxNUV4a2dKWlYwN3YzTlpmRDZZdytWa29Q?=
 =?utf-8?B?NXc5c2pqaHlDb0ZNdHNEczRyVEMvemJ4TU5kZmJUbEduUE5SSkVGMHV1R2lT?=
 =?utf-8?B?aFMzUkRHQ1h3eVQ4T1N3aHU4c1RQS0JsQ3lKZUdZREZDazFwaTJQSWVjUEN3?=
 =?utf-8?B?dmxwZGR2Y1JaTEhDWjBlaDVNOWUzWU1ncGxSRnpTUzJ5V3VFY1RkdnBzWmtH?=
 =?utf-8?B?SmxUQzdqb2UrWGkyZ3IzV1hqZXlRdmdVbE9aUjJCRDgvdEZVOEEvNXoweitp?=
 =?utf-8?B?ZHFBSmF6TnJLOUMwN0dDY3ZFYjhzbVY3U1YzSlgwRjJ3eHFjYTVJNm8rM2tv?=
 =?utf-8?B?SHdKVzU3Zm9JOTZLRS9NRmhNOVVlSWlrWWkxYXJvUGJOVGpYK25OTnlvZndM?=
 =?utf-8?B?M3FWM2dKUFozbzVJSEZoYkVFcit1b2N0MTJhalNyaWw2K0RuZ210cURYcWc0?=
 =?utf-8?B?TnVqeGNoSEdONTVMc2VYM05lQ1JOTUd5aTlzNVpQbE9hamNXQUF6LytvNFIy?=
 =?utf-8?B?dzhRZnA4bEhFSitiVXJnWnFMNHcvV2NyaS9qTC80N1E3bmZKUnVxQUkrTzJM?=
 =?utf-8?B?a0JJMHlwUnFlRXBuZ1kreXhmVVFJcGZpTTdjM0xhKytKUFUxRFRFQkkydWpj?=
 =?utf-8?B?VG1hTU03SUJ3Y1pxYU9wUVlDOEtyOERYWHk4MWdkY3F1ZEJFbE1ZL2sxOE1t?=
 =?utf-8?B?enhJek14Ykg1VENxU3N3L3N6bGNEVUkwOGd6aUthUk5XOXJGSmRHNTZOdVV2?=
 =?utf-8?B?UDY4ZG9CSk5GLzFrRnFMS2ZtS2prT1BIT2QxbjJsRzJpMFdvQXhHUXJ5TTZi?=
 =?utf-8?B?dEc3U09jZzk4ZFFYVnI5cnh2SmNHVWRLaGF0ei9YQ2U4S05TMUFIcDNtNExn?=
 =?utf-8?B?d1lXSFJwRVJZRGQzaEVFRlBjVUNxY2FwdnNpUkwzdXVmN0laYWlYMXJNd1JJ?=
 =?utf-8?B?OUhpa2d1aWt2K3hjc1pkd1JKVDZkNmhVK09MdmM4bHNHMll3RUFrNmlyZVZs?=
 =?utf-8?B?RGMySm1JSWl6TDRTcnduWGxjM29wV3M5RERYZjI2a0QwZlR2eStyZ2NlSUZ2?=
 =?utf-8?B?WDdRVWxBZk00eURreGF4UitobHFyR3V3SlhlVlQvR3gvblJHeDZjTmVtcU5C?=
 =?utf-8?B?S3FWcU1Tdklra0JPb01DbHlNbEN5dDZXcm1nYmhRUmhFOWhrRDE4NVdiSlVD?=
 =?utf-8?B?VjErb1JqOEJRY1Jwa1lieWE1aXRhQkN0ejlET0s2NzhyczIvK2NWRjVRQ0pa?=
 =?utf-8?B?SmFxSC9wTDNudTBxQnEvbm9QUlV0dkFFL3FsM0dBck5sOU00RUc5N3FPRnBF?=
 =?utf-8?B?QWFUK3FJMEdNOXhzRG1UNWJaSzNaSzFJSjZKMFhlZjdXdWxtWVRMcUgzWkxv?=
 =?utf-8?B?R2NjcnpSRDd1bmdENm1SUERWYkZxZTBtdHZRUFFaQVN2b0hWcEpQSWJMcmpN?=
 =?utf-8?B?cnNxUjJ1QmxaNm52Q1ozR2k4SEJQaFNTNTEzdmZRbXg5clEvaCtmVytjM2N3?=
 =?utf-8?B?bE84VXdLLzJsVkp5aTQvUWg5KzR4QUV1MW1xb0hUMWIrYmltcWJsNjZVQjNK?=
 =?utf-8?B?RC9abnZYZk5VWDZnbFFjOUp1aHBsd0hnSkpJYW5pTlRoaWg5WHZyamtBcDBH?=
 =?utf-8?B?Zi90Qjh5VlVmOVVnVHBxdTVGSlFtNHVMRmpRZXY1N2RaRlY2NVNVdkR5aFNl?=
 =?utf-8?B?cy93ZWJXbVN3VGxIVWhJRk1wNURNQ3RRYTd6LzN5N0VVaUFUK25oU3FUY3lr?=
 =?utf-8?B?TGk1NXlFTVdBQi9RWmlqUVE3dDNhY1ZiUk1ORDJlSWFJeFNrV1ZVQ1phS0hm?=
 =?utf-8?Q?5sa4SmWefBx0qCyH/Sd1kgW7V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iI5EjolKc6RgfITMzRL6B8YAgBqpylEB6FH7a6fC25MwMPPDjeqv2VtsMwbA1IFBjJVH53KDVlHY3xUGk7vho/IicXG2cePBPfaLNFDTf+Iejen9FfkIduuh6LCbV7on6dMEc6JpOZKtSBSlhROlHdBBDHHGDNOx1r/tIUsW/7RDN167Fks2NMXILuLzNYjTLGkeWd4jgX0meml99UyyaDOk2IiAdjSDe22liNGy10Ee7JAgiHMbK+GsHVEmta1hSAwlFDsu5b5KIYCl9abUsJtZzKYvOawNrBV/5nYIDlzCmvfYNbWQ3I/EJ9XQ4ZK1ooNwwg/3+ntXy2olrs0Q+lEHqxhEe5hOuWNKBGNNUZVBbhtn21JQzJ2O905Ey0rYexFboHx4Q4adsLI4hw68VeDncxnOlLyfs0XmP7Lt39y95+rt7+FpJpn6lJBsu5ZYqpG10s8RwXJC1rPQDpkijOUeeUGOz2JkRvKUPzdFtcKY2+OCOcb1447OgpA++SwXaxYKtbbiLzgI6WaNukxYnr8lgRpvwtwi0frfUmcRp3yAzSn7oO2S/2oldO0u1KfejLomNiQZ/LrwVIRT22o+o4S9TA2yngMQsSmOYVbXR7w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2550d5de-771e-4ef4-0753-08dde6468107
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:21:04.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5qH+xjQmfdKdSt+vt/uwtE8YEe2qciJOjRhNr6Ws/jwmAZeyD7J73pw1aLYJwJn2rn7/dEEoGwh+nuqk/Q9IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX/+9dIP5mGJnz
 S/M0MIzpG+KjB1uEDSE7NbLiKXPM7hgFYQbPAQ0vaZVJpnXcg1HZbLtB1CiqJ5ksVy6VIXmcXZK
 XrUmqE94YZPieT0A7z/b854KezWfO+Pgv5GB3xr4XbH7//7FAP01J5nEcKKPHs0w7AkK+WPM40r
 1VcC97goZP5E9sUEou2Cpjq+fqHTWLnZgKTVKtDiiTjd1yTO0SfQOl/qG+og5amHL6ByIvOAgfz
 9mQaPnItTsqLv8UQVzae1JMRLjhOgesGUA6B1WXFC0Y8a5TN2SEOT9+0UEeorUUDSV+Q5PZkJ5f
 OKKsjdlsFnA/i7suqH1jk5n3kykCvnPaJBF96NtkrZIs/QsPrnQW90bznlsZaE2HYmlIOwzoFPb
 gbZ6nx6q
X-Proofpoint-ORIG-GUID: sjIky1jdizLyj3Ie0jvpDX5s2_KKXU7N
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68b073ec cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=MomtVotaO44DR0gGqecA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sjIky1jdizLyj3Ie0jvpDX5s2_KKXU7N

On 8/27/25 10:21 AM, Chuck Lever wrote:
> On 8/26/25 6:00 PM, Olga Kornievskaia wrote:
>> This patch tries to address the following failure:
>> nfsdctl threads 0
>> nfsdctl listener +rdma::20049
>> nfsdctl listener +tcp::2049
>> nfsdctl listener -tcp::2049
>> nfsdctl: Error: Cannot assign requested address
>>
>> The reason for the failure is due to the fact that socket cleanup only
>> happens in __svc_rdma_free() which is a deferred work triggers when an
>> rdma transport is destroyed. To remove a listener nfsdctl is forced to
>> first remove all transports via svc_xprt_destroy_all() and then re-add
>> the ones that are left. Due to the fact that there isn't a way to
>> delete a particular entry from server's lwq sp_xprts that stores
>> transports. Going back to the deferred work done in __svc_rdma_free(),
>> the work might not get to run before nfsd_nl_listener_set_doit() creates
>> the new transports. As a result, it finds that something is still
>> listening of the rdma port and rdma_bind_addr() fails.
>>
>> Instead of using svc_xprt_destroy_all() to manipulate the sp_xprt,
>> instead introduce a function that just dequeues all transports. Then,
>> we add non-removed transports back to the list.
>>
>> Still not allowing to remove a listener while the server is active.
>>
>> We need to make several passes over the list of existing/new list
>> entries. On the first pass we determined if any of the entries need
>> to be removed. If so, we then check if the server has no active
>> threads. Then we dequeue all the transports and then go over the
>> list and recreate both permsocks list and sp_xprts lists. Then,
>> for the deleted transports, the transport is closed.
> 
>> --- Comments:
>> (1) There is still a restriction on removing an active listener as
>> I dont know how to handle if the transport to be remove is currently
>> serving a request (it won't be on the sp_xprt list I believe?).
> 
> This is a good reason why just setting a bit in the xprt and waiting for
> the close to complete is probably a better strategy than draining and
> refilling the permsock list.
> 
> The idea of setting XPT_CLOSE and enqueuing the transport ... you know,
> like this:
> 
>  151 /**
> 
>  152  * svc_xprt_deferred_close - Close a transport
> 
>  153  * @xprt: transport instance
> 
>  154  *
> 
>  155  * Used in contexts that need to defer the work of shutting down
> 
>  156  * the transport to an nfsd thread.
> 
>  157  */
> 
>  158 void svc_xprt_deferred_close(struct svc_xprt *xprt)
> 
>  159 {
> 
>  160         trace_svc_xprt_close(xprt);
> 
>  161         if (!test_and_set_bit(XPT_CLOSE, &xprt->xpt_flags))
> 
>  162                 svc_xprt_enqueue(xprt);
> 
>  163 }
> 
>  164 EXPORT_SYMBOL_GPL(svc_xprt_deferred_close);
> 
> I expect that eventually the xprt will show up to svc_handle_xprt() and
> get deleted there. But you might still need some serialization with
>   ->xpo_accept ?

It occurred to me why the deferred close mechanism doesn't work: it
relies on having an nfsd thread to pick up the deferred work.

If listener removal requires all nfsd threads to be terminated, there
is no thread to pick up the xprt and close it.


>> In general, I'm unsure if there are other things I'm not considering.
>> (2) I'm questioning if in svc_xprt_dequeue_all() it is correct. I
>> used svc_cleanup_up_xprts() as the example.
>>> Fixes: d093c90892607 ("nfsd: fix management of listener transports")
>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>> ---
>>  fs/nfsd/nfsctl.c                | 123 +++++++++++++++++++-------------
>>  include/linux/sunrpc/svc_xprt.h |   1 +
>>  include/linux/sunrpc/svcsock.h  |   1 -
>>  net/sunrpc/svc_xprt.c           |  12 ++++
>>  4 files changed, 88 insertions(+), 49 deletions(-)
>>
>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>> index dd3267b4c203..38aaaef4734e 100644
>> --- a/fs/nfsd/nfsctl.c
>> +++ b/fs/nfsd/nfsctl.c
>> @@ -1902,44 +1902,17 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
>>  	return err;
>>  }
>>  
>> -/**
>> - * nfsd_nl_listener_set_doit - set the nfs running sockets
>> - * @skb: reply buffer
>> - * @info: netlink metadata and command arguments
>> - *
>> - * Return 0 on success or a negative errno.
>> - */
>> -int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>> +static void _nfsd_walk_listeners(struct genl_info *info, struct svc_serv *serv,
>> +				 struct list_head *permsocks, int modify_xprt)
> 
> So this function looks for the one listener we need to remove.
> 
> Should removing a listener also close down all active temporary sockets
> for the service, or should it kill only the ones that were established
> via the listener being removed, or should it leave all active temporary
> sockets in place?
> 
> Perhaps this is why /all/ permanent and temporary sockets are currently
> being removed. Once the target listener is gone, clients can't
> re-establish new connections, and the service is effectively ready to
> be shut down cleanly.
> 
> 
>>  {
>>  	struct net *net = genl_info_net(info);
>> -	struct svc_xprt *xprt, *tmp;
>>  	const struct nlattr *attr;
>> -	struct svc_serv *serv;
>> -	LIST_HEAD(permsocks);
>> -	struct nfsd_net *nn;
>> -	bool delete = false;
>> -	int err, rem;
>> -
>> -	mutex_lock(&nfsd_mutex);
>> -
>> -	err = nfsd_create_serv(net);
>> -	if (err) {
>> -		mutex_unlock(&nfsd_mutex);
>> -		return err;
>> -	}
>> -
>> -	nn = net_generic(net, nfsd_net_id);
>> -	serv = nn->nfsd_serv;
>> -
>> -	spin_lock_bh(&serv->sv_lock);
>> +	struct svc_xprt *xprt, *tmp;
>> +	int rem;
>>  
>> -	/* Move all of the old listener sockets to a temp list */
>> -	list_splice_init(&serv->sv_permsocks, &permsocks);
>> +	if (modify_xprt)
>> +		svc_xprt_dequeue_all(serv);
>>  
>> -	/*
>> -	 * Walk the list of server_socks from userland and move any that match
>> -	 * back to sv_permsocks
>> -	 */
>>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>>  		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
>>  		const char *xcl_name;
>> @@ -1962,7 +1935,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>  		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
>>  
>>  		/* Put back any matching sockets */
>> -		list_for_each_entry_safe(xprt, tmp, &permsocks, xpt_list) {
>> +		list_for_each_entry_safe(xprt, tmp, permsocks, xpt_list) {
>>  			/* This shouldn't be possible */
>>  			if (WARN_ON_ONCE(xprt->xpt_net != net)) {
>>  				list_move(&xprt->xpt_list, &serv->sv_permsocks);
>> @@ -1971,35 +1944,89 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>>  
>>  			/* If everything matches, put it back */
>>  			if (!strcmp(xprt->xpt_class->xcl_name, xcl_name) &&
>> -			    rpc_cmp_addr_port(sa, (struct sockaddr *)&xprt->xpt_local)) {
>> +			    rpc_cmp_addr_port(sa,
>> +				    (struct sockaddr *)&xprt->xpt_local)) {
>>  				list_move(&xprt->xpt_list, &serv->sv_permsocks);
>> +				if (modify_xprt)
>> +					svc_xprt_enqueue(xprt);
>>  				break;
>>  			}
>>  		}
>>  	}
>> +}
>> +
>> +/**
>> + * nfsd_nl_listener_set_doit - set the nfs running sockets
>> + * @skb: reply buffer
>> + * @info: netlink metadata and command arguments
>> + *
>> + * Return 0 on success or a negative errno.
>> + */
>> +int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	struct net *net = genl_info_net(info);
>> +	struct svc_xprt *xprt;
>> +	const struct nlattr *attr;
>> +	struct svc_serv *serv;
>> +	LIST_HEAD(permsocks);
>> +	struct nfsd_net *nn;
>> +	bool delete = false;
>> +	int err, rem;
>> +
>> +	mutex_lock(&nfsd_mutex);
>> +
>> +	err = nfsd_create_serv(net);
>> +	if (err) {
>> +		mutex_unlock(&nfsd_mutex);
>> +		return err;
>> +	}
>> +
>> +	nn = net_generic(net, nfsd_net_id);
>> +	serv = nn->nfsd_serv;
>> +
>> +	spin_lock_bh(&serv->sv_lock);
>> +
>> +	/* Move all of the old listener sockets to a temp list */
>> +	list_splice_init(&serv->sv_permsocks, &permsocks);
>>  
>>  	/*
>> -	 * If there are listener transports remaining on the permsocks list,
>> -	 * it means we were asked to remove a listener.
>> +	 * Walk the list of server_socks from userland and move any that match
>> +	 * back to sv_permsocks. Determine if anything needs to be removed so
>> +	 * don't manipulate sp_xprts list.
>>  	 */
>> -	if (!list_empty(&permsocks)) {
>> -		list_splice_init(&permsocks, &serv->sv_permsocks);
>> -		delete = true;
>> -	}
>> -	spin_unlock_bh(&serv->sv_lock);
>> +	_nfsd_walk_listeners(info, serv, &permsocks, false);
>>  
>> -	/* Do not remove listeners while there are active threads. */
>> -	if (serv->sv_nrthreads) {
>> +	/* For now, no removing old sockets while server is running */
>> +	if (serv->sv_nrthreads && !list_empty(&permsocks)) {
>> +		list_splice_init(&permsocks, &serv->sv_permsocks);
>> +		spin_unlock_bh(&serv->sv_lock);
>>  		err = -EBUSY;
>>  		goto out_unlock_mtx;
>>  	}
>>  
>>  	/*
>> -	 * Since we can't delete an arbitrary llist entry, destroy the
>> -	 * remaining listeners and recreate the list.
>> +	 * If there are listener transports remaining on the permsocks list,
>> +	 * it means we were asked to remove a listener. Walk the list again,
>> +	 * but this time also manage the sp_xprts but first removing all of
>> +	 * them and only adding back the ones not being deleted. Then close
>> +	 * the ones left on the list.
>>  	 */
>> -	if (delete)
>> -		svc_xprt_destroy_all(serv, net, false);
>> +	if (!list_empty(&permsocks)) {
>> +		list_splice_init(&permsocks, &serv->sv_permsocks);
>> +		list_splice_init(&serv->sv_permsocks, &permsocks);
>> +		_nfsd_walk_listeners(info, serv, &permsocks, true);
>> +		while (!list_empty(&permsocks)) {
>> +			xprt = list_first_entry(&permsocks, struct svc_xprt, xpt_list);
>> +			clear_bit(XPT_BUSY, &xprt->xpt_flags);
>> +			set_bit(XPT_CLOSE, &xprt->xpt_flags);
>> +			spin_unlock_bh(&serv->sv_lock);
>> +			svc_xprt_close(xprt);
>> +			spin_lock_bh(&serv->sv_lock);
>> +		}
>> +		spin_unlock_bh(&serv->sv_lock);
>> +		goto out_unlock_mtx;
>> +	}
>> +	spin_unlock_bh(&serv->sv_lock);
>>  
>>  	/* walk list of addrs again, open any that still don't exist */
>>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
>> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
>> index da2a2531e110..7038fd8ef20a 100644
>> --- a/include/linux/sunrpc/svc_xprt.h
>> +++ b/include/linux/sunrpc/svc_xprt.h
>> @@ -186,6 +186,7 @@ int	svc_xprt_names(struct svc_serv *serv, char *buf, const int buflen);
>>  void	svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *xprt);
>>  void	svc_age_temp_xprts_now(struct svc_serv *, struct sockaddr *);
>>  void	svc_xprt_deferred_close(struct svc_xprt *xprt);
>> +void	svc_xprt_dequeue_all(struct svc_serv *serv);
>>  
>>  static inline void svc_xprt_get(struct svc_xprt *xprt)
>>  {
>> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
>> index 963bbe251e52..4c1be01afdb7 100644
>> --- a/include/linux/sunrpc/svcsock.h
>> +++ b/include/linux/sunrpc/svcsock.h
>> @@ -65,7 +65,6 @@ int		svc_addsock(struct svc_serv *serv, struct net *net,
>>  			    const struct cred *cred);
>>  void		svc_init_xprt_sock(void);
>>  void		svc_cleanup_xprt_sock(void);
>> -
>>  /*
>>   * svc_makesock socket characteristics
>>   */
>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>> index 6973184ff667..2aa46b9468d4 100644
>> --- a/net/sunrpc/svc_xprt.c
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -890,6 +890,18 @@ void svc_recv(struct svc_rqst *rqstp)
>>  }
>>  EXPORT_SYMBOL_GPL(svc_recv);
>>  
>> +void svc_xprt_dequeue_all(struct svc_serv *serv)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < serv->sv_nrpools; i++) {
>> +		struct svc_pool *pool = &serv->sv_pools[i];
>> +
>> +		lwq_dequeue_all(&pool->sp_xprts);
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(svc_xprt_dequeue_all);
>> +
>>  /**
>>   * svc_send - Return reply to client
>>   * @rqstp: RPC transaction context
> 
> 


-- 
Chuck Lever

