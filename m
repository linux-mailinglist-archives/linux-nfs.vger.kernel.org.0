Return-Path: <linux-nfs+bounces-3824-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2FB908B00
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 13:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE8E28B2C8
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 11:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E20195B2E;
	Fri, 14 Jun 2024 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LgdT67BI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d5uuGFkK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LgdT67BI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d5uuGFkK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A958195B01
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365488; cv=none; b=m68DXTIFqNXDicnahIQszSXQlssMsPljY61+C5K/neOZfki6mGmc4X64oTicQZ7c6w8G3QA/LOaswanaWY5xcbNN/b2LrykFGpbAjz2Rqa4+EjtaE99n5CHpngFpWmVhVSrKyPIX8CjacLwc9h0dDJ9aQbVdezWX2Ly576UV2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365488; c=relaxed/simple;
	bh=UQ1RCOoZpuGIlYrS90jBn3aoFUWzsIhHbTZ/u5KjFpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bztYF8EyhX/o8O8oDDxhHgBMO32l6e/hDXqwDJHKPcu6q+oFrHSS+CYueVzBF4E6fOY9ZOshBwZRW1cLtNO2DDD5G4HSjEim1psh1t0G+zucL4SFVCj40JWkoyliXSuSxqBmUUoMtdoWiIR+Ec+ZNciZqfGftzVlIJLpS6LWytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LgdT67BI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d5uuGFkK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LgdT67BI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d5uuGFkK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2F6633762;
	Fri, 14 Jun 2024 11:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718365484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s79Mswwa32fqc3FE10ziOxrNgVICRtlsk9bFQiUyJKc=;
	b=LgdT67BIRnXOGevN58CAcFZoHfTBL3htVUes3A5cdyKRFAJxszAcXRU84kKSH9MMuoBket
	PGvYDjGJWA9GmE8PZzPZU6dBGTl9O+bkY2FY5bw7QBgzQ7HNzNrq+pj5zszI1yY0cC/YIB
	JUu7zrbnLGSh6MMoxXZY09EFgmq2Sjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718365484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s79Mswwa32fqc3FE10ziOxrNgVICRtlsk9bFQiUyJKc=;
	b=d5uuGFkKs6DC8c9E7VYmWbIfi2fxXEQraztasG+8UidYrxQd2ghdkcUv5widVYSS5GZMJD
	FAPMXr+o2VTOGMDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LgdT67BI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d5uuGFkK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718365484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s79Mswwa32fqc3FE10ziOxrNgVICRtlsk9bFQiUyJKc=;
	b=LgdT67BIRnXOGevN58CAcFZoHfTBL3htVUes3A5cdyKRFAJxszAcXRU84kKSH9MMuoBket
	PGvYDjGJWA9GmE8PZzPZU6dBGTl9O+bkY2FY5bw7QBgzQ7HNzNrq+pj5zszI1yY0cC/YIB
	JUu7zrbnLGSh6MMoxXZY09EFgmq2Sjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718365484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s79Mswwa32fqc3FE10ziOxrNgVICRtlsk9bFQiUyJKc=;
	b=d5uuGFkKs6DC8c9E7VYmWbIfi2fxXEQraztasG+8UidYrxQd2ghdkcUv5widVYSS5GZMJD
	FAPMXr+o2VTOGMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A968A13AAF;
	Fri, 14 Jun 2024 11:44:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kSlWKSwtbGZ7HQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 14 Jun 2024 11:44:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 53447A0873; Fri, 14 Jun 2024 13:44:44 +0200 (CEST)
Date: Fri, 14 Jun 2024 13:44:44 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 3/3] nfs: Block on write congestion
Message-ID: <20240614114444.pcipucez7zqmrnkb@quack3>
References: <20240612153022.25454-1-jack@suse.cz>
 <20240613082821.849-3-jack@suse.cz>
 <fe224e6691204c200f9dced6aa56380cb4ddb3e6.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe224e6691204c200f9dced6aa56380cb4ddb3e6.camel@kernel.org>
X-Rspamd-Queue-Id: B2F6633762
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu 13-06-24 16:04:12, Jeff Layton wrote:
> On Thu, 2024-06-13 at 10:28 +0200, Jan Kara wrote:
> > Commit 6df25e58532b ("nfs: remove reliance on bdi congestion")
> > introduced NFS-private solution for limiting number of writes
> > outstanding against a particular server. Unlike previous bdi congestion
> > this algorithm actually works and limits number of outstanding writeback
> > pages to nfs_congestion_kb which scales with amount of client's memory
> > and is capped at 256 MB. As a result some workloads such as random
> > buffered writes over NFS got slower (from ~170 MB/s to ~126 MB/s). The
> > fio command to reproduce is:
> > 
> 
> That 256M cap was set back in 2007. I wonder if we ought to reconsider
> that. It might be worth experimenting these days with a higher cap on
> larger machines. Might that improve throughput even more?

