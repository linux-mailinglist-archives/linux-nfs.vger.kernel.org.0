Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA141919
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 01:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391800AbfFKXmT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 19:42:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:36038 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389600AbfFKXmT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Jun 2019 19:42:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8C70AC3F;
        Tue, 11 Jun 2019 23:42:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 12 Jun 2019 09:42:10 +1000
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
In-Reply-To: <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com> <87muj3tuuk.fsf@notabene.neil.brown.name> <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com> <87lfy9vsgf.fsf@notabene.neil.brown.name> <3B887552-91FB-493A-8FDF-411562811B36@oracle.com> <CAN-5tyEdu7poNWrKtOyic6GgQcjAPZhB5BJeQ7JMSfmgMx8b+g@mail.gmail.com> <16D30334-67BE-4BD2-BE69-1453F738B259@oracle.com>
Message-ID: <877e9rwuy5.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Jun 11 2019, Chuck Lever wrote:

>
> Earlier in this thread, Neil proposed to make nconnect a hint. Sounds
> like the long term plan is to allow "up to N" connections with some
> mechanism to create new connections on-demand." maxconn fits that idea
> better, though I'd prefer no new mount options... the point being that
> eventually, this setting is likely to be an upper bound rather than a
> fixed value.

When I suggested making at I hint, I considered and rejected the the
idea of making it a maximum.  Maybe I should have been explicit about
that.

I think it *is* important to be able to disable multiple connections,
hence my suggestion that "nconnect=1", as a special case, could be a
firm maximum.
My intent was that if nconnect was not specified, or was given a larger
number, then the implementation should be free to use however many
connections it chose from time to time.  The number given would be just
a hint - maybe an initial value.  Neither a maximum nor a minimum.
Maybe we should add "nonconnect" (or similar) to enforce a single
connection, rather than overloading "nconnect=1"

You have said elsewhere that you would prefer configuration in a config
file rather than as a mount option.
How do you imagine that configuration information getting into the
kernel?
Do we create /sys/fs/nfs/something?  or add to /proc/sys/sunrpc
or /proc/net/rpc .... we have so many options !!
There is even /sys/kernel/debug/sunrpc/rpc_clnt, but that is not
a good place for configuration.

I suspect that you don't really have an opinion, you just don't like the
mount option.  However I don't have that luxury.  I need to put the
configuration somewhere.  As it is per-server configuration the only
existing place that works at all is a mount option.
While that might not be ideal, I do think it is most realistic.
Mount options can be deprecated, and carrying support for a deprecated
mount option is not expensive.

The option still can be placed in a per-server part of
/etc/nfsmount.conf rather than /etc/fstab, if that is what a sysadmin
wants to do.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl0APFIACgkQOeye3VZi
gbnAqg/9Hh0ee1kg39+AxVBkiOkwCn9fqzzM9Rsu7QEWnX2Xicd8WaJnKn730onO
Nc0B2X7Zy9kiPzpDbU1TBLa+4LDa3fmxk9d7qZcpM1RplArO7edjEImxwKYdhOCG
AG1PrWuJe2wdf8pJNHpLEg7YMg7h2atcr/JHyUoRKXcCRlydtCvhw8QcsvfU58i4
clSK5OgMIabPwE856sI2pHHCF+XE0c9e724IsZ3g77o/riKVRG6I5cSjzebQVgNe
yxWr7oc03rgD/tYMDrtUTuqJHXFO0b5dOU6wp5LWHV6mBcagDNWIdUz/T9xXZj4Q
XQcDqsPKcBKuzvN2e/z73sO3Hb4di9pZDJtUm7dKBAH3Vvys3UKHB3YHXEyy5XBL
nKLxxsFCqZY6sBmdVAP/92AyUSEmzYjYqO97rGtt1PAlkSOIxFems94F7MFgv0v9
eNOEjLIrZ97Elq7UegxI4WRD3ma+eQUi0qQIcqJjOd3ZexVsE3g/5BKUNd+mQqGS
WzlTz75UZgcNoEGFxJExyo6ZFbf0stYZe0AeOp1wZ+8W9WuBZybfvxYWmNV8FZBz
HL3zyLW01CPGnlMlCEMcrhYCTz3nrepRtLnc9IDmzhEIhL0xfJOUErLlxS83Ck8T
lYKtefpIo6+zS8i0QSiEd8krGVEyZfM+4DGehoS/T3FQnte+cDo=
=7Zx9
-----END PGP SIGNATURE-----
--=-=-=--
