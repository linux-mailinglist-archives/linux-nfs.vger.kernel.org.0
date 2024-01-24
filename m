Return-Path: <linux-nfs+bounces-1320-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743EF83B4A0
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 23:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2423A28637A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9642B135A44;
	Wed, 24 Jan 2024 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQPl2aVR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71717135A42
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135198; cv=none; b=Un8p0/plYxb/cBRn5MIDixRyxSQpMvd8X2u8omOzHmR6hhNE6CocnoNUBRRdaFeZ5m2WkfXsIAvROxOBOHmY+KxoTPV7wYigQ6oUkAl4IYioCINg1PwkCQlcDnLl9TcV5b/9a2zNRo7ZI8IBdHou8L2LMxOhNsSzPIzLNTVdL+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135198; c=relaxed/simple;
	bh=cZIK0NRr2YFM1KijjyJjJmo5Jbe3Z1mc/zWNH+3EuLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4Gjjitweb8BYS2J3ddfKoGgqnw0cKlE/eZkZx4FKg3t2Ot63EMaQ1iMEa32TYFfRHq8hBAiw1TP1vssAEqh88KX4vfpoUMRoQR8V1IUDdNIQEMJ3PMjqFK7HgajIARcXoolkJdCKup6dB0yi9KeRFvn6mEzyJPPtEMyxkNZjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQPl2aVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DECFC433F1;
	Wed, 24 Jan 2024 22:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706135197;
	bh=cZIK0NRr2YFM1KijjyJjJmo5Jbe3Z1mc/zWNH+3EuLE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SQPl2aVRsAK4haXgrsKZcGyVTzQByBOWIO+8m7dAjgP8Lxw+KTsK3V82WTj/V+fx5
	 5yC4PqSq2f/GXQDj9bo/bkDyDiTZVnWRd10BjMyRUtedUnhMdf0VOqSEZq4lWaJ3At
	 42TuI5fL5DR8Ep1qbC8TvIOwp3ZTL3kTzofEpHvXlrqARK+nmHMuTnLCn4IBoEjftB
	 nDgaB7dV9QOeRWeR2VdGM9UOS9Mt/w5vs4BGmbbRj5oz9v8Su++zeX2oBSdoona0gK
	 95m8+1fGXXN75vnmyucUbw0wfTxtzPuepoXtBqLH9gB/OQdTmZus22Y4rPb6zqg9Zg
	 F9gNMLVjKtbSg==
Message-ID: <36ccfa7d69c47c4689e8129b1a72cc71a69b2ce2.camel@kernel.org>
Subject: Re: [PATCH v1] NFSD: Add a switch to disable nfsd_splice_read()
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date: Wed, 24 Jan 2024 17:26:36 -0500
In-Reply-To: <1F1BB99D-435F-437A-AA33-E22F87ADE1C1@oracle.com>
References: 
	<170602632623.217131.13021600519850917517.stgit@manet.1015granger.net>
	 <81fb5fddeb51b96595444be0ba36718e5ffeea54.camel@kernel.org>
	 <1F1BB99D-435F-437A-AA33-E22F87ADE1C1@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-24 at 21:56 +0000, Chuck Lever III wrote:
>=20
> > On Jan 24, 2024, at 3:34=E2=80=AFPM, Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > On Tue, 2024-01-23 at 11:12 -0500, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >=20
> > > This enables us to ensure that testing properly covers the readv
> > > paths as well as the spliced read paths, which are more commonly
> > > used. Also this makes it easier to do benchmark comparisons between
> > > splice and vectored reads.
> > >=20
> > > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > > Documentation/netlink/specs/nfsd.yaml |   19 +++++++
> > > fs/nfsd/netlink.c                     |   17 ++++++
> > > fs/nfsd/netlink.h                     |    3 +
> > > fs/nfsd/netns.h                       |    1=20
> > > fs/nfsd/nfsctl.c                      |   45 ++++++++++++++++
> > > include/uapi/linux/nfsd_netlink.h     |    8 +++
> > > tools/net/ynl/generated/nfsd-user.c   |   95 ++++++++++++++++++++++++=
+++++++++
> > > tools/net/ynl/generated/nfsd-user.h   |   47 ++++++++++++++++
> > > 8 files changed, 235 insertions(+)
> > >=20
> >=20
> > I think this makes sense. How are you testing it,
>=20
> So far it's only been regression testing. Nothing breaks.
>=20
>=20
> > and how do you forsee
> > us using this interface? Will we need a new program in nfs-utils or wil=
l
> > you extend an existing one?
>=20
> We could add a command line option to rpc.nfsd. That doesn't
> seem convenient for automated testers, though.
>=20

