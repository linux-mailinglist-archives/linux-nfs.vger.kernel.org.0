Return-Path: <linux-nfs+bounces-4702-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0AF929B37
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 06:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C732813FC
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 04:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D6B8C06;
	Mon,  8 Jul 2024 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pWaPd6Qc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vQn/yJRq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pWaPd6Qc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vQn/yJRq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD838BF3
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720411397; cv=none; b=qCrAgwhzWTxIia8Xxqfr48xxOMQimzmSXPA80aK7On2hUnW5h6vCn+m7ROC02/RbHLl39lxAxQdNQ4uMyQ6Rb3DQe7zAuvUfeHa/pr90gKTyrycgOJ+P0zxzXgYZUjD8YWqnbHsv8xoO6ajX0d3T3GfcvuA0E9gtt5p4ZWkozY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720411397; c=relaxed/simple;
	bh=s25a7XtAo4Nbu55cmY9fq/Pn4XwK7TWn7cmOxzsiKtA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pqvgcxgjmGyQ9FgfB8BwAhcqEeNQZSB5Sx+WvPFi8uey1ubjzIPt5sk6FGbercXsIBUvEQHhoIbUr1pkHsS7D41jPII7KOuT+Gnnp9L9r86Vn3JRXE9MUFykQzBIXpVYn+CkcKW3rN09yZS/s4gkllVk59bbS1K7b6C8LOtlGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pWaPd6Qc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vQn/yJRq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pWaPd6Qc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vQn/yJRq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA61F21B03;
	Mon,  8 Jul 2024 04:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720411393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXBo1ebNPC0r073Ipz/6sQCNvrMPvQjQKkXxNgGQMFE=;
	b=pWaPd6QcSFzKRjALSCBMxTc/DyGZSG8JAalV+jcNbB17su33mDkoaOlDSn/IATa54Ogl3b
	iYuJgJUbNgDc+6uFZnFs+lNZqvKRPTiUfL2mx5iN02z6GUB/ysNk0rvg2yZ9rOMyTNo6bz
	ukLCToOocnB04F0V3V4pU2MVLHCkO44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720411393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXBo1ebNPC0r073Ipz/6sQCNvrMPvQjQKkXxNgGQMFE=;
	b=vQn/yJRqvJQ7tcQvlj0UCQ/gJTKjOszseI1iyoJ6m42jZfPInutCy3+/LvuT7UB8MBnCoS
	UCITqUKaSg2h49BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720411393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXBo1ebNPC0r073Ipz/6sQCNvrMPvQjQKkXxNgGQMFE=;
	b=pWaPd6QcSFzKRjALSCBMxTc/DyGZSG8JAalV+jcNbB17su33mDkoaOlDSn/IATa54Ogl3b
	iYuJgJUbNgDc+6uFZnFs+lNZqvKRPTiUfL2mx5iN02z6GUB/ysNk0rvg2yZ9rOMyTNo6bz
	ukLCToOocnB04F0V3V4pU2MVLHCkO44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720411393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXBo1ebNPC0r073Ipz/6sQCNvrMPvQjQKkXxNgGQMFE=;
	b=vQn/yJRqvJQ7tcQvlj0UCQ/gJTKjOszseI1iyoJ6m42jZfPInutCy3+/LvuT7UB8MBnCoS
	UCITqUKaSg2h49BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91C9212FF6;
	Mon,  8 Jul 2024 04:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WvrhDf5ki2ZTVQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 08 Jul 2024 04:03:10 +0000
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
In-reply-to: <ZojnVdrEtmbvNXd-@infradead.org>
References: <>, <ZojnVdrEtmbvNXd-@infradead.org>
Date: Mon, 08 Jul 2024 14:03:02 +1000
Message-id: <172041138255.15471.5728203307255005157@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Sat, 06 Jul 2024, Christoph Hellwig wrote:
> On Sat, Jul 06, 2024 at 04:37:22PM +1000, NeilBrown wrote:
> > > a different scheme for bypassing the server for I/O.  Maybe there is
> > > a really good killer argument for doing that, but it needs to be clearly
> > > stated and defended instead of assumed.
> > 
> > Could you provide a reference to the text book - or RFC - that describes
> > a pNFS DS protocol that completely bypasses the network, allowing the
> > client and MDS to determine if they are the same host and to potentially
> > do zero-copy IO.
> 
> I did not say that we have the exact same functionality available and
> there is no work to do at all, just that it is the standard way to bypass
> the server.

Sometimes what you don't say is important.  As you acknowledge there is
work to do.  Understanding how much work is involved is critical to
understanding that possible direction.

> 
> RFC 5662, RFC 5663 and RFC 8154 specify layouts that completely bypass
> the network and require the client and server to find out that they talk
> to the same storage devuce, and directly perform zero copy I/O.
> They do not require to be on the same host, though.

Thanks.

> 
> > If not, I will find it hard to understand your claim that it is "the
> > text book example".
> 
> pNFS is all about handing out grants to bypass the server for I/O.
> That is exactly what localio is doing.

Yes, there is clearly an alignment.

But pNFS is about handing out grants using standardised protocols that
support interoperability between distinct nodes, and possibly distinct
implementations.  localio doesn't need any of that.  It all exists in a
single implementation on a single node.  So in that sense there can be
expected to be different priorities.

Why should we pay the costs of pNFS when implementing localio?  That
question can only be answered if we have a good understanding of the
costs and benefits.  And that requires having a concrete proposal for
the "pNFS" option - if only a detailed sketch.

Just because pNFS could be part of the answer (which I don't dispute)
that doesn't necessarily mean it should be part of the answer.

Thanks,
NeilBrown

