Return-Path: <linux-nfs+bounces-9345-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F56A1550E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CFF1882B7D
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1B41A0711;
	Fri, 17 Jan 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="qucfbWN2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6019F41C
	for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132984; cv=none; b=UWmJnTeKDgUwPh+uCKawdlRWvvqWcF8Y7YPQJnjwssvrKfHGTOXyy1GPtZc0w9XBr0CHlPdwD/JZ6ZukDOBsPhRE1FOjcNYw6JlnZU57tUTPWDQ2PZJc/7S6aZEXwUeRBaRiKASarLqdwWHs7wyCZk9zVmR/mNUtrkDH9Up1MeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132984; c=relaxed/simple;
	bh=S1PYr4q1kLEgym5mRAh3UXjrlYS93fFY143RsVJGhbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VloDu93NkLX+Fkk9ADUzqPMO2983F4tJGi52Q42GQEHtiiFHs9tsLc8/ujzv1eUtPhhe4hCjftvVZOLkazTSmabON7wgJNubqPXM4CP88CJsVA8z+WL3W7qu9nZih+dR2X36S1inPe/49RZPs9gKExWkA1EAI8+zCQ93p3Y86Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=qucfbWN2; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30615661f98so24632731fa.2
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 08:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1737132980; x=1737737780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id/Ih0ZxnCYS0cSw4SPdRyp0OGPZZYm/0lcTUGrDefU=;
        b=qucfbWN2/EDbESQhwa9vyxsk3OitghmTzevHmwsse3vw0pACH/K3fJlZzoMsSp29yO
         AeG+Z00asbhITo0I7rbfkINZVmeGadatRgz2sdREbhra6I8NuTo6AKnuY5O+IzBQYiOW
         EhUadiOx5XSgLSeyf9t7pJaF8f542QjHkiPY5Xgx+dz8oock46EiGIp+Y6T5ku2wexC5
         +kNv5Hhb+yiGuxhwEa8/bBSPE0uEyscrCPOHODrICOQz4aoxcseN4LT0ZDA2ogYzOded
         vkHChthLg7mCMwn3dA8tnKh070N9nzczHHiPRB7e/owCMJ7f0h7dRn0v3jUk4Cz5fx2y
         Dl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132980; x=1737737780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=id/Ih0ZxnCYS0cSw4SPdRyp0OGPZZYm/0lcTUGrDefU=;
        b=T/O6SUHobm7iOmHcDeQguMyrb5Gle3T1q1rXQD9kOqSUry8qDrOILQtfFYg7beAY5j
         SOYOSsYnsTBWSj8KC+BMImOLwdkpbth5SiDsbixy/V87f5+FcQXiJ7KWbsgl8REApvcV
         FW0S3cBSHMdxJEsPDwMM9XGvDc1idBOj3uKSQv3i6lrL7a8GCwVBvwDfcKnkxgmNtGy6
         8E/IapuJTFw+3CMcLrq4qs0oEfaeCL8jUwdtWFF8W/giJG8BPoEn9pOpbwR+Hwgjr6FT
         q0QfNNitvLeRphaV8VEISzuMI8YAMg1bKbOMzySexMsRydQjdXL9ySM3Ia6nm9IvBjgj
         ekXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNabWZupHgA1hg4VV0SXkzfUe5FuaRfmWao2pKTCsQBtPMA26wk9qRqLx9/YcoPzVBU4pJWF9clVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHvtP8Vr4dxkk2W1ZBlYVTDfS3t7ht8CGPnPL6nS5m+ke83+g5
	7XhftQrHEgO2YreH2+mIAigShQiFZg0fW+x/p/z/yljGrgQrPY/T1gdiN5rNxwmyyCrOqaae/08
	lX09p/tyjVYkm+QNfL42nXhiXxl8=
X-Gm-Gg: ASbGncsHG75dnAyTwn4g1zjlSfFWXVuPi/09DSuDUzjXtV+zusCaV9Gtj/t/NxqPb49
	1pOqqp0JCDipFz1LVLGWe9InQShgY3UrW9IOWaRpNmwe+uhGfMmipHM+FdaMXatG54HWCd2My
