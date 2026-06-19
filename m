Return-Path: <linux-nfs+bounces-22682-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y9TYGsWJNGriagYAu9opvQ
	(envelope-from <linux-nfs+bounces-22682-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 02:13:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D49C26A32BB
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 02:13:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QlNVtxOd;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22682-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22682-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57E963062A5A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 00:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12A40D582;
	Fri, 19 Jun 2026 00:12:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C710F0
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 00:12:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827978; cv=none; b=UXpcjYofOp8ugo5cdu4Q+GsmDoUnWVhd/ndPlBHkgVMAVu3onkcfjTxkVpbmIRgd1pbj0eb0wCYT9hQzabp3jAdN5iz+LyPch+UFiiMH98an4Ko6acvpe0DSSCbjpE9V9sZlf0MZxSiPA2kzZnE8u1ZRznnm/qiYkbj8Ti/qNUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827978; c=relaxed/simple;
	bh=UotpaL3rRvmTQDJCZfdeyvmtOAzaEV5m7folSrafRhk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DcUr9d2AZfPwQXZK2h55ESCwmXYNApeeBalYIDZK9KNPEuRQEuIH/rOOLrpebWH/h4HAl5ZqdL86gl7VFZTKeIOE0wyfC2d4hYl2kj5J5WJ7ZYYKghvL3/ZhaSHxifY/TsSXjIPH1DOXdH2DRq4HOcEU0JDgkrjkUa2TC7L4PyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlNVtxOd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE74F1F00A3A;
	Fri, 19 Jun 2026 00:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781827977;
	bh=DrVV5uN8r7v2I+QYSQO25A2eIY+MsOPpe8409I7IsxA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=QlNVtxOddRzx03i8Gh79h5uDyLh/lIAK7bhFzP/wb+LQFRg20aeFCLNXa40/qeQLS
	 KtP0ZpzDBBsU956zuMEkwnC+hRVF4cME2muNVX0xr2RTzyQGW6f/wZ0tjurHiPk8Po
	 wV13s8v97Piw8XIoBDUEasCLVGlHHXQu68fec5eOcKgjCWYNCAu+4MM14nx7bo1fNU
	 v/0czz9p0ql72EAiNvUDCDAxEuoex3J4Zyj1oGRKTJEZpDYm+0U3s77mYBtHhzlChf
	 mvGEtGRlcYcXK+EBpdy4wqIPn/CoJLOxjem/WJxybaCUymVOnwTEzo54O1yqjKYJc6
	 ZfOmX/FD3Xc+Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F06BFF40071;
	Thu, 18 Jun 2026 20:12:55 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 18 Jun 2026 20:12:55 -0400
X-ME-Sender: <xms:h4k0alCh6JRsAWcwmnr7xsj2WgIJ7wHPnpXNFSv8v-cFiEjxIc9Jdg>
    <xme:h4k0auViSVnQZtIIelZVVkfhkd8zb0vuhQtI69VqMLgicsG48-VfA7q9YFKm73Tvm
    kiBI9kceuEghDQTv6TkqKeImUaewvFEO6bWY6c61Kb9Vc0r6b-L10I>
X-ME-Proxy-Cause: dmFkZTFFgGMJmX8Os2wj0nlRvJBoJg8BoZ0wj6ibv8STLwBWkKPXny219PscUL5sc+WKFf
    yOUDVXCy02DARhZmQre8f+p90oJRUCV62nPpEiipAQm+8Jumtmrenn1FyElXw0rthfPcKo
    ludpbBqGI0wRVMsGXgds+Jah+9n78MEn9udMZ6zdHPGcwqsE97XRoa++1qntyEyblnq5wS
    R2FZi+PdvCyDjjeXtqRzJo9RhSemvgFpLcWce4/1B8df9yFY/Prv2ObZd7YvsVexwZcGmL
    b9ZP5e9CK+UXbfe9DhHra3X5Lb3GhxOPG3lq0/72FCeWV5tkjPyVSqg5kxLsY5MgW6u1ZA
    Hfr0xa2YrqeCJpj2HHDnJa4sn54bAYiSbktS1iJUg3HcR9uVmtJXB7bOdF37g6iLgFmnkX
    CZl5QhnhYRtRLGlX6gXyy08hOpXoRHP39SB4A306tPnrduF6WsTCEyB8S8RM/HXjZEbkXr
    YqFYHU5GeNJ4p8q4W6bwzos8vwvR816O7WVAIO5t1k56uJWSjZGFhqPtv3bA36cFo/BpzD
    bxrTqX9GWu95KgovTctr129M+25TAIz+vEsSTJK15+Ty+AdWOS095pCSxgjeI6WwZX5k+X
    67FJdKZlhjWQtaTDAJzG3eNhmXJaLqnIQZKgPgDJQPMMpw5fLhY+6Lh3LioQ
X-ME-Proxy: <xmx:h4k0aivR2MtE5J8wynYUSUNNqXEHDjujBIcyH_st8TwPS4h7rjwnwg>
    <xmx:h4k0atco5I1hQXGxOXjJgJmL6FKODiGyAV9-o0-ot59zcfduHqkW3A>
    <xmx:h4k0aon2yhIXlpy_KEacA3HtyWB4gr3poHjAVnMhdwS_YYWx-wR3wQ>
    <xmx:h4k0agAfqDDOmT__E0-CvTztjY1F1ZHD8S70EhcQiUJ5Plve9dE5Ww>
    <xmx:h4k0aiP16eAjVD6aNf6e-M_dXKqbRQR0yKIP8CNP_msbXdPNL3x-_1zE>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CBBA57809DB; Thu, 18 Jun 2026 20:12:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Jun 2026 20:12:34 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve Dickson" <steved@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <9847a194-22e9-49d7-8729-6dc31475d203@app.fastmail.com>
In-Reply-To: <20260618-exportd-netlink-v5-5-e9aef947af3d@kernel.org>
References: <20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org>
 <20260618-exportd-netlink-v5-5-e9aef947af3d@kernel.org>
Subject: Re: [PATCH v5 5/6] nfsd: count NFSv4 callback operations per netns
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22682-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D49C26A32BB



On Thu, Jun 18, 2026, at 12:57 PM, Jeff Layton wrote:
> The NFS server tracks per-operation call counts for the forward channel
> (proc4ops) but keeps no statistics for the NFSv4 backchannel (callback)
> operations it sends to clients.
>
> Add a per-netns array of percpu counters for callback operations, indexed
> by RFC 8881 callback opcode (OP_CB_GETATTR..OP_CB_OFFLOAD), and bump the
> relevant counter in nfsd4_run_cb(), which is hit exactly once per callback
> that is actually queued.
>
> CB_GETATTR is sent when a GETATTR conflicts with an outstanding write
> delegation, which is roughly what the dedicated wdeleg_getattr counter
> tracked. The two are not identical: the old counter incremented on every
> such conflict, whereas the CB_GETATTR counter only counts callbacks that
> are actually queued, so concurrent conflicts that coalesce onto an
> already in-flight CB_GETATTR are now counted once rather than once per
> conflict. Report the procfs "wdeleg_getattr" line from the CB_GETATTR
> counter and drop the now-redundant NFSD_STATS_WDELEG_GETATTR counter, its
> helper, and its increment site.
>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/netns.h        | 12 +++++++++++-
>  fs/nfsd/nfs4callback.c |  7 ++++++-
>  fs/nfsd/nfs4state.c    |  2 --
>  fs/nfsd/nfsctl.c       | 14 ++++++++++++++
>  fs/nfsd/stats.c        |  2 +-
>  fs/nfsd/stats.h        |  5 +++--
>  6 files changed, 35 insertions(+), 7 deletions(-)

I agree with the Sashiko review that this patch introduces a UAF
possibility that needs to be addressed before the patch is applied.


-- 
Chuck Lever

