Return-Path: <linux-nfs+bounces-3481-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5048D407F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 23:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DAA1C20F55
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A377B139588;
	Wed, 29 May 2024 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OoBxOUPd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+gs8B/N9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LRCMsFzw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vGbZvWhf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC515D5B3
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019285; cv=none; b=kfkCkiuYqlUaUDYPnZ3qBMoyDVI+AhDFO7XLmuyG6WSpddLfivwiGtX4ky+Blnv8SMKjsEh6leXRe5EjbPcvGyWNmN3EApmvAYcFhxbqKfvGPOMQYM5OeAZp/TLecByzscD1JXfn4e0YTiQL9OPgJlj4qgh0ZJS11aNf/2mb7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019285; c=relaxed/simple;
	bh=UdDXh/8X5DXbLISV3eHT+Fy6CK7KZ1rybqLbVr7M2Gg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cf9Uixkj3oDJzYeEkjKjJSH0+Zo4w0OTk+wyOn3Sq59JPdf5g3yZjIoOH4yQGRh9t9YoCwhwt6UiUkP5qqAk4tj5/5QktdgI+E96+a6YDt5eQLOpU3v4/SJXBrFS4YfaWSDTSxjy8Mj0moUSHQ5tWC9MoWZDJZ2VjCGgxP5fyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OoBxOUPd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+gs8B/N9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LRCMsFzw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vGbZvWhf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C03DA33743;
	Wed, 29 May 2024 21:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717019281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKkHCLNtbRbYGL8lsNOT9rUTuZxVL3NNCDcyp3l+HTI=;
	b=OoBxOUPdqsbHGolyTKiqx5xBwt0K1D01EgJtenXDDGNaLgrbf1jhThMiNAC3lzAm2iYcxu
	nciz6oYLv3TdoLD98e+Vxw42/d38bdAMuT2jrw7kzwvPkcDUx3ydgk221sSxiODn+0fFsZ
	4PS7ll9Yeob0qxI0D8rIuDhdxrmh2dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717019281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKkHCLNtbRbYGL8lsNOT9rUTuZxVL3NNCDcyp3l+HTI=;
	b=+gs8B/N95TtRqjb76yo23EW6qYsug7OAlnlAGfi1EpEggcInV+XmX/A6c9ms6xmXEfWv1K
	lFPEqbojRDEChEAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LRCMsFzw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vGbZvWhf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717019279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKkHCLNtbRbYGL8lsNOT9rUTuZxVL3NNCDcyp3l+HTI=;
	b=LRCMsFzwHTnn8JDFoQ04+9n5Bf40P46PH36VgRYVvQ3mGTxpn2LDDQF4EciPr+Ml1Nxhi/
	5+Lrd5kZDS0x0BO83wx4ZzavWAByBIsHEBLTxEB0N0iMrPPq0sEWn5h3m+FMxYPoz4CvD/
	RJIygyy32NGACzQlorU2HP8+IOsMNeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717019279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKkHCLNtbRbYGL8lsNOT9rUTuZxVL3NNCDcyp3l+HTI=;
	b=vGbZvWhfVZhIbVu2kkQ7San45gSUokvLV/aiiD1lThBD7r2VziclXg9p8d3D5q99M4R4m/
	86UoNZcPktrOrFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D666E13A6B;
	Wed, 29 May 2024 21:47:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r63IHY2iV2b0XwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 29 May 2024 21:47:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@hammerspace.com>
Cc: "jack@suse.cz" <jack@suse.cz>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "anna@kernel.org" <anna@kernel.org>
Subject: Re: NFS write congestion size
In-reply-to: <4a4368fbc260b22ff96593cedc53954b2cbe47fd.camel@hammerspace.com>
References: <20240529161102.5x3hhnbz32lwjcej@quack3>,
 <4a4368fbc260b22ff96593cedc53954b2cbe47fd.camel@hammerspace.com>
Date: Thu, 30 May 2024 07:47:49 +1000
Message-id: <171701926974.14261.6427933703776059666@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C03DA33743
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]

On Thu, 30 May 2024, Trond Myklebust wrote:
> On Wed, 2024-05-29 at 18:11 +0200, Jan Kara wrote:
> > Hello,
> > 
> > so I was investigating why random writes to a large file over NFS got
> > noticeably slower. The workload we use to test this is this fio
> > command:
> > 
> > fio --direct=0 --ioengine=sync --thread --directory=/mnt --
> > invalidate=1 \
> >     --group_reporting=1 --runtime=300 --fallocate=posix --
> > ramp_time=10 \
> >     --name=RandomWrites-async-257024-4k-4 --new_group --rw=randwrite
> > \
> >     --size=32000m --numjobs=4 --bs=4k --fsync_on_close=1 --
> > end_fsync=1 \
> >     --filename_format='FioWorkloads.$jobnum'
> > 
> > Eventually I've tracked down the regression to be caused by
> > 6df25e58532b
> > ("nfs: remove reliance on bdi congestion") which changed the
> > congestion
> > mechanism from a generic bdi congestion handling to NFS private one.
> > Before
> > this commit the fio achieved throughput of 180 MB/s, after this
> > commit only
> > 120 MB/s. Now part of the regression was actually caused by
> > inefficient
> > fsync(2) and the fact that more dirty data was cached at the time of
> > the
> > last fsync after commit 6df25e58532b. After fixing fsync [1], the
> > throughput got to 150 MB/s so better but still not quite the
> > throughput
> > before 6df25e58532b.
> > 
> > The reason for remaining regression is that bdi congestion handling
> > was
> > broken and the client had happily ~8GB of outstanding IO against the
> > server
> > despite the congestion limit was 256 MB. The new congestion handling
> > actually works but as a result the server does not have enough dirty
> > data
> > to efficiently operate on and the server disk often gets idle before
> > the
> > client can send more.
> > 
> > I wanted to discuss possible solutions here.
> > 
> > Generally 256MB is not enough even for consumer grade contemporary
> > disks to
> > max out throughput. There is tunable
> > /proc/sys/fs/nfs/nfs_congestion_kb.
> > If I tweak it to say 1GB, that is enough to give the server enough
> > data to
> > saturate the disk (most of the time) and fio reaches 180MB/s as
> > before
> > commit 6df25e58532b. So one solution to the problem would be to
> > change the
> > default of nfs_congestion_kb to 1GB.
> > 
> > Generally the problem with this tuning is that faster disks may need
> > even
> > larger nfs_congestion_kb, the NFS client has no way of knowing what
> > the
> > right value of nfs_congestion_kb is. I personally find the concept of
> > client throttling writes to the server flawed. The *server* should
> > push
> > back (or throttle) if the client is too aggressively pushing out the
> > data
> > and then the client can react to this backpressure. Because only the
> > server
> > knows how much it can handle (also given the load from other
> > clients). And
> > I believe this is actually what is happening in practice (e.g. when I
> > tune
> > nfs_congestion_kb to really high number). So I think even better
> > solution
> > may be to just remove the write congestion handling from the client
> > completely. The history before commit 6df25e58532b, when congestion
> > was
> > effectively ignored, shows that this is unlikely to cause any
> > practical
> > problems. What do people think?
> 
> I think we do still need a mechanism to prevent the client from pushing
> more writebacks into the RPC layer when the server throttling is
> causing RPC transmission queues to build up. Otherwise we end up
> increasing the latency when the application is trying to do more I/O to
> pages that are queued up for writeback in the RPC layer (since the
> latter will be write locked).

If latency is the issue, could be make the throttling time-based?
So we throttle if the oldest queued request is more than X seconds old?
How easy is it to find the oldest queued request?

NeilBrown

