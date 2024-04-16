Return-Path: <linux-nfs+bounces-2854-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD218A77C2
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 00:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365D41C21C16
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Apr 2024 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004AF84E0C;
	Tue, 16 Apr 2024 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fjOSM1NY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W5hk69oL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fjOSM1NY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W5hk69oL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00784D3B;
	Tue, 16 Apr 2024 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713306527; cv=none; b=rAZQSjsJrYF4JVl8qR+PGGi6NWCdhOCHPnlxjRg5I2CvaPsk5Jdh+ZsUzS7S9YxTwOXMfv5rb25Gf1kfgxLE6MHyRT2aVO5ErR+J+0XPIsO/QrYlBYRDjX52yWKxhrfWnD0uLIF3e6SW1+CnbRng2UE9A0FMcijFmLmmJ5Yfv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713306527; c=relaxed/simple;
	bh=43ggudsvQTZKaXFGAoljkt0JnDEsFhO+Y3m34cP0svU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=u02euvwQKE21IUMpUn8laKfEb2UtpPP67eHIAYR0e1BDGAh+tZaTv5e4nTZdDOXZ/DEJGvkkaBOLgKH5DozmDHQ3EWAGPf/KerADEKasHO2mnG2CvVZFJ0vnd8clxDOCh965tEd5BoRU6QhgTtq5VcKLK6y85byTKZ3LHyBSoyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fjOSM1NY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W5hk69oL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fjOSM1NY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W5hk69oL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13DB82280C;
	Tue, 16 Apr 2024 22:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713306524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ9FCDXlN7R0d7/mZxq0OQNJPfx2sZYrt83BD8WSZNo=;
	b=fjOSM1NYBuIQYbkzq3kObkl7Gvyx57BwR4pZ/HblHclLnIFuSQDR9UIulmeeHarhvABxRR
	ecogG4SkS6uUWNXX+qtFdUYUR/nyC79f+y826MWMxdQUrZizOU6sYHKEuk/nnM7VN1+Tv5
	ZDV9EBq718TLHyFoAc4EtvSRGYjjYdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713306524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ9FCDXlN7R0d7/mZxq0OQNJPfx2sZYrt83BD8WSZNo=;
	b=W5hk69oLMrySwtx0wF2z4O+E//lR5ej08/Idl5RA2492u9os/Axesv8Ch9Metlh1a7o895
	KXFYmf2MeGkK9LBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713306524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ9FCDXlN7R0d7/mZxq0OQNJPfx2sZYrt83BD8WSZNo=;
	b=fjOSM1NYBuIQYbkzq3kObkl7Gvyx57BwR4pZ/HblHclLnIFuSQDR9UIulmeeHarhvABxRR
	ecogG4SkS6uUWNXX+qtFdUYUR/nyC79f+y826MWMxdQUrZizOU6sYHKEuk/nnM7VN1+Tv5
	ZDV9EBq718TLHyFoAc4EtvSRGYjjYdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713306524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ9FCDXlN7R0d7/mZxq0OQNJPfx2sZYrt83BD8WSZNo=;
	b=W5hk69oLMrySwtx0wF2z4O+E//lR5ej08/Idl5RA2492u9os/Axesv8Ch9Metlh1a7o895
	KXFYmf2MeGkK9LBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DFBD13931;
	Tue, 16 Apr 2024 22:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GF/tLJj7HmbcDQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Apr 2024 22:28:40 +0000
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
Subject: Re: [PATCH v8 2/6] NFSD: convert write_threads to netlink command
In-reply-to:
 <4ff777ebb8652e31709bd91c3af50693edf86a26.1713209938.git.lorenzo@kernel.org>
References: <cover.1713209938.git.lorenzo@kernel.org>,
 <4ff777ebb8652e31709bd91c3af50693edf86a26.1713209938.git.lorenzo@kernel.org>
Date: Wed, 17 Apr 2024 08:28:33 +1000
Message-id: <171330651306.17212.2078718779289951086@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Tue, 16 Apr 2024, Lorenzo Bianconi wrote:
> Introduce write_threads netlink command similar to the one available
> through the procfs.
>=20
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Co-developed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  33 ++++++++
>  fs/nfsd/netlink.c                     |  19 +++++
>  fs/nfsd/netlink.h                     |   2 +
>  fs/nfsd/nfsctl.c                      | 104 ++++++++++++++++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  11 +++
>  5 files changed, 169 insertions(+)
>=20
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/=
specs/nfsd.yaml
> index 05acc73e2e33..cbe6c5fd6c4d 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -62,6 +62,18 @@ attribute-sets:
>          name: compound-ops
>          type: u32
>          multi-attr: true
> +  -
> +    name: server-worker
> +    attributes:
> +      -
> +        name: threads
> +        type: u32
> +      -
> +        name: gracetime
> +        type: u32
> +      -
> +        name: leasetime
> +        type: u32

Another thought: I would be really happy if the "scope" were another
optional argument here.  The mechanism of setting the scope by user the
hostname works but is ugly.  I'm inclined to ignore the hostname
completely when netlink is used, but I'm not completely sure about that.
(aside - I think using the hostname for the default scope was a really
bad idea.  It should have been a fixed string like "Linux").

NeilBrown



