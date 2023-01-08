Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47241661480
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 11:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjAHKYr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 05:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHKYq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 05:24:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FD4DF8B
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 02:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673173437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifyc/NpPD4xDrkXOelpV70x0wZHDxaX3KlAPaBK97ZE=;
        b=S7aESQAPqVIS8YR6SFOr9cSzdegxUuZukxfA8xPDB1fa9C+qT7GHUKaO6Bgi0ci0lnYW52
        vAjGuHgkLe+e4HuZFVHDU06uIt/Eeku5uLM6KOrTX4YgK5ifpnXvDcAiulMiIXvKgdDsZ2
        Ogs7i1Zo2Xgy/SlYAU+6AGx6hrWhq7s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-uFYj4GtSOEaNywDitLSi-g-1; Sun, 08 Jan 2023 05:23:56 -0500
X-MC-Unique: uFYj4GtSOEaNywDitLSi-g-1
Received: by mail-qt1-f197.google.com with SMTP id k7-20020ac84747000000b003a87ca26200so3118787qtp.6
        for <linux-nfs@vger.kernel.org>; Sun, 08 Jan 2023 02:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifyc/NpPD4xDrkXOelpV70x0wZHDxaX3KlAPaBK97ZE=;
        b=Doeur76q9lDySno08EMmu955eeFfrcL28gVRo1TiZ6DfkhsSE9ue2L1q1yJgkc0g2G
         zenXaoBiiytwWuY8TU9OrHZY3qzZVZOIj0nuoJ+J4Drav9yZisJsBKrv5jfRjoiAjnvr
         eoj+yS1GleGaFAdl17MIkmFQkqmTgmd6NYOluslWx2F4ZPKyu9MalNJCzygGszd1wxdl
         m1K2zxhAxN2mqZj60bMZrR42t/4cvz37+wQkQ6ShOntcuNPqEvQ390FhnIRNhJegmVDs
         E5z0p+D3222gjbeOas0vhou0UsKKqhngVrMOckGpZeOPGo7Qdvt/SMmJ9ltbieW3JiJW
         Px1g==
X-Gm-Message-State: AFqh2kpE4TAt31wFVsiVI/wIahTy7Hz6W3y/R+Y6XW5+uzwA9EF9gORd
        o0XGAr/0R8z7GurpM/mMSzFygJQGugKFW5xz9bVuKLtq/wowvxqFz4bQ4rjacA8ZcLtiKmriwBd
        qALT86l5djTG59RDwoqhn
X-Received: by 2002:ac8:6782:0:b0:3a8:2d7:af66 with SMTP id b2-20020ac86782000000b003a802d7af66mr95174557qtp.21.1673173435688;
        Sun, 08 Jan 2023 02:23:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvinUcVeN3C2Q5Q9QCpHNOJFVhEA3iYudJmx+H8tbDdi1Xb5hPf5vc3iWUzZqUjLSRUm39apg==
X-Received: by 2002:ac8:6782:0:b0:3a8:2d7:af66 with SMTP id b2-20020ac86782000000b003a802d7af66mr95174544qtp.21.1673173435369;
        Sun, 08 Jan 2023 02:23:55 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id f9-20020ac80689000000b00343057845f7sm3089592qth.20.2023.01.08.02.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 02:23:54 -0800 (PST)
Message-ID: <a456ac8ccdb54f4d661fae5ef090d63d0bbcc690.camel@redhat.com>
Subject: Re: NFSD: refcount_t: underflow; use-after-free from nfsd_file_free
From:   Jeff Layton <jlayton@redhat.com>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Sun, 08 Jan 2023 05:23:54 -0500
In-Reply-To: <830543ab-10e0-3a62-c683-8bd95292db4b@oracle.com>
References: <3c525b04-ef64-2bee-efc9-9a43069306f7@oracle.com>
         <830543ab-10e0-3a62-c683-8bd95292db4b@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2023-01-07 at 14:04 -0800, dai.ngo@oracle.com wrote:
> Hi,
>=20
> This is a regression in 6.2.0-rc1.
>=20
> The problem can be reproduced with a simple test:
> . client mounts server's export using 4.1
> . client cats a file on server's export
> . on server stop nfs-server service
>=20
> Bisect points to commit ac3a2585f018 (nfsd: rework refcounting in filecac=
he)
>=20
> -Dai
>=20


