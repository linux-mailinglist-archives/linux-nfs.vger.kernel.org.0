Return-Path: <linux-nfs+bounces-5351-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD3951863
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 12:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C1228396C
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4CF1AD416;
	Wed, 14 Aug 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XCmmNEn+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DGLQ1FRA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rMOtcBb/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XXPL0PTX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB744D8B9;
	Wed, 14 Aug 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630177; cv=none; b=Bblqs6Yd59wb0pkWRXiSgEwiBfqD6JO4Z+fqX4+sTFWDBaqnpujoiWwCwJbqh9H74jLxyleRCceQKOX/k9rWiyqCnvLst5GzpWKnGYYFjT9Orix6W7d//CrXg7nmG1CTteDV8tOYqre9rS6Y43NKVDHHiHkrDcBJAW2Vr6BfwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630177; c=relaxed/simple;
	bh=4UnDlQe/vysWjxZ5CMpBD4hDjUP/eIU/5CijPaCAXgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHkPSL8pG2kILK11iN+H9vy2L6TgyKBGfDis8d/TmQwBl3ZXu1lKqQba0Dj5Fs0lYKbt0CENicGWkFvT+0jD5Ri2jtI7unuNrPprawmzLHn1vOG9KwTlNaI8TLr1zb3Yp4b07el/Mfm385+/3LrQh9nMyxnRgJ7XMIlsFa64YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XCmmNEn+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DGLQ1FRA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rMOtcBb/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XXPL0PTX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C199B227B0;
	Wed, 14 Aug 2024 10:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723630172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1bXFXgpDvTgn3zDMsa6ryngGfJZ6wle3EjQ9H3J9PXM=;
	b=XCmmNEn+sgBjhO/SY/88xiysaWwdfkBwoMG9jUN0mn0AdzNw5ePQQJAZGna2lG1/ErORrh
	RwxhDCZD9osgYoTpMPaR8juDE1sAxLqLPIzRNqs3sitvw4T3X7dDuzhqLCOCZPEEJwaR+v
	/dmxLfkywcn/xIQjUhlLwemQQ0Zf1ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723630172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1bXFXgpDvTgn3zDMsa6ryngGfJZ6wle3EjQ9H3J9PXM=;
	b=DGLQ1FRAxAFIrApMIdZuvLwzF5fI+iA8KFVW9uitxB02yq9oI77ct0AuoKOIiVH+FTGGAQ
	v/CkPrgzbg3/6OAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723630171;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1bXFXgpDvTgn3zDMsa6ryngGfJZ6wle3EjQ9H3J9PXM=;
	b=rMOtcBb/iucToTGTMzfzRktTS0BsorpMjWPZd3GhLaUVfw48N36jkgFbv6RrOcqj8aPHRA
	L8+vCmMbsD2PDbdYJ3J35vd9QtzHb+MGdqFznAYBqoFkHFY4T9TngPDILkUQFDOnuKlqC1
	U7XfMRyQ33bgeadkoBS5yLBDb9E/M/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723630171;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1bXFXgpDvTgn3zDMsa6ryngGfJZ6wle3EjQ9H3J9PXM=;
	b=XXPL0PTXdP+FOyO7JBpuF4QCuynrru4hN5XZ+CHQLcyZ66v4in9/szIDRtUDLQOK5dABxQ
	4C5A3JyPPev0HKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7720C139B9;
	Wed, 14 Aug 2024 10:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fwXOG1uCvGaBAgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 14 Aug 2024 10:09:31 +0000
Date: Wed, 14 Aug 2024 12:09:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: "cel@kernel.org" <cel@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Sherry Yang <sherry.yang@oracle.com>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Cyril Hrubis <chrubis@suse.cz>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of
 global"
Message-ID: <20240814100930.GA525252@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240812223604.32592-1-cel@kernel.org>
 <20240814074559.GA209695@pevik>
 <BN0PR10MB5143EDD71EF92A181D4255A0E7872@BN0PR10MB5143.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN0PR10MB5143EDD71EF92A181D4255A0E7872@BN0PR10MB5143.namprd10.prod.outlook.com>
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.50

Hi Calum,

> Hi Petr,

> There are two sets of changes here, for NFS client, and NFS server.

> The NFS client changes have already been backported from v6.9 all the way to v5.4.

> Here, Chuck is discussing the NFS server changes (and others), which were not backported from v6.9 (actually, a few were, but only to v6.8).