X-Google-Smtp-Source: AGHT+IH0ww94dfGad8iIBshW9S7LUA7+U9bB0ewRBobOoPprIkQ2kr0yE1VyOA0BRnwzwMN0JGkuPT/DizCD3SWXZ9E=
X-Received: by 2002:a2e:b8c4:0:b0:300:33b1:f0e2 with SMTP id
 38308e7fff4ca-3072cab0cabmr12123671fa.3.1737132979699; Fri, 17 Jan 2025
 08:56:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117163258.52885-1-okorniev@redhat.com> <09fadc29312736c46951d61f42a33f30485bf562.camel@kernel.org>
In-Reply-To: <09fadc29312736c46951d61f42a33f30485bf562.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 17 Jan 2025 11:56:08 -0500
X-Gm-Features: AbW1kvYI14nc0Wb04i-Sj3Je9FsqFlXxr8jBgkERMSK3HKJiRZNjsr8UrkFp_Xo
Message-ID: <CAN-5tyGC2KCdoxwDtDhmWaX-50OneCg7xzBUDdocsAC0aC6mnA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: fix management of listener transports
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neilb@suse.de, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 11:43=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Fri, 2025-01-17 at 11:32 -0500, Olga Kornievskaia wrote:
> > Currently, when no active threads are running, a root user using nfsdct=
l
> > command can try to remove a particular listener from the list of previo=
usly
> > added ones, then start the server by increasing the number of threads,
> > it leads to the following problem:
> >
> > [  158.835354] refcount_t: addition on 0; use-after-free.
> > [  158.835603] WARNING: CPU: 2 PID: 9145 at lib/refcount.c:25 refcount_=
warn_saturate+0x160/0x1a0
> > [  158.836017] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core n=
fsd auth_rpcgss nfs_acl lockd grace overlay isofs uinput snd_seq_dummy snd_=
hrtimer nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_r=
eject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntra=
ck nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables qrtr sunrpc vfat f=
at uvcvideo videobuf2_vmalloc videobuf2_memops uvc videobuf2_v4l2 videodev =
videobuf2_common snd_hda_codec_generic mc e1000e snd_hda_intel snd_intel_ds=
pcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm sn=
d_timer snd soundcore sg loop dm_multipath dm_mod nfnetlink vsock_loopback =
vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock x=
fs libcrc32c crct10dif_ce ghash_ce vmwgfx sha2_ce sha256_arm64 sr_mod sha1_=
ce cdrom nvme drm_client_lib drm_ttm_helper ttm nvme_core drm_kms_helper nv=
me_auth drm fuse
> > [  158.840093] CPU: 2 UID: 0 PID: 9145 Comm: nfsd Kdump: loaded Tainted=
: G    B   W          6.13.0-rc6+ #7
> > [  158.840624] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
> > [  158.840802] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201=
.00V.24006586.BA64.2406042154 06/04/2024
> > [  158.841220] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BT=
YPE=3D--)
> > [  158.841563] pc : refcount_warn_saturate+0x160/0x1a0
> > [  158.841780] lr : refcount_warn_saturate+0x160/0x1a0
> > [  158.842000] sp : ffff800089be7d80
> > [  158.842147] x29: ffff800089be7d80 x28: ffff00008e68c148 x27: ffff000=
08e68c148
> > [  158.842492] x26: ffff0002e3b5c000 x25: ffff600011cd1829 x24: ffff000=
08653c010
> > [  158.842832] x23: ffff00008653c000 x22: 1fffe00011cd1829 x21: ffff000=
08653c028
> > [  158.843175] x20: 0000000000000002 x19: ffff00008653c010 x18: 0000000=
000000000
> > [  158.843505] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000=
000000000
> > [  158.843836] x14: 0000000000000000 x13: 0000000000000001 x12: ffff600=
050a26493
> > [  158.844143] x11: 1fffe00050a26492 x10: ffff600050a26492 x9 : dfff800=
000000000
> > [  158.844475] x8 : 00009fffaf5d9b6e x7 : ffff000285132493 x6 : 0000000=
000000001
> > [  158.844823] x5 : ffff000285132490 x4 : ffff600050a26493 x3 : ffff800=
0805e72bc
> > [  158.845174] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000=
098588000
> > [  158.845528] Call trace:
> > [  158.845658]  refcount_warn_saturate+0x160/0x1a0 (P)
> > [  158.845894]  svc_recv+0x58c/0x680 [sunrpc]
> > [  158.846183]  nfsd+0x1fc/0x348 [nfsd]
> > [  158.846390]  kthread+0x274/0x2f8
> > [  158.846546]  ret_from_fork+0x10/0x20
> > [  158.846714] ---[ end trace 0000000000000000 ]---
> >
> > nfsd_nl_listener_set_doit() would manipulate the list of transports of
> > server's sv_permsocks and close the specified listener but the other
> > list of transports (server's sp_xprts list) would not be changed leadin=
g
> > to the problem above.
> >
> > Instead, determined if the nfsdctl is trying to remove a listener, in
> > which case, delete all the existing listener transports and re-create
> > all-but-the-removed ones.
> >
> > Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfsctl.c | 41 ++++++++++++++++++-----------------------
> >  1 file changed, 18 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 95ea4393305b..079c1fe2eee7 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1918,6 +1918,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb=
, struct genl_info *info)
> >       LIST_HEAD(permsocks);
> >       struct nfsd_net *nn;
> >       int err, rem;
> > +     bool delete =3D false;
> >
> >       mutex_lock(&nfsd_mutex);
> >
> > @@ -1977,35 +1978,26 @@ int nfsd_nl_listener_set_doit(struct sk_buff *s=
kb, struct genl_info *info)
> >               }
> >       }
> >
> > -     /* For now, no removing old sockets while server is running */
> > -     if (serv->sv_nrthreads && !list_empty(&permsocks)) {
> > +     /* If we have listener transports left on permsocks list, it mean=
s
> > +      * we are asked to remove a listener
> > +      */
> > +     if (!list_empty(&permsocks)) {
> >               list_splice_init(&permsocks, &serv->sv_permsocks);
> > -             spin_unlock_bh(&serv->sv_lock);
> > -             err =3D -EBUSY;
> > -             goto out_unlock_mtx;
> > +             delete =3D true;
> >       }
> > +     spin_unlock_bh(&serv->sv_lock);
> >
> > -     /* Close the remaining sockets on the permsocks list */
> > -     while (!list_empty(&permsocks)) {
> > -             xprt =3D list_first_entry(&permsocks, struct svc_xprt, xp=
t_list);
> > -             list_move(&xprt->xpt_list, &serv->sv_permsocks);
> > -
> > -             /*
> > -              * Newly-created sockets are born with the BUSY bit set. =
Clear
> > -              * it if there are no threads, since nothing can pick it =
up
> > -              * in that case.
> > +     /* Not removing old listener transports while server is running *=
/
> > +     if (serv->sv_nrthreads) {
> > +             err =3D -EBUSY;
> > +             goto out_unlock_mtx;
> > +     } else if (delete) {
> > +             /* since we can't delete a single entry, we will destroy
> > +              * all remaining listeners and recreate the list
> >                */
> > -             if (!serv->sv_nrthreads)
> > -                     clear_bit(XPT_BUSY, &xprt->xpt_flags);
> > -
> > -             set_bit(XPT_CLOSE, &xprt->xpt_flags);
> > -             spin_unlock_bh(&serv->sv_lock);
> > -             svc_xprt_close(xprt);
> > -             spin_lock_bh(&serv->sv_lock);
> > +             svc_xprt_destroy_all(serv, net);
> >       }
> >
> > -     spin_unlock_bh(&serv->sv_lock);
> > -
> >       /* walk list of addrs again, open any that still don't exist */
> >       nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> >               struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
> > @@ -2031,6 +2023,9 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb=
, struct genl_info *info)
> >
> >               xprt =3D svc_find_listener(serv, xcl_name, net, sa);
> >               if (xprt) {
> > +                     if (delete)
> > +                             WARN_ONCE("Transport type=3D%s already ex=
ists\n",
> > +                                       xcl_name);
> >                       svc_xprt_put(xprt);
> >                       continue;
> >               }
>
> This does seem a bit safer than trying to dequeue a since entry from
> the lwq.

To be honest I don't understand the value in being able to remove a
listener. There has to be no active threads. Then somebody has to do
nfsdctl listener +<protocol>... but then decide oh wait I dont need it
and do listener -<protocol>... then increase the thread count. They
can (-) listener by running "nfsdctl threads 0" again and that clears
all the listeners anyway.

Is the ultimate goal to remove a listener on an active server? If
there isn't such a goal, it seems better to remove the ability
altogether.

>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>