This looks like the same problem that 789e1e10f214 ("nfsd: shut down the
NFSv4 state objects before the filecache") is intended to fix. That
patch was not in -rc1. Can you test a kernel that does have that patch
and let us know if it fixes this?

Thanks,
Jeff


> Jan  7 12:15:56 nfsvmf14 kernel: ------------[ cut here ]------------
> Jan  7 12:15:56 nfsvmf14 kernel: refcount_t: underflow; use-after-free.
> Jan  7 12:15:56 nfsvmf14 kernel: WARNING: CPU: 0 PID: 10420 at lib/refcou=
nt.c:28 refcount_warn_saturate+0xb3/0x100
> Jan  7 12:15:56 nfsvmf14 kernel: Modules linked in: rpcsec_gss_krb5 btrfs=
 blake2b_generic xor raid6_pq zstd_compress intel_powerclamp sg nfsd nfs_ac=
l auth_rpcgss lockd grace sunrpc xfs dm_mirror dm_region_hash dm_log dm_mod
> Jan  7 12:15:56 nfsvmf14 kernel: CPU: 0 PID: 10420 Comm: rpc.nfsd Kdump: =
loaded Tainted: G        W          6.2.0-rc1 #1
> Jan  7 12:15:56 nfsvmf14 kernel: Hardware name: innotek GmbH VirtualBox/V=
irtualBox, BIOS VirtualBox 12/01/2006
> Jan  7 12:15:56 nfsvmf14 kernel: RIP: 0010:refcount_warn_saturate+0xb3/0x=
100
> Jan  7 12:15:56 nfsvmf14 kernel: Code: 01 01 e8 3f 21 65 00 0f 0b c3 cc c=
c cc cc 80 3d f5 d1 4a 01 00 75 5b 48 c7 c7 c3 4b 22 82 c6 05 e5 d1 4a 01 0=
1 e8 1c 21 65 00 <0f> 0b c3 cc cc cc cc 80 3d d1 d1 4a 01 00 75 38 48 c7 c7=
 eb 4b 22
> Jan  7 12:15:56 nfsvmf14 kernel: RSP: 0018:ffffc9000078fc98 EFLAGS: 00010=
282
> Jan  7 12:15:56 nfsvmf14 kernel: RAX: 0000000000000000 RBX: ffff88810e8a9=
930 RCX: 0000000000000027
> Jan  7 12:15:56 nfsvmf14 kernel: RDX: 00000000ffff7fff RSI: 0000000000000=
003 RDI: ffff888217c1c640
> Jan  7 12:15:56 nfsvmf14 kernel: RBP: ffff88810cbd7870 R08: 0000000000000=
000 R09: ffffffff827d9f88
> Jan  7 12:15:56 nfsvmf14 kernel: R10: 00000000756f6366 R11: 0000000063666=
572 R12: ffff888111c9c000
> Jan  7 12:15:56 nfsvmf14 kernel: R13: ffff88810fb5fa00 R14: ffff88810f980=
058 R15: ffff88810e6d68b0
> Jan  7 12:15:56 nfsvmf14 kernel: FS:  00007fa614d16840(0000) GS:ffff88821=
7c00000(0000) knlGS:0000000000000000
> Jan  7 12:15:56 nfsvmf14 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
> Jan  7 12:15:56 nfsvmf14 kernel: CR2: 0000559a53e66908 CR3: 0000000110c72=
000 CR4: 00000000000406f0
> Jan  7 12:15:56 nfsvmf14 kernel: Call Trace:
> Jan  7 12:15:56 nfsvmf14 kernel: <TASK>
> Jan  7 12:15:56 nfsvmf14 kernel: __refcount_sub_and_test.constprop.0+0x2b=
/0x36 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_file_free+0x119/0x182 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: destroy_unhashed_deleg+0x65/0x8e [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: __destroy_client+0xc3/0x1ea [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: nfs4_state_shutdown_net+0x12c/0x236 [nfs=
d]
> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_shutdown_net+0x35/0x58 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_put+0xbf/0x117 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_svc+0x2d0/0x2f2 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: write_threads+0x6d/0xb9 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: ? write_versions+0x333/0x333 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: nfsctl_transaction_write+0x4f/0x6b [nfsd=
]
> Jan  7 12:15:56 nfsvmf14 kernel: vfs_write+0xdb/0x1e5
> Jan  7 12:15:56 nfsvmf14 kernel: ? kmem_cache_free+0xf1/0x186
> Jan  7 12:15:56 nfsvmf14 kernel: ? do_sys_openat2+0xcd/0xf5
> Jan  7 12:15:56 nfsvmf14 kernel: ? __fget_light+0x2d/0x78
> Jan  7 12:15:56 nfsvmf14 kernel: ksys_write+0x76/0xc3
> Jan  7 12:15:56 nfsvmf14 kernel: do_syscall_64+0x56/0x71
> Jan  7 12:15:56 nfsvmf14 kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
> Jan  7 12:15:56 nfsvmf14 kernel: RIP: 0033:0x7fa6142efa00
> Jan  7 12:15:56 nfsvmf14 kernel: Code: 73 01 c3 48 8b 0d 70 74 2d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd d5 2d 00 00 75 10 b8 0=
1 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee cb 01 00 48=
 89 04 24
> Jan  7 12:15:56 nfsvmf14 kernel: RSP: 002b:00007ffc79bf4748 EFLAGS: 00000=
246 ORIG_RAX: 0000000000000001
> Jan  7 12:15:56 nfsvmf14 kernel: RAX: ffffffffffffffda RBX: 0000000000000=
003 RCX: 00007fa6142efa00
> Jan  7 12:15:56 nfsvmf14 kernel: RDX: 0000000000000002 RSI: 000055d4cb809=
3e0 RDI: 0000000000000003
> Jan  7 12:15:56 nfsvmf14 kernel: RBP: 000055d4cb8093e0 R08: 0000000000000=
000 R09: 00007fa61424d2cd
> Jan  7 12:15:56 nfsvmf14 kernel: R10: 0000000000000004 R11: 0000000000000=
246 R12: 0000000000000000
> Jan  7 12:15:56 nfsvmf14 kernel: R13: 0000000000000000 R14: 0000000000000=
000 R15: 000000000000001f
> Jan  7 12:15:56 nfsvmf14 kernel: </TASK>
> Jan  7 12:15:56 nfsvmf14 kernel: ---[ end trace 0000000000000000 ]---
>=20

--=20
Jeff Layton <jlayton@redhat.com>