Thanks for info! Now I'll see the patchset "Make nfsd stats visible in network
ns" [1]. kernelnewbies [2] starts with d98416cc2154 ("nfsd: rename
NFSD_NET_* to NFSD_STATS_*"), the others are probably some preparation commits.

Anyway, I'll update the patch with NFS server patchset.

Kind regards,
Petr

[1] https://lore.kernel.org/linux-nfs/cover.1706283433.git.josef@toxicpanda.com/
[2] https://kernelnewbies.org/Linux_6.9#File_systems


> Thanks,
> Calum.

> Sent from Outlook for Android<https://aka.ms/AAb9ysg>
> ________________________________
> From: Petr Vorel <pvorel@suse.cz>
> Sent: Wednesday, August 14, 2024 8:45:59 AM
> To: cel@kernel.org <cel@kernel.org>
> Cc: stable@vger.kernel.org <stable@vger.kernel.org>; linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>; Sherry Yang <sherry.yang@oracle.com>; Calum Mackay <calum.mackay@oracle.com>; kernel-team@fb.com <kernel-team@fb.com>; Chuck Lever III <chuck.lever@oracle.com>; Cyril Hrubis <chrubis@suse.cz>; ltp@lists.linux.it <ltp@lists.linux.it>
> Subject: Re: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of global"

> Hi Chuck,

> > Following up on:

> > https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/

> > Here is a backport series targeting origin/linux-6.6.y that closes
> > the information leak described in the above thread. It passes basic
> > NFSD regression testing.


> Thank you for handling this! The link above mentions that it was already
> backported to 5.4 and indeed I see at least d47151b79e322 ("nfs: expose
> /proc/net/sunrpc/nfs in net namespaces") is backported in 5.4, 5.10, 5.15, 6.1.
> And you're now preparing 6.6. Thus we can expect the behavior changed from
> 5.4 kernels.

> I wonder if we consider this as a fix, thus expect any kernel newer than 5.4
> should backport all these 12 patches.

> Or, whether we should relax and just check if version is higher than the one
> which got it in stable/LTS (e.g. >= 5.4.276 || >= 5.10.217 ...). The question is
> also if enterprise distros will take this patchset.

> BTW We have in LTP functionality which points as a hint to kernel fixes. But
> it's usually a single commit. I might need to list all.

> Kind regards,
> Petr

> > Review comments welcome.

> > Chuck Lever (2):
> >   NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
> >   NFSD: Fix frame size warning in svc_export_parse()

> > Josef Bacik (10):
> >   sunrpc: don't change ->sv_stats if it doesn't exist
> >   nfsd: stop setting ->pg_stats for unused stats
> >   sunrpc: pass in the sv_stats struct through svc_create_pooled
> >   sunrpc: remove ->pg_stats from svc_program
> >   sunrpc: use the struct net as the svc proc private
> >   nfsd: rename NFSD_NET_* to NFSD_STATS_*
> >   nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
> >   nfsd: make all of the nfsd stats per-network namespace
> >   nfsd: remove nfsd_stats, make th_cnt a global counter
> >   nfsd: make svc_stat per-network namespace instead of global

> >  fs/lockd/svc.c             |  3 --
> >  fs/nfs/callback.c          |  3 --
> >  fs/nfsd/cache.h            |  2 -
> >  fs/nfsd/export.c           | 32 ++++++++++----
> >  fs/nfsd/export.h           |  4 +-
> >  fs/nfsd/netns.h            | 25 +++++++++--
> >  fs/nfsd/nfs4proc.c         |  6 +--
> >  fs/nfsd/nfs4state.c        |  3 +-
> >  fs/nfsd/nfscache.c         | 40 ++++-------------
> >  fs/nfsd/nfsctl.c           | 16 +++----
> >  fs/nfsd/nfsd.h             |  1 +
> >  fs/nfsd/nfsfh.c            |  3 +-
> >  fs/nfsd/nfssvc.c           | 14 +++---
> >  fs/nfsd/stats.c            | 54 ++++++++++-------------
> >  fs/nfsd/stats.h            | 88 ++++++++++++++------------------------
> >  fs/nfsd/vfs.c              |  6 ++-
> >  include/linux/sunrpc/svc.h |  5 ++-
> >  net/sunrpc/stats.c         |  2 +-
> >  net/sunrpc/svc.c           | 39 +++++++++++------
> >  19 files changed, 163 insertions(+), 183 deletions(-)


