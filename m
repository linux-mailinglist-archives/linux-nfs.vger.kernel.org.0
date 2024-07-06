Return-Path: <linux-nfs+bounces-4674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F27929156
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 08:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F173283BBB
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 06:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57B1B285;
	Sat,  6 Jul 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LJBK54u/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oVjZaw95";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qcy2fAfx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D6NPiuEB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099A847A
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720247853; cv=none; b=l7r1snHHxAMDeM94QqYj2xcf/usDpj2yollwbo+emWoZc/CtluFfYoaGKfNyyEPIVG/W7Rne4kUDn285oOz60S2IaCS2gAczV8Bsurn4FuTov8MeMGtQZ8SVX/8UAjkkl7AIEO8XEk8z/DuD6EJ7SVJhi5/Lzp7S7C+BzO7g22w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720247853; c=relaxed/simple;
	bh=Lo0weWrRbGsGh00myXmb6AIzid3+GRfwR8qU2mnMMb8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IN2yDjcGKmfhJnfUAfBMZaqGsJLB6i+rg/o0dWKzD+nWmAhG+TBUQlmqQQFfd/3dRVmfKDbJLRp88R+PW7g5kMcOOBIuhicl5n1kSlxpD9qXpCwZusIXvlACn0crl1/wLMrWzj4yQsdwNX3qePB7XV/XzRiLZo6Jmn9tkeM3h5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LJBK54u/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oVjZaw95; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qcy2fAfx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D6NPiuEB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D799321A27;
	Sat,  6 Jul 2024 06:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720247850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdWPM3VBWOo9cnSXkc2YjdVUvCIiMrHTiNWFM547cas=;
	b=LJBK54u/tKT4VZ4oRQ5zLny4s38P/RQbvkZNGFXtwK0k6mRr2ueuIHHYNv47q7KtKE3ys8
	TX69I3SERkzsxGpS6HvcAe2JMdtsEmb+I8SKspErbM0B1LymexEf/Z2yh7mqs5WibQ+aUG
	tX6f9kvlS+q6oxAY/FWTTy1sIeiJNnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720247850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdWPM3VBWOo9cnSXkc2YjdVUvCIiMrHTiNWFM547cas=;
	b=oVjZaw95GL39fmuh39UTNRzaDYkgEomCxF3wPF4fFG9NMWP+BYeBSOjw9xR0Bu67JBAKjc
	VVdvHD/Ohi6wPFAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qcy2fAfx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=D6NPiuEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720247849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdWPM3VBWOo9cnSXkc2YjdVUvCIiMrHTiNWFM547cas=;
	b=qcy2fAfx5XlI7gJiK1bUGZb8WOUSfdbRA7SvzNYoWC00AIBl3eLo6ekNdNR5iMHEVEM88e
	aSiBPXFAc6txORd2nzWA8FwpwW6agRGzWD4yt8mO3e8Sp1Z4ewNQrpYfnGfhW7+F24cqo8
	SI8itbLL+CqMK/SyZqYDVo956yLkMxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720247849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdWPM3VBWOo9cnSXkc2YjdVUvCIiMrHTiNWFM547cas=;
	b=D6NPiuEBxZ/eGOxjW6k08eGtbslip5WMLyvYTMLCURUs0gp8OPbucfOvNkLO5KhYzYXIfp
	mI28t5EEGdOT1TDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FDC11373A;
	Sat,  6 Jul 2024 06:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2NyvCCbmiGbYfgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 06 Jul 2024 06:37:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Mike Snitzer" <snitzer@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever III" <chuck.lever@oracle.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Dave Chinner" <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
In-reply-to: <Zojd6fVPG5XASErn@infradead.org>
References: <>, <Zojd6fVPG5XASErn@infradead.org>
Date: Sat, 06 Jul 2024 16:37:22 +1000
Message-id: <172024784245.11489.13308466638278184214@noble.neil.brown.name>
X-Rspamd-Queue-Id: D799321A27
X-Spam-Score: -5.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sat, 06 Jul 2024, Christoph Hellwig wrote:
> On Sat, Jul 06, 2024 at 08:08:07AM +1000, NeilBrown wrote:
> > I would like to see a good explanation for why NOT NFSv3.
> > I don't think NFSv3 is obsolete.  The first dictionary is "No longer in
> > use." which certainly doesn't apply.
> > I think "deprecated" is a more relevant term.  I believe that NFSv2 has
> > been deprecated.  I believe that NFSv4.0 should be deprecated.  But I
> > don't see any reason to consider NFSv3 to be deprecated.
> 
> The obvious answer is that NFSv4.1/2 (which is really the same thing)
> is the only version of NFS under development and open for new features
> at the protocol level.  So from the standardization perspective NFSv3
> is obsolete.

RFC-1813 is certainly obsolete from a standardization perspective - it
isn't even an IETF standard - only informational.  It can't be extended
with any hope of interoperability between implementations.

But we don't want interoperability between implementations.  We want to
enhance the internal workings of one particular implementation.  I don't
see that the standards status affects that choice.

> 
> But the more important point is that NFSv4 has a built-in way to bypass
> the server for I/O namely pNFS.  And bypassing the server by directly
> going to a local file system is the text book example for what pNFS
> does.  So we'll need a really good argument why we need to reinvented
> a different scheme for bypassing the server for I/O.  Maybe there is
> a really good killer argument for doing that, but it needs to be clearly
> stated and defended instead of assumed.

Could you provide a reference to the text book - or RFC - that describes
a pNFS DS protocol that completely bypasses the network, allowing the
client and MDS to determine if they are the same host and to potentially
do zero-copy IO.

If not, I will find it hard to understand your claim that it is "the
text book example".

Also, neither you nor I are in a position to assert what is needed for a
change to get accepted.  That is up the the people with M: in front of
their email address.  I believe that any council that either of us give
will considered with genuine interest, but making demands seems out of
place.

Thanks,
NeilBrown

