Return-Path: <linux-nfs+bounces-10512-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4693A54E9A
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E9716C2A8
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6004E211A3F;
	Thu,  6 Mar 2025 15:08:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021073.outbound.protection.outlook.com [52.101.62.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF620E337
	for <linux-nfs@vger.kernel.org>; Thu,  6 Mar 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273738; cv=fail; b=NfpHsEspx8HzG7bxy2b+JkUjbJNq+2Hz3q2gzDuTgifWUM3jL6SXGsFHEHUh5Vh9Pg7kkxw02QWhQdvvpxqXnodeP26b6fDKtUIVYYIT47F6by1X80FiQ2mnVQBbkb5yhrMukh09uuLYiqGXzxiKo6xdugRhOPYM70ZGwNuG8ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273738; c=relaxed/simple;
	bh=hGPZBVuLT7uU8JXyJ833VTH63HEH0dOCbsDAVN54syw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pStVxE54ThfllebYROn610Oaw1qBUiCL+5Pr/5/HQ8x5+eSsMTuZNGh72QoVeIpq0IM/xx4/r/SksSsUevGmJiiiw2aXEXwaPnDcTJYVqlyJEIn+I0gWAUUWGa8+14dIcuMtHtallvtCVjFT3H9reo0SMai8ETbc7fwKeiBV/Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.62.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq6xyzinjSaT+XMJEkeNxaosNlp8HnOjl0tcBPVjWG8BkMVK7a25z/Re4DDXQqeNjHXbVggrZxH5CrCdCjgL8Mnfn2VcRaMnFPSP1A2fWMhbi7qizPbUOWGFIkdKLvyJ8cVphzk4onxBT+ssJP+D1VduevoRNZRgUAZ+tzR/bGXqbdS+WpvQk3gvyCFHRB37PobkBWZsE7UG5UJuPfdNF/dli0ofrOUGfmVdPmvRfknxupv9V5ONHbSoTd2GI7AdGFy0V9VGhuxhHP1Fth7y9bEbbBWIKmU19CkTd8uptycLnqn9e6q5tLqSE8MWX0ukxqFe/NTbOdp8i8SZ8ogoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b6aEpf92vj9Y31iSKd6im96vG80H+GRPF6dVt+akRw=;
 b=lBDBblw6/1eBtukd79g94RcorTngKHVdFThxYvmj5Z1dZEpoQUjDkumdLNuCbPD2G4GXovLWiYQ2eW+GFVRc6m6ZLgGLTLi2tvIpIJOul6o2GJ02H5AVaMGncdipZys5IkezaAX+npR5uwyTVL/GaKIKL9G2N5HXEjJ068P1pb4vNW3lqKKwV2T6hTIje0NztwOD1Ky/U3UWE6dpqWECL3utIhH4r6KND2Zj1XRvgWeWib+pnCVxcPBh7d+N+dR9n70Iuhz+R8K3K5lQRtAWWhi4JFZCKoypZCzL7CVoLx0e98+o66+LwDOr4XnYuelDykCCBC0UjcAkbTlaRc02zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 PH0PR01MB6684.prod.exchangelabs.com (2603:10b6:510:79::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 15:08:50 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%3]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 15:08:50 +0000
Message-ID: <88a702d3-8f1d-41b0-9e41-6ca09b77b8b9@talpey.com>
Date: Thu, 6 Mar 2025 10:08:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] NFSD: allow client to use write delegation stateid
 for READ
To: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
 Chuck Lever <chuck.lever@oracle.com>, neilb@suse.de, okorniev@redhat.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