It's starting to feel like we ought to create a new nfsdctl program or
something. It could dump the new stats and allow you to twiddle knobs
like this one. Maybe we could teach it to start up and shut down the
server too so it eventually could replace rpc.nfsd?

That might be simpler than plumbing netlink support into rpc.nfsd.

>=20
> > > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/ne=
tlink/specs/nfsd.yaml
> > > index 05acc73e2e33..1a3c5e78b388 100644
> > > --- a/Documentation/netlink/specs/nfsd.yaml
> > > +++ b/Documentation/netlink/specs/nfsd.yaml
> > > @@ -62,6 +62,12 @@ attribute-sets:
> > >         name: compound-ops
> > >         type: u32
> > >         multi-attr: true
> > > +  -
> > > +    name: splice-read
> > > +    attributes:
> > > +      -
> > > +        name: enabled
> > > +        type: u32
> > >=20
> > > operations:
> > >   list:
> > > @@ -87,3 +93,16 @@ operations:
> > >             - sport
> > >             - dport
> > >             - compound-ops
> > > +    -
> > > +      name: splice-read
> > > +      doc: Disable the use of splice for NFS READ operations
> > > +      attribute-set: splice-read
> > > +      flags: [ admin-perm ]
> > > +      do:
> > > +        request:
> > > +          attributes:
> > > +            - enabled
> > > +      dump:
> > > +        reply:
> > > +          attributes:
> > > +            - enabled
> > > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > > index 0e1d635ec5f9..c47f3527d30b 100644
> > > --- a/fs/nfsd/netlink.c
> > > +++ b/fs/nfsd/netlink.c
> > > @@ -10,6 +10,11 @@
> > >=20
> > > #include <uapi/linux/nfsd_netlink.h>
> > >=20
> > > +/* NFSD_CMD_SPLICE_READ - do */
> > > +static const struct nla_policy nfsd_splice_read_nl_policy[NFSD_A_SPL=
ICE_READ_ENABLED + 1] =3D {
> > > + [NFSD_A_SPLICE_READ_ENABLED] =3D { .type =3D NLA_U32, },
> > > +};
> > > +
> > > /* Ops table for nfsd */
> > > static const struct genl_split_ops nfsd_nl_ops[] =3D {
> > > {
> > > @@ -19,6 +24,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =
=3D {
> > > .done =3D nfsd_nl_rpc_status_get_done,
> > > .flags =3D GENL_CMD_CAP_DUMP,
> > > },
> > > + {
> > > + .cmd =3D NFSD_CMD_SPLICE_READ,
> > > + .doit =3D nfsd_nl_splice_read_doit,
> > > + .policy =3D nfsd_splice_read_nl_policy,
> > > + .maxattr =3D NFSD_A_SPLICE_READ_ENABLED,
> > > + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > + },
> > > + {
> > > + .cmd =3D NFSD_CMD_SPLICE_READ,
> > > + .dumpit =3D nfsd_nl_splice_read_dumpit,
> > > + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> > > + },
> > > };
> > >=20
> > > struct genl_family nfsd_nl_family __ro_after_init =3D {
> > > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > > index d83dd6bdee92..2d96d0f093bb 100644
> > > --- a/fs/nfsd/netlink.h
> > > +++ b/fs/nfsd/netlink.h
> > > @@ -16,6 +16,9 @@ int nfsd_nl_rpc_status_get_done(struct netlink_call=
back *cb);
> > >=20
> > > int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> > >   struct netlink_callback *cb);
> > > +int nfsd_nl_splice_read_doit(struct sk_buff *skb, struct genl_info *=
info);
> > > +int nfsd_nl_splice_read_dumpit(struct sk_buff *skb,
> > > +        struct netlink_callback *cb);
> > >=20
> > > extern struct genl_family nfsd_nl_family;
> > >=20
> > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > index 74b4360779a1..3b9e09fecbfc 100644
> > > --- a/fs/nfsd/netns.h
> > > +++ b/fs/nfsd/netns.h
> > > @@ -109,6 +109,7 @@ struct nfsd_net {
> > >=20
> > > bool nfsd_net_up;
> > > bool lockd_up;
> > > + bool spliced_reads;
> > >=20
> > > seqlock_t writeverf_lock;
> > > unsigned char writeverf[8];
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 8e6dbe9e0b65..86f466dbc784 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1696,6 +1696,51 @@ int nfsd_nl_rpc_status_get_done(struct netlink=
_callback *cb)
> > > return 0;
> > > }
> > >=20
> > > +/**
> > > + * nfsd_nl_splice_read_doit - Set the value of splice_read
> > > + * @skb: call buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Returns zero on success, or a negative errno.
> > > + */
> > > +int nfsd_nl_splice_read_doit(struct sk_buff *skb, struct genl_info *=
info)
> > > +{
> > > + struct nfsd_net *nn =3D net_generic(sock_net(skb->sk), nfsd_net_id)=
;
> > > + u32 newval;
> > > +
> > > + if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SPLICE_READ_ENABLED))
> > > + return -EINVAL;
> > > +
> > > + newval =3D nla_get_u32(info->attrs[NFSD_A_SPLICE_READ_ENABLED]);
> > > + nn->spliced_reads =3D newval ? true : false;
> > > + return 0;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_splice_read_dumpit - Return the value of splice_read
> > > + * @skb: reply buffer
> > > + * @cb: netlink metadata and command arguments
> > > + *
> > > + * Returns the size of the reply or a negative errno.
> > > + */
> > > +int nfsd_nl_splice_read_dumpit(struct sk_buff *skb, struct netlink_c=
allback *cb)
> > > +{
> > > + struct nfsd_net *nn =3D net_generic(sock_net(skb->sk), nfsd_net_id)=
;
> > > + void *hdr;
> > > +
> > > + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg=
_seq,
> > > +   &nfsd_nl_family, 0, NFSD_CMD_SPLICE_READ);
> > > + if (!hdr)
> > > + return -ENOBUFS;
> > > +
> > > + if (nla_put_s32(skb, NFSD_A_SPLICE_READ_ENABLED,
> > > + (nn->spliced_reads ? 1 : 0)))
> > > + return -ENOBUFS;
> > > +
> > > + genlmsg_end(skb, hdr);
> > > + return 0;
> > > +}
> > > +
> > > /**
> > >  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespac=
e
> > >  * @net: a freshly-created network namespace
> > > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/n=
fsd_netlink.h
> > > index 3cd044edee5d..c2542ed18b50 100644
> > > --- a/include/uapi/linux/nfsd_netlink.h
> > > +++ b/include/uapi/linux/nfsd_netlink.h
> > > @@ -29,8 +29,16 @@ enum {
> > > NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
> > > };
> > >=20
> > > +enum {
> > > + NFSD_A_SPLICE_READ_ENABLED =3D 1,
> > > +
> > > + __NFSD_A_SPLICE_READ_MAX,
> > > + NFSD_A_SPLICE_READ_MAX =3D (__NFSD_A_SPLICE_READ_MAX - 1)
> > > +};
> > > +
> > > enum {
> > > NFSD_CMD_RPC_STATUS_GET =3D 1,
> > > + NFSD_CMD_SPLICE_READ,
> > >=20
> > > __NFSD_CMD_MAX,
> > > NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > > diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/gene=
rated/nfsd-user.c
> > > index 360b6448c6e9..14957bdfbe9c 100644
> > > --- a/tools/net/ynl/generated/nfsd-user.c
> > > +++ b/tools/net/ynl/generated/nfsd-user.c
> > > @@ -15,6 +15,7 @@
> > > /* Enums */
> > > static const char * const nfsd_op_strmap[] =3D {
> > > [NFSD_CMD_RPC_STATUS_GET] =3D "rpc-status-get",
> > > + [NFSD_CMD_SPLICE_READ] =3D "splice-read",
> > > };
> > >=20
> > > const char *nfsd_op_str(int op)
> > > @@ -47,6 +48,15 @@ struct ynl_policy_nest nfsd_rpc_status_nest =3D {
> > > .table =3D nfsd_rpc_status_policy,
> > > };
> > >=20
> > > +struct ynl_policy_attr nfsd_splice_read_policy[NFSD_A_SPLICE_READ_MA=
X + 1] =3D {
> > > + [NFSD_A_SPLICE_READ_ENABLED] =3D { .name =3D "enabled", .type =3D Y=
NL_PT_U32, },
> > > +};
> > > +
> > > +struct ynl_policy_nest nfsd_splice_read_nest =3D {
> > > + .max_attr =3D NFSD_A_SPLICE_READ_MAX,
> > > + .table =3D nfsd_splice_read_policy,
> > > +};
> > > +
> > > /* Common nested types */
> > > /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_GET=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > /* NFSD_CMD_RPC_STATUS_GET - dump */
> > > @@ -198,6 +208,91 @@ nfsd_rpc_status_get_dump(struct ynl_sock *ys)
> > > return NULL;
> > > }
> > >=20
> > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_SPLICE_READ =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > +/* NFSD_CMD_SPLICE_READ - do */
> > > +void nfsd_splice_read_req_free(struct nfsd_splice_read_req *req)
> > > +{
> > > + free(req);
> > > +}
> > > +
> > > +int nfsd_splice_read(struct ynl_sock *ys, struct nfsd_splice_read_re=
q *req)
> > > +{
> > > + struct nlmsghdr *nlh;
> > > + int err;
> > > +
> > > + nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_SPLICE_READ=
, 1);
> > > + ys->req_policy =3D &nfsd_splice_read_nest;
> > > +
> > > + if (req->_present.enabled)
> > > + mnl_attr_put_u32(nlh, NFSD_A_SPLICE_READ_ENABLED, req->enabled);
> > > +
> > > + err =3D ynl_exec(ys, nlh, NULL);
> > > + if (err < 0)
> > > + return -1;
> > > +
> > > + return 0;
> > > +}
> > > +
> > > +/* NFSD_CMD_SPLICE_READ - dump */
> > > +int nfsd_splice_read_rsp_dump_parse(const struct nlmsghdr *nlh, void=
 *data)
