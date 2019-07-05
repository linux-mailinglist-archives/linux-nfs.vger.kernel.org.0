Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0325960E2E
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2019 01:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfGEXx7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Jul 2019 19:53:59 -0400
Received: from p3plsmtpa07-07.prod.phx3.secureserver.net ([173.201.192.236]:33013
        "EHLO p3plsmtpa07-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbfGEXx7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Jul 2019 19:53:59 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id jY1eheS2r0qbejY1ehZXOi; Fri, 05 Jul 2019 16:53:58 -0700
Subject: Re: User process NFS write hang in wait_on_commit with kworker
To:     Alan Post <adp@prgmr.com>, linux-nfs <linux-nfs@vger.kernel.org>
References: <20190618000613.GR4158@turtle.email>
 <6DE07E49-D450-4BF7-BC61-0973A14CD81B@redhat.com>
 <20190619000746.GT4158@turtle.email>
 <25608EB2-87F0-4196-BEF9-8AB8FC72270B@redhat.com>
 <20190621204723.GU4158@turtle.email> <20190628183324.GJ4158@turtle.email>
 <35045385-2C77-4BA0-8641-2AE4E73E04A4@redhat.com>
 <20190703213221.GB4158@turtle.email>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <a6ccb336-4ce6-b313-660e-ac4c1f033c54@talpey.com>
Date:   Fri, 5 Jul 2019 19:53:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703213221.GB4158@turtle.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGSOmIS4Fj337AXW9UHdXegZsbJYmOuAywbi0qYLPTQCPh/Yd6T0zWhR9HrvshaGJwfTtpMq0lZPrxMPTcn6VZB+9V80Qb6i1dK/L8rVq7Am+WI4zxwC
 R98WqSplIejDY4kwuM7CzTbqpWx9B+ZZqft4k4ErbCAm08WDPzXQ3xw/4JBXod37MqSFpp7wZXk252HzEYSAB3J7jZQajMyaS/o=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/3/2019 5:32 PM, Alan Post wrote:
> On Tue, Jul 02, 2019 at 05:55:10AM -0400, Benjamin Coddington wrote:
>>> As far as I understand it, for a particular xid, there should be a
>>> call and a reply.  The approach I took then was to pull out these
>>> fields from my capture and ignore RPC calls where both are present
>>> in my capture.  It seems this is simplistic, as the number of RPC
>>> calls I have without an attendant reply isn't lining up with my
>>> incident window.
>>
>> Does your capture report dropped packets?  If so, maybe you need to increase
>> the capture buffer.
>>
> 
> I'm not certain, but I do have a capture on both the NFS server and
> the NFS client--comparing them would show me if I was under most
> circumstances.  Good catch.
> 
>>> In one example, I have a series of READ calls which cease
>>> generating RPC reply messages as the offset for the file continues
>>> to increases.  After a couple/few dozen messages, the RPC replies
>>> continue as they were.  Is there a normal or routine explanation
>>> for this?
>>>
>>> RFC 5531 and the NetworkTracing page on wiki.linux-nfs.org have
>>> been quite helpful bringing me up to speed.  If any of you have
>>> advice or guidance or can clarify my understanding of how the
>>> call/reply RPC mechanism works I appreciate it.
>>
>> Seems like you understand it.  Do you have specific questions?
>>
> 
> Is it true that for each RPC call there is an RPC reply with the
> same xid?  Is it a-priori an error if an otherwise correct RPC
> call is not eventually paired with an RPC reply?

Absolutely yes. Not replying would be like a local procedure never
returning.

But remember XIDs are not globally unique. They are only unique within
some limited span of time for the connection they were issued on. This
is typically only a problem on very high IOPS workloads, or over long
spans of time.

Tom.
