Return-Path: <linux-nfs+bounces-4760-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89992C6EC
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 02:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BD12819A6
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7CAA5F;
	Wed, 10 Jul 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xJ61/Q8F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sYntfS7a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xJ61/Q8F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sYntfS7a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77240EC4
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570235; cv=none; b=nNBVrVCo1DBqZUZpDti3GIKmT2TzJIEr7ZwB9NgTjwh7RapPNP01CvO7cgy3aqCacuJCQuajjzcT99yhRRJUnKqnSxrZCJ3K91KOlANLLcZV1i4ctbDKs02NaDNQDF4cQN8ZXsW3ZUt7BLdy4d9lgmyI1rGvooYt14vPV5jtKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570235; c=relaxed/simple;
	bh=1GZqn69tGKE6WeawoNkADr+omxwmQJrgrVOh1GaDbZ8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jVDye09bEEy2qAj44X1+hTAduCiNA9Awk65Dgmd+MKq7/AM6i6Jh2XqcZOGoBfO+BftKu36rj8iwXeQqFUR9tyWW32hFURAiJ7sb8anEZhyqaauu8iHxlHJ4GocSSfhQwUX+KdcTJBVIhWnpfJz3cXn7kYYfa6rAwl9tnOgMHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xJ61/Q8F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sYntfS7a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xJ61/Q8F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sYntfS7a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3CE3421A86;
	Wed, 10 Jul 2024 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720570229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWxZgQLVqWTcDtojWPryawt124jKjABHoDxF3Jv72Lk=;
	b=xJ61/Q8FREqqGxzrWaCfEJjRYW/JM+3csLK9v2wyocTIQH0dMJM9jWgz/QUz/1FmUXdpWC
	zja6CpmhZlppsidE3sbE4AfzzFfRFSi0Zo6YVJrTQqUEeBEz9QTW457XuARyngptFLG7ia
	iZ1e+UXgVyXRNNvyezbCh+xMl8Whgu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720570229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWxZgQLVqWTcDtojWPryawt124jKjABHoDxF3Jv72Lk=;
	b=sYntfS7aWrkdIe9Ha2mQwyD+bwaLe9IIzb476EEyRVtDXz+N15EqtGImbDmUab+l+XDeY/
	D9ZlAGLvsLHsqnDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720570229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWxZgQLVqWTcDtojWPryawt124jKjABHoDxF3Jv72Lk=;
	b=xJ61/Q8FREqqGxzrWaCfEJjRYW/JM+3csLK9v2wyocTIQH0dMJM9jWgz/QUz/1FmUXdpWC
	zja6CpmhZlppsidE3sbE4AfzzFfRFSi0Zo6YVJrTQqUEeBEz9QTW457XuARyngptFLG7ia
	iZ1e+UXgVyXRNNvyezbCh+xMl8Whgu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720570229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWxZgQLVqWTcDtojWPryawt124jKjABHoDxF3Jv72Lk=;
	b=sYntfS7aWrkdIe9Ha2mQwyD+bwaLe9IIzb476EEyRVtDXz+N15EqtGImbDmUab+l+XDeY/
	D9ZlAGLvsLHsqnDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BB65136CD;
	Wed, 10 Jul 2024 00:10:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 33vYKW7RjWZIQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 10 Jul 2024 00:10:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
In-reply-to: <ZouzQ8trA1YW0CdS@infradead.org>
References: <>, <ZouzQ8trA1YW0CdS@infradead.org>
Date: Wed, 10 Jul 2024 10:10:15 +1000
Message-id: <172057021554.15471.12747291940440767258@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Mon, 08 Jul 2024, Christoph Hellwig wrote:
> On Mon, Jul 08, 2024 at 02:03:02PM +1000, NeilBrown wrote:
> > > I did not say that we have the exact same functionality available and
> > > there is no work to do at all, just that it is the standard way to bypa=
ss
> > > the server.
> >=20
> > Sometimes what you don't say is important.  As you acknowledge there is
> > work to do.  Understanding how much work is involved is critical to
> > understanding that possible direction.
>=20
> Of course there is.  I've never said we don't need to do any work,
> I'm just asking why we are not using the existing infrastruture to do
> it.
>=20
> > But pNFS is about handing out grants using standardised protocols that
> > support interoperability between distinct nodes, and possibly distinct
> > implementations.  localio doesn't need any of that.  It all exists in a
> > single implementation on a single node.  So in that sense there can be
> > expected to be different priorities.
> >=20
> > Why should we pay the costs of pNFS when implementing localio?
>=20
> Why do you think we pay a cost for it?  From all I can tell it makes
> the job simpler, especially if we want to do things like bypassing
> the second page cache.
>=20
> > That
> > question can only be answered if we have a good understanding of the
> > costs and benefits.  And that requires having a concrete proposal for
> > the "pNFS" option - if only a detailed sketch.
>=20
> I sketched the the very sketchy sketch earlier - add a new localio
> layout that does local file I/O.  The I/O side of that is pretty
> tivial, and maybe I can find some time to write draft code.  The file
> open side is just as horrible as in the current localio proposal,
> and I could just reuse that for now, although I think the concept
> of opening the file in the client contect is fundamentally wrong
> no matter how we skin the cat.
>=20

I had been assuming that you were proposing a new pNFS layout type with
associated protocol extension, an RFC describing them, and navigation of
the IETF standards process.  These are (some of) the costs I was
thinking of.  Of course the IETF requires demonstration of
interoperability between multiple implementations, and as that is
impossible for localio, we would fail before we started.

But I now suspect that I guessed your intention wrongly (I'm rubbish at
guessing other people's intentions).  Your use of the word
"infrastructure" above and the sketchy sketch you provide (thanks) seems
to indicate you are only suggesting that we re-use some of the pnfs
abstractions and interfaces already implemented in the Linux NFS client
and server.

Is that what you mean?

If it is, then it isn't immediately clear to me that this would have to
be NFSv4 only.  The different versions already share code where that
makes sense.  Moving the pnfs code from the nfsv4 module to a new pnfs
module which nfsv3 also depends on might make sense.

I'm keen to know what you are really thinking.

Thanks,
NeilBrown

