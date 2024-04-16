Return-Path: <linux-nfs+bounces-2834-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E48A615F
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 05:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E18282E56
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 03:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482A0171D8;
	Tue, 16 Apr 2024 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YXs8/IDw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3cAUSUXY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YXs8/IDw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3cAUSUXY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A769210FF;
	Tue, 16 Apr 2024 03:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237407; cv=none; b=WRJC6edSBIAtHpSIJYxbGCAazRLpzwSEZ3e3P3FKyIR5CH4eBeCh2+uV2qEKCtTIahYAP22FWhLUsLxAVvUtEoWKScUR3TFb7bsaMI196zhRZYeeKdMkvvOE6bmuL/1UoIixJrtY3/xOEpqU+Ok3yZ20m+zfKC8oiK5RiYOPb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237407; c=relaxed/simple;
	bh=/auyovir5ZGpY9sSEgAdCiJLYoAKsSpC63k1nJaFHLE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WuhpYZIFZ5ar52zaQg1SGGMZm5lgrETsewhz63mc0hK6sTHC3NaLPKsbm2fUkagMn2vFU4ZCiTkPdplTLNpQ9zLX+RluNCakQ2sJ3+7p1UAmDyKBuOh4lUipRZVo8lX9FiDR9zYqTN+UPOW/SpXsFi7+Nm+6+Rwgw1o2cE+CDaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YXs8/IDw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3cAUSUXY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YXs8/IDw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3cAUSUXY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05CDB5D68D;
	Tue, 16 Apr 2024 03:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713237403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3IwY1+lgMoO1UyxVvfhOW8lPkLDwNY/MY3v1OPHK8k=;
	b=YXs8/IDwhzDUf0moUGuLqezfaNOEdjrVh8BkwAnw1eSMcxxyEq7cbk029YJfJnsSrbA1ke
	HrDHR2QPWbtFlBSFnoJfspWXHY3CN2cn+6fX5NwtC5SvTk+nTCRvK6pzg/dTyoINKb2lOA
	+9+SVfHEjXkLg4lEYR575Iz007KwgJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713237403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3IwY1+lgMoO1UyxVvfhOW8lPkLDwNY/MY3v1OPHK8k=;
	b=3cAUSUXY466gQHm3pA2qQRORklb38NBrRF4oq4n7A3xfAY/57Es6fXUuscSsNs6NLOgH9K
	U9yZMvGD+xmgyBAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="YXs8/IDw";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3cAUSUXY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713237403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3IwY1+lgMoO1UyxVvfhOW8lPkLDwNY/MY3v1OPHK8k=;
	b=YXs8/IDwhzDUf0moUGuLqezfaNOEdjrVh8BkwAnw1eSMcxxyEq7cbk029YJfJnsSrbA1ke
	HrDHR2QPWbtFlBSFnoJfspWXHY3CN2cn+6fX5NwtC5SvTk+nTCRvK6pzg/dTyoINKb2lOA
	+9+SVfHEjXkLg4lEYR575Iz007KwgJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713237403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3IwY1+lgMoO1UyxVvfhOW8lPkLDwNY/MY3v1OPHK8k=;
	b=3cAUSUXY466gQHm3pA2qQRORklb38NBrRF4oq4n7A3xfAY/57Es6fXUuscSsNs6NLOgH9K
	U9yZMvGD+xmgyBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7378138A7;
	Tue, 16 Apr 2024 03:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0ttMEpftHWa6CwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Apr 2024 03:16:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
 chuck.lever@oracle.com, netdev@vger.kernel.org, kuba@kernel.org,
 jlayton@kernel.org
Subject: Re: [PATCH v8 3/6] NFSD: add write_version to netlink command
In-reply-to:
 <1036367642228283184f85715edc0e3227a8e3ae.1713209938.git.lorenzo@kernel.org>
References: <cover.1713209938.git.lorenzo@kernel.org>,
 <1036367642228283184f85715edc0e3227a8e3ae.1713209938.git.lorenzo@kernel.org>
