Return-Path: <linux-nfs+bounces-9611-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91F2A1C5B0
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 00:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B921888885
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 23:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344CD2046B3;
	Sat, 25 Jan 2025 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KWIy09TW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RS53Zs/2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KWIy09TW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RS53Zs/2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E1B18D643;
	Sat, 25 Jan 2025 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737846114; cv=none; b=aDRIO1dspz4rBr9GINsKCt6ViqzRLsCgwXzHOu47O4wtcDNCBsNTrbd5XSibBKGmyb66DL5rniC8oMux06cm/COhI2liRmlBGRL56xlmOnpHyqcHiu3dIMKnJx8fTvLflSDNfXM+k9QzMU00hbeQHR1GoVqFyaALIEPC8ayBj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737846114; c=relaxed/simple;
	bh=1Ed4B/0IaUVW+vGVVb9kM095TAYMhoP1gKTPmjAwSyQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=r1R0+zF+GPlaxAkD2CGsZ0q2Y8B68kfUdfBe7FXWXoae/iozvrYpbSpJ/e2pXhKZU6Op5zvCH5YxwfzwdkqwQ/uQbxpedNZUn/8ZUdk20tTlYJPFKRxgF0dbBbAD+WQWjlq/NqgBxZuXRbY2/ytSIdz5tKB+pF8TUn1Dd/dAsVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KWIy09TW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RS53Zs/2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KWIy09TW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RS53Zs/2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 013CD2115C;
	Sat, 25 Jan 2025 23:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737846110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAr8bpULekmkXIG5sU7L2o2wvjxophxmJVAoc9r35UY=;
	b=KWIy09TWyLlaG3Q2DrzqYhuSjkjdQSPPGZ17jRAo9wZ3kgAonrACaadbhImS30ZQVmvGPA
	v7y+fFt0W+dVwwOy5drTuT23spUw2WnL09Rnn7k8Y0CpGyvyMB0Opmbss7OXs2q9obXGDm
	oUrm0X2Jky36hihkD+tC/4oRKzbr1v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737846110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAr8bpULekmkXIG5sU7L2o2wvjxophxmJVAoc9r35UY=;
	b=RS53Zs/2zP1rUDyO+IZzgy+ClrkXJxMkZ5wYKA0yhGajOkhGO4jO7fGu/wSG3kj3WW4Hy+
	px7smP033dk8moDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KWIy09TW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="RS53Zs/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737846110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAr8bpULekmkXIG5sU7L2o2wvjxophxmJVAoc9r35UY=;
	b=KWIy09TWyLlaG3Q2DrzqYhuSjkjdQSPPGZ17jRAo9wZ3kgAonrACaadbhImS30ZQVmvGPA
	v7y+fFt0W+dVwwOy5drTuT23spUw2WnL09Rnn7k8Y0CpGyvyMB0Opmbss7OXs2q9obXGDm
	oUrm0X2Jky36hihkD+tC/4oRKzbr1v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737846110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAr8bpULekmkXIG5sU7L2o2wvjxophxmJVAoc9r35UY=;
	b=RS53Zs/2zP1rUDyO+IZzgy+ClrkXJxMkZ5wYKA0yhGajOkhGO4jO7fGu/wSG3kj3WW4Hy+
	px7smP033dk8moDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77F48137DB;
	Sat, 25 Jan 2025 23:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wywdC1htlWcoVQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 25 Jan 2025 23:01:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 "Kinglong Mee" <kinglongmee@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH 1/8] nfsd: don't restart v4.1+ callback when RPC_SIGNALLED is set
In-reply-to: <20250123-nfsd-6-14-v1-1-c1137a4fa2ae@kernel.org>
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>,
 <20250123-nfsd-6-14-v1-1-c1137a4fa2ae@kernel.org>
Date: Sun, 26 Jan 2025 10:01:40 +1100
Message-id: <173784610046.22054.813567864998956753@noble.neil.brown.name>
X-Rspamd-Queue-Id: 013CD2115C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,redhat.com,talpey.com,fieldses.org,gmail.com,kernel.org,davemloft.net,google.com,vger.kernel.org];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 24 Jan 2025, Jeff Layton wrote:
> This is problematic, since the RPC might have been entirely successful.
> There is no point in restarting a v4.1+ callback just because
> RPC_SIGNALLED is true. The v4.1+ error handling has other mechanisms for
> detecting when it should retransmit the RPC.

But why might RPC_SIGNALLED() ever be true?
The flag RPC_TASK_SIGNALLED is only ever set by rpc_signal_task() which
is only called from rpc_killall_tasks() and __rpc_execute() for
non-async tasks which doesn't apply to nfsd callbacks as they are
started with rpc_call_async().

rpc_killall_tasks() is called by fs/nfs/ which isn't relevant for us,
and from rpc_shutdown_client().  In those cases we certainly don't want
the request to be retried, though the nfsd4_process_cb_update() case is
a little interesting as we do want it to be retried, but in a different
client.

So the code you are removing is either dead code because something else
will prevent the restart when a client is being shut down, or it is bad
code because it would delay rpc_shutdown_client() while the request is
retried.=20

I haven't dug the extra step to figure out which, but either way I think
the code should go.

NeilBrown



>=20
> Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for process=
ing more cb errors")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4callback.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 50e468bdb8d4838b5217346dcc2bd0fec1765c1a..e12205ef16ca932ffbcc86d67b0=
817aec2436c89 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1403,9 +1403,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *t=
ask, struct nfsd4_callback
>  	}
>  	trace_nfsd_cb_free_slot(task, cb);
>  	nfsd41_cb_release_slot(cb);
> -
> -	if (RPC_SIGNALLED(task))
> -		goto need_restart;
>  out:
>  	return ret;
>  retry_nowait:
>=20
> --=20
> 2.48.1
>=20
>=20


