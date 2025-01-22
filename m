Return-Path: <linux-nfs+bounces-9507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8FDA19AC2
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 23:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB6A165856
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 22:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EAE1C461F;
	Wed, 22 Jan 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1VAnYRBr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NB6Ume0B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1VAnYRBr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NB6Ume0B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68394C9F
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584183; cv=none; b=Ghutj+J+XCiE+b8OeQPHyqL0LZ3kDNsjFqT4WM9HwDBzPefBEfo75cBngKoZTp/iqjNLDfqZEcu9ykQXpMMFnXo6YitDNntTix2Wv26b3uA528g0IFkDNeSdWOP8AIPwsCG2lz/e/+lfIXciYHthHkRS/9+QAMbxLwwrYLLeLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584183; c=relaxed/simple;
	bh=SOnkSXQnsJMIp4y0UQakeLZXcqWSiX9OGBiKc1qtBkk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PUwablau/xFf2PyihC4NuCYX5bQ2gt4T9pSjgUG2iRQ1OtK+3/va5jszglF6+tdOny6csq2TEzVXx+/LAXZnCwdW8+vxq8Xa8LE9ZJ/wRR2eVw9jZ3lDeJs9bVaMhKwkS7Pl2Z3YaOG8WLTN9WsdUcTCtas9futWFeWAN1oXMTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1VAnYRBr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NB6Ume0B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1VAnYRBr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NB6Ume0B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B24F71F391;
	Wed, 22 Jan 2025 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737584179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+elPziQabNxUQ36mR8t8fvvffZgRKVy2IB3Q8ndBXk=;
	b=1VAnYRBrR4sn8jlfCDsSo4ZlT+XwOjtS+VPPDwNFyul7Gtor0HKxagktRAiO6kyVoyvhJw
	DI+m/k/3epCCLlwvuJ7V9KrXWKHoXvXZB577PoNRxesskAvloWT0PjmGAKflOKbTLOAcHv
	dka8czG0W/SN24hcVtaa1K1yZkN6eKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737584179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+elPziQabNxUQ36mR8t8fvvffZgRKVy2IB3Q8ndBXk=;
	b=NB6Ume0B+tyuZDiTVl5J0QxN4TlTH7xa0GQZfEM1qyTN9ieHGV9RWiNivndYG+dM9Zrj5f
	mPGAINsaZKTghECQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1VAnYRBr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NB6Ume0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737584179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+elPziQabNxUQ36mR8t8fvvffZgRKVy2IB3Q8ndBXk=;
	b=1VAnYRBrR4sn8jlfCDsSo4ZlT+XwOjtS+VPPDwNFyul7Gtor0HKxagktRAiO6kyVoyvhJw
	DI+m/k/3epCCLlwvuJ7V9KrXWKHoXvXZB577PoNRxesskAvloWT0PjmGAKflOKbTLOAcHv
	dka8czG0W/SN24hcVtaa1K1yZkN6eKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737584179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+elPziQabNxUQ36mR8t8fvvffZgRKVy2IB3Q8ndBXk=;
	b=NB6Ume0B+tyuZDiTVl5J0QxN4TlTH7xa0GQZfEM1qyTN9ieHGV9RWiNivndYG+dM9Zrj5f
	mPGAINsaZKTghECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93DB11397D;
	Wed, 22 Jan 2025 22:16:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ERNREjFukWdzPgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 22:16:17 +0000
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
Cc: linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 0/4] nfsd: filecache: change garbage collect lists
In-reply-to: <83ed7510-0a0c-4048-beb5-c4a10c38ca06@oracle.com>
References: <20250122035615.2893754-1-neilb@suse.de>,
 <83ed7510-0a0c-4048-beb5-c4a10c38ca06@oracle.com>
Date: Thu, 23 Jan 2025 09:16:10 +1100
Message-id: <173758417063.22054.674648092957982688@noble.neil.brown.name>
X-Rspamd-Queue-Id: B24F71F391
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 23 Jan 2025, Chuck Lever wrote:
> On 1/21/25 10:54 PM, NeilBrown wrote:
> > 
> > The nfsd filecache currently uses  list_lru for tracking files recently
> > used in NFSv3 requests which need to be "garbage collected" when they
> > have becoming idle - unused for 2-4 seconds.
> > 
> > I do not believe list_lru is a good tool for this.  It does no allow the
> > timeout which filecache requires so we have to add a timeout mechanism
> > which holds the list_lru for while the whole list is scanned looking for
> > entries that haven't been recently accessed.  When the list is largish
> > (even a few hundred) this can block new requests which need the lock to
> > remove a file to access it.
> > 
> > This patch removes the list_lru and instead uses 2 simple linked lists.
> > When a file is accessed it is removed from whichever list it is one,
> > then added to the tail of the first list.  Every 2 seconds the second
> > list is moved to the "freeme" list and the first list is moved to the
> > second list.  This avoids any need to walk a list to find old entries.
> > 
> > These lists are per-netns rather than global as the freeme list is
> > per-netns as the actual freeing is done in nfsd threads which are
> > per-netns.
> > 
> > This should not be applied until we resolve how to handle the
> > race-detection code in nfsd_file_put().  However I'm posting it now to
> > get any feedback so that a final version can be posted as soon as that
> > issue is resolved.
> > 
> > Thanks,
> > NeilBrown
> > 
> > 
> >   [PATCH 1/4] nfsd: filecache: use nfsd_file_dispose_list() in
> >   [PATCH 2/4] nfsd: filecache: move globals nfsd_file_lru and
> >   [PATCH 3/4] nfsd: filecache: change garbage collection list
> >   [PATCH 4/4] nfsd: filecache: change garbage collection to a timer.
> 
> Hi Neil -
> 
> I would like Dave Chinner to chime in on this approach. When you
> resend, please Cc: him. Thanks!

Sure, I can do that.  But why Dave in particular?
I would like to add a comment to the cover letter explaining to Dave
what he was added to see and I don't know what to say.

Thanks,
NeilBrown

