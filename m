Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01071752C18
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jul 2023 23:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjGMV2H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jul 2023 17:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGMV2F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jul 2023 17:28:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF7A2D54
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 14:28:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b73261babdso3821961fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 14:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689283682; x=1691875682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQu08IYEmxngVArNyUTUIPv5P9rIMDQiDEwXqflMQIQ=;
        b=srKgDmjtylQQSdbJatXgpfmx4xpUtzp8kmSL1cmkdpOCtfNNPEDm4gk30+w3hdGdJ1
         G5kXImxm/pHj+cj5XuIDi08CElZYNn2FtoVlhtYP3UAv4icG/9fBBCQJvAqd5d+0XpwB
         Pmq3Q5RhQbYz70DjQygPWGxpegjx5Lq+XAeArDse+O710o8ItzXypJx+WfzEuwyvgXy9
         9THJBjYX5ohV/GOW8Nm9pnLmeXr40Zptt84hl0hNlHd4PUfZF1GpncjoOe5c+uGrbGvS
         f761BSwfVBYoDR/DyPH3gNzmY9bb3PeTb7uLPOJHuIH9koSkf8RTl7HRMYh/493Y+BC2
         uMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689283682; x=1691875682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQu08IYEmxngVArNyUTUIPv5P9rIMDQiDEwXqflMQIQ=;
        b=bfH9Ko2eXnbAo/T5JRZ777LzRAUsTiFr870B6u0pwvveIDntWwEy36RUKETXHhG2i3
         FPhPg5zDfcxlY/0gXhFH9vpln84Or8jXJ/eUIpp2Vpx9/8SsJS3CuP9Y1Z3BcbtfU4BS
         7GwCAys2YUngEyAZRgtSs8d0xGZOjNZWZmDTDrrRX7tHAbC+2Dt8ae2z3un6OAh4DDQu
         IVRE7Mvy2NliOl0NspcYwwKtPdqPfFa4oyFXhVH8QdVw3iobXlzwmDWbd0djAZ81GFA+
         RcLag1dld6Gb8VbRh/iZytmjxSOxHDitdtWOgFdb7A8hyXOl8R+9levOmj2iISjD3/x6
         MC6Q==
X-Gm-Message-State: ABy/qLbtuNuKpBrdw4qc1APBS8cG2Orx2hLoYBv5EtTOu/XpTMVTCi/U
        4EHyBwiRGAvrcyTcVje81Ln/hNNJ3ZhpI86TgzW7sr6yDdU=
X-Google-Smtp-Source: APBJJlGjEd0ryEZPeU1A/uGsJJ+IZS9ouMXDClaHwzegNy+WiDD51bX8TrXTstcx/utl6QbGTENRuTa94uHY+YdZ0rE=
X-Received: by 2002:a2e:2a01:0:b0:2b7:32d1:6c7d with SMTP id
 q1-20020a2e2a01000000b002b732d16c7dmr2164304ljq.2.1689283682135; Thu, 13 Jul
 2023 14:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230713195416.30414-1-olga.kornievskaia@gmail.com> <A0663B9C-F005-4089-ABD6-542F77EE43ED@redhat.com>
