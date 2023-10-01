Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE447B48AE
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Oct 2023 18:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjJAQ5D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Oct 2023 12:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbjJAQ5C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Oct 2023 12:57:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AFED9
        for <linux-nfs@vger.kernel.org>; Sun,  1 Oct 2023 09:56:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19908C433C8;
        Sun,  1 Oct 2023 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696179419;
        bh=+PYrhixqzkF4VdxNyVNcHitAeU3ZVe8m8DwnXBJubVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEnQjXtljFIHKHqUIdNrAGXCKtojoRNIybe0gj5VTxAkyU7GNEY25/57DMbJ5mxB8
         G/Kl3cFVQGq9LbZ3T3NJPM8iZ5h8C0i5K8lET7DqMYoP6a+r8xEObyY5BEJG4tQh8+
         TqYZcSDs4PxAWQk+uRJes0mekTfGtpl6iNI27FSqUhLJPdCGqiM5IKB5PC/shqgShU
         qnJmJVcjUIRH5qZIZ3x+3LdG8bvypNkHprkr8TOV/Nmi2Q8mJaCER4sI8qFk072E3u
         hHpeXu9HDMHYBv6QCV2bd1u54KVKNyo2FOvKaPHqb3nvelYeZ23W89FEFJnUNhwQvC
         2Iw9cOWtfHVBA==
Date:   Sun, 1 Oct 2023 18:56:55 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, jlayton@kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
Message-ID: <ZRmk14sd+3gXfJ3N@lore-desk>
References: <27646a34a3ddac3e0b0ad9b49aaf66b3cee5844f.1695766257.git.lorenzo@kernel.org>
 <169576951041.19404.9298873670065778737@noble.neil.brown.name>
 <ZRbUp0gsLv9PqriL@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d0/512ygtkuOvx0l"
Content-Disposition: inline
In-Reply-To: <ZRbUp0gsLv9PqriL@tissot.1015granger.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--d0/512ygtkuOvx0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> >=20
> > This code is wrong... but then the original in write_maxblksize is wrong
> > to, so you can't be blamed.
> > nfsd_max_blksize applies to nfsd in ALL network namespaces.  So if we
> > need to check there are no active services in one namespace, we need to
> > check the same for *all* namespaces.
>=20
> Yes, the original code does look strange and is probably incorrect
> with regard to its handling of the mutex. Shall we explore and fix
> that issue in the nfsctl code first so that it can be backported to
> stable kernels?
>=20
>=20
> > I think we should make nfsd_max_blksize a per-namespace value.
>=20
> That is a different conversation.
>=20
> First, the current name of this tunable is incongruent with its
> actual function, which is to specify the maximum network buffer size
> that is allocated when the NFSD service pool is created. We should
> find a more descriptive and specific name for this element in the
> netlink protocol.
>=20
> Second, it does seem like a candidate for becoming namespace-
> specific, but TBH I'm not familiar enough with its current user
> space consumers to know if that change would be welcome or fraught.
>=20
> Since more discussion, research, and possibly a fix are needed, we
> might drop max_blksize from this round and look for one or two
> other tunables to convert for the first round.

ack. Are write_unlock_ip() and/or write_unlock_fs() good candidates?

Regards,
Lorenzo

>=20
>=20
> > > +
> > > +	nfsd_max_blksize =3D nla_get_u32(attr);
> > > +	nfsd_max_blksize =3D max_t(int, nfsd_max_blksize, 1024);
> > > +	nfsd_max_blksize =3D min_t(int, nfsd_max_blksize, NFSSVC_MAXBLKSIZE=
);
> > > +	nfsd_max_blksize &=3D ~1023;
> > > +out:
> > > +	mutex_unlock(&nfsd_mutex);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_max_blksize_get_dumpit - dump the nfs block size
> > > + * @skb: reply buffer
> > > + * @cb: netlink metadata and command arguments
> > > + *
> > > + * Returns the size of the reply or a negative errno.
> > > + */
> > > +int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
> > > +				   struct netlink_callback *cb)
> > > +{
> > > +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_BLKSIZE_GET,
> > > +				NFSD_A_CONTROL_PLANE_MAX_BLKSIZE,
> > > +				nfsd_max_blksize);
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_max_conn_set_doit - set the max number of connections
> > > + * @skb: reply buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Return 0 on success or a negative errno.
> > > + */
> > > +int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info =
*info)
> > > +{
> > > +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_i=
d);
> > > +	struct nlattr *attr =3D info->attrs[NFSD_A_CONTROL_PLANE_MAX_CONN];
> > > +
> > > +	if (!attr)
> > > +		return -EINVAL;
> > > +
> > > +	nn->max_connections =3D nla_get_u32(attr);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_max_conn_get_dumpit - dump the max number of connections
> > > + * @skb: reply buffer
> > > + * @cb: netlink metadata and command arguments
> > > + *
> > > + * Returns the size of the reply or a negative errno.
> > > + */
> > > +int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
> > > +				struct netlink_callback *cb)
> > > +{
> > > +	struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net=
_id);
> > > +
> > > +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_CONN_GET,
> > > +				NFSD_A_CONTROL_PLANE_MAX_CONN,
> > > +				nn->max_connections);
> > > +}
> > > +
> > >  /**
> > >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespa=
ce
> > >   * @net: a freshly-created network namespace

--d0/512ygtkuOvx0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZRmk1wAKCRA6cBh0uS2t
rELyAP9F+N12XkfumMIpAUVnpwgOR96/qsOGrY9ETkLLJAXqugD9EOFuZjEdEA5j
vsC7kkDPZiH08QaLbNYcK+gLYuGJswQ=
=FJc5
-----END PGP SIGNATURE-----

--d0/512ygtkuOvx0l--
