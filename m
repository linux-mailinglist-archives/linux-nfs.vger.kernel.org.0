Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978683BDB4B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jul 2021 18:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhGFQZf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Jul 2021 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhGFQZf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Jul 2021 12:25:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080C0C061760
        for <linux-nfs@vger.kernel.org>; Tue,  6 Jul 2021 09:22:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b2so35082070ejg.8
        for <linux-nfs@vger.kernel.org>; Tue, 06 Jul 2021 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJuUPcBCTjAlA8tDJURt8bM5CAt/xsvip+FFHWSG6+o=;
        b=WYwXz7Cx2mgI+ClUwinL7jh4HkLYnKXsYULIaXvTz8ZtdaXbwZ3QFjUqzLk+IeeNFQ
         TqEYHFrlje4thTWGwvoWiz+tuJuxQL19H2zkZwsTW3SV0j36wxfUSI+DEZSDF7Ig7FEB
         OQz/c80nR48hdXZ5GJ1tVLZdUtjEuy6JvL8E7CLEZTJkqUO6MNj8QViPm9caNPdEQgBb
         HuuBxkoG01vb8Koed5to0Xpgg9JXbAUck3sw0QeyLJZk1ee++PsCmap9RDW/WHSO1DzI
         Zs+r922VO8H1bCijNORYdgisRe92+uo8ccPBfiDuZ1IeFo/fh3syDjwIGJcu3zvJaInK
         8CLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJuUPcBCTjAlA8tDJURt8bM5CAt/xsvip+FFHWSG6+o=;
        b=EIndVtFwN1C0Pd61t/yByCWi/w+RfRyjPLj9XBrlJH/YVKnWfiEJOS7euLru8aHW/w
         O46AKep5truWYk2OOSTSXNqZuWVjIrBoz3xBsEXZ3TSKglWHUT1OG4SgcIst9yA+yxWv
         cvClgrmXM0IVrXnbdFPOfI/zAMMuUDaBPpYTdWMo126EmWCzbeHI+xQygipQqa8UHUua
         EVwH/2pr1a1Q/WnQ9cDYSqIlSwek2CvHexV4OJ2kUKHiaXYWsdDCZ4TNLvQppRq2wWtK
         mGPQyrPF7Z/iXQOpZYH9Kx+aW0SSOoh2iqP0Nx8Uyi3tF7t5e+GYZ6ue+DdAXy1sWNJn
         n2dA==
X-Gm-Message-State: AOAM530kjC+JQoQS2iXUyM3Y2zGEfcxFEXtA5aXjDNIdlKdKH/NoYVdY
        h8FQnutwG7dQzaioBWneKgq4oShujzM8wh5P5da/6A==
X-Google-Smtp-Source: ABdhPJyGtwhk3naKMHoqjNOpOTDbVqvrs1/Vp40HVMe+bmCONgCcu4N4ZiTGCe/R+KYBgclGeErUrQl20EoYHQB5SGs=
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr19028811ejb.170.1625588574343;
 Tue, 06 Jul 2021 09:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <162458475606.28671.1835069742861755259@noble.neil.brown.name>
 <162510089174.7211.449831430943803791@noble.neil.brown.name>
 <CAPt2mGMgCHwvmy2MA4c2E316xVYPiRy4pRdcX4-1EAALfcxz+A@mail.gmail.com>
 <162513954601.3001.5763461156445846045@noble.neil.brown.name>
 <CAPt2mGNCV7Sh0uXA0ihpuSVcecXW=5cMUAfiS0tYr_cTQ0Du8w@mail.gmail.com> <162535340922.16506.4184249866230493262@noble.neil.brown.name>
