Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DCE610410
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbiJ0VLb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 17:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiJ0VLO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 17:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96BA764B;
        Thu, 27 Oct 2022 14:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09096624EC;
        Thu, 27 Oct 2022 21:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0E0C433D6;
        Thu, 27 Oct 2022 21:07:40 +0000 (UTC)
Date:   Thu, 27 Oct 2022 17:07:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: Re: [RFC][PATCH v2 19/31] timers: net: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221027170755.40ee4059@gandalf.local.home>
In-Reply-To: <20221027163453.383bbf8e@gandalf.local.home>
References: <20221027150525.753064657@goodmis.org>
        <20221027150928.780676863@goodmis.org>
        <20221027155513.60b211e2@gandalf.local.home>
        <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
        <20221027163453.383bbf8e@gandalf.local.home>
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

On Thu, 27 Oct 2022 16:34:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> What about del_timer_try_shutdown(), that if it removes the timer, it sets
> the function to NULL (making it equivalent to a successful shutdown),
> otherwise it does nothing. Allowing the the timer to be rearmed.
> 
> I think this would work in this case.

Guenter,

Can you apply this patch on top of the series, and see if it makes the
warning go away?

diff --git a/include/linux/timer.h b/include/linux/timer.h
index d4d90149d015..e3c5f4bdd526 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -184,12 +184,23 @@ static inline int timer_pending(const struct timer_list * timer)
 	return !hlist_unhashed_lockless(&timer->entry);
 }
 
+extern int __del_timer(struct timer_list * timer, bool free);
+
 extern void add_timer_on(struct timer_list *timer, int cpu);
-extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
 extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 
+static inline int del_timer_try_shutdown(struct timer_list *timer)
+{
+	return __del_timer(timer, true);
+}
+
+static inline int del_timer(struct timer_list *timer)
+{
+	return __del_timer(timer, false);
+}
+
 /*
  * The jiffies value which is added to now, when there is no timer
  * in the timer wheel:
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7305c65ad0eb..073031cb3bb9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1255,7 +1255,7 @@ EXPORT_SYMBOL_GPL(add_timer_on);
  * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
  * active timer returns 1.)
  */
-int del_timer(struct timer_list *timer)
+int __del_timer(struct timer_list *timer, bool free)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1266,12 +1266,16 @@ int del_timer(struct timer_list *timer)
 	if (timer_pending(timer)) {
 		base = lock_timer_base(timer, &flags);
 		ret = detach_if_pending(timer, base, true);
+		if (free && ret) {
+			timer->function = NULL;
+			debug_timer_deactivate(timer);
+		}
 		raw_spin_unlock_irqrestore(&base->lock, flags);
 	}
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer);
+EXPORT_SYMBOL(__del_timer);
 
 static int __try_to_del_timer_sync(struct timer_list *timer, bool free)
 {
diff --git a/net/core/sock.c b/net/core/sock.c
index 10cc84379d75..23a97442a0a6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3345,7 +3345,7 @@ EXPORT_SYMBOL(sk_reset_timer);
 
 void sk_stop_timer(struct sock *sk, struct timer_list* timer)
 {
-	if (del_timer(timer))
+	if (del_timer_try_shutdown(timer))
 		__sock_put(sk);
 }
 EXPORT_SYMBOL(sk_stop_timer);