In theory it may help but in my setup I didn't observe it. So I've decided
to leave the limit alone for now. But I certainly would not object if
someone decided to increase it as 256MB seems a bit low buffer space for
writeback given contemporary IO speeds, I just didn't have numbers to back
that decision.

> > fio --direct=0 --ioengine=sync --thread --invalidate=1 --group_reporting=1
> >   --runtime=300 --fallocate=posix --ramp_time=10 --new_group --rw=randwrite
> >   --size=64256m --numjobs=4 --bs=4k --fsync_on_close=1 --end_fsync=1
> > 
> > This happens because the client sends ~256 MB worth of dirty pages to
> > the server and any further background writeback request is ignored until
> > the number of writeback pages gets below the threshold of 192 MB. By the
> > time this happens and clients decides to trigger another round of
> > writeback, the server often has no pages to write and the disk is idle.
> > 
> > To fix this problem and make the client react faster to eased congestion
> > of the server by blocking waiting for congestion to resolve instead of
> > aborting writeback. This improves the random 4k buffered write
> > throughput to 184 MB/s.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/nfs/client.c           |  1 +
> >  fs/nfs/write.c            | 12 ++++++++----
> >  include/linux/nfs_fs_sb.h |  1 +
> >  3 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index 3b252dceebf5..8286edd6062d 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -994,6 +994,7 @@ struct nfs_server *nfs_alloc_server(void)
> >  
> >  	server->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
> >  
> > +	init_waitqueue_head(&server->write_congestion_wait);
> >  	atomic_long_set(&server->writeback, 0);
> >  
> >  	ida_init(&server->openowner_id);
> > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > index c6255d7edd3c..21a5f1e90859 100644
> > --- a/fs/nfs/write.c
> > +++ b/fs/nfs/write.c
> > @@ -423,8 +423,10 @@ static void nfs_folio_end_writeback(struct folio *folio)
> >  
> >  	folio_end_writeback(folio);
> >  	if (atomic_long_dec_return(&nfss->writeback) <
> > -	    NFS_CONGESTION_OFF_THRESH)
> > +	    NFS_CONGESTION_OFF_THRESH) {
> >  		nfss->write_congested = 0;
> > +		wake_up_all(&nfss->write_congestion_wait);
> > +	}
> >  }
> >  
> >  static void nfs_page_end_writeback(struct nfs_page *req)
> > @@ -698,12 +700,14 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
> >  	struct nfs_pageio_descriptor pgio;
> >  	struct nfs_io_completion *ioc = NULL;
> >  	unsigned int mntflags = NFS_SERVER(inode)->flags;
> > +	struct nfs_server *nfss = NFS_SERVER(inode);
> >  	int priority = 0;
> >  	int err;
> >  
> > -	if (wbc->sync_mode == WB_SYNC_NONE &&
> > -	    NFS_SERVER(inode)->write_congested)
> > -		return 0;
> > +	/* Wait with writeback until write congestion eases */
> > +	if (wbc->sync_mode == WB_SYNC_NONE && nfss->write_congested)
> > +		wait_event(nfss->write_congestion_wait,
> > +			   nfss->write_congested == 0);
> >  
> 
> It seems odd to block here, but if that helps throughput then so be it.

Well, I've kept the place where writeback throttling is decided. Another
logical possibility would be to handle the blocking in
nfs_writepages_callback() more like it happens for standard block device
filesystems which block in submit_bio(). Just there it would potentially
require more work as AFAIU we can have some unfinished RPC requests which
we may need to flush before blocking or something similar (similarly to how
we unplug IO on schedule). So I wasn't really comfortable in moving the
blocking there.

> >  	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGES);
> >  
> > diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> > index 92de074e63b9..38a128796a76 100644
> > --- a/include/linux/nfs_fs_sb.h
> > +++ b/include/linux/nfs_fs_sb.h
> > @@ -140,6 +140,7 @@ struct nfs_server {
> >  	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
> >  	struct nlm_host		*nlm_host;	/* NLM client handle */
> >  	struct nfs_iostats __percpu *io_stats;	/* I/O statistics */
> > +	wait_queue_head_t	write_congestion_wait;	/* wait until write congestion eases */
> >  	atomic_long_t		writeback;	/* number of writeback pages */
> >  	unsigned int		write_congested;/* flag set when writeback gets too high */
> >  	unsigned int		flags;		/* various flags */
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

