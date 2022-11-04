Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FAF619083
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Nov 2022 06:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiKDFz7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Nov 2022 01:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiKDFzW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Nov 2022 01:55:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163B22A424;
        Thu,  3 Nov 2022 22:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1CAAB82BFE;
        Fri,  4 Nov 2022 05:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F079C433D6;
        Fri,  4 Nov 2022 05:51:41 +0000 (UTC)
Date:   Fri, 4 Nov 2022 01:51:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <20221104015139.58f17730@rorschach.local.home>
In-Reply-To: <CANn89iLv9cak6_vXJG5t=Kq+eiMPdMxF8w4AAuAuFB5sOsy2zg@mail.gmail.com>
References: <20221027150525.753064657@goodmis.org>
        <20221027150928.780676863@goodmis.org>
        <20221027155513.60b211e2@gandalf.local.home>
        <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
        <20221027163453.383bbf8e@gandalf.local.home>
        <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
        <20221027170720.31497319@gandalf.local.home>
        <20221027183511.66b058c4@gandalf.local.home>
        <20221028183149.2882a29b@gandalf.local.home>
        <20221028154617.3c63ba68@kernel.org>
        <27a6a587fee5e9172e41acd16ae1bc1f556fdbd7.camel@redhat.com>
        <20221103175123.744d0f37@rorschach.local.home>
        <CANn89iLv9cak6_vXJG5t=Kq+eiMPdMxF8w4AAuAuFB5sOsy2zg@mail.gmail.com>
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

On Thu, 3 Nov 2022 17:00:20 -0700
Eric Dumazet <edumazet@google.com> wrote:

>  inet_csk_clear_xmit_timers() can be called multiple times during TCP
> socket lifetime.
> 
> (See tcp_disconnect(), which can be followed by another connect() ... and loop)
> 
> Maybe add a second parameter, or add a new
> inet_csk_shutdown_xmit_timers() only called from tcp_v4_destroy_sock() ?
> 

I guess.

> >
> >  void inet_csk_delete_keepalive_timer(struct sock *sk)
> >  {
> > -       sk_stop_timer(sk, &sk->sk_timer);
> > +       sk_shutdown_timer(sk, &sk->sk_timer);  
> 
> SO_KEEPALIVE can be called multiple times in a TCP socket lifetime,
> on/off/on/off/...
> 
> I suggest leaving sk_stop_timer() here.
> 
> Eventually  inet_csk_clear_xmit_timers( sk, destroy=true) (or
> inet_csk_shutdown_xmit_timers(())
>    will  be called before the socket is destroyed.

OK. 

Guenter,

I posted a new series, but did not include this change. If you want to
test that other series, I would suggest to at least add the first part
of this patch, otherwise it will trigger. But we want to see if there's
other locations of issue that we should care about.

-- Steve
