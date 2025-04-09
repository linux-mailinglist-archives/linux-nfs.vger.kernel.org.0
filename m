Return-Path: <linux-nfs+bounces-11071-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCEA82B33
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799F59A59DD
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05931263F4E;
	Wed,  9 Apr 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KPXzS9py";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CnVa/9pv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D425E47E;
	Wed,  9 Apr 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213243; cv=fail; b=i/i2ge2H4gandda3jZWpQrKHh+c/C0lO+BTBEQF8Gr1IP3q9hA5Q3K0Av8MWhdvOc8nc7iJ+uDtIw0iCUHNok2uHb2BLWKXV42exOlK1/+2oRT9LAptZmvLdg/WNU3Lmwi+ztXdN9ifzjhHY6X+H9gB5DG/M+gRVjNYS3N4NHF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213243; c=relaxed/simple;
	bh=3M4qecxComrBtBwkH+FMq94Lh6dckKjYaMODrQ3BU7w=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R4nFGxkAwKEBMeErko0doVW2d4q+9ZXvLxdbaoDQTQG5WAzmDpFj6ySEo5h792YWwa6+Ilc/x5n6fy+gACzykwq/HjJPPi0e0pCevtONyLPpwIYW7hOBHiX+H+CH+FtyDlmExvLcz6XcHfUaOqPYkOkx3BwRrVJKE+3vWT+fNhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KPXzS9py; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CnVa/9pv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539EPuaQ023706;
	Wed, 9 Apr 2025 15:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+xr0o7MZCdy90eYSxP4E+bbbLpaLRHv8LGxAzaBDiPI=; b=
	KPXzS9pywFSQ3073k62BqAhinmyiirBbqkqZpxVfgPzhRCmZ5zXadwQoaJQLR4lo
	GZTjMN/mwkRL1/wf8B8AWLM1gCsQF9S8FnY5a5J+vzeJN7PdS1d2wvCSpM9rWgag
	9UErjtEjRkKAtkFNV1IRrIn4XNKzsfPcnPyxNYMV/e1cMvFZrBz54mnnNsSGMdD9
	1AgjP9eG6Xk63F7oZ6rjYpLV2WCFa+ZWbxm26OFsSy0jAqU1An20BhhYGBpbf59V
	s/sRpnci5DWqyuP4448rwpSrEr0cpgP8wc6iVCbanRUgqHmuQV0ye0p7e4Z5zV/U
	57h0uAlBOln3BJ2LMUXq2A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tuebqgrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:40:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539El83c022161;
	Wed, 9 Apr 2025 15:40:30 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011030.outbound.protection.outlook.com [40.93.13.30])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttybpxej-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:40:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyZy5MVFPHQbD8MI2VGG/5sQfOwvjVYy1V+RSiHwcTtFncYQKZEv6xrFjAn5BRXMregj/s/3OlJeggwWotbzWGuQWdJsY9+Acw75d/DOFfGysCyqc25EKg1PtVFLA65L3NJ6dMh6wrwG6AiE9s3jIxhKtxbw2jJCw9hm7XLSgs76WhKNm+9Xj2qA5icxyOKQ3JTCDn9672e9sqzVYO3J1tBiC2CyCo3GwmWcdiJKGcCfUClHwpjotnSaMJ1X/4No0MWiaMtvemmDeARnv0SxTjsr0gQWxy8mtv/9M3ilI90sTer+xZuAqE7nmIDjf3MgPa5LU9XTQmFQyBWhWVPsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xr0o7MZCdy90eYSxP4E+bbbLpaLRHv8LGxAzaBDiPI=;
 b=tgGPe/3DJoPcAeKkH963N6pQXTDMiB+HiLYyVKr0XJgn7vYqe6cM8d5Wdo0J13L+HDndmAgbO72Oza4Wp0vzboY+BeAJ/xOOFHOK+pSwunlNz1LgjD449H7/veOP9CdYkzws2w04YvSNTYBFIHGHzUd/fFqMNZv/D5j+aK1TClR69JeN+jxxnziTU8z8IV5dvOmbeJMuCCP2NL+woVch2bvBs95QnFo3b+F0s1XfqUT4upUsvXi+9PzuIaaQ1euLwBmW7iMZolv3tbSWxNmdIAdUMbGF+jaOH1xoJUscJ3fKkycM8RgqgVW1Jg1Ecm6GOBE1xw23tSlcRiGHfwMcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xr0o7MZCdy90eYSxP4E+bbbLpaLRHv8LGxAzaBDiPI=;
 b=CnVa/9pvTBKGxZZhSElUbaBCUUmhdiH9Sa+lRiDb+KFXEP8Z/FTQ3AlQI/J/o/yni79KMjY3fCHHnwHnaq4ISszaX6yb4yenMvI0cFggg6ro7zhm/20rBGxgvkUGJR+TLlATm2RJCN3GgIlVYLUbnlvLqGX/LH0WgUy+M5JxjSE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 15:40:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 15:40:27 +0000
