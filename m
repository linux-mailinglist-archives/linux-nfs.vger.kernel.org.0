Return-Path: <linux-nfs+bounces-22454-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ztcHK6IsKmpmjgMAu9opvQ
	(envelope-from <linux-nfs+bounces-22454-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 05:33:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A69C66DFEC
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 05:33:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=nXokV7hH;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="j LiCBN+";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22454-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22454-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0B330A0E81
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF3530C176;
	Thu, 11 Jun 2026 03:33:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C42BDC05
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 03:33:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148831; cv=none; b=Q6ccXFP/zFskxcs8BndlmokOiBvZpkXpAXhX6drHjBNNSbi9lMG8wPIeyNZLIQduuAS3qhxYLCFwB3j+qqyMjpRJLZ12iH8rSFhcNnLNLJevFGcyBQdgZ8wL8Q/vognJBp/gL9ckhVV9379RRhEXIWMQZfA2hg8SWJOc8etOljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148831; c=relaxed/simple;
	bh=oR6Xx9NQfhURWBcMnmY2/6FMhv3XE/NPQ8mfvikpSro=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jHlTA9cOWJZM2jwUyb8MFnbFQt55DhSqGsKEdCCtwB/QcC9JvlU3jOdiTs3C7ZZRqaV2FMjayWUo73UUhSpki1jgAWFCbatvaJ4Wlu98G3GtXczitWxDarFyNZ5kH28R4ZD67itNstjIDHal2gzoGqL3ie55WT/Iw68CAkmM3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nXokV7hH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jLiCBN+2; arc=none smtp.client-ip=202.12.124.156
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 25E187A0152;
	Wed, 10 Jun 2026 23:33:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 23:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1781148829; x=1781235229; bh=1K1rdrcGY3+XEV6s/1M95JnSxUag2EQNTj8
	Rg/az56w=; b=nXokV7hH+HktPkCxjBBv8gmesF3Zfd2rWH7+F+icpYffNqSl79y
	gbXg19WQmQyApkN8Rbp1KgvoGQEkAY5Gedl1+Qu7Y2TOGbbaRE5bwu0Qkwk0/8YV
	85SsbMlSmazht7SiVO09AkI6KWJ0pw7DlpvD0gfQOefwr7SisFQb/vUT56OKgrBF
	c+yOqCZsGqtd7XicpZFSL6ntaWxbd+JUwmKnx802aul74UfGPw47o0g67YBjegL7
	ttTCA/CyrSMU3K6oSieA3k8BdBrhMjmuSu9ZM8i5JSuPKOkOgkoxgaNXWs6k5FZf
	ZuZdukfKqhjVnjWH7HFDkE04g+xctuu9NoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781148829; x=
	1781235229; bh=1K1rdrcGY3+XEV6s/1M95JnSxUag2EQNTj8Rg/az56w=; b=j
	LiCBN+2NlJm4AMUf495L0eiMJU8wrE/0pQDyWtk4FPTbcV8z/Zsa/Brd8W1t96nh
	1VXITwzdKJ3n/UfQs0y5+dBEMovu3BO0odcYYumQrbFMWu6nTuyqd/95w4NXNe7s
	+F8f2oSk9zsrzI4nATr//Z92LGfXWtsSGVdwFkNViBWMxE4ergPWb6mYjqZLi6RW
	cmPyt0T2jZJ+mSIuqI0J6iMWFTPE6RZe3QEk87uf247wZ6wIAIEPo0m5/JatyH7z
	gVu7Das2FAfyqf94lbqzVVY7yitA05mJ4E1BzrwXlpXaQd6JCYf2GZWWpHV39+eW
	6DVLr528v9mlKcyP4RPfQ==
X-ME-Sender: <xms:nCwqariOvDhcQ_TDtp3iHTBBv7DdKboWG6w90PfvsBT5uElb5WZ3CA>
    <xme:nCwqaqn01eQJ8AyYQ37ZqNsbVvme661fkbH0KrqEyN7r86uWSyVOYoaignuFY1KfB
    cpgsB_dj7Q7iXGDa8-KNDGFAy1QTQoxnFxtGcYmcQ7EJCx3>
X-ME-Received: <xmr:nCwqauvW0knEnuiVE26KR0Ev0NfAnRG0DiS8p3XiGao0i4iPNoVWgbl8iQi3qYjg0ITgWspg3FyN3jzipCMEVR06VEyrvyw>
X-ME-Proxy-Cause: dmFkZTGCzWDRCE1pGBgWNx3x3l0wy8uYdmSrKWW4xO4E2h337RIYHulBsIsQGmh3cBny/b
    UBTxjRyDSz0vat2mXT5ksmozwOn8TzwubMF5H5R6v4HPB7x5J9OqXWKIGpvTSxTGQCjHLa
    joH3awgw46ZgehXhPHKcwlcGZ1B+4LyAtNeoVXlSjuBBjT5rC63bwl7GaHY8nkDHCB7AIc
    cmxMTXWZ7dGFn8wo8qwRJ067JEDY7hFYI1KJOaLnjrOA7H2quzj6Jfh4HALkDZ78ys9QWC
    4ITYyhHqJC3uGjr+cfWtnULZtwQ2jhSqz+sEvhIr2ebx1xPm3I5o7EnOmXv9bQ4DtGgfLc
    ykOwrEBHAdq+Lq2z2tf7WiiLfIgCKHQ1O8Iz45BBkg1LF/bgD3vChjIafgI0fjrEGfvNOq
    ILA2Jo3w9z1zG/7/H3HteY3MSLjhRc0lP1rHBnRqh21DdWLAGTZgK60OjtHc2wTANZviQC
    zRf1qMlzoTTAfx1CDnuC9vE/BfhicdcxPuMAMpri6QcR+MOCUB2vLRgrTlebjF22icYrZE
    iXcFAxap46p4XHHLea50+kyWKK3lx7bvIsA+/PFI8Oq9OROy5r0UJaYAwV9d8KYSKjj40A
    gQhPln/ZJ7TtgW8zmgHSvf3MHqjewi1zNCbIwxu1c323Uxf5mKGk7/2R+U9w
X-ME-Proxy: <xmx:nCwqaoZZDdQhc2V7ZpFLTeXLuv24rKUZEtPVfaMyANVHGz0qUrqn7g>
    <xmx:nCwqauCxJYVSIeP2rNnAXZKCRQnALq-84iooDA7zNiVESMwcWkgv0Q>
    <xmx:nCwqao-y_do14ni5vOnGHLqFzLpmIn4JtcnMU7DTz9xnHIBDQMvjFw>
    <xmx:nCwqaiR9TJMU8ak_sCzbe-LpEkpTqfhZB5UOR1NtPoUOCEI2vqsMCg>
    <xmx:nSwqaifBzYkmwmmRozVNv6zdM1vURSrS3es1_GAjr2X5P5Qzi8nldZt->
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 23:33:45 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Jonathan Flynn" <jonathan.flynn@hammerspace.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH 4/5] NFSD: Document and rename the NFSv4.1 session slot
 shrinker callbacks
In-reply-to: <20260610-nfsd-slot-growth-clamp-v1-4-7b966700df0b@kernel.org>
References: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
  <20260610-nfsd-slot-growth-clamp-v1-4-7b966700df0b@kernel.org>
Date: Thu, 11 Jun 2026 13:33:43 +1000
Message-id: <178114882392.3002522.3941860594407359120@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22454-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:bcodding@hammerspace.com,m:jonathan.flynn@hammerspace.com,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A69C66DFEC

On Thu, 11 Jun 2026, Chuck Lever wrote:
> Clean up: To prevent their reuse by generic code, rename the NFSv4.1
> session slot shrinker's callback functions to make it clear they are
> for use only by the shrinker.
> 
> Though they are static, callbacks are invoked from outside nfsd.ko,
> so they need appropriate kdoc comments that document their API
> contracts.
> 
> Signed-off-by: Chuck Lever <cel@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9735e9a59f0e..7ce8462e3697 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2196,22 +2196,50 @@ static void free_session(struct nfsd4_session *ses)
>  	__free_session(ses);
>  }
>  
> +/**
> + * nfsd_slot_shrinker_count - report reclaimable DRC slots
> + * @s: shrinker descriptor (unused)
> + * @sc: shrink control (unused)
> + *
> + * Return: a positive count of reclaimable slots, or SHRINK_EMPTY when
> + * there is nothing to reclaim.

I would add to this comment and note that slot zero is not reclaimable,
so that the subtraction of nfsd_total_sessions is explained.

But either way:

Reviewed-by: NeilBrown <neil@brown.name>

and you can add that to all patches in series.  A definite improvement!

Thanks,
NeilBrown


> + */
>  static unsigned long
> -nfsd_slot_count(struct shrinker *s, struct shrink_control *sc)
> +nfsd_slot_shrinker_count(struct shrinker *s, struct shrink_control *sc)
>  {
>  	int cnt = atomic_read(&nfsd_total_target_slots) -
>  		  atomic_read(&nfsd_total_sessions);
>  
> +	/*
> +	 * To prevent deadlock, one slot of each session (slot 0) is
> +	 * not reclaimable while the session is active. Thus the
> +	 * number of sessions is subtracted from the total number of
> +	 * target slots.
> +	 */
>  	return cnt > 0 ? cnt : SHRINK_EMPTY;
>  }
>  
> +/**
> + * nfsd_slot_shrinker_scan - reclaim DRC slots under memory pressure
> + * @s: shrinker descriptor (unused)
> + * @sc: shrink control; @sc->nr_to_scan bounds the sessions visited,
> + *      @sc->nr_scanned reports how many were visited
> + *
> + * Return: the number of session slots NFSD will release.
> + */
>  static unsigned long
> -nfsd_slot_scan(struct shrinker *s, struct shrink_control *sc)
> +nfsd_slot_shrinker_scan(struct shrinker *s, struct shrink_control *sc)
>  {
>  	struct nfsd4_session *ses;
>  	unsigned long scanned = 0;
>  	unsigned long freed = 0;
>  
> +	/*
> +	 * Each visited session releases at most one slot. After
> +	 * nr_to_scan sessions have been visited, the list head is
> +	 * rotated past the last visited session so the next scan
> +	 * resumes from there.
> +	 */
>  	spin_lock(&nfsd_session_list_lock);
>  	list_for_each_entry(ses, &nfsd_session_list, se_all_sessions) {
>  		freed += reduce_session_slots(ses, 1);
> @@ -9120,8 +9148,8 @@ nfs4_state_start(void)
>  		rhltable_destroy(&nfs4_file_rhltable);
>  		return -ENOMEM;
>  	}
> -	nfsd_slot_shrinker->count_objects = nfsd_slot_count;
> -	nfsd_slot_shrinker->scan_objects = nfsd_slot_scan;
> +	nfsd_slot_shrinker->count_objects = nfsd_slot_shrinker_count;
> +	nfsd_slot_shrinker->scan_objects = nfsd_slot_shrinker_scan;
>  	shrinker_register(nfsd_slot_shrinker);
>  
>  	set_max_delegations();
> 
> -- 
> 2.54.0
> 
> 
> 


