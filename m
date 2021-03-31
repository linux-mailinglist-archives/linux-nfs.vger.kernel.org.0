Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633CE350901
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 23:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCaVXJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 17:23:09 -0400
Received: from p3plsmtpa06-07.prod.phx3.secureserver.net ([173.201.192.108]:47699
        "EHLO p3plsmtpa06-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231339AbhCaVW5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 17:22:57 -0400
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id RiIhlXwX4ZK7ARiIilj9u1; Wed, 31 Mar 2021 14:22:56 -0700
X-CMAE-Analysis: v=2.4 cv=INzHtijG c=1 sm=1 tr=0 ts=6064e830
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=awFB1WZmbsX3KXInVVwA:9 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 2/8] xprtrdma: Do not post Receives after disconnect
To:     chucklever@gmail.com
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
 <161721937122.515226.14731175629421422152.stgit@manet.1015granger.net>
 <4004f56f-3603-f56c-aea9-651230b3181e@talpey.com>
 <CAFMMQGvortADqgmAzskZKcnyHDzsTEW0FtR501wpP+deUM57FA@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <b5286b3f-439a-ef7c-cd7c-6cebfbccb02d@talpey.com>
Date:   Wed, 31 Mar 2021 17:22:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAFMMQGvortADqgmAzskZKcnyHDzsTEW0FtR501wpP+deUM57FA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGspgVnBWKLRfg0RYXEUikZLTzvE4aYAsKRpVwhOGl8bNfKejLh+7SjcJrHBxDob0m1eO+AiQemHn1tWlASv+2VSsQUO23mgnb2PPA7K2pRgpoLLvyMP
 vGwSJcRE534bMU91+BWzVGrFOzGrkKKm4Io1jM1LY6F5kKeuhEQW43UmkMfrgJ+vN/lfBN5ioW2w9Q+dCAUekVyz/zhNuWydNnz0687rMvne2wPmSppmtT39
 5iBO44fbQaxpq8AQO2W2stnofppnYDzNDgjP8+Ms/XU=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/31/2021 4:31 PM, Chuck Lever wrote:
> On Wed, Mar 31, 2021 at 4:01 PM Tom Talpey <tom@talpey.com> wrote:
>>
>> On 3/31/2021 3:36 PM, Chuck Lever wrote:
>>> Currently the Receive completion handler refreshes the Receive Queue
>>> whenever a successful Receive completion occurs.
>>>
>>> On disconnect, xprtrdma drains the Receive Queue. The first few
>>> Receive completions after a disconnect are typically successful,
>>> until the first flushed Receive.
snip
>> Is it not possible to mark the WRs as
>> being part of a batch, and allowing them to flush? You could borrow a
>> bit in the completion cookie, and check it when the CQE pops out. Maybe.
> 
> It's not an issue with batching, it's an issue with posting Receives from the
> Receive completion handler. I'd think that any of the ULPs that post Receives
> in their completion handler would have the same issue.
> 
> The purpose of the QP drain in rpcrdma_xprt_disconnect() is to ensure there
> are no more WRs in flight so that the hardware resources can be safely
> destroyed. If the Receive completion handler continues to post Receive WRs
> after the drain sentinel has been posted, leaks and crashes become possible.
Well, why not do an atomic_set() of a flag just before posting the
sentinel, and check it with atomic_get() before any other RQ post?


Tom.
