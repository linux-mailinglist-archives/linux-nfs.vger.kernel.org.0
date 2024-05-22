Return-Path: <linux-nfs+bounces-3338-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDAE8CC56D
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC731F2156F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AC52B9C3;
	Wed, 22 May 2024 17:19:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2102.outbound.protection.outlook.com [40.107.94.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F67770E4
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398344; cv=fail; b=glLsVKy4lA90sJ18akAj0lr8RMXnbUdLNx+lmY3wQPNcE2aHj4bt9WUrK827OQzjPdHqod5TJbXX30UO0yP+Zb4cor2U39qw2qwEP8dTqBaIaj0QgW8Vy89TLXLRBx0mDVfVbncoLVyIIUgopvT+JeehSFq50KWnwkKrPfhnZ20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398344; c=relaxed/simple;
	bh=XP/Z5J1UF5vD2YafMBFaqnQzyBYW46XspKa9/tGHyus=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H3UrUJI6MrTQZkcUFLmd0rapZv1ZIp3DZCv+P/cdHrxfQsnufzwKnseQDzEeU48G7NbWmt6tyg8KJpXYWE82KQwDj1ruDB95rHeJhpsMNGwq0crid7BSngvYEyIwfaIwnsUYM9zihI9sAyRKWjkcmjj/NNab2q0Rw8Bmip8Mqk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.94.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRve12UsdAc1kqehANoVTfwwAjTernOOtjxtHhdTd/8zMkFlFrNc2zc9nF+PtLa6DtWZKUsxYG//BulxvsUKtsfXtz2Klwr9nD/TXpswAz58fXjarAEDbwDWR6sZ/ij0cLE1SXUbsTDXvpa2sOoTTBDkX8nzmC9p8vrlJlJyQjOmbQ4zFqWqMVb67r1s010EgqliOIuzwRAU83E8/XWf/P4mV7zdFCNMR+77aNkdld8NoVzDKgcTay004ZKjzEB0cXW17SAIV5KwI0gTfbsiMHZ0nRez5JW1ZsfK6H43eX8JWSvw3wxGg9tN0WKrmPUiUY70ZuyD31/isnGMWpxHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm95k6ldWQXeas0FO8iqM9l07jcu+gv4iiITgRxezHc=;
 b=emvzCOgf9zq6r9EIM0iNCSd1qW5ko2/TqkfI7rFnMwh7UrlS+jV3rN3Fu/il2h+GWI0aEInejmmg7G3x6cqoTnFiJAsw+upd+koAxx6GvJ/Qc/OuydWjVr218FARKgLIgD8yeesp1oBs7objM9kus2mdpcuc95di+WO/em7IDzat0zFVzRuMgw2EVGkJcLL/EccfEkjzJbkRHjIIdNE6FYPjXV8Mahdc/2w6b1BMli+D7GLODtTfee3hWhbolb6LUpC5cgGEcaXLFH7GecWqGjOQnW60KjHzPtTsNeXu/3ZsBW3LPCQwFfOK62AnO2SC4owoR9rQsOR1GICikCyT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from CH0PR01MB7170.prod.exchangelabs.com (2603:10b6:610:f8::12) by
 PH7PR01MB7909.prod.exchangelabs.com (2603:10b6:510:277::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.18; Wed, 22 May 2024 17:18:57 +0000
Received: from CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511]) by CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 17:18:57 +0000
Message-ID: <d11d884b-8933-4a3a-a16b-8437530da1e7@talpey.com>
Date: Wed, 22 May 2024 13:18:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: sm notify (nlm) question
To: Trond Myklebust <trondmy@hammerspace.com>,
 "ffilzlnx@mindspring.com" <ffilzlnx@mindspring.com>,
 "aglo@umich.edu" <aglo@umich.edu>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <CAN-5tyFBn3C_CTrsftuYeWJHe7KWxd82YFCyrN9t=az8J4RU0w@mail.gmail.com>
 <2C80B5BC-AAEC-41F8-BEB6-C920F88C89BB@oracle.com>
 <0b1101daa646$d26a6300$773f2900$@mindspring.com>
 <CAN-5tyGECFmtzFsYNSZicPcH4SMKF0yovk6V20sWJ1LrZKzzyA@mail.gmail.com>
 <0b1401daa64b$f5831ee0$e0895ca0$@mindspring.com>
 <CAN-5tyHWeQykx0cFpOFf2hTBRk9_NaZarzeeAFdSu2NW0zqobA@mail.gmail.com>
 <33bdba418d7ccd7d9b87fa478ea71a14e979aaf1.camel@hammerspace.com>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <33bdba418d7ccd7d9b87fa478ea71a14e979aaf1.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0035.prod.exchangelabs.com (2603:10b6:208:10c::48)
 To CH0PR01MB7170.prod.exchangelabs.com (2603:10b6:610:f8::12)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7170:EE_|PH7PR01MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 50525220-71bc-4f13-ab7a-08dc7a83439c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d01BUStubUNHZC9MMDdsSG5wcFlVT0xoSkpHN1ZXNSsybWtpOGg5NFE5Ukta?=
 =?utf-8?B?OCtxMGp3UEN2Z09JMjJtMU5sZ1g3U1BqM1p5dzJlQmZxaXVvOVFNbmw5SnVM?=
 =?utf-8?B?RGFUUjAzcHQ5dmxDVExsWW5oRDNFb2VJeEZ5UHVIMGkrSjh1UWowN1l0YXFK?=
 =?utf-8?B?QXhkRjZQQmZtN21uWnk0V0p0K0psOWIwWUk2S1BobVphcnhYV3ZZaXFLZ21l?=
 =?utf-8?B?K3hjS3N4VU9XNDZWazUyN29RZ3NrTmNHTzl3MXlPaUhabDNyYkRhR3p4TnBm?=
 =?utf-8?B?RjVWR2U0alBhVGsvMHBmcURuSUFwM3BtbmJXZmRhbE9BM0g5bHVSS1BkbGhn?=
 =?utf-8?B?Lzlwc2RlaE9DZDZURTVtNnBFdjVBb2diTDNvZUh6ZW1XSkVkZzZGZ01CVE9M?=
 =?utf-8?B?eTJZR1g2TlYzWEJQRVhvSEgwOS9CV0hkQVpxK3RlTTFzZ0wwV1gvamxuKzg5?=
 =?utf-8?B?RlFJRE83U2V4QkdreG96Z091UkhDVEd1UFVMMzRIa29CY0EvSU01eVFrWkx3?=
 =?utf-8?B?OEVDRDQ4aXIzclpUR3daTzB2K0xxMk1NY1lrN09pRDh5WEVEVk1PWm0vMkIx?=
 =?utf-8?B?MEg5SEQ3RDF4U0RZVVd2SXNaMkhJK2VjeCtmTTkvN3YxeStEaEdvYzIrQTlk?=
 =?utf-8?B?YzVmM25ndTFsRWFVT25GYjZsdEVNMlhheEVYU2lIWDBRcmUrNnRMNUhaZW8z?=
 =?utf-8?B?ZjQ3eEFaT2FMWEFPbFdFdTNqOHB0YnRWd1lqclorU0duMlVKOVVSbnNFWWNH?=
 =?utf-8?B?WXVmczZobjhibVg5UThDekdaaGxwS0YrZmU1RUFocU9ac25yTG9nUXIySVhW?=
 =?utf-8?B?ajBtLzd3anVDRGdIVG5JR3lVZWh4dDc4SFlqQmRzYVBScUorNkJBOTBxbVV3?=
 =?utf-8?B?RUVLSmFPbEpwRWZCQUFqZkxLR3dSMEgxbDFsQkk0V0gydlRKREJwWTIwNHB3?=
 =?utf-8?B?ZHpTczVZRDJISm5oZS9jZExLdEUwaTBVOFRwL1IxbUNuRDFzVENnSUg4KzV1?=
 =?utf-8?B?OExjQ0lrTFNPMXMrOEpPeHlIRVVtQVFFdFBPcHpWdUJnS1ZlVlNQRlpmOUhV?=
 =?utf-8?B?enBXd0JRSW56QmVCcVJ1eHNacEh4YThRWmpHT3R0VEQvN0VEaDVVWlh5RjFp?=
 =?utf-8?B?Y3k5UXoxb3pKR2daT09mRlM3bVpKZitIdmZBdzZ5eEhzNzljSWViTmY2TmdE?=
 =?utf-8?B?MHZ0QVd6OXVEWCtvRHVoMVJpTjZPU21wWnIrZTBZR1RIYjY0aHNia3FyQUFo?=
 =?utf-8?B?QWJRR2ZtTGxad2FYcUgvWXZZWjJJVnluTy8rQ21qNWM2MFJDbmRrQWtnWG80?=
 =?utf-8?B?Vkl0MkRCWXEwaXE1c2JkeDJtdDJpYnpleThpUVl2MGZvNUhCYlFGRVJmbkYr?=
 =?utf-8?B?U0lidDltVzdzR0ZuT0JPK0VQcENJVkNTVm5PT3JhVjBIaXgrWjZnYklvUFRt?=
 =?utf-8?B?YXN6eHBpczhWMG5hbjBwczk5dUhuem51a3RTTS9JSE9jaFlUcEVnS1JFeTND?=
 =?utf-8?B?ZkFrMEdqd0tLaTVFSFJDNHliaW1sTnp1Vm84cjNUR3Buby9yaWlCRmN0dnJo?=
 =?utf-8?B?cC80aFB1MWNwYnZHM080UFB2T1MrelZLNFVQQU94Y0FtYzB0Yy8zczdLZElx?=
 =?utf-8?Q?6Sz9INytkdRxSou5y0hsvHhJfrAERvcgDAXeOUm0JYeQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7170.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEJaemloYjdRV3NVY1UvWTZibUJVcmdpUVhSWThYMGtGbUtIUVRnN2l5TU5q?=
 =?utf-8?B?ZVlMcm9yc0RQcFV4Y3d1eUI0MlN6N3M2dWpiTnJGS21ENElqR1dSM1ZXQThZ?=
 =?utf-8?B?dUcvbjBSQ3dkckxOUjhPSHp2NThJaDd1bjJ2TEZhTnRhay9NTkJtSlp5clFy?=
 =?utf-8?B?a0dYamVCV2QyMkF5K1pPNUg0ZFlKRDZZT0NBbndidkNTVmFveDRpaVRjTkxU?=
 =?utf-8?B?WWZzbUhEeTB4UitMemZCak14YTNCbmdOam9XZkYwSE1oSkNsNFlObWtNNEpP?=
 =?utf-8?B?UEViZ3pTTnRjb3dWMWM3cHhWRW9QdEhuVmE1TnNQMFU1TjFiRVlXQmJNWWY4?=
 =?utf-8?B?NHJQR0FRb0Rld2pPY29RU1ZNTmlrdnY1OEtnOGV1QVN1c2xEK1hxblN0Y3Bx?=
 =?utf-8?B?djhFcHowcDZtM1FRcDlqZ052YzQ1SFRhWURkWTB4RkhXblk4SUcxTWRUcjBi?=
 =?utf-8?B?d2hvN2tqQVJJVThNZThHbUg1VUo2SU1LeDk0U1pDSTBCUWhrZHZNY1U4K2pJ?=
 =?utf-8?B?ZWJtZkZYbW9ucVVqdzVjRkYrWjM5Nk5zMm1ycW9ncGd6Y08yVDlxamU2UzNT?=
 =?utf-8?B?d2RiNXorUE1Yc0FlZHZ3a0dlVXcrYkZNak9aSEVVc1YxWEV4enBaRW9qNnd5?=
 =?utf-8?B?RVdOQ3ZJL2JnVlhKT1BvanZqSTF3SjkyeU5MNHovVWgwR2RYZ0RuS2VHZE1Z?=
 =?utf-8?B?QW1NK1lXVUNnVWJCRXJoWnB5Y1ZjNGFaSWpIVWZFeXdoK1VxY2dhb1ppWTgx?=
 =?utf-8?B?ZUVFVno5WGprS0FRenMrVFBqRjlkVFZlYlAwanJCSTdtRDYxdlcwK1RwZlNR?=
 =?utf-8?B?SE5lVmJaQnRFTHVzYUczeVdieWp1ZG9SMDAxMVZ6eVZ2S0paZ3A5VEdmSERU?=
 =?utf-8?B?eHJhNUEwLy9HRUJXN3FYUzZkbTBDT1Y2bjVlZ3BMLzNuc3BsRkNvQ21BQkhX?=
 =?utf-8?B?V0J5MXNJekc3TW4xTHpPcDBTWTFuMktFTW1mbUFjVGorVE1GMDh3WlhLUStN?=
 =?utf-8?B?aEw4T3ZiSXFLY2xVNCsyWHZCV21jS1hpbUhEKyt4YmRUdU5sWTNTNlNGSktE?=
 =?utf-8?B?NGVBMXBCdFpZQ0N5WVFlUFZkeEg4MzN3eDF3NzZIMUxsMWVYbEhyN3dPNjJq?=
 =?utf-8?B?dmlRWi9DaGpMZkNkeGM0aUpOeXpGNU9EOTdtWWx3NnFxV0pWUE5UdUNzamc1?=
 =?utf-8?B?b2pYWnBvUmhJS1NNZ3NOWGhLa1FQYzcxbzhXV203R0J5NDJIMGNaYjU1SVpT?=
 =?utf-8?B?Y0NpUEd5UWVkWFVCMFBPdWNmRmF2N0R0cytPRUNYa09MYWRwT0NNVlZPWk9s?=
 =?utf-8?B?Q1I4YzdUMkxickRtcXpjZFJoNXowenNINmNRek5JclNxQ2hwZGtBM1F0Q3JP?=
 =?utf-8?B?VXFzUC96WHYrbGU1TkQwT1hXcC9tdUN2cnFhb1JvdkJMdWxIUlE2ekxubEtw?=
 =?utf-8?B?WnlWdU5XTUxCNmFSQ0ozeGUrMHJCRkJOcWZpcmtOY0V2anBFelI5UVVIVVUz?=
 =?utf-8?B?VXcxMmwwbDgrcSt5TUhRZk16WjhpdzdIcHJmU3BxS3JUa1VCMFZ3SUx1anRt?=
 =?utf-8?B?T0VNaEc2TTE2Rk8yQ0RFSmFXV0hrSXlkQU1CMUUyV3ZCVWpHQ3NIZGRTM1Zn?=
 =?utf-8?B?eWxPVlAzREN5b0xvV2VHem95cCs2NFlSOGVaNVNETlYvenNkS0pMNTRxQzBp?=
 =?utf-8?B?ak12WmJrZFlpdmswWTFoNmZaWkNBajBlR2tzaisxcitQNlJHZ3R6aXNnSVdr?=
 =?utf-8?B?K3JLY3kwdzdOV0ZZeU4xZnl3dERwYytCNXhaRVlFS2ExN3NmMjhlY2pHUlN1?=
 =?utf-8?B?SFoxRGR4d1FTbGUyb3ZHek9XNnlVUEdvY2k0WWVRNmwyUlByakFqZ2NlSmdr?=
 =?utf-8?B?N1FHcFhzNjUzV3k0eTNScXhIKzQ3d1F0S1V3YXNhaDNwM1F1TzdrQTNWYzB4?=
 =?utf-8?B?ME5zNjJLcmVid24rdzVHTDMyZGo5aXYxY1M1alk1c2NHdEpKYWhoNHB1LzZu?=
 =?utf-8?B?UWQzTXNYaDlGTHhhMWtJMlRMTTNITHQxY25rUjJkVVpMV0pIaDdpeWRhc0Y4?=
 =?utf-8?B?bERMcGRGV2RWM24rUnZaNzNHT3E2Q1h0QU4vcGFIS1FsMU40MVp6MTIvbGIr?=
 =?utf-8?Q?Bh7O5MTrJM9R7LdC9xVZV+XbO?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50525220-71bc-4f13-ab7a-08dc7a83439c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7170.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 17:18:57.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HGVsvNLbB44cgW6t3Iv3CjuZJ3o7Iz1UyzYN7kFXWrpCaBZK6bHTwG1f4nKeh+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7909

