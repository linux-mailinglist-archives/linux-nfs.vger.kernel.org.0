Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E408620AFC5
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 12:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgFZKc5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 06:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgFZKcz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 06:32:55 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B49C08C5DB
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 03:32:55 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m8so32940qvk.7
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5is8QgfW0gBT/UztmS5Gx1+Dzt1VpAF0qsHJJZDlEzk=;
        b=jyN/jn2LrUOfl+dWKpQtdx0Fm023Pzp0IYz9wVPVx6hcR8lWhkq7E9WL4wyp9RvLTS
         G85s1V3Wx/5aVJnk9Oqd93kGYjqGWFw5Dcy4RXWhKrNyf6SngXFemuETNbqIbg2Seo2S
         2d2ooHizRgkJafA22RvTIq2AT33xEWKgyIh3LoxYGM9WFXo8oF72SbepIqrcVBNIiBdx
         ODiwfNQ+TKTsP66nYdPigUhVtblRQXdVm7nDd2pv/qZmSg7i/UXoAgg3+97o3JEuCam3
         l0DNq/sGed2NcR2rtIHDEPcYdpSx5DgyH27EIniHIHKvZvaWMlFjMQQv9H4C2TVeT0YK
         RJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5is8QgfW0gBT/UztmS5Gx1+Dzt1VpAF0qsHJJZDlEzk=;
        b=nd+lxtvTMHVvg9gs+JNLvpMkRaHgnd2xo1ug/QRv1lJtfPrHek78MOu0SHaqUJcJ+J
         Z7FqE81X9SHrifpZaxWexTIhDI+yGLwPKeWKvWpYp893pbCZWp71QXMq4f/jDaVSBqRQ
         Zdx34vwzfUdOyT1aE9fz0+EwddB/E8NPNedI/eDx0E1rUSjoWLeQhQBwirKaiROZ7Fjs
         w6GR+1PSaepAytrXGTA8IWd1TGx5O0xc8QQGmLafmSLuLULzQUvuega7YqW4lvbt1IK3
         bNtjAj72/QfXm5tHPKeY4uGMMkbqeLQ1Qpra34mdkW3aqlkwSKPi594FIaeb2EwnRaMV
         e1pA==
X-Gm-Message-State: AOAM530C97R3EvyRJsfRBjRMZBbeOUV4KZTnOheZiJM1HS3VrEHCE00x
        Fj8ezLM7fTtih+jtwXehgJ49Kx/8CI33HPSWHJzQcQ==
X-Google-Smtp-Source: ABdhPJyNOSbigKih7uapbvdX/VrAsdc7giwzpAsQt1CBo6vtdtapJ25yVNRbjmKzRmMjihMtGS6lAlUa9vP5bHkfJk4=
X-Received: by 2002:a0c:bf06:: with SMTP id m6mr2459515qvi.80.1593167574187;
 Fri, 26 Jun 2020 03:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005016dd05a5e6b308@google.com> <20200603043435.13820-1-hdanton@sina.com>
 <20200603144326.GA2035@fieldses.org> <20200604035359.2516-1-hdanton@sina.com>
 <20200604215812.GC3458@fieldses.org> <20200625210229.GE6605@fieldses.org>
