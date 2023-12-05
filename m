Return-Path: <linux-nfs+bounces-345-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE648060CB
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 22:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C652812D4
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 21:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8E56E5B2;
	Tue,  5 Dec 2023 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AllfoRWG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V45S100Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D35A5;
	Tue,  5 Dec 2023 13:28:26 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 942471FBCD;
	Tue,  5 Dec 2023 21:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701811703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQIzPdgi943jx7chxdp0ZljBHnbp9HCom4a+fLRVgbc=;
	b=AllfoRWG0pnl7VrTLk09Ib9qV8RV9xjjZ0uwpPGnTw134NSegWLtaV+D0AcvAAr8mw0IXN
	Y6KPQ6wi7XFs52fDQzl8xzmqQoCsdsURWqJV4vCoBpeNRZ/IEtUJQrjh7vQYfC2fWVzu2b
	hykFWeBgMZZHF9K2WmNK0xxudYau4tA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701811703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQIzPdgi943jx7chxdp0ZljBHnbp9HCom4a+fLRVgbc=;
	b=V45S100ZG0KtUMSSexkBXDYU/xx1fQfmzg5Y6fY1EhQIUh66kIOEcnS8qN3y1xhrgVC+gl
	3L79GrefzvbzY8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA43B1386E;
	Tue,  5 Dec 2023 21:28:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rkhOIfKVb2VCZAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 05 Dec 2023 21:28:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Oleg Nesterov" <oleg@redhat.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 1/2] Allow a kthread to declare that it calls task_work_run()
In-reply-to: <20231205-altbacken-umbesetzen-e5c0c021ab98@brauner>
References: <20231204014042.6754-1-neilb@suse.de>,
 <20231204014042.6754-2-neilb@suse.de>,
 <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>,
 <170172377302.7109.11739406555273171485@noble.neil.brown.name>,
 <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>,
 <20231205-altbacken-umbesetzen-e5c0c021ab98@brauner>
Date: Wed, 06 Dec 2023 08:28:15 +1100
Message-id: <170181169515.7109.11121482729257102758@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.975];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Tue, 05 Dec 2023, Christian Brauner wrote:
> On Mon, Dec 04, 2023 at 03:09:44PM -0700, Jens Axboe wrote:
> > On 12/4/23 2:02 PM, NeilBrown wrote:
> > > It isn't clear to me what _GPL is appropriate, but maybe the rules
> > > changed since last I looked..... are there rules?
> > > 
> > > My reasoning was that the call is effectively part of the user-space
> > > ABI.  A user-space process can call this trivially by invoking any
> > > system call.  The user-space ABI is explicitly a boundary which the GPL
> > > does not cross.  So it doesn't seem appropriate to prevent non-GPL
> > > kernel code from doing something that non-GPL user-space code can
> > > trivially do.
> > 
> > By that reasoning, basically everything in the kernel should be non-GPL
> > marked. And while task_work can get used by the application, it happens
> > only indirectly or implicitly. So I don't think this reasoning is sound
> > at all, it's not an exported ABI or API by itself.
> > 
> > For me, the more core of an export it is, the stronger the reason it
> > should be GPL. FWIW, I don't think exporting task_work functionality is
> > a good idea in the first place, but if there's a strong reason to do so,
> 
> Yeah, I'm not too fond of that part as well. I don't think we want to
> give modules the ability to mess with task work. This is just asking for
> trouble.
> 

Ok, maybe we need to reframe the problem then.

Currently fput(), and hence filp_close(), take control away from kernel
threads in that they cannot be sure that a "close" has actually
completed.

This is already a problem for nfsd.  When renaming a file, nfsd needs to
ensure any cached "open" that it has on the file is closed (else when
re-exporting an NFS filesystem it can result in a silly-rename).

nfsd currently handles this case by calling flush_delayed_fput().  I
suspect you are no more happy about exporting that than you are about
exporting task_work_run(), but this solution isn't actually 100%
reliable.  If some other thread calls flush_delayed_fput() between nfsd
calling filp_close() and that same nfsd calling flush_delayed_fput(),
then the second flush can return before the first flush (in the other
thread) completes all the work it took on.

What we really need - both for handling renames and for avoiding
possible memory exhaustion - is for nfsd to be able to reliably wait for
any fput() that it initiated to complete.

How would you like the VFS to provide that service?

Thanks,
NeilBrown

