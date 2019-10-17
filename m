Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A1DB948
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2019 23:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406304AbfJQVsd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Oct 2019 17:48:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:57402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406155AbfJQVsd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 17 Oct 2019 17:48:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5F2AAB87;
        Thu, 17 Oct 2019 21:48:31 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@gmail.com>, linux-nfs@vger.kernel.org
Date:   Fri, 18 Oct 2019 08:48:24 +1100
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: [PATCH v2 0/3] Backchannel fixes
In-Reply-To: <20191017130221.7924-1-trond.myklebust@hammerspace.com>
References: <20191017130221.7924-1-trond.myklebust@hammerspace.com>
Message-ID: <87r23bgi1j.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Oct 17 2019, Trond Myklebust wrote:

> A set of patches to ensure the backchannel lifetime cannot exceed the
> lifetime of the transport to which it is attached.
>
> v2:
>  - Fix the case where !defined(CONFIG_SUNRPC_BACKCHANNEL)
>  - Don't allow xprt->bc_alloc_max to underflow in xprt_destroy_bc()
>
> Trond Myklebust (3):
>   SUNRPC: The TCP back channel mustn't disappear while requests are
>     outstanding
>   SUNRPC: The RDMA back channel mustn't disappear while requests are
>     outstanding
>   SUNRPC: Destroy the back channel when we destroy the host transport
>
>  include/linux/sunrpc/bc_xprt.h    | 5 +++++
>  net/sunrpc/backchannel_rqst.c     | 7 ++++---
>  net/sunrpc/xprt.c                 | 5 +++++
>  net/sunrpc/xprtrdma/backchannel.c | 2 ++
>  4 files changed, 16 insertions(+), 3 deletions(-)
>

All look good to me - thanks a lot.
Reviewed-by: NeilBrown <neilb@suse.de>

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2o4akACgkQOeye3VZi
gbnXOw//R7plhgNnG3ATAHTyU+TmzdTK2/RLvb/tp4tNRaDISzaUmIA83BX+beRW
DN50MH9NagvTVuH5aPpBMHlhG5gu6i3vAHdid0aA2KXJ8jpXHkI4TdfIyaGKZFv3
w7wR1+ilxD9uDgzzyyF8uxlStBSz/T3R4TqDOLt+eIqRxQ8miOmr/MSLLW6NVMTC
KrjmBku4kqgAFOyy/zxmYH7wgNh6W+WuC4QbP0ZevuoCloARwbL7QjfhJcrMJrPH
hZlc4a1VyER/SLhjvoeoTvMI0D3yqiKOXa+AZ+bt6U26xirAvEvutnr38romY6/Z
CkoJFBxXJ6vXS7RLke+mNX/A89MUXlkPe/eb6rLvfy78shXEFKEgRbj/BL3qUEmm
o8oYjwDzseVfHm2fWhQkMjRFU9rGDU943NVNpEGO/bPW8IOn18ATJymd49NCla2u
EBVhcP+FsOq0QQEChfg9RjeiYhYZIqIUCKW8m9MAJw6PZLv0e8feh4y0fdzHZddd
JCVc9FCxQoS6r3EcfohHkocFXG5gqAIgDXI7BLhutmQolBQuoh40aQY/BEbBWEvT
ztulcsYy4SKexjW2C47ddnVcj1m7Ml+qQcgKR7V9TmlHBl7XKvvb55sjJOqJfwFj
cbXUokXO1NJ+UCAtG5u6RjzFvLc2hiM5vQ8Kk0qsqEkA3FPqqv0=
=kibE
-----END PGP SIGNATURE-----
--=-=-=--