On 5/22/2024 12:20 PM, Trond Myklebust wrote:
> On Wed, 2024-05-22 at 09:57 -0400, Olga Kornievskaia wrote:
>> On Tue, May 14, 2024 at 6:13 PM Frank Filz <ffilzlnx@mindspring.com>
>> wrote:
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Olga Kornievskaia [mailto:aglo@umich.edu]
>>>> Sent: Tuesday, May 14, 2024 2:50 PM
>>>> To: Frank Filz <ffilzlnx@mindspring.com>
>>>> Cc: Chuck Lever III <chuck.lever@oracle.com>; Linux NFS Mailing
>>>> List <linux-
>>>> nfs@vger.kernel.org>
>>>> Subject: Re: sm notify (nlm) question
>>>>
>>>> On Tue, May 14, 2024 at 5:36 PM Frank Filz
>>>> <ffilzlnx@mindspring.com> wrote:
>>>>>
>>>>>>> On May 14, 2024, at 2:56 PM, Olga Kornievskaia
>>>>>>> <aglo@umich.edu>
>>>> wrote:
>>>>>>>
>>>>>>> Hi folks,
>>>>>>>
>>>>>>> Given that not everything for NFSv3 has a specification, I
>>>>>>> post a
>>>>>>> question here (as it concerns linux v3 (client)
>>>>>>> implementation)
>>>>>>> but I ask a generic question with respect to NOTIFY sent by
>>>>>>> an NFS server.
>>>>>>
>>>>>> There is a standard:
>>>>>>
>>>>>> https://pubs.opengroup.org/onlinepubs/9629799/chap11.htm
>>>>>>
>>>>>>
>>>>>>> A NOTIFY message that is sent by an NFS server upon reboot
>>>>>>> has a
>>>>>>> monitor name and a state. This "state" is an integer and is
>>>>>>> modified on each server reboot. My question is: what about
>>>>>>> state
>>>>>>> value uniqueness? Is there somewhere some notion that this
>>>>>>> value
>>>>>>> has to be unique (as in say a random value).
>>>>>>>
>>>>>>> Here's a problem. Say a client has 2 mounts to ip1 and ip2
>>>>>>> (both
>>>>>>> representing the same DNS name) and acquires a lock per
>>>>>>> mount. Now
>>>>>>> say each of those servers reboot. Once up they each send a
>>>>>>> NOTIFY
>>>>>>> call and each use a timestamp as basis for their "state"
>>>>>>> value --
>>>>>>> which very likely is to produce the same value for 2
>>>>>>> servers
>>>>>>> rebooted at the same time (or for the linux server that
>>>>>>> looks like
>>>>>>> a counter). On the client side, once the client processes
>>>>>>> the 1st
>>>>>>> NOTIFY call, it updates the "state" for the monitor name
>>>>>>> (ie a
>>>>>>> client monitors based on a DNS name which is the same for
>>>>>>> ip1 and
>>>>>>> ip2) and then in the current code, because the 2nd NOTIFY
>>>>>>> has the
>>>>>>> same "state" value this NOTIFY call would be ignored. The
>>>>>>> linux
>>>>>>> client would never reclaim the 2nd lock (but the
>>>>>>> application
>>>>>>> obviously would never know it's missing a lock)
>>>>>>> --- data corruption.
>>>>>>>
>>>>>>> Who is to blame: is the server not allowed to send "non-
>>>>>>> unique"
>>>>>>> state value? Or is the client at fault here for some
>>>>>>> reason?
>>>>>>
>>>>>> The state value is supposed to be specific to the monitored
>>>>>> host. If
>>>>>> the client is indeed ignoring the second reboot notification,
>>>>>> that's incorrect
>>>> behavior, IMO.
>>>>>
>>>>> If you are using multiple server IP addresses with the same DNS
>>>>> name, you
>>>> may want to set:
>>>>>
>>>>> sysctl fs.nfs.nsm_use_hostnames=0
>>>>>
>>>>> The NLM will register with statd using the IP address as name
>>>>> instead of host
>>>> name. Then your two IP addresses will each have a separate
>>>> monitor entry and
>>>> state value monitored.
>>>>
>>>> In my setup I already have this set to 0. But I'll look around
>>>> the code to see what
>>>> it is supposed to do.
>>>
>>> Hmm, maybe it doesn't work on the client side. I don't often test
>>> NLM clients with my Ganesha work because I only run one VM and NLM
>>> clients can’t function on the same host as any server other than
>>> knfsd...
>>
>> I've been staring and tracing the code and here's what I conclude:
>> the
>> use of nsm_use_hostname toggles nothing that helps. No matter what
>> statd always stores whatever it is monitoring based on the DSN name
>> (looks like git blame says it's due to nfs-utils's commit
>> 0da56f7d359475837008ea4b8d3764fe982ef512 "statd - use dnsname to
>> ensure correct matching of NOTIFY requests". Now what's worse is that
>> when statd receives a 2nd monitoring request from lockd for something
>> that maps to the same DNS name, statd overwrites the previous
>> monitoring information it had. When a NOTIFY arrives from an IP
>> matching the DNS name, the statd does the downcall and it will send
>> whatever the last monitoring information lockd gave it. Therefore all
>> the other locks will never be recovered.
>>
>> What I struggle with is how to solve this problem. Say ip1 and ip2
>> run
>> an NFS server and both are known under the same DNS name:
>> foo.bar.com.
>> Does it mean that they represent the "same" server? Can we assume
>> that
>> if one of them "rebooted" then the other rebooted as well?  It seems
>> like we can't go backwards and go back to monitoring by IP. In that
>> case I can see that we'll get in trouble if the rebooted server
>> indeed
>> comes back up with a different IP (same DNS name) and then it would
>> never match the old entry and the lock would never be recovered (but
>> then also I think lockd will only send the lock to the IP is stored
>> previously which in this case would be unreachable). If statd
>> continues to monitor by DNS name and then matches either ips to the
>> stored entry, then the problem comes with "state" update. Once statd
>> processes one NOTIFY which matched the DNS name its state "should" be
>> updated but then it would leads us back into the problem if ignoring
>> the 2nd NOTIFY call. If statd were to be changed to store multiple
>> monitor handles lockd asked to monitor, then when the 1st NOTIFY call
>> comes we can ask lockd to recover "all" the store handles. But then
>> it
>> circles back to my question: can we assume that if one IP rebooted
>> does it imply all IPs rebooted?
>>
>> Perhaps it's lockd that needs to change in how it keeps track of
>> servers that hold locks. The behaviour seems to have changed in 2010
>> (with commit 8ea6ecc8b0759756a766c05dc7c98c51ec90de37 "lockd: Create
>> client-side nlm_host cache") when nlm_host cache was introduced
>> written to be based on hash of IP. It seems that before things were
>> based on a DNS name making it in line with statd.
>>
>> Anybody has any thoughts as to whether statd or lockd needs to
>> change?
>>
> 
> I believe Tom Talpey is to blame for the nsm_use_hostname stuff. That
> all came from his 2006 Connectathon talk
> https://nfsv4bat.org/Documents/ConnectAThon/2006/talpey-cthon06-nsm.pdf

I deny that!! :) All that talk intended to do was to point out how
deeply flawed the statmon protocol is, and how badly it was then
implemented. However, hostnames may be a slight improvement over
the mess that was 2006. And it's been kinda sorta working since then.

Personally I still think trying to "fix" nsm is a fool's errand.
It's just never ever going to succeed. Particularly if both the
clients *and* servers have to change. NFS4.1 is the better way.

Tom.

