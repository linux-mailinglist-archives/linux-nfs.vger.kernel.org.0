Return-Path: <linux-nfs+bounces-9385-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C28A16290
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Jan 2025 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33047A2464
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Jan 2025 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E948B54723;
	Sun, 19 Jan 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BEOwiEbF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z1PHuYCd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940D19BA6;
	Sun, 19 Jan 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737299974; cv=fail; b=AK8sfJ16g23vD/aUdVE8/TrrlhzxhyXBVrVSlAKi9gl8Pz2bocwMblpqj34totYv5b+1asZYTjywF6QmjAxY5WmhZVippQU1PahFeXvi2eX4xMGWxhSLudN5ngmQggCxw/+DMakCfMhrtemKBoNyoSJR9LTAId6smCny46cMJAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737299974; c=relaxed/simple;
	bh=MlD0kjBTq3MMRxmWFefJbcDE6KARCcQ4xBRE87woQqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UNPl0Vua9Dhj9HV3enjuwqMgSI9Fs2dGtTUy9dlTtRG8oChfvWqJIANTJ6kWqf71V+vthmnWzOyRwsn7BbWY90QryKv/GaIDScDMrhFhNQpzi9hIgyIVzV3JkyjCB6RDfEvDADyuFJ7ozz9CabB4wrWbR1eV2I67njEggr5eY9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BEOwiEbF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z1PHuYCd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50J7bTJ8010528;
	Sun, 19 Jan 2025 15:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ihI/Eq8Hav37ED0x1GIZpsgTWH2LQB1a8WoWLdVOmt0=; b=
	BEOwiEbFxGFzLG70v6QXd7Kket1tcdATF5HJTgeoWQhzOMwbMG5s+U3Y6u5+eSmT
	znG0BTBv1n2iHiUJBWHEIjp5DnVXtyBWi7QaC4evtf9SBY4J/K6y/nwIPepfB1mv
	kEVMggSqFHKWJGrX8lxzEEkfrtPMcOlkgp3aZiI6PqS741xyzqHh23e/8nGJxBNY
	xOV3jUqUcxxT5JrIXpOSSKTrPBjzKaKzzgGpQ+iHdBdvsq+9MoP1Jc91HzRcZd9O
	7Ii58dIa2mPDzLHGgOKj0v0H0/CaS7H0rrvvAZI9E5JaIn24/ml2iv1Sk3NdhHmR
	sXTAblxX2x5/Lr15RAkWoQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsaahw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jan 2025 15:19:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50JCHCx4030442;
	Sun, 19 Jan 2025 15:19:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 449190jd6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jan 2025 15:19:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnkGl5qIDcR3u4fLQKoivS++5vYxBjmT7mvvag5TNDEb9WPxC8PYHM4lteweuWZp5koStf1M8vyqo0112hy+BBVuZ3D19PlYF6HkL8mnIN69tdqePysnZi5Uz1+Y8VU03+Jhk8OYhcckdx+QMaZ5GwBGERKhJkJuT3KYjhtJCgg/0GQ71qPRlvx9drMAOHZwqVB1I/UFEn/x9JtsItm0V7+mj2ICH36+4tWhcI0ge3ctXoPuCFTwrJ3pob567cfKb0j8RUn3PU9WCf5JmSyXke2HC+dHs8uPK5JQTHYLg7tAWK5VQEIA6MX31NacsYvj9o3TYsyt/8N6eb7SLA6svQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihI/Eq8Hav37ED0x1GIZpsgTWH2LQB1a8WoWLdVOmt0=;
 b=I7rIOzhhIEXvR86thvL6p9NhN4DEcJFoh44VFwx5YFlqPi4dDW8J+i+rP1eDmQTbARM5ZpvmWk38lr7590Z3foFz4RK7OtN0ovczJ79OnGLxv0QavKtEr1QGqAy9OPIWdvO4HHPjDYQKf6lDUn28TOICRZSnbUVzXTjkKOu3/wHA+Z6JftPRmMdFn8hw67JRdDBwwuNBWHlJiBxhd9MTqImFB1XO7jLmutfbJYytHlDiAoVK5BXnTb9d4oXdsLHCmg7+l+OjW/mJBmCItlBJimQvttv1VIsPkobRZQxdvM7Ah0Xdb01uESagwbOmydz1ESRh2GuRtUVxFA7/oShBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihI/Eq8Hav37ED0x1GIZpsgTWH2LQB1a8WoWLdVOmt0=;
 b=Z1PHuYCdbCXf3EoH2/TqqPKKUlt44PVWK9f03b3rpKRzXpeUQuEi/PYYbBCGtCfz42c1mojc1A7PFfvihyqZo+2NBzJZGEuNs9Wean/LaomZDjhVmHaRsmiINlS5Pga7zMKunUrpjJ+IH1/v00//1nzDvDmuGWZieT9HJIECt1I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4268.namprd10.prod.outlook.com (2603:10b6:5:220::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.19; Sun, 19 Jan
 2025 15:19:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.017; Sun, 19 Jan 2025
 15:19:06 +0000
