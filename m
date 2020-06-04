Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8214A1EED91
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2020 23:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgFDV6N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Jun 2020 17:58:13 -0400
Received: from fieldses.org ([173.255.197.46]:55610 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgFDV6N (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 4 Jun 2020 17:58:13 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id CD23A2017; Thu,  4 Jun 2020 17:58:12 -0400 (EDT)
Date:   Thu, 4 Jun 2020 17:58:12 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+0e37e9d19bded16b8ab9@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: BUG: unable to handle kernel paging request in rb_erase
Message-ID: <20200604215812.GC3458@fieldses.org>
References: <0000000000005016dd05a5e6b308@google.com>
 <20200603043435.13820-1-hdanton@sina.com>
 <20200603144326.GA2035@fieldses.org>
 <20200604035359.2516-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604035359.2516-1-hdanton@sina.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 04, 2020 at 11:53:59AM +0800, Hillf Danton wrote:
> 
> On Wed, 3 Jun 2020 12:48:49 -0400 J. Bruce Fields wrote:
> > On Wed, Jun 03, 2020 at 10:43:26AM -0400, J. Bruce Fields wrote:
> > > On Wed, Jun 03, 2020 at 12:34:35PM +0800, Hillf Danton wrote:
> > > > 
> > > > On Tue, 2 Jun 2020 17:55:17 -0400 "J. Bruce Fields" wrote:
> > > > > 
> > > > > As far as I know, this one's still unresolved.  I can't see the bug from
> > > > > code inspection, and we don't have a reproducer.  If anyone else sees
> > > > > this or has an idea what might be going wrong, I'd be interested.--b.
> > > > 
> > > > It's a PF reported in the syz-executor.3 context (PID: 8682 on CPU:1),
> > > > meanwhile there's another at 
> > > > 
> > > >  https://lore.kernel.org/lkml/20200603011425.GA13019@fieldses.org/T/#t
> > > >  Reported-by: syzbot+a29df412692980277f9d@syzkaller.appspotmail.com
> > > > 
> > > > in the kworker context, and one of the quick questions is, is it needed
> > > > to serialize the two players, say, using a mutex?
> > > 
> > > nfsd_reply_cache_shutdown() doesn't take any locks.  All the data
> > > structures it's tearing down are per-network-namespace, and it's assumed
> > > all the users of that structure are gone by the time we get here.
> > > 
> > > I wonder if that assumption's correct.  Looking at nfsd_exit_net()....
> 
> IIUC it's correct for the kworker case where the ns in question is on
> the cleanup list, and for the syscall as well because the report is
> triggered in the error path, IOW the new ns is not yet visible to the
> kworker ATM.

Sorry, I'm not familiar with the namespace code and I'm not following
you.

I'm trying to figure out what prevents the network namespace exit method
being called while nfsd is still processing an rpc call from that
network namespace.

--b.

> 
> Then we can not draw a race between the two parties, and the two reports
> are not related... but of independent glitches.
> 
> > > 
> > > nfsd_reply_cache_shutdown() is one of the first things we do, so I think
> > > we're depending on the assumption that the interfaces in that network
> > > namespace, and anything referencing associated sockets (in particular,
> > > any associated in-progress rpc's), must be gone before our net exit
> > > method is called.
> > > 
> > > I wonder if that's a good assumption.
> > 
> > I think that assumption must be the problem.
> > 
> > That would explain why the crashes are happening in nfsd_exit_net as
> > opposed to somewhere else, and why we're only seeing them since
> > 3ba75830ce17 "nfsd4: drc containerization".
> > 
> > I wonder what *is* safe to assume when the net exit method is called?
> > 
> > --b.
> > 
> > > 
> > > --b.
> > > 
> > > > 
> > > > 
> > > > > On Sun, May 17, 2020 at 11:59:12PM -0700, syzbot wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > syzbot found the following crash on:
> > > > > > 
> > > > > > HEAD commit:    9b1f2cbd Merge tag 'clk-fixes-for-linus' of git://git.kern..
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15dfdeaa100000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c14212794ed9ad24
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0e37e9d19bded16b8ab9
> > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > > 
> > > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > > > 
> > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+0e37e9d19bded16b8ab9@syzkaller.appspotmail.com
> > > > > > 
> > > > > > BUG: unable to handle page fault for address: ffff887ffffffff0
> > > > > > #PF: supervisor read access in kernel mode
> > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > PGD 0 P4D 0 
> > > > > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > > > > CPU: 1 PID: 8682 Comm: syz-executor.3 Not tainted 5.7.0-rc5-syzkaller #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > > > RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:201 [inline]
> > > > > > RIP: 0010:rb_erase+0x37/0x18d0 lib/rbtree.c:443
> > > > > > Code: 89 f7 41 56 41 55 49 89 fd 48 83 c7 08 48 89 fa 41 54 48 c1 ea 03 55 53 48 83 ec 18 80 3c 02 00 0f 85 89 10 00 00 49 8d 7d 10 <4d> 8b 75 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80
> > > > > > RSP: 0018:ffffc900178ffb58 EFLAGS: 00010246
> > > > > > RAX: dffffc0000000000 RBX: ffff8880354d0000 RCX: ffffc9000fb6d000
> > > > > > RDX: 1ffff10ffffffffe RSI: ffff88800011dfe0 RDI: ffff887ffffffff8
> > > > > > RBP: ffff887fffffffb0 R08: ffff888057284280 R09: fffffbfff185d12e
> > > > > > R10: ffffffff8c2e896f R11: fffffbfff185d12d R12: ffff88800011dfe0
> > > > > > R13: ffff887fffffffe8 R14: 000000000001dfe0 R15: ffff88800011dfe0
> > > > > > FS:  00007fa002d21700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: ffff887ffffffff0 CR3: 00000000a2164000 CR4: 00000000001426e0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > Call Trace:
> > > > > >  nfsd_reply_cache_free_locked+0x198/0x380 fs/nfsd/nfscache.c:127
> > > > > >  nfsd_reply_cache_shutdown+0x150/0x350 fs/nfsd/nfscache.c:203
> > > > > >  nfsd_exit_net+0x189/0x4c0 fs/nfsd/nfsctl.c:1504
> > > > > >  ops_exit_list.isra.0+0xa8/0x150 net/core/net_namespace.c:186
> > > > > >  setup_net+0x50c/0x860 net/core/net_namespace.c:364
> > > > > >  copy_net_ns+0x293/0x590 net/core/net_namespace.c:482
> > > > > >  create_new_namespaces+0x3fb/0xb30 kernel/nsproxy.c:108
> > > > > >  unshare_nsproxy_namespaces+0xbd/0x1f0 kernel/nsproxy.c:229
> > > > > >  ksys_unshare+0x43d/0x8e0 kernel/fork.c:2970
> > > > > >  __do_sys_unshare kernel/fork.c:3038 [inline]
> > > > > >  __se_sys_unshare kernel/fork.c:3036 [inline]
> > > > > >  __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3036
> > > > > >  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> > > > > >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
