Return-Path: <linux-nfs+bounces-4888-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A44930C48
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 02:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184D7B20DC6
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 00:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DF02572;
	Mon, 15 Jul 2024 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kmaqEs65"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEAA4A18;
	Mon, 15 Jul 2024 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721005123; cv=none; b=m4vzyaCsPYrxArma33y9hsSOU6HPFV3fcLaCDRhQmT10CPYo1FCwbTLulw7NE/e3lsMlq5gwxQbUhOCUGO6BGI1/NDflHdVIwuKk1HSHlZMl0u7JPiddFc2GY1WTIvbmNvvyaQP2g/JrirebCL2C0NmJpjnx1f28BXUmjnMiX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721005123; c=relaxed/simple;
	bh=Bm+eXTVkAB7kqv/OKXbzXBjknfigS9qxCazq3JRqfCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dWwkoP8rRAUgSRsuULOUpYmXtcH5T+uwgFP94y88Ts/bNldMr+u73p9ZJszeRzUhXKgld/8yPjvf4BX+KSZm5+lxu1qgkJJP31h0Wzk2+64N0DLFh7mJraMeGRAMf5ooDXlDK9YKvYwwQALw0mjGaxy7s+abAnlZhSTcVBpLK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=kmaqEs65; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1721005118;
	bh=NGmOeTs8rbCRo+Lfmub4TgfphZcHrV4Vg4NavsxUQ7s=;
	h=Date:From:To:Cc:Subject:From;
	b=kmaqEs65BlZWsm01CEoDB0kvl+/aQVIG4iUP8JQL5X4SFgmEzoSbdbTlY3YFGery2
	 d3OTWqGy8E3aZFi4SkgTsNTXO4TNq9h4ST05aY2cRpR/oCkmK/W1G9Q5ebeHAPlzAB
	 qpjVOC0sLloy2Dwaif0uCOdRUljPoq47+q4Yvxcb3OJv8GJ+Ld8+YWT2Jn0SlWLdyc
	 FsZQyWB7mg6RNfJjhWtuIfx3tnBCCXp1s1sWYPgCSzF85v1YfBzTQQ/VvQy77qB4iQ
	 azI0euXWIz+mtna8Flc3HxuuV7ZEtHw6GedbM24BZQxgfd/llDpUciAE+PsXEzoDmA
	 PVQOcjbFqsjEg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WMkNF2z2kz4wcl;
	Mon, 15 Jul 2024 10:58:37 +1000 (AEST)
Date: Mon, 15 Jul 2024 10:58:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anna Schumaker <Anna.Schumaker@Netapp.com>, Trond Myklebust
 <trondmy@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Kairui Song <kasong@tencent.com>, NFS
 Mailing List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the nfs-anna tree with the mm-stable
 tree
Message-ID: <20240715105836.6d6e6e50@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nzY+LIQudv7Wf9cBm5ruQYH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/nzY+LIQudv7Wf9cBm5ruQYH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fs-next tree got conflicts in:

  fs/nfs/nfstrace.h
  fs/nfs/write.c

between commit:

  237d29075ca7 ("nfs: drop usage of folio_file_pos")

from the mm-stable tree and commit:

  64568b27b2d2 ("nfs: pass explicit offset/count to trace events")

from the nfs-anna tree.

I fixed it up (for the nfstrace.h file I just used the latter, and see
below) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/nfs/write.c
index 3573cdc4b28f,680505d664f0..000000000000
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@@ -279,9 -180,9 +180,9 @@@ static void nfs_grow_file(struct folio=20
  	spin_lock(&inode->i_lock);
  	i_size =3D i_size_read(inode);
  	end_index =3D ((i_size - 1) >> folio_shift(folio)) << folio_order(folio);
- 	if (i_size > 0 && folio_index(folio) < end_index)
+ 	if (i_size > 0 && folio->index < end_index)
  		goto out;
 -	end =3D folio_file_pos(folio) + (loff_t)offset + (loff_t)count;
 +	end =3D folio_pos(folio) + (loff_t)offset + (loff_t)count;
  	if (i_size >=3D end)
  		goto out;
  	trace_nfs_size_grow(inode, end);
@@@ -2073,8 -2062,8 +2062,8 @@@ int nfs_wb_folio_cancel(struct inode *i
   */
  int nfs_wb_folio(struct inode *inode, struct folio *folio)
  {
 -	loff_t range_start =3D folio_file_pos(folio);
 +	loff_t range_start =3D folio_pos(folio);
- 	loff_t range_end =3D range_start + (loff_t)folio_size(folio) - 1;
+ 	size_t len =3D folio_size(folio);
  	struct writeback_control wbc =3D {
  		.sync_mode =3D WB_SYNC_ALL,
  		.nr_to_write =3D 0,

--Sig_/nzY+LIQudv7Wf9cBm5ruQYH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaUdDwACgkQAVBC80lX
0Gw+6Af/VTNgao+oEEVH8WwqmF8qVOkwdCpkkkLvXYL4qk4hK95h/bANxClYnPwn
+BWgbj+LHCgVcA//EPGj5Ku/sO7weONZTRefQLkBIGvhGruSUdbvscRQAyNs8N5+
F0d3fSQYlqpAkYemxAuMen2+1X8a27UkAPeJK52W3Q7ouVAWirEfmOLIpq79PJcq
EcaIFV23AnzKBUT9BU8fIRXvS7BbQqvTWFRO0rZ/fGfQ9TXKvmSmK7CmemwOlXHc
PT5gafpwva4TbeVjB3+MpoBnelMdwVTY5NwerEpcXa2QZBRFGVXyBY9HuKMUuX3f
N6OnBnlDz2YugHNxCZOsdlA8KV4F+A==
=qROP
-----END PGP SIGNATURE-----

--Sig_/nzY+LIQudv7Wf9cBm5ruQYH--

