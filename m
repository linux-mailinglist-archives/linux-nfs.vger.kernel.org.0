Return-Path: <linux-nfs+bounces-3374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE28CE88B
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271081F24067
	for <lists+linux-nfs@lfdr.de>; Fri, 24 May 2024 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1285C58;
	Fri, 24 May 2024 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O711btv0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DS/gv8dz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O711btv0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DS/gv8dz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595E12E1CE
	for <linux-nfs@vger.kernel.org>; Fri, 24 May 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567372; cv=none; b=nRUR1ve8R9XiI/iz1dHCdB745+Etp/37G9iuz1VqmQwNVxh2N47XI4hgf5xYJIJebYoXAmyddpGRMUHCHmJrIEYQV5hsaeRmzb7/+DMZEixXwZnFzb4KgrFWG15xaiBOC+TSvu8zoKqHpbWWQMgbXSxNoBAsy37f3yoqWHfsmt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567372; c=relaxed/simple;
	bh=j9+s0Gm0NJDgnns3Lui6DGsILsiipcyUdFKKoa2QtgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMdycKcxRlCMLdLZQ762eLAa7SKK5qgoUg31+txVSZiWSWBIOFZuRqfEbT5TZaF9E7Nb1hM//7XcbKBStPMq6Y9GIIq3YODuW2GmsSK0r3BXOYsNceBke2I8M3SMjLOFw4CxJ4bUlHbXper8KudpWUJf0MN05aGaWH41+dbnPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O711btv0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DS/gv8dz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O711btv0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DS/gv8dz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B461F20B7C;
	Fri, 24 May 2024 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716567368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8anHM9u139ZjfIipPg6oD1Z+AvO08H0v0sAbQaJXoM=;
	b=O711btv08fPpg5y5c5fltH83aAeB7Q1s7POwESWYwbrQqPUX7T71BRUw+2PdD/xzY6YvZP
	kb5ri6lKCx3Qqzct9EGFys1z2q/scVyZqQZ+57CIKbyjHMPliFeLSWNpml1vVfulGSBvmM
	Ix3n4DnamVS/6dXeclRkM7jbRgvehl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716567368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8anHM9u139ZjfIipPg6oD1Z+AvO08H0v0sAbQaJXoM=;
	b=DS/gv8dzJNfU2yqhhx2zZyYUmIvBDR2BD5L8Ibsr8suHUuzBcgJfZsb3is8qFf25FeZopq
	enMsneFBhgkAWTCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O711btv0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="DS/gv8dz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716567368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8anHM9u139ZjfIipPg6oD1Z+AvO08H0v0sAbQaJXoM=;
	b=O711btv08fPpg5y5c5fltH83aAeB7Q1s7POwESWYwbrQqPUX7T71BRUw+2PdD/xzY6YvZP
	kb5ri6lKCx3Qqzct9EGFys1z2q/scVyZqQZ+57CIKbyjHMPliFeLSWNpml1vVfulGSBvmM
	Ix3n4DnamVS/6dXeclRkM7jbRgvehl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716567368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8anHM9u139ZjfIipPg6oD1Z+AvO08H0v0sAbQaJXoM=;
	b=DS/gv8dzJNfU2yqhhx2zZyYUmIvBDR2BD5L8Ibsr8suHUuzBcgJfZsb3is8qFf25FeZopq
	enMsneFBhgkAWTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8DBE13A6B;
	Fri, 24 May 2024 16:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mD84KUi9UGZCWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 24 May 2024 16:16:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 53746A0825; Fri, 24 May 2024 18:16:08 +0200 (CEST)
Date: Fri, 24 May 2024 18:16:08 +0200
From: Jan Kara <jack@suse.cz>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "jack@suse.cz" <jack@suse.cz>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Bad NFS performance for fsync(2)
Message-ID: <20240524161608.jy3ldr45mq2bjxjr@quack3>
References: <20240523165436.g5xgo7aht7dtmvfb@quack3>
 <271717b8f2a6b2121dbb529ed3a21a69467b0fa5.camel@hammerspace.com>
 <20240524131755.xtgt7zgz4ibdfdu7@quack3>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240524131755.xtgt7zgz4ibdfdu7@quack3>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B461F20B7C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email]

