Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322D061063F
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 01:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiJ0XOI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 19:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJ0XN7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 19:13:59 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101DB56D1;
        Thu, 27 Oct 2022 16:13:57 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso2079113otb.6;
        Thu, 27 Oct 2022 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P41rwxhUMczs6ljwzqKYGCdlQ+dI/irnsNJUBE737lw=;
        b=nUs4BQ4QHj5upmui25ZlamsxDTY94q2eK6CXv3krB1huVK8iXo01EW8k7VAhNVROHi
         PjYBf8CwASEYPGf6SwTYwp/ZxxL+hu+oIEzBD66Gszc4ROJ0le1pA55DFqSM51JsTFZU
         gU5Wpx+bws1qVVFzHCN4FW/OY3wOMqGAS29n07JnNPwk7gWEJ4JAX/hseDkT64kYN3wQ
         XrXoWl/xM7zG/HuTEiKdr1MfmR0ifM6cjZrdxqnY+bg/ra9Xu38mR+BX7nY3UrahaCWD
         AC2+gJVoU576iIFXXsgNFhmCCUiwKUFb0hh6k9uqPefGAva3wPgPVGU4KfkgNYVbwaAx
         djyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P41rwxhUMczs6ljwzqKYGCdlQ+dI/irnsNJUBE737lw=;
        b=edFcRlntpKMMw2WjGExM2UT3ExiyoBPfZwa2yX3XKkNxZYIydnUjlzNp2MzsRMG7wM
         EWDj6WG0w7Z/GSyEUzKMGvpBl3iCclMbDX2ql5xXe4E6nfrW352ZNQ+xYuMQymB4d4D5
         YjNOjmLIdBEq4fPIlwCIwaOrez8awUWUIZLcrtNyAzSOhb1wFdHGoKHjXdWbiFAB2R3h
         VNrMoKeY3JhjgdekKOuQ0BRnACdXwnv+5DYFiR4q9Q9QkeocVi69kKeMc8QOdaWlywiu
         AKx7v0+5VlZdXh1JlF4zWL1sCTNyfSsWQUhit+/p19I8l3b891hDcbvShW12qsugqJcO
         OAbw==
X-Gm-Message-State: ACrzQf1/H9UZg1Hb9Oq4Y8ATcXrhyILzKZ/tqmSwiLGd5qkORJygijUi
        ZPOjGUWdWhzjPJdUc+yvKEg=
X-Google-Smtp-Source: AMsMyM5XO1l19DXXjtSxPrs4BROdbXynUNf2PKVD7EXor9oaUSYhVr2U5NCfT8ANE9SAPyn1InBLAA==
X-Received: by 2002:a05:6830:6611:b0:662:2725:d309 with SMTP id cp17-20020a056830661100b006622725d309mr16302188otb.293.1666912437226;
        Thu, 27 Oct 2022 16:13:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm943193ool.46.2022.10.27.16.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 16:13:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 27 Oct 2022 16:13:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
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
Message-ID: <20221027231355.GA279418@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 27, 2022 at 05:07:55PM -0400, Steven Rostedt wrote:
> On Thu, 27 Oct 2022 16:34:53 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > What about del_timer_try_shutdown(), that if it removes the timer, it sets
> > the function to NULL (making it equivalent to a successful shutdown),
> > otherwise it does nothing. Allowing the the timer to be rearmed.
> > 
> > I think this would work in this case.
> 
> Guenter,
> 
> Can you apply this patch on top of the series, and see if it makes the
> warning go away?

Applied, and started testing.

Please let me know if I am missing some other patch(es) to apply.

Thanks,
Guenter

> 
> diff --git a/include/linux/timer.h b/include/linux/timer.h
> index d4d90149d015..e3c5f4bdd526 100644
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
> @@ -184,12 +184,23 @@ static inline int timer_pending(const struct timer_list * timer)
>  	return !hlist_unhashed_lockless(&timer->entry);
>  }
>  
> +extern int __del_timer(struct timer_list * timer, bool free);
> +
>  extern void add_timer_on(struct timer_list *timer, int cpu);
> -extern int del_timer(struct timer_list * timer);
>  extern int mod_timer(struct timer_list *timer, unsigned long expires);
>  extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
>  extern int timer_reduce(struct timer_list *timer, unsigned long expires);
>  
> +static inline int del_timer_try_shutdown(struct timer_list *timer)
> +{
> +	return __del_timer(timer, true);
> +}
> +
> +static inline int del_timer(struct timer_list *timer)
> +{
> +	return __del_timer(timer, false);
> +}
> +
>  /*
>   * The jiffies value which is added to now, when there is no timer
>   * in the timer wheel:
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 7305c65ad0eb..073031cb3bb9 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1255,7 +1255,7 @@ EXPORT_SYMBOL_GPL(add_timer_on);
>   * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
>   * active timer returns 1.)
>   */
> -int del_timer(struct timer_list *timer)
> +int __del_timer(struct timer_list *timer, bool free)
>  {
>  	struct timer_base *base;
>  	unsigned long flags;
> @@ -1266,12 +1266,16 @@ int del_timer(struct timer_list *timer)
>  	if (timer_pending(timer)) {
>  		base = lock_timer_base(timer, &flags);
>  		ret = detach_if_pending(timer, base, true);
> +		if (free && ret) {
> +			timer->function = NULL;
> +			debug_timer_deactivate(timer);
> +		}
>  		raw_spin_unlock_irqrestore(&base->lock, flags);
>  	}
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(del_timer);
> +EXPORT_SYMBOL(__del_timer);
>  
>  static int __try_to_del_timer_sync(struct timer_list *timer, bool free)
>  {
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 10cc84379d75..23a97442a0a6 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3345,7 +3345,7 @@ EXPORT_SYMBOL(sk_reset_timer);
>  
>  void sk_stop_timer(struct sock *sk, struct timer_list* timer)
>  {
> -	if (del_timer(timer))
> +	if (del_timer_try_shutdown(timer))
>  		__sock_put(sk);
>  }
>  EXPORT_SYMBOL(sk_stop_timer);
