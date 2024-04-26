Return-Path: <linux-nfs+bounces-3018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2538B2F4C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 06:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87E21C20DDE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 04:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09973811F7;
	Fri, 26 Apr 2024 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ht3m1uYp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zlA1fDd8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ceuDWfZT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2dLPgcRB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A975805
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714104396; cv=none; b=k9GwSNWYFL2xQtvoAggymbgTYdDaMc6/dUTHv5bzbm7WM2AoGVPEHZv8m0dXX3mfhmiDNln50DZj/5tISDqwIvRmeys8is2mEUFxJg2zb5DLNkKkCJgDSdyH9SBugbtF6d8SEfwDA6Y1RZ4Z6oTjvLLr4lMPMiDJMINsdHQdd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714104396; c=relaxed/simple;
	bh=gGQxM28XFYj0qVNMhIVUzBPnGOcP6wxwW6RZrCmmHIY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qCU4GZWhS0lFCEW0rbmOnZIbfNsT7bP9Mk3gwxzDaScBMRwSwQodCPARyGqC5vTpX9Vn3rhil4VrbunagDj2+eE0KtMkQITxrzeBP2jvxSdBH4Tm4ZnIG7imtf/FXKRTESAmleyE98dflqsZCsOjk6kz/2mf05yYt2BI8OMGgQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ht3m1uYp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zlA1fDd8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ceuDWfZT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2dLPgcRB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0F02336E4;
	Fri, 26 Apr 2024 04:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714104387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78P2K7FBOs81wP5YbdyoK3PztQ24uX2wKMRRRPRCTq4=;
	b=Ht3m1uYpjxxVzZg89BeKogMQVyeYbSyTDB8KPjyZS2excwHn0tIHvHDGfzd2Wh2xSmwI0W
	zAShuYCFMEh93sn9sBQmOGetoURC8BEYI0AQ1yo6WLBek3L1+TZwRxv5Ldn1SH6q0NBo8s
	aQG6Pq9WBnJs2CdXpC4Jt9RkNo2S2bU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714104387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78P2K7FBOs81wP5YbdyoK3PztQ24uX2wKMRRRPRCTq4=;
	b=zlA1fDd8N05ZDEszlp7Xoe17AH6yI79hktQCQuLNlONwIlpvRrgOF5Jay+JZom9sz6RB1q
	s58n/6Sv6UINQBAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ceuDWfZT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2dLPgcRB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714104386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78P2K7FBOs81wP5YbdyoK3PztQ24uX2wKMRRRPRCTq4=;
	b=ceuDWfZTtJ1VAiT8uEE67N9Me/27Ae1GPrCLtZ8EA42/6Cl7xDZeT+GojUVkiXbNUklFhe
	BCf/tauX1u3wtrIOks437aXVstKpYGx0pYDWFYBMIBBrRNl6xnFaBUDjZPkGp4Ssfp3pWO
	NevZf6Zh8p0J7pwokpfW1QgYp+Z+/Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714104386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78P2K7FBOs81wP5YbdyoK3PztQ24uX2wKMRRRPRCTq4=;
	b=2dLPgcRBa5M6cYmJACAXazoHNYpc3Ig1EGMQnEiwkPf7a4qXIwfAzMLEq63lT7gaqouT/C
	z8Di0iPWIj+RaqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DFEA1399F;
	Fri, 26 Apr 2024 04:06:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yPsgMT4oK2ZcUAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Apr 2024 04:06:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Guoqing Jiang" <guoqing.jiang@linux.dev>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Remove comment for sp_lock
In-reply-to: <20240426034750.26945-1-guoqing.jiang@linux.dev>
References: <20240426034750.26945-1-guoqing.jiang@linux.dev>
Date: Fri, 26 Apr 2024 14:06:15 +1000
Message-id: <171410437515.7600.14267125361277447684@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.69 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAYES_HAM(-0.18)[70.18%];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D0F02336E4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.69

On Fri, 26 Apr 2024, Guoqing Jiang wrote:
> It is obsolete since sp_lock was discarded in commit 580a25756a9f
> ("SUNRPC: discard sp_lock").
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  net/sunrpc/svc_xprt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index b4a85a227bd7..ec78c277a02e 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -46,7 +46,6 @@ static LIST_HEAD(svc_xprt_class_list);
>  
>  /* SMP locking strategy:
>   *
> - *	svc_pool->sp_lock protects most of the fields of that pool.
>   *	svc_serv->sv_lock protects sv_tempsocks, sv_permsocks, sv_tmpcnt.
>   *	when both need to be taken (rare), svc_serv->sv_lock is first.
>   *	The "service mutex" protects svc_serv->sv_nrthread.


I usually make an effort to find those sorts of things but I obviously
missed it this time.
Thanks.

Reviewed-by: NeilBrown <neilb@suse.de>

NeilBrown

