Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977107ADA23
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 16:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjIYOcJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 10:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjIYOcI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 10:32:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2776C0
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 07:32:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E45C433C8;
        Mon, 25 Sep 2023 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695652321;
        bh=34z6Dw/XTxGct0UO29aEYjxEKS5xFSdcTF4M12XnnkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0On9ZghtzWKUIoDiiktZ7mNjyLKaFrbu74v4waDIgT6sJxS5bbPk0IfBEd7jWcF+
         CYcFpTM98iYZLe6ZDX8PNQU08rsmpBrL7xi44tswJq4tiArulKgyKtyZYBR8P5zrjY
         qfdz6NFGr3k6yEqwXEqu833pIVoyRDhxRuN7s22A5YyFmGbOWZ1hu6x8D7S1gnMi2K
         8/2cuNo048L//hejcIQZpoGDfXcLxfU7P4C/KEajzQhGNes0N7wtoPoeaCOW6cYpdb
         gp42i8eMGnsZrBQzcPb0QrYsEip8fASux3KAs3FNUnSnp3BHE/zRYyY6M/vvOHWQEt
         EbQO6K14N3ypA==
Date:   Mon, 25 Sep 2023 16:31:57 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
Message-ID: <ZRGZ3biV94qRx/IF@lore-desk>
References: <b9fefe9a15d8a4c5ab597489902ab2f868199365.1695563204.git.lorenzo@kernel.org>
 <ZRGRHbQ4w2hcEre/@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qYoQUvXl/ddLoVyJ"
Content-Disposition: inline
In-Reply-To: <ZRGRHbQ4w2hcEre/@tissot.1015granger.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--qYoQUvXl/ddLoVyJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 25, Chuck Lever wrote:
> On Sun, Sep 24, 2023 at 03:52:28PM +0200, Lorenzo Bianconi wrote:
> > Introduce write_threads, write_maxblksize and write_maxconn netlink
> > commands similar to the ones available through the procfs.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes since v1:
> > - remove write_v4_end_grace command
> > - add write_maxblksize and write_maxconn netlink commands
> >=20
> > This patch can be tested with user-space tool reported below:
> > https://github.com/LorenzoBianconi/nfsd-netlink.git
> > ---
> >  Documentation/netlink/specs/nfsd.yaml |  63 ++++++++++++
> >  fs/nfsd/netlink.c                     |  51 ++++++++++
> >  fs/nfsd/netlink.h                     |   9 ++
> >  fs/nfsd/nfsctl.c                      | 139 ++++++++++++++++++++++++++
> >  include/uapi/linux/nfsd_netlink.h     |  15 +++
> >  5 files changed, 277 insertions(+)
>=20
> This looks pretty close to me. A couple of comments below.
>=20
>=20
> > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netl=
ink/specs/nfsd.yaml
> > index 403d3e3a04f3..10214fcec8a5 100644
> > --- a/Documentation/netlink/specs/nfsd.yaml
> > +++ b/Documentation/netlink/specs/nfsd.yaml
> > @@ -62,6 +62,18 @@ attribute-sets:
> >          name: compound-ops
> >          type: u32
> >          multi-attr: true
> > +  -
> > +    name: server-attr
>=20
> Or, say, "control-plane" ? "server-attr" doesn't seem very self-
> explanatory or specific.

ack, fine to me..naming is always hard :)

