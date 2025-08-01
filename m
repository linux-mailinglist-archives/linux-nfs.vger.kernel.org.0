Return-Path: <linux-nfs+bounces-13390-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47086B18960
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Aug 2025 01:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA7E62262E
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 23:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012D1917E3;
	Fri,  1 Aug 2025 23:17:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2130.outbound.protection.outlook.com [40.107.243.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5E17DFE7
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754090255; cv=fail; b=KXb5wR8hl3KI8zaz+70XOprSoD9pGEFwP0XL9nz9tD+gJ/YOCwCW7VDg7EjeV44Wz406reZYGBdYi9EyygD3zCcodBqG5FgTUIul0JRx2IDlns04yYoaLUBEDsBHc9NYulCJGhbwY0+/1hXai6lV/NkMOmD5yqB4aVvFjDAUZSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754090255; c=relaxed/simple;
	bh=osc2OZ3BWyFA8MaCT1bwX9dUOVQl8xdvcdvKEFt7bZE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oPNXez91kZEJRJYimcqXN4Ffs+bRJ6ufFnJxlgY+CG2LP+MwJj4Vip3IhxCCNZ5rNfStW7a/msH6IQCeVXWgXGxks5n/1qbHFYN9nVWmAmFeLVT9x1RDjiUw8FfiXelAv9D45GwQD365KLx0HfMqXe5AyuSbUk+tUFCM2SgYp/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.243.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7X6tOTDRYVKrjIRnIOM5Kkf3w15NiJi25/UJbCGAH0g++1GWtdcZptawfi/mBYFNIy5007pY9p0qFCFTDyYsv1xcM/xRM6+tHdvDrnlO+niqT6TRnqHb13e/TWkcdut3Tn3FOSgIZa8X25WujB5tUEmXJhl3uMI3bMULgKfJwSngED6AeGRi1nN9zz+7Qlq5Y2eAAtNws+zMPASp852kTkRlQ/D0zsvf41gCVtO+lE3t8nl9Vj9JeHcOvtUApBDHhNKVVO8WA6zZJ6wz617uImk6ECETnN19p1cUZ1O8tg8jTG4XYdEg9W0ZoOv1Rcv4IPSwyD+Rob8Ax84/R5ZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osc2OZ3BWyFA8MaCT1bwX9dUOVQl8xdvcdvKEFt7bZE=;
 b=CXaTBWs6yLZ+7X14osZaFKNOklt88QonXW0Qf8t7vM7QYLW6ChO+jKJfvkrJge3TII2dYp+qWYhmTTBadMbYlX3hr7ORKLA1wk/r45LyDnlx4ojNQfCqDAYFW3Oh1nIEPj+dgZeuETdlMRgnuNH585zmdN5ugiVHVvge62NUk7wSSNQqNbvT6HoZOztUb/7okLgLRO5nGU1tgFHRrX3+WeKZ3qioLCzCXr1xcfuo5ex2+QFflAgtLfT6CntMj9eblfucK+igBtCqqhAcrSRnudyljLSkG93MhwSNiTF8//jNu8dgzDonBpTjLmvs9+pgw0e6rKziyXf08v74RUc63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from DM5PR0102MB3414.prod.exchangelabs.com (2603:10b6:4:a8::22) by
 SA3PR01MB7987.prod.exchangelabs.com (2603:10b6:806:31d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.16; Fri, 1 Aug 2025 23:17:30 +0000
Received: from DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db]) by DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db%5]) with mapi id 15.20.8989.010; Fri, 1 Aug 2025
 23:17:29 +0000
