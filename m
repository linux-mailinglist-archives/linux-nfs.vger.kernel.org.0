Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113E77E8F5F
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Nov 2023 10:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjKLJnJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Nov 2023 04:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjKLJnI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Nov 2023 04:43:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1498E30C2
        for <linux-nfs@vger.kernel.org>; Sun, 12 Nov 2023 01:43:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62877C433C7;
        Sun, 12 Nov 2023 09:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699782183;
        bh=TaKhL+gN9u7pnNrIvLPBsawWNe/VByz5qboeiHYSrVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AHIrhXYVg29IXMnJgMjuxPcRfXlSyzoXUd65piW6AQpqMZ9NkLtgHuV0AIZC+8s8v
         mMRnIjpkz0HLqK7pl2InT2NIvKOAnqmICpbI8hNDYz+qqFJ+tMQHl3AgeihSpxZZfv
         7D6RE+3BO8t4pdt6Cr59Y7CV1PewDtQNmsgbDoveZkszSfT9oUbY1Kq0LpLPZ3+KM9
         F1+92JiKmvKTwUZfwARdw3KJlwMqgizKwCjWjschzdm79AMdHaQeFJvVEJAZoi++97
         NKcHhs+jQNxzL5cqxFbpmDHXhsHzz9SmsoAbq08o8XONODMAntIy4Kkao9lI3ImiZt
         yRl3gEseTd/Zw==
Date:   Sun, 12 Nov 2023 10:43:00 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        neilb@suse.de, netdev@vger.kernel.org, jlayton@kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH v4 1/3] NFSD: convert write_threads to netlink command
Message-ID: <ZVCeJCOaJbDQzGBv@lore-desk>
References: <cover.1699095665.git.lorenzo@kernel.org>
 <ac01a0f3972dd8175238e27a69db0acf0fed89db.1699095665.git.lorenzo@kernel.org>
 <ZU/OntVC2qEwrsQd@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XuSBYpHjaXARouvV"
Content-Disposition: inline
In-Reply-To: <ZU/OntVC2qEwrsQd@tissot.1015granger.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--XuSBYpHjaXARouvV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Nov 04, 2023 at 12:13:45PM +0100, Lorenzo Bianconi wrote:
> > Introduce write_threads netlink command similar to the ones available
> > through the procfs.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/netlink/specs/nfsd.yaml | 23 +++++++
> >  fs/nfsd/netlink.c                     | 17 +++++
> >  fs/nfsd/netlink.h                     |  2 +
> >  fs/nfsd/nfsctl.c                      | 58 +++++++++++++++++
> >  include/uapi/linux/nfsd_netlink.h     |  9 +++
> >  tools/net/ynl/generated/nfsd-user.c   | 92 +++++++++++++++++++++++++++
> >  tools/net/ynl/generated/nfsd-user.h   | 47 ++++++++++++++
> >  7 files changed, 248 insertions(+)
>=20
> Hi Lorenzo -
>=20
> This doesn't apply to my private nfsd-next branch. I don't believe
> that's your fault... We've got some things in flight here that
> conflict with what is in net-next.
>=20
> Jakub tells me there is some ynl churn coming in v6.7-rc1 that
> might resolve the conflicts.
>=20
> I plan to rebase my private nfsd-next on v6.7-rc1 and push the first
> set of patches on Monday or Tuesday. Please rebase this series on
> top of that, regen the ynl code, and then send a v5. I will then
> apply that to nfsd-next for more testing and review.

ack, will do.

Regards,
Lorenzo

