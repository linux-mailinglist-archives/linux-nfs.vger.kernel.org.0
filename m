Return-Path: <linux-nfs+bounces-7555-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015889B5167
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252031C20F09
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0661DA0E0;
	Tue, 29 Oct 2024 17:54:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020081.outbound.protection.outlook.com [52.101.193.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1C1D9665;
	Tue, 29 Oct 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224465; cv=fail; b=Qr/oeUuPg6sv3CisScp/rv6yN7NcwNmuRDwRFittC2+cN7RvPW+yQhI0BR6f2BJuNESAGHzmaHSDFW8D4Qy6P+87y9kahEGJAeysaOkE4DGK7AhU+/ltlAVtndS6dn1JhPUjtmfylzZYJ8wgTvrjpcgJa2rMAc0aJLZyOxlNPpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224465; c=relaxed/simple;
	bh=7zCM472vCn8tEyiAPC12sbGY++fy6P0amzqEzVyVZh0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UEFTJHkceMbdCbz4ssaPysvfiJG1hS69DRaC+OkehIONzjq5Ue99gEM1qsZ/uWctqInP3A7owjSHo/p9Oiu6zx2BblQb8jUFANU46JQyLIosDW3LzO3B7pkdePvAaSv9dNdDqBS+fiQV8ObmLNB3vJNipnnPjKhuADPZrQwohCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=52.101.193.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C880tX9sylNFbFh5/KcyGPiXYbQnAxja1fdH9X9S27w4YZPun+Ry7fbI/16haWypoPMNth9MljdeYzsYfCTX8p1MqDh5NQdzgn2mkJwr6EmE6zSmBpIkJgy+RTqeaQ30DkUaW6TYmfJzy1u5UkAf6VmxT6ew4eyHbxAy3HDlUjCNk2T9hw59nvFTxodLgxQ58+iH0KM30efyy4giRdbFbvImTnSXIACUupN79Jdk3qGkS6d4kGNW01VmAlRg/bQvZaXeAUDkDphAyr8w9l1If26aJ2cBQVC+u/08+xdbnZie1JnBrYeW2f+c7shAHeaLJJ7EEaODQusXWglw7MyH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zCM472vCn8tEyiAPC12sbGY++fy6P0amzqEzVyVZh0=;
 b=XXSq8wMAc1Q+7aNfvwbKwKAzj8W/QAyELKb0lTn7KOaaaI4tCS80nRMgvrEKzGsA6n3PEMnRQHC7eQSVGcgI9rg6eiDFQYn1yqcR54yinXuyiSITfgwZzm2BIX4LHISahY1CR3MkXo0xLU7CODTYdE6I8iDYGpxB8i9Dpw6S/XeoF0SQdEMxf0zr8+H9hSS03Wva15pxVFRNNzUKDe/8E/5fphgPx5UuMSMktcoMdOjKYAXPArFbPJnepKu52zibEpc5PAO5uSVjCzTv+WoHAaMlZPCGGtNuXqwavndgapNxj99JH+cpgmSkYqpv4VK3a3fnHG9wAHhecMVvjBMhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB5246.prod.exchangelabs.com (2603:10b6:805:d8::14) by
 MW4PR01MB6353.prod.exchangelabs.com (2603:10b6:303:72::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Tue, 29 Oct 2024 17:54:18 +0000
Received: from SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90]) by SN6PR01MB5246.prod.exchangelabs.com
 ([fe80::cf18:495f:c6c:ec90%3]) with mapi id 15.20.8069.019; Tue, 29 Oct 2024
 17:54:18 +0000
