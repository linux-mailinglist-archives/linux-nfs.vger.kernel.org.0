Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E642478161
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 01:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhLQAfM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 19:35:12 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:34379 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLQAfM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 19:35:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFVPT5Xlcz4xd4;
        Fri, 17 Dec 2021 11:35:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639701310;
        bh=f59MqEjdpDiaMSk9feD9W71l2ca5f0HhNgFwo3sFh1o=;
        h=Date:From:To:Cc:Subject:From;
        b=qpOlxGTscwSR+ICoPqjUU4zTxI4JFFa6AGkR7Xf1yE3E6TVkrtzshSMA97DQLr6l8
         fMfVnYS6FTgokvhEVLBLHPrNDBNjSMJTRzLkxgNXhbJvmYmpqVV2lpWF0VplO3lLpR
         r3GO2+gLlZggDc77YIS8B3dRpAh8jwGccGc7UdCmXYHn9zm9K0IeHrQ+NfIPefnaLp
         2Gp/+k/bPMwjYHTHHrrTWV24yjS2k4plYcTuVYdWC2Gc+hiaWAKCO9qy5MBldF5jlc
         ABGvNhDHO8DYwh9cas4je+pf2PD91WqnIECLeTBhhL9SYlXN4QZ04HulMtm7v0cMuo
         lVMDKR6ih5vkQ==
Date:   Fri, 17 Dec 2021 11:35:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the nfs-anna tree with the fscache tree
Message-ID: <20211217113507.76f852f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9suRLOcL.ahdpGHmrQBnKrn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/9suRLOcL.ahdpGHmrQBnKrn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nfs-anna tree got conflicts in:

  fs/nfs/fscache.c
  fs/nfs/fscache.h
  fs/nfs/fscache-index.c

between commit:

  882ff66585ec ("nfs: Convert to new fscache volume/cookie API")

from the fscache tree and commits:

  e89edabcb3d4 ("NFS: Remove remaining usages of NFSDBG_FSCACHE")
  0d20bd7faac9 ("NFS: Cleanup usage of nfs_inode in fscache interface and h=
andle i_size properly")
  4a0574909596 ("NFS: Rename fscache read and write pages functions")
  3b779545aa01 ("NFS: Convert NFS fscache enable/disable dfprintks to trace=
points")
  b9077ca60a13 ("NFS: Replace dfprintks with tracepoints in fscache read an=
d write page functions")
  416de7e7eeb6 ("NFS: Remove remaining dfprintks related to fscache cookies=
")
  fcb692b98976 ("NFS: Use nfs_i_fscache() consistently within NFS fscache c=
ode")

from the nfs-anna tree.

I had no idea how to fix this all up, so I just dropped the nfs-anna
tree for today.   Please get together and coordinate thses changes.

--=20
Cheers,
Stephen Rothwell

--Sig_/9suRLOcL.ahdpGHmrQBnKrn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG72zsACgkQAVBC80lX
0GxTtQgAlXs/tim2HNpeEzj/e8+Jz9pCDPihLehMzRMomGS9i3oDZ9IHUAuYKex0
NQkY57aOXQ3+VnqQAZh3ry9Fq7056tKZt6/pZz42wswHA9yroaPXDklNPV6G3xwx
Rg+gNgkPsJj/IOiO27Lt+0NQ9p0o8MEUUCmSxQCWq4oZnQP4aPLsrChv9jAX2v8E
N+OnJhzIPZYRnXEiyJU9uAM7O9qGZKHuN0rOXI1C0pZbvcKJLfj1fPiBLIItuTrE
yBPgtCzM1dNEkkpPBZFLt043o6ckF442t1zRAanC1CqeVn/q9PcgZ+mMltBRfIbK
DypTi5Nnv+5WixM0l6YI0cTv24hkGw==
=sgBE
-----END PGP SIGNATURE-----

--Sig_/9suRLOcL.ahdpGHmrQBnKrn--
