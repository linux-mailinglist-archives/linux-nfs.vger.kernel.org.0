Return-Path: <linux-nfs+bounces-6167-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CFA96A2E8
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871301F27680
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD69188901;
	Tue,  3 Sep 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxSEITIc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2852185B7D;
	Tue,  3 Sep 2024 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377744; cv=none; b=rMg5RmAyWagN6zHd0WxuXDS0MphBmjYHytwsPLwTpHTd60G+Qq1dLOMZy53oDolOlRigMo8eEE/7/rSDm7GtB/QGX6bMqby8NTRqiOCrffKSAlpxXRkfbTNxykI30VnjUnrqBuFjPv5e7LqGHpgZKXH3n5RxoOxgKHMlHotXxfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377744; c=relaxed/simple;
	bh=cpxYhrHlCPOItvUzicbHplSDccA7aRDCqsYyfwNjKpQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTLs5E20bPpYyNn1m9K8tcdV1E4wywGTydnsh3HfjJRviSd6s22AOjK9oozQ83y+HgjrSD+EKYkX//hkU/NpAkqEKhqbR4gMk95IsWlWqWXDieuGqYW3+uIFOPwYY99snKeY4ja6nmShJMlzSr1GCnqTo4f5IrmRzEdzpaVtcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxSEITIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CC6C4CEC6;
	Tue,  3 Sep 2024 15:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377743;
	bh=cpxYhrHlCPOItvUzicbHplSDccA7aRDCqsYyfwNjKpQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uxSEITIckqUeeyjXSs1kfiU8z5q0r0eHsmvbLdPia8ULxJkptASSUIclt8/WQA80/
	 lw0kMusWXfckOB2b65cbpeooXlME1tFB0lWrSXq5XSJiBL58HLnywbkHELO6rQ8t/D
	 5ajc4KRSUi5ORicw8meuRF7+oG7sz8B8iigdSX/4Ckk7cZLjeUdINkaIjFkp31VbIK
	 t9YP787umEI39ZL3+JWDc9C5IWcI6VF6nSFMQzerEhvRYEnm/5fKsMCgDaqoACtQF8
	 7UHLx3FJFeDaNYKBQISr6QKjqUT8YWBDOW+0Y+Iut/7EYz1E1lOozmtHf4U3TedQ3z
	 aPX2oBbaI1NEg==
Message-ID: <45b981ea83a3661bf6c3fa52c98134040f48c737.camel@kernel.org>
Subject: Re: [PATCH] nfsd: return -EINVAL when namelen is 0
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Scott Mayhew <smayhew@redhat.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, neilb@suse.de,
 okorniev@redhat.com,  Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
 yukuai1@huaweicloud.com, houtao1@huawei.com,  yi.zhang@huawei.com,
 yangerkun@huawei.com, lilingfeng@huaweicloud.com
Date: Tue, 03 Sep 2024 11:35:41 -0400
In-Reply-To: <Ztcq9RB6SPhxbDl5@tissot.1015granger.net>
References: <20240903111446.659884-1-lilingfeng3@huawei.com>
	 <73d25d586d1306cd5820058f9062a79ca657d362.camel@kernel.org>
	 <Ztcq9RB6SPhxbDl5@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-03 at 11:27 -0400, Chuck Lever wrote:
