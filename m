Return-Path: <linux-nfs+bounces-13462-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEA5B1C6B7
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 15:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8F5624AA3
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B3B28C032;
	Wed,  6 Aug 2025 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HaPpMvTY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fX4jC/+b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9F1F874C
	for <linux-nfs@vger.kernel.org>; Wed,  6 Aug 2025 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754486349; cv=fail; b=rHusQ0xoqQeBNSW4Q5IM5emgNb7ehca2z0AU/DclTOnP3E5XhvFxo+FNoDtMTe6Onmk40ydONEq3bMTwGXphYwkvqmZkYCNwpCzHfCzx5xTgmz3CdE/Gm5dl09sqpL0s9A/FzY3dOAWoKQBcFaMQ8Klp+Y2pO9TH5kfK+l5XXHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754486349; c=relaxed/simple;
	bh=apf8gwn2FJyWDdx7FTNjIAowdKXPzik8iSjYGvS7iNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iDspE9jJrRdQIiisbTexmNUiWqucjRRzce6BS9BX7wfr+Sfb+LWDNkn/qLbgBMYAWSVvRFfEX4hcKLiJQkYDGKAHhTV50oLK5TvlH6J111HYYDaRtYJC+xBpf7+N8qz8P8frUTMhHMbwrnjDrBLZqd0Ie34pOv27AZvuDIJ+7FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HaPpMvTY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fX4jC/+b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576CRTHo011424;
	Wed, 6 Aug 2025 13:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uEPrIFrgn4WkVu+iZ+/X7kX0lUaOyIr9uzt0hIy+2Ug=; b=
	HaPpMvTYLz6qfb6DSfEVkf6/5jB2/24Wa9bwRLQlJD8FYVmAD/oH3j6fKtw8F0AT
	yqx/t8sKl8zsampWAhWqfF3+N6YjJT/d2//Z6Mm//Zv9gaimQNuAKvL4qaMFIDrg
	1egaONTMFy0rgt/rfU2VoJjAl5gRT9G7Iv9jsrutCMI9PxLQj438gALDXqY8BfQI
	mA0MGzBZt2xQV3JlMCmlCTm052255tYtxd/g8r8C2a+4htTUkZbZxR2ooCTRwUUr
	RdfFEqeZ7iB+/pvveB+cllV/pcwnwCwCiF7e8/nrAW1TvIT+bIgeWWjj1a9hGPKu
	FSlW6EQ6VjB8GM2LV9JpNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd1r23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 13:18:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576ClCm5032139;
	Wed, 6 Aug 2025 13:18:57 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwqhf4b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 13:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/xpex+ntUdJ0xzPHy6mTYfnB1LHfjKKg4w4GmEzKXZR94u9OvZN2PLVACbcmsSFS6ERpyQZxbRrLAcUU8zHMx1NGmXiJNAymEdW8Mlr4UBBNOgS0ZnHlSUwSSeHHBlMi3q01eH9ngmM/kCf3TkCDkFAJzCRwbEb0Sq0MzM892soahqfnuYKOiyY510fF9Gltp3s7ME+JHU5jgCC9SU/lY1D3CQl9RBum1hUkCEUVrNKK39IjIF8TQdFhrgW9aNuipWhU+bti44hGZnO6X8g4MR1CLOtBZ8UtFcinhagtei1D/6vExYt+lDMfwtEIbcVAPtTHJb9I9GpTrJS5wXpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEPrIFrgn4WkVu+iZ+/X7kX0lUaOyIr9uzt0hIy+2Ug=;
 b=DFbyvnH2mSPaJ7kMY5FaNpSiAlrZgfazoLBFH6FjvIb9PjBPmxYCjp1uYt7NIKfJJbWWx7ftp/78UxQETzUu6cRa3wiEp5dyj8oixLECXRRmFizKrtSgFEraNEWRQajsigqQlAbBh8hbVUBf+RoiWvi02LhSeY4Vx6OqcQDDod5sd7B0kRSorYI0YMkoLOemPBiggYXF3oqK5mc6A08nDFNkt7LmdCrFffv2BtsxbrgA6TnPH6DM4GOfmURZbQATMZ7qXnrSkehUTc4+PXMuQthSSFi1pAl1mODPMTy15g+ya7y/umu3RjZJARgcjdgnhrpyw0kFy4Jg4pBaTa2pBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEPrIFrgn4WkVu+iZ+/X7kX0lUaOyIr9uzt0hIy+2Ug=;
 b=fX4jC/+b1gtre4WZq7j2aFNeUFpDHvLdRoI6Hv+CgTf+SMwr3zW+QakFbXaYMPdltmjHG2oO+WrBJBJsYKqzFoxtWF+eiuOgTPLutIbj3wZL5KXUWjKtMXNcDtbuJEA5WmYvV98waklqaNe/5HusHYaqs4n77gVsl6G6ONTXCNE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6268.namprd10.prod.outlook.com (2603:10b6:208:3a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 13:18:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8989.017; Wed, 6 Aug 2025
 13:18:53 +0000
Message-ID: <d3249463-411d-4e0d-aa20-6489cd52c787@oracle.com>
Date: Wed, 6 Aug 2025 09:18:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] NFSD: avoid using iov_iter_is_aligned() in
 nfsd_iter_read()
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
References: <20250805184428.5848-1-snitzer@kernel.org>
 <20250805184428.5848-2-snitzer@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250805184428.5848-2-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: a44477dc-856f-4f53-8920-08ddd4ebca5a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RjIvNXRKK3JWaHd2ZUlpVDU1MmpkczdubEFBTE1EVGV0U3JXY1lRRXRJd2wx?=
 =?utf-8?B?RWNHNmcrTmY0Q1NqL2FWZGZ2cm5hM2RhczNEVk5jTWp6OXprVkIxSm4rVVdO?=
 =?utf-8?B?MlJodkN2M2hOd1d2emptMnYyeXA5UEw0dlVwOFdCdEpMcXlMKzJsaFdBMlNI?=
 =?utf-8?B?Tmd2ZGlURU04UEhGRGpkckxBUVBXSmRmdUNnNTZKVnZRdEw4ajhUZUowWEFS?=
 =?utf-8?B?aHJwUk1nNjhya3NGMGd2UURMRVMxdEJNMmJhN0hGM3RwUElEVGF3TXhoc25G?=
 =?utf-8?B?anFSbjNLWEdmRFZXbHVFZkY5bHNySjNCT2RoM1JLOUtpZjRsUTlZdkhjZW5O?=
 =?utf-8?B?Q2NFbDdvak1YNTc1eXB5aVpIMncvR0tYWXhnWW1mUU85bEVaRzJJdXY0OCsw?=
 =?utf-8?B?QXVPdGV1YkpOVTVzdHBYQjhSVEYyK1VMVXR5bDlNYjJzc21McGU1ck9RQ1Ez?=
 =?utf-8?B?Zno0Q0I4YVpyWTZVdTVtR3ZIbVM4S09RSVZDbjF6Y091OUtaR1gyNmtxbGg5?=
 =?utf-8?B?KzNIcmtOVGFENG9mb0JycGNRdjBPT3I4V3p6NkNkSkdyYktvQTBRMTNLNDVi?=
 =?utf-8?B?eEVjM3pFbkcrTkpMOHYyQ21nNFlmK0ZDdENKUTQ3bzcwRm1FTGc3VUdTdi9t?=
 =?utf-8?B?UzVKTWxGYVJSaTUzdTFlR0F5cXQvVFROeDhCTjJZZktWYWNHVnZ6ZEVuVDNw?=
 =?utf-8?B?ZkdFak1yM24vbklHSEQ2VW5wbHREZWlaRCtTZkczMEEvK2E5S3JxRTlKaTRV?=
 =?utf-8?B?aFk4eFdNeXNQQjF2alYzVWg5SitFR0VqSk5BZ0ltUHQvTnR2N01Ya25CV3VC?=
 =?utf-8?B?eXRUZW1mY1JGdHdiaWhPczV2MGJsS01zZk1UamU1K1p5OEF5Mk9pdGEzaVVX?=
 =?utf-8?B?MTFRWnBvZHNwRXp0emh0TDgyOHFIL1pqVVRyOWlLQ29XY0RYdjBzMUJGWWxm?=
 =?utf-8?B?RExKa0t3SmRmbWl5L0ZYcUlLdmFscTFxMTYzZVRHY2RpMlROMHdtMmx2YlEx?=
 =?utf-8?B?TGllOUlMeERrdFZwRW1XRFB4QnltTS9jMkc2SE5EYzFwZG9ySmlsUGJPY1VZ?=
 =?utf-8?B?TTcxdWdDckRZZi9zbldoZ3pMOEF4TVBjc09VSzdvNW9rbENUQ1RXSFJ0dWlF?=
 =?utf-8?B?cncyblM4N2RRWGlFbEdtd2FkUkh5RGJoclo2UnowcU9KMk9hZWlHNkhVWUhI?=
 =?utf-8?B?TlVJdmZGMWlwcUlPMUg3bHVYMkNXbm56b2VEaWg2ZUZZaUw3WHY3SVB2UVhj?=
 =?utf-8?B?K04zOVdGYzJTMVNGYkp2dUxlOGU4aWVyU3BZUzZKczY2YS9BZHdqbjh3ZzBC?=
 =?utf-8?B?Y0NKM2t6VGE2aGh2UHY2NEs5Uy8rc0dxMHlPL1VwV3ZIOTYvc3BRQ1o0UWpI?=
 =?utf-8?B?eHhSS0haYU8xV3NQZWlzVVI3ZUVsck0ydTlxdGlIVXo3ODR3TDlYdHY5ZW5Y?=
 =?utf-8?B?UG5yMHF4Mk56R2RzWGdmazg5UEZEbnp5TmVnM0ZDdlNDcXRSMXZVZzVsRGRU?=
 =?utf-8?B?R2MzUUM4b1k4ZGEzQ3R1aURlVkQwMXhWL0wwT0FFajBTdjliTldPbXJCbjVI?=
 =?utf-8?B?ZzE2bWpmYjgzL3BwU041VElCTzdXSnFLMWxWc0xuNjBXOUVlUWFUbjRQVTlJ?=
 =?utf-8?B?d3NEMWdqQzUyMEJKcUdiRFRKN09vNFNDcEwvdDJadlRjSktxcFV5d2NDZFN0?=
 =?utf-8?B?WkpMbjVpc0NyTHRkZW83TGF5UkZEeTRQdnBXUm9nMjhwUkg3eUhlY1M4QW1F?=
 =?utf-8?B?Y2NjcWRoTUkvM0VXa0xCMzBCbjk1MzE0SmxDY0ExeEhQeXdudFQ2UmlPalUy?=
 =?utf-8?B?YlpGUm9hTlZ2clg1SFBYTkJyeW5FU3VjNzVxZ0RoRVJBZS9JYmNhUjdKV0Mx?=
 =?utf-8?B?eHhRaEVrQllQKzBJWFRuelhFZm02eTJ6M0ZCbSthUnIzdmc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TFU5eVdnOEFKenpzQ2MvNnIxbnZLdUVLWVFYRDNoUG5xUUFCYTgwRXVjZG9W?=
 =?utf-8?B?aERrZjEyS0x3c3ZsWUxZU0hTUnBnOGptdCtWeEkzMXN5RE45UWYvL1hxZHdi?=
 =?utf-8?B?TkZ4dWJWcW0vZDVnaHhXcjIyWWVodk9ydHlyeEIxd0JHK3pNZThWTlJ3VDVv?=
 =?utf-8?B?RkZKYkwyUS9TYTFlZU02djl4cHBkZEtMaTlLZEQ2NGppRVErQkF2dGREOU1C?=
 =?utf-8?B?UFdOK05OL0x6OEU1UDczeXV0ZE1JNGVHd0NnVEFjL3BXU0ZEbSsvTVVzczFD?=
 =?utf-8?B?ZFcyUzhwMDFtaXlxQ3VXVGgwUks0WCsyd3pycmd0UXhFa0o5MVhNMlNtS0JD?=
 =?utf-8?B?bisvbWlxMGpQcWhRczBIN0RjM2Q2VUE0Q0NwYjUvYlp6YVhuYWV3Q0g3RXNM?=
 =?utf-8?B?ejlrNm16aUx2VWxaVjdCZHMxUEZuRnIrQ0ZHMW9Ua1o0aUt0ZWJUMDBsMFVY?=
 =?utf-8?B?bkNCL1RXdXllU1lrQ0xBaUYxbW42UDV5aWx3bUlHaTBYN3R3WFpHbXRuQUUw?=
 =?utf-8?B?dXdZN0k3Y0NzVG1wUlhtYmpPL1B2SnF1R1M2SVRCUWJBWW1tRm4zcFVJVGo4?=
 =?utf-8?B?bHV4dzVuVDNQT29ZcGtkYkZ6UHpOditFTnRHcGsyNUVaYjI0V04xY2djU0dz?=
 =?utf-8?B?UmI4Q1JPYVA0V3N0T3J5ekRZRTFuUnp0WExRQndqSGl4d0d4UHpldVczUHda?=
 =?utf-8?B?Z0VieTZ2QkhFKzNWOTZVbGdMLzJJZE5zMlJqSndZMmVuMVduNFhUemdrNlc1?=
 =?utf-8?B?MG1qdFR1Wm1Ka0U1V2RFLzdVS2MrVmxqM2NWNzdhSWo1Z0wxRkk1NnNqUklo?=
 =?utf-8?B?TldQYXVRL2hpZFk2MUVCNGRxaHF5R1NLbHV0eUI1TVM3VTNSaWhnMDY2TXM0?=
 =?utf-8?B?ckVBVWw0TWd1ZDlKVXh2T1A0S2xxTVRvNGRDeXdpMm5hNUdYang5U2l5VitJ?=
 =?utf-8?B?ZzY3dURkUTRIQVZETWkyYmgwZ2dHRllYQWFsVmZaTzZZSlovMGhNRSt4Zmt1?=
 =?utf-8?B?OWVKNStjYmdwc0pNZGxwTWdEOW1oMmhRdlN4bFZGOCtwbFphdTFIc1hzT2FF?=
 =?utf-8?B?d1d5a2l2WHdQZ0tBK0R3MUZMY1RVN2M4cHM1alRXa3dJdGZGZUs3R1BUY3RE?=
 =?utf-8?B?ME00Z2dYVmVIZnhYUTVoZmxWcGRDV2FYWitITWpDYlhyTjFuZllXM3FacmJh?=
 =?utf-8?B?bThibWp4M1FXby90cnF0b0JIK0c4dzRmNlBmeGtMaXI2ck5waGlSZExsYklL?=
 =?utf-8?B?R0tXa1ZmdWVkSHFGa01ZaVdKaDVoRFhnaE5Tcnl1N1BFMU5zNEVrRlN3aGgx?=
 =?utf-8?B?YnNlSTgrRmhGaTlmWWJ4eFZRSDFObGU0WTlCK0NHQ2hRMzI4MkRYODdvSUl1?=
 =?utf-8?B?QkxwemNnUHJJeUNXd2RVb3h3TGN3VWVpb0JEeEV1TFlmMXA1UzNEdVp5ZW1y?=
 =?utf-8?B?dDZnc0JDb3Z6YXNiSzZxcTJCb3N0aGpDRWlvQlVnK2RmTzA4ZFI1K3lLMGdj?=
 =?utf-8?B?bk56SEZSR3h3aVg4TitmVjBtODFONVJCVEY1TUhGSkZ2a3ZNaEZBNzA2STBj?=
 =?utf-8?B?Mk9UM0ZvZ3c4RDNTMnZ3WXdoWC9lS3pLUnZ1Y3VycGpOT2Z5TStDd1NSUTl2?=
 =?utf-8?B?SXdwZkRrZFpwS0tTeit1WkZKNnVhME9INVE5RVFKVmo3cWc0TTdrMlkxZ1do?=
 =?utf-8?B?Wk90blJVTFNaZkxzVzFLTGFKelYzTXZBbi9aTVgxRFdVZXlYaC8wK2oxYlh3?=
 =?utf-8?B?VXB3OTR1WEhqWW1kM3BaOXdVSVpkZ3BzV1VsL1NBeHAyT2xnRFhXcGFmZWli?=
 =?utf-8?B?UUd4cHFnZktiWDRlWGhSZ1MxYkd5S0p1ZzRtQzFQb2JhSlkyZFNybzB5Snpp?=
 =?utf-8?B?aUd4S0l2U243TnJMWVhIbk54NGc1QXo5MlRZODRWK1h2YTJoOUw0N2JUbDRn?=
 =?utf-8?B?ci8ySE1jZDJKRGFmSzBYWlBwaU1wdi9POFd0ejdmUmJnRC82QmcxUStPOTkz?=
 =?utf-8?B?dzZUSDBZMUxxaHVqMnhHMFJsUDFsMXpXcTI1NW9KOGFiNko1SVltOHVpaFI0?=
 =?utf-8?B?d0pmRkRQbXlSVHpISnhUWW83T0xNVHN1RHdEOE1pQk1reVhqVHJmOFFnQ0Nm?=
 =?utf-8?Q?anBrpGyGY0hXZoglWQIDq4E9G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WRR/ht+MZN8Kf3yuJp4gDPFvYHk/pX1w+AXI05oqXHTuzR+QSz7z963QEqZ+jODt/gzGkROkw0ehJVQrlMo3AzymSBFUvepHZQFDkmQ/D0+zq+gHBC1kvs6vHIfXOKnuQP4N3GtoDWkH1t3veS6Fbxth0VZJqI72VxAKLBsP8DEyh0TCRH3U4A1yIha52y9MIKeJufuIopGcYhvE0ATMuSikxCXKJNc/lS9omhDDZVug0uMXRqgxTcdJhyvcjbBwAI7cB21s7jEVzc6MKZuhtwfGIgKfY9eOEWjLK5GjMe8hDsAvHOGOLBKETfndpiDKi/JgRocuqVXH9dKxVrrESNSis9xLjTbvBqmjbNabA4YBphwGqltEM9gaAJUMgRqUataIMdJwF4fjEVhIZFHv6i9QOyZbHqOGdMjCWmCMjhWBzxguztQrnwg6roPu7teK1P7JmCK9/nIcChfU/LrvAXRUK7/frmwFJFs79Ub7NDDbCOosGRTl4LCNJkpFZpwagUoC9Tkfeq1f60i0nYEmgk0U6yywGDmf+qJif8+3dpiBZa9pFP+SwxweaYjACZj4x/k/41PnjIZiSmmCg/tp2XJMqw8cw09HAcxyFcFsOvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44477dc-856f-4f53-8920-08ddd4ebca5a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 13:18:53.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFcuUerLFpM94TgKbIId3m2AClPoy/IMA9V5LDWEq7FuD68wbWCsDmG0suFxMq7ze881vgMwgNfwpm2Ea/wm9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060085
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=68935641 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=SEtKQCMJAAAA:8 a=fp3TM6ZIHPd-YGUSaMgA:9
 a=QEXdDO2ut3YA:10 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:13596
