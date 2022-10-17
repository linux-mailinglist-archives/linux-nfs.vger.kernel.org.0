Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3066005E2
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 05:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiJQD7H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Oct 2022 23:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiJQD7F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Oct 2022 23:59:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B396252E7B;
        Sun, 16 Oct 2022 20:59:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h2so2308579plb.2;
        Sun, 16 Oct 2022 20:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+dJRZHtMZrBF2k4ygt78sADQgSCT7KtNURPkxATzpo=;
        b=qfrgYWvrlPzatnb5TGzg5W+X2FMqkoAqpOYBEchdi466319hyjZoDJkPVCeI/FOEYD
         zbURNU+S1ldG1b0YisBTT1xWIqRz0+EKXvoJCANg3dNQBbgntQQvtkN3hEWePO9r6TcI
         72Y+lbQlVrF1wLH3eQlMxeaZOXH7HEtviU438Hg8nJDFVDJ3WQdanorUdwBbL3ttdD1J
         4SBMwpxYvS7ocdyTusoi9MI3P8s16pRUOMLBWcTlDKfLyBboVWuucFn90q2hGWJvvxVh
         WgIh8v8VeebuMVAyL/pKIqwNvsl+Hi4pyAMtttmJx2IO4H1zbPG0R1m8C2iKz+cjeXAi
         LtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+dJRZHtMZrBF2k4ygt78sADQgSCT7KtNURPkxATzpo=;
        b=SU08CdDkP6oPfygDB8E0Sg31j2UNQ3oZbx38L44I2ls01kRSVDFahW0WFlGRrnjFny
         pOZ8XHBwMJKiQgat9bywSIlvKx6pjArmT5R8GPOYxtB1SX7NjFB/nqYXflf/6MXTEhdV
         rlHz98wJt8nn6xhEE8i8HybNo3ZheEmIVUsCZcdjWR7kZLj+p10CNCn12M2McyiIdMZ7
         lj3oTmp20UrPA+AF1xSD+Ki/zHIxe68rsBXuowpciSeHivmLiiF4evYBpUBIdxW7iGOA
         NfU5QOsFp+Re7rc7I4KdtMbMS9cHiEtrQzC+ZaE9b6I5M4RvWUVmrh0mLakHMnGac+Aw
         SI0w==
X-Gm-Message-State: ACrzQf1KQJSLOwkAJLGwzkAbn6eha7RzbvbXgWYvXZGqpL+L+Kj1KGRX
        PVKlHINkC6NCb7NChEDNpIw=
X-Google-Smtp-Source: AMsMyM6ZybR8hSwG5qeWXOFOn322S7xxmxSta81fA9f1KmB6x1a95yrfIgcmGB1YDRGzLldaiReN6g==
X-Received: by 2002:a17:90a:5781:b0:20a:9962:bb4a with SMTP id g1-20020a17090a578100b0020a9962bb4amr30145442pji.185.1665979141630;
        Sun, 16 Oct 2022 20:59:01 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-89.three.co.id. [180.214.233.89])
        by smtp.gmail.com with ESMTPSA id om15-20020a17090b3a8f00b0020087d7e778sm8653196pjb.37.2022.10.16.20.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 20:58:59 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DA9711018D1; Mon, 17 Oct 2022 10:58:55 +0700 (WIB)
Date:   Mon, 17 Oct 2022 10:58:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Anna Schumaker <anna@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 6.1rc1: NFS memcpy warning on mount
Message-ID: <Y0zS/5WLi2q4Ua2U@debian.me>
References: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
 <Y0zEzZwhOxTDcBTB@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qzQ8gnePq5OPTXGG"
