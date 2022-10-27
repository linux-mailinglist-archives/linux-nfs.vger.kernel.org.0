Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC8B61040A
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 23:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbiJ0VLY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 17:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiJ0VLK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 17:11:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2912A83F2C;
        Thu, 27 Oct 2022 14:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 71D05CE2869;
        Thu, 27 Oct 2022 21:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B34C433D6;
        Thu, 27 Oct 2022 21:07:05 +0000 (UTC)
Date:   Thu, 27 Oct 2022 17:07:20 -0400
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
Message-ID: <20221027170720.31497319@gandalf.local.home>
In-Reply-To: <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
References: <20221027150525.753064657@goodmis.org>
        <20221027150928.780676863@goodmis.org>
        <20221027155513.60b211e2@gandalf.local.home>
        <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
        <20221027163453.383bbf8e@gandalf.local.home>
        <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
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

On Thu, 27 Oct 2022 13:48:54 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Oct 27, 2022 at 1:34 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > What about del_timer_try_shutdown(), that if it removes the timer, it sets
> > the function to NULL (making it equivalent to a successful shutdown),
> > otherwise it does nothing. Allowing the the timer to be rearmed.  
> 
> Sounds sane to me and should work, but as mentioned, I think the
> networking people need to say "yeah" too.
> 
> And maybe that function can also disallow any future re-arming even
> for the case where the timer couldn't be actively removed.

Well, I think this current use case will break if we prevent the timer from
being rearmed or run again if it's not found. But as you said, the
networking folks need to confirm or deny it.

The fact that it does the sock_put() when it removes the timer makes me
think that it can be called again, and we shouldn't prevent that from
happening.

The debug code will let us know too, as it only "frees" it for freeing if
it deactivated the timer and shut it down.

> 
> So any *currently* active timer wouldn't be waited for (either because
> locking may make that a deadlock situation, or simply due to
> performance issues), but at least it would guarantee that no new timer
> activations can happen.
> 
> Because I do like the whole notion of "timer has been shutdown and
> cannot be used as a timer any more without re-initializing it" being a
> real state - even for a timer that may be "currently in flight".
> 
> So this all sounds very worthwhile to me, but I'm not surprised that
> we have code that then knows about all the subtleties of "del_timer()
> might still have a running timer" and actually take advantage of it
> (where "advantage" is likely more of a "deal with the complexities"
> rather than anything really positive ;)

Good to hear. This has been a thorn in our side as we keep hitting these
crashes in the timer code that look like a timer was freed before it
triggered.

> 
> And those existing subtle users might want particular semantics to at
> least make said complexities easier.
> 

Yeah, as someone told me recently, "If you let them play long enough without
setting out the rules, they will take advantage of everything and it will be
extremely hard to get them back in order".

-- Steve

