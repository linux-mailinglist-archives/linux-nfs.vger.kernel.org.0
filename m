Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A25E3BA8C2
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jul 2021 14:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhGCMsN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Jul 2021 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhGCMsN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 3 Jul 2021 08:48:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF57C061762
        for <linux-nfs@vger.kernel.org>; Sat,  3 Jul 2021 05:45:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v20so20992744eji.10
        for <linux-nfs@vger.kernel.org>; Sat, 03 Jul 2021 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jt0fAtpNTB+JWnIDFQUOJ7qxzMusYFcu6poy4CsU+c=;
        b=TIqcQ4svfXRL/fWZa0jBCg9jpMVJno3nE/7HopVchaOpNm/sbpzy3KhWW0CrOiAaC/
         mNShzeNXkFXe0ddc9cjj3N2Uu5IVjYj/KK+Ke+LslRRkvMhMrPpSYFMrVGE+CC4cac/L
         8ggyG07hlOAjhdfTa9SJdCGLNdATqiPv+7+pl4Egw3Cc3UBThbPuX3mJ6Ih3w4NCFCf9
         Nfq64HC6j8z8LiJoR0qPBYpXkFd5UAeTGkw/WKkwOi7P05saPuI7228w2bZe7H9oV0BQ
         ppTn2kbT/7PZPIm3GYvoX70k/odhrxxHCuvD40ccyzuLyS6tA9uC/qJezTyUwx1CBK+q
         y7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jt0fAtpNTB+JWnIDFQUOJ7qxzMusYFcu6poy4CsU+c=;
        b=JitdfOUQYFoGEEdKuwCySKBrRQI9/D1uYGZq0E8ccycMuLtIyi2GLsXSvETTSY9per
         2qKRJNx7xgCRRN9Io44MmvVPqhYL+xmVFaIUDqHyP1ze4+LkwbVzIMr/MC8hlaSOjRMt
         BV8CbtJXypvD/TekBrd4AGL1KM7x5DorFFWC/6tipajzDLEA/RDEhMWLqIQsc+QIfNiw
         LpohPIyJcLTslz3jJ22NILSB6VmLrMzFxAm5NYPIxMt/nXXYuMTjSUJtq/gXeVnE+HJu
         M+vDpODXnFnjB0ezWf15QakMpPPvHNznOEUg/E/+MwHa0eovFPVGknvu8NAPa3R+10hm
         w15g==
X-Gm-Message-State: AOAM531uyJJUCv25uq/K+OfJ6G03w1fhZrETdk2FE0ufSBRr4igkUrol
        ZRZY9kAvrJTYcGJMcOK7hJuBaY1yz5ji/7BG4j+EZw==
X-Google-Smtp-Source: ABdhPJzY24pFDH6ysUpNeQu8UewqUX4boDmC0CfY3KICAWzQEwYESMMlNpQ6DKCvBipQpGHW0bmXQcgFWKk8nsbhIew=
X-Received: by 2002:a17:906:3a0e:: with SMTP id z14mr4592365eje.289.1625316337435;
 Sat, 03 Jul 2021 05:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <162458475606.28671.1835069742861755259@noble.neil.brown.name>
 <162510089174.7211.449831430943803791@noble.neil.brown.name>
 <CAPt2mGMgCHwvmy2MA4c2E316xVYPiRy4pRdcX4-1EAALfcxz+A@mail.gmail.com> <162513954601.3001.5763461156445846045@noble.neil.brown.name>
In-Reply-To: <162513954601.3001.5763461156445846045@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Sat, 3 Jul 2021 13:45:01 +0100
Message-ID: <CAPt2mGNCV7Sh0uXA0ihpuSVcecXW=5cMUAfiS0tYr_cTQ0Du8w@mail.gmail.com>
Subject: Re: [PATCH/rfc v2] NFS: introduce NFS namespaces.
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Neil,

Thanks for the pointers. I'm going to try and do some more testing on
the slot table/queue/priority "issue" next week and hopefully that
will be useful in figuring out what is going on exactly.

I would also like to test these patches as part of that, but applying
them on top on 5.13-rc7 I'm seeing some instability. I sometimes see
it when mounting a filesystem, but I consistently see it when
unmounting.

