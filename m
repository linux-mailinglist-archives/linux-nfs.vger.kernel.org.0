Return-Path: <linux-nfs+bounces-9994-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E70FBA2E16C
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 00:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7D01885F37
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 23:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3871F146A60;
	Sun,  9 Feb 2025 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="acDk58Ra";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XHuodVzK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="acDk58Ra";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XHuodVzK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2C8248C
	for <linux-nfs@vger.kernel.org>; Sun,  9 Feb 2025 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739142995; cv=none; b=AZTkjzs2MQR9UlZIvA+5hms2i7ScK3RQit7lAOXmkTiAT1GQccAL/RxdQ86GdFmKp+0KdUtfCe2j6F++oTgKikc+2uz7I5ISdD1B9ZN/W2OcE9N1/OIf2P+E1/jEaj8VRr1PDTeY6UIh7MUPsboVLaZQgZsRMzTIvZ7q0AsHQpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739142995; c=relaxed/simple;
	bh=AdN3savS0V0GbKHOM+ZmNOtThnXgkraqdPRXbYIbVaA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=KlQtpWE/7isY01CAHxjJ49cngx67kSPUJMOtTEhsp+am8gGdg0LSqUmgGz8zVMopNh+I6ZCfoxUsCNdlG0uQyxaLRRDRAfMStXNrQEyqiFU6XP8jfiZTaFWBn4N/Dj3WbIRLOu/Hld52QfkTtCS3XQ5HDNcejvUsuyDlG5N72aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=acDk58Ra; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XHuodVzK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=acDk58Ra; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XHuodVzK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F9C9210F5;
	Sun,  9 Feb 2025 23:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739142991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QL57dmrKdCsmxDrJyraW4VjyYVeDd1gSG6IkzWXdXZg=;
	b=acDk58Ralc5qnSF17OI5LMiZe0p9EqycTYPIo1FSXf7+EcXZo9XjZYBXDziMZP44U6e9e0
	gJ5s2fvFa6wU2TLHwZ8bUnsP+m3e8WyD8mzifCPGa5czxfTeU/FPWbzeXI0J5kRGertHtt
	10kdSms0hWfcueRUMMSc44o5xQwMJ/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739142991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QL57dmrKdCsmxDrJyraW4VjyYVeDd1gSG6IkzWXdXZg=;
	b=XHuodVzK0xvG9rDwDEXJcNTTdwLsyPITjgdGOJUKlG6eEnhbVQTsWDvaIeCrI2JfUAFTtP
	vtHqbwbMpGPByeBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739142991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QL57dmrKdCsmxDrJyraW4VjyYVeDd1gSG6IkzWXdXZg=;
	b=acDk58Ralc5qnSF17OI5LMiZe0p9EqycTYPIo1FSXf7+EcXZo9XjZYBXDziMZP44U6e9e0
	gJ5s2fvFa6wU2TLHwZ8bUnsP+m3e8WyD8mzifCPGa5czxfTeU/FPWbzeXI0J5kRGertHtt
	10kdSms0hWfcueRUMMSc44o5xQwMJ/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739142991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QL57dmrKdCsmxDrJyraW4VjyYVeDd1gSG6IkzWXdXZg=;
	b=XHuodVzK0xvG9rDwDEXJcNTTdwLsyPITjgdGOJUKlG6eEnhbVQTsWDvaIeCrI2JfUAFTtP
	vtHqbwbMpGPByeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2718013796;
	Sun,  9 Feb 2025 23:16:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 16r0Mkw3qWcIFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 09 Feb 2025 23:16:28 +0000
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
 "Tom Talpey" <tom@talpey.com>, "Dave Chinner" <david@fromorbit.com>
Subject:
 Re: [PATCH 3/6] nfsd: filecache: use list_lru_walk_node() in nfsd_file_gc()
In-reply-to: <fb5deaea-0ffe-4f66-9757-7c38934b4c29@oracle.com>
References: <>, <fb5deaea-0ffe-4f66-9757-7c38934b4c29@oracle.com>
Date: Mon, 10 Feb 2025 10:16:25 +1100
Message-id: <173914298570.22054.3572951182274613622@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, 08 Feb 2025, Chuck Lever wrote:
> On 2/7/25 12:15 AM, NeilBrown wrote:
> > list_lru_walk() is only useful when the aim is to remove all elements
> > from the list_lru.
> 
> I think I get where this is going. Can the description cite some API
> documentation that comports with this claim?

That would require someone to write some documentation, because there
isn't any - not for list_lru_walk().  I wouldn't recommend writing any
either.  It should be replaced with something with a name like
"list_lru_destroy()" which is given a list_lru_ and a callback (no
count).  The callback can skip or isolate or if the disposal list gets
lock, drop the lock, dispose the lists, and return LRU_RETRY.


> 
> 
> > It will repeated visit rotated element of the first
> > per-node sublist before proceeding to subsrequent sublists.
> 
> s/repeated/repeatedly, s/element/elements, and s/subsrequent/subsequent.
> 

Yep.


> 
> > This patch changes to use list_lru_walk_node() and list_lru_count_node()
> > on each individual node.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/filecache.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 7dc20143c854..04588c03bdfe 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -532,10 +532,14 @@ static void
> >  nfsd_file_gc(void)
> >  {
> >  	LIST_HEAD(dispose);
> > -	unsigned long ret;
> > +	unsigned long ret = 0;
> > +	int nid;
> >  
> > -	ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> > -			    &dispose, list_lru_count(&nfsd_file_lru));
> > +	for_each_node_state(nid, N_NORMAL_MEMORY) {
> > +		unsigned long nr = list_lru_count_node(&nfsd_file_lru, nid);
> > +		ret += list_lru_walk_node(&nfsd_file_lru, nid, nfsd_file_lru_cb,
> > +					  &dispose, &nr);
> > +	}
> >  	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> 
> Nit: Maybe this trace point should be placed in the loop and changed to
> record the nid as well?

Maybe.

> 
> 
> >  	nfsd_file_dispose_list_delayed(&dispose);
> 
> Wondering if maybe the nfsd_file_dispose_list_delayed() call should also
> be moved inside the for loop to break up the disposal processing per
> node as well.
> 

I don't think it would make much difference.  The "disposal" here is
just moving the items onto different lists.

NeilBrown

> 
> >  }
> 
> 
> -- 
> Chuck Lever
> 


