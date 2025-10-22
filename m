Return-Path: <linux-nfs+bounces-15523-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58FBBFD8C1
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946071891DE4
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B212868B5;
	Wed, 22 Oct 2025 17:23:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021122.outbound.protection.outlook.com [52.101.62.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6027FB18
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153784; cv=fail; b=aoT07PolJVb8nahQ38dzzPlwwq+rPT3V3vaf0HNfXBJDDjXC5e9iqAKH+woN0zkrW2IgDMk7T7gfGZYCsR6Rla5hmRSEfO9WWNDn17pREjyURmkBOB4vv94wwlM+lvhlR31VuBdkPF15ohBkirs44EsCcjbQpQrEdW9MNi/sRk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153784; c=relaxed/simple;
	bh=+qChy2i2HD4oOldLmRb2a7I2j4Yl6EuQtaMP/uKdRKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ebOdfxwXw38gJxkRiw7MHhKce3Ew4rxsaC2AaHSbuJoAiCxS1KfRYQT6j8DxkdXZZX+7IWQHtUYeTBdTYqRHoujJJ7h4n6fhK0yLJ8c3Avw4pp9JlzL8MbHDflNU7VD7UqQTkPijWBafyEe2akp7Pci6JqkjEOz2JnoCdUs3tkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.62.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BP809jVNi5NQ0RLz67N3EzcYUPcKmYron2hcwx94TxSoA5ZgyLhxIkArmffcJPentcskwZZFJ6QswCQtT1dJx3tGHD3uhitr30PiJqAuf1LqY08uGAo4XQG4+dhN5nafq2yZ6H0gQn2Ln04j240IfhBe6yyqAD4gkQk63YiAcscGGD0VKtHSTTeGlUy/Jt24Pkfn7dodR9+UpQ+6qXCKaxkqDr5ZBygT9q1mnEMRbZg+VKYzmzPBd2xRiesR/bP4xm7m7en1KZH1Ho9SvZfZkB6QKaAus1cXAjfroFXIZ3fmE+VfTdmhEErioSbU3WZA8UZBtrpD01Cauo2mIRgjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeTWwH0t+z6fkCRM3N+E/Wt0C4/bPJjE05UFAwlAiF4=;
 b=PCiY+1rEedA1u7NL+HFuaxq2p5wZLOjFTh2PVpYYbfnHseHwF/gHjO/H9qFsUxN4t1wjI2avBs9jCgAbaNS62RmHcHU0O2/Fvj+PrDy3cMUjAQ0N3N5FRGSZR1tTU8RVpkkspY9q2wF/eljTEQ7j47H8wkXXIuGrGfmpNT5SavtiMZONjp8ajWml2ahiLAbyE9nyHIQCgVeZMGAA5g4x+WyenZeMm85Lj8bsfDd4gUINi0lXB7JIQhllgv2oWX+Z9AHBd/dpPbge2xQ2hKorqWzvOeftoc6Z/ttfCAVVFKnBhh28Cvw8RfyxfwR5u4judB+cJkIJy+2/GEmrTF2Y6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from CY3PR01MB9193.prod.exchangelabs.com (2603:10b6:930:109::5) by
 CH5PR01MB9007.prod.exchangelabs.com (2603:10b6:610:212::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 17:22:58 +0000
Received: from CY3PR01MB9193.prod.exchangelabs.com
 ([fe80::5c00:ecc1:1c8c:15cc]) by CY3PR01MB9193.prod.exchangelabs.com
 ([fe80::5c00:ecc1:1c8c:15cc%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 17:22:58 +0000
Message-ID: <63c79d16-fec8-47f2-ace3-0b8fd4f41528@talpey.com>
Date: Wed, 22 Oct 2025 13:22:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Make FILE_SYNC WRITEs comply with spec
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Mike Snitzer <snitzer@kernel.org>
References: <20251022162237.26727-1-cel@kernel.org>
From: Tom Talpey <tom@talpey.com>
Content-Language: en-US
In-Reply-To: <20251022162237.26727-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:208:e8::30) To CY3PR01MB9193.prod.exchangelabs.com
 (2603:10b6:930:109::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR01MB9193:EE_|CH5PR01MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b9da04-5b04-4447-0059-08de118fa526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czNKZVVVUTBSbk9GT0tVaGR1OUxVdGlwcWE3blhqQ1JoZGhhTy9hYSsvdjYr?=
 =?utf-8?B?OVFkWXI5TGZzWGJvU3gyaStkQVJ4eTlkOUMrZGVOUVJlTDBpTmxHMllvNUp2?=
 =?utf-8?B?bnRSSlBad2sxREZVbEhLRld3cm9WenpRcldlSzNvQ2VZRE1EaWNXM0RNK0RV?=
 =?utf-8?B?b0JlblplWmpwVWd2aVJLL1BjaGM2c0drc2c3RHdCSUc3VVVTajZrem9mZytQ?=
 =?utf-8?B?NzBnYnBlelNOditvYTNBc3p3L1h5M1ZKNGEzQmxCeHlBZC9zYlV1c2k5MVZH?=
 =?utf-8?B?Y0VTMFZXdmRpWjF0c2tvbVV1QTVITFpBU1IrOWI5TDZBNXB2QzRZa2lDZDl6?=
 =?utf-8?B?UGJObXEzOFFmUldaWHI3RGtnb1VVRllpM2hqaTZRNE8yUVJweWZzZHlCS1ZO?=
 =?utf-8?B?eWhrUzZMVkdLOUhFU2JiYkt1MEtSNkE3aitNZnRWenY4bFBLQ1FybVhvK0N5?=
 =?utf-8?B?R1hqUHdxRFBpVnRKRUxpdkpaZ2VnZXJ4VlV2OWY2NVpkRVpESVBlQWlhMFlJ?=
 =?utf-8?B?a3FmdTM1ZVBmMktrZHZDNGpSRnJtK0JTMlZMYytQQ1dXang0c2diR3VGZlY0?=
 =?utf-8?B?bHhna01GMHJKQVRJdmhNbTBGbmhjQk1UdTl6UWw2R1pVRFEzemdIRnZUYklU?=
 =?utf-8?B?UkJWVG5Za3VOVjFvWjR4Yy9uVDVoRFA3NkF4U1JtZFh6d0VUK3RVSzlTb0t0?=
 =?utf-8?B?RXJlQWFDZG1IMlhLTjdSekFYTkhEYk5GK0YzZDMxWTRhQmgxTlAzcXBobG5K?=
 =?utf-8?B?UjlES0RwczBQRHpHOU1LUk9GelVHVVBEZERUc2x5bjZwTmkzUFdxUmhkczJ1?=
 =?utf-8?B?VHIzb3daVEdEaXREL3pPUHZYMzlDNGRJWkcyNTU0MUJDVmt2Q28xdHNON21I?=
 =?utf-8?B?SU1ic09vR2VxRUo2L0dtUzNwcGgvMjIyemtwbmNWQzNQa3dxZENVTkZDZ2VK?=
 =?utf-8?B?M3RZR1hBR08zdjZISjNCN0NDQ0ZuSEZNRGsveFBPUFNTbEt1TjJWQkpIaEQz?=
 =?utf-8?B?a2NUaHpwUWc1S3FPQlBJN0VObFBtdWZwVkp2ZVIwYlhKeTM1OHpoaFdWOVho?=
 =?utf-8?B?V280cTRrd3ZZY2JhV2dZN3ZZZGpUYU5YUEVhaDRwSXFiZkxZSGJndUdYZmpB?=
 =?utf-8?B?Y2lGQlRhditycFh3ckJIajEvNFRYVUFMTGhuYVBhUmsyZmhMZGZZMjFZN3dt?=
 =?utf-8?B?bWVURnU5aTh1emZWYmpmWnlCb1RmMnNnZ01YSXM5Z0tDNnY2NE5YWlRqcU1u?=
 =?utf-8?B?Q0VwYTFrL2Q4bFNBaEdaUThlck9UTWsvbEpLUUxTSVJlZUgvUXp0YURxK2Zr?=
 =?utf-8?B?aDJ5ejJwdWY1cTdQd25wZ1NpMk9vbTFKWGlhV3ZZcEpJb3lRZGJHSStQcC95?=
 =?utf-8?B?S1VlRko2ZktHdHpsR3dPWmZseDc5cjZZUXc1Vkd4akJtNTJiRi9yUnJXRWhj?=
 =?utf-8?B?RFEwSmlJNEVqTlRyL25GVHpJT05NS0hkSmp2VWhIV2cydmFFZUFoVzcvazRs?=
 =?utf-8?B?b2JRamNyemVZMHJja0RmN3pERzl3aWFWYTI4OHFCaVE3UDVuYmJPTmhmR3h4?=
 =?utf-8?B?OTMxQ3F2QjVmVGpBZldpcFFGSFV6N2gzMEV5YXFuRFphZFRJQjdJY0tnTjQr?=
 =?utf-8?B?bjNObnU3dzJjbnIyUVl0KzVPS1RWelkvbjJBKzJTWEhqUW8wbld1cjhEL253?=
 =?utf-8?B?ZFFFNC9Tcm1JQkZGaStaZEV0UHNMQzViT3c1N1ErUEVLcVJhOWFNM09jMlZi?=
 =?utf-8?B?WFRYMVZZVjA5TlF5UlhOZHE1ZitrZnFWWm0veHQ1MndUOEhZUmhUM09KdWRw?=
 =?utf-8?B?a1VYd244VEJnUkpVZHJVZFZKL2JhNEp0Rm9PTi93KzNKem1HL3ZJWmZBZnVT?=
 =?utf-8?B?TEZaWnNhS1U5bVZxNTU1SFJ1WG1Vd1dUV1VmUGtFZjBIclVlSCs4U2hMV2U2?=
 =?utf-8?Q?VFnh8wdGEygfWGRSzCnMcm1+LuhhaThZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR01MB9193.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGhoVkNEYkNFbHM0MncwNXJzTld1Q016N2V5bFJLZ0lGWUpkYkVwSTNvME5y?=
 =?utf-8?B?em5NUVE4ZHJpWUhpZGdoWmJ6dHd4NnZGRnBKdnZaVjQ4Nk0zeGVZeUQ3ZTlF?=
 =?utf-8?B?aFN4QXJadHBTQkdMbVJaeDZNV0hHVTdDUkdRWXFpTnovM29yZTJMcUxDQVZU?=
 =?utf-8?B?L21nY2pkdjJ1a1dzRWFXVVZIM2F4dGxaZDJnVURwN3U1dWZrK2cvZGkwSzE0?=
 =?utf-8?B?RTAvRXk4TXdDenVDSll4YnBZR2JJT216aFo4SmdGUmxmSURxMmpwVUtENHE0?=
 =?utf-8?B?UE8zNHVsRzlUcURXamlzSGk3Y0ZBTTRoQnBTOUZob1BweUtxT1Y2cjZjQVcx?=
 =?utf-8?B?czhYMmhVWGF4cVI5YlB0YzJLMm9qdFBYUEMwVG1vUTVtd01YY1FlTEYvU1pv?=
 =?utf-8?B?RE45N0s2SW9DZUg0d2kvRnoyWGl1dmlTZmMrN0RkQjVPWW80Wk5HaWdranNQ?=
 =?utf-8?B?T09pTWNqeFVFZGpwbEVnZmg0QlhHK1hXQzd2ZVJvZHRURmVzTFcyblZmY3FG?=
 =?utf-8?B?R3dsalNvS2JyeHBtNjVTOUo4Wml3VGVBWldQR0tVenVpVWI3RWVSQTJieThJ?=
 =?utf-8?B?bldqdVYyZi9NazNqSk9yWDI4RVN4ODBNc0ZyZExBSFBZQjhhRVZEREFveGxo?=
 =?utf-8?B?eXpNeFFjVzFXVTNVRTBCbWU5TWZ5VUJ0cWlkYWxrMnJnYXhlR1hjNTJ1K0RG?=
 =?utf-8?B?aDllVW1OT3VkRkdRdnZtcGJSSTBrRU56VmxWZlBJbEhCTTUwbkhUdG5qVVpI?=
 =?utf-8?B?L0pEVHJoMUVVMlR0dm5odDkxem9nNFpNL0d5VVBoNis0RUR4V2M1NDdtYSt6?=
 =?utf-8?B?TmJ3ZlIxeXB4YVJoNUFMNlJXdWJzTXBsYWhMUE4yck9vKzdPUkxtQVA4OWcr?=
 =?utf-8?B?ZWJyYm92SzcxMFVPYk02SXcyK3o5TUcyVUQ2TS92U3B1T2lGb1hjTldnNTA1?=
 =?utf-8?B?QmVwQS8yRmswc0tDV2JGTDNvcjU4b0htSW5vNzN0ODJvU3lHUmRkU3g5cXZO?=
 =?utf-8?B?a2FBakZPQVdtaVJ0TWs1eEtOYWpPWWorRG4xb0w4WTN0VDY0RDFDRXNQRXlP?=
 =?utf-8?B?VUV1ekdLWENNcUtsY0lqZjdrbFpLQlRUZDc4QnNXN1c1dzZKTTdRK05SSkZn?=
 =?utf-8?B?TFowTGZlVStGbkRxNnRnMkR0YUZrSEgxbkV3YThHYXU5eFF1UnJFMkFPakps?=
 =?utf-8?B?L0M2U3NKWG42eUtWQjdhc0g2L3lXSFBmaGgyd05Yb0ZjSHRVa1ZYUDFycVA2?=
 =?utf-8?B?UVdqNWJxNGxydE8vdUdheTV6RG1pYUcycDJsYnRZV3I5NEpXNmlFSDlUZEdj?=
 =?utf-8?B?RldISEVRZGF0TkdIbzQwajFsdnJ3dGxNeEJOM3dOMkc0MFF1T1F2bGxRRFBy?=
 =?utf-8?B?S2MvRkxPdnpwei9wQ2dVZ2czdkdxQzFlMnFYL0JXZ2p1NEg2SnVqc0oySjIw?=
 =?utf-8?B?b1pEcEdqNlRKYWVweWJEQnFFMUlGbCtCVk5SUUNXaHVudzhnNkdVYXlsWGl4?=
 =?utf-8?B?c3k2SkVrRWl0M0htVVI0MTAwT1NMU2lRbDluZzNHNzJUdEQva3p2cmtDaUxP?=
 =?utf-8?B?bDMvc3B0ZnVFeE01SXozUE00Rm9sWjBGWjY1OGFmanlFeG1aVmVOTEVsaFJE?=
 =?utf-8?B?N21pSXovYisyc081TlI2V0lLVml3M2ZOREc3NC9kWkxlUjduTWw1Sll3ZVBD?=
 =?utf-8?B?dTZqeDZvK3hDbENjSkc1elMycUp5aDQ1ZjVjZHBKM3IyK2dNZnhmV1VUUmIv?=
 =?utf-8?B?cTFkajZuQjZobitWSVgrc1FaM3JuS1AySEl6S1V3cExmL2tkSWNTeGx4ZGpa?=
 =?utf-8?B?b1hURHFIR2kxR0xnam82SHRyby9mMmFIKys2djVEUGt2WEJ1L2hpUFhFWGxT?=
 =?utf-8?B?WkVCZk9EZVYvWmZRZ3plZGFzaDk0YkhCckpDUkZiY2F6Ky8xUVlUc2tsaDdj?=
 =?utf-8?B?UHF6NmZseUQzUGhFVVRGc0RpdXVYRmJMdFNqUkFsT2tNN1lGMm5CWVAvbjdX?=
 =?utf-8?B?Z2h2d0E3bkRSYmNCUEhTNHNZQjl0RG8wL1Zoc253VENKOE8xMmJDWmFib3Qr?=
 =?utf-8?B?d2psT2Z2MnFKRUNyUWN0bDVVMUw5QmpBQUxVUlpvUmxwM0prYlk0WmNEbllh?=
 =?utf-8?Q?H1kyzZ+BkVMJn1MEpICnd70wo?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b9da04-5b04-4447-0059-08de118fa526
X-MS-Exchange-CrossTenant-AuthSource: CY3PR01MB9193.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 17:22:58.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoaUsWJFpRlRiUQHszCCv0dEMid+5w34d5+HqxxhVfQ2wLjJdLUjIaKkM6kiV/vF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB9007

There needs to be some statement of the performance consequences of
removing this "optimization". I'm going to predict it's significant
on rotating media, and should not go unmeasured.

The commit message needs to more bluntly state the fact that the
server has been violating the quoted MUST. See previous paragraph.

Tom.

On 10/22/2025 12:22 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Mike noted that when NFSD responds to an NFS_FILE_SYNC WRITE, it
> does not also persist file time stamps. To wit, Section 18.32.3
> of RFC 8881 mandates:
> 
>> The client specifies with the stable parameter the method of how
>> the data is to be processed by the server. If stable is
>> FILE_SYNC4, the server MUST commit the data written plus all file
>> system metadata to stable storage before returning results. This
>> corresponds to the NFSv2 protocol semantics. Any other behavior
>> constitutes a protocol violation. If stable is DATA_SYNC4, then
>> the server MUST commit all of the data to stable storage and
>> enough of the metadata to retrieve the data before returning.
> 
> For many years, NFSD has used a "data sync only" optimization for
> FILE_SYNC WRITEs, so file time stamps haven't been persisted as the
> mandate above requires.
> 
> Reported-by: Mike Snitzer <snitzer@kernel.org>
> Closes: https://lore.kernel.org/linux-nfs/20251018005431.3403-1-cel@kernel.org/T/#t
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   fs/nfsd/vfs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> This would need to be applied to nfsd-testing before the DIRECT
> WRITE patches. I'm guessing a Cc: stable would be needed as well.
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f537a7b4ee01..2c5d38f38454 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1315,7 +1315,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>   	init_sync_kiocb(&kiocb, file);
>   	kiocb.ki_pos = offset;
>   	if (stable && !fhp->fh_use_wgather)
> -		kiocb.ki_flags |= IOCB_DSYNC;
> +		kiocb.ki_flags |=
> +			(stable == NFS_FILE_SYNC ? IOCB_SYNC : IOCB_DSYNC);
>   
>   	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
>   	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);


