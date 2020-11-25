Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DA12C3652
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 02:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgKYBo1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 20:44:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbgKYBo0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 20:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606268664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t9iQniTQC+OyY3n1WWtRNHpoqxultr4qs+L8kpWdZVY=;
        b=RmtK5AAlCh6TX7L0uVpUv2Dp+MNfZxW8N784zPrlWGz7aedoRoFNWZY3XiJyzNrL1s4gB4
        oBFpxIhxE5bk3TTlygv252Y3iT4UWfSmM0ASF1j/c2fReQE4z6Lz6ED6h0W46t0ZNLg1HN
        A+TA7VtG6tu0hFbAP/FzGK6g9e8efdI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-MpAmjf7hNPCJDJBV3EA8WQ-1; Tue, 24 Nov 2020 20:44:22 -0500
X-MC-Unique: MpAmjf7hNPCJDJBV3EA8WQ-1
Received: by mail-ej1-f71.google.com with SMTP id yc22so298099ejb.20
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 17:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9iQniTQC+OyY3n1WWtRNHpoqxultr4qs+L8kpWdZVY=;
        b=SjOVoNyry6wpYZYbuQ2PdPyTjylz0Wce4uJTgA2keyfXNh8V+ubFPJEdNKjKJ5GI0V
         ZSgDFyqueRPWAHHFFP04FRjKGXXm2rdgvNOlWGwFYJAdKADYEYs685qTiD88Qm1JeGMw
         qnfSkZGH1D5AWGfeUYFxXRH8heHbOoO0PUsM8tjdWT8kvIK8egIVZUQJf5DfzhRGZbJY
         yoPzfXQrJQSsZPDhAxy5if2Ex/5J59K6jX2X4nFAoqNrTI7DcfWhGt1xduGvRPGzaG51
         JVDxSYkoYa3lqD13Z0zqLSzP8XnT3zZn5PEyJ8th+2B79c0AjrpWuMihEA9M7304HSpa
         8bqQ==
X-Gm-Message-State: AOAM532VRlfuU53Vj9RhBYd1tTlBDmopfkpGIWDlhODrWuJv8ghmZptr
        o1pqUKAT+Ov94TwHCc64L2Azvoo3QRqS+fc2ekmq001HsOzjmEER7W/AaUd/Ycm8hDwJ+fRSOVu
        vNYAcGeOUuvfjSt43CKogL4r8crbJoXfMt2s/
X-Received: by 2002:a17:906:2f87:: with SMTP id w7mr1177912eji.83.1606268659926;
        Tue, 24 Nov 2020 17:44:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnVWVKDvXc47D2OjbVmw7vU+Dt7iJ7MRPKLQpDydn4eXLvqkwZuof3swyiSbZJvGpvt1rQeh3X/CC5JKGmmGo=
X-Received: by 2002:a17:906:2f87:: with SMTP id w7mr1177899eji.83.1606268659675;
 Tue, 24 Nov 2020 17:44:19 -0800 (PST)
MIME-Version: 1.0
References: <CALF+zOntimx8nyiAUyN5Y58T9_-PztLpUU2vpYgOzQkcK7C09w@mail.gmail.com>
 <4f3a2c0de91ff3117ada740cc9b1a22eabb1375d.camel@hammerspace.com>
 <CALF+zOkEWrpo=NKL2ncoierFRKmsLqG56qKdsOHBC1k79Yqxhw@mail.gmail.com> <6c158409f81a82c6176d1c7156e229051a98f9b2.camel@hammerspace.com>
