Return-Path: <linux-nfs+bounces-5346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B39515BD
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 09:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5A41F243F4
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 07:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4365A4DA00;
	Wed, 14 Aug 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WfTNVC8/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hQsnQmc8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WfTNVC8/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hQsnQmc8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6A8488;
	Wed, 14 Aug 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621575; cv=none; b=Lr7HYyzptHKjkrbLg5UynaZBSi0cYjDZqn7wdn8OsH24FrscVhsPZBMSE6XU9cV0Wm6BBAJuC0dbSE9ABmjTQzoi5dn7Cb5QoZy/EqUHNhhPuH6nAhnK3ESzWhfF3KXz5PAw/5IEFa/ZEygRsLIESLaowQMcnYQ3rvdatZYHDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621575; c=relaxed/simple;
	bh=ZN3Dy3Cu3HOgYeh/kioHxc1YS1vbbrnFHsAmzBFL/PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN3yE5gVJMNw17NK2kQMxuNtpS1o+3e8j34pi6pJSgGey994ZgUQJMV+ZKhuGj+lEO9C9aqioSpSR7ZhWJ0ReDrLlhRatDANjPwBBb5tb1HFNNkID/SD/+M8kUHCIk/KYvb6ybcnE8csr+LedmSHT6Xsm4B3XUtdXng9t4VhJ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WfTNVC8/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hQsnQmc8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WfTNVC8/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hQsnQmc8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0662B1F7E1;
	Wed, 14 Aug 2024 07:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723621565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xaVy4wFx7dCh6VdJK0U8mZ4nIvitG+veJTGq8x//eX4=;
	b=WfTNVC8/uVDWTVk6JVyskOKqeZA9dfLCprIky1s7hApwybS7ZbSjbknR7LoWiqnoEbIH0k
	m5vsKSCi4YaJ06epVVKcVejTeYvRfra208BGtxHURecKo+Lfksw3PRuzhExfaxcLotx+Zl
	zBpLOEHdNURj3VrrO2tLH5Mg+Q98Jjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723621565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xaVy4wFx7dCh6VdJK0U8mZ4nIvitG+veJTGq8x//eX4=;
	b=hQsnQmc8ODY+A9pc4Mu+B8GaXYp48qvNHJaUEZ934B1AI89uZaoDLgolCSZN4ffGAf/HBJ
	UtZ+3N2wHzNaQjBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="WfTNVC8/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hQsnQmc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723621565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xaVy4wFx7dCh6VdJK0U8mZ4nIvitG+veJTGq8x//eX4=;
	b=WfTNVC8/uVDWTVk6JVyskOKqeZA9dfLCprIky1s7hApwybS7ZbSjbknR7LoWiqnoEbIH0k
	m5vsKSCi4YaJ06epVVKcVejTeYvRfra208BGtxHURecKo+Lfksw3PRuzhExfaxcLotx+Zl
	zBpLOEHdNURj3VrrO2tLH5Mg+Q98Jjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723621565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xaVy4wFx7dCh6VdJK0U8mZ4nIvitG+veJTGq8x//eX4=;
	b=hQsnQmc8ODY+A9pc4Mu+B8GaXYp48qvNHJaUEZ934B1AI89uZaoDLgolCSZN4ffGAf/HBJ
	UtZ+3N2wHzNaQjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8D52139B9;
	Wed, 14 Aug 2024 07:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tTTAK7xgvGZKMwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 14 Aug 2024 07:46:04 +0000
Date: Wed, 14 Aug 2024 09:45:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: cel@kernel.org
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
	sherry.yang@oracle.com, calum.mackay@oracle.com, kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Subject: Re: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of
 global"
Message-ID: <20240814074559.GA209695@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240812223604.32592-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812223604.32592-1-cel@kernel.org>
X-Spam-Score: -3.71
X-Rspamd-Queue-Id: 0662B1F7E1
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

Hi Chuck,

> Following up on:

> https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/

> Here is a backport series targeting origin/linux-6.6.y that closes
> the information leak described in the above thread. It passes basic
> NFSD regression testing.


Thank you for handling this! The link above mentions that it was already
backported to 5.4 and indeed I see at least d47151b79e322 ("nfs: expose
/proc/net/sunrpc/nfs in net namespaces") is backported in 5.4, 5.10, 5.15, 6.1.
And you're now preparing 6.6. Thus we can expect the behavior changed from
5.4 kernels.

I wonder if we consider this as a fix, thus expect any kernel newer than 5.4
should backport all these 12 patches.

Or, whether we should relax and just check if version is higher than the one
which got it in stable/LTS (e.g. >= 5.4.276 || >= 5.10.217 ...). The question is
also if enterprise distros will take this patchset.

BTW We have in LTP functionality which points as a hint to kernel fixes. But
it's usually a single commit. I might need to list all.

Kind regards,
Petr

> Review comments welcome.   

> Chuck Lever (2):
>   NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
>   NFSD: Fix frame size warning in svc_export_parse()

> Josef Bacik (10):
>   sunrpc: don't change ->sv_stats if it doesn't exist
>   nfsd: stop setting ->pg_stats for unused stats
>   sunrpc: pass in the sv_stats struct through svc_create_pooled
>   sunrpc: remove ->pg_stats from svc_program
>   sunrpc: use the struct net as the svc proc private
>   nfsd: rename NFSD_NET_* to NFSD_STATS_*
>   nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
>   nfsd: make all of the nfsd stats per-network namespace
>   nfsd: remove nfsd_stats, make th_cnt a global counter
>   nfsd: make svc_stat per-network namespace instead of global

>  fs/lockd/svc.c             |  3 --
>  fs/nfs/callback.c          |  3 --
>  fs/nfsd/cache.h            |  2 -
>  fs/nfsd/export.c           | 32 ++++++++++----
>  fs/nfsd/export.h           |  4 +-
>  fs/nfsd/netns.h            | 25 +++++++++--
>  fs/nfsd/nfs4proc.c         |  6 +--
>  fs/nfsd/nfs4state.c        |  3 +-
>  fs/nfsd/nfscache.c         | 40 ++++-------------
>  fs/nfsd/nfsctl.c           | 16 +++----
>  fs/nfsd/nfsd.h             |  1 +
>  fs/nfsd/nfsfh.c            |  3 +-
>  fs/nfsd/nfssvc.c           | 14 +++---
>  fs/nfsd/stats.c            | 54 ++++++++++-------------
>  fs/nfsd/stats.h            | 88 ++++++++++++++------------------------
>  fs/nfsd/vfs.c              |  6 ++-
>  include/linux/sunrpc/svc.h |  5 ++-
>  net/sunrpc/stats.c         |  2 +-
>  net/sunrpc/svc.c           | 39 +++++++++++------
>  19 files changed, 163 insertions(+), 183 deletions(-)

