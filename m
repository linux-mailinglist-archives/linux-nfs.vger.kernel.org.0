Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8648B4281F4
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Oct 2021 16:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhJJOiB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 10 Oct 2021 10:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231842AbhJJOiA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 10 Oct 2021 10:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633876561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TDT91PTGGwYVz4JzCliRytM3izQAiqWq+ydaW8Y5/FU=;
        b=UN7cEbUgWN7NDhc/XNEIDdHPH+9CB72xt/bMPyaNGjrvvyB8wig3nUg+3Gjy3zN6jVuhYC
        7qK5gzQnlWmXFkQW3+PxkVGswaEr+Is/fONJ+YScFOYDD8kJOOYN2TtrV2A46GvCoJ7JLu
        1tPIAkKvB3pKDWVRxLLWkOTL2OdT2WU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-ecXPe2n0P5Sqeomxxx8GMg-1; Sun, 10 Oct 2021 10:36:00 -0400
X-MC-Unique: ecXPe2n0P5Sqeomxxx8GMg-1
Received: by mail-ed1-f70.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso13458355edf.7
        for <linux-nfs@vger.kernel.org>; Sun, 10 Oct 2021 07:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDT91PTGGwYVz4JzCliRytM3izQAiqWq+ydaW8Y5/FU=;
        b=gzPh37CCtgDtR5qd3BcFxY7cppesfCLvAPq6l3EJhHoFBsP3hhQdVuKsnLFiaXLErD
         D7qJCIOiV5WZiOR4hAAZt/2JsdeQp051ymuy7rENLhwT8UA8n9e2VJmx0ismntxZdGf0
         Lqfpoa9nXhgiUGKiT36mPWO/JwmjtuAabHJSh95cOAvuTc2Nla3+ySugRrAlPxQj3X3V
         P94e2ME2zdOJxKeNmV5k9XD9NXXlaNc+Mhq+LbBtJ3qYTJPoo5zpgCdq+wXnYel8b7oF
         JMIvnEcv+NkHCl/CMIS8zNITpFnU/xO90bOQbIRx6VVNuqT7JN64xXgV4s3w3ma9IEmk
         GpDQ==
X-Gm-Message-State: AOAM533aQ5JdSK3GIPLXb3Bs6NrXDKJ0SgeBjD34J4v+TREdJJUGYyAU
        YlzwreTTvNx+uyrjrrDuwj3/lo2oOrBhSzfK3sJiOhrm7ZSaPW35pCVgRLIaEQABSdbxXAJKKsZ
        QYVu67MkkHaeqqQYhky65X8JYKRGHF7fkN9lo
X-Received: by 2002:a17:906:a246:: with SMTP id bi6mr19382974ejb.389.1633876559031;
        Sun, 10 Oct 2021 07:35:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ1Y8bDID3YkIu0LBTAx1d/ZHyAFxDr0V3gchiARuev6ZJGvvsEZmH4FfT/8ehnyvaYK/KR8NhePLSKjZUZao=
X-Received: by 2002:a17:906:a246:: with SMTP id bi6mr19382955ejb.389.1633876558781;
 Sun, 10 Oct 2021 07:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <CALF+zOmahudY07tTDGcu7GFvKOOYUbboKoKk6dwhuCkGTXCUcA@mail.gmail.com>
 <4c4591fc3e0a76dda77ea7de8ac43457c25fbfbb.camel@hammerspace.com>
