Return-Path: <linux-nfs+bounces-21052-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCCcHNNW6mkhxgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21052-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:28:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE99645580C
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF8D030CE50E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEFF3A7832;
	Thu, 23 Apr 2026 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dBdEpnye"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6F203710
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965055; cv=none; b=iQtigobYA0BemZO8xWL3JXpPSYDsyp9+5wrbh7SjEIfzpCig61mGJEhTUlQt4weJLeVxQzcA7Wo2BN49Lpeo1SYpDsXyVPhT1bArVJZucB6nEw9OsYfqJZWeJdrz+mAvLFHaSwxDbhJSa8+0dIgIyeFHZL1mAn01KjlPiuP+p1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965055; c=relaxed/simple;
	bh=McdL1OtcHv7F9QT7/RJclsPAk/F9PtjjbVrHdllkDX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSNojV4XBKj+4BhOorXKQRod/c9ouiwTvGEiIViduFFKWr4lgflWaPF/OIgD0vVy6ISJfzgUgcFwIBzlxqakB2o4ayY7v2xOVEYa4qsKAsAAN7bAw9oUpgrPai/enz972a/+l9OpQEDJcULWYvRC4TLOKrCHGSdgVwDCBt1nGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dBdEpnye; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4g1jcq0hTyz425x;
	Thu, 23 Apr 2026 19:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776965051;
	bh=McdL1OtcHv7F9QT7/RJclsPAk/F9PtjjbVrHdllkDX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dBdEpnyekTTuVO3C5Bk3Q7ZU5IfrwMHhj/Wbud9iFwbMNH1udGGof4RL19CFI4VjS
	 E/6gTLiE9Deed6Pa4R4yAaWbsNNOOeHzQxEoKDQJ+C2lwrkSDoBg6XztpP4QF+bd4P
	 I9jl+PmouzBWjgnHmQNq911KuWFpNdavlprD7z1J+JpkmpH31KMHHaZsll7AaZXdM5
	 rJvmzSbQcsyYU3QzpFElRODsz1vgTslcYUlrpgXq9u/oA2gGVhTRdsTrGAEou4U8+4
	 24qrFptzBwcto64nsUFYpy7mpw09tdHj0Xmog6tqPdHfHFwaYiPr/YcFAFdsFGz8Y9
	 Jmot2N1NX102A==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4g1jcp72vrz425M;
	Thu, 23 Apr 2026 19:24:10 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4g1jcp1Br1z8sZh;
	Thu, 23 Apr 2026 19:24:10 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 4ABD1632A9;
	Thu, 23 Apr 2026 19:24:09 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ffdac7ec-2a0c-48fe-915d-cb9e11b73d7a@leemhuis.info>
