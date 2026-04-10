Return-Path: <linux-nfs+bounces-20804-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLb6D6DV2GmuiwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20804-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 12:49:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDBC3D5D56
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 12:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F9230AB95A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499AF37BE8B;
	Fri, 10 Apr 2026 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MAuboDUn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vtmoDNux";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MAuboDUn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vtmoDNux"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064B38B13E
	for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817712; cv=none; b=ArBINRrCj2CCm8DqEJO/t9hnOkja6SxXr7n4cW0E8SNn3Pi38VIhX4FtYgzybWnOPzKTgPAdPv/3kxbcYamZO/IZvJ/0nO9fAFM1fqPzgAT5e7mPOFbe3O/Xt+fvt36kTUNFqEtdlLJuxZKMi0Ta/Gi3nzlmxkNF1AbnIHBgI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817712; c=relaxed/simple;
	bh=IrtOFMDLPl/jOZwF9p26m4Sdaj7zxxfK7csJ1tcTRvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVVG9oilFYSNMvyVvfMadXUFu0hFWrop2yRujD2ETLFe3WmHxh6zNXJHtJCpy0DCk1EKIyfvQTucjYFlayVHW/aCFXC3P/pmIBUdWZYJEGvI4ksuVMGqLMt2cD6w+a5m7MhUB76KBB4gBWW3w29/RDtRJl7KkZVUUXDfiOElFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MAuboDUn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vtmoDNux; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MAuboDUn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vtmoDNux; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E2A76A7EC;
	Fri, 10 Apr 2026 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775817709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyzQ6B0JHT7gSiWrC1iUMZgxNFOYNLK1JBVUTUgNXLo=;
	b=MAuboDUnRTvB1p5AvXQd7Ca/a5WeO79Wf5UIWAIi9ly28UBWX9cGVQrc8KS46aTdxhTfXX
	VzyamlIBHdkDvXInTk9Zr1FgQebeP0OHyXLheSxMc5KHtRTiElNDUUpVFEVQu4IpKe8lQc
	MM+jNJalYOIODafPdEpKHQw2erU39QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775817709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyzQ6B0JHT7gSiWrC1iUMZgxNFOYNLK1JBVUTUgNXLo=;
	b=vtmoDNuxdf0tOsRkhG44RJJGnBE4d5EyVq5TnJAbPLxhsSB2s8OXZJc3O4Hx+q+tdEejPZ
	6538q4HSX5cBqkDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MAuboDUn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vtmoDNux
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775817709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyzQ6B0JHT7gSiWrC1iUMZgxNFOYNLK1JBVUTUgNXLo=;
	b=MAuboDUnRTvB1p5AvXQd7Ca/a5WeO79Wf5UIWAIi9ly28UBWX9cGVQrc8KS46aTdxhTfXX
	VzyamlIBHdkDvXInTk9Zr1FgQebeP0OHyXLheSxMc5KHtRTiElNDUUpVFEVQu4IpKe8lQc
	MM+jNJalYOIODafPdEpKHQw2erU39QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775817709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyzQ6B0JHT7gSiWrC1iUMZgxNFOYNLK1JBVUTUgNXLo=;
	b=vtmoDNuxdf0tOsRkhG44RJJGnBE4d5EyVq5TnJAbPLxhsSB2s8OXZJc3O4Hx+q+tdEejPZ
	6538q4HSX5cBqkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 124FA4A0B2;
	Fri, 10 Apr 2026 10:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W1JwBO3T2Gl0BwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Apr 2026 10:41:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CCE51A0A81; Fri, 10 Apr 2026 12:41:48 +0200 (CEST)
Date: Fri, 10 Apr 2026 12:41:48 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: kick writeback flusher instead of inline
 flush for IOCB_DONTCACHE
Message-ID: <quptbqj7jfparfhrxt45cassborouvwggeqkwbk3ixyt74crb6@e7ivbuu5qlox>
References: <20260408-dontcache-v2-0-948dec1e756b@kernel.org>
 <20260408-dontcache-v2-1-948dec1e756b@kernel.org>
 <adc-Q1iDWHD5yxHH@infradead.org>
 <gpcc6t5unsoepakjdffsmnmd5duuvijxwdochd753ttix75h7l@nahwzi4qfdcq>
 <ade14lOI1CDiraar@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade14lOI1CDiraar@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20804-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 8EDBC3D5D56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu 09-04-26 07:21:22, Christoph Hellwig wrote:
> On Thu, Apr 09, 2026 at 09:21:36AM +0200, Jan Kara wrote:
> > > So I think you'll want a new WB_start_dontcache bit, a new
> > > get_nr_dontcache_pages() helper on a new node counter, etc.
> > 
> > But I'm not sure how you imagine this would work without restricting
> > writeback to particular inodes. Maybe we could mark inodes which have
> > folios with dropbehind set and make flush worker only write such inodes?
> 
> I'd only expedite writing by the number of pending dontcache folios.
> It would still write the least recently dirtied inodes.

So that may result in dontcache folios staying cached for quite some time
if DONTCACHE and normal writes are mixed. But I agree over longer time it
might just level out so maybe that's fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