In-Reply-To: <20200625210229.GE6605@fieldses.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 26 Jun 2020 12:32:42 +0200
Message-ID: <CACT4Y+b_byN4xT+-42M6XtHv=QKRrgD2aSH+Hd0CDJ=v+OYWPA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in rb_erase
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+0e37e9d19bded16b8ab9@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, LKML <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 25, 2020 at 11:02 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > On Thu, Jun 04, 2020 at 11:53:59AM +0800, Hillf Danton wrote:
> > >
> > > On Wed, 3 Jun 2020 12:48:49 -0400 J. Bruce Fields wrote:
> > > > On Wed, Jun 03, 2020 at 10:43:26AM -0400, J. Bruce Fields wrote:
> > > > > On Wed, Jun 03, 2020 at 12:34:35PM +0800, Hillf Danton wrote:
> > > > > >
> > > > > > On Tue, 2 Jun 2020 17:55:17 -0400 "J. Bruce Fields" wrote:
> > > > > > >
> > > > > > > As far as I know, this one's still unresolved.  I can't see the bug from
> > > > > > > code inspection, and we don't have a reproducer.  If anyone else sees
> > > > > > > this or has an idea what might be going wrong, I'd be interested.--b.
> > > > > >
> > > > > > It's a PF reported in the syz-executor.3 context (PID: 8682 on CPU:1),
> > > > > > meanwhile there's another at
> > > > > >
> > > > > >  https://lore.kernel.org/lkml/20200603011425.GA13019@fieldses.org/T/#t
> > > > > >  Reported-by: syzbot+a29df412692980277f9d@syzkaller.appspotmail.com
> > > > > >
> > > > > > in the kworker context, and one of the quick questions is, is it needed
> > > > > > to serialize the two players, say, using a mutex?
> > > > >
> > > > > nfsd_reply_cache_shutdown() doesn't take any locks.  All the data
> > > > > structures it's tearing down are per-network-namespace, and it's assumed
> > > > > all the users of that structure are gone by the time we get here.
> > > > >
> > > > > I wonder if that assumption's correct.  Looking at nfsd_exit_net()....
> > >
> > > IIUC it's correct for the kworker case where the ns in question is on
> > > the cleanup list, and for the syscall as well because the report is
> > > triggered in the error path, IOW the new ns is not yet visible to the
> > > kworker ATM.
> >
> > Sorry, I'm not familiar with the namespace code and I'm not following
> > you.
> >
> > I'm trying to figure out what prevents the network namespace exit method
> > being called while nfsd is still processing an rpc call from that
> > network namespace.
>
> Looking at this some more:
>
> Each server socket (struct svc_xprt) holds a reference on the struct net
> that's not released until svc_xprt_free().
>
> The svc_xprt is itself referenced as long as an rpc for that socket is
> being processed, the referenced released in svc_xprt_release().  Which
> isn't called until the rpc is processed and the reply sent.
>
> So, assuming nfsd_exit_net() can't be called while we're still holding
> references to the struct net, there can't still be any reply cache
> processing going on when nfsd_reply_cache_shutdown() is called.
>
> So, still a mystery to me how this is happening.

Hi Bruce,

So far this crash happened only once:
https://syzkaller.appspot.com/bug?extid=0e37e9d19bded16b8ab9

For continuous fuzzing on syzbot it usually means either (1) it's a
super narrow race or (2) it's a previous unnoticed memory corruption.

Simpler bugs usually have much higher hit counts:
https://syzkaller.appspot.com/upstream
https://syzkaller.appspot.com/upstream/fixed

If you did a reasonable looking for any obvious bugs in the code that
would lead to such failure, it can make sense to postpone any
additional actions until we have more info.
If no info comes, at some point syzbot will auto-obsolete it, and then
then we can assume it was (2).