References: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
 <1741120693-2517-3-git-send-email-dai.ngo@oracle.com>
 <22c1c21fde3a5b17851207664571341e3dcfc315.camel@kernel.org>
 <ac7d9408-c1fd-4f4b-88a3-162a9f3cf176@oracle.com>
 <24582f1bb0778852feea0e676b7db163019c1b4b.camel@kernel.org>
 <96135388-c965-45b0-8c81-03b680136757@oracle.com>
 <deb67458-fe9e-4303-b310-587b404c9d80@oracle.com>
 <30e405d15a33d2fd809a6e8daa8c5bc01e677b84.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <30e405d15a33d2fd809a6e8daa8c5bc01e677b84.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:208:a8::39) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|PH0PR01MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b27065-f2da-4e00-00c1-08dd5cc0cd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3FZaDM1SDlXTWg4RE1ydSt3MWpOTG0yYXhpaTlOVjdNYkl5dHFWNFpYWTNP?=
 =?utf-8?B?Y2J2MGZVa3RlMDVZdm5RTnR6YXRaRlFFU251MDZtVXhaR20xUTAwV1A5SDVB?=
 =?utf-8?B?eFpsYTRDeE15Z3V5VWx5UldUeUhSL3RuUW9ZRUhiTDdGQzRwSDFlTXRERVQ3?=
 =?utf-8?B?WVl2ZkowYzVuRmw5TmpFZ0RKQW1kaGZFd0NiRHlpL1N0VHlXMklmL0xESTFu?=
 =?utf-8?B?NS8rQVlRVjBTdGpmZXVFL2tyZXdYYlZRaldtR2c0NHZ0VWowamppcXNQL3Mz?=
 =?utf-8?B?S3JlS2pTa3VhQVJwVXk1aFBhREtQamRQTHdiNHR3UUtUTmI0bDJMOUFLOHJn?=
 =?utf-8?B?V05kbmN0NmVKcDBMNFVHWTB3Wjhza1lzR1kzYjc3ZlZ3NzhJOWtSdlM3Mjdk?=
 =?utf-8?B?SHRuMlorc0c0eVFLSy9GK0pFbjNXb1dOU1kwelNJS2hhNXJWTml3NUhmc2Ja?=
 =?utf-8?B?U2thdVp0UWNvMWcxbU9WYzNENXFqL2tvMkhJNzlqamMrT0VkM1c1MFU1QWt1?=
 =?utf-8?B?cXJyNWEyTyt6TjdqTlJJK3hVNzRWSnU3Um5wQ0FvSzBaL1dFejZRa2x5NUE3?=
 =?utf-8?B?T0NVZXorVHgwTXNQUk9uR1dKTElkbWRLbXJNN3FMWDY1cEt1WDJ0V2ZoN0xY?=
 =?utf-8?B?STNCbms0OW5YS2h4YXprc0VxR1lrY0xIU3UxWEtKUUNDek12a3k3R2FGT0o2?=
 =?utf-8?B?OUIxOUgrenZ1WDYyQSt1cG84SlRtQ01ldktaNzFWb1JaVzNaN2NoYkpnSmtP?=
 =?utf-8?B?a0JkYitmVmJrMUtBYUxhQ3pSQkRHbFluTjJydnpKekNXZVZHVjFDK29FUTd3?=
 =?utf-8?B?ZTdveC9CeEhHa0NsazF5WHdpWms4Q3lrZGJZYitTWkdsaFB2SnQxekhFUkg4?=
 =?utf-8?B?TDNjK3RaYzM1Ui9FMG9aRkZ4UHhLN0h1eHh2Q2gzZUJsZ2VZR1hzaHRzMk1o?=
 =?utf-8?B?MEkyM2lPRDhxOWpvdkpNZURRMUhQUmtNZHowVkYxMzZGbUo1SmRWZGYvL1BP?=
 =?utf-8?B?UjBvckFEKy9kNjZGQVZUQ2wzYUQrZ1cvVDE2eUVWWnBTdGtpOXBlNm03YzA4?=
 =?utf-8?B?bys1Vm45Z0FQUU9INzJkd25qVjAyT2M0Q0NlTDRuY0FaalRlZjJqRjFZamlH?=
 =?utf-8?B?anhTd0ZGR3llalAvUFVXVEhYYis5QUdxNG5VMnVSSGp6TDRaU2VlYkJNUVBU?=
 =?utf-8?B?VG9YWFQ2YWFLM3dYYndONk1YaGwzMTIraTdpS01OVzlMeHd2U2hDVEZXVjhn?=
 =?utf-8?B?OHZjU0tINnJvR0J5SnluMTA3NWtvUTY3eGhCaWVqY1o5dXpTeHZxT0RYeER0?=
 =?utf-8?B?U05YTFdCeVVVNjBEMzlFSDNxSTlaY1lvM1BwdDJUSGt4OW1TdnpYdFNpenQ4?=
 =?utf-8?B?VFZWMk9KS3liSDdlWUtjWldjUnlZdkpaVmkwcForUmtIay9XWTFPcHd2UGZl?=
 =?utf-8?B?ODVKQ0g5T3BEdVZxZWw4ZUZqMEFUOXRHNnJ5WGQwWllFNm9yeEpmeVp4MUdp?=
 =?utf-8?B?QXJwMWJsWEk1OHlFR2Zzc0xhaU4zWnZrU0FibWRLZ2VoSTdaUGtSRWZoRnZJ?=
 =?utf-8?B?Vk42am84WWhuR3l2dDY5cGlkVUIyKy9vdTNhZFFTOStSck80SUZzeE5yUnJR?=
 =?utf-8?B?SUtIQnFEeXFoZzIwL1dpckY0M2xEeVllV3A1TGtlbXdiMVdMVnhGanlqVEtl?=
 =?utf-8?B?MFFOMEZTd3RxWVNFVEkxbVZRUmxqZ0t2YU9MZzB6U21JdDhoZGNJdTV3M1dF?=
 =?utf-8?B?eXZFUkY0QWcvTFlEZGtOeHFOK1RQb01qNkpsOEJ2SXNWZ2k4Wk40UmtPeUth?=
 =?utf-8?B?dDV3anc5SEV4QjYzSGlhYk5hTkVxM1VPRVRhazVYcDFEN08xQm1qb0tKZjdB?=
 =?utf-8?Q?Q9bB2HYc6d0sS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUhBUVp1cWZybjlrbHFrT2ZDTnhzUHNXaklEN2wzbTIyTWlwOFI3UGJCbWtD?=
 =?utf-8?B?SitYYVZsQjhwWWVIbWNUWG81eHIxTmN6OGV4WDZSckVRNDdsdXdnZjAvS2VG?=
 =?utf-8?B?ajhNQjdPZTlZWi90WFh3UTZnM0lRZWNrWm1LQnBOd21lUDI1QVQzK0Mrajlo?=
 =?utf-8?B?YXQ5bkgvZ256bnJXcFZZUHJTSCszMkRkak5XWXM5MThmSldSb3FKUTBwT0Ru?=
 =?utf-8?B?OUxpOCtCTHJualBETmd1VHJZck1SditsV0JOeDl1U05pR0NYN2JkUDJlRzNr?=
 =?utf-8?B?K2pVU1l3WXZBaS9NY28zTEVxZG04VmZLNGFQeHZqTTM4aklKWEE4LzZsY1BG?=
 =?utf-8?B?OG1YbFB1ditpeWkyZEQwR1V5K1piaVVhTzZMS21PUlp4Yi9yQ1pVMkVnZno3?=
 =?utf-8?B?YWhpTDRsSTZpaC96ZEtHNUhwYitvc21rN1JkcVRoczd3UGx6aVR0di9vMG9Y?=
 =?utf-8?B?RDNvSjhlUFpNVXc0STlsdnU5eWVaUTFpbmFzNSsxQ2c3MnlBYzBRdWRILzJR?=
 =?utf-8?B?M1RkRWhaQjV1L3dUdG10YURoK0tUK3p3c2lSaUJaY1dDcGJDemdtWS8yVW92?=
 =?utf-8?B?N3lHMGMrSG5UOW5FN3U4dFUzdGphUzFvMUd3c1llait5K00zT1BvMFBWTkVt?=
 =?utf-8?B?OWg0a1ZrczdsT0tZeHhXclgvR1FsWWhxWjU4WUFISXQrT2RGeTNNUklBNlQ3?=
 =?utf-8?B?NFBDWVZiQ3BxSTdXSFpCMTNaa2puZUcwcklPWXNHS1lGTkNsS0JUTkhJUERp?=
 =?utf-8?B?UldFNXg5R2VHRjV1WU5QUFNBUWNLWStNampwcksyQ1FjNUV5aERkRkZGMk5Y?=
 =?utf-8?B?M0FFV3pzVlJNUUhSSG15M0tFZTlFZHhyS1M2ZEttU0lBeEtWNjRzc0dzWUQ4?=
 =?utf-8?B?cW1qRWI0SlN5Q3FiRVBOcjJQWlJWOEg4L2xUQS9vam9FZEFiWmZQOXE1TXBB?=
 =?utf-8?B?ZW5CUHd4djIxMmpnNDM5UERBQVJWNjNSb1lCUTIwb0J1cE5vWThyUDlxRng1?=
 =?utf-8?B?Rm85d2FEUjRjMWdzRytmQUdWanJoei9mT2NwUDU4M2VqWXdvdXE4ZmpzNHdG?=
 =?utf-8?B?ajZQUm4wcUQ5WEc2QXJiRnFWZUN3S1BjMlc3S1lWYXNVR0IzUzRYSjh3M20x?=
 =?utf-8?B?Ni9lNXJWaWVJRTdtQ1l5dGl1US94QWFwNmFMOGQxUVArSzFzM0RycncxVjl4?=
 =?utf-8?B?SmhmajlMazZieWc1RkRzRDAzeGlIYTJlSVJsOGI0Ni9PME50WW5VbTRsUDVF?=
 =?utf-8?B?NlVsMGhyUTJNMTRtWUpCY0ZvSVYwc1ZkbnJ4bUMxSDJJL2FSU3RGdGI0aGph?=
 =?utf-8?B?Y2N4RnVPcXpsNW5TQ2hjb0xYVmtWUlhjU0VIR1Z3QlVNNVEyNFAzSWpJMWZo?=
 =?utf-8?B?cXA2TDkxSU1yNUdlL2dTc2RydkdNV1ZFTDI3UUlLeTc0NDRNYlQ3SkVRM25t?=
 =?utf-8?B?bDRiNVdhZUg4UVFDL3lIc2Vla0Vhc25scWhPNGs0VDN0cWZFVDkyYlZtZExS?=
 =?utf-8?B?ajZ6RDE4QnRoZU11ZDVSbnJwbSs2ejJZT0RDYUZ5dmFxbHBXUnBERkdrZHFr?=
 =?utf-8?B?QVBtRUlqbHpZNTgxTm1oK2Z2dHFURGhlRkwwaEJaYVF5SjlLaDV0RFRGZEVF?=
 =?utf-8?B?UFF3ZElGTjRub2VvTEJuNmcwNDVjTjNzaXlvWUY2ODgxS1Y5U2pDVFUwb1Vu?=
 =?utf-8?B?SW5POXNwTUVZd2JUTXppYzZMRnJLS2JVZzJOUm11KzFWOFVlM0RkenNWK01t?=
 =?utf-8?B?amhQc0JNVVpMUHQwMUZHN2VUemFLRnAxZnhsQ3dEeFRqd3ZMdGpSR24vNTBT?=
 =?utf-8?B?a0Q5b3J4eExSVndIa2NPYTdUZnlEL3NvR3BRbktOdzdLSERkVnUrT28xaUh5?=
 =?utf-8?B?MXc0L1hEaDB3VWVBS2JXZHFGK2QwVlFlOUJ5cksrTEhKcVEwL2FLL0dSQ1RC?=
 =?utf-8?B?eHpSRzYvcnRuR2ZBT1NZNEt5MEFZSnRONnJVd3NMeVFTZGxmam52NzN0NjJJ?=
 =?utf-8?B?VVNkeG8rQkNkR2VscHROREhpY3ZQVGV2WkE3bDYxTytWSFdOTFU3OFhWQ2RS?=
 =?utf-8?B?MXI1ZlJDV0g2RXk4Tlc0VlJqdzJvVFhEc0tNQU5lTnpSdjg5anAzVjZ5VWVq?=
 =?utf-8?Q?SYXQ=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b27065-f2da-4e00-00c1-08dd5cc0cd3b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:08:50.4698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9i+7kydcweionydghnDqHoknTyY9RI+1BugzH/7VbYJ0x2feNL4rEgDhIOUF16G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6684

