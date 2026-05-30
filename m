Return-Path: <linux-nfs+bounces-22112-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A0mKppRG2oEBAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22112-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:07:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DDA6136CA
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36CEF3032F7F
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 21:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB926ED3A;
	Sat, 30 May 2026 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIAd78vM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkaknEAX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A0B22A80D
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780175227; cv=none; b=co4PcZnG/RclH9BIR9Sbc5EJXNrUVBPX/D9BEW0r4G5bqFUSXm5DcFuTQ6EFRlXpZhPeQb65Tb81wVPvyRBC+vy8WNA5NoPs+DCJSXJFa3J8rHSW0tIocC1Zb/yJQmYT5NhV+CffM4OttPVF4xWBuRnX+CMPWythNz0LowTV6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780175227; c=relaxed/simple;
	bh=7fvAVKEyhSppQkdEIepBUNGKvxlOX5Mcr4s8d6vXm1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVeCemG2sWne9/ChnSU90P+aLtXRH+9C6wABFheoRyb90juJmbM0a9yBrBop3gflLQohcwJhKHV6XhJribcca39TnIGMoJ+S3uGpaRZZUtYuauNk7/nNZaFuiba04Zvpo881XI7fQ0el7YB+sGxbrq1BqXKZZPWQXaQ6BpXcrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIAd78vM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkaknEAX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780175225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXmhxpg00tkdtcgJWpXqYOT+smxyW1aaOn3gf7KGaog=;
	b=EIAd78vMW6Uo9dqI4jn8uKeRBVg4u/pTKCKnOFU5IuBpNIuR40tXkELVYpVzYZKZm+qwGm
	l5KBEc/NI1vEujA75A7OwvWf7yHRR6YyMtLbGO+YhuIGoDHqaGnpJ03IG1jqeAq/W+ip2m
	Lk/rWUkLMautZ28rBmcQ2WgMhJKtaD8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-VWBLanGnNdWTKx59vwuAdA-1; Sat, 30 May 2026 17:07:02 -0400
X-MC-Unique: VWBLanGnNdWTKx59vwuAdA-1
X-Mimecast-MFC-AGG-ID: VWBLanGnNdWTKx59vwuAdA_1780175222
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-914f037b7dfso998168585a.3
        for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780175222; x=1780780022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXmhxpg00tkdtcgJWpXqYOT+smxyW1aaOn3gf7KGaog=;
        b=FkaknEAXOX6/EwpmMBv7uaM0gUmAEQ57Ve4FzwtWu86KyecuibvLkFBOCdED342pUb
         pFC+u4i0s+KZRAdn8JbR0JEhVVpOr1pCHdj/z+QRBZM8Ay+B/Ocn+16Rj5o1ssmSQ7nY
         TbpPqRU3tYhLRteivAqddr/iHW7s6y/nT6IunFP0aBs5k8q0Ku8bDX4f3akFx5cy86gB
         QvyARZ8OeH3LBwgSHjxw4p8VlQ2ohXFRftaTLcacaCeLdPNeZ52EWtwbcNFBsgUqef7E
         JZB+XEaR9rQedjktwgfN2A732ONrzQlbcDpGSq5LaQhrVlXYV8isXKtoSL/eK0c+3xJN
         NylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780175222; x=1780780022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXmhxpg00tkdtcgJWpXqYOT+smxyW1aaOn3gf7KGaog=;
        b=GKQecTvYh/dUD7qu1HdioMA1k8EG3sFZedb/eCikCWYQ4JTvBpuTCwBsxHbhceuowc
         sD8m1cGaKTwgNNWx0kX8qppjpxk7yNVfGBThvqX9o4OCNk/9mVAbaHRpWxoCoBhlK8+U
         rDWwHBG6zGbyNCs8bXKFngYdP92gqXIlfRUhBPYf0uAgqsJmEpnEWqjmZi3HU1/Sn4NY
         6WbioTj+vYIztDNLA5nH4askgOEYCBeke2zhVRAdSYtzoqbonMZQMhx98EbBduYc04v6
         dBuUEaGuN2E3Rm9ZjcgGa0+sdxM5vGuRP/ndTqa6e+rtxEzaSTBHElmT89/jHhd+O8rG
         HnCw==
