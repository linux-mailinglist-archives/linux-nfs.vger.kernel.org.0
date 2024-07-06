Return-Path: <linux-nfs+bounces-4668-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39693928FC4
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 02:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F732835F0
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 00:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C3A4A19;
	Sat,  6 Jul 2024 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lqaZpBRN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ocw8SxJ4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dy9ug+1v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sh0kAKcI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD3629;
	Sat,  6 Jul 2024 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720225988; cv=none; b=lC9hsfgL/DL2HKD7Ahgwng1wVAEn1cI08TWu5YrFwtFdb4PofG7oVjVkZ0+F0FQUdTQR5GD0u8UhGOg+f1nN+Ci/7kFE9s0CITkYlreoqIl7oGxLLcHi1iuKYgy7syJ8IssPbJU9OkUibcoripRNYbY/abqjJkhFCwietCO81XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720225988; c=relaxed/simple;
	bh=LfKb7PdZbIc0SKysEl5rjYBAE40cFibkqRvPN62NwS4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ggIWNuXQzWL1H1PmgZBYpuNagqxhaybRlKdg1t9SA8qoGfllhvP4oAyeP1uEUyW2DyWN/con/lLi6Nlkvpuk5MAGWt4Bkx+RSF2qwxVsxNvRd/2juDbItjsGxskAVwDvXHltbapbACyrb/lMtKng5FdVi/TjEkVAvW1+aTK5LgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lqaZpBRN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ocw8SxJ4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dy9ug+1v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sh0kAKcI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F85221A44;
	Sat,  6 Jul 2024 00:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720225985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEpuIfxNJLxEPxDOCQJU8xonAZDsFeuluQO+eHJ3EMY=;
	b=lqaZpBRNUIIe6RwUNSjc3lrsqEWEUkrhnBvhv+a6MBZ2frFXO6sX0mZbkvU/wDmcY/mE9F
	Ge0wo59wPfzDIeRc4n7gzEtCHk9Q7x8nkCt02YB7Nauk6fqWTTt4F1n3NwDmZfeNzEwPTN
	1K3IpDDk8lkIR5oWHO1RB7UW9exuT00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720225985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEpuIfxNJLxEPxDOCQJU8xonAZDsFeuluQO+eHJ3EMY=;
	b=Ocw8SxJ4Z7FkUfrO2/X9EDwgm6SQEFpzOdWAJH5l3p+pW/E+qrEIgt9+Ry4MUkyKFifuUt
	HRcLRJujrl59f/CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dy9ug+1v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sh0kAKcI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720225984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEpuIfxNJLxEPxDOCQJU8xonAZDsFeuluQO+eHJ3EMY=;
	b=Dy9ug+1v8YqnOsLjJqedfgoTtv3aPbHKH3jB8pZ//e1ohwVQ3/qUry27I8ZaQiTsD+uA/M
	hMPRB8ueJYV9OGthSF+m942kK22pR8ZS12U8J/UfeQeaDV3AvITZHT+GJjE50YIpP3t5J2
	St0Nf7wmUY3uf8fdwHcrGwEPRqxJZyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720225984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEpuIfxNJLxEPxDOCQJU8xonAZDsFeuluQO+eHJ3EMY=;
	b=sh0kAKcIqI6gR6Rm6PNQqVIk0cBoPOqW5/cIWBeKEnYthPQ4759416cmC26KsOLzcPVeZS
	cWN2/HjQkmwzTvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAED01396E;
	Sat,  6 Jul 2024 00:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EW2pE72QiGZhMQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 06 Jul 2024 00:33:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@hammerspace.com>
Cc: "david@fromorbit.com" <david@fromorbit.com>,
 "bfoster@redhat.com" <bfoster@redhat.com>,
 "snitzer@kernel.org" <snitzer@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
In-reply-to: <d1af795e3aa83477f90e4521af7ade3a7aed5d4b.camel@hammerspace.com>
References:
 <>, <d1af795e3aa83477f90e4521af7ade3a7aed5d4b.camel@hammerspace.com>
Date: Sat, 06 Jul 2024 10:32:52 +1000
Message-id: <172022597256.11489.7372525202519871550@noble.neil.brown.name>
X-Rspamd-Queue-Id: 4F85221A44
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 03 Jul 2024, Trond Myklebust wrote:
> On Tue, 2024-07-02 at 23:04 +1000, Dave Chinner wrote:
> > On Tue, Jul 02, 2024 at 12:33:53PM +0000, Trond Myklebust wrote:
> > > On Mon, 2024-07-01 at 10:13 -0400, Mike Snitzer wrote:
> > > > On Mon, Jul 01, 2024 at 09:46:36AM +1000, Dave Chinner wrote:
> > > > > IMO, the only sane way to ensure this sort of nested "back-end
> > > > > page
> > > > > cleaning submits front-end IO filesystem IO" mechanism works is
> > > > > to
> > > > > do something similar to the loop device. You most definitely
> > > > > don't
> > > > > want to be doing buffered IO (double caching is almost always
> > > > > bad)
> > > > > and you want to be doing async direct IO so that the submission
> > > > > thread is not waiting on completion before the next IO is
> > > > > submitted.
> > > >=20
> > > > Yes, follow-on work is for me to revive the directio path for
> > > > localio
> > > > that ultimately wasn't pursued (or properly wired up) because it
> > > > creates DIO alignment requirements on NFS client IO:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/com=
mit/?h=3Dnfs-localio-for-6.11-testing&id=3Df6c9f51fca819a8af595a4eb94811c1f90=
051eab
> >=20
> > I don't follow - this is page cache writeback. All the write IO from
> > the bdi flusher thread should be page aligned, right? So why does DIO
> > alignment matter here?
> >=20
>=20
> There is no guarantee in NFS that writes from the flusher thread are
> page aligned. If a page/folio is known to be up to date, we will
> usually align writes to the boundaries, but we won't guarantee to do a
> read-modify-write if that's not the case. Specifically, we will not do
> so if the file is open for write-only.

Would it be reasonable for the partial pages to be written over RPC and
for only full pages to be sent directly to the server-side file using
O_DIRECT writes?  Presumably the benefits of localio are most pronounced
with large writes which will mostly be full-page, or even full-folio.

O_DIRECT writes on the NFS side would be more awkward.  open(2)
documents that NFS places no alignment restrictions on O_DIRECT I/O.  If
applications depend on that then some copying will have to be done
before the data is written to a block filesystem - possibly into the
page cache, possibly into some other buffer.  This wouldn't be more
copying that we already do.

NeilBrown

