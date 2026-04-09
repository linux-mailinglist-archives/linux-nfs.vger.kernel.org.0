Return-Path: <linux-nfs+bounces-20790-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO+NGPNT12kFMggAu9opvQ
	(envelope-from <linux-nfs+bounces-20790-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 09:23:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B61163C6F9D
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 09:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AD91301CCCA
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 07:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763C3371063;
	Thu,  9 Apr 2026 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MwgQvcvk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OqpuF0Yw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MwgQvcvk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OqpuF0Yw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003D372664
	for <linux-nfs@vger.kernel.org>; Thu,  9 Apr 2026 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719304; cv=none; b=Ku+QCh1seE5oid8y3mqY/3p19i5FiYYAH8j38PxAp74bxa3JNz5BnRwJ6Mj63M5V/sj2sgwvRGBOkQGxrlaZsqdgSm8VJZVPCvU2a/J8Hr9J7PW+j7cfUm1k7DNbwX47HKoeS5IfvUZD1qvWLf5xkiPxV8WORPNsel5rh8A9/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719304; c=relaxed/simple;
	bh=tozVDqb6hggNZyf4iiZsDRCXAIfyEAYWqXu0b80Atuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMyGbCDXp1/pxD1HGOkUaR1Xta3isH7sL9zWGFY1kDC55llA7cpKOG5OHOCqW2Mm3iwd/xgdb+gYOUPj7ULp/C3HKMafIqq4zhQMQzwxyr+XfWGaEIn/+sd/dIzMeI9wpUmO8StwWvD31NsATZlqF9uHOOczR/KrvwGRrh5HWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MwgQvcvk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OqpuF0Yw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MwgQvcvk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OqpuF0Yw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F54B4EDF5;
	Thu,  9 Apr 2026 07:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775719301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESt4c0B8oOSEtkd+8LJXFtuu42Yc6K56200il9oR8Ts=;
	b=MwgQvcvkocHrUrSYzXzcSGpLTN9LmNoPNost69oIb3tYDmegXcIx3mCVExdKZq3IMiWiml
	oWoa5hBrQgtUqIs/jP9iB5yuo5jlpO0TpsY1RQPXlv8mESwV34XV2BxxUfvGsxVq3EnMmW
	yUSSvl4rEanxFGNgqr9ytKBNTCfP9Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775719301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESt4c0B8oOSEtkd+8LJXFtuu42Yc6K56200il9oR8Ts=;
	b=OqpuF0YwK4VoT8f/ASHl/EGTw57DTLAUSEpPrZm8NcxxitUZvBvhqcvHVU5vvEdPaynI1P
	hF9BuqaT/bjI5AAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MwgQvcvk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OqpuF0Yw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775719301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESt4c0B8oOSEtkd+8LJXFtuu42Yc6K56200il9oR8Ts=;
	b=MwgQvcvkocHrUrSYzXzcSGpLTN9LmNoPNost69oIb3tYDmegXcIx3mCVExdKZq3IMiWiml
	oWoa5hBrQgtUqIs/jP9iB5yuo5jlpO0TpsY1RQPXlv8mESwV34XV2BxxUfvGsxVq3EnMmW
	yUSSvl4rEanxFGNgqr9ytKBNTCfP9Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775719301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESt4c0B8oOSEtkd+8LJXFtuu42Yc6K56200il9oR8Ts=;
	b=OqpuF0YwK4VoT8f/ASHl/EGTw57DTLAUSEpPrZm8NcxxitUZvBvhqcvHVU5vvEdPaynI1P
	hF9BuqaT/bjI5AAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34D924A0B3;
	Thu,  9 Apr 2026 07:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CcHhDIVT12mbSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 Apr 2026 07:21:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E4924A0A7E; Thu,  9 Apr 2026 09:21:36 +0200 (CEST)
Date: Thu, 9 Apr 2026 09:21:36 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: kick writeback flusher instead of inline
 flush for IOCB_DONTCACHE
Message-ID: <gpcc6t5unsoepakjdffsmnmd5duuvijxwdochd753ttix75h7l@nahwzi4qfdcq>
References: <20260408-dontcache-v2-0-948dec1e756b@kernel.org>
 <20260408-dontcache-v2-1-948dec1e756b@kernel.org>
 <adc-Q1iDWHD5yxHH@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc-Q1iDWHD5yxHH@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20790-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B61163C6F9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed 08-04-26 22:50:59, Christoph Hellwig wrote:
> On Wed, Apr 08, 2026 at 10:25:21AM -0400, Jeff Layton wrote:
> > +/**
> > + * filemap_dontcache_kick_writeback - kick flusher for IOCB_DONTCACHE writes
> > + * @mapping:	address_space that was just written to
> > + *
> > + * Wake the BDI flusher thread to start writeback of dirty pages in the
> > + * background.
> > + */
> > +void filemap_dontcache_kick_writeback(struct address_space *mapping)
> > +{
> > +	wakeup_flusher_threads_bdi(inode_to_bdi(mapping->host),
> > +				   WB_REASON_DONTCACHE);
> > +}
> 
> wakeup_flusher_threads_bdi ends up calling wb_start_writeback eventually,
> which sets WB_start_all, pushes the reason to start_all_reason and then
> does the actual wakeup.
> 
> The flusher thread then through wb_check_start_all does a WB_SYNC_NONE
> writeback based on get_nr_dirty_pages.  Which seems wrong - we don't
> want to do a huge writeback evertime the some DONTCACHE write finished.

This is all true and I can certainly construct a workload where this
behavior will lead to big regressions in performance - for example one
process creating say 1G temporary file and deleting it shortly after
creation + one process doing small DONTCACHE writes. Before this change
only DONTCACHE writes will make it to the disk and temporary file will only
be in the page cache, after this change you pay for allocating, writing
back, and deleting the temporary file.

> So I think you'll want a new WB_start_dontcache bit, a new
> get_nr_dontcache_pages() helper on a new node counter, etc.

But I'm not sure how you imagine this would work without restricting
writeback to particular inodes. Maybe we could mark inodes which have
folios with dropbehind set and make flush worker only write such inodes?
That would probably require tracking number of folios with dropbehind flag
per inode but that wouldn't be too bad. Or we could just lazily clear this
"inode has dropbehind folios" flag once the inode is clean.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

