Return-Path: <linux-nfs+bounces-13775-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 481DFB2C903
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 18:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF851C271D4
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71792C11ED;
	Tue, 19 Aug 2025 16:03:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022102.outbound.protection.outlook.com [40.93.195.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEFB2C11C9;
	Tue, 19 Aug 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619421; cv=fail; b=q8wJJyJ+e/xpTnMhlhHrGxUA0muj82ZV3p3+bsiPeunU8V0aQ4vG81uWegp5/3GgoLg7U9azmHPpp3G0xqNOu7dy8coPhrgIEO6wJA3UevV6LGFHU/vSQisCPDpCSN0odoGz7RuYZENTssnWVWfkAx6UOAyFT+JmO4khf3CEtbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619421; c=relaxed/simple;
	bh=33rh8c6SI0eXLv/vAE34+DRyxIP74wT5PQnaIk+tkc0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rnix66nSVP2ugxuVT/xOTbhmMWqbpyMOLEnBxlYzIkxqUyVy0t5MtLa7ydKpAhj2ph4ak2y07W3YYjfUjHDKNj6pqCrGSDTXZT5UPNbIz6lTMVrQFmaOa4th7Phu1uQNh0n3FbpJ6mCruA2K5+jeB/iOeQ145Nr/xZWjWLxc7YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.93.195.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qR3I6cJnYff7TwiwgjVaEJDD6VQnTV/iPBLYhQcdabKzWskSgQmm8IDjK3HhI87d29YLuJU09cCGQJUNYuOzs9kgSuhSS/vCfMwRqNEF5qY9HFDxwyMTOSvqepvKaAY/c4F7SPdbDKCY8f1JVtOyTPevSQJZJECtzdhtDQXbtJry/ePUkECIznmMY29UT+8S/WNSL+Ah/zOzZIqRz+IoDCo6UKFp6ed3dm3kE3mtDjv9W3wvdQ26LWsyp/AWDzRCRORuQSwV65vVCxL2YaUtaOwlM4KZgRbBzsSYB0+okagdnPXmxDdoRfCejRV4QBiVbPG49vNmZ6Unq8lyBiHc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfCqg/KRGGee1V38HTfU4MtZ+TFY79s7AaIflqMzGCc=;
 b=jgk38zelvC2MbIWVd+XfzBKnM4ih5tzvUWgr4kWs9CEv0CEMTVTAq4MZjAPVFSrpCnUyylZzGzh4Q6YmLlqUpre0DDU5Rgaz1ob0dkJ5PSzB+8vN8QAo1ZvMgwHqvLxJ1jyy4GDDJCzZliSOYoCRqpNdv3bbXnWUKHIl9qzqQaEjFiR6PmPdboFoGYsLQnjCdRRBy7j4eyIK73I3tCQsb8rpRrHqZnlLHAVxil8irhnqEGDHQvEQO7EBFkuUjhsGNZ0RYzbthzT/D/IrT9/2WD6FKOtnlGq1LYhayDmR7YXVUfDT8uhVJjxlbvPtuzeyhO9YhIi8CYPYPkkWGxHUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from DM5PR0102MB3414.prod.exchangelabs.com (2603:10b6:4:a8::22) by
 BL4PR01MB9151.prod.exchangelabs.com (2603:10b6:208:590::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 16:03:30 +0000
Received: from DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db]) by DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db%5]) with mapi id 15.20.9031.021; Tue, 19 Aug 2025
 16:03:30 +0000