> =20
>  operations:
>    list:
> @@ -87,3 +99,24 @@ operations:
>              - sport
>              - dport
>              - compound-ops
> +    -
> +      name: threads-set
> +      doc: set the number of running threads
> +      attribute-set: server-worker
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - threads
> +            - gracetime
> +            - leasetime
> +    -
> +      name: threads-get
> +      doc: get the number of running threads
> +      attribute-set: server-worker
> +      do:
> +        reply:
> +          attributes:
> +            - threads
> +            - gracetime
> +            - leasetime
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 0e1d635ec5f9..20a646af0324 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -10,6 +10,13 @@
> =20
>  #include <uapi/linux/nfsd_netlink.h>
> =20
> +/* NFSD_CMD_THREADS_SET - do */
> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_WO=
RKER_LEASETIME + 1] =3D {
> +	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> +	[NFSD_A_SERVER_WORKER_GRACETIME] =3D { .type =3D NLA_U32, },
> +	[NFSD_A_SERVER_WORKER_LEASETIME] =3D { .type =3D NLA_U32, },
> +};
> +
>  /* Ops table for nfsd */
>  static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  	{
> @@ -19,6 +26,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  		.done	=3D nfsd_nl_rpc_status_get_done,
>  		.flags	=3D GENL_CMD_CAP_DUMP,
>  	},
> +	{
> +		.cmd		=3D NFSD_CMD_THREADS_SET,
> +		.doit		=3D nfsd_nl_threads_set_doit,
> +		.policy		=3D nfsd_threads_set_nl_policy,
> +		.maxattr	=3D NFSD_A_SERVER_WORKER_LEASETIME,
> +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd	=3D NFSD_CMD_THREADS_GET,
> +		.doit	=3D nfsd_nl_threads_get_doit,
> +		.flags	=3D GENL_CMD_CAP_DO,
> +	},
>  };
> =20
>  struct genl_family nfsd_nl_family __ro_after_init =3D {
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index d83dd6bdee92..4137fac477e4 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -16,6 +16,8 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *=
cb);
> =20
>  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  				  struct netlink_callback *cb);
> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
> +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
> =20
>  extern struct genl_family nfsd_nl_family;
> =20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f2e442d7fe16..38a5df03981b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1653,6 +1653,110 @@ int nfsd_nl_rpc_status_get_done(struct netlink_call=
back *cb)
>  	return 0;
>  }
> =20
> +/**
> + * nfsd_nl_threads_set_doit - set the number of running threads
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct net *net =3D genl_info_net(info);
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	int ret =3D -EBUSY;
> +	u32 nthreads;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_WORKER_THREADS))
> +		return -EINVAL;
> +
> +	nthreads =3D nla_get_u32(info->attrs[NFSD_A_SERVER_WORKER_THREADS]);
> +
> +	mutex_lock(&nfsd_mutex);
> +	if (info->attrs[NFSD_A_SERVER_WORKER_GRACETIME] ||
> +	    info->attrs[NFSD_A_SERVER_WORKER_LEASETIME]) {
> +		const struct nlattr *attr;
> +
> +		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
> +			goto out_unlock;
> +
> +		ret =3D -EINVAL;
> +		attr =3D info->attrs[NFSD_A_SERVER_WORKER_GRACETIME];
> +		if (attr) {
> +			u32 gracetime =3D nla_get_u32(attr);
> +
> +			if (gracetime < 10 || gracetime > 3600)
> +				goto out_unlock;
> +
> +			nn->nfsd4_grace =3D gracetime;
> +		}
> +
> +		attr =3D info->attrs[NFSD_A_SERVER_WORKER_LEASETIME];
> +		if (attr) {
> +			u32 leasetime =3D nla_get_u32(attr);
> +
> +			if (leasetime < 10 || leasetime > 3600)
> +				goto out_unlock;
> +
> +			nn->nfsd4_lease =3D leasetime;
> +		}
> +	}
> +
> +	ret =3D nfsd_svc(nthreads, net, get_current_cred());
> +out_unlock:
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return ret =3D=3D nthreads ? 0 : ret;
> +}
> +
> +/**
> + * nfsd_nl_threads_get_doit - get the number of running threads
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct net *net =3D genl_info_net(info);
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	void *hdr;
> +	int err;
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
> +	err =3D nla_put_u32(skb, NFSD_A_SERVER_WORKER_GRACETIME,
> +			  nn->nfsd4_grace) ||
> +	      nla_put_u32(skb, NFSD_A_SERVER_WORKER_LEASETIME,
> +			  nn->nfsd4_lease) ||
> +	      nla_put_u32(skb, NFSD_A_SERVER_WORKER_THREADS,
> +			  nn->nfsd_serv ? nn->nfsd_serv->sv_nrthreads : 0);
> +	mutex_unlock(&nfsd_mutex);
> +
> +	if (err) {
> +		err =3D -EINVAL;
> +		goto err_free_msg;
> +	}
> +
> +	genlmsg_end(skb, hdr);
> +
> +	return genlmsg_reply(skb, info);
> +
> +err_free_msg:
> +	nlmsg_free(skb);
> +
> +	return err;
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_ne=
tlink.h
> index 3cd044edee5d..ccc78a5ee650 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -29,8 +29,19 @@ enum {
>  	NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
>  };
> =20
> +enum {
> +	NFSD_A_SERVER_WORKER_THREADS =3D 1,
> +	NFSD_A_SERVER_WORKER_GRACETIME,
> +	NFSD_A_SERVER_WORKER_LEASETIME,
> +
> +	__NFSD_A_SERVER_WORKER_MAX,
> +	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
> +};
> +
>  enum {
>  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> +	NFSD_CMD_THREADS_SET,
> +	NFSD_CMD_THREADS_GET,
> =20
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> --=20
> 2.44.0
>=20
>=20


