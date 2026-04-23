Return-Path: <linux-nfs+bounces-21046-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDvOOb5L6mkhxgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21046-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 18:41:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E50004550B6
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1EF93010779
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE92376BD3;
	Thu, 23 Apr 2026 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Yjju/fQT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E935B64F;
	Thu, 23 Apr 2026 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961289; cv=none; b=D7MS4r/cbbXIa4mXqt2tGC5dtZtCof/xediEAoGBNcO3qxvL3MEcEy+bhJt3vuoc3DaJmhrFf/Sk32GYqMGMSq3Ay6fCNE/fKcOXbS9uG4TtH5kc47SPEhTzTh9z0FJs55wWFE0iGEblZCh1pGq1MtKcmlZ0fKbZuZe6Bmi8/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961289; c=relaxed/simple;
	bh=BLqOFhWgjf2jP0w0EzQ9A+JTdMP3bsSAlb1CLUBGrvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNO7vun71UUTsSN2+D0dtj1Py4XP0cSOWs1ucUsDOEB3trkVjiMIKZGgmRz773johww/SUR6WtUJDhoWx+UpRSLwlcz5hqMXjsAG3+Bg75zbHy3l3Ju1ZwSX+a6jo5z35JnV1xtRB0MSp5kz0t1USBy+Xkgr9m7ijHOqjbuiNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Yjju/fQT; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4g1hDG174pz48H8;
	Thu, 23 Apr 2026 18:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776961278;
	bh=BLqOFhWgjf2jP0w0EzQ9A+JTdMP3bsSAlb1CLUBGrvs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yjju/fQTyB9B+4XoTWwmLkxm/kl0nL2ueWqlLQlN3KqTiNAKEa9DLLkS2OBQOYf+S
	 Fc9SG3U/qIBY6One1A68433/zcjfQyk+Am0Kf6k4yUXgjvl6z8oJS001iK8YQLkX8p
	 TIQfAe7s7UylfxGr+iDMAkkwRoJWQK1T9Yr3NTYdHC53czvIpdRON1lYGU7+NElZEU
	 IxUGnTy6i1S0vFUJVwfnG1cjymx3kpjxDfCrU805iqmtoOEdAMVdyg9BNS4D02cGBB
	 Bn2mdWWgOaG5zoTnI3piiV7gJcsG6wGjer1Bxnmmgk8nGMc4Mz+Dpqz9WX6cWt8rQ8
	 dWfEXCx4IDSfQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4g1hDG0PbCz7wN2;
	Thu, 23 Apr 2026 18:21:18 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4g1hDF0993z8svF;
	Thu, 23 Apr 2026 18:21:16 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D40946331C;
	Thu, 23 Apr 2026 18:21:15 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f6a3ca6d-e5cb-4a5c-9af2-8d2b1ce33ef0@leemhuis.info>
Date: Thu, 23 Apr 2026 18:21:14 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] sunrpc: add netlink upcall for the auth.unix.ip
 cache
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
 <20260325-exportd-netlink-v2-8-067df016ea95@kernel.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260325-exportd-netlink-v2-8-067df016ea95@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177696127662.1548488.17495906300519036311@mxe9fb.netcup.net>
X-NC-CID: czUzXMZBAMlVv3B0vwxaal4HNT3rkbjt+0AMZ4RUCT97Fs1hveA=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21046-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,leemhuis.info:dkim,leemhuis.info:mid,copr.fedorainfracloud.org:url];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@leemhuis.info,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E50004550B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 15:40, Jeff Layton wrote:
> Add netlink-based cache upcall support for the ip_map (auth.unix.ip)
> cache, using the sunrpc generic netlink family.
> 
> Add ip-map attribute-set (seqno, class, addr, domain, negative, expiry),
> ip-map-reqs wrapper, and ip-map-get-reqs / ip-map-set-reqs operations
> to the sunrpc_cache YAML spec and generated headers.
> 
> Implement sunrpc_nl_ip_map_get_reqs_dumpit() which snapshots pending
> ip_map cache requests and sends each entry's seqno, class name, and
> IP address over netlink.

This afaics showed up in -next today and seems to have broken compiling
tools/net/ynl for me:

"""
CC nl80211-user.o
	CC nlctrl-user.o
	CC ovpn-user.o
	CC ovs_datapath-user.o
In file included from nfsd-user.c:9:
nfsd-user.h:746:45: error: field ‘obj’ has incomplete type
  746 |         struct nfsd_svc_export_get_reqs_rsp obj
__attribute__((aligned(8)));
      |                                             ^~~
nfsd-user.h:826:41: error: field ‘obj’ has incomplete type
  826 |         struct nfsd_expkey_get_reqs_rsp obj
__attribute__((aligned(8)));
      |                                         ^~~
nfsd-user.c: In function ‘nfsd_svc_export_get_reqs_dump’:
nfsd-user.c:1181:18: error: ‘nfsd_svc_export_get_reqs_rsp_parse’
undeclared (first use in this function); did you mean
‘nfsd_svc_export_get_reqs_req_free’?
 1181 |         yds.cb = nfsd_svc_export_get_reqs_rsp_parse;
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                  nfsd_svc_export_get_reqs_req_free
nfsd-user.c:1181:18: note: each undeclared identifier is reported only
once for each function it appears in
nfsd-user.c:1195:19: error: returning ‘void *’ from a function with
return type ‘int’ makes integer from pointer without a cast
[-Wint-conversion]
 1195 |         return yds.first;
      |                ~~~^~~~~~
nfsd-user.c:1199:16: error: returning ‘void *’ from a function with
return type ‘int’ makes integer from pointer without a cast
[-Wint-conversion]
 1199 |         return NULL;
      |                ^~~~
nfsd-user.c: In function ‘nfsd_expkey_get_reqs_dump’:
nfsd-user.c:1273:18: error: ‘nfsd_expkey_get_reqs_rsp_parse’ undeclared
(first use in this function); did you mean ‘nfsd_expkey_get_reqs_req_free’?
 1273 |         yds.cb = nfsd_expkey_get_reqs_rsp_parse;
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                  nfsd_expkey_get_reqs_req_free
	CC ovs_vport-user.o
	CC ovs_flow-user.o
nfsd-user.c:1287:19: error: returning ‘void *’ from a function with
return type ‘int’ makes integer from pointer without a cast
[-Wint-conversion]
 1287 |         return yds.first;
      |                ~~~^~~~~~
nfsd-user.c:1291:16: error: returning ‘void *’ from a function with
return type ‘int’ makes integer from pointer without a cast
[-Wint-conversion]
 1291 |         return NULL;
      |                ^~~~
	CC psp-user.o
make[1]: *** [Makefile:52: nfsd-user.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:28: generated] Error 2
"""
Full log:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-x86_64/10360309-next-next-all/builder-live.log.gz
(similar errors for aarch64 and ppc64)

Reverting the following changes made things compile again for me:

257dc1227d07be ("nfsd: add NFSD_CMD_CACHE_FLUSH netlink command")
22f99c05b145e7 ("sunrpc: add SUNRPC_CMD_CACHE_FLUSH netlink command")
97fa24739b5566 ("nfsd: add netlink upcall for the nfsd.fh cache")
dd8015e766e639 ("nfsd: add netlink upcall for the svc_export cache")
d1b8115657acdf ("sunrpc: add netlink upcall for the auth.unix.gid cache")
1045ccf519ce30 ("sunrpc: add netlink upcall for the auth.unix.ip cache")

I reverted all patches that modified Documentation/netlink/specs/ in
reverse order, so maybe all except the last one in the list above are fine.

Ciao, Thorsten