Date: Tue, 16 Apr 2024 13:16:26 +1000
Message-id: <171323738652.17212.6092555402353724533@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 05CDB5D68D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]

On Tue, 16 Apr 2024, Lorenzo Bianconi wrote:
> Introduce write_version netlink command through a "declarative" interface.
> This patch introduces a change in behavior since for version-set userspace
> is expected to provide a NFS major/minor version list it wants to enable
> while all the other ones will be disabled. (procfs write_version
> command implements imperative interface where the admin writes +3/-3 to
> enable/disable a single version.

It seems a little weird to me that the interface always disables all
version, but then also allows individual versions to be disabled.

Would it be reasonable to simply ignore the "enabled" flag when setting
version, and just enable all versions listed??

Or maybe only enable those with the flag, and don't disable those
without the flag?

Those don't necessarily seem much better - but the current behaviour
still seems odd.

Also for getting the version, the doc says:

     doc: get nfs enabled versions

which I don't think it quite right.  The code reports all supported
versions, and indicates which of those are enabled.  So maybe:

     doc: get enabled status for all supported versions

I think that fact that it actually lists all supported versions is
useful and worth making explicit.

Thanks,
NeilBrown


>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  37 +++++++
>  fs/nfsd/netlink.c                     |  24 +++++
>  fs/nfsd/netlink.h                     |   5 +
>  fs/nfsd/netns.h                       |   1 +
>  fs/nfsd/nfsctl.c                      | 150 ++++++++++++++++++++++++++
>  fs/nfsd/nfssvc.c                      |   3 +-
>  include/uapi/linux/nfsd_netlink.h     |  18 ++++
>  7 files changed, 236 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/=
specs/nfsd.yaml
> index cbe6c5fd6c4d..0396e8b3ea1f 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -74,6 +74,26 @@ attribute-sets:
>        -
>          name: leasetime
>          type: u32
> +  -
> +    name: version
> +    attributes:
> +      -
> +        name: major
> +        type: u32
> +      -
> +        name: minor
> +        type: u32
> +      -
> +        name: enabled
> +        type: flag
> +  -
> +    name: server-proto
> +    attributes:
> +      -
> +        name: version
> +        type: nest
> +        nested-attributes: version
> +        multi-attr: true
> =20
>  operations:
>    list:
> @@ -120,3 +140,20 @@ operations:
>              - threads
>              - gracetime
>              - leasetime
> +    -
> +      name: version-set
> +      doc: set nfs enabled versions
> +      attribute-set: server-proto
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - version
> +    -
> +      name: version-get
> +      doc: get nfs enabled versions
> +      attribute-set: server-proto
> +      do:
> +        reply:
> +          attributes:
> +            - version
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 20a646af0324..bf5df9597288 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -10,6 +10,13 @@
> =20
>  #include <uapi/linux/nfsd_netlink.h>
> =20
> +/* Common nested types */
> +const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1]=
 =3D {
> +	[NFSD_A_VERSION_MAJOR] =3D { .type =3D NLA_U32, },
> +	[NFSD_A_VERSION_MINOR] =3D { .type =3D NLA_U32, },
> +	[NFSD_A_VERSION_ENABLED] =3D { .type =3D NLA_FLAG, },
> +};
> +
>  /* NFSD_CMD_THREADS_SET - do */
>  static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WO=
RKER_LEASETIME + 1] =3D {
>  	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> @@ -17,6 +24,11 @@ static const struct nla_policy nfsd_threads_set_nl_polic=
y[NFSD_A_SERVER_WORKER_L
>  	[NFSD_A_SERVER_WORKER_LEASETIME] =3D { .type =3D NLA_U32, },
>  };
> =20
> +/* NFSD_CMD_VERSION_SET - do */
> +static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_PR=
OTO_VERSION + 1] =3D {
> +	[NFSD_A_SERVER_PROTO_VERSION] =3D NLA_POLICY_NESTED(nfsd_version_nl_polic=
y),
> +};
> +
>  /* Ops table for nfsd */
>  static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  	{
> @@ -38,6 +50,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  		.doit	=3D nfsd_nl_threads_get_doit,
>  		.flags	=3D GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		=3D NFSD_CMD_VERSION_SET,
> +		.doit		=3D nfsd_nl_version_set_doit,
> +		.policy		=3D nfsd_version_set_nl_policy,
> +		.maxattr	=3D NFSD_A_SERVER_PROTO_VERSION,
> +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd	=3D NFSD_CMD_VERSION_GET,
> +		.doit	=3D nfsd_nl_version_get_doit,
> +		.flags	=3D GENL_CMD_CAP_DO,
> +	},
>  };
> =20
>  struct genl_family nfsd_nl_family __ro_after_init =3D {
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index 4137fac477e4..c7c0da275481 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -11,6 +11,9 @@
> =20
>  #include <uapi/linux/nfsd_netlink.h>
> =20
> +/* Common nested types */
> +extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABL=
ED + 1];
> +
>  int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
>  int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> =20
> @@ -18,6 +21,8 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  				  struct netlink_callback *cb);
>  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
>  int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
> +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info);
> +int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info);
> =20
>  extern struct genl_family nfsd_nl_family;
> =20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index d4be519b5734..14ec15656320 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -218,6 +218,7 @@ struct nfsd_net {
>  /* Simple check to find out if a given net was properly initialized */
>  #define nfsd_netns_ready(nn) ((nn)->sessionid_hashtbl)
> =20
> +extern bool nfsd_support_version(int vers);
>  extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> =20
>  extern unsigned int nfsd_net_id;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 38a5df03981b..2c8929ef79e9 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1757,6 +1757,156 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, s=
truct genl_info *info)
>  	return err;
>  }
> =20
> +/**
> + * nfsd_nl_version_set_doit - set the nfs enabled versions
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	const struct nlattr *attr;
> +	struct nfsd_net *nn;
> +	int i, rem;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_PROTO_VERSION))
> +		return -EINVAL;
> +
> +	mutex_lock(&nfsd_mutex);
> +
> +	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> +	if (nn->nfsd_serv) {
> +		mutex_unlock(&nfsd_mutex);
> +		return -EBUSY;
> +	}
> +
> +	/* clear current supported versions. */
> +	nfsd_vers(nn, 2, NFSD_CLEAR);
> +	nfsd_vers(nn, 3, NFSD_CLEAR);
> +	for (i =3D 0; i <=3D NFSD_SUPPORTED_MINOR_VERSION; i++)
> +		nfsd_minorversion(nn, i, NFSD_CLEAR);
> +
> +	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> +		struct nlattr *tb[NFSD_A_VERSION_MAX + 1];
> +		u32 major, minor =3D 0;
> +		bool enabled;
> +
> +		if (nla_type(attr) !=3D NFSD_A_SERVER_PROTO_VERSION)
> +			continue;
> +
> +		if (nla_parse_nested(tb, NFSD_A_VERSION_MAX, attr,
> +				     nfsd_version_nl_policy, info->extack) < 0)
> +			continue;
> +
> +		if (!tb[NFSD_A_VERSION_MAJOR])
> +			continue;
> +
> +		major =3D nla_get_u32(tb[NFSD_A_VERSION_MAJOR]);
> +		if (tb[NFSD_A_VERSION_MINOR])
> +			minor =3D nla_get_u32(tb[NFSD_A_VERSION_MINOR]);
> +
> +		enabled =3D nla_get_flag(tb[NFSD_A_VERSION_ENABLED]);
> +
> +		switch (major) {
> +		case 4:
> +			nfsd_minorversion(nn, minor, enabled ? NFSD_SET : NFSD_CLEAR);
> +			break;
> +		case 3:
> +		case 2:
> +			if (!minor)
> +				nfsd_vers(nn, major, enabled ? NFSD_SET : NFSD_CLEAR);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return 0;
> +}
> +
> +/**
> + * nfsd_nl_version_get_doit - get the nfs enabled versions
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nfsd_net *nn;
> +	int i, err;
> +	void *hdr;
> +
> +	skb =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr =3D genlmsg_iput(skb, info);
> +	if (!hdr) {
> +		err =3D -EMSGSIZE;
> +		goto err_free_msg;
> +	}
> +
> +	mutex_lock(&nfsd_mutex);
> +	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> +
> +	for (i =3D 2; i <=3D 4; i++) {
> +		int j;
> +
> +		for (j =3D 0; j <=3D NFSD_SUPPORTED_MINOR_VERSION; j++) {
> +			struct nlattr *attr;
> +
> +			/* Don't record any versions the kernel doesn't have
> +			 * compiled in
> +			 */
> +			if (!nfsd_support_version(i))
> +				continue;
> +
> +			/* NFSv{2,3} does not support minor numbers */
> +			if (i < 4 && j)
> +				continue;
> +
> +			attr =3D nla_nest_start(skb,
> +					      NFSD_A_SERVER_PROTO_VERSION);
> +			if (!attr) {
> +				err =3D -EINVAL;
> +				goto err_nfsd_unlock;
> +			}
> +
> +			if (nla_put_u32(skb, NFSD_A_VERSION_MAJOR, i) ||
> +			    nla_put_u32(skb, NFSD_A_VERSION_MINOR, j)) {
> +				err =3D -EINVAL;
> +				goto err_nfsd_unlock;
> +			}
> +
> +			/* Set the enabled flag if the version is enabled */
> +			if (nfsd_vers(nn, i, NFSD_TEST) &&
> +			    (i < 4 || nfsd_minorversion(nn, j, NFSD_TEST)) &&
> +			    nla_put_flag(skb, NFSD_A_VERSION_ENABLED)) {
> +				err =3D -EINVAL;
> +				goto err_nfsd_unlock;
> +			}
> +
> +			nla_nest_end(skb, attr);
> +		}
> +	}
> +
> +	mutex_unlock(&nfsd_mutex);
> +	genlmsg_end(skb, hdr);
> +
> +	return genlmsg_reply(skb, info);
> +
> +err_nfsd_unlock:
> +	mutex_unlock(&nfsd_mutex);
> +err_free_msg:
> +	nlmsg_free(skb);
> +
> +	return err;
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index ca193f7ff0e1..4fc91f50138a 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -133,8 +133,7 @@ struct svc_program		nfsd_program =3D {
>  	.pg_rpcbind_set		=3D nfsd_rpcbind_set,
>  };
> =20
> -static bool
> -nfsd_support_version(int vers)
> +bool nfsd_support_version(int vers)
>  {
>  	if (vers >=3D NFSD_MINVERS && vers < NFSD_NRVERS)
>  		return nfsd_version[vers] !=3D NULL;
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_ne=
tlink.h
> index ccc78a5ee650..8a0a2b344923 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -38,10 +38,28 @@ enum {
>  	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
>  };
> =20
> +enum {
> +	NFSD_A_VERSION_MAJOR =3D 1,
> +	NFSD_A_VERSION_MINOR,
> +	NFSD_A_VERSION_ENABLED,
> +
> +	__NFSD_A_VERSION_MAX,
> +	NFSD_A_VERSION_MAX =3D (__NFSD_A_VERSION_MAX - 1)
> +};
> +
> +enum {
> +	NFSD_A_SERVER_PROTO_VERSION =3D 1,
> +
> +	__NFSD_A_SERVER_PROTO_MAX,
> +	NFSD_A_SERVER_PROTO_MAX =3D (__NFSD_A_SERVER_PROTO_MAX - 1)
> +};
> +
>  enum {
>  	NFSD_CMD_RPC_STATUS_GET =3D 1,
>  	NFSD_CMD_THREADS_SET,
>  	NFSD_CMD_THREADS_GET,
> +	NFSD_CMD_VERSION_SET,
> +	NFSD_CMD_VERSION_GET,
> =20
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> --=20
> 2.44.0
>=20
>=20


