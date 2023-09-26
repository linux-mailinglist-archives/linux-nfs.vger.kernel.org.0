Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5057AF6E8
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 01:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjIZXqk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Sep 2023 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjIZXoj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Sep 2023 19:44:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11E1FC9;
        Tue, 26 Sep 2023 16:05:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D2D42186F;
        Tue, 26 Sep 2023 23:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695769517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rv0JPNzypuIuIzcfsltS27qjOQBSi12S+sCZLAto4ec=;
        b=JSQhaId6ST0XP7gHyJzk0uX5RpeLdDjkgox43/CnOBmJebaH7bO9CHKs2CdlG1Qu9u01SS
        bMhmaPWekxYZd6lpAy7GQNxuKW1bsKIqFXtYZT0ohGHRdObQn9Q2/sJgnRr+0tXYfF/p3q
        PNjWAQGh9TC1S1GdNxzfvHEvru+BQcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695769517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rv0JPNzypuIuIzcfsltS27qjOQBSi12S+sCZLAto4ec=;
        b=fD4xwlfU1a5IC3xjkU+7iB5fGEHK/9lcfSaE4Os6Glo94xnDCZCiSe1yb0Y7a8kx18pEHJ
        5CyB9QrHUkCNKcCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8076A1390B;
        Tue, 26 Sep 2023 23:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fuIRDapjE2UPWwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Sep 2023 23:05:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, chuck.lever@oracle.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
In-reply-to: <27646a34a3ddac3e0b0ad9b49aaf66b3cee5844f.1695766257.git.lorenzo@kernel.org>
References: <27646a34a3ddac3e0b0ad9b49aaf66b3cee5844f.1695766257.git.lorenzo@kernel.org>
Date:   Wed, 27 Sep 2023 09:05:10 +1000
Message-id: <169576951041.19404.9298873670065778737@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Hi,
 thanks for doing this.  I had a hunt through the patch largely to help
 improve my own understanding of netlink.  A few things stood out.  Not
 necessarily problems with the patch, but things that seemed worth
 mentioning.=20

 Firstly, and rather trivially, the word "convert" in the subject lead
 me to think that the old approach was being converted to a new
 approach.  I see that isn't correct - you are just introducing a new
 option.

On Wed, 27 Sep 2023, Lorenzo Bianconi wrote:
> Introduce write_threads, write_maxblksize and write_maxconn netlink
> commands similar to the ones available through the procfs.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v2:
> - use u32 to store nthreads in nfsd_nl_threads_set_doit
> - rename server-attr in control-plane in nfsd.yaml specs
> Changes since v1:
> - remove write_v4_end_grace command
> - add write_maxblksize and write_maxconn netlink commands
>=20
> This patch can be tested with user-space tool reported below:
> https://github.com/LorenzoBianconi/nfsd-netlink.git
> ---
>  Documentation/netlink/specs/nfsd.yaml |  63 ++++++++++++
>  fs/nfsd/netlink.c                     |  51 ++++++++++
>  fs/nfsd/netlink.h                     |   9 ++
>  fs/nfsd/nfsctl.c                      | 141 ++++++++++++++++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  15 +++
>  5 files changed, 279 insertions(+)
>=20
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/=
specs/nfsd.yaml
> index 403d3e3a04f3..c6af1653bc1d 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -62,6 +62,18 @@ attribute-sets:
>          name: compound-ops
>          type: u32
>          multi-attr: true
> +  -
> +    name: control-plane
> +    attributes:
> +      -
> +        name: threads
> +        type: u32
> +      -
> +        name: max-blksize
> +        type: u32
> +      -
> +        name: max-conn
> +        type: u32
> =20
>  operations:
>    list:
> @@ -72,3 +84,54 @@ operations:
>        dump:
>          pre: nfsd-nl-rpc-status-get-start
>          post: nfsd-nl-rpc-status-get-done
> +    -
> +      name: threads-set
> +      doc: set the number of running threads
> +      attribute-set: control-plane
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - threads
> +    -
> +      name: threads-get
> +      doc: dump the number of running threads
> +      attribute-set: control-plane
> +      dump:
> +        reply:
> +          attributes:
> +            - threads
> +    -
> +      name: max-blksize-set
> +      doc: set the nfs block size
> +      attribute-set: control-plane
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - max-blksize
> +    -
> +      name: max-blksize-get
> +      doc: dump the nfs block size
> +      attribute-set: control-plane
> +      dump:
> +        reply:
> +          attributes:
> +            - max-blksize
> +    -
> +      name: max-conn-set
> +      doc: set the max number of connections
> +      attribute-set: control-plane
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - max-conn
> +    -
> +      name: max-conn-get
> +      doc: dump the max number of connections
> +      attribute-set: control-plane
> +      dump:
> +        reply:
> +          attributes:
> +            - max-conn
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 0e1d635ec5f9..8f7d72ae60d6 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -10,6 +10,21 @@
> =20
>  #include <uapi/linux/nfsd_netlink.h>
> =20
> +/* NFSD_CMD_THREADS_SET - do */
> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_CONTROL_P=
LANE_THREADS + 1] =3D {
> +	[NFSD_A_CONTROL_PLANE_THREADS] =3D { .type =3D NLA_U32, },
> +};