On 3/6/2025 6:52 AM, Jeff Layton wrote:
> On Wed, 2025-03-05 at 12:59 -0800, Dai Ngo wrote:
>> On 3/5/25 12:47 PM, Dai Ngo wrote:
>>>
>>> On 3/5/25 8:08 AM, Jeff Layton wrote:
>>>> On Wed, 2025-03-05 at 09:46 -0500, Chuck Lever wrote:
>>>>> On 3/5/25 9:34 AM, Jeff Layton wrote:
>>>>>> On Tue, 2025-03-04 at 12:38 -0800, Dai Ngo wrote:
>>>>>>> Allow READ using write delegation stateid granted on OPENs with
>>>>>>> OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>>>>>> implementation may unavoidably do (e.g., due to buffer cache
>>>>>>> constraints).
>>>>>>>
>>>>>>> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
>>>>>>> a new nfsd_file and a struct file are allocated to use for reads.
>>>>>>> The nfsd_file is freed when the file is closed by release_all_access.
>>>>>>>
>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>> ---
>>>>>>>    fs/nfsd/nfs4state.c | 44
>>>>>>> ++++++++++++++++++++++++++++++++++++--------
>>>>>>>    1 file changed, 36 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>>> index b533225e57cf..35018af4e7fb 100644
>>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>>> @@ -6126,6 +6126,34 @@ nfs4_delegation_stat(struct nfs4_delegation
>>>>>>> *dp, struct svc_fh *currentfh,
>>>>>>>        return rc == 0;
>>>>>>>    }
>>>>>>>    +/*
>>>>>>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on
>>>>>>> OPEN
>>>>>>> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
>>>>>>> + * struct file to be used for read with delegation stateid.
>>>>>>> + *
>>>>>>> + */
>>>>>>> +static bool
>>>>>>> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct
>>>>>>> nfsd4_open *open,
>>>>>>> +                  struct svc_fh *fh, struct nfs4_ol_stateid *stp)
>>>>>>> +{
>>>>>>> +    struct nfs4_file *fp;
>>>>>>> +    struct nfsd_file *nf = NULL;
>>>>>>> +
>>>>>>> +    if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>>>>>> +            NFS4_SHARE_ACCESS_WRITE) {
>>>>>>> +        if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ,
>>>>>>> NULL, &nf))
>>>>>>> +            return (false);
>>>>>>> +        fp = stp->st_stid.sc_file;
>>>>>>> +        spin_lock(&fp->fi_lock);
>>>>>>> +        __nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>>>>>>> +        set_access(NFS4_SHARE_ACCESS_READ, stp);
>>>> The only other (minor) issue is that this might be problematic vs.
>>>> DENY_READ modes:
>>>>
>>>> Suppose someone opens the file SHARE_ACCESS_WRITE and gets back a r/w
>>>> delegation. Then someone else tries to open the file
>>>> SHARE_ACCESS_READ|SHARE_DENY_READ. That should succeed, AFAICT, but I
>>>> think with this patch that would fail because we check the deny mode
>>>> before doing the open (and revoking the delegation).
>>>>
>>>> It'd be good to test and see if that's the case.
>>>
>>> Yes, you're correct. The 2nd OPEN fails due to the read access set
>>> to the file in nfsd4_add_rdaccess_to_wrdeleg().
>>>
>>> I think the deny mode is used only by SMB and not Linux client, not
>>> sure though. What should we do about this, any thought?
> 
> Deny modes are a Windows/DOS thing, but they are part of the NFSv4 spec