In-Reply-To: <162535340922.16506.4184249866230493262@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Tue, 6 Jul 2021 17:22:17 +0100
Message-ID: <CAPt2mGNOMh0uWozi=L5H6X7aKUuh_+-QxJ7OK9e6ELiKnSh1hg@mail.gmail.com>
Subject: Re: [PATCH/rfc v2] NFS: introduce NFS namespaces.
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 4 Jul 2021 at 00:03, NeilBrown <neilb@suse.de> wrote:
> > [  360.481824] ------------[ cut here ]------------
> > [  360.483141] kernel BUG at mm/slub.c:4205!
>
> Thanks for testing!
>
> It misunderstood the use of kfree_const().  It doesn't work for
> constants in modules, only constants in vmlinux.  So I guess you built
> nfs as a module.
>
> This version should fix that.
>
> Thanks,
> NeilBrown

Yep, that was the issue and the latest patch certainly helped. I ran a
few load tests and everything seemed to be working fine.

However, once I tried mounting the same server again using a different
namespace, I got a different looking crash under moderate load. I am
pretty sure I applied your latest patch correctly, but I'll double
check. I should probably remove some of the other patches I have
applied too.

# mount -o vers=4.2 server:/srv/export /mnt/server1
# mount -o vers=4.2,namespace=server2 server:/srv/export /mnt/server2