X-Proofpoint-ORIG-GUID: vPewPGZj7a9ewS2nh_ceuej1y-_J02lW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA4NCBTYWx0ZWRfX14NEqafL5Nv2
 a4xqqj2ikrNSTSZRUZNrKT471UTMYsq7+tBNAMuzwrUxuM9fQr3pwFVGpIMV9SQ3gPTnF02O5/g
 E94eyG58duGH3bfEEnZaISPIiEhNk5ygsSn3c0MO56Q/QL3H8yw2PT7WJmN1pdQS0HmZsxY+ec4
 wvCQ+aYghKQSNbAwibDlj3at38cOLjivtBYW5p+59ZVbSlwzDNSi9r78ysPyeu9/mM823QXYcl3
 tf1Oz+yzvPu26m/yoJWkjQmQ0IO7EkroCQNptFi4aajldREKCGFmnRW6m+RgX9Gi49JZ+67R7ow
 oVz1TglQuN+HgPP2WBMFY0tZeLhet5kA/gc7FDmfRNCbJ7xsfXTIgfCdZjLpGwvPtlcTn4Y8MCj
 l4MZixM/N7fAdZtF9KSCJXYfrygviKRs58ZhTAHDdoUjO60dymEaUg7Rst8A5PvBN5MU7uYa
