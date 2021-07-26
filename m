Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A3B3D6827
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 22:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhGZTuC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 15:50:02 -0400
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:34765
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229580AbhGZTuB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 15:50:01 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 15:50:01 EDT
Received: from [192.168.0.100] ([68.239.50.225])
        by :SMTPAUTH: with ESMTPSA
        id 8783mM5FRFkBS8784m2ecH; Mon, 26 Jul 2021 13:23:12 -0700
X-CMAE-Analysis: v=2.4 cv=b4R3XvKx c=1 sm=1 tr=0 ts=60ff19b0
 a=Rhw2r8FBodfaBxRKvGSZLA==:117 a=Rhw2r8FBodfaBxRKvGSZLA==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=QL6GP8Oo9ifN5IFqZiwA:9 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 1/3] svcrdma: Fewer calls to wake_up() in Send
 completion handler
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
 <162731081843.13580.15415936872318036839.stgit@klimt.1015granger.net>
 <e25bd7be-6bcc-cf7d-efcf-1ac39d411431@talpey.com>
 <C5D8AD9E-8DB6-4018-A0FA-92C9A73B07AF@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <283a4f12-5bbe-c4ea-d5c4-f49ce69c59bf@talpey.com>
Date:   Mon, 26 Jul 2021 16:23:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <C5D8AD9E-8DB6-4018-A0FA-92C9A73B07AF@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDkNBJ/zohku3jSB5JsqqHTGE/EMrrkCiQBAClbaUD3FY77O87AkcCzzt1yEfgQJHXVOXcWMf+iNjUfD5AIpJ+IMgaIXer0q4p9zIYqOr3DIopZKmCYx
 4y9huZ1jMhai84k9YdIwoQ5nxVpfeeui5PM1WsCXvVyzQg3/JbSMXQbWQyc71lpAAkHIxdp8pZQOSogRUVo7HJhyO55wtpvLsJ/+fVUDesgCWdMVHTn7A/1X
 uqFqIWF/Y7rPKP+Q3A1T/bBSNsK9Xtee7rw0d093SSw=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/26/2021 1:53 PM, Chuck Lever III wrote:
> 
> 
>> On Jul 26, 2021, at 12:50 PM, Tom Talpey <tom@talpey.com> wrote:
>>
>> On 7/26/2021 10:46 AM, Chuck Lever wrote:
>>>   /**
>>>    * svc_rdma_wc_send - Invoked by RDMA provider for each polled Send WC
>>>    * @cq: Completion Queue context
>>> @@ -275,11 +289,9 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
>>>     	trace_svcrdma_wc_send(wc, &ctxt->sc_cid);
>>>   +	svc_rdma_wake_send_waiters(rdma, 1);
>>>   	complete(&ctxt->sc_done);
>>>   -	atomic_inc(&rdma->sc_sq_avail);
>>> -	wake_up(&rdma->sc_send_wait);
>>
>> This appears to change the order of wake_up() vs complete().
>> Is that intentional?
> 
> IIRC I reversed the order here to be consistent with the other
> Send completion handlers.
> 
> 
>> Is there any possibility of a false
>> scheduler activation, later leading to a second wakeup or poll?
> 
> The two "wake-ups" here are not related to each other, and RPC
> Replies are transmitted already so this shouldn't have a direct
> impact on server latency. But I might not understand your
> question.

IIUC, you're saying that the thread which is awaiting the
completion of ctxt->sc_done is not also waiting to send
anything, therefore no thread is going to experience a
fire drill. Ok.

Feel free to add my
   Reviewed-By: Tom Talpey <tom@talpey.com>
to the series.

Tom.