In-Reply-To: <A0663B9C-F005-4089-ABD6-542F77EE43ED@redhat.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 13 Jul 2023 17:27:50 -0400
Message-ID: <CAN-5tyGa1dV1A5RgZsMCQzFHDV63=LDJq0DTpg8aJ=UCO+k+Og@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix zero value filehandle in post open getattr
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 13, 2023 at 5:09=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 13 Jul 2023, at 15:54, Olga Kornievskaia wrote:
>
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > Currently, if the OPEN compound experiencing an error and needs to
> > get the file attributes separately, it will send a stand alone
> > GETATTR but it would use the filehandle from the results of
> > the OPEN compound. In case of the CLAIM_FH OPEN, nfs_openres's fh
> > is zero value. That generate a GETATTR that's sent with a zero
> > value filehandle, and results in the server returning an error.
> >
> > Instead, for the CLAIM_FH OPEN, take the filehandle that was used
> > in the PUTFH of the OPEN compound.
> >
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4proc.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 8edc610dc1d3..0b1b49f01c5b 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -2703,8 +2703,12 @@ static int _nfs4_proc_open(struct nfs4_opendata =
*data,
> >                       return status;
> >       }
> >       if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
> > +             struct nfs_fh *fh =3D &o_res->fh;
> > +
> >               nfs4_sequence_free_slot(&o_res->seq_res);
> > -             nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr, NULL=
);
> > +             if (o_arg->claim =3D=3D NFS4_OPEN_CLAIM_FH)
> > +                     fh =3D NFS_FH(d_inode(data->dentry));
> > +             nfs4_proc_getattr(server, fh, o_res->f_attr, NULL);
> >       }
> >       return 0;
> >  }
>
> Looks good, but why not just use o_arg->fh?  Maybe also an opportunity
> to fix the whitespace damage a few lines before this hunk too.
>

I did try it first. I had 2 problems with it. First of o_arg->fh is a
"const struct" so it wouldn't allow me to be assigned without casting.
Ok so perhaps it's not a big deal that we are going against the
"const". Second of all, when I did do that, it produced the following
warning and so I thought perhaps I should really use the original fh
instead of what's in the args:

