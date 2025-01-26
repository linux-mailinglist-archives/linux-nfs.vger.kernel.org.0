Return-Path: <linux-nfs+bounces-9628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F6A1C82C
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 14:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0E51886D03
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB0013AD38;
	Sun, 26 Jan 2025 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaWatw0c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1182890;
	Sun, 26 Jan 2025 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737899513; cv=none; b=szF0PwaUjsYslqnrKODNnzlMYyTPc2uxYTam3ug0aLAUsOQFh11bbC77wdhu1ASxUSpCYQc5lTSfEUvRAIacUE5bC7Ig0HOY9YpYnklM5zzAVTp7zQz+hXLI0v0Sgl+R7ROCXqBVW94XxBcEgjWC5RmwE3Pl+mp+TMw6uXqmiVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737899513; c=relaxed/simple;
	bh=201dkDTjCmiRcGm8bPYTPtiSs2ue7vO9CzCTBOmF0Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebl4J7HN+bjxtsEl1Z3r19/y5wLnPEJbac/aWX2n2aqzJAb2JCStlHqm/59+lds/ZBHiVUfHhmbSqAlVAB852WZnZYeVsc8ulg43zjvFjP/nptHx3dtj/8uKEW4pv3FqRq7TUyWhPiBYOjvEZHYCRDUWclbHOWBnVB8c4DeGJ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaWatw0c; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab68a4ab074so180550666b.0;
        Sun, 26 Jan 2025 05:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737899510; x=1738504310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVmrG6JIwPfOi5RgK1nvztQAflZ5wkDpxqV/+6Wg0Jc=;
        b=AaWatw0c/flEoAiqETHFLvMWjSTp0OVbmr8RtECFRRVW3paEwpjZHCg1lJd8ER+BaJ
         5vl0pory2W5vICFPPZ4wopA+HSWpQfbB3EpuPdYugEL8KdrDdGB/fpCE2VBcm5hh6JJx
         71P5EmkmlnIVxTDSLwnfFdHZ6drhO9ALpXVekbfbXm9PpkytrSnwFNdpSMON3yXlphZL
         S1I8OkHJt+0CaI/7SQj0xlTHWrvFOj7ocgxQBUOnyNvnEJpDMeJjxV3Pp/bN2qBJup3X
         gSz7qEnqQofgXp3ZGqXB+ue8D+PlkTo9xn0QJRMwe5vzVHZulG1iiijQaoGKug9HXrjh
         vVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737899510; x=1738504310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVmrG6JIwPfOi5RgK1nvztQAflZ5wkDpxqV/+6Wg0Jc=;
        b=ijb6MG1/UJLqmSMwobPMjJ03yEfRkwwmNQicB8o3g0iej3dBwBubwkkCSWWQ2rwyfU
         xN+a9Zpa2P5uhpZjQdoVYnqQbGO3xD7Egu/guAxdXb+MaS6lEwCuWN7CCaF/8sKOm3wd
         olK647W8TaZJahWyt2ZtVL7rmCPXx0mV6nsL3NU6NYWtDgUozCHPgPFT6PhlaTcDgDue
         GXxPG2OFpb33Q08GsyOkcp3g72HqOMqTXsfb3anvYceWWA2QAHb6ghpOrb+r5B3oAdug
         0Af9HTLfrSUq90kPhTwZVwcIoU1FhcM3DRzexbTydKnQVL77kbH7rj/VBD8S17r6LjS3
         WvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuGwK0gh/36kWb+pEbI68VeMuiNaH9zqY1nKu9QVRuycNKuba2f2G9MNOf0PhM4bDOzHUbgOMMSHHN@vger.kernel.org, AJvYcCXNcbzgt2LtEPND16u5+tLIS+uAI+4hlIC+oqzYOjXNLG6JinF/D3+h1jG9d4XF6kIkSrYDgfZpFX2eD9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LnpIvLdxrpB4luZZqQYAhE1vOn10LmuwO/5MP6KhEnCAPMza
	2I1hHohPM0HbNTrudngO7rZ4Jp/XE41auL4aT/FK191v7Ywy/3HpAjJHEmUw8pfic3xnQNnyvKM
	iXLCUChmWZ31wiZ2CpmJITID7vQ==
X-Gm-Gg: ASbGncveF0BVc8ZdOayEe/zPtrg6nGrFY03LsDEgDzQU69ca6Udbf9JPIozmcmWojJu
	FaJgKEW5Wx4uNneFlOJOjRwdWtAbFrxlIdve+l4x3GOjsyKwYSr5sYhDaelR7ih4219v70q8f9X
	f5GHPfF91WyUQZtTvXr/U=
