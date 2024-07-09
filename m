Return-Path: <linux-nfs+bounces-4758-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E711492C6B0
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 01:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1754F1C21C45
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 23:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7E118562C;
	Tue,  9 Jul 2024 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eH9XbACz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n37M2NIR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eH9XbACz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n37M2NIR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F3189F27;
	Tue,  9 Jul 2024 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568368; cv=none; b=QYAsxBl9xCeiuTq+A1dYHm3jByrqE2/5UachgbXvkZHdGCjaWSiDb4wgKLil2R2LZ18m1oV1lLKgmj7PmDPap2B/FMyWuorbam9wrlPVovgIchnHkaatNsoGbrvRTZyLFNdDbH3nYlikinHhXVn1SYqK+21IG8PqmPxyZCgaI5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568368; c=relaxed/simple;
	bh=G99Er+EWPpHJ/OwrhgruD+yYWUzqkDpBqoyexPINWRA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iRdorSL2q1bWW12b+kJTrQ68fv4Ic41yyXxN7rjp4DCamhN6ph665Sn/j1RlhdVNnyGM8c09/HGxh0Yegf2UqPeoJz9dhzEKM9tLdPy97AC3OVPLTauA/iHN6wFao6QDeuy3d8twyvMFQg2G0YlqfdlNavbTmwXrV/RjOIpp1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eH9XbACz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n37M2NIR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eH9XbACz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n37M2NIR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 882CB1F7A4;
	Tue,  9 Jul 2024 23:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720568364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJn9BSB3Akp4zoDETL7KVSx6H0nTVEQ+GmnJ+BQL/Fw=;
	b=eH9XbACz/ff55H+gmolWnbiFj2vvheb9aNK+TFZxVZNSZn3+q40CM/r3pr/msQzgwuq9qu
	vrUmYRXJ/rPqf/u91/+N357Ab24wi6r5E0LOp96s7lfcJwL0Q8xKdHdkmMY/HHkNoFb/RK
	lRMKM7RUWV8ZRs1YZIxWiQOTAzZTpSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720568364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJn9BSB3Akp4zoDETL7KVSx6H0nTVEQ+GmnJ+BQL/Fw=;
	b=n37M2NIRn4r+KHtPq3rXV1ThdnZ1i/xArnAvOb45te/WTcOKDWhH207FoNg+TOUSnjFlRR
	yU64Z0tTXn2V24CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720568364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJn9BSB3Akp4zoDETL7KVSx6H0nTVEQ+GmnJ+BQL/Fw=;
	b=eH9XbACz/ff55H+gmolWnbiFj2vvheb9aNK+TFZxVZNSZn3+q40CM/r3pr/msQzgwuq9qu
	vrUmYRXJ/rPqf/u91/+N357Ab24wi6r5E0LOp96s7lfcJwL0Q8xKdHdkmMY/HHkNoFb/RK
	lRMKM7RUWV8ZRs1YZIxWiQOTAzZTpSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720568364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJn9BSB3Akp4zoDETL7KVSx6H0nTVEQ+GmnJ+BQL/Fw=;
	b=n37M2NIRn4r+KHtPq3rXV1ThdnZ1i/xArnAvOb45te/WTcOKDWhH207FoNg+TOUSnjFlRR
	yU64Z0tTXn2V24CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52DAC1396E;
	Tue,  9 Jul 2024 23:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tQT7LCbKjWZZOAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 09 Jul 2024 23:39:18 +0000
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
Cc: "Trond Myklebust" <trondmy@hammerspace.com>,
 "david@fromorbit.com" <david@fromorbit.com>,
 "bfoster@redhat.com" <bfoster@redhat.com>,
 "snitzer@kernel.org" <snitzer@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
In-reply-to: <ZojmMx7ERcBJMQ1j@infradead.org>
References: <>, <ZojmMx7ERcBJMQ1j@infradead.org>
Date: Wed, 10 Jul 2024 09:39:04 +1000
Message-id: <172056834436.15471.6940927284262705680@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

On Sat, 06 Jul 2024, Christoph Hellwig wrote:
> Btw, one issue with using direct I/O is that need to synchronize with
> page cache access from the server itself.  For pNFS we can do that as
> we track outstanding layouts.  Without layouts it will be more work
> as we'll need a different data structure tracking grant for bypassing
> the server.  Or just piggy back on layouts anyway as that's what they
> are doing.
> 

I'm missing something here.

Certainly if localio or nfsd were to choose to use direct I/O we would
need to ensure proper synchronisation with page cache access.

Does VFS/MM already provide enough synchronisation?  A quick look at the
code suggests:
- before an O_DIRECT read any dirty pages that overlap are flushed to
  the device.
- after a write, any pages that overlap are invalidated.

So as long as IO requests don't overlap we should have adequate
synchronisation.

If they do overlap we should expect inconsistent results.  Maybe we
would expect reads to only "tear" on a page boundary, and writes to only
interleave in whole pages, and probably using O_DIRECT would not give
any whole-page guarantees.  So maybe that is a problem.

If it is a problem, I think it can only be fixed by keeping track of which
pages are under direct IO, and preventing access to the page-cache for
those regions.  This could be done in the page-cache itself, or in a
separte extent-tree.  I don't think the VFS/MM supports this - does any
filesystem?

(or we could prevent adding any new pages to the page-cache for an inode
 with i_dio_count > 0 - but that would likely hurt performance.)

I can see that pNFS extents could encode the information to enforce
this, but I don't see how that is mapped to filesystems in Linux at
present.

What am I missing?

Thanks,
NeilBrown