> Implement sunrpc_nl_ip_map_set_reqs_doit() which parses ip_map cache
> responses from userspace (class, addr, expiry, and domain name or
> negative flag) and updates the cache via __ip_map_lookup() /
> __ip_map_update().
> 
> Wire up ip_map_notify() callback in ip_map_cache_template so cache
> misses trigger SUNRPC_CMD_CACHE_NOTIFY multicast events with
> SUNRPC_CACHE_TYPE_IP_MAP.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/netlink/specs/sunrpc_cache.yaml |  47 +++++
>  include/uapi/linux/sunrpc_netlink.h           |  21 +++
>  net/sunrpc/netlink.c                          |  34 ++++
>  net/sunrpc/netlink.h                          |   8 +
>  net/sunrpc/svcauth_unix.c                     | 246 ++++++++++++++++++++++++++
>  5 files changed, 356 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/sunrpc_cache.yaml b/Documentation/netlink/specs/sunrpc_cache.yaml
> index f4aa699598bca9ce0215bbc418d9ddcae25c0110..8bcd43f65f3258ba43df4f80a7cfda5f09f2f13e 100644
> --- a/Documentation/netlink/specs/sunrpc_cache.yaml
> +++ b/Documentation/netlink/specs/sunrpc_cache.yaml
> @@ -20,6 +20,35 @@ attribute-sets:
>          name: cache-type
>          type: u32
>          enum: cache-type
> +  -
> +    name: ip-map
> +    attributes:
> +      -
> +        name: seqno
> +        type: u64
> +      -
> +        name: class
> +        type: string
> +      -
> +        name: addr
> +        type: string
> +      -
> +        name: domain
> +        type: string
> +      -
> +        name: negative
> +        type: flag
> +      -
> +        name: expiry
> +        type: u64
> +  -
> +    name: ip-map-reqs
> +    attributes:
> +      -
> +        name: requests
> +        type: nest
> +        nested-attributes: ip-map
> +        multi-attr: true
>  
>  operations:
>    list:
> @@ -31,6 +60,24 @@ operations:
>        event:
>          attributes:
>            - cache-type
> +    -
> +      name: ip-map-get-reqs
> +      doc: Dump all pending ip_map requests
> +      attribute-set: ip-map-reqs
> +      flags: [admin-perm]
> +      dump:
> +          request:
> +            attributes:
> +              - requests
> +    -
> +      name: ip-map-set-reqs
> +      doc: Respond to one or more ip_map requests
> +      attribute-set: ip-map-reqs
> +      flags: [admin-perm]
> +      do:
> +          request:
> +            attributes:
> +              - requests
>  
>  mcast-groups:
>    list:
> diff --git a/include/uapi/linux/sunrpc_netlink.h b/include/uapi/linux/sunrpc_netlink.h
> index 6135d9b3eef155a9192d9710c8c690283ec49073..b44befb5a34b956e70065e0e12b816e2943da66e 100644
> --- a/include/uapi/linux/sunrpc_netlink.h
> +++ b/include/uapi/linux/sunrpc_netlink.h
> @@ -22,8 +22,29 @@ enum {
>  	SUNRPC_A_CACHE_NOTIFY_MAX = (__SUNRPC_A_CACHE_NOTIFY_MAX - 1)
>  };
>  
> +enum {
> +	SUNRPC_A_IP_MAP_SEQNO = 1,
> +	SUNRPC_A_IP_MAP_CLASS,
> +	SUNRPC_A_IP_MAP_ADDR,
> +	SUNRPC_A_IP_MAP_DOMAIN,
> +	SUNRPC_A_IP_MAP_NEGATIVE,
> +	SUNRPC_A_IP_MAP_EXPIRY,
> +
> +	__SUNRPC_A_IP_MAP_MAX,
> +	SUNRPC_A_IP_MAP_MAX = (__SUNRPC_A_IP_MAP_MAX - 1)
> +};
> +
> +enum {
> +	SUNRPC_A_IP_MAP_REQS_REQUESTS = 1,
> +
> +	__SUNRPC_A_IP_MAP_REQS_MAX,
> +	SUNRPC_A_IP_MAP_REQS_MAX = (__SUNRPC_A_IP_MAP_REQS_MAX - 1)
> +};
> +
>  enum {
>  	SUNRPC_CMD_CACHE_NOTIFY = 1,
> +	SUNRPC_CMD_IP_MAP_GET_REQS,
> +	SUNRPC_CMD_IP_MAP_SET_REQS,
>  
>  	__SUNRPC_CMD_MAX,
>  	SUNRPC_CMD_MAX = (__SUNRPC_CMD_MAX - 1)
> diff --git a/net/sunrpc/netlink.c b/net/sunrpc/netlink.c
> index 952de6de85e3f647ef9bc9c1e99651a247649abb..f57eb17fc27dfb958bcb29a171ea6b88834042e3 100644
> --- a/net/sunrpc/netlink.c
> +++ b/net/sunrpc/netlink.c
> @@ -12,8 +12,42 @@
>  
>  #include <uapi/linux/sunrpc_netlink.h>
>  
> +/* Common nested types */
> +const struct nla_policy sunrpc_ip_map_nl_policy[SUNRPC_A_IP_MAP_EXPIRY + 1] = {
> +	[SUNRPC_A_IP_MAP_SEQNO] = { .type = NLA_U64, },
> +	[SUNRPC_A_IP_MAP_CLASS] = { .type = NLA_NUL_STRING, },
> +	[SUNRPC_A_IP_MAP_ADDR] = { .type = NLA_NUL_STRING, },
> +	[SUNRPC_A_IP_MAP_DOMAIN] = { .type = NLA_NUL_STRING, },
> +	[SUNRPC_A_IP_MAP_NEGATIVE] = { .type = NLA_FLAG, },
> +	[SUNRPC_A_IP_MAP_EXPIRY] = { .type = NLA_U64, },
> +};
> +
> +/* SUNRPC_CMD_IP_MAP_GET_REQS - dump */
> +static const struct nla_policy sunrpc_ip_map_get_reqs_nl_policy[SUNRPC_A_IP_MAP_REQS_REQUESTS + 1] = {
> +	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
> +};
> +
> +/* SUNRPC_CMD_IP_MAP_SET_REQS - do */
> +static const struct nla_policy sunrpc_ip_map_set_reqs_nl_policy[SUNRPC_A_IP_MAP_REQS_REQUESTS + 1] = {
> +	[SUNRPC_A_IP_MAP_REQS_REQUESTS] = NLA_POLICY_NESTED(sunrpc_ip_map_nl_policy),
> +};
> +
>  /* Ops table for sunrpc */
>  static const struct genl_split_ops sunrpc_nl_ops[] = {
> +	{
> +		.cmd		= SUNRPC_CMD_IP_MAP_GET_REQS,
> +		.dumpit		= sunrpc_nl_ip_map_get_reqs_dumpit,
> +		.policy		= sunrpc_ip_map_get_reqs_nl_policy,
> +		.maxattr	= SUNRPC_A_IP_MAP_REQS_REQUESTS,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +	},
> +	{
> +		.cmd		= SUNRPC_CMD_IP_MAP_SET_REQS,
> +		.doit		= sunrpc_nl_ip_map_set_reqs_doit,
> +		.policy		= sunrpc_ip_map_set_reqs_nl_policy,
> +		.maxattr	= SUNRPC_A_IP_MAP_REQS_REQUESTS,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>  };
>  
>  static const struct genl_multicast_group sunrpc_nl_mcgrps[] = {
> diff --git a/net/sunrpc/netlink.h b/net/sunrpc/netlink.h
> index 74cf5183d745d778174abbbfed9514c4b6693e30..68b773960b3972536a9aa77861ce332721f2819e 100644
> --- a/net/sunrpc/netlink.h
> +++ b/net/sunrpc/netlink.h
> @@ -12,6 +12,14 @@
>  
>  #include <uapi/linux/sunrpc_netlink.h>
>  
> +/* Common nested types */
> +extern const struct nla_policy sunrpc_ip_map_nl_policy[SUNRPC_A_IP_MAP_EXPIRY + 1];
> +
> +int sunrpc_nl_ip_map_get_reqs_dumpit(struct sk_buff *skb,
> +				     struct netlink_callback *cb);
> +int sunrpc_nl_ip_map_set_reqs_doit(struct sk_buff *skb,
> +				   struct genl_info *info);
> +
>  enum {
>  	SUNRPC_NLGRP_NONE,
>  	SUNRPC_NLGRP_EXPORTD,
> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> index 87732c4cb8383c64b440538a0d3f3113a3009b4e..b09b911c532a46bc629b720e71d5c6113d158b1a 100644
> --- a/net/sunrpc/svcauth_unix.c
> +++ b/net/sunrpc/svcauth_unix.c
> @@ -17,11 +17,14 @@
>  #include <net/ipv6.h>
>  #include <linux/kernel.h>
>  #include <linux/user_namespace.h>
> +#include <net/genetlink.h>
> +#include <uapi/linux/sunrpc_netlink.h>
>  #include <trace/events/sunrpc.h>
>  
>  #define RPCDBG_FACILITY	RPCDBG_AUTH
>  
>  #include "netns.h"
> +#include "netlink.h"
>  
>  /*
>   * AUTHUNIX and AUTHNULL credentials are both handled here.
> @@ -1017,12 +1020,255 @@ struct auth_ops svcauth_unix = {
>  	.set_client	= svcauth_unix_set_client,
>  };
>  
> +static int ip_map_notify(struct cache_detail *cd, struct cache_head *h)
> +{
> +	return sunrpc_cache_notify(cd, h, SUNRPC_CACHE_TYPE_IP_MAP);
> +}
> +
> +/**
> + * sunrpc_nl_ip_map_get_reqs_dumpit - dump pending ip_map requests
> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * Walk the ip_map cache's pending request list and create a netlink
> + * message with a nested entry for each cache_request, containing the
> + * seqno, class and addr.
> + *
> + * Uses cb->args[0] as a seqno cursor for dump continuation across
> + * multiple netlink messages.
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int sunrpc_nl_ip_map_get_reqs_dumpit(struct sk_buff *skb,
> +				     struct netlink_callback *cb)
> +{
> +	struct sunrpc_net *sn;
> +	struct cache_detail *cd;
> +	struct cache_head **items;
> +	u64 *seqnos;
> +	int cnt, i, emitted;
> +	void *hdr;
> +	int ret;
> +
> +	sn = net_generic(sock_net(skb->sk), sunrpc_net_id);
> +
> +	cd = sn->ip_map_cache;
> +	if (!cd)
> +		return -ENODEV;
> +
> +	cnt = sunrpc_cache_requests_count(cd);
> +	if (!cnt)
> +		return 0;
> +
> +	items = kcalloc(cnt, sizeof(*items), GFP_KERNEL);
> +	seqnos = kcalloc(cnt, sizeof(*seqnos), GFP_KERNEL);
> +	if (!items || !seqnos) {
> +		ret = -ENOMEM;
> +		goto out_alloc;
> +	}
> +
> +	cnt = sunrpc_cache_requests_snapshot(cd, items, seqnos, cnt,
> +					     cb->args[0]);
> +	if (!cnt) {
> +		ret = 0;
> +		goto out_alloc;
> +	}
> +
> +	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> +			  cb->nlh->nlmsg_seq, &sunrpc_nl_family,
> +			  NLM_F_MULTI, SUNRPC_CMD_IP_MAP_GET_REQS);
> +	if (!hdr) {
> +		ret = -ENOBUFS;
> +		goto out_put;
> +	}
> +
> +	emitted = 0;
> +	for (i = 0; i < cnt; i++) {
> +		struct ip_map *im;
> +		struct nlattr *nest;
> +		char text_addr[40];
> +
> +		im = container_of(items[i], struct ip_map, h);
> +
> +		if (ipv6_addr_v4mapped(&im->m_addr))
> +			snprintf(text_addr, 20, "%pI4",
> +				 &im->m_addr.s6_addr32[3]);
> +		else
> +			snprintf(text_addr, 40, "%pI6", &im->m_addr);
> +
> +		nest = nla_nest_start(skb, SUNRPC_A_IP_MAP_REQS_REQUESTS);
> +		if (!nest)
> +			break;
> +
> +		if (nla_put_u64_64bit(skb, SUNRPC_A_IP_MAP_SEQNO,
> +				      seqnos[i], 0) ||
> +		    nla_put_string(skb, SUNRPC_A_IP_MAP_CLASS,
> +				   im->m_class) ||
> +		    nla_put_string(skb, SUNRPC_A_IP_MAP_ADDR, text_addr)) {
> +			nla_nest_cancel(skb, nest);
> +			break;
> +		}
> +
> +		nla_nest_end(skb, nest);
> +		cb->args[0] = seqnos[i];
> +		emitted++;
> +	}
> +
> +	if (!emitted) {
> +		genlmsg_cancel(skb, hdr);
> +		ret = -EMSGSIZE;
> +		goto out_put;
> +	}
> +
> +	genlmsg_end(skb, hdr);
> +	ret = skb->len;
> +out_put:
> +	for (i = 0; i < cnt; i++)
> +		cache_put(items[i], cd);
> +out_alloc:
> +	kfree(seqnos);
> +	kfree(items);
> +	return ret;
> +}
> +
> +/**
> + * sunrpc_nl_parse_one_ip_map - parse one ip_map entry from netlink
> + * @cd: cache_detail for the ip_map cache
> + * @attr: nested attribute containing ip_map fields
> + *
> + * Parses one ip_map entry from a netlink message and updates the
> + * cache. Mirrors the logic in ip_map_parse().
> + *
> + * Returns 0 on success or a negative errno.
> + */
> +static int sunrpc_nl_parse_one_ip_map(struct cache_detail *cd,
> +				      struct nlattr *attr)
> +{
> +	struct nlattr *tb[SUNRPC_A_IP_MAP_EXPIRY + 1];
> +	union {
> +		struct sockaddr		sa;
> +		struct sockaddr_in	s4;
> +		struct sockaddr_in6	s6;
> +	} address;
> +	struct sockaddr_in6 sin6;
> +	struct ip_map *ipmp;
> +	struct auth_domain *dom = NULL;
> +	struct unix_domain *udom = NULL;
> +	struct timespec64 boot;
> +	time64_t expiry;
> +	char class[8];
> +	int err;
> +	int len;
> +
> +	err = nla_parse_nested(tb, SUNRPC_A_IP_MAP_EXPIRY, attr,
> +			       sunrpc_ip_map_nl_policy, NULL);
> +	if (err)
> +		return err;
> +
> +	/* class (required) */
> +	if (!tb[SUNRPC_A_IP_MAP_CLASS])
> +		return -EINVAL;
> +	len = nla_len(tb[SUNRPC_A_IP_MAP_CLASS]);
> +	if (len <= 0 || len > sizeof(class))
> +		return -EINVAL;
> +	nla_strscpy(class, tb[SUNRPC_A_IP_MAP_CLASS], sizeof(class));
> +
> +	/* addr (required) */
> +	if (!tb[SUNRPC_A_IP_MAP_ADDR])
> +		return -EINVAL;
> +	if (rpc_pton(cd->net, nla_data(tb[SUNRPC_A_IP_MAP_ADDR]),
> +		     nla_len(tb[SUNRPC_A_IP_MAP_ADDR]) - 1,
> +		     &address.sa, sizeof(address)) == 0)
> +		return -EINVAL;
> +
> +	switch (address.sa.sa_family) {
> +	case AF_INET:
> +		sin6.sin6_family = AF_INET6;
> +		ipv6_addr_set_v4mapped(address.s4.sin_addr.s_addr,
> +				       &sin6.sin6_addr);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		memcpy(&sin6, &address.s6, sizeof(sin6));
> +		break;
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* expiry (required, wallclock seconds) */
> +	if (!tb[SUNRPC_A_IP_MAP_EXPIRY])
> +		return -EINVAL;
> +	getboottime64(&boot);
> +	expiry = nla_get_u64(tb[SUNRPC_A_IP_MAP_EXPIRY]) - boot.tv_sec;
> +
> +	/* domain name or negative */
> +	if (tb[SUNRPC_A_IP_MAP_NEGATIVE]) {
> +		udom = NULL;
> +	} else if (tb[SUNRPC_A_IP_MAP_DOMAIN]) {
> +		dom = unix_domain_find(nla_data(tb[SUNRPC_A_IP_MAP_DOMAIN]));
> +		if (!dom)
> +			return -ENOENT;
> +		udom = container_of(dom, struct unix_domain, h);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	ipmp = __ip_map_lookup(cd, class, &sin6.sin6_addr);
> +	if (ipmp)
> +		err = __ip_map_update(cd, ipmp, udom, expiry);
> +	else
> +		err = -ENOMEM;
> +
> +	if (dom)
> +		auth_domain_put(dom);
> +
> +	cache_flush();
> +	return err;
> +}
> +
> +/**
> + * sunrpc_nl_ip_map_set_reqs_doit - respond to ip_map requests
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Parse one or more ip_map cache responses from userspace and
> + * update the ip_map cache accordingly.
> + *
> + * Returns 0 on success or a negative errno.
> + */
> +int sunrpc_nl_ip_map_set_reqs_doit(struct sk_buff *skb,
> +				   struct genl_info *info)
> +{
> +	struct sunrpc_net *sn;
> +	struct cache_detail *cd;
> +	const struct nlattr *attr;
> +	int rem, ret = 0;
> +
> +	sn = net_generic(genl_info_net(info), sunrpc_net_id);
> +
> +	cd = sn->ip_map_cache;
> +	if (!cd)
> +		return -ENODEV;
> +
> +	nlmsg_for_each_attr_type(attr, SUNRPC_A_IP_MAP_REQS_REQUESTS,
> +				 info->nlhdr, GENL_HDRLEN, rem) {
> +		ret = sunrpc_nl_parse_one_ip_map(cd,
> +						 (struct nlattr *)attr);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct cache_detail ip_map_cache_template = {
>  	.owner		= THIS_MODULE,
>  	.hash_size	= IP_HASHMAX,
>  	.name		= "auth.unix.ip",
>  	.cache_put	= ip_map_put,
>  	.cache_upcall	= ip_map_upcall,
> +	.cache_notify	= ip_map_notify,
>  	.cache_request	= ip_map_request,
>  	.cache_parse	= ip_map_parse,
>  	.cache_show	= ip_map_show,
> 


