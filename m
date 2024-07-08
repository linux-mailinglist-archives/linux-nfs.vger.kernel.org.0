Return-Path: <linux-nfs+bounces-4701-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FC8929B34
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 06:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2C51C20C5B
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 04:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C21B80B;
	Mon,  8 Jul 2024 04:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="buCTH80h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ue5Lz4L6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="buCTH80h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ue5Lz4L6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F20AD21;
	Mon,  8 Jul 2024 04:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720411368; cv=none; b=gwPLZ/++UI1LAM+NVRftOjP6jqjXeXBbFPe3+bzYc9khMDQ6PnrS3J9JyKoJyIlJ1ruhKglux+uku5SkiDp7NHTlZUrCpKBWngijvMKiELzfYlnrWpoa7j8hmY25/O8qcMn6kENveNVLBdJhcMjfBpt5CGZ0VaOyEZxjTUb0v1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720411368; c=relaxed/simple;
	bh=CKtVEJDeXjpBPTY4afSaL5c+FvnCh0fg4jOYNeCWwgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeX3enqc2fHY+7Yge+gtB7EIersY//UDxazl611Vui8DrYEoWyUR+142UYiK5WaHrWf7IehD+Ezw3YtBxFOdreBd9Mz9zbnzWucea0Od/rPlnjE4vCymx4f303uvyKuyzXQ/1Y7IFJ0CSSSDtkNmIXv1x7RA7hk8qh+DCZHjPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=buCTH80h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ue5Lz4L6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=buCTH80h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ue5Lz4L6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 564431FBBC;
	Mon,  8 Jul 2024 04:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720411364;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKtVEJDeXjpBPTY4afSaL5c+FvnCh0fg4jOYNeCWwgg=;
	b=buCTH80h+E6ZFcF72pZ5XVCbgNmfCJUCMXEEWyBorYrzMsEkbi7iakJZkpVQIh+70wwkTh
	7RscC0Mpxszng6CCkgGgy/ZMc4byAnp5PDPiuAQYYvhfqDGGFuypqudPtC0s9+ZfepO3fP
	FITPRaMN7CLexi5XftWFuqOcucxT9NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720411364;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKtVEJDeXjpBPTY4afSaL5c+FvnCh0fg4jOYNeCWwgg=;
	b=ue5Lz4L6dMTYN8hRQSV2zDkClpO2nTs0q2JMU/NPj021xgPssfsMr9ixuOUFELiOGd3vSt
	ynpcMEgMuYz8RbDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720411364;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKtVEJDeXjpBPTY4afSaL5c+FvnCh0fg4jOYNeCWwgg=;
	b=buCTH80h+E6ZFcF72pZ5XVCbgNmfCJUCMXEEWyBorYrzMsEkbi7iakJZkpVQIh+70wwkTh
	7RscC0Mpxszng6CCkgGgy/ZMc4byAnp5PDPiuAQYYvhfqDGGFuypqudPtC0s9+ZfepO3fP
	FITPRaMN7CLexi5XftWFuqOcucxT9NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720411364;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKtVEJDeXjpBPTY4afSaL5c+FvnCh0fg4jOYNeCWwgg=;
	b=ue5Lz4L6dMTYN8hRQSV2zDkClpO2nTs0q2JMU/NPj021xgPssfsMr9ixuOUFELiOGd3vSt
	ynpcMEgMuYz8RbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1759112FF6;
	Mon,  8 Jul 2024 04:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AdbfBORki2ZAVQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 08 Jul 2024 04:02:44 +0000
Date: Mon, 8 Jul 2024 06:02:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Calum Mackay <calum.mackay@oracle.com>,
	linux-stable <stable@vger.kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>,
	Avinesh Kumar <akumar@suse.de>, Neil Brown <neilb@suse.de>,
	Sherry Yang <sherry.yang@oracle.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Message-ID: <20240708040238.GA117694@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.50
X-Spam-Level: 

Hi all,


> > On Jul 2, 2024, at 6:55 PM, Calum Mackay <calum.mackay@oracle.com> wrote:

> > To clarify…

> > On 02/07/2024 5:54 pm, Calum Mackay wrote:
> >> hi Petr,
> >> I noticed your LTP patch [1][2] which adjusts the nfsstat01 test on v6.9 kernels, to account for Josef's changes [3], which restrict the NFS/RPC stats per-namespace.
> >> I see that Josef's changes were backported, as far back as longterm v5.4,

> > Sorry, that's not quite accurate.

> > Josef's NFS client changes were all backported from v6.9, as far as longterm v5.4.y:

> > 2057a48d0dd0 sunrpc: add a struct rpc_stats arg to rpc_create_args
> > d47151b79e32 nfs: expose /proc/net/sunrpc/nfs in net namespaces
> > 1548036ef120 nfs: make the rpc_stat per net namespace


> > Of Josef's NFS server changes, four were backported from v6.9 to v6.8:

> > 418b9687dece sunrpc: use the struct net as the svc proc private
> > d98416cc2154 nfsd: rename NFSD_NET_* to NFSD_STATS_*
> > 93483ac5fec6 nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
> > 4b14885411f7 nfsd: make all of the nfsd stats per-network namespace

> > and the others remained only in v6.9:

> > ab42f4d9a26f sunrpc: don't change ->sv_stats if it doesn't exist
> > a2214ed588fb nfsd: stop setting ->pg_stats for unused stats
> > f09432386766 sunrpc: pass in the sv_stats struct through svc_create_pooled
> > 3f6ef182f144 sunrpc: remove ->pg_stats from svc_program
> > e41ee44cc6a4 nfsd: remove nfsd_stats, make th_cnt a global counter
> > 16fb9808ab2c nfsd: make svc_stat per-network namespace instead of global



> > I'm wondering if this difference between NFS client, and NFS server, stat behaviour, across kernel versions, may perhaps cause some user confusion?

> As a refresher for the stable folken, Josef's changes make
> nfsstats silo'd, so they no longer show counts from the whole
> system, but only for NFS operations relating to the local net
> namespace. That is a surprising change for some users, tools,
> and testing.

> I'm not clear on whether there are any rules/guidelines around
> LTS backports causing behavior changes that user tools, like
> nfsstat, might be impacted by.

> The client-side nfsstat changes are fully backported to all
> TS kernels. But should they have been?

> The server-side nfsstat changes appear in only v6.9. Should
> they be backported to the other LTS kernels, or not?

First, thanks a lot for having a look into the issue.

It looks to me as a functional change, thus I would not backport
changes unless changes they are needed to be backported (part some larger fix).
Thus maybe revert?

And if backported, I would expect changes on both sides (client and server)
would be backported (not just server side).

Kind regards,
Petr

> >> so your check for kernel version "6.9" in the test may need to be adjusted, if LTP is intended to be run on stable kernels?
> >> best wishes,
> >> calum.
> >> [1] https://lore.kernel.org/ltp/20240620111129.594449-1-pvorel@suse.cz/
> >> [2] https://patchwork.ozlabs.org/project/ltp/ patch/20240620111129.594449-1-pvorel@suse.cz/
> >> [3] https://lore.kernel.org/linux-nfs/ cover.1708026931.git.josef@toxicpanda.com/