In-Reply-To: <4c4591fc3e0a76dda77ea7de8ac43457c25fbfbb.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Sun, 10 Oct 2021 10:35:21 -0400
Message-ID: <CALF+zOkcW9Rm271dSfJ-ukB991iLboXLAVRwd-AosALjqb47Vg@mail.gmail.com>
Subject: Re: Oops in nfs_scan_commit running xfstest generic/005 with NFSv4.2
 and hammerspace flexfiles server
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Oct 10, 2021 at 5:04 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Sat, 2021-10-09 at 09:34 -0400, David Wysochanski wrote:
> > Trond,
> >
> > I wonder if you are aware of this or not.
> >
> > This week I ran a lot of xfstests with hammerspace and other servers
> > without any issues and just now seeing this oops (after rebuilding
> > from a base of your testing branch at 0abb8895b065).  I then re-built
> > with just your testing branch and got the same oops.  Same test passes
> > on 5.14.0-rc4 (vanilla), as well as previous kernels I used at
> > BakeAthon with the fscache and readahead patches only.  It reliably
> > panics for me so let me know if you want any more info or a
> > reproduction with tracepoints, etc.  FYI, I don't think the server
> > matters because I can also reproduce with a rhel8 server
> > (kernel-4.18.0-305.19.1.el8_4) and I can also just run 'generic/005'
> > directly - previous tests don't matter.
> >
> > [   15.767423] nfs4filelayout_init: NFSv4 File Layout Driver
> > Registering...
> > [   28.614447] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
> > Registering...
> > [   30.024616] run fstests generic/001 at 2021-10-09 09:01:14
> > [   37.188167] run fstests generic/002 at 2021-10-09 09:01:21
> > [   38.372767] run fstests generic/003 at 2021-10-09 09:01:23
> > [   38.713218] run fstests generic/004 at 2021-10-09 09:01:23
> > [   39.065705] run fstests generic/005 at 2021-10-09 09:01:23
> > [   39.799076] general protection fault, probably for non-canonical
> > address 0xffe826e8e8e7897c: 0000 [#1] SMP PTI
> > [   39.805058] CPU: 0 PID: 6213 Comm: rm Kdump: loaded Not tainted
> > 5.15.0-rc4-trond-testing+ #76
> > [   39.808300] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.14.0-4.fc34 04/01/2014
> > [   39.810819] RIP: 0010:__mutex_lock.constprop.0+0x97/0x3e0
> > [   39.812438] Code: 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 65 48 8b
> > 04 25 c0 7b 01 00 48 8b 00 a8 08 75 1d 49 8b 06 48 83 e0 f8 0f 84 79
> > 02 00 00 <8b> 50 34 85 d2 0f 85 5c 02 00 00 e8 59 8f 55 ff 65 48 8b 04
> > 25 c0
> > [   39.817418] RSP: 0018:ffffbb8e4558bcd0 EFLAGS: 00010286
> > [   39.818546] RAX: ffe826e8e8e78948 RBX: ffffbb8e4558bd70 RCX:
> > ffff932e89300000
> > [   39.820087] RDX: ffff932e89300000 RSI: ffe826e8e8e78948 RDI:
> > ffff932eae01edf0
> > [   39.821583] RBP: ffffbb8e4558bd28 R08: 0000000000000001 R09:
> > ffffbb8e4558bca0
> > [   39.823091] R10: 000000000000001d R11: ffffffffffffcfcf R12:
> > 0000000000000000
> > [   39.824796] R13: 0000000000000000 R14: ffff932eae01edf0 R15:
> > 0000000000000000
> > [   39.826318] FS:  00007fac7df09740(0000) GS:ffff932ff7c00000(0000)
> > knlGS:0000000000000000
> > [   39.828037] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   39.829275] CR2: 0000555f9b7e2018 CR3: 000000011dc96005 CR4:
> > 0000000000770ef0
> > [   39.830787] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [   39.832275] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [   39.833756] PKRU: 55555554
> > [   39.834377] Call Trace:
> > [   39.836219]  ? security_inode_permission+0x30/0x50
> > [   39.837365]  nfs_scan_commit+0x36/0xa0 [nfs]
> > [   39.838367]  __nfs_commit_inode+0xf8/0x160 [nfs]
> > [   39.839417]  nfs_wb_all+0xa6/0xf0 [nfs]
> > [   39.840309]  nfs4_inode_return_delegation+0x58/0x80 [nfsv4]
> > [   39.841554]  nfs4_proc_remove+0xd1/0xe0 [nfsv4]
> > [   39.842589]  nfs_unlink+0xec/0x2d0 [nfs]
> > [   39.843461]  vfs_unlink+0x113/0x230
> > [   39.844245]  do_unlinkat+0x170/0x280
> > [   39.845040]  __x64_sys_unlinkat+0x33/0x60
> > [   39.845922]  do_syscall_64+0x3b/0x90
> > [   39.846726]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
>
> Whoops... I believe the following patch ought to fix it. Thanks for
> reporting this!
>
> 8<---------------------------------------------------
> From 64a082064b7b375263960c4f011bc9875ef50f6a Mon Sep 17 00:00:00 2001
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Sun, 10 Oct 2021 10:58:12 +0200
> Subject: [PATCH] NFSv4: Fixes for nfs4_inode_return_delegation()
>
> We mustn't call nfs_wb_all() on anything other than a regular file.
> Furthermore, we can exit early when we don't hold a delegation.
>
> Reported-by: David Wysochanski <dwysocha@redhat.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/delegation.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index 11118398f495..7c9eb679dbdb 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -755,11 +755,13 @@ int nfs4_inode_return_delegation(struct inode *inode)
>         struct nfs_delegation *delegation;
>
>         delegation = nfs_start_delegation_return(nfsi);
> -       /* Synchronous recall of any application leases */
> -       break_lease(inode, O_WRONLY | O_RDWR);
> -       nfs_wb_all(inode);
> -       if (delegation != NULL)
> +       if (delegation != NULL) {
> +               /* Synchronous recall of any application leases */
> +               break_lease(inode, O_WRONLY | O_RDWR);
> +               if (S_ISREG(inode->i_mode))
> +                       nfs_wb_all(inode);
>                 return nfs_end_delegation_return(inode, delegation, 1);
> +       }
>         return 0;
>  }
>
> --
> 2.31.1
>
>

