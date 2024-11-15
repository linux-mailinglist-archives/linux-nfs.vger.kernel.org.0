Return-Path: <linux-nfs+bounces-7998-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F19CDB06
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 10:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E982128302D
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC48189B9C;
	Fri, 15 Nov 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oWaUBpmQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PVW8UEsx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oWaUBpmQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PVW8UEsx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6731898EA
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661394; cv=none; b=XZ1DH/B5Nl8SI09HbzAw1vLlHJWFEUTpMb7LoIiwpYT87NzAOJWKS3VxC/c9Tg2Nt8eHWU7oqyPeOso4Fkh6HPir5ZdmtyK963igmiONCuUPhbTaec/0C2LQFeNGWtUgeFfpWVSHfW9Wd8NM7PHYN1A664kN16Y4YoH0mjuSWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661394; c=relaxed/simple;
	bh=pf9NLn4U71/Q++Eth4tQlgL0GBmkn/PrOVncJ6T9T5g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VUbB+aGRibwQl3V9qPnGfnqQQv/MG9aVkfGVcD3Ks808moW5cekvvQF0cGarbZIHbnodewrhnFS2m0zA1HMqu6uG4b0uHO58/3bTz9im4Q9ZzAeqyJsiBgH8uGkwdjMDQvxxY5R0e3FcT2MYmi5/uowzSmabXmhXUSNgqO81tdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oWaUBpmQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PVW8UEsx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oWaUBpmQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PVW8UEsx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABCC921234;
	Fri, 15 Nov 2024 09:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731661390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLj4S+KCM8/+PisFrLOFsMkCFo7xWRHzebCOmeSsTfM=;
	b=oWaUBpmQjTp6aAclhld/0+Y3nz8UzPS9D17pl/P6Vi0cNNvEuT23W2AvW93IcQo60uAaWO
	a/HyLY3sATvnUzBzLOchtNbgM86Va27840bWobHV09I+RsCU0H2gevxFXADxFsGt8ABDJX
	iTF2x+w76yMOiknVA/sZ4EWfNvYsro8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731661390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLj4S+KCM8/+PisFrLOFsMkCFo7xWRHzebCOmeSsTfM=;
	b=PVW8UEsxNKCpezjzTpOwXe+Tcgs4irLdc/k2Iil+85v1fhczmD6hUYJ9j28iNAQKk5Fs+A
	4iK1CgCXWWUqGTCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731661390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLj4S+KCM8/+PisFrLOFsMkCFo7xWRHzebCOmeSsTfM=;
	b=oWaUBpmQjTp6aAclhld/0+Y3nz8UzPS9D17pl/P6Vi0cNNvEuT23W2AvW93IcQo60uAaWO
	a/HyLY3sATvnUzBzLOchtNbgM86Va27840bWobHV09I+RsCU0H2gevxFXADxFsGt8ABDJX
	iTF2x+w76yMOiknVA/sZ4EWfNvYsro8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731661390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLj4S+KCM8/+PisFrLOFsMkCFo7xWRHzebCOmeSsTfM=;
	b=PVW8UEsxNKCpezjzTpOwXe+Tcgs4irLdc/k2Iil+85v1fhczmD6hUYJ9j28iNAQKk5Fs+A
	4iK1CgCXWWUqGTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DF5213485;
	Fri, 15 Nov 2024 09:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vs0AFUwON2dAOwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Nov 2024 09:03:08 +0000
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
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 0/4 RFC] nfsd: allocate/free session-based DRC slots on demand
In-reply-to: <03805410-2951-4BF8-BAA5-544F896E6DA2@oracle.com>
References: <20241113055345.494856-1-neilb@suse.de>,
 <03805410-2951-4BF8-BAA5-544F896E6DA2@oracle.com>
