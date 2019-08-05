Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C52A98210A
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2019 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfHEQCk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Aug 2019 12:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfHEQCk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 5 Aug 2019 12:02:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F7E8300BEAE;
        Mon,  5 Aug 2019 16:02:40 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBD6760127;
        Mon,  5 Aug 2019 16:02:38 +0000 (UTC)
Message-ID: <1d2aadf8054b3ba2c50464e17fc477eb92bcf1b1.camel@redhat.com>
Subject: Re: [PATCH v3] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
From:   Doug Ledford <dledford@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Date:   Mon, 05 Aug 2019 12:02:36 -0400
In-Reply-To: <20190729171923.13428.52555.stgit@manet.1015granger.net>
References: <20190729171923.13428.52555.stgit@manet.1015granger.net>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rzLvz2895y4p8Iv09iVf"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 05 Aug 2019 16:02:40 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--=-rzLvz2895y4p8Iv09iVf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-29 at 13:22 -0400, Chuck Lever wrote:
> Send and Receive completion is handled on a single CPU selected at
> the time each Completion Queue is allocated. Typically this is when
> an initiator instantiates an RDMA transport, or when a target
> accepts an RDMA connection.
>=20
> Some ULPs cannot open a connection per CPU to spread completion
> workload across available CPUs and MSI vectors. For such ULPs,
> provide an API that allows the RDMA core to select a completion
> vector based on the device's complement of available comp_vecs.
>=20
> ULPs that invoke ib_alloc_cq() with only comp_vector 0 are converted
> to use the new API so that their completion workloads interfere less
> with each other.
>=20
> Suggested-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> Cc: <linux-cifs@vger.kernel.org>
> Cc: <v9fs-developer@lists.sourceforge.net>

This looks reasonable to me Chuck, and we have plenty of time to test it
in for-next before the next merge window, so applied to for-next, thanks
:-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-rzLvz2895y4p8Iv09iVf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1IUxwACgkQuCajMw5X
L90alRAArGLywfldeAGttkpNxU/+G7ArXLXpxOcAv2PYk6zfhBZ1GsL29zmyeP4B
P7t0OYuE6W8MNDGk/a8jLaEQvTFBGLqglUGdOPmMvHQDmV9xbcpBHuwGpyiQY42u
EwS4Rb/6jt/aK888ARE8MC5ArWK5F4zrXNEnXeZwAtmi7bia31iT3FzQiivOxgYK
KpC/PRrcIQ8Aq7nXq/qh8YmzO0AMUxX3WF5hi4baZZDnlBztNBZFlaboR8yTgDtN
7BHUjC+fIDy0ZzewjhZJjJkS1e/Ym2R5786KYyWEzUVhNQDyLAIGPr2y5K8N0i7n
LVQ+QeFlQmlvQzGsCjt5CEhOuB1L+fVz2G8OQL+w/f4Z9HMzZYGrvJ9HpQzmFgp6
M0yZCLBBSg1rV9GNnhvyICIXTnn2MjOdWNpBU73MeATU+4c+SckGvLX2RbLpX67D
u0uckXe2Z/sXwkKFM86Zpo7ijaaFNQbmcKtToMmSVME9+xP1YSTWtgBwxZP7rVDs
TF8Ggxta+W7By0BCRkzMwGjsfrt3SgwXsEebww5GTh7wTyDu4YH+AMcP65SCeMio
+DyBoy8b8nCWiYN/IlpOVxMNmPj332MV1LhvP7HfqRkmLo0LoHC3VK2HMNVfWR62
GEjvJkbBMjrf7TIdHpcLKFbMtMvoQIXXYPYIPDk4r1pf43jvvVA=
=l7Wu
-----END PGP SIGNATURE-----

--=-rzLvz2895y4p8Iv09iVf--