Message-ID: <83aad379-81fb-4e11-a462-e02fd536fda2@oracle.com>
Date: Sun, 19 Jan 2025 10:19:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] nfsd: fix handling of delegated change attr in
 CB_GETATTR
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Olga Kornievskaia <okorniev@redhat.com>, Neil Brown <neilb@suse.de>
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
 <20241209-delstid-v5-1-42308228f692@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241209-delstid-v5-1-42308228f692@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:610:b0::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 0593f715-ab93-4c1b-b502-08dd389c9d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkF1Vk80YUN6aHdDRWFUZnJDN2lUcitXSzZkem0rRGUzNlFxdFhNcU1IZFFo?=
 =?utf-8?B?VXgySmt4TWtUbFRYdDg5SXpIODd6NFJMUlVudE9TVEg1Zzk2WGZtV1BrdzdU?=
 =?utf-8?B?bmNZbjZ4ZFlSdE52c0pKVUE0QTcxNFpkejNnTi9JRkdvZGgyN3p4ZU9WRXhr?=
 =?utf-8?B?ZkRhYWtkMWhoVEF1TG8xb1pIWCtTenhkU1Uwb2luT3dLMUhZUEtkNjZQMFRK?=
 =?utf-8?B?RHJJWkxCKzA5SEs0QXFnUmkxL3d5L0dqaCtGRTFNMEs0SU5QTStKK2w5NTlq?=
 =?utf-8?B?cGtuUk9yZVFIeUVIV3pOeGp0aTl3S0FwejZWUXhIYXc1R21tYWYyc05CeUtl?=
 =?utf-8?B?S003UGdPT0Y2UHpBbmF5aXlFcElIVmd5NmJTMXcrS1ZvMk8wc1NER3RYUFpL?=
 =?utf-8?B?VFF1OS9sNlFlZk5lYi9JYlNFSW5abGZndG9TMnVsemdvTm4rdXFwRy9iQW1H?=
 =?utf-8?B?Tk5OYTJ3SUdFT0ZySjVCalpONDhOelRnYjJpUVFFcWYxdzVjdXBjZkxuWXNW?=
 =?utf-8?B?dDRBbVVlUUVJeUtxUzE3elZ3b2MzeHhmR0xvdUZlOS9JWjlJdC9rSVlrdmV5?=
 =?utf-8?B?UTNrKzk4VUtBT203UktlMER3aFh6VGNuQ1FaV0tXdk1Lb2JCWVoyTVowYVhM?=
 =?utf-8?B?K0xESURiQ2tJbG1RaVh1TWI2OXFIOGNISzdrdWZ1bzFjM3ZlNWkxRE9BWmEv?=
 =?utf-8?B?b283SzJ5dWhEUXNETHk2VXdQVFZkR1AxK053Z2ZLVHR5UW1SRXFrLzhLWTlD?=
 =?utf-8?B?bXFvSlhNaHprdkU5NGlLeVM0MXlzWHB3cjVoOU9Panc5WDVqUkhEREFPZ1Zs?=
 =?utf-8?B?d2tVbjVvYjdXTlJ3NHVocXlFbHpEWWUrR0FpYlh6cFpFc1AwZWM4b1lWQ0pD?=
 =?utf-8?B?dzZ5SVBNTzFmRCtJS2NMeGNTYXY5YlZzZ0pqeEJhaE9VMHlGRTh0eE1OQ1Bk?=
 =?utf-8?B?aXdjaHFYbDI4K3pKRGQ2dzk0NzQ3SThJV3htcDRQVTQwZTcyc2dVVUYwWkZP?=
 =?utf-8?B?UkZFTjBWU0ZLTUFkM01Pa1VTRUFPYlBJdmxMcEM2cFMzczdIZ2JtZjQ4Q0xp?=
 =?utf-8?B?YkxjR1pVNzdxZjRhbFdhVlFWS0dhSXp2SHFYYUNhQUZOa2FhUGRNWnQ2aENu?=
 =?utf-8?B?d2FyNDVWTTZNS1VoMi9nbmRIZHliT1dLeTJCcVMyQWU3NUhNQUVDSTlKNktB?=
 =?utf-8?B?TjR3K1YxVUJqTzVpaERXVWVzN2hrYVlpWE9uT3g2SXFrRkFpL2p6LysxL01W?=
 =?utf-8?B?ZkxLcHpvWDBiTURuTTcxUUJUOCtrbjhVQnJoa0N6TVVZemhpYk9Jcmo4MGE4?=
 =?utf-8?B?TmJvUTRHVHdJTUVlakxxS0ZwQWQ1K0x3S21lQTJUWFFJKy9QaWFJaWg3U2lm?=
 =?utf-8?B?TUZFTUs4c2txSDNMZnNqb3VFU1M2VDllRlpXVllTSThqZnVUQytmaTNlaDBi?=
 =?utf-8?B?ck1UMktlRUpqSllEZTg3d2JkMW5hRFE1bFdrT2lrMUJuWU00RnhoNU0zUjBW?=
 =?utf-8?B?OWp3dzhQYkROWlFkczFVdWIvaXJhTGhOdGUrYmRQUmliLzhKbFBBNi9veEZO?=
 =?utf-8?B?MGE2NFZ5V2xTbUxBWDcxVmNabFVTZlExNlZuRzZiR3lYM2hFSDhhT2oybUEr?=
 =?utf-8?B?QnByU0d6WWE0Sy93TkJpQXYwZWEwRnVHMStSUmM4c2F2SHZzb2Q5bTR0Zm16?=
 =?utf-8?B?UUdWQVZTcEJnc2lPQW9ZSnh1WWZLN2VLRFd6VW1hc0x0UDNJSjFkNnByOHFS?=
 =?utf-8?B?NTNZem1LSmtmK0g5Rkw3d2ZyUnNEUWhXdnl5c3lvVkR6L3cyMHcwclIrWVdM?=
 =?utf-8?B?cEtlTk5DSmRZYjArVHg2ZlVVREdhL2JvY1lobjVUU0JwZk1XY0pKQVRSSlhm?=
 =?utf-8?Q?pHQjqW4hUTqSm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VktNRGplYmNkTDdBWHJvUDlBdUpNd21CZ0dsRFd1NGxrb3JyUHd2Y0V0YXBB?=
 =?utf-8?B?RkF3QVgweGw0MzIzVEZ4UGdWZ1cxdllQM01WZk0wUEs0b3FVT0lTU211cm9a?=
 =?utf-8?B?VXVtYXQ2OWllQmlCcEJ3clJsWTFVdkpHOXNyMnk2V0ViWURBcTBWejFjdzdh?=
 =?utf-8?B?Mll1RHpsMGdoQ0tkUGVCNlFMMnNFcmNFWFl6c2xTamNVMUtlMEUwRVlXTlBM?=
 =?utf-8?B?SlMrM1BMV2Fhd1ZOUWdYMEEweko3cjFGeWJEYjNYSE1UVzB3SkdYZ1JDLzU3?=
 =?utf-8?B?TFRBTnNYOFBSWG5aYTZVMG1LOW0vdjNvSzNmS1gxaGxac1c3TjZaZ0I1SnFv?=
 =?utf-8?B?aEw1MkVTZjBuSm5qOHZvYmcwditUV3V5eTlrb2hqYURGbnF4cTFxWTkyVyt6?=
 =?utf-8?B?SXJ3TUY5MENHV1ZhK0ZocmN5c2xxRk1yeG9USWNYL0ViRTJxQ056RGp2TnBp?=
 =?utf-8?B?Z2hmTEtLYTZsaGNLa0tUZEtQdXFLS0Y2eGYwVFEyb0hPSUwycUhmaXRvb21S?=
 =?utf-8?B?c09zUGJxQXdwUk5vVHpaZ2tpMWtFdjBYeGM1WVhRL05UYVBsaGNrUS81ODVo?=
 =?utf-8?B?Z1d1NndmSlA2NlZVK0JYNkhJRGxkYWx3bnRSN25nYThXeERKRUtyMzR6SVQx?=
 =?utf-8?B?SkpvR0tVSkFmclQxbGJTTWpCOG1xMTNuS0pjODY0RFV6ODlibmQ1bGR4ZnFX?=
 =?utf-8?B?N0gxMndnbkdFY2ZNUjBXVTVxSWpCU3hyRUl3NWp2NHhrekhBM3k3ZDJaOWRt?=
 =?utf-8?B?a1hNd1YzZU9PV0hqTmJ2SExtM1o3TWplbEd2SGFxV1ZMK2NQaGh3RGdOQ0RM?=
 =?utf-8?B?d21Fb2dQRFkralhpMlE1VEw1elFMV1ozWk5yZ2YvbUZEMTJxZ1gyL0MzWmtW?=
 =?utf-8?B?dzNtRTk2SE8zZTdGRWZucWdmV0tLaFNlcWRJWloyMWtEMzBUMkVwRC9VK21E?=
 =?utf-8?B?MFNVU0IzSEtUelB4Z29pcFptYlpKc2I2ejZCVXdKUnZyUmE2aUxkc1ZBTGhr?=
 =?utf-8?B?TGlydHhUUE1ZSHNZaWs3Zlh5dHk2N2hIRGxUaGpmZysxa3N4ZmhFUktGRWp5?=
 =?utf-8?B?QVI3RmNYVUFYalFIOTBOeTJwUWd0eE9ySm9KaDhJNHBUY0QzS2ZldzVMOHFn?=
 =?utf-8?B?a2VIb3VhWER0a3h6NEJtaWhmRHdkQ3dDbTNlQ3ozbEdoWXo3c2wwNG03ZjRM?=
 =?utf-8?B?M2pqNisxbVNkQzJxWFRVTVZISnp5cGFuL2kzb3lhOHE2MnJvNlFFODFtUXV1?=
 =?utf-8?B?bXJtQUdxM1ZNSEtIbVBaMEtOVGFxNkxaRTlad2UrQXp2T3VmK1hUM0FkZVor?=
 =?utf-8?B?dmVJK05lMDM4UDFwWUJsWjVTZ1FsUWxOTFVGWlVaUzd0andnTjE5WWtmb1o0?=
 =?utf-8?B?MjFJN0VGeHR5UFpNeXErMm0rZC9YU0ttZ0ZsOUQzNTg4NE1DK2FFTHZiNGxq?=
 =?utf-8?B?cEFJTkRLalYyNnk4b3VBc1BqOUF1OWNwNkxWZ0ZOdXhYQmpCOEVBaGZ5THZl?=
 =?utf-8?B?bDFwNDVpVWRDUk5IRzBuTDMyTXhmVFgrQS8vN2tyamVUaUJIVVJoT1c1Wnhw?=
 =?utf-8?B?RGNBM202eVdablFubHUyVEJwQ1V4cUJWeE4yaHp2Y1JNWnFJdXNaQzQ2bXJX?=
 =?utf-8?B?K3FtMldMYldXdW1iYWsrZURORlkvcDg1bERqQkF3cXRVMlNaSXdtbks5UDBH?=
 =?utf-8?B?R2FPWkQ1TGV2RFd0TWxreEkraHJzeGt3TExzYXN0NmhjV0kzSE5PalJNcHlv?=
 =?utf-8?B?TWUxcnY3bHBZbTF0bjFxdHhQbk13NjI0dEtoREYxamRwUzh6SzJjMSs3Qytm?=
 =?utf-8?B?aW0xMVpxT3hWTTN2Q3VudGZHYlljempzT3BmYjl3cmMxSGJxdm1iRnpWbVA5?=
 =?utf-8?B?WmdPTVBMNFppOGNseGxhV2FEcTU5R2NSVTdwTGp3Y3hyckJxTUlhSHBSV1h6?=
 =?utf-8?B?T28wbXZqYlNnYS9WbWh5T0svamJGTTlqZWUxbHBvS3VyaTZmVFQ5ZWFYRGRx?=
 =?utf-8?B?SlJwSFQ0UGhFNjY5TzF5TVJ6bGFKR2E4cnc3aGJjM2NrSXJjdTloTmF6MlA5?=
 =?utf-8?B?NDhEV1Nnc1lpTmhTUEdWTWw1LzJkTkxYOW5WZks0UnpKMTBGNUdKRWpSOHlI?=
 =?utf-8?Q?Mr+f7CWdZLozwiY7h9uT9w3fn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lJI93dGs9QQxFeVdMM8rrIOzo5XK8aHOUqgFimNgPAuT5/j4xkGVGfElUKmXWHH5zUgT1Ybcuy0VEuc+x87PddRhFQ5j+FRLfJfbM8avoK3wqHmuyxR91iqrvy1FzGHV7mOOOztJ0soucSFfDBzyioJrerC7KAUpJlpSTSQZIa+7UpOZ8ifWE56x8ZV1bsItToWlFwCVD4+xVzQltG1pCXkt0EWhzdExQpBMW+Q6Vk0cVYANFrBIGm19bK0YA/ETVvfVfHnc8XdYro5OxTvjiSpKWG/U3D8/xKUU+7E342WTWfDpK54+qDfuCh9z3w2Btf1C6SiNI/iJarrNBjB6jxuwVuoLYgLv5Epr2NYSSvzYqccW7QPkMi/pYsBhlQQy+dinXAhNER7mA2P5yvWO9p4AkxUz8LArxOA7GBSKZTDtxWkV6of3AZCGZvb3efZeIeNuO+gUCngit6TG/MZxGIt7ybbRHXzYUHRBBL3Vno3yGSZeoTfGQJBj9Q62CDO32mf1m/dWntdvnA+LRgeUCShhCUpIa5DBZ1BsmVAzDXtbiWY0w1xZU9QFkfjxNnsd+lVrs7H4MYW+XOPUNy/eEeAzUtFrsSeC1tOGPdYXa40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0593f715-ab93-4c1b-b502-08dd389c9d74
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 15:19:06.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9Sal04gKX+kA9QE6D65LaYtTF4glWTSNpYCFqDcgqIvVea3H+6o/xSQTG3rcjptyfWiy174tqAr58xnWM1LSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-19_02,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501190118
X-Proofpoint-GUID: SdafXjTET6IdbpwEc3ztxDU6slfXZ1_i
X-Proofpoint-ORIG-GUID: SdafXjTET6IdbpwEc3ztxDU6slfXZ1_i

