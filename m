Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2289611BCD
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJ1UtY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 16:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJ1UtK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 16:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAB0248C95;
        Fri, 28 Oct 2022 13:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F2FF62A65;
        Fri, 28 Oct 2022 20:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F03C433D6;
        Fri, 28 Oct 2022 20:48:53 +0000 (UTC)
Date:   Fri, 28 Oct 2022 16:49:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna Schumaker <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Message-ID: <20221028164910.6804a855@gandalf.local.home>
In-Reply-To: <A016D74D-CDFC-4CAB-9AE4-C1688C9A49A1@hammerspace.com>
References: <20221027150525.753064657@goodmis.org>
        <20221028145005.28bc324d@gandalf.local.home>
        <A016D74D-CDFC-4CAB-9AE4-C1688C9A49A1@hammerspace.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 28 Oct 2022 20:12:30 +0000
Trond Myklebust <trondmy@hammerspace.com> wrote:

> I seem to vaguely remember that at the time, del_timer_sync() would loop
> in order to catch re-arming timers, whereas del_singleshot_timer_sync()
> would not, hence the commit message. The expectation for
> del_singleshot_timer_sync() was simply that the caller would ensure
> safety against re-arming, which was indeed the case for this code.

Well, that expectation didn't last long. Your commit was added on June 22,
2005. Then on June 23, 2005 (the next day!) this happened:


55c888d6d09a0 ("timers fixes/improvements")

Which has:

@@ -89,12 +77,12 @@ static inline void add_timer(struct timer_list * timer)
 
 #ifdef CONFIG_SMP
   extern int del_timer_sync(struct timer_list *timer);
-  extern int del_singleshot_timer_sync(struct timer_list *timer);
 #else
 # define del_timer_sync(t) del_timer(t)
-# define del_singleshot_timer_sync(t) del_timer(t)
 #endif
 
+#define del_singleshot_timer_sync(t) del_timer_sync(t)
+


So much or efficiency! :-)

I guess converting it back to del_timer_sync() is the right thing to do
regardless of this patch series. I'll send you a patch.

-- Steve