>=20
>=20
> > +    attributes:
> > +      -
> > +        name: threads
> > +        type: u32
> > +      -
> > +        name: max-blksize
> > +        type: u32
> > +      -
> > +        name: max-conn
> > +        type: u32
> > =20
> >  operations:
> >    list:
> > @@ -72,3 +84,54 @@ operations:
> >        dump:
[...]
> > =20
> > +/**
> > + * nfsd_nl_threads_set_doit - set the number of running threads
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *in=
fo)
> > +{
> > +	u16 nthreads;
> > +	int ret;
> > +
> > +	if (!info->attrs[NFSD_A_SERVER_ATTR_THREADS])
> > +		return -EINVAL;
> > +
> > +	nthreads =3D nla_get_u32(info->attrs[NFSD_A_SERVER_ATTR_THREADS]);
>=20
> I worry about what happens if someone sends down a value larger than
> 64K. While not a likely scenario, the behavior is not well defined,
> and I don't think the implicit type conversions are necessary.
>=20
> Can nthreads be u32?

actually this is a leftover of the previous patch. I will fix it in v3.

Regards,
Lorenzo

>=20
>=20
> > +	ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
> > +	return ret =3D=3D nthreads ? 0 : ret;
> > +}
> > +
> > +static int nfsd_nl_get_dump(struct sk_buff *skb, struct netlink_callba=
ck *cb,
> > +			    int cmd, int attr, u32 val)
> > +{
> > +	void *hdr;
> > +
> > +	if (cb->args[0]) /* already consumed */
> > +		return 0;
> > +
> > +	hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_s=
eq,
> > +			  &nfsd_nl_family, NLM_F_MULTI, cmd);
> > +	if (!hdr)
> > +		return -ENOBUFS;
> > +
> > +	if (nla_put_u32(skb, attr, val))
> > +		return -ENOBUFS;
> > +
> > +	genlmsg_end(skb, hdr);
> > +	cb->args[0] =3D 1;
> > +
> > +	return skb->len;
> > +}
> > +
> > +/**
> > + * nfsd_nl_threads_get_dumpit - dump the number of running threads
> > + * @skb: reply buffer
> > + * @cb: netlink metadata and command arguments
> > + *
> > + * Returns the size of the reply or a negative errno.
> > + */
> > +int nfsd_nl_threads_get_dumpit(struct sk_buff *skb, struct netlink_cal=
lback *cb)
> > +{
> > +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_THREADS_GET,
> > +				NFSD_A_SERVER_ATTR_THREADS,
> > +				nfsd_nrthreads(sock_net(skb->sk)));
> > +}
> > +
> > +/**
> > + * nfsd_nl_max_blksize_set_doit - set the nfs block size
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_info=
 *info)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > +	int ret =3D 0;
> > +
> > +	if (!info->attrs[NFSD_A_SERVER_ATTR_MAX_BLKSIZE])
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	if (nn->nfsd_serv) {
> > +		ret =3D -EBUSY;
> > +		goto out;
> > +	}
> > +
> > +	nfsd_max_blksize =3D nla_get_u32(info->attrs[NFSD_A_SERVER_ATTR_MAX_B=
LKSIZE]);
> > +	nfsd_max_blksize =3D max_t(int, nfsd_max_blksize, 1024);
> > +	nfsd_max_blksize =3D min_t(int, nfsd_max_blksize, NFSSVC_MAXBLKSIZE);
> > +	nfsd_max_blksize &=3D ~1023;
> > +out:
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * nfsd_nl_max_blksize_get_dumpit - dump the nfs block size
> > + * @skb: reply buffer
> > + * @cb: netlink metadata and command arguments
> > + *
> > + * Returns the size of the reply or a negative errno.
> > + */
> > +int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
> > +				   struct netlink_callback *cb)
> > +{
> > +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_BLKSIZE_GET,
> > +				NFSD_A_SERVER_ATTR_MAX_BLKSIZE,
> > +				nfsd_max_blksize);
> > +}
> > +
> > +/**
> > + * nfsd_nl_max_conn_set_doit - set the max number of connections
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info *i=
nfo)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > +
> > +	if (!info->attrs[NFSD_A_SERVER_ATTR_MAX_CONN])
> > +		return -EINVAL;
> > +
> > +	nn->max_connections =3D nla_get_u32(info->attrs[NFSD_A_SERVER_ATTR_MA=
X_CONN]);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * nfsd_nl_max_conn_get_dumpit - dump the max number of connections
> > + * @skb: reply buffer
> > + * @cb: netlink metadata and command arguments
> > + *
> > + * Returns the size of the reply or a negative errno.
> > + */
> > +int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
> > +				struct netlink_callback *cb)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net_i=
d);
> > +
> > +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_CONN_GET,
> > +				NFSD_A_SERVER_ATTR_MAX_CONN,
> > +				nn->max_connections);
> > +}
> > +
> >  /**
> >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >   * @net: a freshly-created network namespace
> > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfs=
d_netlink.h
> > index c8ae72466ee6..59d0aa22ba94 100644
> > --- a/include/uapi/linux/nfsd_netlink.h
> > +++ b/include/uapi/linux/nfsd_netlink.h
> > @@ -29,8 +29,23 @@ enum {
> >  	NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
> >  };
> > =20
> > +enum {
> > +	NFSD_A_SERVER_ATTR_THREADS =3D 1,
> > +	NFSD_A_SERVER_ATTR_MAX_BLKSIZE,
> > +	NFSD_A_SERVER_ATTR_MAX_CONN,
> > +
> > +	__NFSD_A_SERVER_ATTR_MAX,
> > +	NFSD_A_SERVER_ATTR_MAX =3D (__NFSD_A_SERVER_ATTR_MAX - 1)
> > +};
> > +
> >  enum {
> >  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > +	NFSD_CMD_THREADS_SET,
> > +	NFSD_CMD_THREADS_GET,
> > +	NFSD_CMD_MAX_BLKSIZE_SET,
> > +	NFSD_CMD_MAX_BLKSIZE_GET,
> > +	NFSD_CMD_MAX_CONN_SET,
> > +	NFSD_CMD_MAX_CONN_GET,
> > =20
> >  	__NFSD_CMD_MAX,
> >  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > --=20
> > 2.41.0
> >=20
>=20
> --=20
> Chuck Lever

--qYoQUvXl/ddLoVyJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZRGZ3QAKCRA6cBh0uS2t
rOgqAP9IOs0km0VrwZNf0Y+k6qHjlCGzOfBPpGLErwb1/BfYxgEA3B0gHC1TWlFY
sGcIe+SOtT/SsMiwY2FbcKHcEcyMAwc=
=cV6d
-----END PGP SIGNATURE-----

--qYoQUvXl/ddLoVyJ--