X-Google-Smtp-Source: AGHT+IEaQuYhEqc0kcIspIEjXtJBDNyiLRo2hWXsPZHg0VK9vUO8Rxh6ZaTIiMo1blPPwHM8nTezif4nxanHXapBBbw=
X-Received: by 2002:a05:6402:2101:b0:5d1:2377:5af3 with SMTP id
 4fb4d7f45d1cf-5db7d2dc12amr85168627a12.5.1737899509585; Sun, 26 Jan 2025
 05:51:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126094722.738358-1-lilingfeng3@huawei.com>
In-Reply-To: <20250126094722.738358-1-lilingfeng3@huawei.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 26 Jan 2025 05:51:38 -0800
X-Gm-Features: AWEUYZn2_s5Ep1GrkxW4Oxr_7geLoWQtt3ii_rEeC-J2qv1rrE4yruAxspqYgt4
Message-ID: <CAM5tNy5DfZ18qCSbAX8TnUd2z3DZS=XmY3ka7X5KKVLW1n-6ng@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: clear acl_access/acl_default after releasing them
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	Trond.Myklebust@netapp.com, zhangjian496@huawei.com, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, lilingfeng@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 1:29=E2=80=AFAM Li Lingfeng <lilingfeng3@huawei.com=
> wrote:
>
> If getting acl_default fails, acl_access and acl_default will be released
> simultaneously. However, acl_access will still retain a pointer pointing
> to the released posix_acl, which will trigger a WARNING in
> nfs3svc_release_getacl like this:
>
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
> refcount_warn_saturate+0xb5/0x170
> Modules linked in:
> CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
> 6.12.0-rc6-00079-g04ae226af01f-dirty #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> RIP: 0010:refcount_warn_saturate+0xb5/0x170
> Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3 01 75
> e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> 0b eb
> cd 0f b6 1d 8a3
> RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
> RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
> RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
> R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
> R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
> FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? refcount_warn_saturate+0xb5/0x170
>  ? __warn+0xa5/0x140
>  ? refcount_warn_saturate+0xb5/0x170
>  ? report_bug+0x1b1/0x1e0
>  ? handle_bug+0x53/0xa0
>  ? exc_invalid_op+0x17/0x40
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? tick_nohz_tick_stopped+0x1e/0x40
>  ? refcount_warn_saturate+0xb5/0x170
>  ? refcount_warn_saturate+0xb5/0x170
>  nfs3svc_release_getacl+0xc9/0xe0
>  svc_process_common+0x5db/0xb60
>  ? __pfx_svc_process_common+0x10/0x10
>  ? __rcu_read_unlock+0x69/0xa0
>  ? __pfx_nfsd_dispatch+0x10/0x10
>  ? svc_xprt_received+0xa1/0x120
>  ? xdr_init_decode+0x11d/0x190
>  svc_process+0x2a7/0x330
>  svc_handle_xprt+0x69d/0x940
>  svc_recv+0x180/0x2d0
>  nfsd+0x168/0x200
>  ? __pfx_nfsd+0x10/0x10
>  kthread+0x1a2/0x1e0
>  ? kthread+0xf4/0x1e0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x34/0x60
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> Kernel panic - not syncing: kernel: panic_on_warn set ...
>
> Clear acl_access/acl_default after posix_acl_release is called to prevent
> UAF from being triggered.
>
> Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
> Link: https://lore.kernel.org/all/20241107014705.2509463-1-lilingfeng@hua=
weicloud.com/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
> Changes in v2:
> - Clear acl_access/acl_default after releasing them, instead of
>   modifying the logic for setting them.
> - Clear acl_access/acl_default in nfs2acl.c.
> ---
>  fs/nfsd/nfs2acl.c | 2 ++
>  fs/nfsd/nfs3acl.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
> index 4e3be7201b1c..5fb202acb0fd 100644
> --- a/fs/nfsd/nfs2acl.c
> +++ b/fs/nfsd/nfs2acl.c
> @@ -84,6 +84,8 @@ static __be32 nfsacld_proc_getacl(struct svc_rqst *rqst=
p)
>  fail:
>         posix_acl_release(resp->acl_access);
>         posix_acl_release(resp->acl_default);
> +       resp->acl_access =3D NULL;
> +       resp->acl_default =3D NULL;
>         goto out;
>  }
>
> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> index 5e34e98db969..7b5433bd3019 100644
> --- a/fs/nfsd/nfs3acl.c
> +++ b/fs/nfsd/nfs3acl.c
> @@ -76,6 +76,8 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
>  fail:
>         posix_acl_release(resp->acl_access);
>         posix_acl_release(resp->acl_default);
> +       resp->acl_access =3D NULL;
> +       resp->acl_default =3D NULL;
>         goto out;
>  }
>
> --
> 2.31.1
>
This version looks fine to me, rick