Date: Thu, 23 Apr 2026 19:24:08 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Put cache get-reqs dump attrs under reply
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260423171732.322623-1-cel@kernel.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260423171732.322623-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177696504968.1719095.3318528759228132384@mxe9fb.netcup.net>
X-NC-CID: SfH5Slwf4I4bQrpB1q2FQwN9ifTIthYyqT+DzdzBmcgcIaqovt8=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,leemhuis.info:email,leemhuis.info:dkim,leemhuis.info:mid];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	TAGGED_FROM(0.00)[bounces-21052-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@leemhuis.info,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DE99645580C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/26 19:17, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The new get-reqs dump operations added to sunrpc_cache.yaml and
> nfsd.yaml place the "requests" nested attribute under dump.request.
> A netlink dump carries an empty request; its payload travels back
> in the reply. Because the spec names no reply attributes, the YNL
> C code generator synthesizes a forward reference to a
> <op>_rsp struct that is never defined, breaking any consumer of
> these specs.
> 
> This first surfaced when Thorsten Leemhuis built tools/net/ynl
> against -next:

Thx for the quick fix, this makes things work. In case anybody cares:

Tested-by: Thorsten Leemhuis <linux@leemhuis.info>

Ciao, Thorsten

>   nfsd-user.h:746: error: field 'obj' has incomplete type
>     struct nfsd_svc_export_get_reqs_rsp obj ...
>   nfsd-user.h:826: error: field 'obj' has incomplete type
>     struct nfsd_expkey_get_reqs_rsp obj ...
>   nfsd-user.c:1211: error: 'nfsd_svc_export_get_reqs_rsp_parse'
>     undeclared
> 
> sunrpc_cache.yaml has the same defect in ip-map-get-reqs and
> unix-gid-get-reqs, but nfsd.yaml errors out first in the Makefile's
> alphabetical build order and hides the sunrpc failures.
> 
> These bugs were introduced by incorrect merge conflict resolution.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/linux-nfs/f6a3ca6d-e5cb-4a5c-9af2-8d2b1ce33ef0@leemhuis.info/
> Fixes: 1045ccf519ce30 ("sunrpc: add netlink upcall for the auth.unix.ip cache")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  Documentation/netlink/specs/nfsd.yaml         |  4 +--
>  Documentation/netlink/specs/sunrpc_cache.yaml |  4 +--
>  fs/nfsd/netlink.c                             | 26 +++++--------------
>  net/sunrpc/netlink.c                          | 26 +++++--------------
>  4 files changed, 16 insertions(+), 44 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
> index 17e714ef683d..8f36fadd68f7 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -445,7 +445,7 @@ operations:
>        attribute-set: svc-export-reqs
>        flags: [admin-perm]
>        dump:
> -          request:
> +          reply:
>              attributes:
>                - requests
>      -
> @@ -463,7 +463,7 @@ operations:
>        attribute-set: expkey-reqs
>        flags: [admin-perm]
>        dump:
> -          request:
> +          reply:
>              attributes:
>                - requests
>      -
> diff --git a/Documentation/netlink/specs/sunrpc_cache.yaml b/Documentation/netlink/specs/sunrpc_cache.yaml
> index 55dabc914dbc..f22ff22b9418 100644
> --- a/Documentation/netlink/specs/sunrpc_cache.yaml
> +++ b/Documentation/netlink/specs/sunrpc_cache.yaml
> @@ -101,7 +101,7 @@ operations:
>        attribute-set: ip-map-reqs
>        flags: [admin-perm]
>        dump:
> -          request:
> +          reply:
>              attributes:
>                - requests
>      -
> @@ -119,7 +119,7 @@ operations:
>        attribute-set: unix-gid-reqs
>        flags: [admin-perm]
>        dump:
> -          request:
> +          reply:
>              attributes:
>                - requests
>      -
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index df5b0e2fb286..fbee3676d253 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -88,21 +88,11 @@ static const struct nla_policy nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
>  	[NFSD_A_POOL_MODE_MODE] = { .type = NLA_NUL_STRING, },
>  };
>  
> -/* NFSD_CMD_SVC_EXPORT_GET_REQS - dump */
> -static const struct nla_policy nfsd_svc_export_get_reqs_nl_policy[NFSD_A_SVC_EXPORT_REQS_REQUESTS + 1] = {
> -	[NFSD_A_SVC_EXPORT_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_svc_export_nl_policy),
> -};
> -
>  /* NFSD_CMD_SVC_EXPORT_SET_REQS - do */
>  static const struct nla_policy nfsd_svc_export_set_reqs_nl_policy[NFSD_A_SVC_EXPORT_REQS_REQUESTS + 1] = {
>  	[NFSD_A_SVC_EXPORT_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_svc_export_nl_policy),
>  };
>  
> -/* NFSD_CMD_EXPKEY_GET_REQS - dump */
> -static const struct nla_policy nfsd_expkey_get_reqs_nl_policy[NFSD_A_EXPKEY_REQS_REQUESTS + 1] = {
> -	[NFSD_A_EXPKEY_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_expkey_nl_policy),
> -};
> -
>  /* NFSD_CMD_EXPKEY_SET_REQS - do */
>  static const struct nla_policy nfsd_expkey_set_reqs_nl_policy[NFSD_A_EXPKEY_REQS_REQUESTS + 1] = {
>  	[NFSD_A_EXPKEY_REQS_REQUESTS] = NLA_POLICY_NESTED(nfsd_expkey_nl_policy),
> @@ -184,11 +174,9 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>  		.flags	= GENL_CMD_CAP_DO,
>  	},
>  	{
> -		.cmd		= NFSD_CMD_SVC_EXPORT_GET_REQS,
> -		.dumpit		= nfsd_nl_svc_export_get_reqs_dumpit,
> -		.policy		= nfsd_svc_export_get_reqs_nl_policy,
> -		.maxattr	= NFSD_A_SVC_EXPORT_REQS_REQUESTS,
> -		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +		.cmd	= NFSD_CMD_SVC_EXPORT_GET_REQS,
> +		.dumpit	= nfsd_nl_svc_export_get_reqs_dumpit,
> +		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>  	},
>  	{
>  		.cmd		= NFSD_CMD_SVC_EXPORT_SET_REQS,
> @@ -198,11 +186,9 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{
> -		.cmd		= NFSD_CMD_EXPKEY_GET_REQS,
> -		.dumpit		= nfsd_nl_expkey_get_reqs_dumpit,
> -		.policy		= nfsd_expkey_get_reqs_nl_policy,
> -		.maxattr	= NFSD_A_EXPKEY_REQS_REQUESTS,
> -		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +		.cmd	= NFSD_CMD_EXPKEY_GET_REQS,
> +		.dumpit	= nfsd_nl_expkey_get_reqs_dumpit,
> +		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>  	},
>  	{
>  		.cmd		= NFSD_CMD_EXPKEY_SET_REQS,
> diff --git a/net/sunrpc/netlink.c b/net/sunrpc/netlink.c
> index 5ccf0967809c..ce09ecc0faa2 100644
> --- a/net/sunrpc/netlink.c
> +++ b/net/sunrpc/netlink.c
> @@ -29,21 +29,11 @@ const struct nla_policy sunrpc_unix_gid_nl_policy[SUNRPC_A_UNIX_GID_EXPIRY + 1]
>  	[SUNRPC_A_UNIX_GID_EXPIRY] = { .type = NLA_U64, },
>  };
>  
> -/* SUNRPC_CMD_IP_MAP_GET_REQS - dump */
> -static const struct nla_policy sunrpc_ip_map_get_reqs_nl_policy[SUNRPC_A_IP_MAP_REQS_REQUESTS + 1] = {
> -	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
> -};
> -
>  /* SUNRPC_CMD_IP_MAP_SET_REQS - do */
>  static const struct nla_policy sunrpc_ip_map_set_reqs_nl_policy[SUNRPC_A_IP_MAP_REQS_REQUESTS + 1] = {
>  	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
>  };
>  
> -/* SUNRPC_CMD_UNIX_GID_GET_REQS - dump */
> -static const struct nla_policy sunrpc_unix_gid_get_reqs_nl_policy[SUNRPC_A_UNIX_GID_REQS_REQUESTS + 1] = {
> -	[SUNRPC_A_UNIX_GID_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_unix_gid_nl_policy),
> -};
> -
>  /* SUNRPC_CMD_UNIX_GID_SET_REQS - do */
>  static const struct nla_policy sunrpc_unix_gid_set_reqs_nl_policy[SUNRPC_A_UNIX_GID_REQS_REQUESTS + 1] = {
>  	[SUNRPC_A_UNIX_GID_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_unix_gid_nl_policy),
> @@ -57,11 +47,9 @@ static const struct nla_policy sunrpc_cache_flush_nl_policy[SUNRPC_A_CACHE_FLUSH
>  /* Ops table for sunrpc */
>  static const struct genl_split_ops sunrpc_nl_ops[] = {
>  	{
> -		.cmd		= SUNRPC_CMD_IP_MAP_GET_REQS,
> -		.dumpit		= sunrpc_nl_ip_map_get_reqs_dumpit,
> -		.policy		= sunrpc_ip_map_get_reqs_nl_policy,
> -		.maxattr	= SUNRPC_A_IP_MAP_REQS_REQUESTS,
> -		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +		.cmd	= SUNRPC_CMD_IP_MAP_GET_REQS,
> +		.dumpit	= sunrpc_nl_ip_map_get_reqs_dumpit,
> +		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>  	},
>  	{
>  		.cmd		= SUNRPC_CMD_IP_MAP_SET_REQS,
> @@ -71,11 +59,9 @@ static const struct genl_split_ops sunrpc_nl_ops[] = {
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{
> -		.cmd		= SUNRPC_CMD_UNIX_GID_GET_REQS,
> -		.dumpit		= sunrpc_nl_unix_gid_get_reqs_dumpit,
> -		.policy		= sunrpc_unix_gid_get_reqs_nl_policy,
> -		.maxattr	= SUNRPC_A_UNIX_GID_REQS_REQUESTS,
> -		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +		.cmd	= SUNRPC_CMD_UNIX_GID_GET_REQS,
> +		.dumpit	= sunrpc_nl_unix_gid_get_reqs_dumpit,
> +		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>  	},
>  	{
>  		.cmd		= SUNRPC_CMD_UNIX_GID_SET_REQS,


