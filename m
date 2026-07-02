Return-Path: <linux-nfs+bounces-22955-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Vs9EOXNRmqodwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22955-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 22:45:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 930AF6FCCD6
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 22:45:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E5HbCWdy;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22955-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22955-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6488030075DE
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F133B6F1;
	Thu,  2 Jul 2026 20:45:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FA333B6E8;
	Thu,  2 Jul 2026 20:45:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783025122; cv=none; b=YCYf0bS7quBWQ1K8Sa8w+3Zb0/0D0HQjkqQh13DFxqpj1jWragIo4H3BrMiI6orO4BszAmu2NHp0/Jeiko+Sb+AMs6L69Whp5Mpm68ETmv3K1M+pRpGNcQ8cRDYTNNhbZDjv1yl/QKXyDAlRX43q8AQPvt1vw3eXEJbEgS1eHy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783025122; c=relaxed/simple;
	bh=9bjGaW2xqFtOKOjoH2XYmQTRMj29VWIQHUSfpLTJ8zw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KsUs3+MIzHCq1zgtf6s//8M1TMvNumLA/tLUHjMGACvWM2gNDk8oihz6uwLRbdtvZG8tboADclHHmnXpx+7LbN9Wj4L0AaqOlWaar1ZX0+liXlDB84QKhR6a+iwTu6j4ZpQwGJJ0WWeFfSz5tg9xfXDyCu93gaoLl5bW2PW/M58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5HbCWdy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9231F000E9;
	Thu,  2 Jul 2026 20:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783025121;
	bh=sV7+DPdgpOZCAKw1wALrGg5YsvNfUvmv07GbElhuie8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=E5HbCWdyDgFjbX3Kw8aQjk54DXEJtswWNjqmtu5+/uILwfsNP9bHYLNEqid334S2t
	 Pmq0eHCawJrjtM3yEC2n8JG6f0Wr8r/RtlxAYkPOeeQ5xhqp1CEAmPH6MgQEGJon5C
	 qiqQ0PHfawjB8O3zmwwZmaGmsdCloS6irUkB1a8pIOV8ROmsis5nAwCKvQUIji3KgK
	 kiOnKF2IENddXQWAtHrS/LfSl5ddzgDLPtphW0j/CwPkDSGzEFsZ+4MUEnYEpVYDDs
	 dNsAbhaxwMtUsv45KBI6GAYGHP3phUFEH3ROtIu8J5gWnFLrJNiIg60DMOxIH8i/6d
	 T3oBbsihNTE7Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 72CE9F40068;
	Thu,  2 Jul 2026 16:45:20 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 02 Jul 2026 16:45:20 -0400
X-ME-Sender: <xms:4M1Gao5PqgJNVaV1IIaZw_E_PEL7VRBUH3WWBUWaa50bv-pi9sJKog>
    <xme:4M1GaktHdHz4shAg3q58OUjsRmIir8FCI24Ity0L9K-5r9Dt-Sec5aw0s6i1SG5q6
    EzlsHu5cLF5MeYJF3wk8Rged9TESaAeiTh9jtFle-eovG7YBkxb70Ed>
X-ME-Proxy-Cause: dmFkZTEWBhmQujZvw9wF2vX4e7b730NnN6xlnP8PtWBPAXtiAZbWF71+2I8koxW6iNCjzm
    didnUynxwK38SPL5U9lS8CB33VzAf6RRO8TyLxHwOrNHOWHpBTZ6cs2mJngiXR7hvMK9Cx
    PnzXm9gfAa3PZ+GkMQ8/5G6cjSZOzZ9oj5dtpJTJlkb8fRH9SHdSZGWEEvqbn8WF0uFo03
    TOomF2q8DK5CzuBCqzH1IHwJBixQCpfbYTzeg4R9UybsH/UKG8iwHnJXbKZubDIQIh++wH
    svZXDYywiYFZ0wxFJ2dQsk+v/8G0G2Xcw5Gxkx3MQEG+AB2e0/adfAaEWcYiVMHRvoLeeY
    ilzH2tGU2p+eTYVY3uKrggE76rtJT/vwG2FKBtd7Fwxop7XQqP5AsU2IvtfQBBwzpgx1ch
    gh7Szhj/k4JKLvIHWjBrsyELht5mc9rZKIbgqXejlzZca0Oz5fpqLm25u/w3df2vtw/IIX
    A5BgYc2AnWe+/lUCd/KswPDEg8PMIUO0LEqPOnZUBql8j+173TE809GvVaIQusoU/vXp2j
    jtKyyTwo+YF0vyaK50ozIGtjGvWSX4pCz3VkMWQCjZ31BBdqezZZq5agLkBCuBGyPyCNXW
    CsE/zNgDzyJTtZbAOzFycgATY13Lk9r1N2nOqzcqzR/Es8xG6JPmI7mDAnYQ