On 12/9/24 4:13 PM, Jeff Layton wrote:
> RFC8881, section 10.4.3 has some specific guidance as to how the
> delegated change attribute should be handled. We currently don't follow
> that guidance properly.
> 
> In particular, when the file is modified, the server always reports the
> initial change attribute + 1. Section 10.4.3 however indicates that it
> should be incremented on every GETATTR request from other clients.
> 
> Only request the change attribute until the file has been modified. If
> there is an outstanding delegation, then increment the cached change
> attribute on every GETATTR.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

After review of LTS backport instructions in the candidate patches for
v6.14, this commit stuck out. Should it have a Fixes: or Cc: stable ?

How about

   Fixes: 6487a13b5c6b ("NFSD: add support for CB_GETATTR callback") ??


> ---
>   fs/nfsd/nfs4callback.c |  8 +++++---
>   fs/nfsd/nfs4xdr.c      | 15 +++++++++------
>   2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 3877b53e429fd89899d7dc35086bee8bda6eed07..25acb8624b854f5d0d184efec660e1f72cad8885 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -361,12 +361,14 @@ static void
>   encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
>   			struct nfs4_cb_fattr *fattr)
>   {
> -	struct nfs4_delegation *dp =
> -		container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
> +	struct nfs4_delegation *dp = container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
>   	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
> +	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
>   	u32 bmap[1];
>   
> -	bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
> +	bmap[0] = FATTR4_WORD0_SIZE;
> +	if (!ncf->ncf_file_modified)
> +		bmap[0] |= FATTR4_WORD0_CHANGE;
>   
>   	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
>   	encode_nfs_fh4(xdr, fh);
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 53fac037611c05ff8ba2618f9e324a9cb54c3890..c8e8d3f0dff4bb5288186369aad821906e684db7 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2919,6 +2919,7 @@ struct nfsd4_fattr_args {
>   	struct kstat		stat;
>   	struct kstatfs		statfs;
>   	struct nfs4_acl		*acl;
> +	u64			change_attr;
>   #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>   	void			*context;
>   	int			contextlen;
> @@ -3018,7 +3019,6 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
>   					 const struct nfsd4_fattr_args *args)
>   {
>   	const struct svc_export *exp = args->exp;
> -	u64 c;
>   
>   	if (unlikely(exp->ex_flags & NFSEXP_V4ROOT)) {
>   		u32 flush_time = convert_to_wallclock(exp->cd->flush_time);
> @@ -3029,9 +3029,7 @@ static __be32 nfsd4_encode_fattr4_change(struct xdr_stream *xdr,
>   			return nfserr_resource;
>   		return nfs_ok;
>   	}
> -
> -	c = nfsd4_change_attribute(&args->stat);
> -	return nfsd4_encode_changeid4(xdr, c);
> +	return nfsd4_encode_changeid4(xdr, args->change_attr);
>   }
>   
>   static __be32 nfsd4_encode_fattr4_size(struct xdr_stream *xdr,
> @@ -3556,11 +3554,16 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
>   	if (dp) {
>   		struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
>   
> -		if (ncf->ncf_file_modified)
> +		if (ncf->ncf_file_modified) {
> +			++ncf->ncf_initial_cinfo;
>   			args.stat.size = ncf->ncf_cur_fsize;
> -
> +		}
> +		args.change_attr = ncf->ncf_initial_cinfo;
>   		nfs4_put_stid(&dp->dl_stid);
> +	} else {
> +		args.change_attr = nfsd4_change_attribute(&args.stat);
>   	}
> +
>   	if (err)
>   		goto out_nfserr;
>   
> 


-- 
Chuck Lever