Message-ID: <1225505a-262e-4d4e-9cf0-3b14fbc26878@oracle.com>
Date: Wed, 9 Apr 2025 11:40:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] nfsd: add tracepoints around nfsd_create events
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
 <20250409-nfsd-tracepoints-v2-6-cf4e084fdd9c@kernel.org>
 <078a639b-1f19-48e2-a0cc-f861b67f34c9@oracle.com>
 <11d5010fbe14e21b614d7cc56bae1805b35f3a31.camel@kernel.org>
 <d0c0f6e0-ad8d-4f5e-a24e-700df88e3ec5@oracle.com>
Content-Language: en-US
In-Reply-To: <d0c0f6e0-ad8d-4f5e-a24e-700df88e3ec5@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: e66f4a5f-8178-4750-4c4e-08dd777cd9d2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Z3JiR01QbXlMYVIrMHQyMWwyYUt2Z1NwMTEvUmdiTExvTnpvanhkNm5mZkhy?=
 =?utf-8?B?VGU1SkE2Qy93a3NUMVZ0ZVMrZlU5TEVLZ1RWT09TRXNhTit4R2lnb1A1UGdX?=
 =?utf-8?B?Z0hENUh4eDhDcjBVOHoybEVPTGlWcU53dVpnZ1hjWVhIWU9JRkhjd3RIUmpU?=
 =?utf-8?B?UDlFT290S3JJZDBKckpCRnc5NFFnQkxobEJrSldLNFVBeiszRmFDaTVaR3Bj?=
 =?utf-8?B?VlVrWTdITUlRTzRKazlyVUQ3SXFUNjlGanRjaXFtbGM1UTczOXc1cjdoS0dy?=
 =?utf-8?B?UzFqdGtGaGd2ZkNUWUd3MU5PWDNOSklmZUtlaTliSUt1bnJic09Vem5yTStG?=
 =?utf-8?B?TGJzQ1oxVW9GaG51VnBXazJBM0pRYnQyQm1ISWw1RmtQdHhZWGk3c2Z6ZmJS?=
 =?utf-8?B?QzNycTV3cTM0TmQ3YjI4SmhwbkVRTDN2bWdaaFdlRnpORDVnMUpYQ0E4SjBM?=
 =?utf-8?B?Ri9iWFJwa2h0MXBxaEQ0UDZ4TnVPb2swMGFxQVZTb1JQZHBOOFlpa05jbHNB?=
 =?utf-8?B?TzVmYlArRXRrekJ4QmpjN2htK2FCUmN6N2kxSlBQOElCM28wdmZBMXJwbU1n?=
 =?utf-8?B?QTJkbUZLT1RQR0FORU1iV2VEbmJXamJFQXBoM0ZVVDhIQ1RGN3p6aTFSVTZr?=
 =?utf-8?B?WkhZNjJEMWtRQzhaT3BPRmxJcHQwRGlXUkxIREFjcUlRVzJmbnoxNkVaRkFm?=
 =?utf-8?B?UU5PNmw2WHM0bG9aQURQK25Sak5xazFRRTMrT2s0aXFrUnBtcWsvMHhVL2xQ?=
 =?utf-8?B?akVSNFd1cjRLS1l0L2c2ckl0QUZ0M2pMeVZqaEZWMzArQkNTRkNaNUtrRnEv?=
 =?utf-8?B?ak5wRERtZlBhaFlNamg1VUJuMnh0REdXUXpmWHYyYmlwaGFmL1krTk5vUm5H?=
 =?utf-8?B?VCsyVllMYUxwS0NQclU1MjN4UzhlYzVONnRqdnczUmN3bFdxK3MrY2gvZllr?=
 =?utf-8?B?OUt1VzZsYnZwYXJscVBWNEh2dWNBc2piTGxVU2Q0SllsSXJsOUlLNGZmR3N2?=
 =?utf-8?B?T2N0VUlBRVBTMHpTV1VvYmRxMGM2NDcyMnNHZ2h6Q0t2NUg2WlIzK2k4UTZm?=
 =?utf-8?B?WnNvSmVSVE05MWc5bk41cHdhRzhXWUpxMFlEeDB3LzVJNFRBVlI3cjc5WmlN?=
 =?utf-8?B?T3FQOUJyMG1ZM3VxZ3ppZVhud3FkSE8wU3lGcEFzQzcycXlIbTZ0UUVJbWF3?=
 =?utf-8?B?YkFyUmw5VUZxcEo1RlRiQ2ZBZGc0bCszS04wcDUybFdaeDNPRkdGeFIzQVZa?=
 =?utf-8?B?bndGSUtXM2lTV1VuYUdPYkMvT1FmZE9IYUk0WmRGSFlxK0c0MmZGamVseFdW?=
 =?utf-8?B?dDR1K2RZMll5bWh2Tmd1N3NBa3dTK3JhV0t3YVBselNYSElraXlxMGZqVFlS?=
 =?utf-8?B?VzJJM0hTN2J2U2picE1CUzhldFEzWS9nNnh6VXM0SDZqeDhxUjFnakxTb1d0?=
 =?utf-8?B?M2FvdncyVGd0eHQyVE1EVUJsQ1dkaTVmSjUxeUMwYXJaTE1yd1pBakV5ZXlv?=
 =?utf-8?B?K3JrZ2RsSldDS2VrRzFWT01EbUF1Ky9OUXNIcXE3R3FCdC8rZThsM3pOeURq?=
 =?utf-8?B?OWp1ZTVNN004dUtSUFE2bEZLRks1dDRYam5BUVBXcWxkUXBoN0Z5NzZTY2JC?=
 =?utf-8?B?Qy8zSTlvSVZmR01IT3VkL3RVaWpVYVRRUGFKb25ZNTdXS3k0WTdNZVNOWnJn?=
 =?utf-8?B?OUZpYlN3UmFOM28vR0l4YkdlbEVPV0g1YmFUNkMxR0V5ZTNWbWRSTDU1WGsw?=
 =?utf-8?B?Z01HVHZ2cDgxYnRPVFZRV2o5S3Z0SHVUMDV1WWs2ZzNBSk9haGlpL3ZWZkVY?=
 =?utf-8?B?NHFaVDBCUERmTno0NG80eW80YXR4VDhoRFVFV2Q2VDMrTUQ1cE5Ua2RpTXR6?=
 =?utf-8?Q?hGup0oxS3tGho?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Mk94d3JqUUZNcitFK3FSaVl4dFNiNzVUK3lMb2FnSXRKMWNucDRCT1hYdFNX?=
 =?utf-8?B?MksxRW5aZUV0bHU3N0hsNTFmVDUxRjBkcTBYa1NBU0s1SXhIQUZ1UmdFUlEw?=
 =?utf-8?B?aTI2L0h3V0R4d3ZPVnI0cEtBdmpVcy9GYkNXWXlGaUc5dlBvaDZuMFBRV0ZL?=
 =?utf-8?B?K2M1UGJxdjhvbnZ3aENIZHpzSklsSDJSZjR1bDVjMzY5SkpPOHZXY1VZN3F0?=
 =?utf-8?B?aUxJblFPRk1qazd3V0s2T3hvcHNQc29CRExNeDk1ZlNsNEZhOXJzTTFtWkhl?=
 =?utf-8?B?YVptUGFxV3VLclB4d04veWFSZHVXSk51SjBxdWFvelNEYnh1Wm1mdXh0bmhj?=
 =?utf-8?B?ckd6eTArd1I0TlVvMDJCaU1DK2ZUbUtvNFNFNEtROHlIbFdZWG1HdXJ1RW9H?=
 =?utf-8?B?OUNydFNMNThob2hCRmhDblRibE1YeGdFQUk4eFRXdGZoczB6cUNGdUwwSGZI?=
 =?utf-8?B?MFZTUm1uUmozazhpS3lYMmV4SzVWTmhBazVXaDlSSjVGMklVTjNheTArbzlN?=
 =?utf-8?B?NWd0dkF4cXJpRElwYWZndE82M2d1YTB5Uk5KQXlUbW9FY3dmU3hGMXk5K3R0?=
 =?utf-8?B?blNYRXpQYXFrNFIvNTFTeUxuMjRpbXJSZm14RGUwUUdFVkI1cjhXaVNJZXdM?=
 =?utf-8?B?QlNPdnNCZ1RVaDJGa0hvdWl4SVdML2poeVYxZGdDUWJkbXdWcDFLM1QyUFow?=
 =?utf-8?B?Tit0amQ1c3Y5R3preTNOTlFZeDJiWTFvaE9LU25iZXpqclRuRzcvL3BYQjE2?=
 =?utf-8?B?djdBQmdTMktLRGJ0U0RSOWRwZ2hHdEQ0Z1JWK05uRS80NGJsWDBIa05vNDlV?=
 =?utf-8?B?T2luUStBTUdPUUJXNWluZk9JZnZ4dTQycEl0SHBOWEo3REdIMFRjaWFMekMz?=
 =?utf-8?B?ZThMUEtCVHBOU1hjS3YvYURxbUxqcGJyeEZWbVJPUGtXUnV6NGFNVm1EM3lR?=
 =?utf-8?B?THFnaWpnSktkN1o1c3dWWFZoa2E3L3J2Q3pLN0ZTRjk3NnZHTklBWGNZaFZC?=
 =?utf-8?B?TFJGYjdzandQcXV3aEIxRnJTMkNDbUJWcDc4K3ltVTFPeSttdzVvZTdqQlRO?=
 =?utf-8?B?TnNyU3pwRGdaYnVlWkRDNE1UK0MzcHpEdVdtNXB5WHJRRWt6ZEtjNWwwaFR4?=
 =?utf-8?B?L2U5cEh4ZHNEanlHZjUwZ1ZrbDZpanEydXNEMDdqUTQxYlcyM3FqYXN5bWVm?=
 =?utf-8?B?SDdNbVB4R29ERURubjYwTzlCL1YveFdPV3FuZ1ZXUVVPdUF6NmN5d1c0aUZt?=
 =?utf-8?B?ZUkyaHVYeWgyejhjdDF0S3JSYUNPaDR4bjk0M2VrVno1elhGckJPZVZiQ2o4?=
 =?utf-8?B?QytQd2Y5QzU1bjVUUkoxWnZISS9UZmk1ZkoyTElKRXVlMXRzZ3FMdW45VzQ3?=
 =?utf-8?B?WkJXa2JBaXcxRVpVWWs4Q0o0aHdPRzV1a2xnMkZmeWZweGQ0aXIrNW0vWTl2?=
 =?utf-8?B?QjZ2dFdLQTJoN2YwbHplTitvaGs1bTFrRVVGV3BMM3dQRE1OS2JyK2MyVTgr?=
 =?utf-8?B?ejRkOUV4WjRxT3dRODBaZkkybFE4REtyc25uTGdqTzdiSkg3SGVnVU5FUE01?=
 =?utf-8?B?cjZXdHZPbktmdldZYU1jQUxHY0pXY1d1OHQzK2xGcEErQnNWVi84c3EzR0Vv?=
 =?utf-8?B?MFRjTnl1WG41RHdudlM3b1puekY5enE4REpSZ1Z3MEVzeFAyM1BWWlI4ZVpi?=
 =?utf-8?B?eEh6R3ptdEw2NDVOLzMzNzZ6dDk3WmMyaEd2QndUa1ZLWVVFUlVFelNZSHVr?=
 =?utf-8?B?SU5xaTZWaldCY0tzZWhFa1RpM01IVy92TnV5UERMM2l1aHg1UDBTa2lPOEhE?=
 =?utf-8?B?MGlVNldoaDYwUDl4QURWZjZBTUZrckd3ZjhkVHNmdTJKa243WVRkeURHOGJj?=
 =?utf-8?B?QXBCbExsWVFpalRON2ZtSVJ6MFJvSFU5L2tvdXYyMys3N24zUjV5NldUVFJC?=
 =?utf-8?B?YURLMXNaQlNCRC8raTVTNDd5WU9LUkhOUDQxZHpHVFRiQlZveGx1bDM0QUFV?=
 =?utf-8?B?YVZES2QyN3l6QzdLQWtUODJ0a3Rrb3hkUzVNeDdGZlVhN3N2QXhNdDlMUXRn?=
 =?utf-8?B?UjJnczhXYVpJVi9YenRWRyt1MzBxWmdkSzd6TlpJRlpQUTROaWZvUEhMZlF6?=
 =?utf-8?B?Yi82Qk1rTmlNRG96SEcrWW1NcXVjZGNYMHVRdmxVc1Q3dDgvWTc1M0ViV1Iy?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NnOCnSYobHcMJ0IJayinRObdAhjYQxa3I5EOlPB1liS8uyiO5/pJakZ7sOI3m+bXni2b7XtPkwkX3bzovbhM8G3yHh3YyGMmaCx+QZF1tcCD3h7jYkeoniW9EEHvC2tDYlyWyxi0HkkTQRO/59AtV5n5iH/uZMp8zdefyP/iUdldLeO7MpBrW5aerqBHRF7n8y1qZO4BIhHAuTJk+VKz71AXqv0XoDb/tfv6iagPenVHb3QHaqfHPEZ4MjYMe1V/wkNyhoi6cpAeQOK+X48ITlQU9QoBz8YYSQHdHu1bFG94o3y9fdGUX5iVNUQZBxfXEFa9T70k5Dzjo56exs+ci0EYzMpbYlQtn3J8HLe7VA9s+9rFQlHFHQRwrp7e1XD54iZzr2beIHf71Kg5og2uBs7TokpmtXNdltqkXEQar0p8KHf4VkyIyui8allAMeRW6dpkO74hui0OeK3Ur1xPfrSSX4u9ikjjx1TLBefkq2kr9/BSu2+EIHrMNpiGBtw1suZ3qLRfoWMh3GkTVkjEgmEhg5VO7QjdrpmseYnMTtItEdoNCt0RdTAjxX/+FALp46NYBRwAW6WLISq8OFN4LPvWqaKLs0lW4UyGlf7mSaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66f4a5f-8178-4750-4c4e-08dd777cd9d2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:40:27.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jxqnERos/p9yWLOirogIYIj4eMnd06/94ZhGxFFoPlcmH+pVMjlIH1QuDr/qALjJoYw0znpMlkso/JcGzkgew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090099