Jul 13 17:25:32 localhost kernel: ------------[ cut here ]------------
Jul 13 17:25:32 localhost kernel: WARNING: CPU: 0 PID: 5458 at
fs/nfs/nfs4xdr.c:978 encode_string+0x4c/0x68 [nfsv4]
Jul 13 17:25:32 localhost kernel: Modules linked in: rpcsec_gss_krb5
auth_rpcgss nfsv4 dns_resolver nfs lockd grace uinput nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr
vsock_loopback vmw_vsock_virtio_transport_common
vmw_vsock_vmci_transport vsock sunrpc vfat fat vmw_vmci xfs libcrc32c
vmwgfx drm_ttm_helper ttm drm_kms_helper nvme crct10dif_ce sr_mod
cdrom sg syscopyarea nvme_core sysfillrect sysimgblt ghash_ce sha2_ce
e1000e drm sha256_arm64 sha1_ce nvme_common fuse
Jul 13 17:25:32 localhost kernel: CPU: 0 PID: 5458 Comm: cat Kdump:
loaded Not tainted 6.4.0-rc7+ #11
Jul 13 17:25:32 localhost kernel: Hardware name: VMware, Inc.
VMware20,1/VBSA, BIOS VMW201.00V.20904234.BA64.2212051119 12/05/2022
Jul 13 17:25:32 localhost kernel: pstate: 21400005 (nzCv daif +PAN
-UAO -TCO +DIT -SSBS BTYPE=3D--)
Jul 13 17:25:32 localhost kernel: pc : encode_string+0x4c/0x68 [nfsv4]
Jul 13 17:25:32 localhost kernel: lr : encode_string+0x30/0x68 [nfsv4]
Jul 13 17:25:32 localhost kernel: sp : ffff80000ccab400
Jul 13 17:25:32 localhost kernel: x29: ffff80000ccab400 x28:
ffff00008cadf008 x27: ffff0000866f4e30
Jul 13 17:25:32 localhost kernel: x26: 0000000000440000 x25:
0000000000000000 x24: ffff80000949f008
Jul 13 17:25:32 localhost kernel: x23: ffff800001200c30 x22:
ffff00008a4ef830 x21: ffff00008cadf018
Jul 13 17:25:32 localhost kernel: x20: ffff00008cadf01a x19:
0000000000000858 x18: 0000000000000000
Jul 13 17:25:32 localhost kernel: x17: 0000000000000000 x16:
0000000000000000 x15: 0000000000000000
Jul 13 17:25:32 localhost kernel: x14: ffffffffffffffff x13:
0000000000000007 x12: 93449b0e64a317a5
Jul 13 17:25:32 localhost kernel: x11: 00000006e6fbcafb x10:
0000000000000e10 x9 : ffff800001212040
Jul 13 17:25:32 localhost kernel: x8 : ffff00008a4ef8e0 x7 :
0000000000000007 x6 : 93449b0e64a317a5
Jul 13 17:25:32 localhost kernel: x5 : ffff00008824b08c x4 :
ffff000082196008 x3 : ffff80000ccab4c0
Jul 13 17:25:32 localhost kernel: x2 : 000000000000021c x1 :
000000000000085c x0 : 0000000000000000
Jul 13 17:25:32 localhost kernel: Call trace:
Jul 13 17:25:32 localhost kernel: encode_string+0x4c/0x68 [nfsv4]
Jul 13 17:25:32 localhost kernel: nfs4_xdr_enc_getattr+0xb0/0x108 [nfsv4]
Jul 13 17:25:32 localhost kernel: rpcauth_wrap_req_encode+0x20/0x38 [sunrpc=
]
Jul 13 17:25:32 localhost kernel: rpcauth_wrap_req+0x24/0x38 [sunrpc]
Jul 13 17:25:32 localhost kernel: call_encode+0x180/0x258 [sunrpc]
Jul 13 17:25:32 localhost kernel: __rpc_execute+0xb8/0x3e0 [sunrpc]
Jul 13 17:25:32 localhost kernel: rpc_execute+0x160/0x1d8 [sunrpc]
Jul 13 17:25:32 localhost kernel: rpc_run_task+0x148/0x1f8 [sunrpc]
Jul 13 17:25:32 localhost kernel: nfs4_do_call_sync+0x78/0xc8 [nfsv4]
Jul 13 17:25:32 localhost kernel: _nfs4_proc_getattr+0xe8/0x120 [nfsv4]
Jul 13 17:25:32 localhost kernel: nfs4_proc_getattr+0x7c/0x140 [nfsv4]
Jul 13 17:25:32 localhost kernel: _nfs4_open_and_get_state+0x1d8/0x460 [nfs=
v4]
Jul 13 17:25:32 localhost kernel: _nfs4_do_open.isra.0+0x140/0x408 [nfsv4]
Jul 13 17:25:32 localhost kernel: nfs4_do_open+0x9c/0x238 [nfsv4]
Jul 13 17:25:32 localhost kernel: nfs4_atomic_open+0x100/0x118 [nfsv4]
Jul 13 17:25:32 localhost kernel: nfs4_file_open+0x11c/0x240 [nfsv4]
Jul 13 17:25:32 localhost kernel: do_dentry_open+0x140/0x490
Jul 13 17:25:32 localhost kernel: vfs_open+0x30/0x38
Jul 13 17:25:32 localhost kernel: do_open+0x14c/0x360
Jul 13 17:25:32 localhost kernel: path_openat+0x104/0x250
Jul 13 17:25:32 localhost kernel: do_filp_open+0x84/0x138
Jul 13 17:25:32 localhost kernel: do_sys_openat2+0xb4/0x170
Jul 13 17:25:32 localhost kernel: __arm64_sys_openat+0x64/0xb0
Jul 13 17:25:32 localhost kernel: invoke_syscall.constprop.0+0x7c/0xd0
Jul 13 17:25:32 localhost kernel: el0_svc_common.constprop.0+0x13c/0x158
Jul 13 17:25:32 localhost kernel: do_el0_svc+0x38/0xa8
Jul 13 17:25:32 localhost kernel: el0_svc+0x3c/0x198
Jul 13 17:25:32 localhost kernel: el0t_64_sync_handler+0xb4/0x130
Jul 13 17:25:32 localhost kernel: el0t_64_sync+0x17c/0x180
Jul 13 17:25:32 localhost kernel: ---[ end trace 0000000000000000 ]---


> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>
> Ben
>
