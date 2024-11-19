Return-Path: <linux-nfs+bounces-8139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4909D309F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 23:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D556E1F22D1E
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 22:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265D1D0B95;
	Tue, 19 Nov 2024 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zLo0/Wsj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Oq60bi4L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zLo0/Wsj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Oq60bi4L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831DC1C2DA2
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732056115; cv=none; b=Ep4X+k/rSilAhF8a7zp9YcuQFqz+AySDzXlrm33sZtb+KiODcsg+KsFkDGKVXEPBSi7lfyFWps3Clip2c+ID0Zr3+3/b9Xy2Wtn575pqCeXSxCx+iJkPa0zU1Hdx0MugL9QfLJW6rtSBelZAHTeM81oAxSSVce46ONGvqA5GWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732056115; c=relaxed/simple;
	bh=kKQMJ3BdRFrIrsPsB9u6+i3lzpwMJt+qffeHVNqeR1E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=CA2wiY5bEZKWY3kEALD96ZkxFOsBmtVDhfZVSL+/cnD0FnUckSzmcJp8kJN2u8tGQQAaOBttzpTiJNR/4tcSBEG7s2fYzbqIcjwGzGqtVcxiw1v1Vg7rosKT8wl1rjpqrzf1Ts0EoAbaZvrpCUVhe3niXRW5VbnMoH4wA+vdx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zLo0/Wsj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Oq60bi4L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zLo0/Wsj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Oq60bi4L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86B74219F9;
	Tue, 19 Nov 2024 22:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732056111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCkPbybHzFWX0gLHLOv5mpI6TBGRTXJyEdetONWYRXY=;
	b=zLo0/WsjkOzveOxax6oVdTj+Zu3OJjM5NSQqvNMx6tiC6szIw2okvha2EBTBKy9wJjhsRj
	l3PRvzzyZWx8lmAZjlS/+xXy2jgK6ebbWe805nUml9lI19IftUfE0LYh/CdYX1qIiZ+YRv
	D+GBGantzKutZQ21wp23J3+P3IEyaUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732056111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCkPbybHzFWX0gLHLOv5mpI6TBGRTXJyEdetONWYRXY=;
	b=Oq60bi4LrFsvuY9lBnzHCslpDpwpCHeFx/m5yoMwB3RTvDM5m07l9HQO9WdRME/GOquScr
	HI0fuvnDdUH/TFBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="zLo0/Wsj";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Oq60bi4L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732056111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCkPbybHzFWX0gLHLOv5mpI6TBGRTXJyEdetONWYRXY=;
	b=zLo0/WsjkOzveOxax6oVdTj+Zu3OJjM5NSQqvNMx6tiC6szIw2okvha2EBTBKy9wJjhsRj
	l3PRvzzyZWx8lmAZjlS/+xXy2jgK6ebbWe805nUml9lI19IftUfE0LYh/CdYX1qIiZ+YRv
	D+GBGantzKutZQ21wp23J3+P3IEyaUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732056111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCkPbybHzFWX0gLHLOv5mpI6TBGRTXJyEdetONWYRXY=;
	b=Oq60bi4LrFsvuY9lBnzHCslpDpwpCHeFx/m5yoMwB3RTvDM5m07l9HQO9WdRME/GOquScr
	HI0fuvnDdUH/TFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 840581376E;
	Tue, 19 Nov 2024 22:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XCJaDy0UPWd3IQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 22:41:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 6/6] nfsd: add shrinker to reduce number of slots
 allocated per session
In-reply-to: <Zzzm89G4XI2CdRfe@tissot.1015granger.net>
References: <>, <Zzzm89G4XI2CdRfe@tissot.1015granger.net>
Date: Wed, 20 Nov 2024 09:41:46 +1100
Message-id: <173205610669.1734440.5605667912838732633@noble.neil.brown.name>
X-Rspamd-Queue-Id: 86B74219F9
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 20 Nov 2024, Chuck Lever wrote:
> On Tue, Nov 19, 2024 at 11:41:33AM +1100, NeilBrown wrote:
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index ea6659d52be2..0e320ba097f2 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -345,6 +345,7 @@ struct nfsd4_session {
> >  	bool			se_dead;
> >  	struct list_head	se_hash;	/* hash by sessionid */
> >  	struct list_head	se_perclnt;
> > +	struct list_head	se_all_sessions;/* global list of sessions */
> 
> I think my only minor issue here is whether we truly want an
> "all_sessions" list. Since we don't expect the shrinker to run very
> often, isn't there another mechanism that can already iterate all
> clients and their sessions?

"all_sessions" certainly isn't my favourite part of the set.
But I do think we need it.

We can iterate all sessions by iterating all net-namespaces, then all
clients, then all sessions.  But that isn't what we need.

The shrinker mechanism seems to assume an LRU.  It makes "scan" requests
one "batch" at a time, and may request several batches in sequence
without telling you in advance how many batches to expect.  So you need
some concept of the "next" thing to free.  Often this is the end of the
LRU.
But we don't have an LRU because the slots aren't a cache.

An important detail is that when nfsd_slot_scan() has scanned all that
it was asked, it moves the head to the current point in the list.  So
the next time it is called it will start with the correct next session.

This will only become important where there are more than 64 (default
batch size) sessions.

NeilBrown


> 
> 
> >  	struct nfs4_client	*se_client;
> >  	struct nfs4_sessionid	se_sessionid;
> >  	struct nfsd4_channel_attrs se_fchannel;
> > -- 
> > 2.47.0
> > 
> 
> -- 
> Chuck Lever
> 


