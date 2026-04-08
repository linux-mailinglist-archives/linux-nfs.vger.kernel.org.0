Return-Path: <linux-nfs+bounces-20771-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAOADNyk1ml9GwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20771-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 20:56:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D39B3C201F
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 20:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97FF4315BF1B
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CD33D669E;
	Wed,  8 Apr 2026 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezk59P9j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914083B0AFC;
	Wed,  8 Apr 2026 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673591; cv=none; b=LSt8RoSzVOSUbdZFwp6Ie7kHqtLWjytcYYC1vXVlDmAO9/jiA7DTuO99Xxt6rXFcf3aUqlYKFAxb3hOY+Y3eB0aAavMJ20uUWyZttyJb7AEFsKGxA3sAhmgbyrP+L91xVuXrn3JB61tyZAOt1GIjSjtGjBsc+DjedsGA/faJVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673591; c=relaxed/simple;
	bh=RN/pTYJvDuq0Qv3c6dA7MoCNt5qgsAS3+mnHAfe4A88=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lhdOCMnCWk578hmrDgC1MxWDURslgt5RlhQWzZpFa7jV/O75aG6fE2dHwOxD5uYXK3Upp+8Cxp9zvpcRskC5S5WNZYAzILoOpTv5YGGCBsWs/aDKzfwA6bESeTBkM5kPkYbmV1fhjkTkoJ7L8fM43bb6SSCdxGsDSWLNgP8nKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezk59P9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A93C4AF09;
	Wed,  8 Apr 2026 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775673591;
	bh=RN/pTYJvDuq0Qv3c6dA7MoCNt5qgsAS3+mnHAfe4A88=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ezk59P9jOO4M4Li89V2OKZzmcoHRfxRGiqUVCO26Q3YrcIn0VvUNZXsmiqZULrP3F
	 lHJzLI5+p+eFTqVekD60H8R74fbFau5e5xiEIM9H2SW5Tt88gRuph4AeK2Jw2mu7dW
	 bDz73qk7CIPg0WjTLAAjXIeJgv4l9DjJ/3HUojxNbChWKGWQCrcMyveHco4EHFf5KC
	 F7bOWWzrg3II4BknJnIMLL+JxQqL1gjmKVe329jfxJSpGvmthqrZgcIx7oMxFVp5fo
	 RroG63DKpzNmS2WecLJU7rnEX1okrXDyFm4CT5tr2U+BNnfMP3NcmC+rCIE1y5YBje
	 fxaUkQCnTDDtQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 83E04F4007F;
	Wed,  8 Apr 2026 14:39:49 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 08 Apr 2026 14:39:49 -0400
X-ME-Sender: <xms:9aDWaSlT-9YJbg0ItDVJJzBCs4Dxjinx9KDLifjShTizqRNcLE9WbQ>
    <xme:9aDWaUoSFGnoC5IXFjwOHGJaiF1F5TjMKOVDAoaeCm9DeYTTdLL2jRubfW7FpzmF2
    jSpRmpIVldGqhEHO6NvQGPQlOmGYTU0f0S9owXOLIxIgQm0sAx8C3EH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehmrghthhhivghurd
    guvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopegrlhgvgidr
    rghrihhnghesghhmrghilhdrtghomhdprhgtphhtthhopegrmhhirhejfehilhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhr
    tghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvg
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9aDWadWxLr_0AVhJmAWi17_5Cj6gJxZeZbQ1m8qFQmn4m6rkAYwWig>
    <xmx:9aDWafSwX5SulzE7FJOQn5x8EN20Yd_Hi8LdBfrW2NE1lqt28fiBAQ>
    <xmx:9aDWac1AqNvcCx8HBhSPwhYwdI3N3cQFiurjcpIFka2hI-_4tGr3Kw>
    <xmx:9aDWaQK7Ro3Q5sk57SQFnguLEeM2kGpYWpIusKgu0-Ps4n1jfjraGA>
    <xmx:9aDWad_IZdnh80WrYY0WAJQV3KmxevvGIs7ccq50QGp5tusZeUOg0dVy>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F16B4780076; Wed,  8 Apr 2026 14:39:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: As-Fl2EJbHmB
Date: Wed, 08 Apr 2026 14:39:28 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>
Cc: "Calum Mackay" <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <8a6dbbee-5d59-4833-b0f6-22b1e46dfd11@app.fastmail.com>
In-Reply-To: <20260407-dir-deleg-v1-12-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
 <20260407-dir-deleg-v1-12-aaf68c478abd@kernel.org>
Subject: Re: [PATCH 12/24] nfsd: add data structures for handling CB_NOTIFY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20771-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9D39B3C201F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, Apr 7, 2026, at 9:21 AM, Jeff Layton wrote:
> Add the data structures, allocation helpers, and callback operations
> needed for directory delegation CB_NOTIFY support:
>
> - struct nfsd_notify_event: carries fsnotify events for CB_NOTIFY
> - struct nfsd4_cb_notify: per-delegation state for notification handling
> - Union dl_cb_fattr with dl_cb_notify in nfs4_delegation since a
>   delegation is either a regular file delegation or a directory
>   delegation, never both
>
> Refactor alloc_init_deleg() into a common __alloc_init_deleg() base
> with a pluggable sc_free callback, and add alloc_init_dir_deleg() which
> allocates the page array and notify4 buffer needed for CB_NOTIFY
> encoding.
>
> Add skeleton nfsd4_cb_notify_ops with done/release handlers that will
> be filled in when the notification path is wired up.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4afe7e68fb51..b2b8c454fc0f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c

> @@ -3381,6 +3440,30 @@ nfsd4_cb_getattr_release(struct nfsd4_callback 
> *cb)
>  	nfs4_put_stid(&dp->dl_stid);
>  }
> 
> +static int
> +nfsd4_cb_notify_done(struct nfsd4_callback *cb,
> +				struct rpc_task *task)
> +{
> +	switch (task->tk_status) {
> +	case -NFS4ERR_DELAY:
> +		rpc_delay(task, 2 * HZ);
> +		return 0;
> +	default:
> +		return 1;
> +	}
> +}
> +
> +static void
> +nfsd4_cb_notify_release(struct nfsd4_callback *cb)
> +{
> +	struct nfsd4_cb_notify *ncn =
> +			container_of(cb, struct nfsd4_cb_notify, ncn_cb);
> +	struct nfs4_delegation *dp =
> +			container_of(ncn, struct nfs4_delegation, dl_cb_notify);
> +
> +	nfs4_put_stid(&dp->dl_stid);
> +}
> +
>  static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>  	.done		= nfsd4_cb_recall_any_done,
>  	.release	= nfsd4_cb_recall_any_release,

So when a client responds with NFS4ERR_DELAY, the RPC framework retries
after 2s. On retry, prepare() is called again, but ncn_evt_cnt is
already 0 (drained in the first prepare). prepare returns false, which
destroys the callback.

Events arriving during the retry window are dropped because
nfsd4_run_cb_notify() returns early when NFSD4_CALLBACK_RUNNING is set.
After the callback is destroyed, future events can queue a new CB_NOTIFY,
but the window's events are lost.                                                                                        

The result is that the client misses notifications. Does this impact
behavioral correctness or spec compliance? Is there a way for that
client to detect the loss and recover?


-- 
Chuck Lever