Message-ID: <a1ce98e1-83b6-45c4-bde0-c4b71be67868@talpey.com>
Date: Tue, 19 Aug 2025 12:03:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] svcrdma: Introduce Receive buffer arenas
To: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
References: <20250811203539.1702-1-cel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <20250811203539.1702-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:208:234::21) To DM5PR0102MB3414.prod.exchangelabs.com
 (2603:10b6:4:a8::22)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3414:EE_|BL4PR01MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edf01d9-424f-4a7a-b9e7-08dddf39f092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VytOUzQxQWdZOTJUOHZEMmNldEswQU5EQi9scm1idEpvUWVTOW0zb080REE1?=
 =?utf-8?B?VjAzN0drVi85Qi9USFlwYThwQU5IYWdGSkRwUDRCL3VnRkhjTnlrVnlMaVpZ?=
 =?utf-8?B?Y0YrcUVmaVd2aGtGWVlmdG1wT2lEU1V1cXBkakYzTXpaaFVUZVo5VjJNb0tr?=
 =?utf-8?B?bUxuQWtrNXlUekIxYzZsZVpJRlozNGxWMlg3KzQ4MUlQWWRVMDhCOFpKSysr?=
 =?utf-8?B?KzNWU3dwbDYvSlU1anVob2tFT21jYnZjUVdqLzEwcmwyQnhBaTlMUzNZRFE2?=
 =?utf-8?B?WldPN25DOFVYR2NvRUhreWpORlkvVUhLS0wrLzNodWdUbi9jQVdiMkdnbzcw?=
 =?utf-8?B?a2ZMK1ZYWnNjdk9PS1dvdDhBcjE5NVd6ZUNQRlYvQm13RHNyM0k2VnNQTlhM?=
 =?utf-8?B?OUE5SnJCOGNFaXUxY0xnY1gwcEpxOGp6V3RxNWxzV0k0MERPREd5M0krMTJZ?=
 =?utf-8?B?OHpVRjhUOHJ1WHhRazJCMjE3dmxENThtaWVPNDVjVUlhV0tIanhRbFovcU4y?=
 =?utf-8?B?OGgwSFIwL0ovOHJ5Wk9kZWZwY25GS0JXazE4MzNRcWptbWIxVHNscEZpQW85?=
 =?utf-8?B?NGRZRFhLU3pZRDB1L2pnYXU3WHRiN0EzaUkvL3Z6cGprWmZRWXIxU1EvKzEw?=
 =?utf-8?B?djlvTlZ4ZXVrQkdPSk9RSVQ4M0s1Z2xZSGg1VDRaSDJpdkN5TUk2MHJOcDBW?=
 =?utf-8?B?aFU2Mjhhbzg2ZWRsZHoyTVNBMnlwUitEZTBDZ0pZeUsvam4rS0REclFQRjA3?=
 =?utf-8?B?OHp5a2JYczFJaVNubElRa2NweUloRkVyZXBYYTFPN0l5VmZsUUtiMzNZcEdE?=
 =?utf-8?B?bit2b2xWdlowVlMvbUNMNmx6YW9KcHpaRHd1MGpDYUZ0bFNnZlQ2L0dCd0sx?=
 =?utf-8?B?d2xXTVpkVGVBaW9WYjJBd294QUpCT3VoQXdCVEROVStRRDFoN2NLSEVoaEpJ?=
 =?utf-8?B?UnBrTlZ5SEZTOFlrK2tOUVNwd1A2ejVrL0hiMVZwanFhKytqZnNSdW16Q1NG?=
 =?utf-8?B?QngvaUgybzgzNXhXcTRCb0gxRDErYVRsVm4ycm01NWJpMkhxcHJDOXZwS3Bv?=
 =?utf-8?B?cXljUHgxTHMrcXlBeTZ5TFpsS0loMk1qMjFoN0drblFBM0prc01TTFpaM2JV?=
 =?utf-8?B?Y3ZUaGJHdTEyWjFyUzBtMmk4RGUzNUF1MTZjZWRxK21OVnFxNkhYa2VsS2lV?=
 =?utf-8?B?dkNPdVNEdDlTM3drdWVFNjJrQkVQZ1NLY0d6M05QQklJcWRDVkE1bXJzSmhU?=
 =?utf-8?B?VjhSNkdPV1Bkc1FwMVNhWGVmTTAyQ2h0TS9ZTWMwcUsxemxVZForM0ptZ2dH?=
 =?utf-8?B?WStRRHBmZitCU2dMbDF4R2RxOHFOMDZtbXAySDhPMkx6UmN5WHl6cW5jL1cr?=
 =?utf-8?B?aVJMZCtvY0VhejhnYlY2NFgvajVsYnk2SmRNQWRmWmJPZnBaeFhnZngrTGRC?=
 =?utf-8?B?bGlwTEZvSU1aNUNxUXhPcHJzc2pDY0MxTkpMbUlHUGVFZTlsZUc0cXlyYUVN?=
 =?utf-8?B?NjRLdENnQVBGbUh6dGl3TDNVby9PQ3l1MVpzdWZvelJWUDFvK3F1enpiSExx?=
 =?utf-8?B?L3RCd3pFdGJuUjBSU1MyTkRtMGowWlduT25EUVJUaGxabFRueWc3YnVqbC80?=
 =?utf-8?B?K016Unl2eWVKRkdLVHVjQ1U4OFQ4WVhzaHZFbU12NTRoUjlzVy9VaXJ5d2Jm?=
 =?utf-8?B?aUtRYmZFYmVYb3dVdUdlNXczMTgzVUJlbFNwaDVpbmltYTBDSkFPbitvSE5U?=
 =?utf-8?B?Y3JicTlONFh4UktXTExRQWxxcXVMVVdwa0d3aHRrQkRVbmpPeHRZRmRkR3ND?=
 =?utf-8?B?K1FiL1JtMnowRUZENGVTSkJBTWxKSFpLVW5yQ3Z0MElDL3VzRWp4L2dCQnl2?=
 =?utf-8?B?Uy9pUUtvakFtK1g2RkN1azNVNkg4Z0ZEQ1J6UkJlR2prMHVvWkl6TGMzYXN1?=
 =?utf-8?Q?OzSVQw0lPsA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3414.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFNQRjlvWjVaZEd2dTJxbldaRFNLbmg5QkpQd2FoN3ZUdUZMN0hSbkdFR3ow?=
 =?utf-8?B?NVRpWStWbUZvR0wxeG9uNytuOUpHOXJNTGNZZ3c4WngrNndSeHpFdEhKVlAr?=
 =?utf-8?B?cGRYenZVV1R5VUVXQ0FRZHhOdm5wR1hlWGlBNmhsWnVnNi9wVS9vT1hBRVkz?=
 =?utf-8?B?dHNSSE9LTGdHelNNZWdTOGo5bGpmeHh2RmlqZktVTXljZlFPWTY5NlJaRER5?=
 =?utf-8?B?MUtBK1B5QmJ5Q0QvN1V2Q3c1ZHdRUWNCQ2hlNXBqN2h2blFSWlVGZWxjMC9s?=
 =?utf-8?B?RWlrYXIrVFdmeGU4NmE3SG5oWjVrK3VKbG9IcDlIUXYyM0x2WnhucWg4SUNT?=
 =?utf-8?B?Y2U0WkxmUkJGU09MWDZteXdXZEMvL3NkRDZyaEFtakNOYmtRenp3REpkZEdF?=
 =?utf-8?B?V2JHdkxSVjY0SUc4NjJjajFpQXhyalJ5a2VnOXRaRHZWNWY5N3QyQWQ1cUpL?=
 =?utf-8?B?bElTbEF2OFNQd0lSeFlUUHoxdlZ5czI5Nk9qanVVSi9nc0NCbzNWVFord0hH?=
 =?utf-8?B?Z1FLaTc5UXgyUUpkS29abjJQSGxVUHY2dzE5Z243L2VYUlY5ZGF1MkVjbmZG?=
 =?utf-8?B?K0lKbWpHZ0pzYS9acVh4OWVUOW5FZTdGOC9jK1hoazVjUzI5T3ZVeXlGM0dz?=
 =?utf-8?B?OGIzdVpNWEtTWFdKbzBEN0ZML2twbGdiNFFzMmxNaFJlZVFsUkRRZ2JTSzFj?=
 =?utf-8?B?THdXZ2I1aHlrR3dHRUk5QmE0SVRnT0dVQkluQjZTOXNYSERXTjlZSGVQcjVT?=
 =?utf-8?B?aWcyZGNFZE5NaGJkVkJEdUl1Rm9FSy9zRHBDdklCZGlnZHpqOTk0MTBSZ1pO?=
 =?utf-8?B?TnIrTDZZZW5jOG9wVHN3ODdYTUFPK0VONmQwOHVFNmM5cFZpQndLd3RtUmlV?=
 =?utf-8?B?UUkxNGdoaFAwWHhRemN6RFFZZHg0SDBjckhEWGNFT2JRU2wxMGlLcHFHTVQv?=
 =?utf-8?B?emdZMVc5bTlVQndodGtKekVTbjh4NFJzbWpjN1h1ODhVbFFjWXZCcC8xTVMv?=
 =?utf-8?B?TExsWUVjQ3g4YXBXTnkrTVEvQlVSUDVQbWRLK2pVcDdvdEVZVXhISG4rUXMx?=
 =?utf-8?B?bzUwc3haSEdhOUhWZWcwMS9DNGh1OWd1MkU1cGZDVnJxNUxBME1pdG1qeVJ1?=
 =?utf-8?B?cWhEaStkN0hRQXhkWHhGMko4dFk4a2xzRkRGY2V0dTk4Y0w1QndTbEp3MnJ5?=
 =?utf-8?B?b2x3TXRsRlpKQlF0N0IxYy83NkxrNE51TWJudVRJOWloMFVVSHhuWWZBSTR6?=
 =?utf-8?B?NThmRkkyMDY2cDBLenhqRGYvbmVMZnJjM2dzZHlTSFcrRjVRZklyS3pia1F2?=
 =?utf-8?B?di8zVFJrN3RFenJuVDY1MW9wZUlKTUltQlhQUkNvN1UyRll1a0doZ09qL2Vp?=
 =?utf-8?B?UE13eVNmYjh4OWVUMURrYWxad2ExQ21jbmhpTlhWU21qN253dUFNdkFMMlFm?=
 =?utf-8?B?a0ROaDI1MWJUNXR3WHVxYjYyNjB1V0QwTmNiV21UTHFRekFtakFXSENiNG5G?=
 =?utf-8?B?K0Zob2orWk84emRubEZibTIvbGpZUmNLTmtUZi93NXo2a1hFZTNwTmQ2T3pD?=
 =?utf-8?B?YXRzc3g3RTN3Yjc1Ykh5bVpQS1I5RFh3SFBZczdwamRZRk43N1I4SUNFZERZ?=
 =?utf-8?B?eklYbGxCdGxuWks3Z2wxcEZqVjlsNHBmTnlBcUd3aC80ZnRJcVhUR2Fpck5E?=
 =?utf-8?B?aldpb24veXNubmFyUHV0dkhERUhyUnhXNGNNRE9OOVd2ZE9JOVo3V1FWOUxz?=
 =?utf-8?B?d2VCd2JxZEl3YVhxc3dWTUJtazB6L0doTXkrMUZySWgzOXFreUNMZUJRNnps?=
 =?utf-8?B?NXJnM3pKaWZ6UzEyR21QZ0tidTZ4dExJZW90WkMvZDhsWEJPNUQ0ZGFSSDJH?=
 =?utf-8?B?eDUvL2RkTTM5OU8rWjhneThHZW1EZEZ2clNvaTd6REp1cnZpTkkwWkxPRnFs?=
 =?utf-8?B?ZWVhMktRNlhJYlZoQzIyTXZZQ01CZmxPcUtTbEE0UHZKSldBd29STmV5c2ZO?=
 =?utf-8?B?bFNTcXpsUUxzMXFGOU5ET0hiRGZOTVdCQytockxZWDR2NDhVNEZjS0JTd0hV?=
 =?utf-8?B?eGpqR0FPZ2xZQ1JPZU5TZnlvSlVSdC85b1FNZWFubTN4cXVBVE94V0ljRVht?=
 =?utf-8?Q?Kv9HdQN8ADLfCc4aP64uR/5FL?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edf01d9-424f-4a7a-b9e7-08dddf39f092
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3414.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:03:30.0380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0h0sf705YHzWAJtvkz2ZXRfVqXGVmzPtew80wfdcbaw2swXXhVOAr6tjCbhi8B9r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR01MB9151