On Fri 24-05-24 15:17:55, Jan Kara wrote:
> On Thu 23-05-24 18:00:01, Trond Myklebust wrote:
> > On Thu, 2024-05-23 at 18:54 +0200, Jan Kara wrote:
> > > Hello!
> > > 
> > > I've been debugging NFS performance regression with recent kernels.
> > > It
> > > seems to be at least partially related to the following behavior of
> > > NFS
> > > (which is there for a long time AFAICT). Suppose the following
> > > workload:
> > > 
> > > fio --direct=0 --ioengine=sync --thread --directory=/test --
> > > invalidate=1 \
> > >   --group_reporting=1 --runtime=100 --fallocate=posix --ramp_time=10
> > > \
> > >   --name=RandomWrites-async --new_group --rw=randwrite --size=32000m
> > > \
> > >   --numjobs=4 --bs=4k --fsync_on_close=1 --end_fsync=1 \
> > >   --filename_format='FioWorkloads.$jobnum'
> > > 
> > > So we do 4k buffered random writes from 4 threads into 4 different
> > > files.
> > > Now the interesting behavior comes on the final fsync(2). What I
> > > observe is
> > > that the NFS server getting a stream of 4-8k writes which have
> > > 'stable'
> > > flag set. What the server does for each such write is that performs
> > > the
> > > write and calls fsync(2). Since by the time fio calls fsync(2) on the
> > > NFS
> > > client there is like 6-8 GB worth of dirty pages to write and the
> > > server
> > > effectively ends up writing each individual 4k page as O_SYNC write,
> > > the
> > > throughput is not great...
> > > 
> > > The reason why the client sets 'stable' flag for each page write
> > > seems to
> > > be because nfs_writepages() issues writes with FLUSH_COND_STABLE for
> > > WB_SYNC_ALL writeback and nfs_pgio_rpcsetup() has this logic:
> > > 
> > >         switch (how & (FLUSH_STABLE | FLUSH_COND_STABLE)) {
> > >         case 0:
> > >                 break;
> > >         case FLUSH_COND_STABLE:
> > >                 if (nfs_reqs_to_commit(cinfo))
> > >                         break;
> > >                 fallthrough;
> > >         default:
> > >                 hdr->args.stable = NFS_FILE_SYNC;
> > >         }
> > > 
> > > but since this is final fsync(2), there are no more requests to
> > > commit so
> > > we set NFS_FILE_SYNC flag.
> > > 
> > > Now I'd think the client is stupid in submitting so many
> > > NFS_FILE_SYNC
> > > writes instead of submitting all as async and then issuing commit
> > > (i.e.,
> > > the switch above in nfs_pgio_rpcsetup() could gain something like:
> > > 
> > > 		if (count > <small_magic_number>)
> > > 			break;
> > > 
> > > But I'm not 100% sure this is a correct thing to do since I'm not
> > > 100% sure
> > > about the FLUSH_COND_STABLE requirements. On the other hand it could
> > > be
> > > also argued that the NFS server could be more clever and batch the
> > > fsync(2)s for many sync writes to the same file. But there the
> > > heuristic is
> > > less clear.
> > > 
> > > So what do people think?
> > 
> > We can probably remove that case FLUSH_COND_STABLE in
> > nfs_pgio_rpcsetup() altogether, since we have the following just before
> > the call to nfs_pgio_rpcsetup()
> > 
> >         if ((desc->pg_ioflags & FLUSH_COND_STABLE) &&
> >             (desc->pg_moreio || nfs_reqs_to_commit(&cinfo)))
> >                 desc->pg_ioflags &= ~FLUSH_COND_STABLE;
> 
> Yeah, I was somewhat wondering about that as well. But my point was that
> the client should apparently be dropping FLUSH_COND_STABLE in more cases
> because currently fsync(2) submits several GB worth of dirty pages, each
> page with NFS_FILE_SYNC set. Which is suboptimal... I'll try to understand
> better why non of the above conditions is met.

OK, I think I've tracked the problem down. Patch submitted [1].

								Honza

[1] https://lore.kernel.org/r/20240524161419.18448-1-jack@suse.cz

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