> --b.
>
> >
> >
> > > ---
> > > v2: Use linux/highmem.h instead of asm/cacheflush.sh
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > > net/sunrpc/svcsock.c | 1 +
> > > 1 file changed, 1 insertion(+)
> > >
> > > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > > index 5c4ec9386f81..c537272f9c7e 100644
> > > --- a/net/sunrpc/svcsock.c
> > > +++ b/net/sunrpc/svcsock.c
> > > @@ -44,6 +44,7 @@
> > > #include <net/tcp.h>
> > > #include <net/tcp_states.h>
> > > #include <linux/uaccess.h>
> > > +#include <linux/highmem.h>
> > > #include <asm/ioctls.h>
> > >
> > > #include <linux/sunrpc/types.h>
> > > --
> > > 2.25.0
> > >
> >
> > --
> > Chuck Lever
> >
> >
>
> >
> > --b.
> >
> > >
> > > Then we can not draw a race between the two parties, and the two reports
> > > are not related... but of independent glitches.
> > >
> > > > >
> > > > > nfsd_reply_cache_shutdown() is one of the first things we do, so I think
> > > > > we're depending on the assumption that the interfaces in that network
> > > > > namespace, and anything referencing associated sockets (in particular,
> > > > > any associated in-progress rpc's), must be gone before our net exit
> > > > > method is called.
> > > > >
> > > > > I wonder if that's a good assumption.
> > > >
> > > > I think that assumption must be the problem.
> > > >
> > > > That would explain why the crashes are happening in nfsd_exit_net as
> > > > opposed to somewhere else, and why we're only seeing them since
> > > > 3ba75830ce17 "nfsd4: drc containerization".
> > > >
> > > > I wonder what *is* safe to assume when the net exit method is called?
> > > >
> > > > --b.
> > > >
> > > > >
> > > > > --b.
> > > > >
> > > > > >
> > > > > >
> > > > > > > On Sun, May 17, 2020 at 11:59:12PM -0700, syzbot wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > syzbot found the following crash on:
> > > > > > > >
> > > > > > > > HEAD commit:    9b1f2cbd Merge tag 'clk-fixes-for-linus' of git://git.kern..
> > > > > > > > git tree:       upstream
> > > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15dfdeaa100000
> > > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c14212794ed9ad24
> > > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0e37e9d19bded16b8ab9
> > > > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > > > >
> > > > > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > > > > >
> > > > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > > > Reported-by: syzbot+0e37e9d19bded16b8ab9@syzkaller.appspotmail.com
> > > > > > > >
> > > > > > > > BUG: unable to handle page fault for address: ffff887ffffffff0
> > > > > > > > #PF: supervisor read access in kernel mode
> > > > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > > > PGD 0 P4D 0
> > > > > > > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > > > > > > CPU: 1 PID: 8682 Comm: syz-executor.3 Not tainted 5.7.0-rc5-syzkaller #0
> > > > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > > > > > RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:201 [inline]
> > > > > > > > RIP: 0010:rb_erase+0x37/0x18d0 lib/rbtree.c:443
> > > > > > > > Code: 89 f7 41 56 41 55 49 89 fd 48 83 c7 08 48 89 fa 41 54 48 c1 ea 03 55 53 48 83 ec 18 80 3c 02 00 0f 85 89 10 00 00 49 8d 7d 10 <4d> 8b 75 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80
> > > > > > > > RSP: 0018:ffffc900178ffb58 EFLAGS: 00010246
> > > > > > > > RAX: dffffc0000000000 RBX: ffff8880354d0000 RCX: ffffc9000fb6d000
> > > > > > > > RDX: 1ffff10ffffffffe RSI: ffff88800011dfe0 RDI: ffff887ffffffff8
> > > > > > > > RBP: ffff887fffffffb0 R08: ffff888057284280 R09: fffffbfff185d12e
> > > > > > > > R10: ffffffff8c2e896f R11: fffffbfff185d12d R12: ffff88800011dfe0
> > > > > > > > R13: ffff887fffffffe8 R14: 000000000001dfe0 R15: ffff88800011dfe0
> > > > > > > > FS:  00007fa002d21700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > CR2: ffff887ffffffff0 CR3: 00000000a2164000 CR4: 00000000001426e0
> > > > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > > > Call Trace:
> > > > > > > >  nfsd_reply_cache_free_locked+0x198/0x380 fs/nfsd/nfscache.c:127
> > > > > > > >  nfsd_reply_cache_shutdown+0x150/0x350 fs/nfsd/nfscache.c:203
> > > > > > > >  nfsd_exit_net+0x189/0x4c0 fs/nfsd/nfsctl.c:1504
> > > > > > > >  ops_exit_list.isra.0+0xa8/0x150 net/core/net_namespace.c:186
> > > > > > > >  setup_net+0x50c/0x860 net/core/net_namespace.c:364
> > > > > > > >  copy_net_ns+0x293/0x590 net/core/net_namespace.c:482
> > > > > > > >  create_new_namespaces+0x3fb/0xb30 kernel/nsproxy.c:108
> > > > > > > >  unshare_nsproxy_namespaces+0xbd/0x1f0 kernel/nsproxy.c:229
> > > > > > > >  ksys_unshare+0x43d/0x8e0 kernel/fork.c:2970
> > > > > > > >  __do_sys_unshare kernel/fork.c:3038 [inline]
> > > > > > > >  __se_sys_unshare kernel/fork.c:3036 [inline]
> > > > > > > >  __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3036
> > > > > > > >  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> > > > > > > >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20200625210229.GE6605%40fieldses.org.