This array, and the following arrays, is sized exactly large enough to
hold the last element.  In that case you don't need to explicitly set
the size:

 +static const struct nla_policy nfsd_threads_set_nl_policy[] =3D {
 +	[NFSD_A_CONTROL_PLANE_THREADS] =3D { .type =3D NLA_U32, },
 +};

I at first assumed you were following a standard practice, but other
places that declare nla_policy use a variety of different approaches.
I prefer the [] approach, but it is up to you.


> +
> +/* NFSD_CMD_MAX_BLKSIZE_SET - do */
> +static const struct nla_policy nfsd_max_blksize_set_nl_policy[NFSD_A_CONTR=
OL_PLANE_MAX_BLKSIZE + 1] =3D {
> +	[NFSD_A_CONTROL_PLANE_MAX_BLKSIZE] =3D { .type =3D NLA_U32, },
> +};
> +
> +/* NFSD_CMD_MAX_CONN_SET - do */
> +static const struct nla_policy nfsd_max_conn_set_nl_policy[NFSD_A_CONTROL_=
PLANE_MAX_CONN + 1] =3D {
> +	[NFSD_A_CONTROL_PLANE_MAX_CONN] =3D { .type =3D NLA_U32, },
> +};
> +
>  /* Ops table for nfsd */
>  static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  	{
> @@ -19,6 +34,42 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  		.done	=3D nfsd_nl_rpc_status_get_done,
>  		.flags	=3D GENL_CMD_CAP_DUMP,
>  	},
> +	{
> +		.cmd		=3D NFSD_CMD_THREADS_SET,
> +		.doit		=3D nfsd_nl_threads_set_doit,
> +		.policy		=3D nfsd_threads_set_nl_policy,
> +		.maxattr	=3D NFSD_A_CONTROL_PLANE_THREADS,

maxattr is *always* the largest index for the policy array.
I think it would aid reading to have something like

#define NLA_POLICY(_pol) .policy =3D _pol, .maxattr =3D ARRAY_SIZE(_pol) - 1
=20
then you could have
		.doit  =3D nfsd_nl_thread_set_doit,
		NLA_POLICY(nfsd_thread_set_nl_policy),

and be certain that all the maxattr values are correct.

> +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd	=3D NFSD_CMD_THREADS_GET,
> +		.dumpit	=3D nfsd_nl_threads_get_dumpit,
> +		.flags	=3D GENL_CMD_CAP_DUMP,
> +	},
> +	{
> +		.cmd		=3D NFSD_CMD_MAX_BLKSIZE_SET,
> +		.doit		=3D nfsd_nl_max_blksize_set_doit,
> +		.policy		=3D nfsd_max_blksize_set_nl_policy,
> +		.maxattr	=3D NFSD_A_CONTROL_PLANE_MAX_BLKSIZE,
> +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},

it is a little weird that the dumpit sections are indented differently
to the doit section.  But that is probably intentional and I might even
grow to like it...