# mount -o vers=4.2 server1:/usr /mnt/server1
# umount /mnt/server1

I do have a couple of other patches applied but they have been stable
up until now. I'm also running nfs-utils v2.5.4 in case that has any
bearing.

Daire

[  360.481824] ------------[ cut here ]------------
[  360.483141] kernel BUG at mm/slub.c:4205!
[  360.484233] invalid opcode: 0000 [#1] SMP PTI
[  360.485392] CPU: 6 PID: 3040 Comm: umount.nfs4 Not tainted
5.13.0-1.dneg.x86_64 #1
[  360.487050] Hardware name: Red Hat dneg, BIOS
1.11.1-4.module_el8.2.0+320+13f867d7 04/01/2014
[  360.488847] RIP: 0010:kfree+0x21a/0x260
[  360.489549] Code: e2 f7 da e8 c8 ca 01 00 41 f7 c5 00 02 00 00 75
3b 44 89 f6 4c 89 e7 e8 e4 47 fd ff e9 f6 fe ff ff 49 8b 44 24 08 a8
01 75 b3 <0f> 0b 48 8b 55 c8 4d 89 f9 41 b8 01 00 00 00 4c 89 e9 4c 89
e6 4c
[  360.492431] RSP: 0018:ffffb4a400357d58 EFLAGS: 00010246
[  360.493320] RAX: ffffdddc0d370108 RBX: ffff8da90acf1c80 RCX: 00000000000005dc
[  360.494484] RDX: 0000000000000000 RSI: ffffffffa224fdb7 RDI: ffffffffc0c04957
[  360.495629] RBP: ffffb4a400357d90 R08: ffff8da900042300 R09: ffff8da907fcb1e8
[  360.496706] R10: ffff8da90bbd80d0 R11: ffff8dad2bbac7f0 R12: ffffdddc0d370100
[  360.497677] R13: ffffffffc0c04957 R14: 0000000000000000 R15: ffff8da907fcb100
[  360.498603] FS:  00007fb32ea1c880(0000) GS:ffff8dad2bb80000(0000)
knlGS:0000000000000000
[  360.499681] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  360.500465] CR2: 00007fb32ea4c000 CR3: 0000000101392006 CR4: 0000000000370ee0
[  360.501436] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  360.502408] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  360.503385] Call Trace:
[  360.503738]  kfree_const+0x17/0x30
[  360.504217]  nfs_free_client+0x85/0xb0 [nfs]
[  360.504905]  nfs4_free_client+0x85/0xc0 [nfsv4]
[  360.505542]  nfs_put_client.part.0+0xf1/0x110 [nfs]
[  360.506250]  nfs_free_server+0x5c/0xb0 [nfs]
[  360.506829]  nfs_kill_super+0x32/0x50 [nfs]
[  360.507409]  deactivate_locked_super+0x3b/0x80
[  360.508027]  deactivate_super+0x3e/0x50
[  360.508558]  cleanup_mnt+0x109/0x160
[  360.509052]  __cleanup_mnt+0x12/0x20
[  360.509541]  task_work_run+0x70/0xb0
[  360.510033]  exit_to_user_mode_prepare+0x23d/0x250
[  360.510673]  syscall_exit_to_user_mode+0x1d/0x40
[  360.511306]  do_syscall_64+0x4d/0x80
[  360.511786]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  360.512436] RIP: 0033:0x7fb32ded70c7
[  360.512917] Code: 7d 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f
44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 79 7d 2c 00 f7 d8 64 89
01 48
[  360.515270] RSP: 002b:00007ffc052dad88 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[  360.516237] RAX: 0000000000000000 RBX: 0000000000b61010 RCX: 00007fb32ded70c7
[  360.518019] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000b61710
[  360.519520] RBP: 0000000000b61710 R08: 0000000000000000 R09: 000000000000000f
[  360.521008] R10: 00007ffc052da7e0 R11: 0000000000000246 R12: 00007fb32e601d58
[  360.522506] R13: 0000000000000000 R14: 0000000000b611e0 R15: 0000000000000000
[  360.523989] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
nfsv3 nfs tcp_diag inet_diag nfsd auth_rpcgss nfs_acl lockd grace
cachefiles fscache netfs ext4 mbcache jbd2 sb_edac kvm_intel kvm
irqbypass bochs_drm drd
[  360.536012] ---[ end trace a3cd0418a0940440 ]---
[  360.537310] RIP: 0010:kfree+0x21a/0x260
[  360.538499] Code: e2 f7 da e8 c8 ca 01 00 41 f7 c5 00 02 00 00 75
3b 44 89 f6 4c 89 e7 e8 e4 47 fd ff e9 f6 fe ff ff 49 8b 44 24 08 a8
01 75 b3 <0f> 0b 48 8b 55 c8 4d 89 f9 41 b8 01 00 00 00 4c 89 e9 4c 89
e6 4c
[  360.542278] RSP: 0018:ffffb4a400357d58 EFLAGS: 00010246
[  360.543661] RAX: ffffdddc0d370108 RBX: ffff8da90acf1c80 RCX: 00000000000005dc
[  360.545317] RDX: 0000000000000000 RSI: ffffffffa224fdb7 RDI: ffffffffc0c04957
[  360.546919] RBP: ffffb4a400357d90 R08: ffff8da900042300 R09: ffff8da907fcb1e8
[  360.548535] R10: ffff8da90bbd80d0 R11: ffff8dad2bbac7f0 R12: ffffdddc0d370100
[  360.550137] R13: ffffffffc0c04957 R14: 0000000000000000 R15: ffff8da907fcb100
[  360.551744] FS:  00007fb32ea1c880(0000) GS:ffff8dad2bb80000(0000)
knlGS:0000000000000000
[  360.553530] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  360.555041] CR2: 00007fb32ea4c000 CR3: 0000000101392006 CR4: 0000000000370ee0
[  360.556740] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  360.558406] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  360.560098] Kernel panic - not syncing: Fatal exception
[  360.561778] Kernel Offset: 0x21000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  360.563836] ---[ end Kernel panic - not syncing: Fatal exception ]---

