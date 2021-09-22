Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AFD414F0B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 19:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhIVR3i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 13:29:38 -0400
Received: from p3plsmtpa06-03.prod.phx3.secureserver.net ([173.201.192.104]:40861
        "EHLO p3plsmtpa06-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236701AbhIVR3h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 13:29:37 -0400
Received: from [192.168.0.100] ([173.76.240.186])
        by :SMTPAUTH: with ESMTPSA
        id T62Qm4IvajeJoT62Rm07ar; Wed, 22 Sep 2021 10:28:07 -0700
X-CMAE-Analysis: v=2.4 cv=aNA1FZxm c=1 sm=1 tr=0 ts=614b67a7
 a=jWrLioA5F7WmVvax94MGYQ==:117 a=jWrLioA5F7WmVvax94MGYQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=ZcTEHt0vA8zF5IGawKMA:9 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v2] xprtrdma: Provide a buffer to pad Write chunks of
 unaligned length
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <163198229142.4159.3151965308454175921.stgit@morisot.1015granger.net>
 <d69234ec-4688-e5d1-17c3-247841d47d16@talpey.com>
 <BAFA239A-2F60-4163-AB20-046AFE6B6F7D@oracle.com>
 <04ec7294-f456-65cb-c401-5a56f61c8dc7@talpey.com>
 <5CE77E8E-97D1-4FFE-89AF-7536C3ABC6F0@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <2e0f81a6-fb56-791f-4574-382596605135@talpey.com>
Date:   Wed, 22 Sep 2021 13:28:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5CE77E8E-97D1-4FFE-89AF-7536C3ABC6F0@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIl9/XS+SR7HoCgbV7th2ZirhFTzhuKEaJ3vgDaa0xZKV9td3KVMbpq9ruJnbr6r17Nq0bFgvhQiyi24M7WN1Eqtndcg4a/RdhR7p419fhPCyFe7siw9
 3paU9Kommoer2qAR9aS7qHMzIqtti59eQar+2gqEn+CIM0w7sXarkJt4iJJXDQsi2vUZ9kZz8nVvMCLhnujRp/6heUz3+iqEIFcGshluiK/9mEE1jmJDAcCO
 0axir+ZfpeD1cfS2/Ms1sQ==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/22/2021 1:18 PM, Chuck Lever III wrote:
> 
>> On Sep 22, 2021, at 1:15 PM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 9/21/2021 1:21 PM, Chuck Lever III wrote:
>>>> On Sep 21, 2021, at 12:58 PM, Tom Talpey <tom@talpey.com> wrote:
>>>>
>>>> On 9/18/2021 12:26 PM, Chuck Lever wrote:
>>>>> This is a buffer to be left persistently registered while a
>>>>> connection is up. Connection tear-down will automatically DMA-unmap,
>>>>> invalidate, and dereg the MR. A persistently registered buffer has
>>>>> no-cost to provide, and it can never be elided into the RDMA segment
>>>>> that backs the data payload.
>>>>
>>>> I'm confused by this last sentence. Why is "no-cost" important?
>>> Today, the client turns off this XDR pad when it can because it
>>> is registered and invalidated for every Write chunk with non-
>>> aligned length. That adds a cost to providing it.
>>> No-cost means we don't need to worry about optimizing it away;
>>> it can be provided all the time, if we like, because there's no
>>> additional per-RPC registration/invalidation cost.
>>
>> Sure, I get that, but it's not actually zero. The MR is allocated and
>> therefore consumes a handle. It's a way-better approach than registering a few bytes for each rpc of course. I guess I'm simply suggesting to delete the sentence. The other sentences cover the issue without the possible confusion.
> 
> There is a bug now where SG_GAPS support is coalescing the Write
> pad MR into the data payload, and for various reasons, that's
> not safe to do all the time.
> 
> So this patch addresses that, and this sentence calls out that
> specific part of the fix.

Wait, what? The sentence, as I read it, is talking about the possible
advantage of a pre-registered buffer, not a safety or s/g thing. If
this is fixing a bug, shouldn't that be described?

Tom.