> On Tue, Sep 03, 2024 at 07:23:18AM -0400, Jeff Layton wrote:
> > On Tue, 2024-09-03 at 19:14 +0800, Li Lingfeng wrote:
> > > When we have a corrupted main.sqlite in /var/lib/nfs/nfsdcld/, it may
> > > result in namelen being 0, which will cause memdup_user() to return
> > > ZERO_SIZE_PTR.
> > > When we access the name.data that has been assigned the value of
> > > ZERO_SIZE_PTR in nfs4_client_to_reclaim(), null pointer dereference i=
s
> > > triggered.
> > >=20
> > > [ T1205] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [ T1205] BUG: KASAN: null-ptr-deref in nfs4_client_to_reclaim+0xe9/0x=
260
> > > [ T1205] Read of size 1 at addr 0000000000000010 by task nfsdcld/1205
> > > [ T1205]
> > > [ T1205] CPU: 11 PID: 1205 Comm: nfsdcld Not tainted 5.10.0-00003-g2c=
1423731b8d #406
> > > [ T1205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/201=
4
> > > [ T1205] Call Trace:
> > > [ T1205]  dump_stack+0x9a/0xd0
> > > [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> > > [ T1205]  __kasan_report.cold+0x34/0x84
> > > [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> > > [ T1205]  kasan_report+0x3a/0x50
> > > [ T1205]  nfs4_client_to_reclaim+0xe9/0x260
> > > [ T1205]  ? nfsd4_release_lockowner+0x410/0x410
> > > [ T1205]  cld_pipe_downcall+0x5ca/0x760
> > > [ T1205]  ? nfsd4_cld_tracking_exit+0x1d0/0x1d0
> > > [ T1205]  ? down_write_killable_nested+0x170/0x170
> > > [ T1205]  ? avc_policy_seqno+0x28/0x40
> > > [ T1205]  ? selinux_file_permission+0x1b4/0x1e0
> > > [ T1205]  rpc_pipe_write+0x84/0xb0
> > > [ T1205]  vfs_write+0x143/0x520
> > > [ T1205]  ksys_write+0xc9/0x170
> > > [ T1205]  ? __ia32_sys_read+0x50/0x50
> > > [ T1205]  ? ktime_get_coarse_real_ts64+0xfe/0x110
> > > [ T1205]  ? ktime_get_coarse_real_ts64+0xa2/0x110
> > > [ T1205]  do_syscall_64+0x33/0x40
> > > [ T1205]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> > > [ T1205] RIP: 0033:0x7fdbdb761bc7
> > > [ T1205] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f =
00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 514
> > > [ T1205] RSP: 002b:00007fff8c4b7248 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
> > > [ T1205] RAX: ffffffffffffffda RBX: 000000000000042b RCX: 00007fdbdb7=
61bc7
> > > [ T1205] RDX: 000000000000042b RSI: 00007fff8c4b75f0 RDI: 00000000000=
00008
> > > [ T1205] RBP: 00007fdbdb761bb0 R08: 0000000000000000 R09: 00000000000=
00001
> > > [ T1205] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
0042b
> > > [ T1205] R13: 0000000000000008 R14: 00007fff8c4b75f0 R15: 00000000000=
00000
> > > [ T1205] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > Fix it by checking namelen.
> > >=20
> > > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > > ---
> > >  fs/nfsd/nfs4recover.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > > index 67d8673a9391..69a3a84e159e 100644
> > > --- a/fs/nfsd/nfs4recover.c
> > > +++ b/fs/nfsd/nfs4recover.c
> > > @@ -809,6 +809,10 @@ __cld_pipe_inprogress_downcall(const struct cld_=
msg_v2 __user *cmsg,
> > >  			ci =3D &cmsg->cm_u.cm_clntinfo;
> > >  			if (get_user(namelen, &ci->cc_name.cn_len))
> > >  				return -EFAULT;
> > > +			if (!namelen) {
> > > +				dprintk("%s: namelen should not be zero", __func__);
> > > +				return -EINVAL;
> > > +			}
> > >  			name.data =3D memdup_user(&ci->cc_name.cn_id, namelen);
> > >  			if (IS_ERR(name.data))
> > >  				return PTR_ERR(name.data);
> > > @@ -831,6 +835,10 @@ __cld_pipe_inprogress_downcall(const struct cld_=
msg_v2 __user *cmsg,
> > >  			cnm =3D &cmsg->cm_u.cm_name;
> > >  			if (get_user(namelen, &cnm->cn_len))
> > >  				return -EFAULT;
> > > +			if (!namelen) {
> > > +				dprintk("%s: namelen should not be zero", __func__);
> > > +				return -EINVAL;
> > > +			}
> > >  			name.data =3D memdup_user(&cnm->cn_id, namelen);
> > >  			if (IS_ERR(name.data))
> > >  				return PTR_ERR(name.data);
> >=20
> > This error will come back to nfsdcld in its downcall write(). -EINVAL
> > is a bit generic. It might be better to go with a more distinct error,
> > but I don't think it matters too much.
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> Wondering if
>=20
>    Fixes: 74725959c33c ("nfsd: un-deprecate nfsdcld")
>=20
> would be appropriate.
>=20
>=20

Hmm, 2019 patch. Are there any supported release streams that don't
have that commit?

Oh well, I guess it won't hurt anything to add it.
--=20
Jeff Layton <jlayton@kernel.org>

