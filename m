Return-Path: <linux-nfs+bounces-2227-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565A4874EF9
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 13:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D6BB234D1
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F6E12A154;
	Thu,  7 Mar 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dzYjVHHz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bsQVyYHi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SHbLip5L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fNHQXagz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25D85295;
	Thu,  7 Mar 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814404; cv=none; b=qPVfFg8ZGgwNElD+e4eCXzcfyIetAZIwBFMNXI8UjcszQm8/M22lMecfFLadyQjPig7EE9++VcveXqTz7Sstri5eCIw9HYrtCOUKc5jNp8NJ25k6nvSVusdaOSquB2agfOjZcCp0szWiJizMWCGLP6+3rWwe3LEDJMvdG64BTNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814404; c=relaxed/simple;
	bh=BhNGlpsq99Ce0tfJp3Cxo3xzk/R9OIoRQOCGH3lcS1w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=li3rB6q1viD4GnsfW2tiruTomFhJw2clvPetFd22bzwpDlqXrk/05bpuexCU7lo6wgqep+Y2sDHqYvN/6Ad4jh3e8cHNTsc4LGlXU6j4U9FCPfW1XWwWXDk/svEmF6raLT4YSJ0eO1j4iWYGVRmM0qQ4vOBPTvIT+EL2lwAnisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dzYjVHHz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bsQVyYHi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SHbLip5L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fNHQXagz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 522328CADD;
	Thu,  7 Mar 2024 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709811709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lgx+StLjDkO3YYKmbxg12umPyztFQfIPqwIN0q1WYE=;
	b=dzYjVHHzpSliGzafLPA+2yuxMihPcaZAioLEBF6Pvoch87/HcgfPUENd7EFr3Q53vHXMzk
	00pNRJL0U2ysQI0RKyJbr4RtnFN9CutpOZ6k+VmzWpHnyS1OFOOnfcvm8QJ6V8cr9x4VGz
	1C971132FEUmc2WYDqIzbXPqYUv0QqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709811709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lgx+StLjDkO3YYKmbxg12umPyztFQfIPqwIN0q1WYE=;
	b=bsQVyYHiGTeNoAFpbRpWqbBIOcuQWR6Pe8akhIXCfhyiDm2EXxA7Y1biY7xXcE9koHuxAB
	gidzHjjWnNNBlBBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709811708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lgx+StLjDkO3YYKmbxg12umPyztFQfIPqwIN0q1WYE=;
	b=SHbLip5L3jZPWQgehFa2E/fq2LpQ3Uyqp79MY7n+VGICliELG+p37goMKihjD8PXOJ9WTv
	Ls+dpSO1+5wnbptaY7SRxq/dcjSDj7v9yHxjgB4GRa3ui1TvtTVRvrdgrBFydt9fuBnKvB
	i5DBTRSodNY3h3e8UZuW+tVFlSnhtq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709811708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lgx+StLjDkO3YYKmbxg12umPyztFQfIPqwIN0q1WYE=;
	b=fNHQXagzFnMUvpgKPNM/s0ExGGb1Xj/+yIfvFiQdmn775K3XvMTEU4qDv3pIhYYJZKleJH
	6bUeiDrJWPfsNgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC2CD12FC5;
	Thu,  7 Mar 2024 11:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KZ/aE/mn6WVUOwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 07 Mar 2024 11:41:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: stable@vger.kernel.org,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org,
 "Dan Aloni" <dan.aloni@vastdata.com>
Subject:
 Re: [PATCH stable 6.6 and 6.7] NFS: Fix data corruption caused by congestion.
In-reply-to: <cfec488eccfc3469d18dd94b05a00919cc152113.camel@kernel.org>
References: <170907621128.24797.4390391329078744015@noble.neil.brown.name>,
 <cfec488eccfc3469d18dd94b05a00919cc152113.camel@kernel.org>
Date: Thu, 07 Mar 2024 22:41:41 +1100
Message-id: <170981170160.13576.347273159851012933@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[22.96%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[poczta.fm:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Thu, 07 Mar 2024, Jeff Layton wrote:
> On Wed, 2024-02-28 at 10:23 +1100, NeilBrown wrote:
> > when AOP_WRITEPAGE_ACTIVATE is returned (as NFS does when it detects
> > congestion) it is important that the folio is redirtied.
> > nfs_writepage_locked() doesn't do this, so files can become corrupted as
> > writes can be lost.
> > 
> > Note that this is not needed in v6.8 as AOP_WRITEPAGE_ACTIVATE cannot be
> > returned.  It is needed for kernels v5.18..v6.7.  Prior to 6.3 the patch
> > is different as it needs to mention "page", not "folio".
> > 
> 
> Neil, I have a question about the above statement. In Linus's tree as of
> this morning (v6.8-rc7-ish), it does this in nfs_writepages_locked:
> 
>         if (wbc->sync_mode == WB_SYNC_NONE &&
>             NFS_SERVER(inode)->write_congested)           
>                 return AOP_WRITEPAGE_ACTIVATE;
> 
> The only caller of nfs_writepages_locked, and I don't see where it
> redirties the page. Why don't we need this in v6.8?

You are right - it doesn't redirty anything.  But there is no bug
here....
I didn't see it at first either, but the only caller of
nfs_writepage_locked() is nfs_wb_folio() (as you say) and that always
passes a wbc with .sync_mode = WB_SYNC_ALL.  So sync_mode is never
WB_SYNC_NODE and the code snippet you included above is dead code.  I've
already posted a patch to Trond and Anna to remove that code.

Thanks for the review!

NeilBrown

> 
> 
> > Reported-and-tested-by: Jacek Tomaka <Jacek.Tomaka@poczta.fm>
> > Fixes: 6df25e58532b ("nfs: remove reliance on bdi congestion")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfs/write.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > index b664caea8b4e..9e345d3c305a 100644
> > --- a/fs/nfs/write.c
> > +++ b/fs/nfs/write.c
> > @@ -668,8 +668,10 @@ static int nfs_writepage_locked(struct folio *folio,
> >  	int err;
> >  
> >  	if (wbc->sync_mode == WB_SYNC_NONE &&
> > -	    NFS_SERVER(inode)->write_congested)
> > +	    NFS_SERVER(inode)->write_congested) {
> > +		folio_redirty_for_writepage(wbc, folio);
> >  		return AOP_WRITEPAGE_ACTIVATE;
> > +	}
> >  
> >  	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
> >  	nfs_pageio_init_write(&pgio, inode, 0, false,
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


