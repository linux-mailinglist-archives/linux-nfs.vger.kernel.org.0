Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93EE49AC33
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 07:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiAYGQ0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 01:16:26 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:58115 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S256366AbiAYFWA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 00:22:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JjZwC20rDz4xNm;
        Tue, 25 Jan 2022 16:21:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643088108;
        bh=EXHDGMBkz/WT0lNUnQj7KDfXlPwfDl9vmteB2k6cJ3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EdnIAN3Dje7TsR0qLc+kvP3CKJZXsiXEiv5aBCcj083DxKac3+abPPCAhie1cgZYw
         cT6dqjqE84E/qHpW/3nph5OmiAPelmoPcwV3Rg05oMi5OLIpBGhxN0jTCsiHFJ2/+u
         /roc9Spb+C0aH61oZQuBc+cfkoZ1O5OTT7kSadLv8xBDcpvFqpgDsOBDjEsKA0Mb2+
         YXWT6GKw1+XGHVNF/YiP8srvXlfIZoQGe/8e/undAt9RVWTqJSUZlDNj4bjsg2e3ou
         pDdTJ0ODV2qNfkoBpOy5XPygYoFAbe2cr09gq4TX7fqu48RujXWOohUm/SFv67xOj6
         R/VYHrcEkzfuQ==
Date:   Tue, 25 Jan 2022 16:21:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: linux-next: runtime warning in next-20220125
Message-ID: <20220125162146.13872bdb@canb.auug.org.au>
In-Reply-To: <20220125160505.068dbb52@canb.auug.org.au>
References: <20220125160505.068dbb52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GcmYL3f6WLHjIlgotq6pgNq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--Sig_/GcmYL3f6WLHjIlgotq6pgNq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 25 Jan 2022 16:05:05 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> My qemu boot test of a powerpc pseries_le_defconfig kernel produces the
> following trace:
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/trace/trace_events.c:417 trace_event_raw=
_init+0x194/0x730
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc1 #2
> NIP:  c0000000002bdbb4 LR: c0000000002bdcb0 CTR: c0000000002bdb70
>=20
> I have no idea what has caused this :-(  Maybe commit
>=20
>   5544d5318802 ("SUNRPC: Same as SVC_RQST_ENDPOINT, but without the xid")

Actually, reverting commits

  6ff851d98af8 ("SUNRPC: Improve sockaddr handling in the svc_xprt_create_e=
rror trace point")
  5544d5318802 ("SUNRPC: Same as SVC_RQST_ENDPOINT, but without the xid")
  e2d3613db12a ("SUNRPC: Record endpoint information in trace log")

makes the warning go away.

--=20
Cheers,
Stephen Rothwell

--Sig_/GcmYL3f6WLHjIlgotq6pgNq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHviOoACgkQAVBC80lX
0Gys6QgAlGSkaap9eq9MYZ7vSaG4FckU4s2yeO0WuT8ESDW3LLEhh5QMs74MqdRH
5H9ZftfOAQnzEsyboKAJC6heWbxpHG2yJ+NlKtMWviIRSm4TYPvL3fxxueq0KDiY
Peo16xh4yyERxGOHHU2u77mQGy1Qi77bJJtt0eL5b7Ur95yfG86EoRpRp3uzi7F4
ESCZ/UYPTN0lexyafnZzI6TAThwnyq1bHdXCvPyinibryzNwbrEjwibtdlaAkzdL
AICl655j7ya/rzkWMkS/MWdW18L1af8vagM87+i9ynA7QRbT0JY9l/c+BMOYE81I
Fv5BdzURvzJe7qqdNsNgwudRnn63wA==
=6Eui
-----END PGP SIGNATURE-----

--Sig_/GcmYL3f6WLHjIlgotq6pgNq--
