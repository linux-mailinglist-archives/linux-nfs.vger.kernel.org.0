Return-Path: <linux-nfs+bounces-16236-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2675EC49CAA
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 00:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EE674F0604
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 23:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7AF2F691F;
	Mon, 10 Nov 2025 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TMHd2hFq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840821B196;
	Mon, 10 Nov 2025 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817931; cv=none; b=gki2rwmjgGUez8+9u7hhrgCyQRn09InCkVnuq9TR8DOnTtWlfHgOjEkMPpwJszZlpCQVZcHpJyqji7DwdIxc3hk/ex9i9FKhG4F9cvAHoIJkt49Zx6wl+zNxtkNY8OUO5a1MoTm3a5hEiBtPyOwNcI2gkH4BQvLd8/locAtPVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817931; c=relaxed/simple;
	bh=sR43zrzrdmlvoBwZ64SsCIgT5y5AVagDKmg9rPhaoxU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Z2IoC4s+PIug6fAQcpn/q82ZZ3Rw9rkw8f2MEX3J+lSlWEeZB5XIqXC6sQN/bXSVfToiYY+k1lNNx27xlVHo5TDYbz8iPgCd+6dtMURJf/v5r3l+9xGQWEFbukrsSKbb9yQ8quEc4u4s93GWXfPjkuuU9iVGGLM1+PJbwF2bryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TMHd2hFq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1762817918;
	bh=9+n8g7Oe9NC8CoA1EbspLz1bfjTzk0COygqpR6OrGWs=;
	h=Date:From:To:Cc:Subject:From;
	b=TMHd2hFqVdpC/DVSfVnmat3/dUC/bZpxo/YLMSqzt8eDSwy8vSXtk21YTg1EtQfPR
	 Bk4jMUcDeWFAEoGfaJZ44scMuTI+g3KJzqfFwawOg+RLiJLwK2HzP2S6s6VC00d0G6
	 quRPFMV981VFgGjyGLlIPIFc9zLDBcYLbVhEV8Y4hEKPZNzcRYFmmYJwqKvGRKnCJz
	 F/ci82lOtwUXf4Ph9EL4DABe+Dzk/qTDjJDwgONeFv6XOkFvJkJQmcNM2VMQek7oV8
	 7KPH6nBY1k0GvOvJulpJcaU3WZasvc/+JO+tLlgoiyg95ew9E7Biq7GHUsya8+ngGA
	 lih91MUZpr1dg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4d55hZ4kggz4wBD;
	Tue, 11 Nov 2025 10:38:38 +1100 (AEDT)
Date: Tue, 11 Nov 2025 10:38:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Anna Schumaker
 <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Mike Snitzer
 <snitzer@kernel.org>, NFS Mailing List <linux-nfs@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the nfs-anna
 tree
Message-ID: <20251111103837.0ecdf26d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TDV1KL+3TQeTorugdiyX=w5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TDV1KL+3TQeTorugdiyX=w5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/nfs/localio.c

