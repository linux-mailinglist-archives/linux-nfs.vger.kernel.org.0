Return-Path: <linux-nfs+bounces-22727-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cf+KKaWpNWrO2gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22727-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 22:42:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D5D6A7B02
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 22:42:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LwACz3N5;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22727-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22727-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3EAD301A433
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 20:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3BB339863;
	Fri, 19 Jun 2026 20:42:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA89395AEB;
	Fri, 19 Jun 2026 20:42:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901731; cv=none; b=HIOZw8NfSFZFjEHmxJbpMQ6KwKfy4gyMMDXgFnKFLyqJIrSkHxbUD8jWfmSNd8pvaX9R9VK0/XxEodHDGsaKzBql9tebVjIDf8KOMZ56ve2p+TPMj00FazoIzW42ujzBOfl3ehTgakbwzzcA8kNQM+Jke+zRBc2KTE+ceCp3lyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901731; c=relaxed/simple;
	bh=757UIhZ7qu/lnWz8fcUhlso4FQ5q2+jRJh/hJ9bWavw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GmkFG5jx5slFQ53QRE3I0BPC44+3sGXKP3v7ywAHmKDcMR1VnRip/3fijYzx4eGR6osVYquDZo3Oigjq58MQWeRF3YX9b6V30kxunUGlAR/5pEDohvpd8XQ6oyZyoo4HdTzo719fvvB2xCwp7cijOiqgIvV8kaSqBXdrrqcEJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwACz3N5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B561F00A3A;
	Fri, 19 Jun 2026 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781901729;
	bh=uYgEO0J5chhFwK20KEaELoCZrvXaLd37tAuHxYG7vFA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=LwACz3N5PqTJEwzzmqEcIWIEzqeR9bQ1QU0I5jrwFTAv5//Bi4R5zcyiDAPwylOM/
	 5pldCrMf/pLFsv8o4NEgBiaAUrjTdMo4tah9ZbBACS1Da1MJe330z9bgaU7J5g8Yye
	 6fRkPD74ft+7JX/bUtBc6gkEgGvQO3lT/INvnUsRNjJoVe4IQIFgh3IoK1MgIE4Jbs
	 b8AMz/6JVcvC9VNwPYgS7uoRCKX1+aBncnzTOUfLPgFafbRBnnx1BsV9cAvLExxbK6
	 nQJWSCaL5AggIUGSMp6zOD5u64c22k4dyqXZODOymcEqze2TLRQp6M3ZwlFsQDF0Xx
	 bXNh1VEdtqzww==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DED23F4006A;
	Fri, 19 Jun 2026 16:42:08 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 19 Jun 2026 16:42:08 -0400
X-ME-Sender: <xms:oKk1atJ8mffLg8SFuP_aPIFCooIayX1gXwtWmm_l-8tabITCyPlyNg>
    <xme:oKk1aj-lpVvEezaffJ1VTStPopVuNjPSflNPZNl3QdCtS10ABcTYf14jciWuk20os
    VRK4DEZz-pJt4Fqf-k0dp3d5lkbXgkAw2PXZDl1X3RxM25npsuZoZQ>
X-ME-Proxy-Cause: dmFkZTGd7Uv7s6hSToPo7vVLQmqA99Fg9s0uAkDgstU+Th9BvirHjm0hFNhaK1Twwl6P3U
    SHRH7L5Rv3LaB0UMu1A5sKpVMJUfT+ROHVcQNrw4rrRIKVWuMgGnqDBFh1cBErbbGbcDHI
    aL+CJOxBGvrSBpZI/nJnGiIlnzBp+PKfJrG2dZG7s+ToWZIs7/U7nvnIXlKtlOSXSw+VZB
    r+WY6j6DYqblu2er5HN8ObOmjEiSP//0rJ8sGRzLBZaI4iE8+llJYMOvLsbY96UxNt16jR
    DuXeTVDaxeUOjPNeU+NtDyUpCc8OOlnNw8gQf11eJOV2o0KC0dKsu65SslRQss56nUexZ3
    OiW4kU8OUIrQEge8f9/i43dn1UNjGP9o6WNCczVTy1g4v9geXhSDrNqQvboir77XyFL9F7
    EGN2DN754itu/KHPm57OH8Ev0Qgxglhc3mjlYLZfYshQzjBEeyAv90B5C/3gQMjKcA8lx6
    G2EVOTPV9KK87AZtQGCTNPe9l73dupuQfktzofoOdaPyoxsrQVRXBU0fDxixMJFFP+IL9I
    7Qc03i/p2H1c/D9tYAkU0xLV0HMrNQmHFXTKyNKdSchNIw9+TMeyLLkLWXJtFGvHqB1XEu
    i1cH+bIABMcl6yTGhBDZOlD7P6A1a7wevMK040vH3QDO7PleeyC7UXFUweHw