In-Reply-To: <6c158409f81a82c6176d1c7156e229051a98f9b2.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 24 Nov 2020 20:43:43 -0500
Message-ID: <CALF+zOnYbN2VghyB+Kj_YcBc_dCdVB6FTdQ+affrAWV6BKqtRw@mail.gmail.com>
Subject: Re: NFS failure with generic/074 when lockdep is enabled - BUG:
 Invalid wait context
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 8:33 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2020-11-24 at 20:28 -0500, David Wysochanski wrote:
> > On Tue, Nov 24, 2020 at 8:07 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > >
> > > On Tue, 2020-11-24 at 16:56 -0500, David Wysochanski wrote:
> > > > I've started seeing this failure since testing 5.10-rc4 - this
> > > > does
> > > > not happen on 5.9
> > > >
> > > >
> > > > f31-node1 login: [  124.055768] FS-Cache: Netfs 'nfs' registered
> > > > for
> > > > caching
> > > > [  125.046104] Key type dns_resolver registered
> > > > [  125.770354] NFS: Registering the id_resolver key type
> > > > [  125.780599] Key type id_resolver registered
> > > > [  125.782440] Key type id_legacy registered
> > > > [  126.563717] run fstests generic/074 at 2020-11-24 11:23:49
> > > > [  178.736479]
> > > > [  178.751380] =============================
> > > > [  178.753249] [ BUG: Invalid wait context ]
> > > > [  178.754886] 5.10.0-rc4 #127 Not tainted
> > > > [  178.756423] -----------------------------
> > > > [  178.758055] kworker/1:2/848 is trying to lock:
> > > > [  178.759866] ffff8947fffd33d8 (&zone->lock){..-.}-{3:3}, at:
> > > > get_page_from_freelist+0x897/0x2190
> > > > [  178.763333] other info that might help us debug this:
> > > > [  178.765354] context-{5:5}
> > > > [  178.766437] 3 locks held by kworker/1:2/848:
> > > > [  178.768158]  #0: ffff8946ce825538
> > > > ((wq_completion)nfsiod){+.+.}-{0:0}, at:
> > > > process_one_work+0x1be/0x540
> > > > [  178.771871]  #1: ffff9e6b408f7e58
> > > > ((work_completion)(&task->u.tk_work)#2){+.+.}-{0:0}, at:
> > > > process_one_work+0x1be/0x540
> > > > [  178.776562]  #2: ffff8947f7c5b2b0 (krc.lock){..-.}-{2:2}, at:
> > > > kvfree_call_rcu+0x69/0x230
> > > > [  178.779803] stack backtrace:
> > > > [  178.780996] CPU: 1 PID: 848 Comm: kworker/1:2 Kdump: loaded
> > > > Not
> > > > tainted 5.10.0-rc4 #127
> > > > [  178.784374] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> > > > [  178.787071] Workqueue: nfsiod rpc_async_release [sunrpc]
> > > > [  178.789308] Call Trace:
> > > > [  178.790386]  dump_stack+0x8d/0xb5
> > > > [  178.791816]  __lock_acquire.cold+0x20b/0x2c8
> > > > [  178.793605]  lock_acquire+0xca/0x380
> > > > [  178.795113]  ? get_page_from_freelist+0x897/0x2190
> > > > [  178.797116]  _raw_spin_lock+0x2c/0x40
> > > > [  178.798638]  ? get_page_from_freelist+0x897/0x2190
> > > > [  178.800620]  get_page_from_freelist+0x897/0x2190
> > > > [  178.802537]  __alloc_pages_nodemask+0x1b4/0x460
> > > > [  178.804416]  __get_free_pages+0xd/0x30
> > > > [  178.805987]  kvfree_call_rcu+0x168/0x230
> > > > [  178.807687]  nfs_free_request+0xab/0x180 [nfs]
> > > > [  178.809547]  nfs_page_group_destroy+0x41/0x80 [nfs]
> > > > [  178.811588]  nfs_read_completion+0x129/0x1f0 [nfs]
> > > > [  178.813633]  rpc_free_task+0x39/0x60 [sunrpc]
> > > > [  178.815481]  rpc_async_release+0x29/0x40 [sunrpc]
> > > > [  178.817451]  process_one_work+0x23e/0x540
> > > > [  178.819136]  worker_thread+0x50/0x3a0
> > > > [  178.820657]  ? process_one_work+0x540/0x540
> > > > [  178.822427]  kthread+0x10f/0x150
> > > > [  178.823805]  ? kthread_park+0x90/0x90
> > > > [  178.825339]  ret_from_fork+0x22/0x30
> > > >
> > >
> > > I can't think of any changes that might have caused this. Is this
> > > NFSv3, v4 or other? I haven't been seeing any of this.
> > >
> >
> > It is NFSv4.1 or NFS4.2.  I am running the xfstests NFS client
> > against
> > an older server, RHEL7 based (3.10.0-1127.8.2.el7.x86_64) though not
> > sure if that matters.
> > My config has these:
> > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> > CONFIG_PROVE_LOCKING=y
> > CONFIG_PROVE_RAW_LOCK_NESTING=y
> > CONFIG_DEBUG_SPINLOCK=y
> > CONFIG_DEBUG_LOCK_ALLOC=y
> > CONFIG_LOCKDEP=y
> >
> That helps. It means we can't blame the new READ_PLUS code, since it
> would be completely disabled here.
> Are you using any special rsize values? Also, could pNFS be involved
> (e.g. the pNFS block/scsi code)?
>

No special rsize values or pNFS should be involved - here's most of
the /proc/mounts
 /mnt/test nfs4
rw,context=system_u:object_r:root_t:s0,relatime,vers=4.1,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys

If you want I can try against a later server and maybe loopback on the
same 5.10-rc4 kernel and see if it reproduces?

>

FWIW, I've also seen at least once NFS4.1 produces something slightly different:

$ cat nfs41-fail-074-different-backtrace.txt
[   60.125028] run fstests generic/074 at 2020-11-24 11:57:51
[   62.281576]
[   62.300548] =============================
[   62.302205] [ BUG: Invalid wait context ]
[   62.303812] 5.10.0-rc4 #127 Not tainted
[   62.305351] -----------------------------
[   62.306954] fstest/2035 is trying to lock:
[   62.308588] ffff8fe4bffd23d8 (&zone->lock){..-.}-{3:3}, at:
get_page_from_freelist+0x897/0x2190
[   62.312079] other info that might help us debug this:
[   62.314105] context-{5:5}
[   62.315166] 3 locks held by fstest/2035:
[   62.316722]  #0: ffff8fe3b3d78448 (sb_writers#16){.+.+}-{0:0}, at:
do_syscall_64+0x33/0x40
[   62.320040]  #1: ffff8fe3d8f48488
(&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: do_truncate+0x69/0xd0
[   62.323706]  #2: ffff8fe4b7c9b2b0 (krc.lock){..-.}-{2:2}, at:
kvfree_call_rcu+0x69/0x230
[   62.326974] stack backtrace:
[   62.328151] CPU: 2 PID: 2035 Comm: fstest Kdump: loaded Not tainted
5.10.0-rc4 #127
[   62.331172] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[   62.333449] Call Trace:
[   62.334504]  dump_stack+0x8d/0xb5
[   62.335880]  __lock_acquire.cold+0x20b/0x2c8
[   62.337621]  ? find_get_entries+0x2c7/0x5b0
[   62.339316]  lock_acquire+0xca/0x380
[   62.340795]  ? get_page_from_freelist+0x897/0x2190
[   62.342722]  _raw_spin_lock+0x2c/0x40
[   62.344224]  ? get_page_from_freelist+0x897/0x2190
[   62.346123]  get_page_from_freelist+0x897/0x2190
[   62.347979]  ? __lock_acquire+0x3b1/0x25d0
[   62.349625]  __alloc_pages_nodemask+0x1b4/0x460
[   62.351437]  __get_free_pages+0xd/0x30
[   62.352942]  kvfree_call_rcu+0x168/0x230
[   62.354562]  nfs4_do_setattr+0x1f6/0x4e0 [nfsv4]
[   62.356455]  nfs4_proc_setattr+0xb0/0x160 [nfsv4]
[   62.358380]  nfs_setattr+0x102/0x2c0 [nfs]
[   62.360069]  notify_change+0x340/0x4d0
[   62.361587]  ? do_truncate+0x76/0xd0
[   62.363034]  do_truncate+0x76/0xd0
[   62.364413]  do_sys_ftruncate+0x14a/0x230
[   62.366037]  do_syscall_64+0x33/0x40
[   62.367481]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   62.369489] RIP: 0033:0x7f23c70c2abb
[   62.370927] Code: 77 05 c3 0f 1f 40 00 48 8b 15 c9 73 0c 00 f7 d8
64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 4d 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 99 73 0c 00
f7 d8
[   62.378219] RSP: 002b:00007ffd0780e788 EFLAGS: 00000202 ORIG_RAX:
000000000000004d
[   62.381208] RAX: ffffffffffffffda RBX: 0000000000002000 RCX: 00007f23c70c2abb
[   62.384031] RDX: 0000000000000242 RSI: 0000000000a00000 RDI: 0000000000000003
[   62.386851] RBP: 00000000017022b0 R08: 0000000000000000 R09: 000000000000001f
[   62.389677] R10: 00000000000001a4 R11: 0000000000000202 R12: 0000000000000003
[   62.392493] R13: 0000000000000000 R14: 0000000000a00000 R15: 0000000000000001



# eu-addr2line -e fs/nfs/nfsv4.ko nfs4_do_setattr+0x1f6
fs/nfs/nfs4proc.c:3307:6


   3268 static int _nfs4_do_setattr(struct inode *inode,
   3269                             struct nfs_setattrargs *arg,
   3270                             struct nfs_setattrres *res,
   3271                             const struct cred *cred,
   3272                             struct nfs_open_context *ctx)
   3273 {
   3274         struct nfs_server *server = NFS_SERVER(inode);
   3275         struct rpc_message msg = {
   3276                 .rpc_proc       =
&nfs4_procedures[NFSPROC4_CLNT_SETATTR],
   3277                 .rpc_argp       = arg,
   3278                 .rpc_resp       = res,
   3279                 .rpc_cred       = cred,
   3280         };
   3281         const struct cred *delegation_cred = NULL;
   3282         unsigned long timestamp = jiffies;
   3283         bool truncate;
   3284         int status;
   3285
   3286         nfs_fattr_init(res->fattr);
   3287
   3288         /* Servers should only apply open mode checks for file
size changes */
   3289         truncate = (arg->iap->ia_valid & ATTR_SIZE) ? true : false;
   3290         if (!truncate) {
   3291                 nfs4_inode_make_writeable(inode);
   3292                 goto zero_stateid;
   3293         }
   3294
   3295         if (nfs4_copy_delegation_stateid(inode, FMODE_WRITE,
&arg->stateid, &delegation_cred)) {
   3296                 /* Use that stateid */
   3297         } else if (ctx != NULL && ctx->state) {
   3298                 struct nfs_lock_context *l_ctx;
   3299                 if (!nfs4_valid_open_stateid(ctx->state))
   3300                         return -EBADF;
   3301                 l_ctx = nfs_get_lock_context(ctx);
   3302                 if (IS_ERR(l_ctx))
   3303                         return PTR_ERR(l_ctx);
   3304                 status = nfs4_select_rw_stateid(ctx->state,
FMODE_WRITE, l_ctx,
   3305                                                 &arg->stateid,
&delegation_cred);
   3306                 nfs_put_lock_context(l_ctx);
   3307                 if (status == -EIO)
   3308                         return -EBADF;




> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