Date: Fri, 15 Nov 2024 20:03:00 +1100
Message-id: <173166138079.1734440.6966732313020344490@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 14 Nov 2024, Chuck Lever III wrote:
> 
> 
> > On Nov 13, 2024, at 12:38 AM, NeilBrown <neilb@suse.de> wrote:
> > 
> > This patch set aims to allocate session-based DRC slots on demand, and
> > free them when not in use, or when memory is tight.
> > 
> > I've tested with NFSD_MAX_UNUSED_SLOTS set to 1 so that freeing is
> > overly agreesive, and with lots of printks, and it seems to do the right
> > thing, though memory pressure has never freed anything - I think you
> > need several clients with a non-trivial number of slots allocated before
> > the thresholds in the shrinker code will trigger any freeing.
> 
> Can you describe your test set-up? Generally a system
> with less than 4GB of memory can trigger shrinkers
> pretty easily.
> 
> If we never see the mechanism being triggered due to
> memory exhaustion, then I wonder if the additional
> complexity is adding substantial value.

Just a single VM with 1G RAM.  Only one client so only one session.
The default batch count for shrinkers is 64 and the reported count of
freeable items is normally scaled down a lot until memory gets really
tight.  So if I only have 6 slots that could be freed the shrinker isn't
going to notice.
I set ->batch to 2 and ->seeks to 0 and the shrinker started freeing
things.  This allowed me to see some bugs.

One that I haven't resolved yet is the need to wait to get confirmation
from the client before rejecting requests with larger numbered slots.

> 
> 
> > I haven't made use of the CB_RECALL_SLOT callback.  I'm not sure how
> > useful that is.  There are certainly cases where simply setting the
> > target in a SEQUENCE reply might not be enough, but I doubt they are
> > very common.  You would need a session to be completely idle, with the
> > last request received on it indicating that lots of slots were still in
> > use.
> > 
> > Currently we allocate slots one at a time when the last available slot
> > was used by the client, and only if a NOWAIT allocation can succeed.  It
> > is possible that this isn't quite agreesive enough.  When performing a
> > lot of writeback it can be useful to have lots of slots, but memory
> > pressure is also likely to build up on the server so GFP_NOWAIT is likely
> > to fail.  Maybe occasionally using a firmer request (outside the
> > spinlock) would be justified.
> 
> I'm wondering why GFP_NOWAIT is used here, and I admit
> I'm not strongly familiar with the code or mechanism.
> Why not always use GFP_KERNEL ?

Partly because the kmalloc call is under a spinlock, so we cannot wait. 
But that could be changed with a bit of work.

GFP_KERNEL can block indefinitely, and we don't actually need the
allocation to succeed to satisfy the current request, so it seems wrong
to block at all when we don't need to.

I'm hoping that GFP_NOWAIT will succeed often enough that the slot table
will grow when there is demand - maybe not instantly but not too slowly.
If GFP_NOWAIT doesn't succeed, then reclaim will be happening and the
shrinker will probably ask us to return some slots soon - maybe it isn't
worth trying hard to allocate something we will have to return soon.

> 
> 
> > We free slots when the number of unused slots passes some threshold -
> > currently 6 (because ...  why not).  Possible a hysteresis should be
> > added so we don't free unused slots for a least N seconds.
> 
> Generally freeing unused resources is un-Linux like. :-)
> Can you provide a rationale for why this is needed?

Uhm...  No.  I added it so that patch which adds slot retirement could do
something useful before the shrinker was added, and when I added the
shrinker I couldn't bring myself to remove it.  Probably I should.


Thanks for your thoughtful review.

NeilBrown

> 
> 
> > When the shrinker wants to apply presure we remove slots equally from
> > all sessions.  Maybe there should be some proportionality but that would
> > be more complex and I'm not sure it would gain much.  Slot 0 can never
> > be freed of course.
> > 
> > I'm very interested to see what people think of the over-all approach,
> > and of the specifics of the code.
> > 
> > Thanks,
> > NeilBrown
> > 
> > 
> > [PATCH 1/4] nfsd: remove artificial limits on the session-based DRC
> > [PATCH 2/4] nfsd: allocate new session-based DRC slots on demand.
> > [PATCH 3/4] nfsd: free unused session-DRC slots
> > [PATCH 4/4] nfsd: add shrinker to reduce number of slots allocated
> > 
> 
> --
> Chuck Lever
> 
> 
> 