X-ME-Proxy: <xmx:oKk1an2Pr2C4zM5qj2biK6Yq4VrEm-VLueGBUzdd5ShM-eX44w3DrQ>
    <xmx:oKk1asHd6GuS0RJkcB-XL6T3oUyMQM5sa-GTCKScutnlakT7KZR0Tg>
    <xmx:oKk1ais6DomfWVePZTfjXhaPuaVd8UIhvQG2id4fnxf1UYFVYK45Rg>
    <xmx:oKk1avp2Z89q768NRkPZ3W_y_FKRkeCbi2okKq_NZK2n-2EWWusnow>
    <xmx:oKk1apUG5Ud8E6cSzPEdOwOOYnEAHlvxn4vxVWSNfT1BgUFYL_TYyztO>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BEEAD780AB5; Fri, 19 Jun 2026 16:42:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvxUbqeuyocJ
Date: Fri, 19 Jun 2026 16:41:47 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve Dickson" <steved@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <a13eff8e-7444-4ba2-bcfa-a981b25af393@app.fastmail.com>
In-Reply-To: <20260619-exportd-netlink-v6-5-ddef3499793c@kernel.org>
References: <20260619-exportd-netlink-v6-0-ddef3499793c@kernel.org>
 <20260619-exportd-netlink-v6-5-ddef3499793c@kernel.org>
Subject: Re: [PATCH v6 5/6] nfsd: count NFSv4 callback operations per netns
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22727-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 13D5D6A7B02



On Fri, Jun 19, 2026, at 11:26 AM, Jeff Layton wrote:
> The NFS server tracks per-operation call counts for the forward channel
> (proc4ops) but keeps no statistics for the NFSv4 backchannel (callback)
> operations it sends to clients.
>
> Add a per-netns array of percpu counters for callback operations, indexed
> by RFC 8881 callback opcode (OP_CB_GETATTR..OP_CB_OFFLOAD), and bump the
> relevant counter in nfsd4_run_cb(), which is hit exactly once per callback
> that is actually queued.

> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 71dcb448fa0a..b171257da6ba 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1921,12 +1921,32 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
>  bool nfsd4_run_cb(struct nfsd4_callback *cb)
>  {
>  	struct nfs4_client *clp = cb->cb_clp;
> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
> +	const struct nfsd4_callback_ops *ops = cb->cb_ops;
> +	u32 minorversion = clp->cl_minorversion;
>  	bool queued;
>
> +	/*
> +	 * Snapshot the opcode, minorversion, and the per-net pointer before
> +	 * queuing: once nfsd4_queue_cb() has queued the work, the callback (and
> +	 * the object that embeds it) may be processed and freed concurrently, so
> +	 * neither cb nor clp can be dereferenced afterward.
> +	 */

The comment says the opcode is snapshotted before queuing, but the code
captures the cb_ops pointer and reads ops->opcode after nfsd4_queue_cb()
returns:

	if (ops)
		nfsd_stats_cb_op_inc(nn, ops->opcode);

That read is safe because every cb_ops points at a file-scope
static const nfsd4_callback_ops (nfsd4_cb_recall_ops,
nfsd4_cb_getattr_ops, and so on), which outlives cb, unlike cb and clp
themselves.  Would the comment read more accurately as snapshotting the
cb_ops pointer rather than the opcode, perhaps noting that ops stays
valid afterward because it points at static data?

>  	nfsd41_cb_inflight_begin(clp);
>  	queued = nfsd4_queue_cb(cb);
> -	if (!queued)
> +	if (queued) {
> +		if (ops)
> +			nfsd_stats_cb_op_inc(nn, ops->opcode);
> +		/*
> +		 * Minorversion > 0 callbacks prepend a CB_SEQUENCE op (see
> +		 * encode_cb_sequence4args()); count it like the forechannel
> +		 * counts SEQUENCE, so it isn't perpetually reported as zero.
> +		 */
> +		if (minorversion > 0)
> +			nfsd_stats_cb_op_inc(nn, OP_CB_SEQUENCE);

Can this inflate the OP_CB_SEQUENCE count for callbacks that never send
a CB_SEQUENCE?  The increment fires whenever minorversion > 0, including
the ops == NULL case.  The only callback with cb_ops == NULL is the
null probe:

  nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);

which nfsd4_probe_callback() and nfsd4_shutdown_callback() queue via
nfsd4_run_cb(&clp->cl_cb_null).  For a 4.1+ client, nfsd4_run_cb_work()
drops that work item without sending any RPC:

	/*
	 * Don't send probe messages for 4.1 or later.
	 */
	if (!cb->cb_ops && clp->cl_minorversion) {
		nfsd4_mark_cb_state(clp, NFSD4_CB_UP);
		nfsd41_destroy_cb(cb);
		return;
	}

So callback-channel probes, backchannel changes, and client teardown
each bump OP_CB_SEQUENCE for a minorversion > 0 client even though no
CB_SEQUENCE (and no callback at all) goes on the wire.

Would moving the CB_SEQUENCE increment inside the if (ops) block avoid
this?  A real callback on a 4.1+ client always prepends CB_SEQUENCE, and
the null probe carries cb_ops == NULL, so:

	if (queued) {
		if (ops) {
			nfsd_stats_cb_op_inc(nn, ops->opcode);
			if (minorversion > 0)
				nfsd_stats_cb_op_inc(nn, OP_CB_SEQUENCE);
		}
	} else {
		nfsd41_cb_inflight_end(clp);
	}

> +	} else {
>  		nfsd41_cb_inflight_end(clp);
> +	}
>  	return queued;
>  }


-- 
Chuck Lever