Message-ID: <66fb4420-a773-4da3-aa0b-7a78d9e50c5d@talpey.com>
Date: Tue, 29 Oct 2024 13:54:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfsd: allow for more callback session slots
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>,
 Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241028-bcwide-v1-0-0e75a8219dc0@kernel.org>
 <20241028-bcwide-v1-2-0e75a8219dc0@kernel.org>
 <Zx/gbQmNS1vXw2Jq@tissot.1015granger.net>
 <a674c6091a2f510b103bbbacb6ef4a7f497289a0.camel@kernel.org>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <a674c6091a2f510b103bbbacb6ef4a7f497289a0.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::16) To SN6PR01MB5246.prod.exchangelabs.com
 (2603:10b6:805:d8::14)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5246:EE_|MW4PR01MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a57e21-0bbb-4c84-f2ea-08dcf842b5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkxvUys1elplUXM4Y1hPRXdEcklUMUxwN0RsNU5hRUwwRGxrTW5WckV4dHpU?=
 =?utf-8?B?SEI5ekx3Sy9MOHpEdFhuSnpuS1FMd3M1alQ3d0RQcm14NXBzN3daSHVydXdV?=
 =?utf-8?B?bXRBVmlEdGVTMlJFQXN2eU5TcVhPR3JsVnY4RGw5TEdKYWxPK0VIbEZvSk1C?=
 =?utf-8?B?UmtIdHdpV2NZc3YyVDJNWmVwdDF5M0tDKzJROHpIMVBkdkp4UkxaVG1GT1VL?=
 =?utf-8?B?NmdNZ05SVlhUc3BPQ2JNSUlrT1JHd21HTldVQTFtLy9ieWRJNWoyOUxrb0Rp?=
 =?utf-8?B?Mm5Bb0h2cnRMSmZsNXRYWUNPVEhZUHk3YXRWT0Z2d1g1Wjc4YkQ1aVdPNEFt?=
 =?utf-8?B?Um5VU2tLNHpKQ2QwZDdpdDdNVllIVWNSdW1oek0ybHkyVnJrNEd0cnc5cnUw?=
 =?utf-8?B?WDQrL3dwY3pTRG1LQUhyZXdrMVdydlgvZGlHdHFaY0J4V1QwaWgxMHEvbGpX?=
 =?utf-8?B?cC9NMDdXd0szeGRFUzJFQWhCZWZTdzVYMllRbzJzbklCbmZSTGtvU2JlYmJ1?=
 =?utf-8?B?WTFJeSswU21xbTB4dHlsdnlwK3dzYjJEQkl2d1JOL1ZoVnhGYTl0eVZNYjc4?=
 =?utf-8?B?RTU4RUphYjdOdG13d0p0V2dXT1BVRUJjdlJ0Tmt0VDVDOEZEZVhkbGwrSU5D?=
 =?utf-8?B?SWZBamZOOWhMZDY4dXhrTFpFQ2U4WFVDNWVnazk1REpUYlRUQjVnQ0NUODJk?=
 =?utf-8?B?cWtzd01CY253TlNOWk5ZWlhlR1dXTjUyb2dhVWdkQjRaSkxhL2xwWHo3Y3pl?=
 =?utf-8?B?azhxcEhxN3BtSm5ZRU4vOUtLeWUwaDc2dnFWcmpEVEszeU9GZnBITzcxVyta?=
 =?utf-8?B?Uko3UmhxMWVZZTBSb3c2ZWlVY3Z1cmZ4VFoxRERCekFhWExFU2NxODkvS1M4?=
 =?utf-8?B?SjdrN09pN2FZcWY3cFBsWFJ3YWdvQUEwdEpvMmphT29lNWkzTEVwYXNWUmZD?=
 =?utf-8?B?VktrajNYdEpJV0ZYRWszVDlBTGU2QmtsMzMyOHRHK3pYN2RFZzdleGUwcU5p?=
 =?utf-8?B?dGRWMWVObisyamlxQlI0ZS8xNHZ1djBWT1MrcXFLSEY2a1dsMzE4TmphOUVV?=
 =?utf-8?B?aURrUUNKTEhzT3dBQ0pqb2pUcVoyc1dpS1cxTlIycnNEb09jWEh4TUk5ZStY?=
 =?utf-8?B?WWdCRW42dXB2dDA4NDh5RStBVkc2UWxSRDQ5aXNYNUZ2b3pnK09nL1VQeHhF?=
 =?utf-8?B?d0ppSkwxOTJGSlRlbDZYbHEzUWdwT2FvUzN0U0t4Q05UV3ZHRFpoa1dibjVm?=
 =?utf-8?B?TGJCb0pQMXVKTmZCZm55RDBNVDI4dkZJT05uaDV2VFFHMEtnZVBScjFUaDZT?=
 =?utf-8?B?QXd0UUhVTnNWdmgyQStvM1QwcFduUDdCTnI2T2M5RkpaMWdLQmpUeGRTeGRN?=
 =?utf-8?B?NEd6NExuVG04Rm9jTHZOUHdVK2FLOFJLbEIzQzI5MFJNM2kwZCtqMnRaVGhz?=
 =?utf-8?B?cE5CRkJGNExHVllCbEErdnppK0JJOFV2dDUweEZjMG1sNFl1RENuRzJudDUx?=
 =?utf-8?B?RWJ5RVB5eXl4Z2FMOU9Ed3lOZXhIQlhSTitCWVU4cGxWMlNvMXByYk1jd3hI?=
 =?utf-8?B?aHZTM2dYcUZPTlBITDJFWkdKbmVnSUhuZ2tkK29uQk5Td05mRFFxSm9VMlJ0?=
 =?utf-8?B?OVh0aWdUQzZlbityM1RNQ3A2K2svckZZTlJsT0Noek8rSmkvQzhkYXppSE5l?=
 =?utf-8?B?Q2FUcmNybXd2eEk3Vlg3NitkVnZPMThSTHMzSkFWaVNGT2MreXhOVmxhZFg0?=
 =?utf-8?Q?uMDd3n62ydTpQYmcgZQYFyUNaO66imIhE6lhqEH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5246.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0lJY0lCVlFSbHVkNDI2ZXJxOTJXM2dZRmxuM1VrMmFVTXVmU09ZZ1hrWHhC?=
 =?utf-8?B?VXJieGFxN2pGTzZpcFlHSUNSbUI1QW5nenFGVEdQMlk2Qm1QUUc5QVBMVGJj?=
 =?utf-8?B?STBlcGdGS2JMSVk0c0U5UHlzR0tDUDg1Tm5RckVEUzRPVTdDdFE5VEVMTmtD?=
 =?utf-8?B?T044NnQwc1llazNobEpId2RoeHZOYlVtRlExb3BNa01IRkNHbndNemhhaWpp?=
 =?utf-8?B?NUx4Z2RJZWljWFJLS25Vamc4c05aeVVsMm51VlhzKzBUVmI3T1lQSHZvdmIw?=
 =?utf-8?B?YVczZi9XS2xZSGxOWXlneUl4cFFQVkE5bUJBRnZxdFVKKzFzbDBOTWtOekY1?=
 =?utf-8?B?TlJKNmpYejBsaHRFaEU0QlgycjNDQWNYblQwVWxGV0pZczlVN0x3OWpNQzhx?=
 =?utf-8?B?T2FMNlF1aEJTdnkram9YTHJiZm1BdWYwUlhlTHhONUVMS1RIb1FQdHcrbGxt?=
 =?utf-8?B?c3Z0OG51OGJEbWdYRlZGZGNCSFMzVVVoQitML2ZDZzhWZ05JakxQeXltbVlP?=
 =?utf-8?B?NzJhRGw5TDFvcEVaRVJWVHhMQytsb1pNTTZ4b3BucXZOZDFSWjBydkZrWTUr?=
 =?utf-8?B?WFJ3U2VETHc1ekJqdytTYUk4TTMwVGNnbXlGcUEvd25VdVd5WHJxRkRWcnky?=
 =?utf-8?B?T2tHQXpxeTF4V3J5Tjc2Mjl5Rm5yMDJROHZKd2hybHlmTWpjbXpKOE8xbXho?=
 =?utf-8?B?Ymo0L3pHanVqRVlUTnMwOXp2Y2wzRnFjYjZqa1RxbmdaRlJrZ1hQMTBoRUFD?=
 =?utf-8?B?UFpEdEZ0QkpCcmFoYjRSTDJWaEtBVGRGWEpIUHVEcFRzUEhEM3BicExsQ2Ix?=
 =?utf-8?B?RGhOOWJMaTJuU0hwTWFiRmlFN1k5ZWVzQUlUVFhzcFBRcVh1dkREY3ZNYjJN?=
 =?utf-8?B?VVhKVXBXVHdPKzJKUG40V2hybGE1NW5WdFUwWEtjS1hmVGNaYXgxelVRelJE?=
 =?utf-8?B?bGF4QUsvK0N3aUxXaE5ZcER2U2o1b01mOGFkVlFZdWVZcWd0SzNOYjQ5K21B?=
 =?utf-8?B?QjBTWWdjWFhLTldZYitTT281WENUTnI5V0NxWmxWU1llOWFJV3VUeURSRmRG?=
 =?utf-8?B?RUthdGNIVWI4WVphdlB4bVU4Ym03SE5md3pVajNoS0pSWDJUQ1hGTHFDTXd5?=
 =?utf-8?B?ZUU0bFZKQ0E3Smh5aGRETjdnWXp5K3NlVDczOGhvV3NwM25zaUNhR2FKQzJX?=
 =?utf-8?B?UEtQNmVDWDNmbmVVRkllSVBsbys3MFgya2xYZWx5dlIvRkQzQ0lxSnhsREt4?=
 =?utf-8?B?bjg0RzlYbXNiRFJ3aTRnN0xDUE45dnJMaVN6ZU5QeGF2R2xWbUxSdmNwbXhr?=
 =?utf-8?B?WEdQUlNaK3Fqa0hjU2RadjA1OExyWVBGUEVTZ2ZQbnRtL0VoL2hjMHo4ZnhP?=
 =?utf-8?B?dW9aQjNadWgvUnR1VUdaOHJPV1ZVYkJyN2MvaFlmZnpSWHlMZ1JocnJHYWFz?=
 =?utf-8?B?VTZCdHA4UC9EOUxKeWpNWDZjdDFzSFBaOFFXMG1BQytmMVRhekF2OGFKQ01J?=
 =?utf-8?B?cEgvbFZ2d2RNd2VvY21OKzh0OXRFYmgyaHpPaUd6bDRIOThkT2pNSVc3Q21F?=
 =?utf-8?B?U0VmL0YxRStsUCtvSUJFeUE2QUo2cE1TV0thTUdORHpMWW4xeElQZGJ6NG9l?=
 =?utf-8?B?S1JrY0M3Wk95Vi9ZNVQxWnIzdWp0VnB3QTFmNjBsOWttSjE5eXEwUnlRRU9I?=
 =?utf-8?B?LzFqSDI2c215QjRWNEs2ZVlGRFdhWDAxOFJSY2RRRU1NV2J3VVdmSVFtYVdM?=
 =?utf-8?B?bEwrbUJrTnpvbnFOZm9zcElrYjg2T2RqUTVDOExwYUMrRDlDUVVSYXQxbWpS?=
 =?utf-8?B?L3NzanVuNzlxYVc0SlBRSHI1S1hNZlNPMlNpMTNiMUxqcG1jZDlnVTYxVmdj?=
 =?utf-8?B?eGNYZkc4SjZUTC9oVVBuLzM0b1hISzBESHdwTGozbkFZYnAybnpncmh5RDhz?=
 =?utf-8?B?ei92a2c2S1pxancyMEpnZGxOdGYyRlhVNmE1RjhyaS9lNnhMbFM3UE11M1Zv?=
 =?utf-8?B?UGlzNHJJcjRWd3Q0YU9qcmdxZHN3cU1DYjF6K3lsMVQ2TVU4SGh0UlY0dnp0?=
 =?utf-8?B?eXlSQkxic3RmczJqbGhsTlN2TlRpVDAvUmthVTNoNW8wYWliNXdOTDV6RWRX?=
 =?utf-8?Q?3uSU=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a57e21-0bbb-4c84-f2ea-08dcf842b5cd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5246.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:54:18.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8iv8ZxKN8ZFEto5x8q0WW1nPwWX416m/GoxL52BHcJtQlerycwCciVVy/OHn8N7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6353

On 10/29/2024 6:28 AM, Jeff Layton wrote:
> I'm open to switching to a per-session lock of some sort, but I don't
> see a real need here. Only one session will be used as the backchannel
> at a time, so there shouldn't be competing access between different
> sessions for the cl_lock. We are competing with the other uses of the
> cl_lock, but this one should be pretty quick. My preference would be to
> add extra locking only once it becomes clear that it's necessary.
I have a question on what you mean by "Only one session will be used
as the backchannel". Does this mean that the server ignores backchannels
for all but one random victim? That doesn't seem fair, or efficient.
And what happens with nconnect > 1?

Another question is, what clients are offering this many backchannel
slots?

Tom.