Windows NFSv4 clients certainly might use these modes, so it's
important that knfsd supports them, or at least, not reject them.

Tom.

> too. Linux doesn't have a userland interface that allows you to set
> them, and they aren't plumbed through the VFS layer, so you can still
> do an open locally on the box, even if a deny mode is set. I _think_
> BSD might also have support at the VFS layer for share/deny locking but
> I don't know for sure.
> 
>>
>> Without this patch, nfsd does not hand out the write delegation and don't
>> set the read access so the 2nd OPEN would work. But is that the correct
>> behavior because the open stateid of the 1st OPEN is allowed to do read?
>>
> 
> That's a good question.
> 
> The main reason the server might allow reads on an O_WRONLY open is
> because the client may need to do a RMW cycle if it's doing page-
> aligned buffered I/Os. The client really shouldn't allow userland to do
> an O_WRONLY open and start issuing read() calls on it, however. So,
> from that standpoint I think the original behavior of knfsd does
> conform to the spec.
> 
> To fix this the right way, we probably need to make the implicit
> O_WRONLY -> O_RDRW upgrade for a delegation take some sort of "shadow"
> reference. IOW, we need to be able to use the O_RDONLY file internally
> and put its reference when the file is closed, but we don't want to
> count that reference toward share/deny mode enforcement.
> 
>>
>>>
>>>>
>>>>
>>>>>>> +        fp = stp->st_stid.sc_file;
>>>>>>> +        fp->fi_fds[O_RDONLY] = nf;
>>>>>>> +        spin_unlock(&fp->fi_lock);
>>>>>>> +    }
>>>>>>> +    return (true);
>>>>>> no need for parenthesis here ^^^
>>>
>>> Fixed.
>>>
>>>>>>
>>>>>>> +}
>>>>>>> +
>>>>>>>    /*
>>>>>>>     * The Linux NFS server does not offer write delegations to NFSv4.0
>>>>>>>     * clients in order to avoid conflicts between write delegations
>>>>>>> and
>>>>>>> @@ -6151,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation
>>>>>>> *dp, struct svc_fh *currentfh,
>>>>>>>     * open or lock state.
>>>>>>>     */
>>>>>>>    static void
>>>>>>> -nfs4_open_delegation(struct nfsd4_open *open, struct
>>>>>>> nfs4_ol_stateid *stp,
>>>>>>> -             struct svc_fh *currentfh)
>>>>>>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open
>>>>>>> *open,
>>>>>>> +             struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>>>>>>> +             struct svc_fh *fh)
>>>>>>>    {
>>>>>>>        bool deleg_ts = open->op_deleg_want &
>>>>>>> OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>>>>>>        struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>>>>>>> @@ -6197,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open
>>>>>>> *open, struct nfs4_ol_stateid *stp,
>>>>>>>        memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid,
>>>>>>> sizeof(dp->dl_stid.sc_stateid));
>>>>>>>          if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>>>> -        if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>>>>> +        if ((!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh,
>>>>>>> stp)) ||
>>>>>> extra set of parens above too ^^^
>>>
>>> Fixed.
>>>
>>>>>>
>>>>>>> + !nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>>>>>                nfs4_put_stid(&dp->dl_stid);
>>>>>>>                destroy_delegation(dp);
>>>>>>>                goto out_no_deleg;
>>>>>>> @@ -6353,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp,
>>>>>>> struct svc_fh *current_fh, struct nf
>>>>>>>        * Attempt to hand out a delegation. No error return, because
>>>>>>> the
>>>>>>>        * OPEN succeeds even if we fail.
>>>>>>>        */
>>>>>>> -    nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>>>>>>> +    nfs4_open_delegation(rqstp, open, stp,
>>>>>>> +        &resp->cstate.current_fh, current_fh);
>>>>>>>          /*
>>>>>>>         * If there is an existing open stateid, it must be updated and
>>>>>>> @@ -7098,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>>>>>>          switch (s->sc_type) {
>>>>>>>        case SC_TYPE_DELEG:
>>>>>>> -        spin_lock(&s->sc_file->fi_lock);
>>>>>>> -        ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>>>>>>> -        spin_unlock(&s->sc_file->fi_lock);
>>>>>>> -        break;
>>>>>>>        case SC_TYPE_OPEN:
>>>>>>>        case SC_TYPE_LOCK:
>>>>>>>            if (flags & RD_STATE)
>>>>>>> @@ -7277,6 +7304,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst
>>>>>>> *rqstp,
>>>>>>>            status = find_cpntf_state(nn, stateid, &s);
>>>>>>>        if (status)
>>>>>>>            return status;
>>>>>>> +
>>>>>>>        status = nfsd4_stid_check_stateid_generation(stateid, s,
>>>>>>>                nfsd4_has_session(cstate));
>>>>>>>        if (status)
>>>>>> Patch itself looks good though, so with the nits fixed up, you can
>>>>>> add:
>>>>>>
>>>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>> Dai, I can fix the parentheses in my tree, no need for a v5.
>>>
>>> Thanks Chuck, I will fold these patches into one to avoid potential
>>> bisect issue before sending out v5.
>>>
>>> -Dai
>>>
>>>>>
>>>>>
>>>
> 