X-Forwarded-Encrypted: i=1; AFNElJ/B3JmNVp8qbRkRpSPuSGvaubLhpqgXnut/qCiyx9/HYoQp1PZNtYAO3YzZmVZMD6RB42LkHGp4Cwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHB653a/dPbuHoyzvIsh2XxuM2rVtUeP3ECci+LkQLeOfsDMhy
	3Im88GrsXOYZg6uGvNVnzDAJlVNCQp/7CAKoT+lG6P4QJ4kAIKFSCnAtrsbcA7EleReXnGEZ2Fd
	XoNk/BB/2dC9an0doJH8mta/G4YbR0PUbttVHqM2k51YeW09YNzsp8yv5IKGiWg==
X-Gm-Gg: Acq92OGIcJp/C33ixAAZOG83eiRsHqnh5mgb6EWANDloU3Qg2+Yk4w56jQZihtJhkzJ
	dXL3rV6/DaO9GDwwbYZW5iAtHXgbNJVQb+TiPgbUhGOQ4BU9TUgeLG79aaxHDARXW4zpuv0ZtY7
	LIPK9MABXA9XoH1cfgyxPhU24qRJywv7SGPoYybdcez+F08f/nF6jQxAQgkfgS6sx49yictrsih
	LGpvr+M3f7pxW/6EV3xzusx3eSoVzD1Paly/bSjjlEPvfFvlHJNdTLU3Wt2dDXPenDjpEP9gyru
	RZ4RlDhfdIt/6REGAaaVvE0vS0/XbX2jPSQlO9BK4xjtP4wvqi1nn2lxGPBCrhhPCFKOiN0BcyA
	lggunB8bTprUKOH7CxK5OTPoAGECz50TP
X-Received: by 2002:a05:620a:2309:10b0:914:afc1:c66d with SMTP id af79cd13be357-9153d93ae4amr631845185a.11.1780175221977;
        Sat, 30 May 2026 14:07:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2309:10b0:914:afc1:c66d with SMTP id af79cd13be357-9153d93ae4amr631841485a.11.1780175221442;
        Sat, 30 May 2026 14:07:01 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.241.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532650e85sm571028585a.42.2026.05.30.14.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 14:07:00 -0700 (PDT)
Message-ID: <75ca1106-966c-467c-8807-1cb051c4c372@redhat.com>
Date: Sat, 30 May 2026 17:06:58 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] nfsstat: add netlink support for fetching
 server statistics
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20260525-nfsstat-nl-v1-1-eca0764921ea@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260525-nfsstat-nl-v1-1-eca0764921ea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22112-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,makefile.in:url]
X-Rspamd-Queue-Id: 15DDA6136CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/26 8:45 AM, Jeff Layton wrote:
> Add Generic Netlink support to nfsstat for retrieving NFS server
> statistics, with automatic fallback to the existing /proc/net/rpc/nfsd
> parsing when netlink is unavailable (e.g., older kernels).
> 
> The new code sends NFSD_CMD_SERVER_STATS_GET as a dump command and
> parses the reply to populate the same stat arrays used by the proc
> path: reply cache (rc), filehandle (fh), IO, network, RPC, and
> per-version procedure call counts (proc2/3/4/proc4ops).
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Committed... (tag: nfs-utils-2-9-2-rc4)

