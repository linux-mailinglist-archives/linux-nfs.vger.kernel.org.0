Return-Path: <linux-nfs+bounces-5849-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63F2962244
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 10:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F511C210A8
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F150B67A;
	Wed, 28 Aug 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FTtsjl5p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mGrIHvPQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GQsK3PVg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PNdyiilA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68415853A;
	Wed, 28 Aug 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833460; cv=none; b=SgGUeFiBqwEqPvTMalX00dY57UZlLw+Y+ja0qS+T40T6XVzB98Jl3JWg7ufOtt3Yo6/oCyG5GdIwAsIYMc7YVjKst28zPbRC3H4JbRbCiTNYxwBbRNCFu0ao0GmShc+erpxsCRxrSPd3q6M2TaZEkLopcVvfESzrqzqog38uAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833460; c=relaxed/simple;
	bh=GIAoRJFBNwwpKGtS0LTCcaz2V1ixbGLJJPMd5G5+MBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNUCQ7gpyJFqzSYEZpJLDT87gtuYVY7K2bRITVaq3j4T7lZqsuEZKcQVRAXr4oDTc863wo80tCJC56A/nob8dQ1ABToLlHPAim40Wv3n588FzaPc/9BupgJMCqt5+XrGtkdc3R9my83jrjYGq93E+w/D7lzI7q1uhOIqbItnQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FTtsjl5p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mGrIHvPQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GQsK3PVg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PNdyiilA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E25601FBED;
	Wed, 28 Aug 2024 08:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724833456;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2dRgp/cBG57vE4RNJLl2sr2qXzWa1FUbUXiUJzbitg=;
	b=FTtsjl5po3CoQnQekyUMbJqX9PfLMUWt55Jtp3m0EghDvwX+K5/jnaDb3RfkXMnZl4hH02
	XbcL5EuTAjwWVSK4q0mkbQm+X2ougQcCIm6OZohVOYkeUuFwN306lsJXPnWOOw+uIyqp+J
	RLd0X7C2l1AkdNi85/2VcK2Fxc+5X9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724833456;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2dRgp/cBG57vE4RNJLl2sr2qXzWa1FUbUXiUJzbitg=;
	b=mGrIHvPQRLxsntLWxrBQ3ClQSJlZsuiWav9SoZUBmIhlC/OhHtICGOp2WYZXKZ/7IjB+oC
	sR1xfRh+k67JUKDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724833455;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2dRgp/cBG57vE4RNJLl2sr2qXzWa1FUbUXiUJzbitg=;
	b=GQsK3PVg9oGugtR68o19eFJQORMr7wx/RnunSrXtoSnVn7UCVNvI/I2WBFz9Ti3Vn1AS3g
	U96aBnPg4Isce0OWqo0SeXUSaqN89dNn36YSSC3jYKLojFgi/rl1rVrcOYt8sethLphXp4
	NPGug4WhFpMk/zZImqRWFJBM34opBl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724833455;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2dRgp/cBG57vE4RNJLl2sr2qXzWa1FUbUXiUJzbitg=;
	b=PNdyiilAOEnTCDQ8BqZPWlIECBz9DIgkDblcApU6gnmkyDx8I0hfNYUut50IX5ugodxsJj
	OQRy0WIin7yJjEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E573138D2;
	Wed, 28 Aug 2024 08:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AnAxJa/ezmYTQQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 28 Aug 2024 08:24:15 +0000
Date: Wed, 28 Aug 2024 10:24:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Martin Doucha <mdoucha@suse.cz>, linux-nfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v2 1/1] nfsstat01: Update client RPC calls for
 kernel 6.9
Message-ID: <20240828082410.GA1665124@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <>
 <9afef16d-52b2-435d-902a-7ccfa5824968@suse.cz>
 <172479295459.11014.9802161915427616319@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172479295459.11014.9802161915427616319@noble.neil.brown.name>
X-Spam-Score: -7.50
X-Spamd-Result: default: False [-7.50 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Neil,

> On Tue, 27 Aug 2024, Martin Doucha wrote:
> > On 23. 08. 24 23:59, NeilBrown wrote:
> > > On Fri, 23 Aug 2024, Petr Vorel wrote:
> > >> We discussed in v1 how to fix tests.  Neil suggested to fix the test the way so
> > >> that it works on all kernels. As I note [1]

> > >> 1) either we give up on checking the new functionality still works (if we
> > >> fallback to old behavior)

> > > I don't understand.  What exactly do you mean by "the new
> > > functionality".
> > > As I understand it there is no new functionality.  All there was was and
> > > information leak between network namespaces, and we stopped the leak.
> > > Do you consider that to be new functionality?

> > The new functionality is that the patches add a new file to network 
> > namespaces: /proc/net/rpc/nfs. This file did not exist outside the root 
> > network namespace at least on some of the kernels where we still need to 
> > run this test. So the question is: How aggressively do we want to 
> > enforce backporting of these NFS patches into distros with older kernels?

> Thanks for explaining that.  I had assumed that the the file was always
> visible from all name spaces, but before the fix every namespace saw the
> same file.  Clearly I was wrong.


> > We have 3 options how to fix the test depending on the answer:
> > 1) Don't enforce at all. We'll check whether /proc/net/rpc/nfs exists in 
> > the client namespace and read it only if it does. Otherwise we'll fall 
> > back on the global file.
> > 2) Enforce aggressively. We'll hardcode a minimal kernel version into 
> > the test (e.g. v5.4) and if the procfile doesn't exist on any newer 
> > kernel, it's a bug.
> > 3) Enforce on new kernels only. We'll set a hard requirement for kernel 
> > v6.9+ as in option 2) and check for existence of the procfile on any 
> > older kernels as in option 1).

> I think there are two totally separate questions here.
> 1/ How to fix the existing test to work on new and old kernels.  The
>   existing test checked that the rpc count increased when NFS traffic
>   happened.  I think 1 is the correct fix.  I don't think the test
>   should check kernel version.

> 2/ We have discovered a bug and want to add a test to guard against
>   regression.  This should be a new test.  That test can simply check if
>   the given file exist in a non-init namespace.  I have no particular
>   opinion about testing kernel versions.  A credible approach would be
>   to choose the oldest kernel which it still maintained at the time that
>   that bug was discovered.  Or maybe create a list of kernel versions
>   where were maintained at that time and only run the test on versions
>   in that list, or after the last in the list.

> I really think there is value in having two different tests because we
> are testing two different things.

IMHO this is 3), just split in 2 tests (maybe more obvious for a reviewer).
Sure, we can be explicit and split it into 2 tests.

Regards the version, I would really either draw the line for new change for 6.9
or whatever stable will be the last which gets that. I mean, if it's e.g. 5.14,
this test should fail on some old e.g. unsupported 5.15 some companies may test.
When we in LTP test if fix is still working (no regression), usually the same
tests is used to verify if the fix was applied.

Kind regards,
Petr

> Thanks,
> NeilBrown



> > -- 
> > Martin Doucha   mdoucha@suse.cz
> > SW Quality Engineer
> > SUSE LINUX, s.r.o.
> > CORSO IIa
> > Krizikova 148/34
> > 186 00 Prague 8
> > Czech Republic




