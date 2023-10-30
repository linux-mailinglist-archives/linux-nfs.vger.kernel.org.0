Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5E87DBAB2
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 14:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjJ3N1x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 09:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjJ3N1w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 09:27:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E4ED3
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 06:27:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971F4C433CA;
        Mon, 30 Oct 2023 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698672469;
        bh=KQPospHCSgaiG2LHqwxGwfPogISqTzasFopAM1Nn04E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGmzxRHNaZFAcmTIuhMMKwtXmILhto7t5auF82/4sw8qBWLR6jDT7N77a91y7E5Ue
         yI7EQrrVVTcpVw3Zw6OxWVzd0XfmRqdmwHyQ6alEfb0XEWRtGxU5DuKmZd4EBPSA2V
         mVmRvqZ8Xhz9ko8gsaJMMtRXVci0KWCQ5Ypzhxoa3cC11Lrjgt0x5gWDcn6ioMPVPt
         FlnEZyY29UPk2d147YZNT1E8+NXBYW40HHoDGOV0qdgK3CnXdFaOmxwk/9c0MtfX2f
         nG5BmBVMBhd3COnSs1JDHiWmW+21f6bRC1v8og08AWIFAC+qzgj2zprm2ClHnIdRPy
         S1pE3e+bgQHTg==
Date:   Mon, 30 Oct 2023 14:27:46 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/5] nfsd: hold nfsd_mutex across entire netlink operation
Message-ID: <ZT+vUmtUVNMEzUwC@lore-desk>
References: <20231030011247.9794-1-neilb@suse.de>
 <20231030011247.9794-4-neilb@suse.de>
 <07df60cee15b8c206365613364d4979330c31407.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JFSCYX3CYslEtjRO"
Content-Disposition: inline
In-Reply-To: <07df60cee15b8c206365613364d4979330c31407.camel@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--JFSCYX3CYslEtjRO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 2023-10-30 at 12:08 +1100, NeilBrown wrote:
> > Rather than using svc_get() and svc_put() to hold a stable reference to
> > the nfsd_svc for netlink lookups, simply hold the mutex for the entire
> > time.
> >=20
> > The "entire" time isn't very long, and the mutex is not often contented.
> >=20
> > This makes way for use to remove the refcounts of svc, which is more
> > confusing than useful.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfsctl.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index d78ae4452946..8f644f1d157c 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1515,11 +1515,10 @@ int nfsd_nl_rpc_status_get_start(struct netlink=
_callback *cb)
> >  	int ret =3D -ENODEV;
> > =20
> >  	mutex_lock(&nfsd_mutex);
> > -	if (nn->nfsd_serv) {
> > -		svc_get(nn->nfsd_serv);
> > +	if (nn->nfsd_serv)
> >  		ret =3D 0;
> > -	}
> > -	mutex_unlock(&nfsd_mutex);
> > +	else
> > +		mutex_unlock(&nfsd_mutex);
> > =20
> >  	return ret;
> >  }
> > @@ -1691,8 +1690,6 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff =
*skb,
> >   */
> >  int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
> >  {
> > -	mutex_lock(&nfsd_mutex);
> > -	nfsd_put(sock_net(cb->skb->sk));
> >  	mutex_unlock(&nfsd_mutex);
> > =20
> >  	return 0;
>=20
> (cc'ing Lorenzo since he wrote this)
>=20
> I think Lorenzo did it this way originally, and I convinced him to take
> a reference instead. This should be fine though.

yep, the idea was to avoid grabbing the mutex and dump the refcount instead=
 but
I think it is fine.

Regards,
Lorenzo

>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

--JFSCYX3CYslEtjRO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZT+vUgAKCRA6cBh0uS2t
rFMyAP90yVhTeDeOin4j7bfLTwRqpq7DfjLnYZssex0R3lNzIQEAhJjoCnnX/tpe
eUIpY6iKyhmim0aL3gMJ15TcQIH4mQM=
=LWFr
-----END PGP SIGNATURE-----

--JFSCYX3CYslEtjRO--
