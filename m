Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B659610434
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 23:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiJ0VPq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 17:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiJ0VPp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 17:15:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2564520D;
        Thu, 27 Oct 2022 14:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3845E624F7;
        Thu, 27 Oct 2022 21:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C247BC433C1;
        Thu, 27 Oct 2022 21:15:40 +0000 (UTC)
Date:   Thu, 27 Oct 2022 17:15:55 -0400
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
Message-ID: <20221027171555.7fcd27ee@gandalf.local.home>
In-Reply-To: <20221027170720.31497319@gandalf.local.home>
References: <20221027150525.753064657@goodmis.org>
        <20221027150928.780676863@goodmis.org>
        <20221027155513.60b211e2@gandalf.local.home>
        <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
        <20221027163453.383bbf8e@gandalf.local.home>
        <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
        <20221027170720.31497319@gandalf.local.home>
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

On Thu, 27 Oct 2022 17:07:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > And maybe that function can also disallow any future re-arming even
> > for the case where the timer couldn't be actively removed.  

The naming of the functions will depend on this.

If the async version always shuts down the timer, then we should have the
interface be:

	del_timer_shutdown() <- async

	del_timer_shutdown_sync <- sync

As it would match the del_timer() and del_timer_sync() semantics.

If shutdown only happens if the timer is removed, then I believe the
current approach of del_timer_shutdown() being synchronous and
del_timer_try_shutdown() being async is the way to go, as it follows more
the semantics of mutex_lock() and mutex_trylock().

-- Steve
