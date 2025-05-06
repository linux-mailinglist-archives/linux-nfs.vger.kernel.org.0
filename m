Return-Path: <linux-nfs+bounces-11536-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3CAACE6C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 21:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024B61B684FE
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 19:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF26E20D4E4;
	Tue,  6 May 2025 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b="3MkwPnMU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR09CU001.outbound.protection.outlook.com (mail-northcentralusazon11011052.outbound.protection.outlook.com [40.107.199.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC01FBCB1
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.199.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561259; cv=fail; b=i6H9QAu0OmOjgcRQMQMEoOf89s/UO5aTHaYZyZ/RPiq+KtHk9dFRKminu+nTVYKLzdlzcU+99123OTdtwJghelB3JuJYdJIEuR7fJzoyeeVUvGpzxCjdq/zlxSF5vIhQ/pP5F8Bt8IE/9ea4Qkrvry8Zj6zc1ssHVsrg7+T0aHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561259; c=relaxed/simple;
	bh=FhTwvtsvetj8DWkAru8kYuXVJm8dVgWyCBI1ryE27xo=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=USOvl+k1ekB7IOeJ6FlCZPPYE/5rm1uG3Ry0aevEbshAl8K4BjBs9vHhA5saNW3VskyIfmaFm/N68yV4PmxT2vVcashCQU9fUcitEJduH8IkK69ivwfZn5kXjMCEQ1QfWRY3ytI9/JR2ajuDfM+Pq0xenCXVGJoogQkCOh5sNEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com; spf=pass smtp.mailfrom=nwra.com; dkim=pass (2048-bit key) header.d=nwra.com header.i=@nwra.com header.b=3MkwPnMU; arc=fail smtp.client-ip=40.107.199.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nwra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwra.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQG/lXDGmI166PDfM4Y3ar/R/IweOuXl0zGvQOzTzCOO1diK6Hlm4yU0wb5tP8CSjBqA/UWyXsMPY2476uX5VHiSNMXKwflJS9LF5Vc4z4iOkBjsene3Lnqkr3LMvos4SAbSBqXZ0I6jwJrIR1lDYvLqnUKO7wmBeP4Lwx9EtO8pkC/0CuiZFJBErZOLUZUf99FLpUNCDXVu6wvSvkAvmCRxdWi1Y5BFMtfGGCewchQ4N6A8aSDGUPSoI3hQ/0GKz+t8sbRUMozbAm91cxewVp+pNGKTW3j6H55nKAB+jGZB/J5GL3RYdSowBylCw0tFx8s64C9HvvvCk954aVoY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr1e4zGIlzd+Zq1oJsk4Ox32NaCfu7nQvGIbQWvyin0=;
 b=jBwSf8gkgbBD1Vs8qr9pvJTvPgmIXSPNEBeK9sGM40eGX6uq3nI8JnlWsvxsQDMP887pao9uIqkA8jjJuOVsrBBIxADTH+46UC9HNUPC9DHQgxiQLm3ndHRWd/aimiSX0VzT1pA8B+LBoO1FnRepM1RvNtUWcxPadraRmARnwlV3IGIbC0fKRskPlUVVN0ndxpuNw/r9XzvJDXyWxDIMh7JskBrE5i+7zx3yQBXzD9jCysLMsfUsUsa60cYh7KVZxSF3Uv0voKhXA++vsQCgp3E/aUMzewASt0ilKg2rdV5276SJRQSizdM1OBJto4mlsr3jDWSxnctdaLeLGMsExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nwra.com; dmarc=pass action=none header.from=nwra.com;
 dkim=pass header.d=nwra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nwra.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr1e4zGIlzd+Zq1oJsk4Ox32NaCfu7nQvGIbQWvyin0=;
 b=3MkwPnMUJ6Lz60DUScfZfiot4j2zuAs8WmaJcdqE2Tdi+x9FOsoLbzMR160duR2ZA/wlcp3Fg5t5HVLnC5knbzq8ohaq4/JM3vwsG6XhL7Gl3s0oSuluFYTGJ41naZqp/krwe1v+/dLpM8Pic5UHPAOmyAo2NnysRSLLOYwfED/FVPuyLil1770SB5d1Iw1Rkhg5BJhHYMHVw3xUkvBWtNHie+DIauED2eAMWFN8QOXamgym0qo0KZa1ZFUadmie4FLu+nLj9pVBawq9Rp4VN6UFTSg2WQe96rCO8/YsjnkFdAxi4j0J4RZY3XyLTYzh+RXt4qhGdYEAhA2SPgamew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nwra.com;