> > > +{
> > > + struct nfsd_splice_read_rsp_dump *dst;
> > > + struct ynl_parse_arg *yarg =3D data;
> > > + const struct nlattr *attr;
> > > +
> > > + dst =3D yarg->data;
> > > +
> > > + mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> > > + unsigned int type =3D mnl_attr_get_type(attr);
> > > +
> > > + if (type =3D=3D NFSD_A_SPLICE_READ_ENABLED) {
> > > + if (ynl_attr_validate(yarg, attr))
> > > + return MNL_CB_ERROR;
> > > + dst->_present.enabled =3D 1;
> > > + dst->enabled =3D mnl_attr_get_u32(attr);
> > > + }
> > > + }
> > > +
> > > + return MNL_CB_OK;
> > > +}
> > > +
> > > +void nfsd_splice_read_rsp_list_free(struct nfsd_splice_read_rsp_list=
 *rsp)
> > > +{
> > > + struct nfsd_splice_read_rsp_list *next =3D rsp;
> > > +
> > > + while ((void *)next !=3D YNL_LIST_END) {
> > > + rsp =3D next;
> > > + next =3D rsp->next;
> > > +
> > > + free(rsp);
> > > + }
> > > +}
> > > +
> > > +struct nfsd_splice_read_rsp_list *nfsd_splice_read_dump(struct ynl_s=
ock *ys)
> > > +{
> > > + struct ynl_dump_state yds =3D {};
> > > + struct nlmsghdr *nlh;
> > > + int err;
> > > +
> > > + yds.ys =3D ys;
> > > + yds.alloc_sz =3D sizeof(struct nfsd_splice_read_rsp_list);
> > > + yds.cb =3D nfsd_splice_read_rsp_dump_parse;
> > > + yds.rsp_cmd =3D NFSD_CMD_SPLICE_READ;
> > > + yds.rsp_policy =3D &nfsd_splice_read_nest;
> > > +
> > > + nlh =3D ynl_gemsg_start_dump(ys, ys->family_id, NFSD_CMD_SPLICE_REA=
D, 1);
> > > +
> > > + err =3D ynl_exec_dump(ys, nlh, &yds);
> > > + if (err < 0)
> > > + goto free_list;
> > > +
> > > + return yds.first;
> > > +
> > > +free_list:
> > > + nfsd_splice_read_rsp_list_free(yds.first);
> > > + return NULL;
> > > +}
> > > +
> > > const struct ynl_family ynl_nfsd_family =3D  {
> > > .name =3D "nfsd",
> > > };
> > > diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/gene=
rated/nfsd-user.h
> > > index 989c6e209ced..5732c5a665e7 100644
> > > --- a/tools/net/ynl/generated/nfsd-user.h
> > > +++ b/tools/net/ynl/generated/nfsd-user.h
> > > @@ -64,4 +64,51 @@ nfsd_rpc_status_get_rsp_list_free(struct nfsd_rpc_=
status_get_rsp_list *rsp);
> > > struct nfsd_rpc_status_get_rsp_list *
> > > nfsd_rpc_status_get_dump(struct ynl_sock *ys);
> > >=20
> > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_SPLICE_READ =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > +/* NFSD_CMD_SPLICE_READ - do */
> > > +struct nfsd_splice_read_req {
> > > + struct {
> > > + __u32 enabled:1;
> > > + } _present;
> > > +
> > > + __u32 enabled;
> > > +};
> > > +
> > > +static inline struct nfsd_splice_read_req *nfsd_splice_read_req_allo=
c(void)
> > > +{
> > > + return calloc(1, sizeof(struct nfsd_splice_read_req));
> > > +}
> > > +void nfsd_splice_read_req_free(struct nfsd_splice_read_req *req);
> > > +
> > > +static inline void
> > > +nfsd_splice_read_req_set_enabled(struct nfsd_splice_read_req *req,
> > > +  __u32 enabled)
> > > +{
> > > + req->_present.enabled =3D 1;
> > > + req->enabled =3D enabled;
> > > +}
> > > +
> > > +/*
> > > + * Disable the use of splice for NFS READ operations
> > > + */
> > > +int nfsd_splice_read(struct ynl_sock *ys, struct nfsd_splice_read_re=
q *req);
> > > +
> > > +/* NFSD_CMD_SPLICE_READ - dump */
> > > +struct nfsd_splice_read_rsp_dump {
> > > + struct {
> > > + __u32 enabled:1;
> > > + } _present;
> > > +
> > > + __u32 enabled;
> > > +};
> > > +
> > > +struct nfsd_splice_read_rsp_list {
> > > + struct nfsd_splice_read_rsp_list *next;
> > > + struct nfsd_splice_read_rsp_dump obj __attribute__ ((aligned (8)));
> > > +};
> > > +
> > > +void nfsd_splice_read_rsp_list_free(struct nfsd_splice_read_rsp_list=
 *rsp);
> > > +
> > > +struct nfsd_splice_read_rsp_list *nfsd_splice_read_dump(struct ynl_s=
ock *ys);
> > > +
> > > #endif /* _LINUX_NFSD_GEN_H */
> > >=20
> > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

