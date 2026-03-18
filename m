Return-Path: <linux-nfs+bounces-20253-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNs5NKG2umlWawIAu9opvQ
	(envelope-from <linux-nfs+bounces-20253-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:28:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9473D2BD219
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F663300669E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9CF37C10E;
	Wed, 18 Mar 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOEqSAAw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FCA244684;
	Wed, 18 Mar 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844094; cv=none; b=iliDMndfAxqNZv39HlqDEcm6sIweYHxsAfqW7heuqI3zxjBC6fPVPZqJjzcSjURp2YDmpe9x7z99ifxY1qNsAbwMty0zKwkvznobQUL9LBGZ19wMfYycbGJohpNNnpAFi8GGml6w3zUaFH1rUp0a1aEMjky4lxPusQcCD1Vgz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844094; c=relaxed/simple;
	bh=aTKC4Jhk8Ko/nHeKz0V0qGltwLNTV45d/6w2V+cp6Nw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gerDgvYLt2rZYp/6j0eLax7Y4RJ7ScFydKEGdw8T8OTZzDposN7TM1VPDGEP4nQUp4nMH4LQxPZuwtmXqCx7dRsPSFJ5HylCk8Vp5LMF5lFwZC5SjAdeft0B3KGq2KLRpiz9lblYouHaihSfkfVSUkCSqKyHZDK+9UYGaEED9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOEqSAAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BDCC19421;
	Wed, 18 Mar 2026 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844094;
	bh=aTKC4Jhk8Ko/nHeKz0V0qGltwLNTV45d/6w2V+cp6Nw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dOEqSAAwpSpocbEm4rnJCG+pELtdEchQ/l99Sta11ubTTVI2OJsRBht8eVYZwtzw7
	 zramtNOhsN2crHl+9AYBwMx/2U536iGayyvEpw3WT19O/scUrP1RfCcEVdjZCxxb5q
	 h4AwNsdqiyUWaA+b0Nqvs7wqq2ARbSwkS9bq4ryJ2a1ZTys6DBX2VVqL2etv0PEJ7d
	 UYAlGDcIk4j6ADMI57wGXgaAMruDh+xrfHgQVQ6RcqlkRosX+2ZqfdJYIGRFBMSQ2Z
	 +Uy46+XkcD8zTwPZXfw6RMP1oz99DqvNY1lkOsZpAfrk265jUoib0IH7/Jq6OT41oY
	 wTo9zsioG1/8Q==
Message-ID: <33d42b3de7a2c7cd61bdd01bae04a2e082755f95.camel@kernel.org>
Subject: Re: [PATCH v4 2/6] NFSD: Add NFSD_CMD_UNLOCK netlink command with
 ip scope
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Wed, 18 Mar 2026 10:28:10 -0400
In-Reply-To: <20260318-umount-kills-nfsv4-state-v4-2-56aad44ab982@oracle.com>
References: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
	 <20260318-umount-kills-nfsv4-state-v4-2-56aad44ab982@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20253-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9473D2BD219
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-18 at 10:15 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The existing write_unlock_ip procfs interface releases NLM file
> locks held by a specific client IP address, but procfs provides
> no structured way to extend that operation to other scopes such
> as revoking NFSv4 state. A netlink command allows the operation
> to carry typed, validated attributes and supports future scope
> values without interface proliferation.
>=20
> NFSD_CMD_UNLOCK accepts an unlock-type attribute selecting the
> scope and an address attribute carrying a binary sockaddr_in
> or sockaddr_in6. The handler validates the address family
> and length, then calls nlmsvc_unlock_all_by_ip() to release
> matching NLM locks. Because lockd is a single global instance,
> that call operates across all network namespaces regardless of
> which namespace the caller inhabits. The command requires admin
> privileges via GENL_ADMIN_PERM.
>=20
> The unlock-type enum begins with a single value, ip, and is
> defined with render-max so that future values can be added
> without breaking existing userspace.
>=20
> The nfsd_ctl_unlock_ip tracepoint is updated from string-based
> address logging to __sockaddr, which stores the binary sockaddr
> and formats it with %pISpc. This affects both the new netlink
> path and the existing procfs write_unlock_ip path, giving
> consistent structured output in both cases.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  Documentation/netlink/specs/nfsd.yaml | 32 ++++++++++++++++++
>  fs/nfsd/netlink.c                     | 13 ++++++++
>  fs/nfsd/netlink.h                     |  1 +
>  fs/nfsd/nfsctl.c                      | 63 +++++++++++++++++++++++++++++=
+++++-
>  fs/nfsd/trace.h                       | 13 ++++----
>  include/uapi/linux/nfsd_netlink.h     | 17 ++++++++++
>  6 files changed, 132 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlin=
k/specs/nfsd.yaml
> index f87b5a05e5e9..02fadfca22ba 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -6,6 +6,13 @@ uapi-header: linux/nfsd_netlink.h
> =20
>  doc: NFSD configuration over generic netlink.
> =20
> +definitions:
> +  -
> +    type: enum
> +    name: unlock-type
> +    render-max: true
> +    entries: [ip]
> +
>  attribute-sets:
>    -
>      name: rpc-status
> @@ -127,6 +134,21 @@ attribute-sets:
>        -
>          name: npools
>          type: u32
> +  -
> +    name: unlock
> +    attributes:
> +      -
> +        name: type
> +        type: u32
> +        enum: unlock-type
> +      -
> +        name: address
> +        type: binary
> +        doc: >-
> +          struct sockaddr_in or struct sockaddr_in6.
> +          Required when type is ip.
> +        checks:
> +          min-len: 16
> =20
>  operations:
>    list:
> @@ -227,3 +249,13 @@ operations:
>            attributes:
>              - mode
>              - npools
> +    -
> +      name: unlock
> +      doc: release NLM locks by scope
> +      attribute-set: unlock
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - type
> +            - address

I wonder if we'd be better served with different commands instead of
passing a type value to a single command? Different types are going to
require different attributes, and it'll be easier to validate those if
they use different commands.

> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 887525964451..9ec0d56eaa21 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -47,6 +47,12 @@ static const struct nla_policy nfsd_pool_mode_set_nl_p=
olicy[NFSD_A_POOL_MODE_MOD
>  	[NFSD_A_POOL_MODE_MODE] =3D { .type =3D NLA_NUL_STRING, },
>  };
> =20
> +/* NFSD_CMD_UNLOCK - do */
> +static const struct nla_policy nfsd_unlock_nl_policy[NFSD_A_UNLOCK_ADDRE=
SS + 1] =3D {
> +	[NFSD_A_UNLOCK_TYPE] =3D NLA_POLICY_MAX(NLA_U32, 0),
> +	[NFSD_A_UNLOCK_ADDRESS] =3D NLA_POLICY_MIN_LEN(16),
> +};
> +
>  /* Ops table for nfsd */
>  static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  	{
> @@ -102,6 +108,13 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D=
 {
>  		.doit	=3D nfsd_nl_pool_mode_get_doit,
>  		.flags	=3D GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		=3D NFSD_CMD_UNLOCK,
> +		.doit		=3D nfsd_nl_unlock_doit,
> +		.policy		=3D nfsd_unlock_nl_policy,
> +		.maxattr	=3D NFSD_A_UNLOCK_ADDRESS,
> +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>  };
> =20
>  struct genl_family nfsd_nl_family __ro_after_init =3D {
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index 478117ff6b8c..3ece774e5f52 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -26,6 +26,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, stru=
ct genl_info *info);
>  int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *inf=
o);
>  int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info *in=
fo);
>  int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *in=
fo);
> +int nfsd_nl_unlock_doit(struct sk_buff *skb, struct genl_info *info);
> =20
>  extern struct genl_family nfsd_nl_family;
> =20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 4cc8a58fa56a..858f3803c490 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -236,7 +236,7 @@ static ssize_t write_unlock_ip(struct file *file, cha=
r *buf, size_t size)
>  	if (rpc_pton(net, fo_path, size, sap, salen) =3D=3D 0)
>  		return -EINVAL;
> =20
> -	trace_nfsd_ctl_unlock_ip(net, buf);
> +	trace_nfsd_ctl_unlock_ip(net, sap, svc_addr_len(sap));
>  	return nlmsvc_unlock_all_by_ip(sap);
>  }
> =20
> @@ -2142,6 +2142,67 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb=
, struct genl_info *info)
>  	return err;
>  }
> =20
> +/**
> + * nfsd_nl_unlock_by_ip - release NLM locks held by an IP address
> + * @info: netlink metadata and command arguments
> + *
> + * Return: 0 on success or a negative errno.
> + */
> +static int nfsd_nl_unlock_by_ip(struct genl_info *info)
> +{
> +	struct sockaddr *sap;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_UNLOCK_ADDRESS))
> +		return -EINVAL;
> +	sap =3D nla_data(info->attrs[NFSD_A_UNLOCK_ADDRESS]);
> +	switch (sap->sa_family) {
> +	case AF_INET:
> +		if (nla_len(info->attrs[NFSD_A_UNLOCK_ADDRESS]) <
> +		    sizeof(struct sockaddr_in))
> +			return -EINVAL;
> +		break;
> +	case AF_INET6:
> +		if (nla_len(info->attrs[NFSD_A_UNLOCK_ADDRESS]) <
> +		    sizeof(struct sockaddr_in6))
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EAFNOSUPPORT;
> +	}
> +	/*
> +	 * nlmsvc_unlock_all_by_ip() releases matching locks
> +	 * across all network namespaces because lockd operates
> +	 * a single global instance.
> +	 */
> +	trace_nfsd_ctl_unlock_ip(genl_info_net(info), sap,
> +				 svc_addr_len(sap));
> +	return nlmsvc_unlock_all_by_ip(sap);
> +}
> +
> +/**
> + * nfsd_nl_unlock_doit - release NLM locks by scope
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return: 0 on success or a negative errno.
> + */
> +int nfsd_nl_unlock_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	u32 type;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_UNLOCK_TYPE))
> +		return -EINVAL;
> +
> +	type =3D nla_get_u32(info->attrs[NFSD_A_UNLOCK_TYPE]);
> +
> +	switch (type) {
> +	case NFSD_UNLOCK_TYPE_IP:
> +		return nfsd_nl_unlock_by_ip(info);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index d1d0b0dd0545..c770c5e6b1e7 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1984,19 +1984,20 @@ TRACE_EVENT(nfsd_cb_recall_any_done,
>  TRACE_EVENT(nfsd_ctl_unlock_ip,
>  	TP_PROTO(
>  		const struct net *net,
> -		const char *address
> +		const struct sockaddr *addr,
> +		const unsigned int addrlen
>  	),
> -	TP_ARGS(net, address),
> +	TP_ARGS(net, addr, addrlen),
>  	TP_STRUCT__entry(
>  		__field(unsigned int, netns_ino)
> -		__string(address, address)
> +		__sockaddr(addr, addrlen)
>  	),
>  	TP_fast_assign(
>  		__entry->netns_ino =3D net->ns.inum;
> -		__assign_str(address);
> +		__assign_sockaddr(addr, addr, addrlen);
>  	),
> -	TP_printk("address=3D%s",
> -		__get_str(address)
> +	TP_printk("addr=3D%pISpc",
> +		__get_sockaddr(addr)
>  	)
>  );
> =20
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_=
netlink.h
> index e9efbc9e63d8..8edd75590f31 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -10,6 +10,14 @@
>  #define NFSD_FAMILY_NAME	"nfsd"
>  #define NFSD_FAMILY_VERSION	1
> =20
> +enum nfsd_unlock_type {
> +	NFSD_UNLOCK_TYPE_IP,
> +
> +	/* private: */
> +	__NFSD_UNLOCK_TYPE_MAX,
> +	NFSD_UNLOCK_TYPE_MAX =3D (__NFSD_UNLOCK_TYPE_MAX - 1)
> +};
> +
>  enum {
>  	NFSD_A_RPC_STATUS_XID =3D 1,
>  	NFSD_A_RPC_STATUS_FLAGS,
> @@ -80,6 +88,14 @@ enum {
>  	NFSD_A_POOL_MODE_MAX =3D (__NFSD_A_POOL_MODE_MAX - 1)
>  };
> =20
> +enum {
> +	NFSD_A_UNLOCK_TYPE =3D 1,
> +	NFSD_A_UNLOCK_ADDRESS,
> +
> +	__NFSD_A_UNLOCK_MAX,
> +	NFSD_A_UNLOCK_MAX =3D (__NFSD_A_UNLOCK_MAX - 1)
> +};
> +
>  enum {
>  	NFSD_CMD_RPC_STATUS_GET =3D 1,
>  	NFSD_CMD_THREADS_SET,
> @@ -90,6 +106,7 @@ enum {
>  	NFSD_CMD_LISTENER_GET,
>  	NFSD_CMD_POOL_MODE_SET,
>  	NFSD_CMD_POOL_MODE_GET,
> +	NFSD_CMD_UNLOCK,
> =20
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)

--=20
Jeff Layton <jlayton@kernel.org>