between commits:

  51a491f2708d ("nfs/localio: remove unecessary ENOTBLK handling in DIO WRI=
TE support")
  f2060bdc21d7 ("nfs/localio: add refcounting for each iocb IO associated w=
ith NFS pgio header")
  d0497dd27452 ("nfs/localio: backfill missing partial read support for mis=
aligned DIO")
  6a218b9c3183 ("nfs/localio: do not issue misaligned DIO out-of-order")

from the nfs-anna tree and commit:

  94afb627dfc2 ("nfs: use credential guards in nfs_local_call_read()")

from the vfs-brauner tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/nfs/localio.c
index 656976b4f42c,0c89a9d1e089..000000000000
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@@ -620,37 -595,30 +620,34 @@@ static void nfs_local_call_read(struct=20
  	struct nfs_local_kiocb *iocb =3D
  		container_of(work, struct nfs_local_kiocb, work);
  	struct file *filp =3D iocb->kiocb.ki_filp;
- 	const struct cred *save_cred;
 +	bool force_done =3D false;
  	ssize_t status;
 +	int n_iters;
 =20
- 	save_cred =3D override_creds(filp->f_cred);
+ 	scoped_with_creds(filp->f_cred) {
 -		for (int i =3D 0; i < iocb->n_iters ; i++) {
++		n_iters =3D atomic_read(&iocb->n_iters);
++		for (int i =3D 0; i < n_iters ; i++) {
+ 			if (iocb->iter_is_dio_aligned[i]) {
+ 				iocb->kiocb.ki_flags |=3D IOCB_DIRECT;
 -				iocb->kiocb.ki_complete =3D nfs_local_read_aio_complete;
 -				iocb->aio_complete_work =3D nfs_local_read_aio_complete_work;
 -			}
++				/* Only use AIO completion if DIO-aligned segment is last */
++				if (i =3D=3D iocb->end_iter_index) {
++					iocb->kiocb.ki_complete =3D nfs_local_read_aio_complete;
++					iocb->aio_complete_work =3D nfs_local_read_aio_complete_work;
++				}
++			} else
++				iocb->kiocb.ki_flags &=3D ~IOCB_DIRECT;
 =20
- 	n_iters =3D atomic_read(&iocb->n_iters);
- 	for (int i =3D 0; i < n_iters ; i++) {
- 		if (iocb->iter_is_dio_aligned[i]) {
- 			iocb->kiocb.ki_flags |=3D IOCB_DIRECT;
- 			/* Only use AIO completion if DIO-aligned segment is last */
- 			if (i =3D=3D iocb->end_iter_index) {
- 				iocb->kiocb.ki_complete =3D nfs_local_read_aio_complete;
- 				iocb->aio_complete_work =3D nfs_local_read_aio_complete_work;
- 			}
- 		} else
- 			iocb->kiocb.ki_flags &=3D ~IOCB_DIRECT;
-=20
- 		status =3D filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
- 		if (status !=3D -EIOCBQUEUED) {
- 			if (unlikely(status >=3D 0 && status < iocb->iters[i].count))
- 				force_done =3D true; /* Partial read */
- 			if (nfs_local_pgio_done(iocb, status, force_done)) {
- 				nfs_local_read_iocb_done(iocb);
- 				break;
 -			iocb->kiocb.ki_pos =3D iocb->offset[i];
+ 			status =3D filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
+ 			if (status !=3D -EIOCBQUEUED) {
 -				nfs_local_pgio_done(iocb->hdr, status);
 -				if (iocb->hdr->task.tk_status)
++				if (unlikely(status >=3D 0 && status < iocb->iters[i].count))
++					force_done =3D true; /* Partial read */
++				if (nfs_local_pgio_done(iocb, status, force_done)) {
++					nfs_local_read_iocb_done(iocb);
+ 					break;
++				}
  			}
  		}
  	}
--
- 	revert_creds(save_cred);
 -	if (status !=3D -EIOCBQUEUED) {
 -		nfs_local_read_done(iocb, status);
 -		nfs_local_pgio_release(iocb);
 -	}
  }
 =20
  static int
@@@ -820,47 -781,78 +817,55 @@@ static void nfs_local_write_aio_complet
  	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_write_aio_complete=
_work */
  }
 =20
- static void nfs_local_call_write(struct work_struct *work)
+ static ssize_t do_nfs_local_call_write(struct nfs_local_kiocb *iocb,
+ 				       struct file *filp)
  {
- 	struct nfs_local_kiocb *iocb =3D
- 		container_of(work, struct nfs_local_kiocb, work);
- 	struct file *filp =3D iocb->kiocb.ki_filp;
- 	unsigned long old_flags =3D current->flags;
- 	const struct cred *save_cred;
 +	bool force_done =3D false;
  	ssize_t status;
 +	int n_iters;
 =20
- 	current->flags |=3D PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
- 	save_cred =3D override_creds(filp->f_cred);
-=20
  	file_start_write(filp);
 -	for (int i =3D 0; i < iocb->n_iters ; i++) {
 +	n_iters =3D atomic_read(&iocb->n_iters);
 +	for (int i =3D 0; i < n_iters ; i++) {
  		if (iocb->iter_is_dio_aligned[i]) {
  			iocb->kiocb.ki_flags |=3D IOCB_DIRECT;
 -			iocb->kiocb.ki_complete =3D nfs_local_write_aio_complete;
 -			iocb->aio_complete_work =3D nfs_local_write_aio_complete_work;
 -		}
 -retry:
 -		iocb->kiocb.ki_pos =3D iocb->offset[i];
 +			/* Only use AIO completion if DIO-aligned segment is last */
 +			if (i =3D=3D iocb->end_iter_index) {
 +				iocb->kiocb.ki_complete =3D nfs_local_write_aio_complete;
 +				iocb->aio_complete_work =3D nfs_local_write_aio_complete_work;
 +			}
 +		} else
 +			iocb->kiocb.ki_flags &=3D ~IOCB_DIRECT;
 +
  		status =3D filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
  		if (status !=3D -EIOCBQUEUED) {
 -			if (unlikely(status >=3D 0 && status < iocb->iters[i].count)) {
 -				/* partial write */
 -				if (i =3D=3D iocb->end_iter_index) {
 -					/* Must not account partial end, otherwise, due
 -					 * to end being issued before middle: the partial
 -					 * write accounting in nfs_local_write_done()
 -					 * would incorrectly advance hdr->args.offset
 -					 */
 -					status =3D 0;
 -				} else {
 -					/* Partial write at start or buffered middle,
 -					 * exit early.
 -					 */
 -					nfs_local_pgio_done(iocb->hdr, status);
 -					break;
 -				}
 -			} else if (unlikely(status =3D=3D -ENOTBLK &&
 -					    (iocb->kiocb.ki_flags & IOCB_DIRECT))) {
 -				/* VFS will return -ENOTBLK if DIO WRITE fails to
 -				 * invalidate the page cache. Retry using buffered IO.
 -				 */
 -				iocb->kiocb.ki_flags &=3D ~IOCB_DIRECT;
 -				iocb->kiocb.ki_complete =3D NULL;
 -				iocb->aio_complete_work =3D NULL;
 -				goto retry;
 -			}
 -			nfs_local_pgio_done(iocb->hdr, status);
 -			if (iocb->hdr->task.tk_status)
 +			if (unlikely(status >=3D 0 && status < iocb->iters[i].count))
 +				force_done =3D true; /* Partial write */
 +			if (nfs_local_pgio_done(iocb, status, force_done)) {
 +				nfs_local_write_iocb_done(iocb);
  				break;
 +			}
  		}
  	}
  	file_end_write(filp);
 =20
- 	revert_creds(save_cred);
+ 	return status;
+ }
+=20
+ static void nfs_local_call_write(struct work_struct *work)
+ {
+ 	struct nfs_local_kiocb *iocb =3D
+ 		container_of(work, struct nfs_local_kiocb, work);
+ 	struct file *filp =3D iocb->kiocb.ki_filp;
+ 	unsigned long old_flags =3D current->flags;
+ 	ssize_t status;
+=20
+ 	current->flags |=3D PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
+=20
+ 	scoped_with_creds(filp->f_cred)
+ 		status =3D do_nfs_local_call_write(iocb, filp);
+=20
  	current->flags =3D old_flags;
 -
 -	if (status !=3D -EIOCBQUEUED) {
 -		nfs_local_write_done(iocb, status);
 -		nfs_local_vfs_getattr(iocb);
 -		nfs_local_pgio_release(iocb);
 -	}
  }
 =20
  static int

--Sig_/TDV1KL+3TQeTorugdiyX=w5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmkSd30ACgkQAVBC80lX
0GwQ8Qf+JNBhJW3HHY9s99XWPThbcmK/3t6eMDCUnS9dUKhIyD0jTAkoe2ugAX+o
EEaAycevgrLcaUDWjXFN8kak3CARIfgZbLUDmoH5pL9oL5KfeQxSP6RO+Pb9C32h
srguHNv0E8KJglMpFXxwtFJN9npR2Ce+FudgfdouseCFKxLP26VLd/EpsDDaiXbu
y9shhSUD8Fyq3RtUbWp7wr5gF+mQz/+7LTlpp7LW/YFs9depCeMg9I0t9dErzUue
fJz9VB9wACvrIcBplZMbGxpy3yf9u4ap0tz6jDa6jqK3dQTPHE1ok6lgOGnE5Aw6
gtvGRLgzEeqN5tlEtQJmgGKSHrRTaw==
=4z7x
-----END PGP SIGNATURE-----

--Sig_/TDV1KL+3TQeTorugdiyX=w5--