X-Proofpoint-GUID: elX9cFUzwDdUXGae0KvtJp5QF6XdV6Bg
X-Proofpoint-ORIG-GUID: elX9cFUzwDdUXGae0KvtJp5QF6XdV6Bg

On 4/9/25 11:38 AM, Chuck Lever wrote:
> On 4/9/25 11:36 AM, Jeff Layton wrote:
>> On Wed, 2025-04-09 at 11:09 -0400, Chuck Lever wrote:
>>> On 4/9/25 10:32 AM, Jeff Layton wrote:
>>>> ...and remove the legacy dprintks.
>>>>
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>>  fs/nfsd/nfs3proc.c | 18 +++++-------------
>>>>  fs/nfsd/nfs4proc.c | 29 +++++++++++++++++++++++++++++
>>>>  fs/nfsd/nfsproc.c  |  6 +++---
>>>>  fs/nfsd/trace.h    | 39 +++++++++++++++++++++++++++++++++++++++
>>>>  4 files changed, 76 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>>>> index 372bdcf5e07a5c835da240ecebb02e3576eb2ca6..ea1280970ea11b2a82f0de88ad0422eef7063d6d 100644
>>>> --- a/fs/nfsd/nfs3proc.c
>>>> +++ b/fs/nfsd/nfs3proc.c
>>>> @@ -14,6 +14,7 @@
>>>>  #include "xdr3.h"
>>>>  #include "vfs.h"
>>>>  #include "filecache.h"
>>>> +#include "trace.h"
>>>>  
>>>>  #define NFSDDBG_FACILITY		NFSDDBG_PROC
>>>>  
>>>> @@ -380,10 +381,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
>>>>  	struct nfsd3_diropres *resp = rqstp->rq_resp;
>>>>  	svc_fh *dirfhp, *newfhp;
>>>>  
>>>> -	dprintk("nfsd: CREATE(3)   %s %.*s\n",
>>>> -				SVCFH_fmt(&argp->fh),
>>>> -				argp->len,
>>>> -				argp->name);
>>>> +	trace_nfsd3_proc_create(rqstp, &argp->fh, S_IFREG, argp->name, argp->len);
>>>>  
>>>>  	dirfhp = fh_copy(&resp->dirfh, &argp->fh);
>>>>  	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
>>>> @@ -405,10 +403,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
>>>>  		.na_iattr	= &argp->attrs,
>>>>  	};
>>>>  
>>>> -	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
>>>> -				SVCFH_fmt(&argp->fh),
>>>> -				argp->len,
>>>> -				argp->name);
>>>> +	trace_nfsd3_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->len);
>>>>  
>>>>  	argp->attrs.ia_valid &= ~ATTR_SIZE;
>>>>  	fh_copy(&resp->dirfh, &argp->fh);
>>>> @@ -471,13 +466,10 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
>>>>  	struct nfsd_attrs attrs = {
>>>>  		.na_iattr	= &argp->attrs,
>>>>  	};
>>>> -	int type;
>>>> +	int type = nfs3_ftypes[argp->ftype];
>>>>  	dev_t	rdev = 0;
>>>>  
>>>> -	dprintk("nfsd: MKNOD(3)    %s %.*s\n",
>>>> -				SVCFH_fmt(&argp->fh),
>>>> -				argp->len,
>>>> -				argp->name);
>>>> +	trace_nfsd3_proc_mknod(rqstp, &argp->fh, type, argp->name, argp->len);
>>>>  
>>>>  	fh_copy(&resp->dirfh, &argp->fh);
>>>>  	fh_init(&resp->fh, NFS3_FHSIZE);
>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>> index 6e23d6103010197c0316b07c189fe12ec3033812..2c795103deaa4044596bd07d90db788169a32a0c 100644
>>>> --- a/fs/nfsd/nfs4proc.c
>>>> +++ b/fs/nfsd/nfs4proc.c
>>>> @@ -250,6 +250,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  	__be32 status;
>>>>  	int host_err;
>>>>  
>>>> +	trace_nfsd4_create_file(rqstp, fhp, S_IFREG, open->op_fname, open->op_fnamelen);
>>>> +
>>>>  	if (isdotent(open->op_fname, open->op_fnamelen))
>>>>  		return nfserr_exist;
>>>>  	if (!(iap->ia_valid & ATTR_MODE))
>>>> @@ -807,6 +809,29 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>  	return status;
>>>>  }
>>>>  
>>>> +static umode_t nfs_type_to_vfs_type(enum nfs_ftype4 nfstype)
>>>> +{
>>>> +	switch (nfstype) {
>>>> +	case NF4REG:
>>>> +		return S_IFREG;
>>>> +	case NF4DIR:
>>>> +		return S_IFDIR;
>>>> +	case NF4BLK:
>>>> +		return S_IFBLK;
>>>> +	case NF4CHR:
>>>> +		return S_IFCHR;
>>>> +	case NF4LNK:
>>>> +		return S_IFLNK;
>>>> +	case NF4SOCK:
>>>> +		return S_IFSOCK;
>>>> +	case NF4FIFO:
>>>> +		return S_IFIFO;
>>>> +	default:
>>>> +		break;
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>> +
>>>
>>> Wondering what happens when trace points are disabled in the kernel
>>> build. Maybe this helper belongs in fs/nfsd/trace.h instead as a
>>> macro wrapper for __print_symbolic(). But see below.
>>>
>>
>> If tracepoints are disabled, then the only caller of this static
>> function would go away, so it should get optimized out.
> 
> AIUI, the compiler will complain in that case. If we need to keep this
> function here, then this is a legitimate use for "inline".

or maybe_unused.


>> I don't see how
>> you'd make this a wrapper around __print_symbolic(), since the point is
>> to pass in a NFS version-independent constant that the tracepoint class
>> can use as a type.
>>
>>>
>>>>  static __be32
>>>>  nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>  	     union nfsd4_op_u *u)
>>>> @@ -822,6 +847,10 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>>  	__be32 status;
>>>>  	dev_t rdev;
>>>>  
>>>> +	trace_nfsd4_create(rqstp, &cstate->current_fh,
>>>> +			   nfs_type_to_vfs_type(create->cr_type),
>>>> +			   create->cr_name, create->cr_namelen);
>>>> +
>>>>  	fh_init(&resfh, NFS4_FHSIZE);
>>>>  
>>>>  	status = fh_verify(rqstp, &cstate->current_fh, S_IFDIR, NFSD_MAY_NOP);
>>>> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
>>>> index 6dda081eb24c00b834ab0965c3a35a12115bceb7..33d8cbf8785588d38d4ec5efd769c1d1d06c6a91 100644
>>>> --- a/fs/nfsd/nfsproc.c
>>>> +++ b/fs/nfsd/nfsproc.c
>>>> @@ -10,6 +10,7 @@
>>>>  #include "cache.h"
>>>>  #include "xdr.h"
>>>>  #include "vfs.h"
>>>> +#include "trace.h"
>>>>  
>>>>  #define NFSDDBG_FACILITY		NFSDDBG_PROC
>>>>  
>>>> @@ -292,8 +293,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>>>>  	int		hosterr;
>>>>  	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
>>>>  
>>>> -	dprintk("nfsd: CREATE   %s %.*s\n",
>>>> -		SVCFH_fmt(dirfhp), argp->len, argp->name);
>>>> +	trace_nfsd_proc_create(rqstp, dirfhp, S_IFREG, argp->name, argp->len);
>>>>  
>>>>  	/* First verify the parent file handle */
>>>>  	resp->status = fh_verify(rqstp, dirfhp, S_IFDIR, NFSD_MAY_EXEC);
>>>> @@ -548,7 +548,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
>>>>  		.na_iattr	= &argp->attrs,
>>>>  	};
>>>>  
>>>> -	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
>>>> +	trace_nfsd_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->len);
>>>>  
>>>>  	if (resp->fh.fh_dentry) {
>>>>  		printk(KERN_WARNING
>>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>>> index 382849d7c321d6ded8213890c2e7075770aa716c..c6aff23a845f06c87e701d57ec577c2c5c5a743c 100644
>>>> --- a/fs/nfsd/trace.h
>>>> +++ b/fs/nfsd/trace.h
>>>> @@ -2391,6 +2391,45 @@ TRACE_EVENT(nfsd_lookup_dentry,
>>>>  	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
>>>>  		  __entry->xid, __entry->fh_hash, __get_str(name))
>>>>  );
>>>> +
>>>> +DECLARE_EVENT_CLASS(nfsd_vfs_create_class,
>>>> +	TP_PROTO(struct svc_rqst *rqstp,
>>>> +		 struct svc_fh *fhp,
>>>> +		 umode_t type,
>>>> +		 const char *name,
>>>> +		 unsigned int len),
>>>> +	TP_ARGS(rqstp, fhp, type, name, len),
>>>> +	TP_STRUCT__entry(
>>>> +		SVC_RQST_ENDPOINT_FIELDS(rqstp)
>>>> +		__field(u32, fh_hash)
>>>> +		__field(umode_t, type)
>>>> +		__string_len(name, name, len)
>>>> +	),
>>>> +	TP_fast_assign(
>>>> +		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
>>>> +		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
>>>> +		__entry->type = type;
>>>> +		__assign_str(name);
>>>> +	),
>>>> +	TP_printk("xid=0x%08x fh_hash=0x%08x type=%s name=%s",
>>>> +		  __entry->xid, __entry->fh_hash,
>>>> +		  show_fs_file_type(__entry->type), __get_str(name))
>>>> +);
>>>> +
>>>> +#define DEFINE_NFSD_VFS_CREATE_EVENT(__name)						\
>>>> +	DEFINE_EVENT(nfsd_vfs_create_class, __name,					\
>>>> +		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp,		\
>>>> +			      umode_t type, const char *name, unsigned int len),	\
>>>> +		     TP_ARGS(rqstp, fhp, type, name, len))
>>>> +
>>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_create);
>>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_mkdir);
>>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_create);
>>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mkdir);
>>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mknod);
>>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create);
>>>> +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create_file);
>>>
>>> I think we would be better off with one or two new trace points in
>>> nfsd_create() and nfsd_create_setattr() instead of all of these...
>>>
>>> Unless I've missed what you are trying to observe...?
>>>
>>
>> I'll look into doing it that way.
>>
>>>
>>>> +
>>>>  #endif /* _NFSD_TRACE_H */
>>>>  
>>>>  #undef TRACE_INCLUDE_PATH
>>>>
>>>
>>>
>>
> 
> 


-- 
Chuck Lever