Received: from SJ0PR09MB11875.namprd09.prod.outlook.com
 (2603:10b6:a03:51f::10) by SA1PR09MB11207.namprd09.prod.outlook.com
 (2603:10b6:806:36b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Tue, 6 May
 2025 19:54:12 +0000
Received: from SJ0PR09MB11875.namprd09.prod.outlook.com
 ([fe80::30e0:339f:805:2779]) by SJ0PR09MB11875.namprd09.prod.outlook.com
 ([fe80::30e0:339f:805:2779%3]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 19:54:12 +0000
Message-ID: <e482c8e4-2939-4ef6-a004-e23fcf5e666d@nwra.com>
Date: Tue, 6 May 2025 13:54:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Trouble with multiple kerberos ticket caches
From: Orion Poplawski <orion@nwra.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <c4ecc067-9a51-40c8-9300-29119ff2e1d0@nwra.com>
Content-Language: en-US
Organization: NWRA
In-Reply-To: <c4ecc067-9a51-40c8-9300-29119ff2e1d0@nwra.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060002080607000103030206"
X-ClientProxiedBy: CY5P221CA0111.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::25) To SJ0PR09MB11875.namprd09.prod.outlook.com
 (2603:10b6:a03:51f::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB11875:EE_|SA1PR09MB11207:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec5223e-2799-413e-3c7d-08dd8cd7c58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|41320700013|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjZ3U0ZKRWRmVk9jdVZqM09YVnNETGY3OGNaSFQvaG94MmthUDdENlZFNDN3?=
 =?utf-8?B?d2J4TDhiV1VYRlY3dUFsWE1mWWhuaklGbmROTUZkY1k2Z3FIWnVhcThnNkJU?=
 =?utf-8?B?MzNuc09raXh2MlZQamFEMGRGa3RtT2lMUGtpam8rcWJoK1B1VEU4cFU2Ym4r?=
 =?utf-8?B?a1BpV1VBaUVtckYxcGZCdFA2Z2pSclgxOFdpc0xETUlzUUswTEd1MHN6Vm1Z?=
 =?utf-8?B?S1hqRnVKc1l1L0tFTGwwNnA5N2RyczZqeGpUVVNvSEZGUnZLZFlqRnUzeUZC?=
 =?utf-8?B?RVA3RzBmWWluWmYvc056ZWVCZlZBZnlKeHVEOThyV3VCSjRYTDNMbWVXR3ZT?=
 =?utf-8?B?eVRwcWQ4bkFtcTlwc0tZalhLeVpYUnBTK29MTUhoNHJoZFI4Nk16OG91T0ZL?=
 =?utf-8?B?YUFXa1hGNmdiMlZqaTRPa3Rtd3lzVXdmT0lIYnRUSkFSNW14Y29JY29McTZ6?=
 =?utf-8?B?Y3ZpWjJGRm5pdGlrV01QNTZCWWpuM1ZXa1NpZk9sTmtES0FuUDJQYmpjZjdH?=
 =?utf-8?B?UzVUY1Q2NmJpdFhvVnovSHBDWFN2VFJHQUNONGxwV2RLQ2ttYS9ham9OL2p3?=
 =?utf-8?B?ZkpjRmh1SDcvQklRMGRIQkFnTTdlTnB4UEZ2bWNidGdFcE5vbDIxcXkweFR6?=
 =?utf-8?B?OThWdGZvYUJYWGthL1dNNW9VVHMwMWg0WjMwOSs1U1BwamtsZE40dGNPSHVt?=
 =?utf-8?B?TTBIeEhvVUZYTS8yeVE4NXdQdGFZSkRBS3hscVUrVkxBeG5hMGpuc2VUTVNV?=
 =?utf-8?B?TTN2aFlrVld5UGtRMkVrUEJFSDd0dldBd0pjNm1vdUpzS2lLYisrajE1L1NB?=
 =?utf-8?B?M2lLa2JJRWwxbzZOQitEL0daTjFEcUh1UWVYU252bmdmTDhUVmVhWCtNdWho?=
 =?utf-8?B?QzA1VU56U040cXM5djFEZVhVMzgzODhjOGcrcTRENVVNQXplUTM2ekNmcjRO?=
 =?utf-8?B?bTFCdG83VkpiTFduNHZyejRyRDRyaFp6K1ltc3RmNEtGOE9vei9hRVo2amx6?=
 =?utf-8?B?TXpCVy9VVmp5Wm5OWDhjUVRHcXJSSmpYR1N3SnVzYnRPUGl4bVViMXN4VEg0?=
 =?utf-8?B?NjEzeHpQMFZmK0t6dGYzOUtzSGYzY1JFRnlUWFdZbjJqa2ZkK3NKVDNwWUwx?=
 =?utf-8?B?WWdaY01JTWk3UDlOYmx0eVo5QkM4aHhaUysydUJzU3V1YlUvd3dsYWRtQmtM?=
 =?utf-8?B?MnhKK3BJRGRQVHdLZ29CZWhqM2VrckRmMVdFb2pPR2owTXV1a2o3VnFIclZi?=
 =?utf-8?B?dFZTS0NZTWN0VXdzMnNVeWZXQW56YkhLZnlYV0ZGSGFuelkyWHNBeVlVUVlO?=
 =?utf-8?B?Q0ZjTUxFSGg4M2VyUEJSWW80YkJyaGthb0RWcU9pZmRBVE81dGJKOHF6bjJk?=
 =?utf-8?B?SlZMdGFZM0NDcEFxRFpGMU1LblcvVjQxL0ZLdVBYYm42ZHluZTJONUt1bXJT?=
 =?utf-8?B?Ui8zUUFzTXQ4UE1jQ0V4cXZTMzVFcTZ2bS8xeVI0WmF3RUhQb29kVEh1Y0Iz?=
 =?utf-8?B?NWJjaW4rM0w0bDhaYTF2anZqcmFZclNET1VuOUV1RHJlRVVjbWltZi9ySVJi?=
 =?utf-8?B?WFRVUFdTaTZmb3c3M1o3OFR6eWZ0cElOUUdOdXFReDFHMkhkR3h0M2JtQlha?=
 =?utf-8?B?ZHd2Qzd4Zk9GTVhheFNneUlsVitwbG9pUEJOMHN3T2VhVzE3d01uclBNOExS?=
 =?utf-8?B?RW9DYVJ1Zm5HWkpMNzdwRmhjNE9Ya2c1c1pKakY3KzQ4SkhyTnVpeXJWZ2Zi?=
 =?utf-8?B?VW5YTlJXOFFKSkVFVzVuNDl6MExXQXl5ODFINUZPWkYvSERDTFUzMmZhNHBQ?=
 =?utf-8?Q?1E32vfO56kugoq66O434HCYJ1padu25cclq7s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB11875.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0JXVzcrRWdNV0F2a3JVc05wdTJPWFBCT2VwdTR6OTBhcis4b0VqQlZHbU51?=
 =?utf-8?B?UXlSSEF0TWIvUWdJTE5YVzI2TUlZUFRlS3EzRHhMZjBJZ0JGc0xHczFTVXJ3?=
 =?utf-8?B?RWorcGpKc0pYMGx6eU9ySGVuMXA5VE9wUmdGQ24zSGovcFJuRVUzLzgwM1dN?=
 =?utf-8?B?RVFKd1Q1RzhmYlpZV1V3Rll1ZjZOcUljN2IwWS9lVDRLMzB2U25ubGxJTEZy?=
 =?utf-8?B?cWVkZUllQlR5ZkdMYUhaelJNNjNHbmVpNkg5cSs2cDdGSDc0Ly9RSGI4WEt4?=
 =?utf-8?B?R3ZBWXpIY1RUNzBKQldjTEsxSUVyTEZCaG1sNXpEMjhKTkRueFFsaHBXV2cr?=
 =?utf-8?B?MWpGeU5iR05MTlp1THFDcWN2R0JuVUJqaTBMVk5OTHFMQkt3U2c0UHBFakht?=
 =?utf-8?B?UWdKOVlhN0tXMWJqdXh6cElmRW5JSzFPL2dZMFZZL0poMlBSL2VQamhGdkhE?=
 =?utf-8?B?MzF4RHg0UEs3dkNrZ003dEhTS3h4MloxbHI5Vjc4MnVEVFVPNXdOZXVUelMw?=
 =?utf-8?B?TjdFYy9PWVMyVVUwTVZ6dGduTnh0RktHTjlKZUo1NUpJS1cyQ3lJbndBUXQ4?=
 =?utf-8?B?TGtqQ0s1SmRCZW9Denk5NXV3a0JBYzdlQkRrdU9yc0d0cUhxSWhBa0tsQU1H?=
 =?utf-8?B?b2xrOUVPcDBVTGFCSzgwZHQxeTlSdTBqK0dmNDNtYWdnbzdHdmxsWXZ5SWth?=
 =?utf-8?B?WVJ0dzY3THpaZlRZU3dObFZtaHdBMHZkK21wcnhDOW03MzR6YUNadVNwbVRQ?=
 =?utf-8?B?Wm1qTlhUWVM1SlBRS0l3SVdoUTJxSk9xUjIwdFRuV2JoYXBic0V0TnluVUdC?=
 =?utf-8?B?dUJFaXVKVlJwa3BseGY0blBYaUdlcFRsRkVCS01NU21ZN2dWUFBhV0IveWQw?=
 =?utf-8?B?Z0toR3ZkMTV2RHZiOS9IekV2QUlyVDNrcjF2SHNFUDVLRnZRTy9waHppTGpi?=
 =?utf-8?B?eEd6S1hrMXlOY1VHRGx2c1lad2JxWnBJdjJWbi9DMnk3OWJZQ2YzVkFlVEE0?=
 =?utf-8?B?ZHhBbHRrSVpERUpRbEpGN3lPZ1NkU2lQdDlpTm03R1NKZVBvdktSM21jc3VG?=
 =?utf-8?B?NGMrWVZFbTNKMnJhOEpyWWtlLzFaSUlqVldnR25aT1VnY0N1c3RZUHBYQTR2?=
 =?utf-8?B?anVSaEtNRjYrWFBLYXRLeDVOUzNKRkRsYkloYnhYWGlZNU9EL3pRSzZnak5k?=
 =?utf-8?B?aW9Tbkt4Tys4Q0plTm9vWldvdU5QN1RXS1ZwVHQvVGxXWFpEaHpLdWtBTFhY?=
 =?utf-8?B?bFJILzUrazNSMENiZW44RVVMTjlYTWI0TzIrTWRDK09ISjZ6REMyMU44Z2FT?=
 =?utf-8?B?ZGlOWWdUMHkyRG5lY2haTEhGOWVNQWpscUVCc3dPT3RSRURWdFlXd2JPOXlK?=
 =?utf-8?B?NGdFYyt1UklkbWw0VTBnZDVCTXhYNVZ0U3I2UXUwc1RuUWE4dmxsMisrK2d1?=
 =?utf-8?B?VVhVb251WUJ2RjMxczFSS0h0ZERKRG1MSWNGMEdiV3lHWmNpQ0orTUlyY0lF?=
 =?utf-8?B?MWd1RGZESGhEd3ZzTjNmZmMwUU1tbFFPZ2VPWExZYi9HdTYrY0tmWHg2Mkwr?=
 =?utf-8?B?QWw4NERiWkxLNWIwSW9JWVVlMzdjaExySFM5R3J1MHZPL09lYWxiY1ZRSzA3?=
 =?utf-8?B?SDIxb003WHFYaE1YOGNucEFWMm05TGJDZ1JvYVZZbWVPWWJ1MVp3MDhxcTlZ?=
 =?utf-8?B?TTNscm1BNHAwWi9zb3AycjZ6SEw3R2N5MTVSZkdJUytSdjZRT2hHd0s5TllW?=
 =?utf-8?B?SU5VQkxWWHpHbzcrMnFzV3M1a2diTmtNNGx2WmRkQ2dhWit3ZEpOOGxBeEk5?=
 =?utf-8?B?bzlFQXkwNHlZMkxxbGtaaENwUHl1NHJtKzBUS1QzTHFDeC9PMENjME90TFBn?=
 =?utf-8?B?bElxYzRuOFlobGVHL1JDcWV5elZCYXd5cmpIZzNacnRReHBLMTZLVCtFcHFP?=
 =?utf-8?B?Wmw4RXZjZHl6aUtFK3dSdVh4RDFjRFRzRDRVbkZIYTd1Q004R1k2RkJJMDc5?=
 =?utf-8?B?U2ZyUVoraXlmYXhvZHdjaXlhRXREdzIyKy9ocnNFWGErQjhKZ3ZjWDZXUDA3?=
 =?utf-8?B?anJuc0E4WTlSRVZxQ0RSVHZ6Vjk0elBkQldnL1AwSEJxK1pCRW1ZaW01di9y?=
 =?utf-8?Q?+F/7/3utjmp5nuI9AuU8Hcy82?=
X-OriginatorOrg: nwra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec5223e-2799-413e-3c7d-08dd8cd7c58d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB11875.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 19:54:11.8187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 761303a3-2ec2-424e-8122-be8b689b4996
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB11207

--------------ms060002080607000103030206
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 5/2/25 11:29, Orion Poplawski wrote:
> One of our users is struggling with multiple kerberos ticket caches imp=
acting
> access to NFS sec=3Dkrb5 mounts.
>=20
> Because home directories are NFS mounted, we use GSSAPI auth to forward=
 a
> ticket.  But then we need to kinit to have a long-term renewable ticket=
=2E
>=20
> But we seem to be seeing that new ssh connections which create a new ti=
cket
> cache break access to the NFS mounts, resulting in "permission denied" =
or
> "Stale file handle" messages.  Switching back to a renewable ticket cac=
he
> seems to resolve the issue.
>=20
> Any suggestions?  Is this expected?  I would have thought that the nfs =
access
> would work with any valid ticket.
>=20
> NAME=3D"AlmaLinux"
> VERSION=3D"8.10 (Cerulean Leopard)"
> nfs-utils-2.3.3-59.el8.x86_64
> 4.18.0-553.50.1.el8_10.x86_64
>=20

More details.  The issue seems to arise when doing gssapi delegation from=
 a
macOS client to the Linux box.  If I have ticket on macOS:

Ticket cache: API:427671FC-DB63-442F-ACA4-13A9194F4398
Default principal: user@AD.NWRA.COM

Valid starting     Expires            Service principal
05/06/25 13:29:54  05/06/25 23:29:54  krbtgt/AD.NWRA.COM@AD.NWRA.COM
        renew until 05/13/25 13:29:50
05/06/25 13:30:30  05/06/25 23:29:54  krbtgt/NWRA.COM@AD.NWRA.COM
05/06/25 13:30:30  05/06/25 23:29:54  host/host@NWRA.COM

and ssh to the Linux box, I can't access the nfs mount:

-bash: /home/user/.bash_profile: Permission denied

Ticket cache: KEYRING:persistent:30657:krb_ccache_efgrZpc
Default principal: user@AD.NWRA.COM

Valid starting     Expires            Service principal
05/06/25 13:30:30  05/06/25 23:29:54  krbtgt/AD.NWRA.COM@AD.NWRA.COM

I also notice that the ticket is non-renewable.

If I then kinit I can access the home directory fine.  Other than the new=

ticket being renewable I don't see any difference:

Ticket cache: KEYRING:persistent:30657:krb_ccache_efgrZpc
Default principal: user@AD.NWRA.COM

Valid starting     Expires            Service principal
05/06/25 13:31:27  05/06/25 23:31:27  nfs/server@NWRA.COM
        renew until 05/13/25 13:31:22
05/06/25 13:31:27  05/06/25 23:31:27  krbtgt/NWRA.COM@AD.NWRA.COM
        renew until 05/13/25 13:31:22
05/06/25 13:31:27  05/06/25 23:31:27  krbtgt/AD.NWRA.COM@AD.NWRA.COM
        renew until 05/13/25 13:31:22

Actually, I also notice now that there is a krbtgt/NWRA.COM principal as =
well.
 I wonder if that is the difference.


On the initial connection I see:

May 06 13:16:22 rpc.gssd[1539533]:
                                   handle_gssd_upcall(0x7f9c73b2fc80):
'mech=3Dkrb5 uid=3D30657 enctypes=3D18,17,16,23,3,1,2' (nfs/clnt2c)
May 06 13:16:22 rpc.gssd[1539533]: start_upcall_thread(0x7f9c73b2fc80):
created thread id 0x7f9c69d07700
May 06 13:16:22 rpc.gssd[1539533]: krb5_not_machine_creds(0x7f9c69d07700)=
: uid
30657 tgtname (null)
May 06 13:16:22 rpc.gssd[1539533]: create_auth_rpc_client(0x7f9c69d07700)=
:
creating tcp client for server server
May 06 13:16:22 rpc.gssd[1539533]: DEBUG: port already set to 2049
May 06 13:16:22 rpc.gssd[1539533]: create_auth_rpc_client(0x7f9c69d07700)=
:
creating context with server nfs@server
May 06 13:16:22 rpc.gssd[1539533]: WARNING: Failed to create krb5 context=
 for
user with uid 30657 for server nfs@server
May 06 13:16:22 rpc.gssd[1539533]: looking for client creds with uid 3065=
7 for
server serverin /tmp
May 06 13:16:22 rpc.gssd[1539533]: CC '/tmp/krb5ccmachine_NWRA.COM' being=

considered, with preferred realm 'NWRA.COM'
May 06 13:16:22 rpc.gssd[1539533]: CC '/tmp/krb5ccmachine_NWRA.COM' owned=
 by
0, not 30657
May 06 13:16:22 rpc.gssd[1539533]: looking for client creds with uid 3065=
7 for
server server in /run/user/%U
May 06 13:16:22 rpc.gssd[1539533]: do_error_downcall(0x7f9c69d07700): uid=

30657 err -13


after kinit:

May 06 13:31:27 rpc.gssd[1539533]:
                                   handle_gssd_upcall(0x7f9c73b2fc80):
'mech=3Dkrb5 uid=3D30657 enctypes=3D18,17,16,23,3,1,2' (nfs/
clnt2c)
May 06 13:31:27 rpc.gssd[1539533]: start_upcall_thread(0x7f9c73b2fc80):
created thread id 0x7f9c63fff700
May 06 13:31:27 rpc.gssd[1539533]: krb5_not_machine_creds(0x7f9c63fff700)=
: uid
30657 tgtname (null)
May 06 13:31:27 rpc.gssd[1539533]: create_auth_rpc_client(0x7f9c63fff700)=
:
creating tcp client for server server
May 06 13:31:27 rpc.gssd[1539533]: DEBUG: port already set to 2049
May 06 13:31:27 rpc.gssd[1539533]: create_auth_rpc_client(0x7f9c63fff700)=
:
creating context with server nfs@server
May 06 13:31:27 rpc.gssd[1539533]: DEBUG: serialize_krb5_ctx: lucid versi=
on!
May 06 13:31:27 rpc.gssd[1539533]: prepare_krb5_rfc4121_buffer: protocol =
1
May 06 13:31:27 rpc.gssd[1539533]: prepare_krb5_rfc4121_buffer: serializi=
ng
key with enctype 18 and size 32
May 06 13:31:27 rpc.gssd[1539533]: do_downcall(0x7f9c63fff700):
lifetime_rec=3D10h:0m:0s acceptor=3Dnfs@server


--=20
Orion Poplawski
he/him/his  - surely the least important thing about me
Manager of IT Systems                      720-772-5637
NWRA, Boulder Office                  FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/

--------------ms060002080607000103030206
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
ClEwggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEU
MBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0
OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVu
dHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24g
QXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1
c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykg
MjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0je
rm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOs
V7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8
XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIML
WAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9Z
UdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUF
BwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCsw
KTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIw
MAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmh
JAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9C
k6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+h
APANSxRRRvRocbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0
CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYK
W8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4x
ELH2l47+IIO9TUowggU0MIIEHKADAgECAhBOGocb/uu4yQAAAABMPXr3MA0GCSqGSIb3DQEB
CwUAMIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMw
d3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYD
VQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIg
Q2xpZW50IENBMB4XDTIzMTIxNjIxMTUyNVoXDTI2MTIxNjIxNDUyMlowgbAxCzAJBgNVBAYT
AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdTZWF0dGxlMSYwJAYDVQQKEx1O
b3J0aFdlc3QgUmVzZWFyY2ggQXNzb2NpYXRlczEbMBkGA1UEYRMSTlRSVVMrV0EtNjAwNTcz
MjUxMTUwFgYDVQQDEw9PcmlvbiBQb3BsYXdza2kwGwYJKoZIhvcNAQkBFg5vcmlvbkBud3Jh
LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKn5wO5Bjob6bLDahVowly2l
AyCWBHGRq1bSptv7tXpj+Xaci4zpCqRoyqX0Gjpo8BEulUYQK8b7nO7UM3aMLC8H6vyzQ64A
GupPGIKuJg+Qr8jA0ihCVH+duE0bNXfDPTm/8VsXOubmVLPLp0cejxzrEC/RI5l8rdl0sQ+2
QZp9jTlyghB1Rxt2AYVYhVVnRMSJ8RgKp9MLV3qIfHqF1k5MGBIP6rS1afmlGd/yW9IWSB8z
iASPtr/Ml5ObbxtYZG47kCKCS7RF2rI6rGNmK/R6cITRs37dzUfBmagDFV897wAW3tHTyLQM
4vobhmS2UYi8C5voc+I75LYOsvLaXHUCAwEAAaOCAVEwggFNMA4GA1UdDwEB/wQEAwIFoDAd
BgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwFAYDVR0gBA0wCzAJBgdngQwBBQMBMGoG
CCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwNQYI
KwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0OGNsYXNzMnNoYTIuY2VyMDQG
A1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5uZXQvY2xhc3MyY2EuY3JsMBkG
A1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8GA1UdIwQYMBaAFAmRpbrp8i4qdd/Nfv53yvLe
a5skMB0GA1UdDgQWBBSZhCz4u7bZ2JjPtNAM8gx3QVEp1zAJBgNVHRMEAjAAMA0GCSqGSIb3
DQEBCwUAA4IBAQA2L6VG0IcimaH24eRr4+L6a/Q51YxInV1pDPt73Lr2uz9CzKWiqWgm6Ioh
O9gSEhDsAYUXED8lkJ3jId9Lo/fDj5M+13S4eChfzFb1VWyA9fBeOE+/zEYrSPQIuRUM324g
PEm8eP/mYaZzHXoA0RJC7jyZlLRdzu/kGqUQDr+81YnkXoyoKc8WeNZnSQSL+LqRvPJCcCTu
JbCdd7C8zYW1dRgh4d9hYooUSsKTsSeDoRkFyqk4ZH0V3PFqa2HiFrdi8h3vpBX44VFddyaa
e+ekomLvvVZWGtJgXWr6VEBo8PTah0fw8BQjCIfFym44D9dulz1YW7E6FRPMSZ7x8X3UMYIF
ZDCCBWACAQEwgbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkw
NwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVu
Y2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3Qg
Q2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwDQYJYIZIAWUDBAIBBQCgggN6
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUwNjE5NTQx
MFowLwYJKoZIhvcNAQkEMSIEIN3XNlXQMKR/HIQ3NRbYIUqbIU4H8f61ly8GzY+8OXi2MIHL
BgkrBgEEAYI3EAQxgb0wgbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJ
bmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSBy
ZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVu
dHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEE4ahxv+67jJAAAAAEw9evcwgc0GCyqGSIb3DQEJ
EAILMYG9oIG6MIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcG
A1UECxMwd3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNl
MR8wHQYDVQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENs
YXNzIDIgQ2xpZW50IENBAhBOGocb/uu4yQAAAABMPXr3MIIBbwYJKoZIhvcNAQkPMYIBYDCC
AVwwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzANBggqhkiG9w0DAgIB
BTANBggqhkiG9w0DAgIBBTAHBgUrDgMCBzANBggqhkiG9w0DAgIBBTAKBggqhkiG9w0CAjAK
BggqhkiG9w0CBTAHBgUrDgMCGjALBglghkgBZQMEAgEwCwYJYIZIAWUDBAICMAsGCWCGSAFl
AwQCAzALBglghkgBZQMEAgQwCwYJYIZIAWUDBAIHMAsGCWCGSAFlAwQCCDALBglghkgBZQME
AgkwCwYJYIZIAWUDBAIKMAsGCSqGSIb3DQEBATALBgkrgQUQhkg/AAIwCAYGK4EEAQsAMAgG
BiuBBAELATAIBgYrgQQBCwIwCAYGK4EEAQsDMAsGCSuBBRCGSD8AAzAIBgYrgQQBDgAwCAYG
K4EEAQ4BMAgGBiuBBAEOAjAIBgYrgQQBDgMwDQYJKoZIhvcNAQEBBQAEggEAjEiOjVAXo/Ip
f8uCbbjrZQA6M3HPntY1vPrC/+qpDVIk/BHpPcunQ+WV11b1+HYm63puL2hjH3cZOplFmzK/
lqOimqvVpv/KrdqBS3d+hHB+GVw/QIO+70lYBir4n2DZAi8eanhJVqScCP0gWgfipQckC/20
53XqHFEzAC22BuZSQFfI8GEvhyBkAOJIrtCcPPHYFr3fC0R4wwB/D+ewLEOxMYQmKsSTsFtP
q0a7GVRxptyK27kbnMk0gXluXtyH1oU3oW9C7MieNJ6Y5wtsAZjtcJYHZICSmx0sBzIBrH27
Ia9/3qURvZrlIdj8geoOIJG665KfGClplCW2WvXplQAAAAAAAA==

--------------ms060002080607000103030206--