On 8/11/2025 4:35 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Reduce the per-connection footprint in the host's and RNIC's memory
> management TLBs by combining groups of a connection's Receive
> buffers into fewer IOVAs.

This is an interesting and potentially useful approach. Keeping
the iova count (==1) reduces the size of work requests and greatly
simplifies processing.

But how large are the iova's currently? RPCRDMA_DEF_INLINE_THRESH
is just 4096, which would mean typically <= 2 iova's. The max is
arbitrarily but consistently 64KB, is this complexity worth it?

And, allocating large contiguous buffers would seem to shift the
burden to kmalloc and/or the IOMMU, so it's not free, right?

> I don't have a good way to measure whether this approach is
> effective.

I guess I'd need to see this data to be more convinced. But it does
seem potentially promising, at least on some RDMA provider hardware.

Tom.

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/linux/sunrpc/svc_rdma.h         |   3 +
>   include/trace/events/rpcrdma.h          |  99 +++++++++++
>   net/sunrpc/xprtrdma/Makefile            |   2 +-
>   net/sunrpc/xprtrdma/pool.c              | 223 ++++++++++++++++++++++++
>   net/sunrpc/xprtrdma/pool.h              |  25 +++
>   net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  43 ++---
>   6 files changed, 370 insertions(+), 25 deletions(-)
>   create mode 100644 net/sunrpc/xprtrdma/pool.c
>   create mode 100644 net/sunrpc/xprtrdma/pool.h
> 
> Changes since v1:
> - Rename "chunks" to "shards" -- RPC/RDMA already has chunks
> - Replace pool's list of shards with an xarray
> - Implement bitmap-based shard free space management
> - Implement some naive observability
> 
> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
> index 22704c2e5b9b..b4f3c01f1b94 100644
> --- a/include/linux/sunrpc/svc_rdma.h
> +++ b/include/linux/sunrpc/svc_rdma.h
> @@ -73,6 +73,8 @@ extern struct percpu_counter svcrdma_stat_recv;
>   extern struct percpu_counter svcrdma_stat_sq_starve;
>   extern struct percpu_counter svcrdma_stat_write;
>   
> +struct rpcrdma_pool;
> +
>   struct svcxprt_rdma {
>   	struct svc_xprt      sc_xprt;		/* SVC transport structure */
>   	struct rdma_cm_id    *sc_cm_id;		/* RDMA connection id */
> @@ -112,6 +114,7 @@ struct svcxprt_rdma {
>   	unsigned long	     sc_flags;
>   	struct work_struct   sc_work;
>   
> +	struct rpcrdma_pool  *sc_recv_pool;
>   	struct llist_head    sc_recv_ctxts;
>   
>   	atomic_t	     sc_completion_ids;
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
> index e6a72646c507..8bc713082c1a 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -2336,6 +2336,105 @@ DECLARE_EVENT_CLASS(rpcrdma_client_register_class,
>   DEFINE_CLIENT_REGISTER_EVENT(rpcrdma_client_register);
>   DEFINE_CLIENT_REGISTER_EVENT(rpcrdma_client_unregister);
>   
> +TRACE_EVENT(rpcrdma_pool_create,
> +	TP_PROTO(
> +		unsigned int poolid,
> +		size_t bufsize
> +	),
> +
> +	TP_ARGS(poolid, bufsize),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, poolid)
> +		__field(size_t, bufsize)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->poolid = poolid;
> +		__entry->bufsize = bufsize;
> +	),
> +
> +	TP_printk("poolid=%u bufsize=%zu bytes",
> +		__entry->poolid, __entry->bufsize
> +	)
> +);
> +
> +TRACE_EVENT(rpcrdma_pool_destroy,
> +	TP_PROTO(
> +		unsigned int poolid
> +	),
> +
> +	TP_ARGS(poolid),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, poolid)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->poolid = poolid;),
> +
> +	TP_printk("poolid=%u",
> +		__entry->poolid
> +	)
> +);
> +
> +DECLARE_EVENT_CLASS(rpcrdma_pool_shard_class,
> +	TP_PROTO(
> +		unsigned int poolid,
> +		u32 shardid
> +	),
> +
> +	TP_ARGS(poolid, shardid),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, poolid)
> +		__field(u32, shardid)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->poolid = poolid;
> +		__entry->shardid = shardid;
> +	),
> +
> +	TP_printk("poolid=%u shardid=%u",
> +		__entry->poolid, __entry->shardid
> +	)
> +);
> +
> +#define DEFINE_RPCRDMA_POOL_SHARD_EVENT(name)				\
> +	DEFINE_EVENT(rpcrdma_pool_shard_class, name,			\
> +	TP_PROTO(							\
> +		unsigned int poolid,					\
> +		u32 shardid						\
> +	),								\
> +	TP_ARGS(poolid, shardid))
> +
> +DEFINE_RPCRDMA_POOL_SHARD_EVENT(rpcrdma_pool_shard_new);
> +DEFINE_RPCRDMA_POOL_SHARD_EVENT(rpcrdma_pool_shard_free);
> +
> +TRACE_EVENT(rpcrdma_pool_buffer,
> +	TP_PROTO(
> +		unsigned int poolid,
> +		const void *buffer
> +	),
> +
> +	TP_ARGS(poolid, buffer),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, poolid)
> +		__field(const void *, buffer)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->poolid = poolid;
> +		__entry->buffer = buffer;
> +	),
> +
> +	TP_printk("poolid=%u buffer=%p",
> +		__entry->poolid, __entry->buffer
> +	)
> +);
> +
>   #endif /* _TRACE_RPCRDMA_H */
>   
>   #include <trace/define_trace.h>
> diff --git a/net/sunrpc/xprtrdma/Makefile b/net/sunrpc/xprtrdma/Makefile
> index 3232aa23cdb4..f69456dffe87 100644
> --- a/net/sunrpc/xprtrdma/Makefile
> +++ b/net/sunrpc/xprtrdma/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_SUNRPC_XPRT_RDMA) += rpcrdma.o
>   
> -rpcrdma-y := transport.o rpc_rdma.o verbs.o frwr_ops.o ib_client.o \
> +rpcrdma-y := transport.o rpc_rdma.o verbs.o frwr_ops.o ib_client.o pool.o \
>   	svc_rdma.o svc_rdma_backchannel.o svc_rdma_transport.o \
>   	svc_rdma_sendto.o svc_rdma_recvfrom.o svc_rdma_rw.o \
>   	svc_rdma_pcl.o module.o
> diff --git a/net/sunrpc/xprtrdma/pool.c b/net/sunrpc/xprtrdma/pool.c
> new file mode 100644
> index 000000000000..e285c3e9c38e
> --- /dev/null
> +++ b/net/sunrpc/xprtrdma/pool.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025, Oracle and/or its affiliates.
> + *
> + * Pools for RPC-over-RDMA Receive buffers.
> + *
> + * A buffer pool attempts to conserve both the number of DMA mappings
> + * and the device's IOVA space by collecting small buffers together
> + * into a shard that has a single DMA mapping.
> + *
> + * API Contract:
> + *  - Buffers contained in one rpcrdma_pool instance are the same
> + *    size (rp_bufsize), no larger than RPCRDMA_MAX_INLINE_THRESH
> + *  - Buffers in one rpcrdma_pool instance are mapped using the same
> + *    DMA direction
> + *  - Buffers in one rpcrdma_pool instance are automatically released
> + *    when the instance is destroyed
> + *
> + * Future work:
> + *   - Manage pool resources by reference count
> + */
> +
> +#include <linux/list.h>
> +#include <linux/xarray.h>
> +#include <linux/sunrpc/svc_rdma.h>
> +
> +#include <rdma/ib_verbs.h>
> +
> +#include "xprt_rdma.h"
> +#include "pool.h"
> +
> +#include <trace/events/rpcrdma.h>
> +
> +/*
> + * An idr would give near perfect pool ID uniqueness, but for
> + * the moment the pool ID is used only for observability, not
> + * correctness.
> + */
> +static atomic_t rpcrdma_pool_id;
> +
> +struct rpcrdma_pool {
> +	struct xarray		rp_xa;
> +	struct ib_device	*rp_device;
> +	size_t			rp_shardsize;	// in bytes
> +	size_t			rp_bufsize;	// in bytes
> +	enum dma_data_direction	rp_direction;
> +	unsigned int		rp_bufs_per_shard;
> +	unsigned int		rp_pool_id;
> +};
> +
> +struct rpcrdma_pool_shard {
> +	u8			*pc_cpu_addr;
> +	u64			pc_mapped_addr;
> +	unsigned long		*pc_bitmap;
> +};
> +
> +static struct rpcrdma_pool_shard *
> +rpcrdma_pool_shard_alloc(struct rpcrdma_pool *pool, gfp_t flags)
> +{
> +	struct rpcrdma_pool_shard *shard;
> +	size_t bmap_size;
> +
> +	shard = kmalloc(sizeof(*shard), flags);
> +	if (!shard)
> +		goto fail;
> +
> +	bmap_size = BITS_TO_LONGS(pool->rp_bufs_per_shard) * sizeof(unsigned long);
> +	shard->pc_bitmap = kzalloc(bmap_size, flags);
> +	if (!shard->pc_bitmap)
> +		goto free_shard;
> +
> +	/*
> +	 * For good NUMA awareness, allocate the shard's I/O buffer
> +	 * on the NUMA node that the underlying device is affined to.
> +	 */
> +	shard->pc_cpu_addr = kmalloc_node(pool->rp_shardsize, flags,
> +					  ibdev_to_node(pool->rp_device));
> +	if (!shard->pc_cpu_addr)
> +		goto free_bitmap;
> +	shard->pc_mapped_addr = ib_dma_map_single(pool->rp_device,
> +						  shard->pc_cpu_addr,
> +						  pool->rp_shardsize,
> +						  pool->rp_direction);
> +	if (ib_dma_mapping_error(pool->rp_device, shard->pc_mapped_addr))
> +		goto free_iobuf;
> +
> +	return shard;
> +
> +free_iobuf:
> +	kfree(shard->pc_cpu_addr);
> +free_bitmap:
> +	kfree(shard->pc_bitmap);
> +free_shard:
> +	kfree(shard);
> +fail:
> +	return NULL;
> +}
> +
> +static void
> +rpcrdma_pool_shard_free(struct rpcrdma_pool *pool,
> +			struct rpcrdma_pool_shard *shard)
> +{
> +	ib_dma_unmap_single(pool->rp_device, shard->pc_mapped_addr,
> +			    pool->rp_shardsize, pool->rp_direction);
> +	kfree(shard->pc_cpu_addr);
> +	kfree(shard->pc_bitmap);
> +	kfree(shard);
> +}
> +
> +/**
> + * rpcrdma_pool_create - Allocate and initialize an rpcrdma_pool instance
> + * @args: pool creation arguments
> + * @flags: GFP flags used during pool creation
> + *
> + * Returns a pointer to an opaque rpcrdma_pool instance or
> + * NULL. If a pool instance is returned, caller must free the
> + * returned instance using rpcrdma_pool_destroy().
> + */
> +struct rpcrdma_pool *
> +rpcrdma_pool_create(struct rpcrdma_pool_args *args, gfp_t flags)
> +{
> +	struct rpcrdma_pool *pool;
> +
> +	pool = kmalloc(sizeof(*pool), flags);
> +	if (!pool)
> +		return NULL;
> +
> +	xa_init_flags(&pool->rp_xa, XA_FLAGS_ALLOC);
> +	pool->rp_device = args->pa_device;
> +	pool->rp_shardsize = RPCRDMA_MAX_INLINE_THRESH;
> +	pool->rp_bufsize = args->pa_bufsize;
> +	pool->rp_direction = args->pa_direction;
> +	pool->rp_bufs_per_shard = pool->rp_shardsize / pool->rp_bufsize;
> +	pool->rp_pool_id = atomic_inc_return(&rpcrdma_pool_id);
> +
> +	trace_rpcrdma_pool_create(pool->rp_pool_id, pool->rp_bufsize);
> +	return pool;
> +}
> +
> +/**
> + * rpcrdma_pool_destroy - Release resources owned by @pool
> + * @pool: buffer pool instance that will no longer be used
> + *
> + * This call releases all buffers in @pool that were allocated
> + * via rpcrdma_pool_buffer_alloc().
> + */
> +void
> +rpcrdma_pool_destroy(struct rpcrdma_pool *pool)
> +{
> +	struct rpcrdma_pool_shard *shard;
> +	unsigned long index;
> +
> +	trace_rpcrdma_pool_destroy(pool->rp_pool_id);
> +
> +	xa_for_each(&pool->rp_xa, index, shard) {
> +		trace_rpcrdma_pool_shard_free(pool->rp_pool_id, index);
> +		xa_erase(&pool->rp_xa, index);
> +		rpcrdma_pool_shard_free(pool, shard);
> +	}
> +
> +	xa_destroy(&pool->rp_xa);
> +	kfree(pool);
> +}
> +
> +/**
> + * rpcrdma_pool_buffer_alloc - Allocate a buffer from @pool
> + * @pool: buffer pool from which to allocate the buffer
> + * @flags: GFP flags used during this allocation
> + * @cpu_addr: CPU address of the buffer
> + * @mapped_addr: mapped address of the buffer
> + *
> + * Return values:
> + *   %true: @cpu_addr and @mapped_addr are filled in with a DMA-mapped buffer
> + *   %false: No buffer is available
> + *
> + * When rpcrdma_pool_buffer_alloc() is successful, the returned
> + * buffer is freed automatically when the buffer pool is released
> + * by rpcrdma_pool_destroy().
> + */
> +bool
> +rpcrdma_pool_buffer_alloc(struct rpcrdma_pool *pool, gfp_t flags,
> +			  void **cpu_addr, u64 *mapped_addr)
> +{
> +	struct rpcrdma_pool_shard *shard;
> +	u64 returned_mapped_addr;
> +	void *returned_cpu_addr;
> +	unsigned long index;
> +	u32 id;
> +
> +	xa_for_each(&pool->rp_xa, index, shard) {
> +		unsigned int i;
> +
> +		returned_cpu_addr = shard->pc_cpu_addr;
> +		returned_mapped_addr = shard->pc_mapped_addr;
> +		for (i = 0; i < pool->rp_bufs_per_shard; i++) {
> +			if (!test_and_set_bit(i, shard->pc_bitmap)) {
> +				returned_cpu_addr += i * pool->rp_bufsize;
> +				returned_mapped_addr += i * pool->rp_bufsize;
> +				goto out;
> +			}
> +		}
> +	}
> +
> +	shard = rpcrdma_pool_shard_alloc(pool, flags);
> +	if (!shard)
> +		return false;
> +	set_bit(0, shard->pc_bitmap);
> +	returned_cpu_addr = shard->pc_cpu_addr;
> +	returned_mapped_addr = shard->pc_mapped_addr;
> +
> +	if (xa_alloc(&pool->rp_xa, &id, shard, xa_limit_16b, flags) != 0) {
> +		rpcrdma_pool_shard_free(pool, shard);
> +		return false;
> +	}
> +	trace_rpcrdma_pool_shard_new(pool->rp_pool_id, id);
> +
> +out:
> +	*cpu_addr = returned_cpu_addr;
> +	*mapped_addr = returned_mapped_addr;
> +
> +	trace_rpcrdma_pool_buffer(pool->rp_pool_id, returned_cpu_addr);
> +	return true;
> +}
> diff --git a/net/sunrpc/xprtrdma/pool.h b/net/sunrpc/xprtrdma/pool.h
> new file mode 100644
> index 000000000000..214f8fe78b9a
> --- /dev/null
> +++ b/net/sunrpc/xprtrdma/pool.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025, Oracle and/or its affiliates.
> + *
> + * Pools for Send and Receive buffers.
> + */
> +
> +#ifndef RPCRDMA_POOL_H
> +#define RPCRDMA_POOL_H
> +
> +struct rpcrdma_pool_args {
> +	struct ib_device	*pa_device;
> +	size_t			pa_bufsize;
> +	enum dma_data_direction	pa_direction;
> +};
> +
> +struct rpcrdma_pool;
> +
> +struct rpcrdma_pool *
> +rpcrdma_pool_create(struct rpcrdma_pool_args *args, gfp_t flags);
> +void rpcrdma_pool_destroy(struct rpcrdma_pool *pool);
> +bool rpcrdma_pool_buffer_alloc(struct rpcrdma_pool *pool, gfp_t flags,
> +			       void **cpu_addr, u64 *mapped_addr);
> +
> +#endif /* RPCRDMA_POOL_H */
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> index e7e4a39ca6c6..f625f1ede434 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -104,9 +104,9 @@
>   #include <linux/sunrpc/svc_rdma.h>
>   
>   #include "xprt_rdma.h"
> -#include <trace/events/rpcrdma.h>
> +#include "pool.h"
>   
> -static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc);
> +#include <trace/events/rpcrdma.h>
>   
>   static inline struct svc_rdma_recv_ctxt *
>   svc_rdma_next_recv_ctxt(struct list_head *list)
> @@ -115,14 +115,14 @@ svc_rdma_next_recv_ctxt(struct list_head *list)
>   					rc_list);
>   }
>   
> +static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc);
> +
>   static struct svc_rdma_recv_ctxt *
>   svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
>   {
>   	int node = ibdev_to_node(rdma->sc_cm_id->device);
>   	struct svc_rdma_recv_ctxt *ctxt;
>   	unsigned long pages;
> -	dma_addr_t addr;
> -	void *buffer;
>   
>   	pages = svc_serv_maxpages(rdma->sc_xprt.xpt_server);
>   	ctxt = kzalloc_node(struct_size(ctxt, rc_pages, pages),
> @@ -130,13 +130,11 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
>   	if (!ctxt)
>   		goto fail0;
>   	ctxt->rc_maxpages = pages;
> -	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
> -	if (!buffer)
> +
> +	if (!rpcrdma_pool_buffer_alloc(rdma->sc_recv_pool, GFP_KERNEL,
> +				       &ctxt->rc_recv_buf,
> +				       &ctxt->rc_recv_sge.addr))
>   		goto fail1;
> -	addr = ib_dma_map_single(rdma->sc_pd->device, buffer,
> -				 rdma->sc_max_req_size, DMA_FROM_DEVICE);
> -	if (ib_dma_mapping_error(rdma->sc_pd->device, addr))
> -		goto fail2;
>   
>   	svc_rdma_recv_cid_init(rdma, &ctxt->rc_cid);
>   	pcl_init(&ctxt->rc_call_pcl);
> @@ -149,30 +147,17 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
>   	ctxt->rc_recv_wr.sg_list = &ctxt->rc_recv_sge;
>   	ctxt->rc_recv_wr.num_sge = 1;
>   	ctxt->rc_cqe.done = svc_rdma_wc_receive;
> -	ctxt->rc_recv_sge.addr = addr;
>   	ctxt->rc_recv_sge.length = rdma->sc_max_req_size;
>   	ctxt->rc_recv_sge.lkey = rdma->sc_pd->local_dma_lkey;
> -	ctxt->rc_recv_buf = buffer;
>   	svc_rdma_cc_init(rdma, &ctxt->rc_cc);
>   	return ctxt;
>   
> -fail2:
> -	kfree(buffer);
>   fail1:
>   	kfree(ctxt);
>   fail0:
>   	return NULL;
>   }
>   
> -static void svc_rdma_recv_ctxt_destroy(struct svcxprt_rdma *rdma,
> -				       struct svc_rdma_recv_ctxt *ctxt)
> -{
> -	ib_dma_unmap_single(rdma->sc_pd->device, ctxt->rc_recv_sge.addr,
> -			    ctxt->rc_recv_sge.length, DMA_FROM_DEVICE);
> -	kfree(ctxt->rc_recv_buf);
> -	kfree(ctxt);
> -}
> -
>   /**
>    * svc_rdma_recv_ctxts_destroy - Release all recv_ctxt's for an xprt
>    * @rdma: svcxprt_rdma being torn down
> @@ -185,8 +170,9 @@ void svc_rdma_recv_ctxts_destroy(struct svcxprt_rdma *rdma)
>   
>   	while ((node = llist_del_first(&rdma->sc_recv_ctxts))) {
>   		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
> -		svc_rdma_recv_ctxt_destroy(rdma, ctxt);
> +		kfree(ctxt);
>   	}
> +	rpcrdma_pool_destroy(rdma->sc_recv_pool);
>   }
>   
>   /**
> @@ -305,8 +291,17 @@ static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
>    */
>   bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
>   {
> +	struct rpcrdma_pool_args args = {
> +		.pa_device	= rdma->sc_cm_id->device,
> +		.pa_bufsize	= rdma->sc_max_req_size,
> +		.pa_direction	= DMA_FROM_DEVICE,
> +	};
>   	unsigned int total;
>   
> +	rdma->sc_recv_pool = rpcrdma_pool_create(&args, GFP_KERNEL);
> +	if (!rdma->sc_recv_pool)
> +		return false;
> +
>   	/* For each credit, allocate enough recv_ctxts for one
>   	 * posted Receive and one RPC in process.
>   	 */