steved
> ---
> This patch requires the corresponding kernel patches to add netlink
> support:
> 
> https://lore.kernel.org/linux-nfs/20260525-exportd-netlink-v2-0-40003fed450c@kernel.org/
> ---
>   support/include/nfsd_netlink.h |  86 ++++++++-----
>   utils/nfsstat/Makefile.am      |   4 +-
>   utils/nfsstat/nfsstat.c        | 282 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 341 insertions(+), 31 deletions(-)
> 
> diff --git a/support/include/nfsd_netlink.h b/support/include/nfsd_netlink.h
> index a6a831866be8..3d076d173b1d 100644
> --- a/support/include/nfsd_netlink.h
> +++ b/support/include/nfsd_netlink.h
> @@ -128,27 +128,6 @@ enum {
>   	NFSD_A_POOL_MODE_MAX = (__NFSD_A_POOL_MODE_MAX - 1)
>   };
>   
> -enum {
> -	NFSD_A_UNLOCK_IP_ADDRESS = 1,
> -
> -	__NFSD_A_UNLOCK_IP_MAX,
> -	NFSD_A_UNLOCK_IP_MAX = (__NFSD_A_UNLOCK_IP_MAX - 1)
> -};
> -
> -enum {
> -	NFSD_A_UNLOCK_FILESYSTEM_PATH = 1,
> -
> -	__NFSD_A_UNLOCK_FILESYSTEM_MAX,
> -	NFSD_A_UNLOCK_FILESYSTEM_MAX = (__NFSD_A_UNLOCK_FILESYSTEM_MAX - 1)
> -};
> -
> -enum {
> -	NFSD_A_UNLOCK_EXPORT_PATH = 1,
> -
> -	__NFSD_A_UNLOCK_EXPORT_MAX,
> -	NFSD_A_UNLOCK_EXPORT_MAX = (__NFSD_A_UNLOCK_EXPORT_MAX - 1)
> -};
> -
>   enum {
>   	NFSD_A_FSLOCATION_HOST = 1,
>   	NFSD_A_FSLOCATION_PATH,
> @@ -172,15 +151,6 @@ enum {
>   	NFSD_A_AUTH_FLAVOR_MAX = (__NFSD_A_AUTH_FLAVOR_MAX - 1)
>   };
>   
> -enum {
> -	NFSD_A_SVC_EXPORT_REQ_SEQNO = 1,
> -	NFSD_A_SVC_EXPORT_REQ_CLIENT,
> -	NFSD_A_SVC_EXPORT_REQ_PATH,
> -
> -	__NFSD_A_SVC_EXPORT_REQ_MAX,
> -	NFSD_A_SVC_EXPORT_REQ_MAX = (__NFSD_A_SVC_EXPORT_REQ_MAX - 1)
> -};
> -
>   enum {
>   	NFSD_A_SVC_EXPORT_SEQNO = 1,
>   	NFSD_A_SVC_EXPORT_CLIENT,
> @@ -234,6 +204,61 @@ enum {
>   	NFSD_A_CACHE_FLUSH_MAX = (__NFSD_A_CACHE_FLUSH_MAX - 1)
>   };
>   
> +enum {
> +	NFSD_A_UNLOCK_IP_ADDRESS = 1,
> +
> +	__NFSD_A_UNLOCK_IP_MAX,
> +	NFSD_A_UNLOCK_IP_MAX = (__NFSD_A_UNLOCK_IP_MAX - 1)
> +};
> +
> +enum {
> +	NFSD_A_UNLOCK_FILESYSTEM_PATH = 1,
> +
> +	__NFSD_A_UNLOCK_FILESYSTEM_MAX,
> +	NFSD_A_UNLOCK_FILESYSTEM_MAX = (__NFSD_A_UNLOCK_FILESYSTEM_MAX - 1)
> +};
> +
> +enum {
> +	NFSD_A_UNLOCK_EXPORT_PATH = 1,
> +
> +	__NFSD_A_UNLOCK_EXPORT_MAX,
> +	NFSD_A_UNLOCK_EXPORT_MAX = (__NFSD_A_UNLOCK_EXPORT_MAX - 1)
> +};
> +
> +enum {
> +	NFSD_A_SERVER_PROC_ENTRY_OP = 1,
> +	NFSD_A_SERVER_PROC_ENTRY_COUNT,
> +	NFSD_A_SERVER_PROC_ENTRY_PAD,
> +
> +	__NFSD_A_SERVER_PROC_ENTRY_MAX,
> +	NFSD_A_SERVER_PROC_ENTRY_MAX = (__NFSD_A_SERVER_PROC_ENTRY_MAX - 1)
> +};
> +
> +enum {
> +	NFSD_A_SERVER_STATS_RC_HITS = 1,
> +	NFSD_A_SERVER_STATS_RC_MISSES,
> +	NFSD_A_SERVER_STATS_RC_NOCACHE,
> +	NFSD_A_SERVER_STATS_PAD,
> +	NFSD_A_SERVER_STATS_FH_STALE,
> +	NFSD_A_SERVER_STATS_IO_READ,
> +	NFSD_A_SERVER_STATS_IO_WRITE,
> +	NFSD_A_SERVER_STATS_NETCNT,
> +	NFSD_A_SERVER_STATS_NETUDPCNT,
> +	NFSD_A_SERVER_STATS_NETTCPCNT,
> +	NFSD_A_SERVER_STATS_NETTCPCONN,
> +	NFSD_A_SERVER_STATS_RPCCNT,
> +	NFSD_A_SERVER_STATS_RPCBADFMT,
> +	NFSD_A_SERVER_STATS_RPCBADAUTH,
> +	NFSD_A_SERVER_STATS_RPCBADCLNT,
> +	NFSD_A_SERVER_STATS_PROC2_OPS,
> +	NFSD_A_SERVER_STATS_PROC3_OPS,
> +	NFSD_A_SERVER_STATS_PROC4_OPS,
> +	NFSD_A_SERVER_STATS_PROC4OPS_OPS,
> +
> +	__NFSD_A_SERVER_STATS_MAX,
> +	NFSD_A_SERVER_STATS_MAX = (__NFSD_A_SERVER_STATS_MAX - 1)
> +};
> +
>   enum {
>   	NFSD_CMD_RPC_STATUS_GET = 1,
>   	NFSD_CMD_THREADS_SET,
> @@ -253,6 +278,7 @@ enum {
>   	NFSD_CMD_UNLOCK_IP,
>   	NFSD_CMD_UNLOCK_FILESYSTEM,
>   	NFSD_CMD_UNLOCK_EXPORT,
> +	NFSD_CMD_SERVER_STATS_GET,
>   
>   	__NFSD_CMD_MAX,
>   	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
> diff --git a/utils/nfsstat/Makefile.am b/utils/nfsstat/Makefile.am
> index d1555a7d82d3..8b121c48c35c 100644
> --- a/utils/nfsstat/Makefile.am
> +++ b/utils/nfsstat/Makefile.am
> @@ -5,8 +5,10 @@ EXTRA_DIST	= $(man8_MANS)
>   
>   sbin_PROGRAMS	= nfsstat
>   nfsstat_SOURCES = nfsstat.c
> +nfsstat_CFLAGS = $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS)
>   nfsstat_LDADD = ../../support/export/libexport.a \
>   	      	../../support/nfs/libnfs.la \
> -		../../support/misc/libmisc.a
> +		../../support/misc/libmisc.a \
> +		$(LIBNL3_LIBS) $(LIBNLGENL3_LIBS)
>   
>   MAINTAINERCLEANFILES = Makefile.in
> diff --git a/utils/nfsstat/nfsstat.c b/utils/nfsstat/nfsstat.c
> index ca845325f0dc..f09e1d6a447f 100644
> --- a/utils/nfsstat/nfsstat.c
> +++ b/utils/nfsstat/nfsstat.c
> @@ -23,6 +23,17 @@
>   #include <signal.h>
>   #include <time.h>
>   
> +#include <netlink/genl/genl.h>
> +#include <netlink/genl/ctrl.h>
> +#include <netlink/msg.h>
> +#include <netlink/attr.h>
> +
> +#ifdef USE_SYSTEM_NFSD_NETLINK_H
> +#include <linux/nfsd_netlink.h>
> +#else
> +#include "nfsd_netlink.h"
> +#endif
> +
>   #define MAXNRVALS	32
>   
>   enum {
> @@ -271,6 +282,7 @@ static statinfo		*get_stat_info(const char *, struct statinfo *);
>   
>   static int		mounts(const char *);
>   
> +static int		get_stats_netlink(struct statinfo *);
>   static void		get_stats(const char *, struct statinfo *, int *, int,
>   					int);
>   static int		has_stats(const unsigned int *, int);
> @@ -1051,6 +1063,272 @@ mounts(const char *name)
>   	return 1;
>   }
>   
> +/*
> + * Netlink helpers for fetching server stats via Generic Netlink.
> + */
> +static int nl_error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
> +			    void *arg)
> +{
> +	int *ret = arg;
> +
> +	*ret = err->error;
> +	return NL_SKIP;
> +}
> +
> +static int nl_finish_handler(struct nl_msg *msg, void *arg)
> +{
> +	int *ret = arg;
> +
> +	*ret = 0;
> +	return NL_SKIP;
> +}
> +
> +static int nl_ack_handler(struct nl_msg *msg, void *arg)
> +{
> +	int *ret = arg;
> +
> +	*ret = 0;
> +	return NL_STOP;
> +}
> +
> +static void parse_one_proc_entry(struct nlattr *nest, unsigned int *info,
> +				 unsigned int max_ops)
> +{
> +	struct nlattr *tb[NFSD_A_SERVER_PROC_ENTRY_MAX + 1];
> +	unsigned int op, count;
> +
> +	nla_parse_nested(tb, NFSD_A_SERVER_PROC_ENTRY_MAX, nest, NULL);
> +	if (!tb[NFSD_A_SERVER_PROC_ENTRY_OP] ||
> +	    !tb[NFSD_A_SERVER_PROC_ENTRY_COUNT])
> +		return;
> +
> +	op = nla_get_u32(tb[NFSD_A_SERVER_PROC_ENTRY_OP]);
> +	count = (unsigned int)nla_get_u64(tb[NFSD_A_SERVER_PROC_ENTRY_COUNT]);
> +	if (op < max_ops) {
> +		info[0] = max_ops;
> +		info[op + 1] = count;
> +	}
> +}
> +
> +static int stats_nl_handler(struct nl_msg *msg, void *arg)
> +{
> +	struct statinfo *info = arg;
> +	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
> +	struct nlattr *attr;
> +	statinfo *si;
> +	int rem;
> +
> +	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
> +			  genlmsg_attrlen(gnlh, 0), rem) {
> +		int type = nla_type(attr);
> +
> +		switch (type) {
> +		/* Reply cache */
> +		case NFSD_A_SERVER_STATS_RC_HITS:
> +			si = get_stat_info("rc", info);
> +			if (si)
> +				si->valptr[0] = nla_get_u64(attr);
> +			break;
> +		case NFSD_A_SERVER_STATS_RC_MISSES:
> +			si = get_stat_info("rc", info);
> +			if (si)
> +				si->valptr[1] = nla_get_u64(attr);
> +			break;
> +		case NFSD_A_SERVER_STATS_RC_NOCACHE:
> +			si = get_stat_info("rc", info);
> +			if (si)
> +				si->valptr[2] = nla_get_u64(attr);
> +			break;
> +
> +		/* Filehandle */
> +		case NFSD_A_SERVER_STATS_FH_STALE:
> +			si = get_stat_info("fh", info);
> +			if (si)
> +				si->valptr[0] = nla_get_u64(attr);
> +			break;
> +
> +		/* IO */
> +		case NFSD_A_SERVER_STATS_IO_READ:
> +			si = get_stat_info("io", info);
> +			if (si)
> +				si->valptr[0] = nla_get_u64(attr);
> +			break;
> +		case NFSD_A_SERVER_STATS_IO_WRITE:
> +			si = get_stat_info("io", info);
> +			if (si)
> +				si->valptr[1] = nla_get_u64(attr);
> +			break;
> +
> +		/* Network */
> +		case NFSD_A_SERVER_STATS_NETCNT:
> +			si = get_stat_info("net", info);
> +			if (si)
> +				si->valptr[0] = nla_get_u32(attr);
> +			break;
> +		case NFSD_A_SERVER_STATS_NETUDPCNT:
> +			si = get_stat_info("net", info);
> +			if (si)
> +				si->valptr[1] = nla_get_u32(attr);
> +			break;
> +		case NFSD_A_SERVER_STATS_NETTCPCNT:
> +			si = get_stat_info("net", info);
> +			if (si)
> +				si->valptr[2] = nla_get_u32(attr);
> +			break;
> +		case NFSD_A_SERVER_STATS_NETTCPCONN:
> +			si = get_stat_info("net", info);
> +			if (si)
> +				si->valptr[3] = nla_get_u32(attr);
> +			break;
> +
> +		/* RPC */
> +		case NFSD_A_SERVER_STATS_RPCCNT:
> +			si = get_stat_info("rpc", info);
> +			if (si)
> +				si->valptr[0] = nla_get_u32(attr);
> +			break;
> +		case NFSD_A_SERVER_STATS_RPCBADFMT:
> +			si = get_stat_info("rpc", info);
> +			if (si)
> +				si->valptr[2] = nla_get_u32(attr);
> +			break;
> +		case NFSD_A_SERVER_STATS_RPCBADAUTH:
> +			si = get_stat_info("rpc", info);
> +			if (si)
> +				si->valptr[3] = nla_get_u32(attr);
> +			break;
> +		case NFSD_A_SERVER_STATS_RPCBADCLNT:
> +			si = get_stat_info("rpc", info);
> +			if (si)
> +				si->valptr[4] = nla_get_u32(attr);
> +			break;
> +
> +		/* Per-version procedure counts (multi-attr) */
> +		case NFSD_A_SERVER_STATS_PROC2_OPS:
> +			si = get_stat_info("proc2", info);
> +			if (si)
> +				parse_one_proc_entry(attr, si->valptr,
> +						     SRVPROC2_SZ);
> +			break;
> +		case NFSD_A_SERVER_STATS_PROC3_OPS:
> +			si = get_stat_info("proc3", info);
> +			if (si)
> +				parse_one_proc_entry(attr, si->valptr,
> +						     SRVPROC3_SZ);
> +			break;
> +		case NFSD_A_SERVER_STATS_PROC4_OPS:
> +			si = get_stat_info("proc4", info);
> +			if (si)
> +				parse_one_proc_entry(attr, si->valptr,
> +						     SRVPROC4_SZ);
> +			break;
> +		case NFSD_A_SERVER_STATS_PROC4OPS_OPS:
> +			si = get_stat_info("proc4ops", info);
> +			if (si)
> +				parse_one_proc_entry(attr, si->valptr,
> +						     SRVPROC4OPS_SZ);
> +			break;
> +		}
> +	}
> +
> +	return NL_OK;
> +}
> +
> +/*
> + * Fetch server stats via Generic Netlink.
> + * Returns 0 on success, -1 on failure.
> + */
> +static int
> +get_stats_netlink(struct statinfo *info)
> +{
> +	struct nl_sock *sock;
> +	struct nl_msg *msg;
> +	struct nl_cb *cb;
> +	int family, ret;
> +	statinfo *si;
> +
> +	sock = nl_socket_alloc();
> +	if (!sock)
> +		return -1;
> +
> +	if (genl_connect(sock)) {
> +		nl_socket_free(sock);
> +		return -1;
> +	}
> +
> +	family = genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
> +	if (family < 0) {
> +		nl_socket_free(sock);
> +		return -1;
> +	}
> +
> +	msg = nlmsg_alloc();
> +	if (!msg) {
> +		nl_socket_free(sock);
> +		return -1;
> +	}
> +
> +	if (!genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0,
> +			 NLM_F_DUMP, NFSD_CMD_SERVER_STATS_GET, 0)) {
> +		nlmsg_free(msg);
> +		nl_socket_free(sock);
> +		return -1;
> +	}
> +
> +	cb = nl_cb_alloc(NL_CB_CUSTOM);
> +	if (!cb) {
> +		nlmsg_free(msg);
> +		nl_socket_free(sock);
> +		return -1;
> +	}
> +
> +	ret = nl_send_auto(sock, msg);
> +	if (ret < 0) {
> +		nl_cb_put(cb);
> +		nlmsg_free(msg);
> +		nl_socket_free(sock);
> +		return -1;
> +	}
> +
> +	ret = 1;
> +	nl_cb_err(cb, NL_CB_CUSTOM, nl_error_handler, &ret);
> +	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, nl_finish_handler, &ret);
> +	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, nl_ack_handler, &ret);
> +	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, stats_nl_handler, info);
> +
> +	while (ret > 0)
> +		nl_recvmsgs(sock, cb);
> +
> +	nl_cb_put(cb);
> +	nlmsg_free(msg);
> +	nl_socket_free(sock);
> +
> +	if (ret < 0)
> +		return -1;
> +
> +	/*
> +	 * Compute derived fields. The proc file emits "rpc rpccnt
> +	 * badcalls badfmt badauth badclnt" where badcalls is the sum
> +	 * of badfmt+badauth+badclnt. The netlink interface sends the
> +	 * components individually, so recompute the sum here.
> +	 */
> +	si = get_stat_info("rpc", info);
> +	if (si)
> +		si->valptr[1] = si->valptr[2] + si->valptr[3] + si->valptr[4];
> +
> +	/* Compute totals for each stat category */
> +	for (si = info; si->tag; si++) {
> +		unsigned int total = 0;
> +		int i;
> +
> +		for (i = 0; i < si->nrvals - 1; i++)
> +			total += si->valptr[i];
> +		si->valptr[si->nrvals - 1] = total;
> +	}
> +
> +	return 0;
> +}
> +
>   static void
>   get_stats(const char *file, struct statinfo *info, int *opt, int other_opt,
>   		int is_srv)
> @@ -1060,6 +1338,10 @@ get_stats(const char *file, struct statinfo *info, int *opt, int other_opt,
>   	int err = 1;
>   	char *label = is_srv ? "Server" : "Client";
>   
> +	/* Try netlink first for server stats */
> +	if (is_srv && get_stats_netlink(info) == 0)
> +		return;
> +
>   	/* try to guess what type of stat file we're dealing with */
>   	if ((fp = fopen(file, "r")) == NULL)
>   		goto out;
> 
> ---
> base-commit: a806c9d65662ecf5d40c00d60a514e13ada8d76e
> change-id: 20260514-nfsstat-nl-16cabe1c80ae
> 
> Best regards,


