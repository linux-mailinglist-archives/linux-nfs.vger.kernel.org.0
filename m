Return-Path: <linux-nfs+bounces-3679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25019049DA
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 06:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644052834E8
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 04:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48731E531;
	Wed, 12 Jun 2024 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rkZrphlQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Izeq1nxx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rkZrphlQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Izeq1nxx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1108257D
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 04:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718165381; cv=none; b=DgxJZJ7ipBMhHSxjWSwQ/TrMu17olfmP+5cyGJFb4nKbkKqoe6mGcYk7AMlsMasZ/y9sIG+TGuUKZ8tVpmwdueLIg/SVgo0s5p77J6IgELcgapE5PT6SHdVizEPdvs4/DFYaOA6pcWaF0FkSye495TVWU9w09mY/8iqv6L0NQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718165381; c=relaxed/simple;
	bh=+vyoRxc81P3qAUdScyNzpIQYvYyYQmqU2HAZnuVLoig=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TwBqWTzvSz1ouihDL7t9TRdDp72WANMJj4l07oDkb4OYY4xSM2uHNFxB2JiISNTZBuBUBcoj34U3QzEsmXKxo/QYeT+AZ3LYKFFj/+UTgw85a2GjLmrMbPhbfBIL0VncXtzd3XXltsHx9eHfA/ZgJ/Ua7Bwxp9o9xCmXczyUkSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rkZrphlQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Izeq1nxx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rkZrphlQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Izeq1nxx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5249533E2D;
	Wed, 12 Jun 2024 04:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718165372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4XPE8iNSYS4vhtjWSJW7vHN0xxppyEb9RiC68XEJx8=;
	b=rkZrphlQnBHSXaWO3gWl7rnHsMg0goYS4fb8eCah7s4N03cvQ0ab8TCLetuB65J8Li2CMf
	iktjEvKGlgAokLdr4lN0EAhGhu0MSIVv2InZEN404isACxhbKBFaJkhEJ9TpsHASJlG03Z
	PYJwO+43URDpICJCOn1SjLF+LwMwAoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718165372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4XPE8iNSYS4vhtjWSJW7vHN0xxppyEb9RiC68XEJx8=;
	b=Izeq1nxxNsFw0qn620OaCDNQxoriFUCInLToJCpCo+iwO53JjMERYH9hsOiGz4wSoaWvPj
	dMiiSg9hqtkSEACg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rkZrphlQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Izeq1nxx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718165372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4XPE8iNSYS4vhtjWSJW7vHN0xxppyEb9RiC68XEJx8=;
	b=rkZrphlQnBHSXaWO3gWl7rnHsMg0goYS4fb8eCah7s4N03cvQ0ab8TCLetuB65J8Li2CMf
	iktjEvKGlgAokLdr4lN0EAhGhu0MSIVv2InZEN404isACxhbKBFaJkhEJ9TpsHASJlG03Z
	PYJwO+43URDpICJCOn1SjLF+LwMwAoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718165372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4XPE8iNSYS4vhtjWSJW7vHN0xxppyEb9RiC68XEJx8=;
	b=Izeq1nxxNsFw0qn620OaCDNQxoriFUCInLToJCpCo+iwO53JjMERYH9hsOiGz4wSoaWvPj
	dMiiSg9hqtkSEACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADEA413AA4;
	Wed, 12 Jun 2024 04:09:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mMMzFHkfaWY2GgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 04:09:29 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 10/29] nfs/nfsd: add "local io" support
In-reply-to: <ZmkZAJtd3MhlXM7O@kernel.org>
References: <>, <ZmkZAJtd3MhlXM7O@kernel.org>
Date: Wed, 12 Jun 2024 14:09:21 +1000
Message-id: <171816536144.14261.4040713092050012288@noble.neil.brown.name>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5249533E2D
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Wed, 12 Jun 2024, Mike Snitzer wrote:
> On Wed, Jun 12, 2024 at 01:17:05PM +1000, NeilBrown wrote:
> > On Wed, 12 Jun 2024, Mike Snitzer wrote:
> > > 
> > > SO I looked, and I'm saddened to see Neil's 6.8 commit 1e3577a4521e
> > > ("SUNRPC: discard sv_refcnt, and svc_get/svc_put").
> > > 
> > > [the lack of useful refcounting with the current code kind of blew me
> > > away.. but nice to see it existed not too long ago.]
> > > 
> > > Rather than immediately invest the effort to revert commit
> > > 1e3577a4521e for my apparent needs... I'll send out v2 to allow for
> > > further review and discussion.
> > > 
> > > But it really does feel like I _need_ svc_{get,put} and nfsd_{get,put}
> > 
> > You are taking a reference, and at the right time.  But it is to the
> > wrong thing.
> 
> Well, that reference is to ensure nfsd (and nfsd_open_local_fh) is
> available for the duration of a local client connected to it.
> 
> Really wasn't trying to keep nn->nfsd_serv around with this ;)
> 
> > You call symbol_request(nfsd_open_local_fh) and so get a reference to
> > the nfsd module.  But you really want a reference to the nfsd service.
> > 
> > I would suggest that you use symbol_request() to get a function which
> > you then call and immediately symbol_put().... unless you need to use it
> > to discard the reference to the service later.
> 
> Getting the nfsd_open_local_fh symbol once when client handshakes with
> server is meant to avoid needing to do so for every IO the client
> issues to the local server.
> 
> > The function would take nfsd_mutex, check there is an nfsd_serv, sets a
> > flag or whatever to indicate the serv is being used for local_io, and
> > maybe returns the nfsd_serv.  As long as that flag is set the serv
> > cannot be destroy.
> >
> > Do you need there to be available threads for LOCAL_IO to work?  If so
> > the flag would cause setting the num threads to zero to fail.
> > If not ....  that is weird.  It would mean that setting the number of
> > threads to zero would not destroy the service and I don't think we want
> > to do that.
> > 
> > So I think that when LOCAL_IO is in use, setting number of threads to
> > zero must return EBUSY or similar, even if you don't need the threads.
> 
> Yes, but I really dislike needing to play games with a tangential
> characteristic of nfsd_serv (that threads are what hold reference),
> rather than have the ability to keep the nfsd_serv around in a cleaner
> way.
> 
> This localio code doesn't run in nfsd context so it isn't using nfsd's
> threads. Forcing threads to be held in reserve because localio doesn't
> want nfsd_serv to go away isn't ideal.

I started reading the rest of the patches and it seems that localio is
only used for READ, WRTE, COMMIT.  Is that correct?  Is there
documentation so that I don't have to ask?
Obviously there are lots of other NFS requests so you wouldn't be able
to use localio without nfsd threads running....

But a normal remote client doesn't pin the nfsd threads or the
nfsd_serv.  If the threads go away, the client blocks until the service
comes back.  Would that be appropriate semantics for localio??  i.e.  on
each nfsd_open_local_fh() call you mutex_trylock and hold that long
enough to get the 'struct file *'.  If it fails because there is no
serv, you simply fall-back to the same path you use for other requests.

Could that work?

> 
> Does it maybe make sense to introduce a more narrow svc_get/svc_put
> for this auxillary usecase?

I don't think so.  nfsd is a self-contained transactional service.  It
doesn't promise to persist beyond each transaction.
Current transactions return status and/or data.  Adding a new transaction
that returns a 'struct file *' fits that model reasonable well.  Taking
an external reference to the nfs service is quite a big conceptual
change.

Thanks,
NeilBrown


> 
> Thanks,
> Mike
> 