[ 3626.638077] general protection fault, probably for non-canonical
address 0x375f656c6966ff00: 0000 [#1] SMP PTI
[ 3626.640538] CPU: 9 PID: 12053 Comm: ls Not tainted 5.13.0-1.dneg.x86_64 #1
[ 3626.642270] Hardware name: Red Hat dneg, BIOS
1.11.1-4.module_el8.2.0+320+13f867d7 04/01/2014
[ 3626.644443] RIP: 0010:__kmalloc_track_caller+0xfa/0x480
[ 3626.646138] Code: 65 4c 03 05 28 4d d5 69 49 83 78 10 00 4d 8b 20
0f 84 4c 03 00 00 4d 85 e4 0f 84 43 03 00 00 41 8b 47 28 49 8b 3f 48
8d 4a 01 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 bb 41
8b 47
[ 3626.650253] RSP: 0018:ffffaadecf2afb90 EFLAGS: 00010206
[ 3626.651747] RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000003d41
[ 3626.653479] RDX: 0000000000003d40 RSI: 0000000000000cc0 RDI: 000000000002fbe0
[ 3626.655293] RBP: ffffaadecf2afbd0 R08: ffff985aabc6fbe0 R09: ffff985689c76b20
[ 3626.657034] R10: ffff9858408a0000 R11: ffff985966e69ec0 R12: 375f656c6966ff00
[ 3626.658794] R13: 0000000000000000 R14: 0000000000000cc0 R15: ffff985680042200
[ 3626.660585] FS:  00007efd3c25e840(0000) GS:ffff985aabc40000(0000)
knlGS:0000000000000000
[ 3626.662452] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3626.663952] CR2: 00007fe616fb2000 CR3: 0000000115cae005 CR4: 0000000000370ee0
[ 3626.665717] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3626.667413] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3626.669078] Call Trace:
[ 3626.670194]  ? nfs_readdir_add_to_array+0x23/0x110 [nfs]
[ 3626.671683]  kmemdup_nul+0x26/0x60
[ 3626.672844]  nfs_readdir_add_to_array+0x23/0x110 [nfs]
[ 3626.674252]  nfs_readdir_page_filler+0x157/0x820 [nfs]
[ 3626.675666]  nfs_readdir_xdr_to_array+0x2e7/0x380 [nfs]
[ 3626.677123]  nfs_readdir+0x1e7/0x950 [nfs]
[ 3626.678387]  iterate_dir+0xa2/0x1c0
[ 3626.679695]  __x64_sys_getdents+0x81/0x120
[ 3626.680918]  ? compat_fillonedir+0x160/0x160
[ 3626.682225]  do_syscall_64+0x40/0x80
[ 3626.683456]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 3626.684831] RIP: 0033:0x7efd3b7299d5
[ 3626.685997] Code: 83 c7 13 e9 4d b7 fc ff 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 00 41 56 48 63 ff b8 4e 00 00 00 41 55 41 54 55 53 48 89
f3 0f 05 <48> 3d 00 f0 ff ff 77 55 4c 8d 2c 03 49 89 c6 4c 39 eb 73 3d
0f 1f
[ 3626.689846] RSP: 002b:00007ffe3b3704a0 EFLAGS: 00000246 ORIG_RAX:
000000000000004e
[ 3626.691579] RAX: ffffffffffffffda RBX: 0000000000d352b0 RCX: 00007efd3b7299d5
[ 3626.693207] RDX: 0000000000008000 RSI: 0000000000d352b0 RDI: 0000000000000004
[ 3626.694868] RBP: 0000000000d352b0 R08: 0000000000e68fa0 R09: 0000000000e68f90
[ 3626.696545] R10: 0000000000000000 R11: 0000000000000246 R12: fffffffffffffe80
[ 3626.698165] R13: 0000000000000000 R14: 00000000011a24e0 R15: 0000000000000062
[ 3626.699764] Modules linked in: nfsd nfsv3 nfs_acl rpcsec_gss_krb5
auth_rpcgss tcp_diag inet_diag nfsv4 dns_resolver nfs lockd grace
cachefiles fscache netfs ext4 mbcache jbd2 sb_edac kvm_intel kvm
irqbypass bochs_drm drm_vram_helper drm_ttm_helper ttd
[ 3626.712538] ---[ end trace 0ee06b6300c7ea14 ]---
[ 3626.714098] RIP: 0010:__kmalloc_track_caller+0xfa/0x480
[ 3626.715584] Code: 65 4c 03 05 28 4d d5 69 49 83 78 10 00 4d 8b 20
0f 84 4c 03 00 00 4d 85 e4 0f 84 43 03 00 00 41 8b 47 28 49 8b 3f 48
8d 4a 01 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 bb 41
8b 47
[ 3626.720025] RSP: 0018:ffffaadecf2afb90 EFLAGS: 00010206
[ 3626.721567] RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000003d41
[ 3626.723351] RDX: 0000000000003d40 RSI: 0000000000000cc0 RDI: 000000000002fbe0
[ 3626.725021] RBP: ffffaadecf2afbd0 R08: ffff985aabc6fbe0 R09: ffff985689c76b20
[ 3626.726761] R10: ffff9858408a0000 R11: ffff985966e69ec0 R12: 375f656c6966ff00
[ 3626.728572] R13: 0000000000000000 R14: 0000000000000cc0 R15: ffff985680042200
[ 3626.730328] FS:  00007efd3c25e840(0000) GS:ffff985aabc40000(0000)
knlGS:0000000000000000
[ 3626.732264] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3626.733892] CR2: 00007fe616fb2000 CR3: 0000000115cae005 CR4: 0000000000370ee0
[ 3626.735636] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3626.737341] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3626.739043] Kernel panic - not syncing: Fatal exception
[ 3626.740803] Kernel Offset: 0x15000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Daire