X-Proofpoint-GUID: vPewPGZj7a9ewS2nh_ceuej1y-_J02lW

On 8/5/25 2:44 PM, Mike Snitzer wrote:
> From: Mike Snitzer <snitzer@hammerspace.com>
> 
> Check the bvec is DIO-aligned while creating it, saves CPU cycles by
> avoiding iterating the bvec elements a second time using
> iov_iter_is_aligned().
> 
> This prepares for Keith Busch's near-term removal of the
> iov_iter_is_aligned() interface.  This fixes cel/nfsd-testing commit
> 5d78ac1e674b4 ("NFSD: issue READs using O_DIRECT even if IO is
> misaligned") and it should be folded into that commit so that NFSD
> doesn't require iov_iter_is_aligned() while it is being removed
> upstream in parallel.
> 
> Fixes: cel/nfsd-testing 5d78ac1e674b4 ("NFSD: issue READs using O_DIRECT even if IO is misaligned")
> Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
> ---
>  fs/nfsd/vfs.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 46189020172fb..e1751d3715264 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1226,7 +1226,10 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			 */
>  			offset = read_dio.start;
>  			in_count = read_dio.end - offset;
> -			kiocb.ki_flags = IOCB_DIRECT;
> +			/* Verify ondisk DIO alignment, memory addrs checked below */
> +			if (likely(((offset | in_count) &
> +				    (nf->nf_dio_read_offset_align - 1)) == 0))
> +				kiocb.ki_flags = IOCB_DIRECT;
>  		}
>  	} else if (nfsd_io_cache_read == NFSD_IO_DONTCACHE)
>  		kiocb.ki_flags = IOCB_DONTCACHE;
> @@ -1236,16 +1239,24 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	v = 0;
>  	total = in_count;
>  	if (read_dio.start_extra) {
> -		bvec_set_page(&rqstp->rq_bvec[v++], read_dio.start_extra_page,
> +		bvec_set_page(&rqstp->rq_bvec[v], read_dio.start_extra_page,
>  			      read_dio.start_extra, PAGE_SIZE - read_dio.start_extra);
> +		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
> +			     rqstp->rq_bvec[v].bv_offset & (nf->nf_dio_mem_align - 1)))
> +			kiocb.ki_flags &= ~IOCB_DIRECT;
>  		total -= read_dio.start_extra;
> +		v++;
>  	}
>  	while (total) {
>  		len = min_t(size_t, total, PAGE_SIZE - base);
> -		bvec_set_page(&rqstp->rq_bvec[v++], *(rqstp->rq_next_page++),
> -			      len, base);
> +		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++), len, base);
> +		/* No need to verify memory is DIO-aligned since bv_offset is 0 */
> +		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) && base &&
> +			     (base & (nf->nf_dio_mem_align - 1))))
> +			kiocb.ki_flags &= ~IOCB_DIRECT;
>  		total -= len;
>  		base = 0;
> +		v++;
>  	}
>  	if (WARN_ONCE(v > rqstp->rq_maxpages,
>  		      "%s: v=%lu exceeds rqstp->rq_maxpages=%lu\n", __func__,
> @@ -1256,16 +1267,6 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	if (!host_err) {
>  		trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
>  		iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
> -
> -		/* Double check nfsd_analyze_read_dio's DIO-aligned result */
> -		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
> -			     !iov_iter_is_aligned(&iter,
> -				nf->nf_dio_mem_align - 1,
> -				nf->nf_dio_read_offset_align - 1))) {
> -			/* Fallback to buffered IO */
> -			kiocb.ki_flags &= ~IOCB_DIRECT;
> -		}
> -
>  		host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
>  	}
>  

Hi Mike,

In cases where the SQUASHME patch is this large, I usually drop the
patch (or series) in nfsd-testing and ask the contributor to rebase and
repost. This gets the new version of the patch properly archived on
lore, for one thing.

Before reposting, please do run checkpatch.pl on the series.


-- 
Chuck Lever

