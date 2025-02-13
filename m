Return-Path: <linux-nfs+bounces-10080-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1AA33F35
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 13:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17219161A40
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1961E86E;
	Thu, 13 Feb 2025 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLZdKOKB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE30227E90;
	Thu, 13 Feb 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450057; cv=none; b=lo0erzQbzKzvdvqOspHC0JcX6qtjRmJ09Uc0LuB/u3XPunqfvnTQZCOkgypSeeMw9sfkuail2DC1ExUff6nCMmaILptbBJGeGLs/5u5fG09s0Y05j54bkEPyXP6tsFSsfZV3xMK2wHz4bG1hANDETWZZX7LCSeQR4pXLCzZwvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450057; c=relaxed/simple;
	bh=Rlklv7dis1m5I3+W2vsCMfTfiQ0cg681MxJRqeW4QvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHyfbUjshdc3jggiynuK+6pYx/emZxI3WNe72VXhhPLsRwbZiIO+FYqrnMhxPfBuAsbygRk7sNLZYUDB47W/+EDDpN9aJoly4yVoeP7Mrw6AXr2jlt1KSMIEoFZAru8UP7Wu0hANrpsXnU5Yx1GPb2yMCLHdgJRPCPyHTkrf8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLZdKOKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3735C4CED1;
	Thu, 13 Feb 2025 12:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739450054;
	bh=Rlklv7dis1m5I3+W2vsCMfTfiQ0cg681MxJRqeW4QvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cLZdKOKBFNVZDAzdBU9llTQQ4nFYOOwjzmQ4Y7cqxqY4bBuoMZ7FAkY7BrKV/agF0
	 Usg3I/tE4r2J36IPcXL+SPgCppdnZKT6ePqOLoRJhNZFElwmKpWSfW8+iLwZaToDzV
	 DMFo2UX2obhBbxjqO9T7KeX3k27CXf7HmjvZOCxUefAzOsrGZVNEDvDxcu33VQGowN
	 9xDCw8dBMxbLfXH7M40rwxXGZ3+G4w4WGK+3y6tq+BK29ihz5qeR8qe2UPUAJSdcPU
	 8f+Q7+ILG0hworDhAcDNkEFH9hlk3q3BsZZzGoaWg40VztYAQ2X31MZ7kVwev2zIcW
	 aRGlImqAOg6Hw==
Message-ID: <c29d47560629ca8866b0604abba60fda96ac0fbb.camel@kernel.org>
Subject: Re: [PATCH] nfsd: put dl_stid if fail to queue dl_recall
From: Jeff Layton <jlayton@kernel.org>
To: Li Lingfeng <lilingfeng3@huawei.com>, chuck.lever@oracle.com,
 neilb@suse.de, 	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, lilingfeng@huaweicloud.com
Date: Thu, 13 Feb 2025 07:34:12 -0500
In-Reply-To: <d4c3b347-477f-4016-8093-edac22213cec@huawei.com>
References: <20250213072536.69986-1-lilingfeng3@huawei.com>
	 <7df4de2bff617dc5c2bb482df6dbc5ef21ba0d01.camel@kernel.org>
	 <d4c3b347-477f-4016-8093-edac22213cec@huawei.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-13 at 20:28 +0800, Li Lingfeng wrote:
> =E5=9C=A8 2025/2/13 19:49, Jeff Layton =E5=86=99=E9=81=93:
> > On Thu, 2025-02-13 at 15:25 +0800, Li Lingfeng wrote:
> > > Before calling nfsd4_run_cb to queue dl_recall to the callback_wq, we
> > > increment the reference count of dl_stid.
> > > We expect that after the corresponding work_struct is processed, the
> > > reference count of dl_stid will be decremented through the callback
> > > function nfsd4_cb_recall_release.
> > > However, if the call to nfsd4_run_cb fails, the incremented reference
> > > count of dl_stid will not be decremented correspondingly, leading to =
the
> > > following nfs4_stid leak:
> > > unreferenced object 0xffff88812067b578 (size 344):
> > >    comm "nfsd", pid 2761, jiffies 4295044002 (age 5541.241s)
> > >    hex dump (first 32 bytes):
> > >      01 00 00 00 6b 6b 6b 6b b8 02 c0 e2 81 88 ff ff  ....kkkk.......=
.
> > >      00 6b 6b 6b 6b 6b 6b 6b 00 00 00 00 ad 4e ad de  .kkkkkkk.....N.=
.
> > >    backtrace:
> > >      kmem_cache_alloc+0x4b9/0x700
> > >      nfsd4_process_open1+0x34/0x300
> > >      nfsd4_open+0x2d1/0x9d0
> > >      nfsd4_proc_compound+0x7a2/0xe30
> > >      nfsd_dispatch+0x241/0x3e0
> > >      svc_process_common+0x5d3/0xcc0
> > >      svc_process+0x2a3/0x320
> > >      nfsd+0x180/0x2e0
> > >      kthread+0x199/0x1d0
> > >      ret_from_fork+0x30/0x50
> > >      ret_from_fork_asm+0x1b/0x30
> > > unreferenced object 0xffff8881499f4d28 (size 368):
> > >    comm "nfsd", pid 2761, jiffies 4295044005 (age 5541.239s)
> > >    hex dump (first 32 bytes):
> > >      01 00 00 00 00 00 00 00 30 4d 9f 49 81 88 ff ff  ........0M.I...=
.
> > >      30 4d 9f 49 81 88 ff ff 20 00 00 00 01 00 00 00  0M.I.... ......=
.
> > >    backtrace:
> > >      kmem_cache_alloc+0x4b9/0x700
> > >      nfs4_alloc_stid+0x29/0x210
> > >      alloc_init_deleg+0x92/0x2e0
> > >      nfs4_set_delegation+0x284/0xc00
> > >      nfs4_open_delegation+0x216/0x3f0
> > >      nfsd4_process_open2+0x2b3/0xee0
> > >      nfsd4_open+0x770/0x9d0
> > >      nfsd4_proc_compound+0x7a2/0xe30
> > >      nfsd_dispatch+0x241/0x3e0
> > >      svc_process_common+0x5d3/0xcc0
> > >      svc_process+0x2a3/0x320
> > >      nfsd+0x180/0x2e0
> > >      kthread+0x199/0x1d0
> > >      ret_from_fork+0x30/0x50
> > >      ret_from_fork_asm+0x1b/0x30
> > > Fix it by checking the result of nfsd4_run_cb and call nfs4_put_stid =
if
> > > fail to queue dl_recall.
> > >=20
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> > > ---
> > >   fs/nfsd/nfs4state.c | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 153eeea2c7c9..0ccb87be47b7 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -5414,6 +5414,7 @@ static const struct nfsd4_callback_ops nfsd4_cb=
_recall_ops =3D {
> > >  =20
> > >   static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
> > >   {
> > > +	bool queued;
> > >   	/*
> > >   	 * We're assuming the state code never drops its reference
> > >   	 * without first removing the lease.  Since we're in this lease
> > > @@ -5422,7 +5423,10 @@ static void nfsd_break_one_deleg(struct nfs4_d=
elegation *dp)
> > >   	 * we know it's safe to take a reference.
> > >   	 */
> > >   	refcount_inc(&dp->dl_stid.sc_count);
> > > -	WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
> > > +	queued =3D nfsd4_run_cb(&dp->dl_recall);
> > > +	WARN_ON_ONCE(!queued);
> > > +	if (!queued)
> > > +		nfs4_put_stid(&dp->dl_stid);
> > >   }
> > >  =20
> > >   /* Called from break_lease() with flc_lock held. */
> >=20
> > Have you actually seen the WARN_ON_ONCE() pop under normal usage, or
> > was the problem you reproduced done via fault injection?
>=20
> Hi,
>=20
> I add mdelay for cb_work before processing it and add msleep in=20
> nfs_do_return_delegation to reproduce it.
>=20
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1188,6 +1188,8 @@ alloc_init_deleg(struct nfs4_client *clp, struct=
=20
> nfs4_file *fp,
>  =C2=A0=C2=A0=C2=A0=C2=A0 dp->dl_recalled =3D false;
>  =C2=A0=C2=A0=C2=A0=C2=A0 nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_cl=
ient,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
> +=C2=A0=C2=A0=C2=A0 dp->dl_recall.cb_work.debug_flag =3D 0x1234;
> +=C2=A0=C2=A0=C2=A0 printk("%s init work func %px\n", __func__,=20
> dp->dl_recall.cb_work.func);
>  =C2=A0=C2=A0=C2=A0=C2=A0 get_nfs4_file(fp);
>  =C2=A0=C2=A0=C2=A0=C2=A0 dp->dl_stid.sc_file =3D fp;
>  =C2=A0=C2=A0=C2=A0=C2=A0 return dp;
>=20
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2708,6 +2708,12 @@ static void process_scheduled_works(struct worker=
=20
> *worker)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 worker->pool->watchdog_ts =3D jiffies;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 first =3D false;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (work->debug_flag =3D=3D 0=
x1234) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print=
k("%s func %px\n", __func__, work->func);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print=
k("%s delay before clear pending...\n", __func__);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mdela=
y(10 * 1000);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print=
k("%s delay done\n", __func__);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 process_one_work(worker=
, work);
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0}
>=20
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -263,6 +263,15 @@ static int nfs_do_return_delegation(struct inode=20
> *inode, struct nfs_delegation *
>  =C2=A0=C2=A0=C2=A0=C2=A0 const struct cred *cred;
>  =C2=A0=C2=A0=C2=A0=C2=A0 int res =3D 0;
>=20
> +=C2=A0=C2=A0=C2=A0 printk("sleep before deleg return...\n");
> +=C2=A0=C2=A0=C2=A0 while (1) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ifdebug(PROC)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mslee=
p(10 * 1000);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break=
;
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 printk("sleep done\n");
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bit(NFS_DELEGATION_REVOKED, &delegati=
on-flags)) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&delegation->=
lock);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cred =3D get_cred(deleg=
ation->cred);
>=20
> > Unfortunately, this won't work. nfsd_break_one_deleg() is called from
> > the ->break_lease callback with the flc->flc_lock held, and
> > nfs4_put_stid can sleep in the sc_free callbacks.
>=20
> Are you referring to nfs4_free_deleg? I didn't quite see where it might=
=20
> sleep. Could you please explain it to me?
>=20

I stand corrected. nfs4_free_deleg() won't sleep, but
nfs4_free_lock_stateid() can. In this case, you know that this is a
deleg stateid, so this should actually be safe after all.

If you do this though, please add a comment to nfs4_free_deleg()
mentioning that it mustn't ever sleep, since it can be called from that
context.
--=20
Jeff Layton <jlayton@kernel.org>