X-ME-Proxy: <xmx:4M1GaucBJlFrs1fzQmolec4UeCc--ab0DSXEBb0KQq53q4NDYwNlqQ>
    <xmx:4M1GaoXaadCZZ3GBirLmqksGJohM-8VIzWaiQ-qrCjMD1eYSu4eIkw>
    <xmx:4M1GaneS1A2Kr2wm4oSP9-aD5OGg9UYm4OZOZxAyYJnFz_TsP8o7gw>
    <xmx:4M1GakMH_HluRhmzyq3ClPoTu-PEcq-66HC5o7NBN5cQheEu17Dxgg>
    <xmx:4M1GalhXg5heameuRMmawAKguXP4OjUNmBIYbwKSGDis128BlYMD75Gp>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 525D5780AB8; Thu,  2 Jul 2026 16:45:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: At87D983WL-J
Date: Thu, 02 Jul 2026 16:45:00 -0400
From: "Chuck Lever" <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Message-Id: <75ee89cc-490d-4ba4-b6fa-32f5a2b62379@app.fastmail.com>
In-Reply-To: <20260702202749.1618630-2-cel@kernel.org>
References: <20260702202749.1618630-1-cel@kernel.org>
 <20260702202749.1618630-2-cel@kernel.org>
Subject: Re: [PATCH 6.12.y 2/2] nfsd: release layout stid on setlease failure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22955-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:email,meta.com:email,app.fastmail.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 930AF6FCCD6

Please note: The correct Author for this patch is "Chris Mason <clm@meta.com>"

On Thu, Jul 2, 2026, at 4:27 PM, Chuck Lever wrote:
> commit 30d55c8aabb261bc3f427d6b9aae7ef6206063f9 upstream.
>
> nfs4_alloc_stid() publishes the new stid into cl->cl_stateids via
> idr_alloc_cyclic() under cl_lock before returning to
> nfsd4_alloc_layout_stateid(). When nfsd4_layout_setlease() then
> fails, the error path frees the layout stateid directly with
> kmem_cache_free() without ever calling idr_remove(), leaving the
> IDR slot pointing at freed slab memory. Any subsequent IDR walker
> (states_show, client teardown) dereferences the dangling pointer.
>
> The correct teardown for an IDR-published stid is nfs4_put_stid(),
> which removes the IDR slot under cl_lock, dispatches sc_free
> (nfsd4_free_layout_stateid) to release ls->ls_file via
> nfsd4_close_layout(), and drops the nfs4_file reference in its
> tail.
>
> Replace the manual nfsd_file_put + put_nfs4_file + kmem_cache_free
> cleanup with a single nfs4_put_stid(stp).
>
> Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <clm@meta.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Chuck Lever <cel@kernel.org>
> [ cel: no ls_fence_work in 6.12.y; dropped INIT_DELAYED_WORK hunk ]
> Signed-off-by: Chuck Lever <cel@kernel.org>
> ---
>  fs/nfsd/nfs4layouts.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index fc5e82eddaa1..c08bc2d0d377 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -256,9 +256,7 @@ nfsd4_alloc_layout_stateid(struct 
> nfsd4_compound_state *cstate,
>  	BUG_ON(!ls->ls_file);
> 
>  	if (nfsd4_layout_setlease(ls)) {
> -		nfsd_file_put(ls->ls_file);
> -		put_nfs4_file(fp);
> -		kmem_cache_free(nfs4_layout_stateid_cache, ls);
> +		nfs4_put_stid(stp);
>  		return NULL;
>  	}
> 
> -- 
> 2.54.0

-- 
Chuck Lever

