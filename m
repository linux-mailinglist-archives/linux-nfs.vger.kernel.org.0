Return-Path: <linux-nfs+bounces-4045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B54C90E28C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 07:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2172C1F235B1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 05:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DF64F5EC;
	Wed, 19 Jun 2024 05:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cmFFFVbu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2Vpiplkv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cmFFFVbu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2Vpiplkv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C924654D
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 05:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718773488; cv=none; b=K+/lbRIkaiy39/0LMBIjRtHcCrAZEeJZ/uL6uXxw6cRXm+qP1X5pOIHoDWn0ZgkvnPBumQWO5zx+Ts13POPf4gPNyMzyd/1uE+tkdXJHbnmh7EwsBinBUGZeU8OhIUn1rUX4CEQfRF8BpgoxFYw6KPJzW4q0TSnfWIciorIAYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718773488; c=relaxed/simple;
	bh=0pPj4PFJKyggnYhypv1WZJWoxr092vyVK2sMNLFb1tI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PJhmmWtcx7rso/Lgg9tGFT5IvTk+akvvTJlJ7+hcPujC/B9Hd5n08gE1BtTZnswP5l/H/8/A7kMq8/nPiVU0ipqDsc16XjzshXEB8NOA0zdk2fwtTLtTC8A0Xrr9HPnfsGCQvGUjDMURphZjcR0gBS5mmOAGwIsYJyJzvvIt0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cmFFFVbu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2Vpiplkv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cmFFFVbu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2Vpiplkv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E888219E5;
	Wed, 19 Jun 2024 05:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718773484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nVpQKG6OH4CF7TJntzaP5CFBTdktkBDkQbLE0+gDVY=;
	b=cmFFFVbu9l/BGDPrZup5moGhzQELRF+fFAo0wN7NxD+IYuVaUPURLaQQLsonaX//U2xOJS
	kbF7WX1FocNG3CFuWcYpa/pyOncN8IrOofwfyP+dqzmuMeJZ7iXcpxA+FSmxA+RSGMKLsF
	SWQAbSJuWLOPtNMg+zDpcxgqoj4G7gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718773484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nVpQKG6OH4CF7TJntzaP5CFBTdktkBDkQbLE0+gDVY=;
	b=2Vpiplkv77h1Ls2TC7juf/z1b9kUjdeFxpQ54ubBwPBPnPHUFJCplQyPtb+hRRv1n0j2Au
	no/OS0MKmGC75EDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718773484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nVpQKG6OH4CF7TJntzaP5CFBTdktkBDkQbLE0+gDVY=;
	b=cmFFFVbu9l/BGDPrZup5moGhzQELRF+fFAo0wN7NxD+IYuVaUPURLaQQLsonaX//U2xOJS
	kbF7WX1FocNG3CFuWcYpa/pyOncN8IrOofwfyP+dqzmuMeJZ7iXcpxA+FSmxA+RSGMKLsF
	SWQAbSJuWLOPtNMg+zDpcxgqoj4G7gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718773484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nVpQKG6OH4CF7TJntzaP5CFBTdktkBDkQbLE0+gDVY=;
	b=2Vpiplkv77h1Ls2TC7juf/z1b9kUjdeFxpQ54ubBwPBPnPHUFJCplQyPtb+hRRv1n0j2Au
	no/OS0MKmGC75EDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E405113AAF;
	Wed, 19 Jun 2024 05:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CcPkIelmcmayYQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Jun 2024 05:04:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v5 05/19] nfs_common: add NFS LOCALIO protocol extension
 enablement
In-reply-to: <20240618201949.81977-6-snitzer@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>,
 <20240618201949.81977-6-snitzer@kernel.org>
Date: Wed, 19 Jun 2024 15:04:37 +1000
Message-id: <171877347768.14261.14456680724471133597@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Wed, 19 Jun 2024, Mike Snitzer wrote:
> First use is in nfsd, to add access to a global nfsd_uuids list that
> will be used to identify local nfsd instances.
> 
> nfsd_uuids is protected by nfsd_mutex or RCU read lock.  List is
> composed of nfsd_uuid_t instances that are managed as nfsd creates
> them (per network namespace).
> 
> nfsd_uuid_is_local() will be used to search all local nfsd for the
> client specified nfsd uuid.
> 

> +
> +bool nfsd_uuid_is_local(const uuid_t *uuid)
> +{
> +	const uuid_t *nfsd_uuid;
> +
> +	rcu_read_lock();
> +	nfsd_uuid = nfsd_uuid_lookup(uuid);
> +	rcu_read_unlock();
> +
> +	return !uuid_is_null(nfsd_uuid);

This uuid_is_null() test needs to be inside rcu_read_lock()ed region, or
it could deref a freed pointer.

But this seems to be a good place in the series to propose a bigger
change.

I think that every fs that is communicating with a localio server should
be registered with nfs_common even if that server isn't presently local.
On each IO it should check if the server is actually local, and act
accordingly.  This might mean an extra pointer-deref but if that is
deemed a problem I'm sure we can find a solution.

Imagine an NFS server cluster where the server instances can migrate
around the cluster.  Imagine there are also client side mounts on nodes
in this cluster.  At any point a server might migrate onto a node which
is also a client of that server.  We have customers who do this and for
that reason we make sure that loop-back mounts work and don't hit memory
deadlocks.

It would be good if these configurations could set the uuid for each
server instance and have it follow the server when it is migrated.  So
if the server suddenly becomes local, we get to bypass the network code
for all IO.

Each uuid registered with nfs_common could be possibly linked to a
server, and to zero or more struct nfs_clients.  When the server
registration changes, we walk the list of clients and tell them about
the change.

We could certainly add that functionality later if there seems to be too
much change already, but I think it would be good to add at some stage,
and maybe now is the right time.

Thanks,
NeilBrown

