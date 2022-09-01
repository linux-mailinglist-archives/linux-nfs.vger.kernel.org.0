Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7065A9A6F
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiIAOdZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiIAOdX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 10:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D345D72EEC
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662042798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chO12QX1NXHcyYM7S9vuoPr+YASdePzxuFsFtOp3ig8=;
        b=I+UvImLyuXB+MRTZoNY7UpehJ2NLHQ9wNdTqNgWe5B9Vy2V9ooNdO+Y9ebVfPGP4TMYRaR
        hPfxAwIZlU7a3K29yLqdZcTLGQXeGHQhb7wEmRIQnRNQd3BDmqp0WTMVs1dyoxubz/FKoE
        4jdftwL8uYA4JVVkMFw+qQWwRXHb6gE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-sMflAp98OGKrcVgKLz777A-1; Thu, 01 Sep 2022 10:33:14 -0400
X-MC-Unique: sMflAp98OGKrcVgKLz777A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9B4B3C10237;
        Thu,  1 Sep 2022 14:33:13 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BC522166B26;
        Thu,  1 Sep 2022 14:33:13 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Olga Kornievskaia" <aglo@umich.edu>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Date:   Thu, 01 Sep 2022 10:33:11 -0400
Message-ID: <A2C346F9-E11F-4180-B47A-995CB9FDA690@redhat.com>
In-Reply-To: <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1 Sep 2022, at 9:51, Olga Kornievskaia wrote:

> On Tue, Aug 30, 2022 at 1:49 PM Jeff Layton <jlayton@kernel.org> 
> wrote:
>>
>> On Tue, 2022-08-30 at 13:14 -0400, Olga Kornievskaia wrote:
>>> Hi folks,
>>>
>>> Is this a known nfsd kernel oops in 6.0-rc1. Was running xfstests on
>>> pre-rhel-9.1 client against 6.0-rc1 server when it panic-ed.
>>>
>>> [ 5554.769159] BUG: KASAN: null-ptr-deref in 
>>> kernel_sendpage+0x60/0x220
>>> [ 5554.770526] Read of size 8 at addr 0000000000000008 by task 
>>> nfsd/2590
>>> [ 5554.771899]
>>
>> No, I haven't seen this one. I'm guessing the page pointer passed to
>> kernel_sendpage was probably NULL, so this may be a case where 
>> something
>> walked off the end of the rq_pages array?
>>
>> Beyond that I can't tell much from just this stack trace. It might be
>> nice to see what line of code kernel_sendpage+0x60 refers to on your
>> kernel.
>
> After getting debug symbols this is what gdb told me...
>
> (gdb) l *(kernel_sendpage+0x60)
> 0xffffffff81cbd570 is in kernel_sendpage 
> (./include/linux/page-flags.h:487).
> 482 TESTCLEARFLAG(LRU, lru, PF_HEAD)
> 483 PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, 
> PF_HEAD)
> 484 TESTCLEARFLAG(Active, active, PF_HEAD)
> 485 PAGEFLAG(Workingset, workingset, PF_HEAD)
> 486 TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
> 487 __PAGEFLAG(Slab, slab, PF_NO_TAIL)
> 488 __PAGEFLAG(SlobFree, slob_free, PF_NO_TAIL)
> 489 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)   /* Used by some 
> filesystems */
> 490
> 491 /* Xen */



I just oopsed here too on 6.0-rc3, but I didn't get a vmcore.  I'll get 
the
next one and hopefully take it apart a bit further.  My oops was on
kernel_sendpage+0x1d:

     crash> dis -lrx kernel_sendpage+0x52
     /usr/local/src/linux/net/socket.c: 3557
     0xffffffff9caf0160 <kernel_sendpage>:   nopl   0x0(%rax,%rax,1) 
[FTRACE NOP]
     /usr/local/src/linux/net/socket.c: 3558
     0xffffffff9caf0165 <kernel_sendpage+0x5>:       push   %rbx
     0xffffffff9caf0166 <kernel_sendpage+0x6>:       mov    %rdi,%rbx
     0xffffffff9caf0169 <kernel_sendpage+0x9>:       sub    $0x18,%rsp
     0xffffffff9caf016d <kernel_sendpage+0xd>:       mov    
0x20(%rdi),%rax
     0xffffffff9caf0171 <kernel_sendpage+0x11>:      mov    
0xa0(%rax),%r9
     0xffffffff9caf0178 <kernel_sendpage+0x18>:      test   %r9,%r9
     0xffffffff9caf017b <kernel_sendpage+0x1b>:      je     
0xffffffff9caf01b2 <kernel_sendpage+0x52>
     /usr/local/src/linux/./include/linux/page-flags.h: 253
>>> 0xffffffff9caf017d <kernel_sendpage+0x1d>:      mov    
>>> 0x8(%rsi),%rax
     /usr/local/src/linux/./include/linux/page-flags.h: 255

Yes, RSI is 0.

     251 static inline unsigned long _compound_head(const struct page 
*page)
     252 {
>>> 253     unsigned long head = READ_ONCE(page->compound_head);
     254
     255     if (unlikely(head & 1))
     256         return head - 1;
     257     return (unsigned long)page_fixed_fake_head(page);
     258 }

Hmm, maybe that's inside

kernel_sendpage ->
	sendpage_ok ->
		page_count ->
			folio_ref_count ->
				page_folio

.. and page is NULL?  That would only make sense if we used to survive
calling kernel_sendpage with bvec->bv_page = NULL, which seems unlikely.

I'll try to catch a vmcore this time, which will help me see more.

Ben