>=20
>=20
> > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netl=
ink/specs/nfsd.yaml
> > index 05acc73e2e33..c92e1425d316 100644
> > --- a/Documentation/netlink/specs/nfsd.yaml
> > +++ b/Documentation/netlink/specs/nfsd.yaml
> > @@ -62,6 +62,12 @@ attribute-sets:
> >          name: compound-ops
> >          type: u32
> >          multi-attr: true
> > +  -
> > +    name: server-worker
> > +    attributes:
> > +      -
> > +        name: threads
> > +        type: u32
> > =20
> >  operations:
> >    list:
> > @@ -87,3 +93,20 @@ operations:
> >              - sport
> >              - dport
> >              - compound-ops
> > +    -
> > +      name: threads-set
> > +      doc: set the number of running threads
> > +      attribute-set: server-worker
> > +      flags: [ admin-perm ]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - threads
> > +    -
> > +      name: threads-get
> > +      doc: get the number of running threads
> > +      attribute-set: server-worker
> > +      do:
> > +        reply:
> > +          attributes:
> > +            - threads
> > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > index 0e1d635ec5f9..1a59a8e6c7e2 100644
> > --- a/fs/nfsd/netlink.c
> > +++ b/fs/nfsd/netlink.c
> > @@ -10,6 +10,11 @@
> > =20
> >  #include <uapi/linux/nfsd_netlink.h>
> > =20
> > +/* NFSD_CMD_THREADS_SET - do */
> > +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVE=
R_WORKER_THREADS + 1] =3D {
> > +	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> > +};
> > +
> >  /* Ops table for nfsd */
> >  static const struct genl_split_ops nfsd_nl_ops[] =3D {
> >  	{
> > @@ -19,6 +24,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D=
 {
> >  		.done	=3D nfsd_nl_rpc_status_get_done,
> >  		.flags	=3D GENL_CMD_CAP_DUMP,
> >  	},
> > +	{
> > +		.cmd		=3D NFSD_CMD_THREADS_SET,
> > +		.doit		=3D nfsd_nl_threads_set_doit,
> > +		.policy		=3D nfsd_threads_set_nl_policy,
> > +		.maxattr	=3D NFSD_A_SERVER_WORKER_THREADS,
> > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> > +	{
> > +		.cmd	=3D NFSD_CMD_THREADS_GET,
> > +		.doit	=3D nfsd_nl_threads_get_doit,
> > +		.flags	=3D GENL_CMD_CAP_DO,
> > +	},
> >  };
> > =20
> >  struct genl_family nfsd_nl_family __ro_after_init =3D {
> > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > index d83dd6bdee92..4137fac477e4 100644
> > --- a/fs/nfsd/netlink.h
> > +++ b/fs/nfsd/netlink.h
> > @@ -16,6 +16,8 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callba=
ck *cb);
> > =20
> >  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> >  				  struct netlink_callback *cb);
> > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *in=
fo);
> > +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *in=
fo);
> > =20
> >  extern struct genl_family nfsd_nl_family;
> > =20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 739ed5bf71cd..0d0394887506 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1693,6 +1693,64 @@ int nfsd_nl_rpc_status_get_done(struct netlink_c=
allback *cb)
> >  	return 0;
> >  }
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
> > +	u32 nthreads;
> > +	int ret;
> > +
> > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_WORKER_THREADS))
> > +		return -EINVAL;
> > +
> > +	nthreads =3D nla_get_u32(info->attrs[NFSD_A_SERVER_WORKER_THREADS]);
> > +	ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
> > +
> > +	return ret =3D=3D nthreads ? 0 : ret;
> > +}
> > +
> > +/**
> > + * nfsd_nl_threads_get_doit - get the number of running threads
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *in=
fo)
> > +{
> > +	void *hdr;
> > +	int err;
> > +
> > +	skb =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > +	if (!skb)
> > +		return -ENOMEM;
> > +
> > +	hdr =3D genlmsg_iput(skb, info);
> > +	if (!hdr) {
> > +		err =3D -EMSGSIZE;
> > +		goto err_free_msg;
> > +	}
> > +
> > +	if (nla_put_u32(skb, NFSD_A_SERVER_WORKER_THREADS,
> > +			nfsd_nrthreads(genl_info_net(info)))) {
> > +		err =3D -EINVAL;
> > +		goto err_free_msg;
> > +	}
> > +
> > +	genlmsg_end(skb, hdr);
> > +
> > +	return genlmsg_reply(skb, info);
> > +
> > +err_free_msg:
> > +	nlmsg_free(skb);
> > +	return err;
> > +}
> > +
> >  /**
> >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >   * @net: a freshly-created network namespace
> > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfs=
d_netlink.h
> > index c8ae72466ee6..99f7855852a1 100644
> > --- a/include/uapi/linux/nfsd_netlink.h
> > +++ b/include/uapi/linux/nfsd_netlink.h
> > @@ -29,8 +29,17 @@ enum {
> >  	NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
> >  };
> > =20
> > +enum {
> > +	NFSD_A_SERVER_WORKER_THREADS =3D 1,
> > +
> > +	__NFSD_A_SERVER_WORKER_MAX,
> > +	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
> > +};
> > +
> >  enum {
> >  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > +	NFSD_CMD_THREADS_SET,
> > +	NFSD_CMD_THREADS_GET,
> > =20
> >  	__NFSD_CMD_MAX,
> >  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/genera=
ted/nfsd-user.c
> > index fec6828680ce..342a00b0474a 100644
> > --- a/tools/net/ynl/generated/nfsd-user.c
> > +++ b/tools/net/ynl/generated/nfsd-user.c
> > @@ -15,6 +15,8 @@
> >  /* Enums */
> >  static const char * const nfsd_op_strmap[] =3D {
> >  	[NFSD_CMD_RPC_STATUS_GET] =3D "rpc-status-get",
> > +	[NFSD_CMD_THREADS_SET] =3D "threads-set",
> > +	[NFSD_CMD_THREADS_GET] =3D "threads-get",
> >  };
> > =20
> >  const char *nfsd_op_str(int op)
> > @@ -47,6 +49,15 @@ struct ynl_policy_nest nfsd_rpc_status_nest =3D {
> >  	.table =3D nfsd_rpc_status_policy,
> >  };
> > =20
> > +struct ynl_policy_attr nfsd_server_worker_policy[NFSD_A_SERVER_WORKER_=
MAX + 1] =3D {
> > +	[NFSD_A_SERVER_WORKER_THREADS] =3D { .name =3D "threads", .type =3D Y=
NL_PT_U32, },
> > +};
> > +
> > +struct ynl_policy_nest nfsd_server_worker_nest =3D {
> > +	.max_attr =3D NFSD_A_SERVER_WORKER_MAX,
> > +	.table =3D nfsd_server_worker_policy,
> > +};
> > +
> >  /* Common nested types */
> >  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> >  /* NFSD_CMD_RPC_STATUS_GET - dump */
> > @@ -90,6 +101,87 @@ struct nfsd_rpc_status_get_list *nfsd_rpc_status_ge=
t_dump(struct ynl_sock *ys)
> >  	return NULL;
> >  }
> > =20
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_THREADS_SET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_THREADS_SET - do */
> > +void nfsd_threads_set_req_free(struct nfsd_threads_set_req *req)
> > +{
> > +	free(req);
> > +}
> > +
> > +int nfsd_threads_set(struct ynl_sock *ys, struct nfsd_threads_set_req =
*req)
> > +{
> > +	struct nlmsghdr *nlh;
> > +	int err;
> > +
> > +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_THREADS_SET, =
1);
> > +	ys->req_policy =3D &nfsd_server_worker_nest;
> > +
> > +	if (req->_present.threads)
> > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_WORKER_THREADS, req->threads);
> > +
> > +	err =3D ynl_exec(ys, nlh, NULL);
> > +	if (err < 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_THREADS_GET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_THREADS_GET - do */
> > +void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp)
> > +{
> > +	free(rsp);
> > +}
> > +
> > +int nfsd_threads_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> > +{
> > +	struct ynl_parse_arg *yarg =3D data;
> > +	struct nfsd_threads_get_rsp *dst;
> > +	const struct nlattr *attr;
> > +
> > +	dst =3D yarg->data;
> > +
> > +	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> > +		unsigned int type =3D mnl_attr_get_type(attr);
> > +
> > +		if (type =3D=3D NFSD_A_SERVER_WORKER_THREADS) {
> > +			if (ynl_attr_validate(yarg, attr))
> > +				return MNL_CB_ERROR;
> > +			dst->_present.threads =3D 1;
> > +			dst->threads =3D mnl_attr_get_u32(attr);
> > +		}
> > +	}
> > +
> > +	return MNL_CB_OK;
> > +}
> > +
> > +struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys)
> > +{
> > +	struct ynl_req_state yrs =3D { .yarg =3D { .ys =3D ys, }, };
> > +	struct nfsd_threads_get_rsp *rsp;
> > +	struct nlmsghdr *nlh;
> > +	int err;
> > +
> > +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_THREADS_GET, =
1);
> > +	ys->req_policy =3D &nfsd_server_worker_nest;
> > +	yrs.yarg.rsp_policy =3D &nfsd_server_worker_nest;
> > +
> > +	rsp =3D calloc(1, sizeof(*rsp));
> > +	yrs.yarg.data =3D rsp;
> > +	yrs.cb =3D nfsd_threads_get_rsp_parse;
> > +	yrs.rsp_cmd =3D NFSD_CMD_THREADS_GET;
> > +
> > +	err =3D ynl_exec(ys, nlh, &yrs);
> > +	if (err < 0)
> > +		goto err_free;
> > +
> > +	return rsp;
> > +
> > +err_free:
> > +	nfsd_threads_get_rsp_free(rsp);
> > +	return NULL;
> > +}
> > +
> >  const struct ynl_family ynl_nfsd_family =3D  {
> >  	.name		=3D "nfsd",
> >  };
> > diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/genera=
ted/nfsd-user.h
> > index b6b69501031a..4c11119217f1 100644
> > --- a/tools/net/ynl/generated/nfsd-user.h
> > +++ b/tools/net/ynl/generated/nfsd-user.h
> > @@ -30,4 +30,51 @@ void nfsd_rpc_status_get_list_free(struct nfsd_rpc_s=
tatus_get_list *rsp);
> > =20
> >  struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_s=
ock *ys);
> > =20
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_THREADS_SET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_THREADS_SET - do */
> > +struct nfsd_threads_set_req {
> > +	struct {
> > +		__u32 threads:1;
> > +	} _present;
> > +
> > +	__u32 threads;
> > +};
> > +
> > +static inline struct nfsd_threads_set_req *nfsd_threads_set_req_alloc(=
void)
> > +{
> > +	return calloc(1, sizeof(struct nfsd_threads_set_req));
> > +}
> > +void nfsd_threads_set_req_free(struct nfsd_threads_set_req *req);
> > +
> > +static inline void
> > +nfsd_threads_set_req_set_threads(struct nfsd_threads_set_req *req,
> > +				 __u32 threads)
> > +{
> > +	req->_present.threads =3D 1;
> > +	req->threads =3D threads;
> > +}
> > +
> > +/*
> > + * set the number of running threads
> > + */
> > +int nfsd_threads_set(struct ynl_sock *ys, struct nfsd_threads_set_req =
*req);
> > +
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_THREADS_GET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_THREADS_GET - do */
> > +
> > +struct nfsd_threads_get_rsp {
> > +	struct {
> > +		__u32 threads:1;
> > +	} _present;
> > +
> > +	__u32 threads;
> > +};
> > +
> > +void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp);
> > +
> > +/*
> > + * get the number of running threads
> > + */
> > +struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys);
> > +
> >  #endif /* _LINUX_NFSD_GEN_H */
> > --=20
> > 2.41.0
> >=20
>=20
> --=20
> Chuck Lever

--XuSBYpHjaXARouvV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZVCeJAAKCRA6cBh0uS2t
rBdyAP9Dgpc1ppAl8TtPjGxpXJRxfy0bmZZtr0QxDArAJdoWqgEA47txQCDCi1Fj
73cEW66X5YKbSkJqjFF09xI3ldm1TAg=
=BfCB
-----END PGP SIGNATURE-----

--XuSBYpHjaXARouvV--