> +	{
> +		.cmd	=3D NFSD_CMD_MAX_BLKSIZE_GET,
> +		.dumpit	=3D nfsd_nl_max_blksize_get_dumpit,
> +		.flags	=3D GENL_CMD_CAP_DUMP,
> +	},
> +	{
> +		.cmd		=3D NFSD_CMD_MAX_CONN_SET,
> +		.doit		=3D nfsd_nl_max_conn_set_doit,
> +		.policy		=3D nfsd_max_conn_set_nl_policy,
> +		.maxattr	=3D NFSD_A_CONTROL_PLANE_MAX_CONN,
> +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd	=3D NFSD_CMD_MAX_CONN_GET,
> +		.dumpit	=3D nfsd_nl_max_conn_get_dumpit,
> +		.flags	=3D GENL_CMD_CAP_DUMP,
> +	},
>  };
> =20
>  struct genl_family nfsd_nl_family __ro_after_init =3D {
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index d83dd6bdee92..41b95651c638 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -16,6 +16,15 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback =
*cb);
> =20
>  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  				  struct netlink_callback *cb);
> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
> +int nfsd_nl_threads_get_dumpit(struct sk_buff *skb,
> +			       struct netlink_callback *cb);
> +int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_info *in=
fo);
> +int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
> +				   struct netlink_callback *cb);
> +int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info *info);
> +int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
> +				struct netlink_callback *cb);
> =20
>  extern struct genl_family nfsd_nl_family;
> =20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index b71744e355a8..07e7a09e28e3 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1694,6 +1694,147 @@ int nfsd_nl_rpc_status_get_done(struct netlink_call=
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
> +	u32 nthreads;
> +	int ret;
> +
> +	if (!info->attrs[NFSD_A_CONTROL_PLANE_THREADS])
> +		return -EINVAL;
> +
> +	nthreads =3D nla_get_u32(info->attrs[NFSD_A_CONTROL_PLANE_THREADS]);
> +
> +	ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
> +	return ret =3D=3D nthreads ? 0 : ret;
> +}
> +
> +static int nfsd_nl_get_dump(struct sk_buff *skb, struct netlink_callback *=
cb,
> +			    int cmd, int attr, u32 val)
> +{
> +	void *hdr;
> +
> +	if (cb->args[0]) /* already consumed */
> +		return 0;
> +
> +	hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
> +			  &nfsd_nl_family, NLM_F_MULTI, cmd);
> +	if (!hdr)
> +		return -ENOBUFS;
> +
> +	if (nla_put_u32(skb, attr, val))
> +		return -ENOBUFS;
> +
> +	genlmsg_end(skb, hdr);
> +	cb->args[0] =3D 1;
> +
> +	return skb->len;
> +}
> +
> +/**
> + * nfsd_nl_threads_get_dumpit - dump the number of running threads
> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int nfsd_nl_threads_get_dumpit(struct sk_buff *skb, struct netlink_callbac=
k *cb)
> +{
> +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_THREADS_GET,
> +				NFSD_A_CONTROL_PLANE_THREADS,
> +				nfsd_nrthreads(sock_net(skb->sk)));
> +}
> +
> +/**
> + * nfsd_nl_max_blksize_set_doit - set the nfs block size
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_info *in=
fo)
> +{
> +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> +	struct nlattr *attr =3D info->attrs[NFSD_A_CONTROL_PLANE_MAX_BLKSIZE];
> +	int ret =3D 0;
> +
> +	if (!attr)
> +		return -EINVAL;
> +
> +	mutex_lock(&nfsd_mutex);
> +	if (nn->nfsd_serv) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}

This code is wrong... but then the original in write_maxblksize is wrong
to, so you can't be blamed.
nfsd_max_blksize applies to nfsd in ALL network namespaces.  So if we
need to check there are no active services in one namespace, we need to
check the same for *all* namespaces.

I think we should make nfsd_max_blksize a per-namespace value.

> +
> +	nfsd_max_blksize =3D nla_get_u32(attr);
> +	nfsd_max_blksize =3D max_t(int, nfsd_max_blksize, 1024);
> +	nfsd_max_blksize =3D min_t(int, nfsd_max_blksize, NFSSVC_MAXBLKSIZE);
> +	nfsd_max_blksize &=3D ~1023;
> +out:
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * nfsd_nl_max_blksize_get_dumpit - dump the nfs block size
> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
> +				   struct netlink_callback *cb)
> +{
> +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_BLKSIZE_GET,
> +				NFSD_A_CONTROL_PLANE_MAX_BLKSIZE,
> +				nfsd_max_blksize);
> +}
> +
> +/**
> + * nfsd_nl_max_conn_set_doit - set the max number of connections
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> +	struct nlattr *attr =3D info->attrs[NFSD_A_CONTROL_PLANE_MAX_CONN];
> +
> +	if (!attr)
> +		return -EINVAL;
> +
> +	nn->max_connections =3D nla_get_u32(attr);
> +
> +	return 0;
> +}
> +
> +/**
> + * nfsd_nl_max_conn_get_dumpit - dump the max number of connections
> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
> +				struct netlink_callback *cb)
> +{
> +	struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net_id);
> +
> +	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_CONN_GET,
> +				NFSD_A_CONTROL_PLANE_MAX_CONN,
> +				nn->max_connections);
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_ne=
tlink.h
> index c8ae72466ee6..145f4811f3d9 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -29,8 +29,23 @@ enum {
>  	NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
>  };
> =20
> +enum {
> +	NFSD_A_CONTROL_PLANE_THREADS =3D 1,
> +	NFSD_A_CONTROL_PLANE_MAX_BLKSIZE,
> +	NFSD_A_CONTROL_PLANE_MAX_CONN,
> +
> +	__NFSD_A_CONTROL_PLANE_MAX,
> +	NFSD_A_CONTROL_PLANE_MAX =3D (__NFSD_A_CONTROL_PLANE_MAX - 1)

This last value is never used.  Is it needed?


Thanks,
NeilBrown

> +};
> +
>  enum {
>  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> +	NFSD_CMD_THREADS_SET,
> +	NFSD_CMD_THREADS_GET,
> +	NFSD_CMD_MAX_BLKSIZE_SET,
> +	NFSD_CMD_MAX_BLKSIZE_GET,
> +	NFSD_CMD_MAX_CONN_SET,
> +	NFSD_CMD_MAX_CONN_GET,
> =20
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> --=20
> 2.41.0
>=20
>=20