Message-ID: <f1e81d36-d49f-424a-95f8-5c3e4943b522@talpey.com>
Date: Fri, 1 Aug 2025 19:17:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] NFSD: handle unaligned DIO for NFS reexport
To: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 hch@lst.de
References: <20250731194448.88816-1-snitzer@kernel.org>
 <20250731194448.88816-5-snitzer@kernel.org>
 <b5e2e433e70189b4ed05417f8bdb2ff98a82881e.camel@kernel.org>
 <aIvf7VqSeNE3Ma1m@kernel.org>
 <4f12862ab8560f788210b0c2d0c7b13a5dffcd70.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <4f12862ab8560f788210b0c2d0c7b13a5dffcd70.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0034.namprd15.prod.outlook.com
 (2603:10b6:408:c0::47) To DM5PR0102MB3414.prod.exchangelabs.com
 (2603:10b6:4:a8::22)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3414:EE_|SA3PR01MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: a5233997-0f88-4a8d-b217-08ddd1519598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1JwUTZBaHphc01YdmJHOFFYKzQ3Z1BrdmVkaTlOdjhOeXpzbGEvNDQ1K0dF?=
 =?utf-8?B?VlpTWld6dndkZTRmaDBZYjlXY1p4RUwwREZzdlhXdVY1NytzS092VGhxRFZT?=
 =?utf-8?B?SWFwNmVFamRFMHd5R1lDTTk0c05TN3kzWldHdnhVWE9XZGZXUGxnaWxXVnhS?=
 =?utf-8?B?ZTJCdit1bW9WNy83Ui9IbitVVUs2NXJtQUNmSXZPTkJXTGdDa2p2ZmxQaGUy?=
 =?utf-8?B?R2NoZlEvT2ZzOVc2ZnA1V21zUWNsVXZ0VS8vN0FMQTRFRFVXaUMyYTRzZHVP?=
 =?utf-8?B?Z1pZL0lhdXg4ZEI2MHJSUnFNWHp2MHBES3U3QXM4RTJYRHZRUUs1YURSMWt2?=
 =?utf-8?B?SmtGRTRXVUxZS2k1NXd1eDRMU2ZLRWgvVG1LNUJsaTVHRzZteHF5MnJQYjE0?=
 =?utf-8?B?bzVqV0FqeXlrWWVRNDR4bi81RUhqaWhMS292aytNN3JQOWJ5NjZwU0xtY2hx?=
 =?utf-8?B?aUViYXNBZFlIYWY2YTJYWk9PZHZXYWtBUlRJY05seXRadmNxT2QwOHFUaVNO?=
 =?utf-8?B?eGtjY1kyVHhBMzVhUmJ0M1ZPSFJQMEhjbW5WMC93Z0NHblhYTUlqRjFlaEsw?=
 =?utf-8?B?M2ZLbU9xM0tVSWVwa0xIblZKYW93UFdHamdjL3dSNlRhQjA5Z2ZDVTJhWnRN?=
 =?utf-8?B?aUZNYTNRbnJ3N0xyajhNWS9JWWIzUStRSUd0eDNJUWxwMHAvbE1OT1d5cmJ1?=
 =?utf-8?B?ZGxYZnl1QXFkR0M4dXlmMjJvUStCNG5LVWwvWmhROHNGc1I1ak5vd1d6Nk9j?=
 =?utf-8?B?em5rTHVnb2drYmp4eWY2TmVzU3kzZkJ4dTd5OFQvSmtyZXhya3RXc01vL2Rq?=
 =?utf-8?B?UDhFMTVTWU1lRjcrRldPbG1DWS9FdHBGMWlvdlk2d1p2TWJ5dGNJZk9PRlps?=
 =?utf-8?B?a05rNEZXVjMrZFpVdVZHaDE0RlloRml0dU5aNHd0RmNuT1BhZGkrbk80WE81?=
 =?utf-8?B?SWZGZXc0RXVFR2o4dkxEL1FlajJRb2RuZ1c2Z29FblRaSlduZTFiMmo0bnZO?=
 =?utf-8?B?RHJoWnArN0xLVngxOXpHN3MyUVRYcWUyY05kSjdkS3pOczRrVUVhN3RWWXd0?=
 =?utf-8?B?Q1hBNlEyclA0dVBMbTUwK29DZnkyOW0vRlpPWXJxV3hUTTQza0VxOE9samZ4?=
 =?utf-8?B?dXNOZU5sWVArWDlBa0JtTDZ6VVhtMS90Wk91UnFKcytRTDNFTzNNM2Y4K0t4?=
 =?utf-8?B?Q2N5d202WWdVSm1hWnplRjlLOGErUFUyL0R4ME9SeVZQV0NlNUFDTTdmMURu?=
 =?utf-8?B?Y1RnRTRiZUN6M05YK2RZcDJBN2VKVzB5RG5PNlg0ZHpoWk5mSEY3a3UrV09J?=
 =?utf-8?B?OEhrUkt0QUhnUWpYUHA5MzJNdW1oY0FoK0p1ZzNNQ1lsNzFZZGk1T1hTVEVu?=
 =?utf-8?B?eUVOUjZoK1pEQVJENFN0ZXpBVjdRSzFUMkJtUEEweGNFQmZ2TWVSVmk1RXRp?=
 =?utf-8?B?R0F0eWNzZ3hJelRta1RDS1BEb1Z3ejBReVBnenJKVVcxNmw2NXNqckYydG1m?=
 =?utf-8?B?d2NubExQMHVNdzJFemtaNm84bHRFTTR0S0VRTVFldnA3ME9Wb0NKWEZHakZL?=
 =?utf-8?B?aTNEQmg5amkwRGEwOUJEN3F6azc0VDAyTnFxaktpSCt6WkJNc0ZvYll6ZkJv?=
 =?utf-8?B?WGZPY1YrczNjSFoyMGdVdDY2ZkpWdytURnAwRFFsSUovYkZwV1lqQ1RnREs4?=
 =?utf-8?B?czdNdjdpVDEzQkhHem5QYU9EeTBML3A4KzhHbndPdUcwaC9od0JvRDRjT2F1?=
 =?utf-8?B?bGNMSW5aVGJrRForaXFQbTRPOFZ4YlIwZ051aUhSZk9rUjZjOGtsWkk0V2J3?=
 =?utf-8?B?YXcySGxIWHo5SnNyRSt0M2xtL3p4SlRjWDROclExcFFWMHJWMzRkQllKVzF0?=
 =?utf-8?B?NTFZNmIzMGl0SUw5YUk3bFhCQ0piVVVtYlVWa3VJTW5PblE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3414.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFpwN1pIaXF2N2JwYWlzcTVZNHpVeC9jZTZsYmdoSlNkTjcyQ1UzaTh4bEFj?=
 =?utf-8?B?RlAyOTFGcFBEUHpZbHJOQnJ6V2NGb1hCVldJRFBvb3c1c21FdFZzM3hGUUJs?=
 =?utf-8?B?ZG5icmZZaWJSUWdvMXd6WmRiVjBjZnR1R1BLS2FLNUhNNmE0cCtSZjkwMWJu?=
 =?utf-8?B?NVQvYWlmMmxwRlU1UCtEeFFhaGp5WDFNbHArZlpTUFRZNkNyRUN6RzVHdys2?=
 =?utf-8?B?WVpibDJDcm1iSmhBbEpoMVNSQVU3YzNxWVlDcUhyZkFsVGs3NnRpUkdKczFR?=
 =?utf-8?B?MFVzaENuMVdhUWgySDlYWmNjelNvbDE1Tm92NndPc0RWaW85NndEN3M3Znpo?=
 =?utf-8?B?VnAwTjA1LzdFQjVSQmFmYXA1dUppVmNRTWNnN3ZveUhQM0JXbWJLNmlVLzRN?=
 =?utf-8?B?dzBXQlhPVkx1TkxQU0hldmdKK29ndU5TUVozWTAxZVVXS0Nrc0F4d0tXQzBW?=
 =?utf-8?B?QVRQeDNXYnFEMHFpcEl0VWRQN1M5eUFLV1NXUFdKRi9IQXFacm9uZExGZE1T?=
 =?utf-8?B?YlByNVlhOTNmTHlrd3M2WHpvR0picEloZ1ZYZ2JjZjhERFpZaEJHTm1ZRXE2?=
 =?utf-8?B?c2ZjVkRGUjhreGFnczQ3Q1R1NzhSTUtvUW9yT0cxMHhXMEhSemN2dWhkOXpm?=
 =?utf-8?B?MUg0dEFVOERlOWw5OTNLOE44UitEUFNzTWZhM3hPR28zQzI1TWttaXN1K0JI?=
 =?utf-8?B?WFVSdVFFczB3Z0pLdVF3YmxPWklRa3NZOEFNaDBNMlc0Y0IxTG0ycGsyZitK?=
 =?utf-8?B?UUxmUlZrcmVJY0NzK2hiclN3MXRwUHQxM2tUV0thejArYjIycktDSWsrVDZk?=
 =?utf-8?B?Umsveml6Ykw1Z1hQenVKTmZpL3Ivd3lSRTFXOWZUQmd5ekFQR0hiZnJCOE1t?=
 =?utf-8?B?MHV6RkZ4ZEpLOE4rYlEvay9oc1Bad29MWEJSVUV6Uk5BTVJVVTVpNldFTWpx?=
 =?utf-8?B?YzRqWmgvREs3dS9RZlFsK2UyWGd0UFZQWXh2Z0dGSnJwOVNHRjN3Snk4dVZ5?=
 =?utf-8?B?SU55YzZzQXJUeWhEbmlJeVpUNEN6WE5oUFF1RndqYi9URWJObTVrcU1zS0la?=
 =?utf-8?B?ZWJjWDFzK1l2ZXRlL3krbjhaMFhkcXhOWWw4MWtzVzZQVmduYUFVMDFhQjBM?=
 =?utf-8?B?SlYwcUZGbitHS2lKcWduVTQrYVFBYXVOejZpZlV5Q1dZWVVkSXlUY0xTZ2cw?=
 =?utf-8?B?TGtWcnZCOU11OVhwYW8ycDlFdHBJZzJ2Y1FPQU9EdGNoVTVjMDhCaGpTdTFp?=
 =?utf-8?B?ZjQzaTBDOWlLZlpuZVFiTER3YjNJVW9WUEYwM2JhU2R3SnlhUTZ1aFRWTFpx?=
 =?utf-8?B?QllxNUFZZ1lrdmIwd1REZTdhMWZjTDE1REp3Y21VK1B4S2pBa3ZPUSs4TkMr?=
 =?utf-8?B?a0tXYzl5SkJSSlA0b3U5cHhlTXNra0wyQmRCZEZ6a1VIU1VzR1VSQTRab0hm?=
 =?utf-8?B?WEN6YUd0ZjlmRHdhQmw5cTNQb1hEVDRKT3l3b081Qkg3b21iNDhYd3NFWTdW?=
 =?utf-8?B?Ylo2a3FHM2E0clROVXlhK2c1aEZieFh4cGlEaUVhbERBaHViWk9DTUxQTkpW?=
 =?utf-8?B?QUxNN3FSSVM4NzVtaDVaMklqZEpKUFd0ZERqSSt6eDNFMnBPQUx1aDJndWJz?=
 =?utf-8?B?OUNwL3JhS1h2UkhCZ3pkbUJpMlhscWhrK2wzWFZsbkhBZFNFNUdzU3Y3eCta?=
 =?utf-8?B?RVZEYk0wd1cwbDljekY0UHMrNG1OczA0dlY0M3FjdndwWkpmSkNEcFlTV2tH?=
 =?utf-8?B?SVdScTh5RWJFY0pHNjVHTnFTTWlYV0thUFVrdVVuT3I4L09DaWtuTkV3WXdz?=
 =?utf-8?B?dy94NXc3SjcyRG5Fc2xXU3ZrUHN0OGdFeUlld01iUFFROXc5VUhOTnNpU1lP?=
 =?utf-8?B?WmtxZ3lEVVgweUxRb2VDTkZkLzZhVkZ3UlZvT2lCY2tOaWRhZUEyUUpmUEFU?=
 =?utf-8?B?MU1GYlJRZXJhSDVkWHlDYStyczY3RWFZa0xaRG9EUktLM1lyV2N2MHJkZlFp?=
 =?utf-8?B?NlNKZlB4MVdRRklhK1JSb1k2YXRtTWI2Y0Vlc3prbDJDdWg2Q0szME9aWEpB?=
 =?utf-8?B?Q3VzS3FSQUk5RlZMZFZaRDVkTjE1b3NKb0JOL0RPWUF1dUVlMHpLOTFjTlhH?=
 =?utf-8?Q?UqeEzG5qtzyIhKCruom44FToi?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5233997-0f88-4a8d-b217-08ddd1519598
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3414.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 23:17:29.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9NCx/2m+4zsUz5i2DwyqnG1UgRhO8o7H4Kv2lGQIi/12YPT95mwvZ+p2jv3NfJc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB7987

Just a late interjection on this:

On 7/31/2025 5:45 PM, Jeff Layton wrote:
> I don't think NFS has ever enforced a particular alignment on userland,
> at least not with regular network transport. Does RDMA change this?

RDMA imposes no alignment restrictions per se, it's byte-aligned
and byte-length for both inline and directly-placed payloads.

Some NFS/rpcrdma implementations may reserve direct placement only
for page lists. I believe early Linux NFS clients did, but that was
long ago. Like, 20 years. There's no transport requirement for it.

Tom.