> Subject: [PATCH] NFS: introduce NFS namespaces.
>
> When there are multiple NFS mounts from the same server using the same
> NFS version and the same security parameters, various other mount
> parameters are forcibly shared, causing the parameter requests on
> subsequent mounts to be ignored.  This includes nconnect, fsc, and
> others
>
> It is possible to avoid this sharing by creating a separate network
> namespace for the new connections, but this can often be overly
> burdensome.  This patch introduces the concept of "NFS namespaces" which
> allows one group of NFS mounts to be completely separate from others
> without the need for a completely separate network namespace.
>
> Use cases for this include:
>  - major applications with different tuning recommendations.  Often the
>    support organisation for a particular application will require known
>    configuration options to be used before a support request can be
>    considered.  If two applications use (different mounts from) the same
>    NFS server but
>    awkward.
>  - data policy restrictions.  Use of fscache on one directory might be
>    forbidden by local policy, while use on another might be permitted
>    and beneficial.
>  - testing for problem diagnosis.  When an NFS mount is exhibiting
>    problems it can be useful information to see if a second mount will
>    suffer the same problems.  I've seen two separate cases recently with
>    TCP-level problems where the initial diagnosis couldn't make this test
>    as the TCP connection would be shared.  Allowing completely independent
>    mounts would make this easier.
>
> The NFS namespace concept addresses each of these needs.
>
> A new mount option "namespace=" is added.  Any two mounts with different
> namespace settings are treated as through there were to different
> servers.  If no "namespace=" is given, then the empty string is used as
> the namespace for comparisons.  Possible usages might be
> "namespace=application_name" or "namespace=mustnotcache" or
> "namespace=testing".
>
> The namespace - if given - is included in the client identity string so
> that the NFSv4 server will see two different mount groups as though from
> separate clients.
>
> A few white-space inconsistencies nearby changed code have been
> rectified.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfs/client.c           | 21 +++++++++++++++++++--
>  fs/nfs/fs_context.c       | 11 ++++++++++-
>  fs/nfs/internal.h         |  2 ++
>  fs/nfs/nfs3client.c       |  1 +
>  fs/nfs/nfs4client.c       | 15 ++++++++++++++-
>  fs/nfs/nfs4proc.c         | 28 ++++++++++++++++++++--------
>  fs/nfs/super.c            |  5 +++++
>  include/linux/nfs_fs_sb.h |  4 ++--
>  8 files changed, 73 insertions(+), 14 deletions(-)
>
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 330f65727c45..53b11f29e86e 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -173,6 +173,13 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
>                 if (!clp->cl_hostname)
>                         goto error_cleanup;
>         }
> +       err = -ENOMEM;
> +       if (cl_init->namespace && *cl_init->namespace)
> +               clp->cl_namespace = kstrdup(cl_init->namespace, GFP_KERNEL);
> +       else
> +               clp->cl_namespace = "";
> +       if (!clp->cl_namespace)
> +               goto error_cleanup;
>
>         INIT_LIST_HEAD(&clp->cl_superblocks);
>         clp->cl_rpcclient = ERR_PTR(-EINVAL);
> @@ -187,6 +194,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
>         return clp;
>
>  error_cleanup:
> +       kfree(clp->cl_hostname);
>         put_nfs_version(clp->cl_nfs_mod);
>  error_dealloc:
>         kfree(clp);
> @@ -247,6 +255,8 @@ void nfs_free_client(struct nfs_client *clp)
>         put_nfs_version(clp->cl_nfs_mod);
>         kfree(clp->cl_hostname);
>         kfree(clp->cl_acceptor);
> +       if (clp->cl_namespace && *clp->cl_namespace)
> +               kfree(clp->cl_namespace);
>         kfree(clp);
>  }
>  EXPORT_SYMBOL_GPL(nfs_free_client);
> @@ -288,7 +298,7 @@ static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *dat
>
>  again:
>         list_for_each_entry(clp, &nn->nfs_client_list, cl_share_link) {
> -               const struct sockaddr *clap = (struct sockaddr *)&clp->cl_addr;
> +               const struct sockaddr *clap = (struct sockaddr *)&clp->cl_addr;
>                 /* Don't match clients that failed to initialise properly */
>                 if (clp->cl_cons_state < 0)
>                         continue;
> @@ -320,11 +330,17 @@ static struct nfs_client *nfs_match_client(const struct nfs_client_initdata *dat
>                     test_bit(NFS_CS_DS, &clp->cl_flags))
>                         continue;
>
> +               /* If admin has asked for different namespaces for these mounts,
> +                * don't share the client.
> +                */
> +               if (strcmp(clp->cl_namespace, data->namespace ?: "") != 0)
> +                       continue;
> +
>                 /* Match the full socket address */
>                 if (!rpc_cmp_addr_port(sap, clap))
>                         /* Match all xprt_switch full socket addresses */
>                         if (IS_ERR(clp->cl_rpcclient) ||
> -                            !rpc_clnt_xprt_switch_has_addr(clp->cl_rpcclient,
> +                           !rpc_clnt_xprt_switch_has_addr(clp->cl_rpcclient,
>                                                            sap))
>                                 continue;
>
> @@ -676,6 +692,7 @@ static int nfs_init_server(struct nfs_server *server,
>                 .timeparms = &timeparms,
>                 .cred = server->cred,
>                 .nconnect = ctx->nfs_server.nconnect,
> +               .namespace = ctx->namespace,
>                 .init_flags = (1UL << NFS_CS_REUSEPORT),
>         };
>         struct nfs_client *clp;
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index d95c9a39bc70..7c644a31d304 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -59,6 +59,7 @@ enum nfs_param {
>         Opt_mountproto,
>         Opt_mountvers,
>         Opt_namelen,
> +       Opt_namespace,
>         Opt_nconnect,
>         Opt_port,
>         Opt_posix,
> @@ -156,6 +157,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
>         fsparam_u32   ("mountport",     Opt_mountport),
>         fsparam_string("mountproto",    Opt_mountproto),
>         fsparam_u32   ("mountvers",     Opt_mountvers),
> +       fsparam_string("namespace",     Opt_namespace),
>         fsparam_u32   ("namlen",        Opt_namelen),
>         fsparam_u32   ("nconnect",      Opt_nconnect),
>         fsparam_string("nfsvers",       Opt_vers),
> @@ -824,7 +826,13 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
>                         goto out_invalid_value;
>                 }
>                 break;
> -
> +       case Opt_namespace:
> +               if (strpbrk(param->string, " \n\t,"))
> +                       goto out_invalid_value;
> +               kfree(ctx->namespace);
> +               ctx->namespace = param->string;
> +               param->string = NULL;
> +               break;
>                 /*
>                  * Special options
>                  */
> @@ -1462,6 +1470,7 @@ static void nfs_fs_context_free(struct fs_context *fc)
>                 kfree(ctx->nfs_server.export_path);
>                 kfree(ctx->nfs_server.hostname);
>                 kfree(ctx->fscache_uniq);
> +               kfree(ctx->namespace);
>                 nfs_free_fhandle(ctx->mntfh);
>                 nfs_free_fattr(ctx->clone_data.fattr);
>                 kfree(ctx);
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index a36af04188c2..2010492b856a 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -62,6 +62,7 @@ struct nfs_client_initdata {
>         const struct sockaddr *addr;            /* Address of the server */
>         const char *nodename;                   /* Hostname of the client */
>         const char *ip_addr;                    /* IP address of the client */
> +       const char *namespace;                  /* NFS namespace */
>         size_t addrlen;
>         struct nfs_subversion *nfs_mod;
>         int proto;
> @@ -97,6 +98,7 @@ struct nfs_fs_context {
>         unsigned short          protofamily;
>         unsigned short          mountfamily;
>         bool                    has_sec_mnt_opts;
> +       const char              *namespace;
>
>         struct {
>                 union {
> diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
> index 5601e47360c2..61ad13e1b041 100644
> --- a/fs/nfs/nfs3client.c
> +++ b/fs/nfs/nfs3client.c
> @@ -93,6 +93,7 @@ struct nfs_client *nfs3_set_ds_client(struct nfs_server *mds_srv,
>                 .net = mds_clp->cl_net,
>                 .timeparms = &ds_timeout,
>                 .cred = mds_srv->cred,
> +               .namespace = mds_clp->cl_namespace,
>         };
>         struct nfs_client *clp;
>         char buf[INET6_ADDRSTRLEN + 1];
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 42719384e25f..7dbc521275ff 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -500,6 +500,12 @@ static int nfs4_match_client(struct nfs_client  *pos,  struct nfs_client *new,
>         if (pos->cl_minorversion != new->cl_minorversion)
>                 return 1;
>
> +       /* If admin has asked for different namespaces for these mounts,
> +        * don't share the client.
> +        */
> +       if (strcmp(pos->cl_namespace, new->cl_namespace) != 0)
> +               return 1;
> +
>         /* If "pos" isn't marked ready, we can't trust the
>          * remaining fields in "pos", especially the client
>          * ID and serverowner fields.  Wait for CREATE_SESSION
> @@ -863,6 +869,7 @@ static int nfs4_set_client(struct nfs_server *server,
>                 const char *ip_addr,
>                 int proto, const struct rpc_timeout *timeparms,
>                 u32 minorversion, unsigned int nconnect,
> +               const char *namespace,
>                 struct net *net)
>  {
>         struct nfs_client_initdata cl_init = {
> @@ -873,6 +880,7 @@ static int nfs4_set_client(struct nfs_server *server,
>                 .nfs_mod = &nfs_v4,
>                 .proto = proto,
>                 .minorversion = minorversion,
> +               .namespace = namespace,
>                 .net = net,
>                 .timeparms = timeparms,
>                 .cred = server->cred,
> @@ -940,6 +948,7 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
>                 .nfs_mod = &nfs_v4,
>                 .proto = ds_proto,
>                 .minorversion = minor_version,
> +               .namespace = mds_clp->cl_namespace,
>                 .net = mds_clp->cl_net,
>                 .timeparms = &ds_timeout,
>                 .cred = mds_srv->cred,
> @@ -1120,6 +1129,7 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
>                                 &timeparms,
>                                 ctx->minorversion,
>                                 ctx->nfs_server.nconnect,
> +                               ctx->namespace,
>                                 fc->net_ns);
>         if (error < 0)
>                 return error;
> @@ -1209,6 +1219,7 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
>                                 parent_server->client->cl_timeout,
>                                 parent_client->cl_mvops->minor_version,
>                                 parent_client->cl_nconnect,
> +                               parent_client->cl_namespace,
>                                 parent_client->cl_net);
>         if (!error)
>                 goto init_server;
> @@ -1224,6 +1235,7 @@ struct nfs_server *nfs4_create_referral_server(struct fs_context *fc)
>                                 parent_server->client->cl_timeout,
>                                 parent_client->cl_mvops->minor_version,
>                                 parent_client->cl_nconnect,
> +                               parent_client->cl_namespace,
>                                 parent_client->cl_net);
>         if (error < 0)
>                 goto error;
> @@ -1321,7 +1333,8 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
>         error = nfs4_set_client(server, hostname, sap, salen, buf,
>                                 clp->cl_proto, clnt->cl_timeout,
>                                 clp->cl_minorversion,
> -                               clp->cl_nconnect, net);
> +                               clp->cl_nconnect,
> +                               clp->cl_namespace, net);
>         clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
>         if (error != 0) {
>                 nfs_server_insert_lists(server);
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index e653654c10bc..5f5caf26397c 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -6191,6 +6191,8 @@ nfs4_init_nonuniform_client_string(struct nfs_client *clp)
>                 strlen(rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR)) +
>                 1;
>         rcu_read_unlock();
> +       if (*clp->cl_namespace)
> +               len += strlen(clp->cl_namespace) + 1;
>
>         buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
>         if (buflen)
> @@ -6210,15 +6212,19 @@ nfs4_init_nonuniform_client_string(struct nfs_client *clp)
>
>         rcu_read_lock();
>         if (buflen)
> -               scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s",
> +               scnprintf(str, len, "Linux NFSv4.0 %s/%s/%s%s%s",
>                           clp->cl_rpcclient->cl_nodename, buf,
>                           rpc_peeraddr2str(clp->cl_rpcclient,
> -                                          RPC_DISPLAY_ADDR));
> +                                          RPC_DISPLAY_ADDR),
> +                         *clp->cl_namespace ? "/" : "",
> +                         clp->cl_namespace);
>         else
> -               scnprintf(str, len, "Linux NFSv4.0 %s/%s",
> +               scnprintf(str, len, "Linux NFSv4.0 %s/%s%s%s",
>                           clp->cl_rpcclient->cl_nodename,
>                           rpc_peeraddr2str(clp->cl_rpcclient,
> -                                          RPC_DISPLAY_ADDR));
> +                                          RPC_DISPLAY_ADDR),
> +                         *clp->cl_namespace ? "/" : "",
> +                         clp->cl_namespace);
>         rcu_read_unlock();
>
>         clp->cl_owner_id = str;
> @@ -6238,6 +6244,8 @@ nfs4_init_uniform_client_string(struct nfs_client *clp)
>
>         len = 10 + 10 + 1 + 10 + 1 +
>                 strlen(clp->cl_rpcclient->cl_nodename) + 1;
> +       if (*clp->cl_namespace)
> +               len += strlen(clp->cl_namespace) + 1;
>
>         buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
>         if (buflen)
> @@ -6256,13 +6264,17 @@ nfs4_init_uniform_client_string(struct nfs_client *clp)
>                 return -ENOMEM;
>
>         if (buflen)
> -               scnprintf(str, len, "Linux NFSv%u.%u %s/%s",
> +               scnprintf(str, len, "Linux NFSv%u.%u %s/%s%s%s",
>                           clp->rpc_ops->version, clp->cl_minorversion,
> -                         buf, clp->cl_rpcclient->cl_nodename);
> +                         buf, clp->cl_rpcclient->cl_nodename,
> +                         *clp->cl_namespace ? "/" : "",
> +                         clp->cl_namespace);
>         else
> -               scnprintf(str, len, "Linux NFSv%u.%u %s",
> +               scnprintf(str, len, "Linux NFSv%u.%u %s%s%s",
>                           clp->rpc_ops->version, clp->cl_minorversion,
> -                         clp->cl_rpcclient->cl_nodename);
> +                         clp->cl_rpcclient->cl_nodename,
> +                         *clp->cl_namespace ? "/" : "",
> +                         clp->cl_namespace);
>         clp->cl_owner_id = str;
>         return 0;
>  }
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index fe58525cfed4..ea59248b64d1 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -479,6 +479,8 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
>         rcu_read_unlock();
>         if (clp->cl_nconnect > 0)
>                 seq_printf(m, ",nconnect=%u", clp->cl_nconnect);
> +       if (*clp->cl_namespace)
> +               seq_printf(m, ",namespace=%s", clp->cl_namespace);
>         if (version == 4) {
>                 if (nfss->port != NFS_PORT)
>                         seq_printf(m, ",port=%u", nfss->port);
> @@ -1186,6 +1188,9 @@ static int nfs_compare_super(struct super_block *sb, struct fs_context *fc)
>         /* Note: NFS_MOUNT_UNSHARED == NFS4_MOUNT_UNSHARED */
>         if (old->flags & NFS_MOUNT_UNSHARED)
>                 return 0;
> +       if (strcmp(old->nfs_client->cl_namespace,
> +                  server->nfs_client->cl_namespace) != 0)
> +               return 0;
>         if (memcmp(&old->fsid, &server->fsid, sizeof(old->fsid)) != 0)
>                 return 0;
>         if (!nfs_compare_userns(old, server))
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index d71a0e90faeb..c62db98f3c04 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -62,8 +62,8 @@ struct nfs_client {
>
>         u32                     cl_minorversion;/* NFSv4 minorversion */
>         unsigned int            cl_nconnect;    /* Number of connections */
> -       const char *            cl_principal;  /* used for machine cred */
> -
> +       const char *            cl_principal;   /* used for machine cred */
> +       const char *            cl_namespace;   /* used for NFS namespaces */
>  #if IS_ENABLED(CONFIG_NFS_V4)
>         struct list_head        cl_ds_clients; /* auth flavor data servers */
>         u64                     cl_clientid;    /* constant */
> --
> 2.32.0
>
