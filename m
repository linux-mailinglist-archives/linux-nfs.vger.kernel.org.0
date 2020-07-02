Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A7B211736
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2020 02:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGBAat (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 20:30:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:38434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgGBAas (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Jul 2020 20:30:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28BF2AD4A;
        Thu,  2 Jul 2020 00:30:47 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Date:   Thu, 02 Jul 2020 10:30:40 +1000
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: simplify inode_dio_begin/end calls.
In-Reply-To: <20200624175408.74678-1-olga.kornievskaia@gmail.com>
References: <20200624175408.74678-1-olga.kornievskaia@gmail.com>
Message-ID: <87366a3gi7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


As a recent patch highlighted, inode_dio_end() must be called after
nfs_direct_req_release() is called.
It would make the code more robust if nfs_direct_req_release() did that
call itself, placing it after put_nfs_open_context().

To achieve this:
 - move the inode_dio_begin() calls to the moment when a
   'struct nfs_direct_req' is allocated,
 - move the inode_dio_end() calls to just before the
   'struct nfs_direct_req' is freed,
 - use igrab to make req->inode a counted reference so that
   it can be used after put_nfs_open_context() (which calls
   dput(), that releasing the only reference we previously held
   on the inode).

This patch doesn't change behaviour at all, it just simplifies the code
a little.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/nfs/direct.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 3d113cf8908a..ab32b23639d3 100644
=2D-- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -221,6 +221,8 @@ static void nfs_direct_req_free(struct kref *kref)
 		nfs_put_lock_context(dreq->l_ctx);
 	if (dreq->ctx !=3D NULL)
 		put_nfs_open_context(dreq->ctx);
+	inode_dio_end(dreq->inode);
+	iput(dreq->inode);
 	kmem_cache_free(nfs_direct_cachep, dreq);
 }
=20
@@ -278,10 +280,7 @@ static void nfs_direct_complete(struct nfs_direct_req =
*dreq)
=20
 	complete(&dreq->completion);
=20
=2D	igrab(inode);
 	nfs_direct_req_release(dreq);
=2D	inode_dio_end(inode);
=2D	iput(inode);
 }
=20
 static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
@@ -359,7 +358,6 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nf=
s_direct_req *dreq,
 			     &nfs_direct_read_completion_ops);
 	get_dreq(dreq);
 	desc.pg_dreq =3D dreq;
=2D	inode_dio_begin(inode);
=20
 	while (iov_iter_count(iter)) {
 		struct page **pagevec;
@@ -411,10 +409,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct n=
fs_direct_req *dreq,
 	 * generic layer handle the completion.
 	 */
 	if (requested_bytes =3D=3D 0) {
=2D		igrab(inode);
 		nfs_direct_req_release(dreq);
=2D		inode_dio_end(inode);
=2D		iput(inode);
 		return result < 0 ? result : -EIO;
 	}
=20
@@ -467,7 +462,8 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct=
 iov_iter *iter)
 	if (dreq =3D=3D NULL)
 		goto out;
=20
=2D	dreq->inode =3D inode;
+	dreq->inode =3D igrab(inode);
+	inode_dio_begin(inode);
 	dreq->bytes_left =3D dreq->max_count =3D count;
 	dreq->io_start =3D iocb->ki_pos;
 	dreq->ctx =3D get_nfs_open_context(nfs_file_open_context(iocb->ki_filp));
@@ -807,7 +803,6 @@ static ssize_t nfs_direct_write_schedule_iovec(struct n=
fs_direct_req *dreq,
 			      &nfs_direct_write_completion_ops);
 	desc.pg_dreq =3D dreq;
 	get_dreq(dreq);
=2D	inode_dio_begin(inode);
=20
 	NFS_I(inode)->write_io +=3D iov_iter_count(iter);
 	while (iov_iter_count(iter)) {
@@ -867,10 +862,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct =
nfs_direct_req *dreq,
 	 * generic layer handle the completion.
 	 */
 	if (requested_bytes =3D=3D 0) {
=2D		igrab(inode);
 		nfs_direct_req_release(dreq);
=2D		inode_dio_end(inode);
=2D		iput(inode);
 		return result < 0 ? result : -EIO;
 	}
=20
@@ -929,7 +921,8 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struc=
t iov_iter *iter)
 	if (!dreq)
 		goto out;
=20
=2D	dreq->inode =3D inode;
+	dreq->inode =3D igrab(inode);
+	inode_dio_begin(inode);
 	dreq->bytes_left =3D dreq->max_count =3D count;
 	dreq->io_start =3D pos;
 	dreq->ctx =3D get_nfs_open_context(nfs_file_open_context(iocb->ki_filp));
=2D-=20
2.26.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl79KrAACgkQOeye3VZi
gbluQBAAjNhXPN7XLRmihIeYKqj8GCMUxGz99oFKiXKAmQN1KXS/AvWggBFNmSJB
3pWLEBFztBst/+5XzIu13FyBZVJ2WHyYHviN4xDXPKdVj2WWyr7z/AAFO1nMQmzO
DRuBn2ydlBgxc6bqjAABJEZxENAtgn7NpCwPd5z7d26UgmOpl4pGX8iuTcNK/AA5
n3/2OhqqhUnsyoxf8FoNjEn8wDtboE1AYYA1JeXov7r9kl84+fBQ9CftvgNMsiIU
v6vlptxL3Nt0Dj8gs36slUWWHjmBG8QjMET0Db4a/TGxmVdljazszSRmYDssZdlL
9GE1Iv0wvcj2q+3kxPVLpBP6ZXJWB+wtBz2igSDDmBPlwmJqsxhv68ZgT/dEAdoY
BaFWRjTlELKGKPt66f9sdIGw+kZlTy/3TuerK4fec6ChgS6u1ScUzIeEmMlNpbNd
HsDJJNz1KtMa/uvz0aFWrWYdxLb2miIbK9Wozq9HawEGrmRXS8wbRMquh9XAFtj+
3mHvfYFKCeEfAlL/+zSmApd1HuW83esltdO5pWQA+D/6BTmbKgC71CkyEaQGWo53
H+MD9PLLc1TPWXf6d8GbeFRoAiHpz714njDhoycpDJVEapyx/hzQyegUSwgoW6XH
0/SFtoF4+QUUAZ068YxHWY3fcCBmt/CM9IX7eTHK+6KLM8/0jlU=
=oytk
-----END PGP SIGNATURE-----
--=-=-=--
