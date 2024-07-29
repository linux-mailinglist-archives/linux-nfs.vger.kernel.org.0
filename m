Return-Path: <linux-nfs+bounces-5190-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E8F9401AC
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 01:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF9AB22110
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 23:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1D57441F;
	Mon, 29 Jul 2024 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w55SL16W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mtrJC9/N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w55SL16W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mtrJC9/N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37F288BD
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722295070; cv=none; b=WJ5efq5yFISqYewFnnk7oJcuiUaRzZUuXntzNK2VO252Pps1NLV3IGdzHHPdxZ9biRkvNd7nRnkG4jhHvJpK2hSZEc21i3f8oazagijX4fD0nLKUmMqp7uS2JS98QtOWuz29ZKKiJyHzuQpe08BobpLA3QMvTaoVtVBEwi+nP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722295070; c=relaxed/simple;
	bh=GOrZAZ77rxR83W8LBPBhTki1BbZpQGkv9SWCitLlsF0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HrbYsvxcCrsWXpVAc3AlsMIBjB63/Sxudxtg3mFCK6V0yjrZuLr3pVsYszozBHjVmiD1rsqTVXhgjibJJNGgQE/BK4x5LXKX1ua0W1na1zGYHmpajnZlF0DhQURa+13m7uU0rQOz0vypgKoeMTw9QUbR2GaNufPghgWXA/TvvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w55SL16W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mtrJC9/N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w55SL16W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mtrJC9/N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4214B219A0;
	Mon, 29 Jul 2024 23:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722295067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2J57tFsV6iYNt4mZ6u73q0vhFFgngHgRYreZB+vRPc=;
	b=w55SL16WpdHkKQER/QqqAT9HC2GjPpWQdYh5cyH/Iw1J3RPkQ7krmPVUfJCfhN3GcGlG8m
	Ya/caOSgNnz5poCexlkJucZc6LjsXNrq5Eh7vq2SWavTiH2JEeTDR9dRt2WuPJT4pCgGCX
	wUWuGxtRv0/fFAdryQXLr2vVpIOr+4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722295067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2J57tFsV6iYNt4mZ6u73q0vhFFgngHgRYreZB+vRPc=;
	b=mtrJC9/NCiUhdwDaHNMtecqpjgUlEHOw+xXp9iFZ5smGwcu+iOxKZpDrPEa9npPkrGcF/b
	mj+xDZu3thLbieDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722295067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2J57tFsV6iYNt4mZ6u73q0vhFFgngHgRYreZB+vRPc=;
	b=w55SL16WpdHkKQER/QqqAT9HC2GjPpWQdYh5cyH/Iw1J3RPkQ7krmPVUfJCfhN3GcGlG8m
	Ya/caOSgNnz5poCexlkJucZc6LjsXNrq5Eh7vq2SWavTiH2JEeTDR9dRt2WuPJT4pCgGCX
	wUWuGxtRv0/fFAdryQXLr2vVpIOr+4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722295067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2J57tFsV6iYNt4mZ6u73q0vhFFgngHgRYreZB+vRPc=;
	b=mtrJC9/NCiUhdwDaHNMtecqpjgUlEHOw+xXp9iFZ5smGwcu+iOxKZpDrPEa9npPkrGcF/b
	mj+xDZu3thLbieDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16D6F138A7;
	Mon, 29 Jul 2024 23:17:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BRXPLhgjqGYMcwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jul 2024 23:17:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 0/2] nfsd: fix handling of error from unshare_fs_struct()
In-reply-to: <363EC622-AFCA-4A01-AB81-822C5D2004F2@oracle.com>
References: <>, <363EC622-AFCA-4A01-AB81-822C5D2004F2@oracle.com>
Date: Tue, 30 Jul 2024 09:17:41 +1000
Message-id: <172229506177.31176.7805096304491883717@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.10

On Tue, 30 Jul 2024, Chuck Lever III wrote:
> 
> 
> > On Jul 29, 2024, at 5:07 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> 
> > (and if you could delete "for-next" from there, and possibly other old
> > cruft, that might help too)
> 
> I'm looking at the list of branches, and I don't see a for-next
> in the cel git repo. The only branches I can see are:
> 
> nfsd-next
> nfsd-6.1.y
> nfsd-testing
> master
> nfsd-5.10.y
> nfsd-5.15.y
> nfsd-fixes
> exportfs-next
> topic-xdr-tracepoints
> topic-rdma-fault-injection
> 
> 
> I've been deleting old tags as I notice them, but "git push :branch"
> doesn't always seem to work against git.kernel.org.


Ahh...  "git fetch" does discard branched that have been deleted
remotely.
I need
   git remote prune $remote
or to set remote.$remote.prune to true

Thanks,
NeilBrown