Content-Disposition: inline
In-Reply-To: <Y0zEzZwhOxTDcBTB@codemonkey.org.uk>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--qzQ8gnePq5OPTXGG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 16, 2022 at 10:58:21PM -0400, Dave Jones wrote:
> Started getting this during mount on a 6.1rc1 kernel..
> not sure which mount it's complaining about, but they're all v3 tcp
> mounts on that machine.
>=20
> [   19.617475] memcpy: detected field-spanning write (size 28) of single =
field "request.sap" at fs/nfs/super.c:857 (size 18446744073709551615)
> [   19.617504] WARNING: CPU: 3 PID: 1300 at fs/nfs/super.c:857 nfs_reques=
t_mount.constprop.0.isra.0+0x1c0/0x1f0
> [   19.617528] CPU: 3 PID: 1300 Comm: mount.nfs Not tainted 6.1.0-rc1-bac=
kup+ #1
> [   19.617553] RIP: 0010:nfs_request_mount.constprop.0.isra.0+0x1c0/0x1f0
> [   19.617566] Code: 16 81 01 00 75 9b 48 c7 c1 ff ff ff ff 48 c7 c2 a8 a=
8 82 ab 4c 89 e6 c6 05 36 16 81 01 01 48 c7 c7 a8 3a 81 ab e8 61 1d 9a 00 <=
0f> 0b 48 8b 3c 24 e9 6c ff ff ff c7 83 20 01 00 00 01 00 00 00 b8
> [   19.617593] RSP: 0018:ffffc900027fbd48 EFLAGS: 00010286
> [   19.617604] RAX: 0000000000000000 RBX: ffff8881208d5000 RCX: ffff88842=
fadb7a8
> [   19.617617] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff88842=
fadb7a0
> [   19.617629] RBP: ffff8881208d5130 R08: 0000000000000000 R09: ffffffffa=
ba5c540
> [   19.617641] R10: 0000000000000001 R11: 0000000000000001 R12: 000000000=
000001c
> [   19.617653] R13: 0000000000000001 R14: ffffc900027fbef0 R15: ffff88810=
0b3bea0
> [   19.617665] FS:  00007ff793dd6840(0000) GS:ffff88842fac0000(0000) knlG=
S:0000000000000000
> [   19.617679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   19.617690] CR2: 0000564a1a747468 CR3: 00000001106fb003 CR4: 000000000=
01706e0
> [   19.617703] Call Trace:
> [   19.617709]  <TASK>
> [   19.617716]  nfs_try_get_tree+0xa1/0x220
> [   19.617725]  ? get_nfs_version+0x63/0x130
> [   19.617736]  vfs_get_tree+0x1d/0x90
> [   19.617746]  ? capable+0x2f/0x50
> [   19.617755]  path_mount+0x75c/0xb00
> [   19.617766]  __x64_sys_mount+0x19a/0x200
> [   19.617775]  do_syscall_64+0x35/0x80
> [   19.617785]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   19.617796] RIP: 0033:0x7ff7941ac6ea
> [   19.617805] Code: 48 8b 0d a9 17 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 6=
6 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 17 0d 00 f7 d8 64 89 01 48
> [   19.617832] RSP: 002b:00007ffd02ae4ce8 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000a5
> [   19.617846] RAX: ffffffffffffffda RBX: 00007ffd02ae4e70 RCX: 00007ff79=
41ac6ea
> [   19.617858] RDX: 0000564a1a73fb60 RSI: 0000564a1a73fb80 RDI: 0000564a1=
a741890
> [   19.617870] RBP: 00007ff793dd67b8 R08: 0000564a1a73f480 R09: 0000564a1=
a73f480
> [   19.617882] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000000
> [   19.617894] R13: 00007ffd02ae4dd0 R14: 0000564a1a7474e0 R15: 0000564a1=
a7436b0
> [   19.617907]  </TASK>
> [   19.617913] irq event stamp: 8757
> [   19.617920] hardirqs last  enabled at (8769): [<ffffffffaa1397c2>] __u=
p_console_sem+0x52/0x60
> [   19.617937] hardirqs last disabled at (8780): [<ffffffffaa1397a7>] __u=
p_console_sem+0x37/0x60
> [   19.617952] softirqs last  enabled at (8180): [<ffffffffaabf547a>] sk_=
common_release+0x5a/0xe0
> [   19.617969] softirqs last disabled at (8178): [<ffffffffaabf5456>] sk_=
common_release+0x36/0xe0
> [   19.617984] ---[ end trace 0000000000000000 ]---
>=20

Hmm, the blamed line in the warning is introduced by 38465f5d1af932 ("NFS:
rename nfs_fs_context pointer arg in a few functions"). Cc: the commit
author. Also Cc: Kees for authoring the patch [1] that have fixed
similar warning.

Also, does v6.0 have this warning? If so, you need to bisect in the range
of v6.0..v6.1-rc1.

Thanks.

[1]: https://lore.kernel.org/lkml/20221011065243.583650-1-keescook@chromium=
=2Eorg/

--=20
An old man doll... just what I always wanted! - Clara

--qzQ8gnePq5OPTXGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0zS+gAKCRD2uYlJVVFO
o1BoAPwOan526SnMjUySVrl/LUWJInIvbkQQoiZ42n6U5peSrgEAsc5oHBdEsmTo
sfSQc74rHrGuBrkh5/R3O9dBzOIhLA8=
=a1Sh
-----END PGP SIGNATURE-----

--qzQ8gnePq5OPTXGG--
