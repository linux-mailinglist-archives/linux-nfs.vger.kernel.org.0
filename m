Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76081BFA50
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2019 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfIZTvA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Sep 2019 15:51:00 -0400
Received: from fieldses.org ([173.255.197.46]:60848 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbfIZTvA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 26 Sep 2019 15:51:00 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 2BDCD150B; Thu, 26 Sep 2019 15:51:00 -0400 (EDT)
Date:   Thu, 26 Sep 2019 15:51:00 -0400
To:     James Harvey <jamespharvey20@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        bcodding@redhat.com
Subject: Re: 5.3.0 Regression: rpc.nfsd v4 uninterruptible sleep for 5+
 minutes w/o rpc-statd/etc
Message-ID: <20190926195100.GB2849@fieldses.org>
References: <CA+X5Wn60sGi+za48Lj-y1fcHHw7kdzEUsw8nj+Xc0U90mONz5w@mail.gmail.com>
 <CA+X5Wn6Yj6752BMxpXB-wa92QQD7xv3uOp=rzJn5qP-_RxL41g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+X5Wn6Yj6752BMxpXB-wa92QQD7xv3uOp=rzJn5qP-_RxL41g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 19, 2019 at 09:17:03AM -0400, James Harvey wrote:
> On Thu, Sep 19, 2019 at 9:00 AM James Harvey <jamespharvey20@gmail.com> wrote:
> >
> > For a really long time (years?) if you forced NFS v4 only, you could
> > mask a lot of unnecessary services.
> >
> > In /etc/nfs.conf, in "[nfsd] I've been able to set "vers3=n", and then
> > mask the following services:
> > * gssproxy
> > * nfs-blkmap
> > * rpc-statd
> > * rpcbind (service & socket)
> >
> > Upgrading from 5.2.14 to 5.3.0, nfs-server.service (rpc.nfsd) has
> > exactly a 5 minute delay, and sometimes longer.
> >
> > ...
> 
> P.S.  During a few of the earlier boots where I was seeing strace show
> the delay was reading "/proc/fs/nfsd/versions", I do have this in
> journalctl, when I tried in another term cat'ing it during the
> rpc.nfsd delay: (it repeats a few times during the 5 minute delay)

It's waiting on the nfsd_mutex.

So somebody else is sitting around blocking for five minutes while
holding nfsd_mutex.  That lock covers a lot of stuff so that may not
narrow down much who's blocking.

An alt-sysrq-t dump might help.

(So, hit alt-sysrq-t, or echo t to /proc/sysrq-trigger, then look in
dmesg for tasks that are waiting.)

There's not a whole ton of changes between 5.2 and 5.3, but I'm not
seeing an obvious culprit.

--b.

> 
> INFO: task cat:3400 blocked for more than 122 seconds.
>       Not tainted 5.3.0-arch1-1-ARCH #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> cat             D    0  3400   3029 0x00000080
> Call Trace:
>  ? __schedule+0x27f/0x6d0
>  schedule+0x43/0xd0
>  schedule_preempt_disabled+0x14/0x20
>  __mutex_lock.isra.0+0x27d/0x530
>  write_versions+0x38/0x3c0 [nfsd]
>  ? _copy_from_user+0x37/0x60
>  ? write_ports+0x320/0x320 [nfsd]
>  nfsctl_transaction_write+0x45/0x70 [nfsd]
>  nfsctl_transaction_read+0x3b/0x60 [nfsd]
>  vfs_read+0x9d/0x150
>  ksys_read+0x67/0xe0
>  do_syscall_64+0x5f/0x1c0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f47286fa155
> Code: Bad RIP value.
> RSP: 002b:00007ffcd2a74438 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f47286fa155
> RDX: 0000000000020000 RSI: 00007f47282ba000 RDI: 0000000000000003
> RBP: 00007f47282ba000 R08: 00007f47282b9010 R09: 0000000000000000
> R10: 0000000000000022 R11: 0000000000000246 R12: 00007f47282ba000
> R13: 0000000000000003 R14: 0000000000000fff R15: 0000000000020000
> svc: failed to register lockdv1 RPC service (errno 110).
> lockd_up: makesock failed, error=-110
