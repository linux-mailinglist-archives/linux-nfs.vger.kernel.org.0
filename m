Return-Path: <linux-nfs+bounces-4973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F82934015
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 17:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65101F23CDA
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E25374C2;
	Wed, 17 Jul 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PN02JVOT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QGXL5brI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PN02JVOT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QGXL5brI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50F17F393
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231892; cv=none; b=rZuMi7gC3aoYce5fczC7GcMcJSH2hwxX/WjHzUYq+dIFri/ofY7/iw0ns0c4Xb+wClkcWNQOA81rjhiDWpr3HTT4N+mhg8ZWn21S221O059ir220eVmyoSCIlOJ7HUXsNK17IJIzL8SppHs5cUZPShwLLwhRdJegn4a0NGMOJeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231892; c=relaxed/simple;
	bh=OIg5vg6zxTgfV//yjox4DqvU3E8KnLVsitlHMvyzCBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2t8q5tJ0JGmXgp6LggiZixQCBiby/CHfocniM4pr5fxMx+5zeW/jmssJf7moefaEHu7P6c7pKe1URrdf7IEpoUhIKT0aYnNpNlSmdGIqsdFffpgz+pUxV5jN1LbDtD90yAZsBWQCx3GUVn4KaG16GI8EN6AjKJPKkup71aHXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PN02JVOT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QGXL5brI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PN02JVOT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QGXL5brI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F5AF1FB81;
	Wed, 17 Jul 2024 15:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721231889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8eqGf7BAAZqFA4fRtpgXJHT1yvRcEvJlVBuOrD5nKo=;
	b=PN02JVOTQ49b3/2efNMXsJHz1/X14Lf+Q0CaBFiyjHOcnw6MKVzMs5Lzzvn2wJc1gGzIp2
	TdKdj4vSxNi+E6T2VPPLbfwADQNlGCy3lqgD/YSEXvVFjFMdZFvwwKgdycvzjzXnhlEfmk
	3so79OFoABh4N++XEQw1su1QYcZ1sc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721231889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8eqGf7BAAZqFA4fRtpgXJHT1yvRcEvJlVBuOrD5nKo=;
	b=QGXL5brIzPpZoEd5p+nUzgBAP3xR8Llkiexabwh9fPqFL03ukFvuxfyYi1O629b4wHiEky
	gnSV2hAs7x/lAZCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PN02JVOT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QGXL5brI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721231889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8eqGf7BAAZqFA4fRtpgXJHT1yvRcEvJlVBuOrD5nKo=;
	b=PN02JVOTQ49b3/2efNMXsJHz1/X14Lf+Q0CaBFiyjHOcnw6MKVzMs5Lzzvn2wJc1gGzIp2
	TdKdj4vSxNi+E6T2VPPLbfwADQNlGCy3lqgD/YSEXvVFjFMdZFvwwKgdycvzjzXnhlEfmk
	3so79OFoABh4N++XEQw1su1QYcZ1sc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721231889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8eqGf7BAAZqFA4fRtpgXJHT1yvRcEvJlVBuOrD5nKo=;
	b=QGXL5brIzPpZoEd5p+nUzgBAP3xR8Llkiexabwh9fPqFL03ukFvuxfyYi1O629b4wHiEky
	gnSV2hAs7x/lAZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 383F9136E5;
	Wed, 17 Jul 2024 15:58:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H/qyDRHql2bJIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 15:58:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BEF2FA0987; Wed, 17 Jul 2024 17:58:08 +0200 (CEST)
Date: Wed, 17 Jul 2024 17:58:08 +0200
From: Jan Kara <jack@suse.cz>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH RESEND v2 0/3] nfs: Improve throughput for random
 buffered writes
Message-ID: <20240717155808.hemnfxyrbfwu6euo@quack3>
References: <20240617073525.10666-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617073525.10666-1-jack@suse.cz>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 4F5AF1FB81

Ping? I don't see these patches being in NFS git tree. Did they fall
through the cracks?

								Honza

On Mon 01-07-24 12:50:45, Jan Kara wrote:
> [Resending because of messed up mailing list address]
> 
> Hello,
> 
> this is second revision of my patch series improving NFS throughput for
> buffered writes.
> 
> Changes since v1:
> * Added Reviewed-by tags
> * Made sleep waiting for congestion to resolve killable
> 
> Original cover letter below:
> 
> I was thinking how to best address the performance regression coming from
> NFS write congestion. After considering various options and concerns raised
> in the previous discussion, I've got an idea for a simple option that could
> help to keep the server more busy - just mimick what block devices do and
> block the flush worker waiting for congestion to resolve instead of aborting
> the writeback. And it actually helps enough that I don't think more complex
> solutions are warranted at this point.
> 
> This patch series has two preparatory cleanups and then a patch implementing
> this idea.
> 
> 								Honza
> 
> Previous versions:
> Link: http://lore.kernel.org/r/20240612153022.25454-1-jack@suse.cz # v1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