On Thu, 1 Jul 2021 at 12:39, NeilBrown <neilb@suse.de> wrote:
>
> On Thu, 01 Jul 2021, Daire Byrne wrote:
> > Neil,
> >
> > I'm curious about these patches but lack enough knowledge to say
> > definitively if this would also mean a separate slot table/queue for
> > requests per namespace mount too? In a similar fashion to Olga's
> > recent patches and multi-homed servers?
>
> Yes, it would mean a separate slot table and queues.  A completely
> separate TCP connections.  Nothing is shared between two mounts in different
> NFS namespaces.
>
> >
> > I'm just wondering if this could also help with the problem described
> > in this thread:
> >
> > https://marc.info/?t=160199739400001&r=2&w=4
>
> Not really a good fit for that problem.
>
> >
> > The original issue described was how a high read/write process on the
> > client could slow another process trying to do heavy metadata
> > operations (like walking the filesystem). Using a different mount to
> > the same multi-homed server seems to help a lot (probably because of
> > the independent slot table).
>
> "probably" sounds a bit like a wild guess :-) We really need some
> measurements to understand the problem.  Easier said that done.
>
> It could be that the slot table is too small for your workload, and
> making it bigger would be as good as having two of them.
> If could be that this is a queuing fairness problem.  There is a strong
> tradition of allowing synchronous IO - particularly for metadata - to
> have a higher priority than async IO.  Linux NFS does use a lower
> priority for async writes and a higher priority for memory-reclaim
> writes, but doesn't appear to preference metadata requests.
>
> The size of the slot table for NFSv4.1 and later is managed by the NFS
> layer, and negotiated with the server.  Linux client asks for 1024,
> Linux server allows 160 (I think).
>
> If you have a different server, you might get a different result.
> With 1024 slots, you might be at risk of "buffer bloat" where slow
> request can fill the queue and cause a large delay for other requests.
>
> A fairly easy experiment that might be worth trying is, while
> a problematic IO pattern is happening, disable rpc debugging (you don't
> need to enable it first).
>    rpcdebug -m rpc -c all
>
> This has a side-effect of listing all tasks which are waiting on an RPC
> queue.  If you see a lot of tasks queued on "ForeChannel Slot table",
> that confirms they are waiting for an NFSv4.1 slot.  If, instead, you
> see lots on "xprt_pending", then they are waiting for a reply, so the
> bottle neck must be elsewhere.
>
> You should also be able to see the mix of requests that are queued,
> which might be interesting.
>
> >
> > And my particular interest in the problem was that a re-export server
> > similarly could get bogged down by high read/write throughput such
> > that clients needing to do heavy metadata became backlogged (where
> > nfsds are the client processes).
> >
> > So could I mount a remote server 10 times (say) and in effect have 10
> > different processes accessing each one such that I could better
> > parallelise the requests?
>
> I guess that might work.  It would allow you come control over queuing,
> though having too many mounts might lead to other problem.  One for each
> priority group, and keep the number of groups small.
>
> >
> > I'm also curious about the interaction with fscache - will that see
> > each namespace mount to the same server export as a different
> > filesystem and create a new independant cache for each?
>
> I suspect fscache would see them as all separate independent mounts.
>
> >
> > I should just go away and test it shouldn't I ... ;)
>
> :-)
>
> NeilBrown
>
>
> >
> > Daire
> >
> >
> > On Thu, 1 Jul 2021 at 01:55, NeilBrown <neilb@suse.de> wrote:
> > >
> > >
> > > When there are multiple NFS mounts from the same server using the same
> > > NFS version and the same security parameters, various other mount
> > > parameters are forcibly shared, causing the parameter requests on
> > > subsequent mounts to be ignored.  This includes nconnect, fsc, and
> > > others.
> > >
> > > It is possible to avoid this sharing by creating a separate network
> > > namespace for the new connections, but this can often be overly
> > > burdensome.  This patch introduces the concept of "NFS namespaces" which
> > > allows one group of NFS mounts to be completely separate from others
> > > without the need for a completely separate network namespace.
> > >
> > > Use cases for this include:
> > >  - major applications with different tuning recommendations.  Often the
> > >    support organisation for a particular application will require known
> > >    configuration options to be used before a support request can be
> > >    considered.  If two applications use (different mounts from) the same
> > >    NFS server but require different configuration, this is currently
> > >    awkward.
> > >  - data policy restrictions.  Use of fscache on one directory might be
> > >    forbidden by local policy, while use on another might be permitted
> > >    and beneficial.
> > >  - testing for problem diagnosis.  When an NFS mount is exhibiting
> > >    problems it can be useful information to see if a second mount will
> > >    suffer the same problems.  I've seen two separate cases recently with
> > >    TCP-level problems where the initial diagnosis couldn't make this test
> > >    as the TCP connection would be shared.  Allowing completely independent
> > >    mounts would make this easier.
> > >
> > > The NFS namespace concept addresses each of these needs.
> > >
> > > A new mount option "namespace=" is added.  Any two mounts with different
> > > namespace settings are treated as through there were to different
> > > servers.  If no "namespace=" is given, then the empty string is used as
> > > the namespace for comparisons.  Possible usages might be
> > > "namespace=application_name" or "namespace=mustnotcache" or
> > > "namespace=testing".
> > >
> > > The namespace - if given - is included in the client identity string so
> > > that the NFSv4 server will see two different mount groups as though from
> > > separate clients.
> > >
> > > A few white-space inconsistencies nearby changed code have been
> > > rectified.
> > >
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >
> > > Only change since V1 is a minor code fix from Dan Carpenter.
> > >
> > >  fs/nfs/client.c           | 20 ++++++++++++++++++--
> > >  fs/nfs/fs_context.c       | 11 ++++++++++-
> > >  fs/nfs/internal.h         |  2 ++
> > >  fs/nfs/nfs3client.c       |  1 +
> > >  fs/nfs/nfs4client.c       | 15 ++++++++++++++-
> > >  fs/nfs/nfs4proc.c         | 28 ++++++++++++++++++++--------
> > >  fs/nfs/super.c            |  5 +++++
> > >  include/linux/nfs_fs_sb.h |  4 ++--
> > >  8 files changed, 72 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > > index 330f65727c45..f6f06ea649bc 100644
> > > --- a/fs/nfs/client.c
> > > +++ b/fs/nfs/client.c
> > > @@ -173,6 +173,13 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
> > >                 if (!clp->cl_hostname)
> > >                         goto error_cleanup;
> > >         }
> > > +       if (cl_init->namespace && *cl_init->namespace) {
> > > +               err = -ENOMEM;
> > > +               clp->cl_namespace = kstrdup(cl_init->namespace, GFP_KERNEL);
> > > +               if (!clp->cl_namespace)
> > > +                       goto error_cleanup;
> > > +       } else
> > > +               clp->cl_namespace = "";
> > >
> > >         INIT_LIST_HEAD(&clp->cl_superblocks);
> > >         clp->cl_rpcclient = ERR_PTR(-EINVAL);
> > > @@ -187,6 +194,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
> > >         return clp;
> > >
> > >  error_cleanup:
> > > +       kfree_const(clp->cl_hostname);
> > >         put_nfs_version(clp->cl_nfs_mod);
> > >  error_dealloc:
> > >         kfree(clp);
> > > @@ -247,6 +255,7 @@ void nfs_free_client(struct nfs_client *clp)
> > >         put_nfs_version(clp->cl_nfs_mod);
> > >         kfree(clp->cl_hostname);
> > >         kfree(clp->cl_acceptor);
> > > +       kfree_const(clp->cl_namespace);
> > >         kfree(clp);
> > >  }
> > >  EXPORT_SYMBOL_GPL(nfs_free_client);
> > > @@ -288,7 +297,7 @@ static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *dat
> > >
> > >  again:
> > >         list_for_each_entry(clp, &nn->nfs_client_list, cl_share_link) {
> > > -               const struct sockaddr *clap = (struct sockaddr *)&clp->cl_addr;
> > > +               const struct sockaddr *clap = (struct sockaddr *)&clp->cl_addr;
> > >                 /* Don't match clients that failed to initialise properly */
> > >                 if (clp->cl_cons_state < 0)
> > >                         continue;
> > > @@ -320,11 +329,17 @@ static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *dat
> > >                     test_bit(NFS_CS_DS, &clp->cl_flags))
> > >                         continue;
> > >
> > > +               /* If admin has asked for different namespaces for these mounts,
> > > +                * don't share the client.
> > > +                */
> > > +               if (strcmp(clp->cl_namespace, data->namespace ?: "") != 0)
> > > +                       continue;
> > > +
> > >                 /* Match the full socket address */
> > >                 if (!rpc_cmp_addr_port(sap, clap))
> > >                         /* Match all xprt_switch full socket addresses */
> > >                         if (IS_ERR(clp->cl_rpcclient) ||
> > > -                            !rpc_clnt_xprt_switch_has_addr(clp->cl_rpcclient,
> > > +                           !rpc_clnt_xprt_switch_has_addr(clp->cl_rpcclient,
> > >                                                            sap))
> > >                                 continue;
> > >
> > > @@ -676,6 +691,7 @@ static int nfs_init_server(struct nfs_server *server,
> > >                 .timeparms = &timeparms,
> > >                 .cred = server->cred,
> > >                 .nconnect = ctx->nfs_server.nconnect,
> > > +               .namespace = ctx->namespace,
> > >                 .init_flags = (1UL << NFS_CS_REUSEPORT),
> > >         };
> > >         struct nfs_client *clp;
> > > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > > index d95c9a39bc70..7c644a31d304 100644
> > > --- a/fs/nfs/fs_context.c
> > > +++ b/fs/nfs/fs_context.c
> > > @@ -59,6 +59,7 @@ enum nfs_param {
> > >         Opt_mountproto,
> > >         Opt_mountvers,
> > >         Opt_namelen,
> > > +       Opt_namespace,
> > >         Opt_nconnect,
> > >         Opt_port,
> > >         Opt_posix,
> > > @@ -156,6 +157,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
> > >         fsparam_u32   ("mountport",     Opt_mountport),
> > >         fsparam_string("mountproto",    Opt_mountproto),
> > >         fsparam_u32   ("mountvers",     Opt_mountvers),
> > > +       fsparam_string("namespace",     Opt_namespace),
> > >         fsparam_u32   ("namlen",        Opt_namelen),
> > >         fsparam_u32   ("nconnect",      Opt_nconnect),
> > >         fsparam_string("nfsvers",       Opt_vers),
> > > @@ -824,7 +826,13 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
> > >                         goto out_invalid_value;
> > >                 }
> > >                 break;
> > > -
> > > +       case Opt_namespace:
> > > +               if (strpbrk(param->string, " \n\t,"))
> > > +                       goto out_invalid_value;
> > > +               kfree(ctx->namespace);
> > > +               ctx->namespace = param->string;
> > > +               param->string = NULL;
> > > +               break;
> > >                 /*
> > >                  * Special options
> > >                  */
> > > @@ -1462,6 +1470,7 @@ static void nfs_fs_context_free(struct fs_context *fc)
> > >                 kfree(ctx->nfs_server.export_path);
> > >                 kfree(ctx->nfs_server.hostname);
> > >                 kfree(ctx->fscache_uniq);
> > > +               kfree(ctx->namespace);
> > >                 nfs_free_fhandle(ctx->mntfh);
> > >                 nfs_free_fattr(ctx->clone_data.fattr);
> > >                 kfree(ctx);
> > > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > > index a36af04188c2..2010492b856a 100644
> > > --- a/fs/nfs/internal.h
> > > +++ b/fs/nfs/internal.h
> > > @@ -62,6 +62,7 @@ struct nfs_client_initdata {
> > >         const struct sockaddr *addr;            /* Address of the server */
> > >         const char *nodename;                   /* Hostname of the client */
> > >         const char *ip_addr;                    /* IP address of the client */
> > > +       const char *namespace;                  /* NFS namespace */
> > >         size_t addrlen;
> > >         struct nfs_subversion *nfs_mod;
> > >         int proto;
> > > @@ -97,6 +98,7 @@ struct nfs_fs_context {
> > >         unsigned short          protofamily;
> > >         unsigned short          mountfamily;
> > >         bool                    has_sec_mnt_opts;
> > > +       const char              *namespace;
> > >
> > >         struct {
> > >                 union {
> > > diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
> > > index 5601e47360c2..61ad13e1b041 100644
> > > --- a/fs/nfs/nfs3client.c
> > > +++ b/fs/nfs/nfs3client.c
> > > @@ -93,6 +93,7 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
> > >                 .net = mds_clp->cl_net,
> > >                 .timeparms = &ds_timeout,
> > >                 .cred = mds_srv->cred,
> > > +               .namespace = mds_clp->cl_namespace,
> > >         };
> > >         struct nfs_client *clp;
> > >         char buf[INET6_ADDRSTRLEN + 1];
> > > diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> > > index 42719384e25f..7dbc521275ff 100644
> > > --- a/fs/nfs/nfs4client.c
> > > +++ b/fs/nfs/nfs4client.c
> > > @@ -500,6 +500,12 @@ static int nfs4_match_client(struct nfs_client  *pos,  struct nfs_client *new,
> > >         if (pos->cl_minorversion != new->cl_minorversion)
> > >                 return 1;
> > >
> > > +       /* If admin has asked for different namespaces for these mounts,
> > > +        * don't share the client.
> > > +        */
> > > +       if (strcmp(pos->cl_namespace, new->cl_namespace) != 0)
> > > +               return 1;
> > > +
> > >         /* If "pos" isn't marked ready, we can't trust the
> > >          * remaining fields in "pos", especially the client
> > >          * ID and serverowner fields.  Wait for CREATE_SESSION
> > > @@ -863,6 +869,7 @@ static int nfs4_set_client(struct nfs_server *server,
> > >                 const char *ip_addr,
> > >                 int proto, const struct rpc_timeout *timeparms,
> > >                 u32 minorversion, unsigned int nconnect,
> > > +               const char *namespace,
> > >                 struct net *net)
> > >  {
> > >         struct nfs_client_initdata cl_init = {
> > > @@ -873,6 +880,7 @@ static int nfs4_set_client(struct nfs_server *server,
> > >                 .nfs_mod = &nfs_v4,
> > >                 .proto = proto,
> > >                 .minorversion = minorversion,
> > > +               .namespace = namespace,
> > >                 .net = net,
> > >                 .timeparms = timeparms,
> > >                 .cred = server->cred,
> > > @@ -940,6 +948,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
> > >                 .nfs_mod = &nfs_v4,
> > >                 .proto = ds_proto,
> > >                 .minorversion = minor_version,
> > > +               .namespace = mds_clp->cl_namespace,
> > >                 .net = mds_clp->cl_net,
> > >                 .timeparms = &ds_timeout,
> > >                 .cred = mds_srv->cred,
> > > @@ -1120,6 +1129,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
> > >                                 &timeparms,
> > >                                 ctx->minorversion,
> > >                                 ctx->nfs_server.nconnect,
> > > +                               ctx->namespace,
> > >                                 fc->net_ns);
> > >         if (error < 0)
> > >                 return error;
> > > @@ -1209,6 +1219,7 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
> > >                                 parent_server->client->cl_timeout,
> > >                                 parent_client->cl_mvops->minor_version,
> > >                                 parent_client->cl_nconnect,
> > > +                               parent_client->cl_namespace,
> > >                                 parent_client->cl_net);
> > >         if (!error)
> > >                 goto init_server;
> > > @@ -1224,6 +1235,7 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
> > >                                 parent_server->client->cl_timeout,
> > >                                 parent_client->cl_mvops->minor_version,
> > >                                 parent_client->cl_nconnect,
> > > +                               parent_client->cl_namespace,
> > >                                 parent_client->cl_net);
> > >         if (error < 0)
> > >                 goto error;
> > > @@ -1321,7 +1333,8 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
> > >         error = nfs4_set_client(server, hostname, sap, salen, buf,
> > >                                 clp->cl_proto, clnt->cl_timeout,
> > >                                 clp->cl_minorversion,
> > > -                               clp->cl_nconnect, net);
> > > +                               clp->cl_nconnect,
> > > +                               clp->cl_namespace, net);
> > >         clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
> > >         if (error != 0) {
> > >                 nfs_server_insert_lists(server);
> > > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > > index e653654c10bc..5f5caf26397c 100644
> > > --- a/fs/nfs/nfs4proc.c
> > > +++ b/fs/nfs/nfs4proc.c
> > > @@ -6191,6 +6191,8 @@ nfs4_init_nonuniform_client_string(struct nfs_client *clp)
> > >                 strlen(rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR)) +
> > >                 1;
> > >         rcu_read_unlock();
> > > +       if (*clp->cl_namespace)
> > > +               len += strlen(clp->cl_namespace) + 1;
> > >
> > >         buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
> > >         if (buflen)
> > > @@ -6210,15 +6212,19 @@ nfs4_init_nonuniform_client_string(struct nfs_client *clp)
> > >
> > >         rcu_read_lock();
> > >         if (buflen)
> > > -               scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s",
> > > +               scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s%s%s",
> > >                           clp->cl_rpcclient->cl_nodename, buf,
> > >                           rpc_peeraddr2str(clp->cl_rpcclient,
> > > -                                          RPC_DISPLAY_ADDR));
> > > +                                          RPC_DISPLAY_ADDR),
> > > +                         *clp->cl_namespace ? "/" : "",
> > > +                         clp->cl_namespace);
> > >         else
> > > -               scnprintf(str, len, "Linux NFSv4.0 %s/%s",
> > > +               scnprintf(str, len, "Linux NFSv4.0 %s/%s%s%s",
> > >                           clp->cl_rpcclient->cl_nodename,
> > >                           rpc_peeraddr2str(clp->cl_rpcclient,
> > > -                                          RPC_DISPLAY_ADDR));
> > > +                                          RPC_DISPLAY_ADDR),
> > > +                         *clp->cl_namespace ? "/" : "",
> > > +                         clp->cl_namespace);
> > >         rcu_read_unlock();
> > >
> > >         clp->cl_owner_id = str;
> > > @@ -6238,6 +6244,8 @@ nfs4_init_uniform_client_string(struct nfs_client *clp)
> > >
> > >         len = 10 + 10 + 1 + 10 + 1 +
> > >                 strlen(clp->cl_rpcclient->cl_nodename) + 1;
> > > +       if (*clp->cl_namespace)
> > > +               len += strlen(clp->cl_namespace) + 1;
> > >
> > >         buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
> > >         if (buflen)
> > > @@ -6256,13 +6264,17 @@ nfs4_init_uniform_client_string(struct nfs_client *clp)
> > >                 return -ENOMEM;
> > >
> > >         if (buflen)
> > > -               scnprintf(str, len, "Linux NFSv%u.%u %s/%s",
> > > +               scnprintf(str, len, "Linux NFSv%u.%u %s/%s%s%s",
> > >                           clp->rpc_ops->version, clp->cl_minorversion,
> > > -                         buf, clp->cl_rpcclient->cl_nodename);
> > > +                         buf, clp->cl_rpcclient->cl_nodename,
> > > +                         *clp->cl_namespace ? "/" : "",
> > > +                         clp->cl_namespace);
> > >         else
> > > -               scnprintf(str, len, "Linux NFSv%u.%u %s",
> > > +               scnprintf(str, len, "Linux NFSv%u.%u %s%s%s",
> > >                           clp->rpc_ops->version, clp->cl_minorversion,
> > > -                         clp->cl_rpcclient->cl_nodename);
> > > +                         clp->cl_rpcclient->cl_nodename,
> > > +                         *clp->cl_namespace ? "/" : "",
> > > +                         clp->cl_namespace);
> > >         clp->cl_owner_id = str;
> > >         return 0;
> > >  }
> > > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > > index fe58525cfed4..ea59248b64d1 100644
> > > --- a/fs/nfs/super.c
> > > +++ b/fs/nfs/super.c
> > > @@ -479,6 +479,8 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
> > >         rcu_read_unlock();
> > >         if (clp->cl_nconnect > 0)
> > >                 seq_printf(m, ",nconnect=%u", clp->cl_nconnect);
> > > +       if (*clp->cl_namespace)
> > > +               seq_printf(m, ",namespace=%s", clp->cl_namespace);
> > >         if (version == 4) {
> > >                 if (nfss->port != NFS_PORT)
> > >                         seq_printf(m, ",port=%u", nfss->port);
> > > @@ -1186,6 +1188,9 @@ static int nfs_compare_super(struct super_block *sb, struct fs_context *fc)
> > >         /* Note: NFS_MOUNT_UNSHARED == NFS4_MOUNT_UNSHARED */
> > >         if (old->flags & NFS_MOUNT_UNSHARED)
> > >                 return 0;
> > > +       if (strcmp(old->nfs_client->cl_namespace,
> > > +                  server->nfs_client->cl_namespace) != 0)
> > > +               return 0;
> > >         if (memcmp(&old->fsid, &server->fsid, sizeof(old->fsid)) != 0)
> > >                 return 0;
> > >         if (!nfs_compare_userns(old, server))
> > > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > > index d71a0e90faeb..c62db98f3c04 100644
> > > --- a/include/linux/nfs_fs_sb.h
> > > +++ b/include/linux/nfs_fs_sb.h
> > > @@ -62,8 +62,8 @@ struct nfs_client {
> > >
> > >         u32                     cl_minorversion;/* NFSv4 minorversion */
> > >         unsigned int            cl_nconnect;    /* Number of connections */
> > > -       const char *            cl_principal;  /* used for machine cred */
> > > -
> > > +       const char *            cl_principal;   /* used for machine cred */
> > > +       const char *            cl_namespace;   /* used for NFS namespaces */
> > >  #if IS_ENABLED(CONFIG_NFS_V4)
> > >         struct list_head        cl_ds_clients; /* auth flavor data servers */
> > >         u64                     cl_clientid;    /* constant */
> > > --
> > > 2.32.0
> > >
> >
> >
