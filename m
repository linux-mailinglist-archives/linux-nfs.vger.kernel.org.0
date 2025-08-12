Return-Path: <linux-nfs+bounces-13592-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B1CB23A6A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 23:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7100F1B64851
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 21:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B602882C9;
	Tue, 12 Aug 2025 21:13:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2104.outbound.protection.outlook.com [40.107.220.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14089274B4D
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033223; cv=fail; b=a3IyD+fZPnBmqWkFbIMyg5onTgroV0x14TBCcJAzbkQoZ0rNpEjNFtNSp56t2dz1KSF2BlUh8wQy8vynCV/U1nVQxSW2TMd+xbV8ec1YNvf+cqMEjTf56KsA81TIZFgdpvWxxXAoeNneDewCbpDPwfkqYXK/XNEAtUsL7LovL/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033223; c=relaxed/simple;
	bh=C91g+sb39fbPVo2JhQRfCblzuFstPlv8TGSayR+FfyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XG26faT7WnEzyojTRYSjuK1mK1yfs1dwxr+XE/2diyqXo8wQKwHBpLpAa0T3GHf7StFVpgcAqhaLpdkTl/sCbqniZDmQDUPMgIzewQP5xQph4vMRBfraRnLHDm2xBdtsz6QIIkbqrKxQbpU9Cbi0AFncPGgP6t1qwabORIVKDfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.220.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj1P8mBnZYDwSTFovxdf42OyANHVBpJ2M5JlyP6sSBUy0sYWOFfG0UJZbJTY1ezC8opHSkw4MYCDVt4hBTLoFZ7Dsd/rl3luu0Mm46DvKPlnYRen87tDS9EtcF7MMWVCFjh22gEd9vmHF1phoLh1tBpjhSFt71hCvkXNByjAqVNKOoGCpFuMdqu1O1z6sU7OrAK8U7pznDIz6sdZU6mF8/jdf/X9jLYgiae92zaTirY6mA36smluQjG+1DO0W6TFDgfoDWRRm2qRwn+5i9PioiKJxovsfT7ChNpNc/zoNPZpef18YiAaWavG0cEC3zMKIffWrBC5YkM5nZyqSYaXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIS6IUDkLY6jpWO4f1vK+8rYxFcnf0eo3H/fK4DWAmw=;
 b=AYOb8zeuP1AQnh9Jnzngk2zsdMUs2FIzg4pfsGXPlt1fLKj5KZP5DCdD4AfnoqFfcZfJZ1zJzvk+nkp2cJ3MqbRbCvCSB7VNvlTU5Ghg/6gal+TylBtg7x10rpXTKZJOcBgMQJR+9k8a81egSLoODugDtE0qB/t9MlJ687DXG3filtzkkDeM2RV80Ng0vhIVK8OT5Z3xXo9GUsOaik/tuqTQ2grkK7Y3DUW1hcy3evRwvYN2l9gKnjnCua8X561pZ9pKij/hu8rL6LMPfFddtN9tn1R6fZP5SlzC0oGnEicDQp9E9T4bAd0gcGDHN9HfaO+Ziqr/fUhCfJHEKgOaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from DM5PR0102MB3414.prod.exchangelabs.com (2603:10b6:4:a8::22) by
 CH0PR01MB7171.prod.exchangelabs.com (2603:10b6:610:fb::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.14; Tue, 12 Aug 2025 21:13:39 +0000
Received: from DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db]) by DM5PR0102MB3414.prod.exchangelabs.com
 ([fe80::cc85:45b5:e6fe:e2db%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 21:13:39 +0000
Message-ID: <c5701f0f-3895-4978-9d7f-b5b960b20d85@talpey.com>
Date: Tue, 12 Aug 2025 17:13:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfsd: unregister with rpcbind when removing listener
To: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, neil@brown.name, Dai.Ngo@oracle.com
References: <20250812190244.30452-1-okorniev@redhat.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <20250812190244.30452-1-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::10) To DM5PR0102MB3414.prod.exchangelabs.com
 (2603:10b6:4:a8::22)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3414:EE_|CH0PR01MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: a422d124-8585-418f-669c-08ddd9e51bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU9LM3orZ0pSTWFuQUJNTEZZTHVkZHlpRTZ4ZkJNUldJKzhBMUorUjFMcDhj?=
 =?utf-8?B?Rk9oOUdjcjVJTVQ1V2wwaXNrWkU1YnhFNE5tekx4YlkwSklUV1hsQzV4dXVK?=
 =?utf-8?B?OTQ4YUNNWTA0TUd0cXlMcTJqd2kvaGc2ZTZhRk9CQ1ZtbTN3Nkpha2F0azll?=
 =?utf-8?B?TDBVRk1hK281bllSYXlRU012dmlXWGdKQktVdkoyZHhwdGo3UmR3bE1IeWo0?=
 =?utf-8?B?OTVFOG9rbkVGSllXMlRUS3VlNENhRno4MWJKckd5QXJ4ems1NnQwTHJMeklM?=
 =?utf-8?B?K2VyY0dIMTVCbkExZmNWb08vNjBUTzUrNEUrRnZZTnJrWWM4VlNVTEpBVGlT?=
 =?utf-8?B?NkZjdnRtdDU2L3YzRlJJSGNGRDdqUzV4Y1FXaWZEeWZpUmVCYkVPUmhJdXg2?=
 =?utf-8?B?THdjbm01aDdWbUhpQ2hkdlFhQnltWldxRjgxTTI1Tm5FZVQ2YjQvV2pUQTBu?=
 =?utf-8?B?Q3FONmw5dlJCY1JmVnRrOWlocWRNc1F2L2l5enRaWlBMSTdZcmpGWlB3ZjNW?=
 =?utf-8?B?OGVFWUcwcUNrTVlhS2JtNlNtMVIwNnZLb2h5MFQ2NUorR2J5UFVobmUxUmZm?=
 =?utf-8?B?eVhCbG16c0pGTEtEV0VPdnlMdTZNTHZERFE1aTYyS1VvQldtaExYVksvYlRa?=
 =?utf-8?B?eGxkbGxsSmE1WGd1N09mT3U2eW5ra2o5YjdOTXN3L0ZTeC81ZGpJVmIwSTZp?=
 =?utf-8?B?eHF6VW00bGluS05mQTgvMk53ZlJldHRndkNvTkFhcmZ3Y3hYSFpUczNsUnVt?=
 =?utf-8?B?WWtNaHlONDV6Lzh2L0xwU1pZdXBxcUk4OFp0Z2dlSHdVOUl6NTAxbUlBVnZn?=
 =?utf-8?B?WkUrOHUxR1ZRdWxQWllZRXNTU3Ntak5lMTBLNlFNc1JEVkcyTGRwR1Z1MGtB?=
 =?utf-8?B?bUtCd3QvaEJjZXdSYkpodU4waUJxeFZ3bEhsNXFmZXNCY2NaeVRsb1htckdN?=
 =?utf-8?B?L3Y4K2YxU2xpZis4UjZkdlFjUXBFZ3E5TEl2OGRad2s0SmZYQml3UlVmVEV2?=
 =?utf-8?B?SmlFeWNTMTFZZlNWS2ZIN2J0SVNPcHdoTHRSSDFFY0ZiVTczRGpKS1pqZERs?=
 =?utf-8?B?dE5USDdRbm83a3JDTGN3K0E0bXQ5QytxUDJHcGtQcmJ6K2JyT2V5UGdOSC9z?=
 =?utf-8?B?NnFEZHNTZ2JwRktZM2RFNlFqMkRQZHNHNXJ2NnB6eCt0VXdib1pTZHJ1MkZV?=
 =?utf-8?B?QWlqQ0U5OXU5bEtobXozSGtYN1AvcS84enlHNnJVMTd5N3RSeEtaVDdodysv?=
 =?utf-8?B?MERnaU1SV1BDV0JadGtRNFhHTkFxMW02aE5rQndlTlYrTUdCbVF6NGYxcjFK?=
 =?utf-8?B?b3MzQlV0Uzd0MDRCUG9YL1N4Y1BxMkN6UHIrcWwvTzFiS28xU1QxbUo0Yk5V?=
 =?utf-8?B?SnF6eUF5Wi9KMEh0MEVncTBZcmlmclJ1RlY1NzZaQ2k3RnNnMm8wbFFhUXVq?=
 =?utf-8?B?ZzFxdXIwTE51Z1FJL2ZFY3pUTjArT2ZBK1c5dVhSaHlMd01nRHM4bEJzZFZE?=
 =?utf-8?B?VzY3Q2xuTE1ocGwxS0l3N0NkRWpuOWRvZEsyeVZ5NGtHdHZ2WVdtT1A5cVVN?=
 =?utf-8?B?dmNVbGJ0dEg3Q1VJSXpDMkhYaWxnQ1NLNjdadGcreWV6cWxPZ2dIdUdXOXcy?=
 =?utf-8?B?WGo5bTkxeHRCaU0xMWFOZ3hXZ1hSUGEvREJrKzQ1eTlldkhPbkdqbEF0Z3Zp?=
 =?utf-8?B?WitCUjhLeTVCanJkclJMaHRvWW9aREl2TlpIVmkwRHkrTFBPY3ljbWMvTDFY?=
 =?utf-8?B?eE5FNGdpOUhIM2ZkMHNQUVBFWjJQMG1tWEhXTDZYY0pqVmlHa2lDSlN4dnQ5?=
 =?utf-8?B?YkxUWDVRRFN3V25QZ2s1Z0U1Y05MNzMwbFpMa2FSMkVQY2dQelNTL1cvWDVv?=
 =?utf-8?B?ZW91b2R5OWo5aVcyczJJY21xN1VSdTgyVkJZSXF0V2pkazUyQURsbndKWGJC?=
 =?utf-8?Q?Yn5sD7D6idA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3414.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1E5VVlsM3lLSzNIVm9vRlFoL1NLU1ZDRWVNSGJ4YlVUZHBhTDQyc1hGK1pV?=
 =?utf-8?B?NHozaWJ4QlBiOWtiMk9lQVFZNUJCTGVPanB0UnR1T2hidWUydi94QTdmeURj?=
 =?utf-8?B?aFljdW14Qlp0Q3kvL0NCaVkranY5U3RVQ3lEKzlOOXYwWlR2Z1hyNW1ROFVG?=
 =?utf-8?B?ZEp1ZFZTcnhLVmI0TUNwcVFtbEFjakFvV2UrWFhMUExlaVJBZ0ZuUDBHSXU5?=
 =?utf-8?B?TkpmQkNORHFkZDdrdHkxVGZ5dUdHVW44c3M5RG51NEwrWUs2VGFzNS8wemJv?=
 =?utf-8?B?ODVIYzIxSTB4NTFIWUNJM3JkcW00VDAyU3VRS1BDVUpVM2h3N2JQL2d5c0dM?=
 =?utf-8?B?cS8wU05xZmVuR3ZjV3U5aEsyYkxrdmROK2VTUzJwZVNEOTZrNFlNektXdWdm?=
 =?utf-8?B?aXZpc2hlWXdwWDlXUlFWN2hpMXoxdW1JK1JKWXNyUkdKa2xudDVITmxGQWZp?=
 =?utf-8?B?YTRVdXRVMGJpeGhza1dqTy9lNmxUbE1vVDQ0MmpzUnk3VFNDL2FnRU9KaEZH?=
 =?utf-8?B?bWF5RkJ5QTFlNzZjQ01BM1Z3S0VWVEJsT1pUS2t2cEpQMUYzREV5V0IrT0Rk?=
 =?utf-8?B?VEFCUkE3RTJkOWk0eWlFbmsyZVphRFNneTZ2WkREUzZ3WStNRkVpMng1OEpv?=
 =?utf-8?B?M0t5Y0lVVnJNU3E3ZUoydVhHOUxtMDlnL2lmcWxicVd4cm0zak5Ea1ROdWMw?=
 =?utf-8?B?anlnSUZ5d0k2c2ExcmpiVUtlTXZJSjZMdXZJWGZSVVFNR3J5R010M04ycW1R?=
 =?utf-8?B?T1VkY0k3L25YUndPTjl4QkRWYy9vS2pFaHNvbVZobXFwNDRFUGdLbUFEbU5x?=
 =?utf-8?B?YVdjeVJHRGtSc3FzTzVobEYrQXYrNFRjSFR2L0VpWHJnbXN4c1pheXc5dmtN?=
 =?utf-8?B?YU1MdENpTGpLeGVuZkVUdmhwOGkwWTBnYkFWMnBubXhtbHl5K2pDcmJmM1FO?=
 =?utf-8?B?QUlNcHRpMDl3NmxaWjRaVXpobFJQWXVuSC9RY3h1RDRBRzhEVEt3K3lOQzA3?=
 =?utf-8?B?QWdmdE9aNFBxUGErVjBMZDJ6ZHZ4d0IrYkVHSnBCNy96T2dNVTV3SUZ0ZEF1?=
 =?utf-8?B?cmpuaWJrNjBqVkVRTnFIRjJTSFdHT2pQM0RvSk9EWXcvbnUxcERiRmcydFZh?=
 =?utf-8?B?QXpzODdxb2tXVmFGQS9VS2dkd3RCenpaWkpHTExkTFpUdjJVRHFSMnlHZE5n?=
 =?utf-8?B?ekZWSGlCaDNBcFBlMzFXUDgzeklsUWlqN2RPL1J5Qnl1TC9sMWVnblEzL3FY?=
 =?utf-8?B?TFBMS0htNGlHdERUcGxUTUc1anIyQUFZSTN4ZlpiY25lOUpKQy80Zk84OWJ4?=
 =?utf-8?B?SkFSOGUyRElsRzcwaUhkSzVTK3dpa1A1TUV1RmplN1VaNDdLYVh4dVJWYUtt?=
 =?utf-8?B?eE40Nzd3L2lFV013S1dGaXQwVU1yKzFzdmNrK21kZERMb1lDSkdwTWlSM1FT?=
 =?utf-8?B?emVvbGxRbzZOL3ZsM21ybHBmODd2TjRlaTBMNmVkUFNrWkhOZ3I5Z3hTK2Zp?=
 =?utf-8?B?V1krZGZ2V0FTR3RWbjBlanIwdkVpSmFmdDNjQ09tWDFZb1NuSnRCdy96Z1VY?=
 =?utf-8?B?MGd1eXFGWHo3NDJkeGZac3R4RjYwK2Z6RG04aitxWk1JZUpLcHB2WkgvWXp2?=
 =?utf-8?B?VGdQV0dNVlN5T1R4NUJjd0dlcHRGY2pkOTNMR1FhaUk2cGhQbGFJaU1qSWE5?=
 =?utf-8?B?b3FtK1JaR0VQc3Yrb3cvVmhCL1I0OWJ0RHF4RWNBYm9teGF3cnRrVjlNWlll?=
 =?utf-8?B?ZHhCa2RtQ0t3V2lqanIyU3AveHB1b0J3STlvVVVuRkFJd0hFU2dheG4yZ1hN?=
 =?utf-8?B?NVZGS0lMUldzT1VhejgxL2k4a3U5SnpMeGVwbXZ4bXpFTWJYckZ1a2lmaTJN?=
 =?utf-8?B?WE1RWHZMVFpEVFdHZmExZUZudHZ0OHJaT25hSmxKSlBoRXZDbnBhMHlYRThJ?=
 =?utf-8?B?WDJ0Rm1RVHRrU1hWNHloZVBzektQcXdlNHJWS1pSVUhObmhwNEVDVlBMRGhE?=
 =?utf-8?B?U3lYLzNMM0Jqa3c3RDArS2hxYTNPRkZYWTQrWFBNRU0yV2lQTWJXOFl0U04v?=
 =?utf-8?B?d081UHZHYU8rNzFmMS93dWVZTWJCYUJidGZ1Ky9GbFhZM3NLOG9waVdyWTQ0?=
 =?utf-8?Q?+tNmT6etKOwHbP5YH8ORdSO81?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a422d124-8585-418f-669c-08ddd9e51bc6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3414.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:13:39.4715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /URUkqTF2RyvQv49m9liJqAp7y/VGUsl6oZWnj9WD5VPzD7kK3627lhyd524Iw40
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7171

On 8/12/2025 3:02 PM, Olga Kornievskaia wrote:
> When a listener is added, a part of creation of transport also registers
> program/port with rpcbind. However, when the listener is removed,
> while transport goes away, rpcbind still has the entry for that
> port/type.
> 
> Removal of listeners works by first removing all transports and then
> re-adding the ones that were not removed. In addition to destroying
> all transports, now also call the function that unregisters everything
> with the rpcbind. But we also then need to call the rpcbind setup
> function before adding back new transports.

The rpcbind and portmap protocols both define PROC_UNSET procedures
to selectively remove the triplets. Is it not feasible to code a new
client stub to simply invoke them, instead of the legacy big-hammer?

Tom.

> Fixes: d093c9089260 ("nfsd: fix management of listener transports")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>   fs/nfsd/nfsctl.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 2909d70de559..99d06343117b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1998,8 +1998,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
>   	 * Since we can't delete an arbitrary llist entry, destroy the
>   	 * remaining listeners and recreate the list.
>   	 */
> -	if (delete)
> +	if (delete) {
>   		svc_xprt_destroy_all(serv, net);
> +		svc_rpcb_cleanup(serv, net);
> +		svc_bind(serv, net);
> +	}
>   
>   	/* walk list of addrs again, open any that still don't exist */
>   	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {


