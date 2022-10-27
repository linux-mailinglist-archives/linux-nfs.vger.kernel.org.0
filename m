Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71F46105CB
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 00:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiJ0WfG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 18:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbiJ0WfF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 18:35:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBD232EDE;
        Thu, 27 Oct 2022 15:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99879B8263F;
        Thu, 27 Oct 2022 22:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2E1C433C1;
        Thu, 27 Oct 2022 22:34:56 +0000 (UTC)
Date:   Thu, 27 Oct 2022 18:35:11 -0400
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
Message-ID: <20221027183511.66b058c4@gandalf.local.home>
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

> Well, I think this current use case will break if we prevent the timer from
> being rearmed or run again if it's not found. But as you said, the
> networking folks need to confirm or deny it.
> 
> The fact that it does the sock_put() when it removes the timer makes me
> think that it can be called again, and we shouldn't prevent that from
> happening.
> 
> The debug code will let us know too, as it only "frees" it for freeing if
> it deactivated the timer and shut it down.

I think we have our answer from Guenter's report:


Linux version 6.1.0-rc2-00138-gced58c742836 (groeck@jupiter) (aarch64-linux-gcc (GCC) 11.3.0, GNU ld (GNU Binutils) 2.39) #1 SMP PREEMPT Thu Oct 27 14:53:17 PDT 2022
[   17.258727] ------------[ cut here ]------------
[   17.259079] ODEBUG: free active (active state 0) object type: timer_list hint: tcp_write_timer+0x0/0x190
[   17.259723] WARNING: CPU: 0 PID: 309 at lib/debugobjects.c:502 debug_print_object+0xb8/0x100
[   17.259951] Modules linked in:
[   17.260249] CPU: 0 PID: 309 Comm: telnet Tainted: G                 N 6.1.0-rc2-00138-gced58c742836 #1
[   17.260518] Hardware name: linux,dummy-virt (DT)
[   17.260779] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   17.260967] pc : debug_print_object+0xb8/0x100
[   17.261096] lr : debug_print_object+0xb8/0x100
[   17.261223] sp : ffff8000086539e0
[   17.261324] x29: ffff8000086539e0 x28: 0000000000000004 x27: ffff0d2ac2168000
[   17.261574] x26: 0000000000000000 x25: ffffa241e2b9de18 x24: ffffa241e4f8fcd8
[   17.261772] x23: ffffa241e336b370 x22: ffffa241e2b9de18 x21: ffff0d2ac20c5710
[   17.261967] x20: ffffa241e4ea2568 x19: ffffa241e3ea3c00 x18: 00000000ffffffff
[   17.262161] x17: 6c6973742068696e x16: 3a2074696d65725f x15: 6563742074797065
[   17.262375] x14: 65203029206f626a x13: ffffa241e3ec7640 x12: 0000000000000d50
[   17.262591] x11: 0000000000000470 x10: ffffa241e3f1f640 x9 : ffffa241e3ec7640
[   17.262821] x8 : 00000000ffffefff x7 : ffffa241e3f1f640 x6 : 0000000000000000
[   17.263028] x5 : ffff0d2adfebba68 x4 : 0000000000000000 x3 : 0000000000000027
[   17.263235] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0d2ac658b340
[   17.263528] Call trace:
[   17.263646]  debug_print_object+0xb8/0x100
[   17.263795]  __debug_check_no_obj_freed+0x1d0/0x25c
[   17.263927]  debug_check_no_obj_freed+0x20/0x90
[   17.264051]  slab_free_freelist_hook.constprop.0+0xac/0x1b0
[   17.264197]  kmem_cache_free+0x1ac/0x500
[   17.264311]  __sk_destruct+0x140/0x2a0
[   17.264425]  sk_destruct+0x54/0x64
[   17.264531]  __sk_free+0x74/0x120
[   17.264636]  sk_free+0x64/0x8c
[   17.264736]  tcp_close+0x94/0xc0
[   17.264840]  inet_release+0x50/0xb0
[   17.264949]  __sock_release+0x44/0xbc
[   17.265061]  sock_close+0x18/0x30
[   17.265166]  __fput+0x84/0x270
[   17.265266]  ____fput+0x10/0x20
[   17.265366]  task_work_run+0x88/0xf0
[   17.265491]  do_exit+0x334/0xafc
[   17.265596]  do_group_exit+0x34/0x90
[   17.265705]  __arm64_sys_exit_group+0x18/0x20
[   17.265826]  invoke_syscall+0x48/0x114
[   17.265941]  el0_svc_common.constprop.0+0x60/0x11c
[   17.266070]  do_el0_svc+0x30/0xd0
[   17.266175]  el0_svc+0x48/0xc0
[   17.266276]  el0t_64_sync_handler+0xbc/0x13c
[   17.266396]  el0t_64_sync+0x18c/0x190
[   17.266565] irq event stamp: 5192
[   17.266676] hardirqs last  enabled at (5191): [<ffffa241e1926a18>] __up_console_sem+0x78/0x84
[   17.266903] hardirqs last disabled at (5192): [<ffffa241e2b4d504>] el1_dbg+0x24/0x90
[   17.267093] softirqs last  enabled at (5170): [<ffffa241e181050c>] __do_softirq+0x46c/0x5d8
[   17.267305] softirqs last disabled at (5163): [<ffffa241e1816750>] ____do_softirq+0x10/0x20
[   17.267506] ---[ end trace 0000000000000000 ]---
[   17.275715] ------------[ cut here ]------------

I'll go modify that code to make it shutdown even if it returns zero.

I thinks this means we'll need to change the name to:

 del_timer_shutdown()
 del_timer_shutdown_sync()

But I want to confirm this first.

-- Steve