Great, that seems to have fixed it!

Now I get the below WARN_ON pop though indicating
nfs_have_writebacks() is true when inside nfs_clear_inode() and I
think I saw this once before.
I think we need some simple fixup to nfs_have_writebacks() due to the
union-ization in your patch:
commit b712e11b99eadba5b4003dd815adb368835fb5d5
Author: Trond Myklebust <trond.myklebust@hammerspace.com>
Date:   Tue Sep 28 17:41:41 2021 -0400

    NFS: Save some space in the inode

    Save some space in the nfs_inode by setting up an anonymous union with
    the fields that are peculiar to a specific type of filesystem object.

    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>


You may want to fold something like this into the above which fixes
the WARN for me:
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a5aef2cbe4ee..5a110ecf2d85 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -579,7 +579,9 @@ extern int nfs_access_get_cached(struct inode
*inode, const struct cred *cred, s
 static inline int
 nfs_have_writebacks(struct inode *inode)
 {
-       return atomic_long_read(&NFS_I(inode)->nrequests) != 0;
+       if (S_ISREG(inode->i_mode))
+               return atomic_long_read(&NFS_I(inode)->nrequests) != 0;
+       return 0;
 }

 /*


[   77.421040] run fstests generic/001 at 2021-10-10 10:01:29
[   84.454129] run fstests generic/002 at 2021-10-10 10:01:37
[   85.578188] run fstests generic/003 at 2021-10-10 10:01:38
[   85.894748] run fstests generic/004 at 2021-10-10 10:01:38
[   86.242081] run fstests generic/005 at 2021-10-10 10:01:38
[   87.054151] ------------[ cut here ]------------
[   87.056407] WARNING: CPU: 7 PID: 6236 at fs/nfs/inode.c:123
nfs_clear_inode+0x3b/0x50 [nfs]
[   87.060392] Modules linked in: nfs_layout_flexfiles rpcsec_gss_krb5
nfs_layout_nfsv41_files nfsv4 dns_resolver nfsv3 nfs nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 ip_set rfkill nf_tables nfnetlink
cachefiles fscache netfs intel_rapl_msr intel_rapl_common
isst_if_common kvm_intel kvm iTCO_wdt intel_pmc_bxt
iTCO_vendor_support joydev virtio_balloon irqbypass i2c_i801 i2c_smbus
lpc_ich nfsd nfs_acl lockd auth_rpcgss grace drm sunrpc fuse zram
ip_tables xfs crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel serio_raw virtio_console virtio_blk virtio_net
net_failover failover qemu_fw_cfg
[   87.075262] CPU: 7 PID: 6236 Comm: rm Kdump: loaded Not tainted
5.15.0-rc4-fscache-remove-old-io-nfs-fixes-trond2-readahead2+ #78
[   87.077057] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-4.fc34 04/01/2014
[   87.078376] RIP: 0010:nfs_clear_inode+0x3b/0x50 [nfs]
[   87.079212] Code: 85 c0 75 26 48 8b 55 88 48 8d 45 88 48 39 c2 75
28 48 89 ef e8 76 ff ff ff 48 89 ef e8 9e b1 ff ff 48 89 ef 5d e9 f5
93 01 00 <0f> 0b 48 8b 55 88 48 8d 45 88 48 39 c2 74 d8 0f 0b eb d4 66
90 0f
[   87.082029] RSP: 0018:ffffb7a9c5597e80 EFLAGS: 00010286
[   87.082865] RAX: ffff8b03b8a75078 RBX: ffffffffc0e11fe0 RCX: 0000000000000000
[   87.083968] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9c30f8a75138
[   87.085097] RBP: ffff9c30f8a75138 R08: fffffffffffffffe R09: 0000000000000000
[   87.086224] R10: ffff9c30c0b43300 R11: 0000000000000003 R12: ffff9c30f8a75250
[   87.087332] R13: ffff9c30c1657000 R14: ffff9c30f8a75138 R15: ffff9c30f054b3c0
[   87.088499] FS:  00007f9dd7864740(0000) GS:ffff9c3237dc0000(0000)
knlGS:0000000000000000
[   87.089756] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.090868] CR2: 000055b8f711f018 CR3: 0000000105a6a005 CR4: 0000000000770ee0
[   87.091974] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   87.093089] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   87.094207] PKRU: 55555554
[   87.094661] Call Trace:
[   87.095080]  nfs4_evict_inode+0x57/0x70 [nfsv4]
[   87.095853]  evict+0xd1/0x180
[   87.096357]  do_unlinkat+0x198/0x280
[   87.096964]  __x64_sys_unlinkat+0x33/0x60
[   87.097615]  do_syscall_64+0x3b/0x90
[   87.098218]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   87.099008] RIP: 0033:0x7f9dd7959e8b
[   87.099593] Code: 73 01 c3 48 8b 0d ed ff 0c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 07 01 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bd ff 0c 00 f7 d8 64 89
01 48
[   87.102601] RSP: 002b:00007fff2dfde878 EFLAGS: 00000246 ORIG_RAX:
0000000000000107
[   87.103771] RAX: ffffffffffffffda RBX: 000055b8f711b7e0 RCX: 00007f9dd7959e8b
[   87.104871] RDX: 0000000000000000 RSI: 000055b8f711a380 RDI: 00000000ffffff9c
[   87.106158] RBP: 000055b8f711a2f0 R08: 0000000000000003 R09: 0000000000000000
[   87.107266] R10: 0000000000000100 R11: 0000000000000246 R12: 0000000000000000
[   87.108379] R13: 00007fff2dfde9a0 R14: 0000000000000000 R15: 0000000000000002
[   87.109477] ---[ end trace a1355ed0b42315fa ]---
[   87.429954] run fstests generic/006 at 2021-10-10 10:01:39

    118 void nfs_clear_inode(struct inode *inode)
    119 {
    120         /*
    121          * The following should never happen...
    122          */
    123         WARN_ON_ONCE(nfs_have_writebacks(inode));
    124         WARN_ON_ONCE(!list_empty(&NFS_I(inode)->open_files));
    125         nfs_zap_acl_cache(inode);
    126         nfs_access_zap_cache(inode);
    127         nfs_fscache_clear_inode(inode);
    128 }

