Return-Path: <linux-nfs+bounces-22075-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAlDA+O3GWpWyggAu9opvQ
	(envelope-from <linux-nfs+bounces-22075-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 17:59:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B94A460532D
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B82453019103
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02F82DA757;
	Fri, 29 May 2026 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfWQPv8X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE91F78E6;
	Fri, 29 May 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069129; cv=none; b=B5qO8DSPIFJY2iOjlNYkdVmar86TzRpRcL+zpJ3t2U2/ruyH1P9b8Df7yy3cAiL7QGIgRKUeUhZTvzAoMuBq03Jea1TNrts/dmOGwV0QyIbje7oQBZdT/Rf71XMJRkqoPKVRRp0zG/in5sslVS7mlsgVs7mzzHcg8gIgcfF4OLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069129; c=relaxed/simple;
	bh=KN+GAexbyrGTUIvmY+CguTOLdPCenmvdLgdODDA6OaE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JJnIIggsuIEA2soJxqgj9FQkX7sf3rW1C8goEL4iDoEeCBdS4n6WrTM2qRYEIWGy8fhr0luKixvC3VPdZ/uH9l9Qe1GftrfZJCwfU0xN4CT64PwjVfzv82qMLmPmW7B+VHeoocIkKPmx21kNGpzenMoGW+V3VVbQRT/BPvjpgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfWQPv8X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA4E1F00899;
	Fri, 29 May 2026 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780069127;
	bh=YQxivC3VLuJYe1KtueSHTthFDRVDFjvlReXHzf2VXtY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=QfWQPv8XBC0G1jqbQQr/gEZk4FdYISGFJ6BGegoqEHudQLcAwyPeHn9WUToEavq0k
	 /5gHW/86TqTlU3fMRuNWizK472kFeqpvtNz7Trn00Lr3SRkq1ad2gpBCuQqM4aFTHX
	 iLh/z64HD1SSvDLyGgGvJtv/llb0q5sC7B+YdIGulS74Tf8nNT7h+9QkU6rniKBOKN
	 4PLFehvHlTQBriLrMJsijDMSgxb0E8PW4/rikuL8nBfV3uaWghWRFjGd1ZSTmVnH9u
	 8rXkwMBHNRQ3I6JgqO4fNO4LerRuvp/Fnx6G6/gVJsMHThEHI/fMC+ZEWqelKvYrpR
	 HUklgB6deIwng==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7D552F4007B;
	Fri, 29 May 2026 11:38:46 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 29 May 2026 11:38:46 -0400
X-ME-Sender: <xms:BrMZarvSXqLxCUNApbqkNiBfPfI01SThgblTP8TlomzLi6UAoH-wFg>
    <xme:BrMZanSPpp2QZGzITVpNTANEEoCgOeoPgvEbHtHJAmG32sQvKPXIjlfG4Beu575l0
    9LjFPcKMKUUXW97nQKqp12QlrJ0bvQcUghp8K6urCmMbk0PZG6XTME>
X-ME-Proxy-Cause: dmFkZTGKrHhpVNOK44pXFMqz7xY5Kna3BNQWQX8J/AZjIUUCvRMGKODf4JeI27+HP36Rkx
    rbKvaz3P5gGzTFORkUq3Ga4SmEEJ14z6tBVWXtwxOd5sCfRE59kRkx1MXtvt6zEyUA3j98
    493ty1yVsbotSH8ORpOO5pQ0i9U7nFFpcHDeJGTr5cVjGf20Af8cHoGBUTBU+sROU9bmPr
    rziqQP9WJNqXzR5ViNw7s/uDerSl85kM76L6VybksBJuRQ2jnMUrn4AlM2Ri7sff7n43AK
    yvWtUFkgtJkwsCg6pS1ZLnHTIeeU7mIQnz73ypHdI1PpQOcp/KakxP5/9wcbuQiCQzHmN9
    I1eC+2mkRsWX2MRvwPdusuH9h7LQ7cGGeYD7LCuPe6zb51bRe4BiCydOxl76RdtQk7dm+s
    XKxHNvWtr4/nusjwPsxdSkZmkwrM6ItoHajCtN+jozxW1OjakPR1oVlcxOT0gNDh6/BlYd
    QPrkrOK8TlOoPUtzrrx0M9slhfn7kHsgASqGH8mSPHGgohhMgYE67wKwaFjH2MNChnp3mV
    2Idd84bUF8uEs1l84ectapOdKcFjNxgnk/BT1iG0gnwO5carakiQS3L/QsFOdfJzV8rGjN
    L9IofuZL8NDvV7EhLVcbR9reRWQCHDkR7n9/lDgxZi7AQs9WbQxCOzvVXRRQ
X-ME-Proxy: <xmx:BrMZapFPHrX4-92kDBZ5i9AZoj5EKNiwscJ1mkcegl3SJKg8DH3e_Q>
    <xmx:BrMZatQrOwXKF_snmemtra35NWQ9GU0MlPctDUErMNJACGzpPno7Xw>
    <xmx:BrMZanOUrNaVmB1B7MXgUMXi0RVW91tL5C8-G1AfQjnPFKsW22BXIg>
    <xmx:BrMZain3wWmZi1Vara4A-WWPEgqeSspbNi5WJd78YXw-UleHDinWgg>
    <xmx:BrMZahbiAgruyDAOCdpynjJSF97KLtqoMrL5lR0JlrMUhaWH2OET-A8b>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5300D7800CC; Fri, 29 May 2026 11:38:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A3vJJvDMHKQR
Date: Fri, 29 May 2026 11:38:26 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 "Scott Mayhew" <smayhew@redhat.com>,
 "Trond Myklebust" <Trond.Myklebust@netapp.com>,
 "Andreas Gruenbacher" <agruen@suse.de>, "Mike Snitzer" <snitzer@kernel.org>,
 "Rick Macklem" <rmacklem@uoguelph.ca>
Cc: "Chris Mason" <clm@meta.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <c087f4c4-c17e-474e-a869-14077996beb6@app.fastmail.com>
In-Reply-To: <20260528-nfsd-fixes-v1-3-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-3-e78708eff77d@kernel.org>
Subject: Re: [PATCH 03/10] nfsd: serialize nfsd4_end_grace() with atomic test-and-set
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22075-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B94A460532D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, May 28, 2026, at 5:55 PM, Jeff Layton wrote:
> From: Chris Mason <clm@meta.com>
>
> nfsd4_end_grace() guards its drain path with a plain bool:
>
>     if (nn->grace_ended)
>             return;
>     nn->grace_ended = true;
>
> The read and the write are independent, and nothing in struct
> nfsd_net serializes them.  At least two contexts can reach this
> code with no lock held:
>
>     laundromat path
>       laundry_wq kworker
>         nfs4_laundromat()
>           nfsd4_end_grace()
>
>     RECLAIM_COMPLETE path
>       nfsd compound kthread
>         nfsd4_reclaim_complete()
>           inc_reclaim_complete()
>             nfsd4_end_grace()
>
> Both callers can observe grace_ended == false on different CPUs,
> both store true, and both proceed into nfsd4_record_grace_done(),
> which invokes the active client_tracking_ops->grace_done callback.
> For tracking ops that drain reclaim_str_hashtbl (legacy_tracking_ops
> via nfsd4_recdir_purge_old, and the cld v1+ ops via
> nfsd4_cld_grace_done), grace_done calls nfs4_release_reclaim(),
> which walks every bucket of reclaim_str_hashtbl with no lock and
> calls nfs4_remove_reclaim_record() (list_del + kfree) on each
> entry.  Two concurrent walkers corrupt the list and double-free
> every nfs4_client_reclaim.  A concurrent nfsd4_find_reclaim_client()
> iterating the same bucket reads through freed memory.
>
> A third call site exists in nfs4_state_start_net() on the
> skip_grace startup path, but it runs under nfsd_mutex before any
> client has connected and before the laundromat's first delayed
> work fires, so it cannot race with the two callers above.
>
> Fix by replacing the read/write pair with try_cmpxchg() so exactly
> one caller transitions grace_ended from false to true and proceeds
> into the drain; the loser returns immediately.  bool supports
> 1-byte cmpxchg on all supported architectures, and no lock
> ordering changes are needed.
>
> Fixes: 362063a595be ("nfsd: keep a tally of RECLAIM_COMPLETE operations 
> when using nfsdcld")
> Assisted-by: kres:claude-opus-4-7
> Signed-off-by: Chris Mason <clm@meta.com>
> ---
>  fs/nfsd/nfs4state.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index f4d12dbcf97b..dc4ac541436f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7022,12 +7022,23 @@ nfsd4_renew(struct svc_rqst *rqstp, struct 
> nfsd4_compound_state *cstate,
>  static void
>  nfsd4_end_grace(struct nfsd_net *nn)
>  {
> -	/* do nothing if grace period already ended */
> -	if (nn->grace_ended)
> +	bool expected = false;
> +
> +	/*
> +	 * nfsd4_end_grace() can be entered concurrently from the
> +	 * laundromat workqueue and from an nfsd compound thread
> +	 * handling RECLAIM_COMPLETE.  Without serialization, both
> +	 * callers can observe grace_ended==false and proceed into
> +	 * nfsd4_record_grace_done().  For tracking ops whose
> +	 * grace_done drains reclaim_str_hashtbl, that results in
> +	 * list corruption and a double free of every
> +	 * nfs4_client_reclaim entry.  Use an atomic test-and-set so
> +	 * exactly one caller proceeds.
> +	 */
> +	if (!try_cmpxchg(&nn->grace_ended, &expected, true))
>  		return;
> 
>  	trace_nfsd_grace_complete(nn);
> -	nn->grace_ended = true;
>  	/*
>  	 * If the server goes down again right now, an NFSv4
>  	 * client will still be allowed to reclaim after it comes back up,
>
> -- 
> 2.54.0

Seems like the usual idiom for something like this is an atomic
bit op. Perhaps try_cmpxchg on a boolean variable is not going
to behave as you expect on every hardware platform.

-- 
Chuck Lever

