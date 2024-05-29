Return-Path: <linux-nfs+bounces-3477-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C998D3BF4
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 18:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591FFB27692
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24885181CF8;
	Wed, 29 May 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JGgQP1Z2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TEjna/02";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xdGxr/EH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hjw9tILK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE8181D14
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999076; cv=none; b=FQhCVugnvPLXKTc9aFiNvZz42MqV2P+YmKri3GSDHo6E5WPAqwS0vTX9n118GTArkweLKYcUze7+ThW4dUWRc30GyFG4RJ8gjky90hD39z6PubLLaD83iDIQuaNQhFKmZ7lmbmMURdltvnFwPAVj+xPLVzwWfLOp241+nNLnxes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999076; c=relaxed/simple;
	bh=QHrqEB7yrm1PyW2hX4yofMUgtq4CafjXyL0rpTwEczU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s3eQOWW38ysju7R2lEJDCW9oqSzPHbqw4aSJj8vdyR+3QcMWfaBn8QnJzCA7h9atg6GEAH7OXWR3TBASm+sA5cbLYS0+jdB+3znYeOLxtZuSCxKu2g4Hsbbq1B3J6KOYT7e+fek5O5LjYqGKYt4O5y23zLfokY8VHdlVzFwXldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JGgQP1Z2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TEjna/02; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xdGxr/EH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hjw9tILK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 227CA336DF;
	Wed, 29 May 2024 16:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716999072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=nbAWh9s7p+BIPcwV8b4y5A/oV6GEaBAy4mKrVsP6YYQ=;
	b=JGgQP1Z2m/G6omB/fULx0eqj8y0ksROX3E6c5MjKPAFwpmPaenXeBddiVMH36AaLVJAr6+
	sNsgXPaYAWQzNtR7rpFPQb6tKpCTGloAASvA6gDyEhPoJ5tT9PpNdqxraomN5uZNL9bFOr
	Cw/0/aoo3tfoRT/Ft36nH2mYxijGRiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716999072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=nbAWh9s7p+BIPcwV8b4y5A/oV6GEaBAy4mKrVsP6YYQ=;
	b=TEjna/02nu/QvSwFSnVPGAYJDvpOk1EzKvOr/COP6B9L9SOTx4+1lfoMzDmop0JPeqatmp
	nvyCOMAx9UKF/NBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="xdGxr/EH";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hjw9tILK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716999071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=nbAWh9s7p+BIPcwV8b4y5A/oV6GEaBAy4mKrVsP6YYQ=;
	b=xdGxr/EHhxToG8QbcsKwF7gCMh1g31P2h67caC7hoFn/WYCdBfiUEL/wCnTk2jFz6Kbb1f
	n9k/R6y8zgiela1mxRrJ5HqEUt80vWtnj5KIeMkoiHTuOkuDIaMWjDBelk2G90TQwdd5QW
	p66m/c64lAAz4uty3pAQ/qrGCfHZtNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716999071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=nbAWh9s7p+BIPcwV8b4y5A/oV6GEaBAy4mKrVsP6YYQ=;
	b=hjw9tILK/37UxiOZ9PyHwDQ42NKhSYrt3xOluaGkrK7/FYZIJpa9R095dQ+BU18rMA29Kt
	akPi5QgirnHR6xCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FCEB1372E;
	Wed, 29 May 2024 16:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 23DdA59TV2bKAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 29 May 2024 16:11:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A66A1A082D; Wed, 29 May 2024 18:11:02 +0200 (CEST)
Date: Wed, 29 May 2024 18:11:02 +0200
From: Jan Kara <jack@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, nfbrown@suse.com
Subject: NFS write congestion size
Message-ID: <20240529161102.5x3hhnbz32lwjcej@quack3>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 227CA336DF
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
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]

Hello,

so I was investigating why random writes to a large file over NFS got
noticeably slower. The workload we use to test this is this fio command:

fio --direct=0 --ioengine=sync --thread --directory=/mnt --invalidate=1 \
    --group_reporting=1 --runtime=300 --fallocate=posix --ramp_time=10 \
    --name=RandomWrites-async-257024-4k-4 --new_group --rw=randwrite \
    --size=32000m --numjobs=4 --bs=4k --fsync_on_close=1 --end_fsync=1 \
    --filename_format='FioWorkloads.$jobnum'

Eventually I've tracked down the regression to be caused by 6df25e58532b
("nfs: remove reliance on bdi congestion") which changed the congestion
mechanism from a generic bdi congestion handling to NFS private one. Before
this commit the fio achieved throughput of 180 MB/s, after this commit only
120 MB/s. Now part of the regression was actually caused by inefficient
fsync(2) and the fact that more dirty data was cached at the time of the
last fsync after commit 6df25e58532b. After fixing fsync [1], the
throughput got to 150 MB/s so better but still not quite the throughput
before 6df25e58532b.

The reason for remaining regression is that bdi congestion handling was
broken and the client had happily ~8GB of outstanding IO against the server
despite the congestion limit was 256 MB. The new congestion handling
actually works but as a result the server does not have enough dirty data
to efficiently operate on and the server disk often gets idle before the
client can send more.

I wanted to discuss possible solutions here.

Generally 256MB is not enough even for consumer grade contemporary disks to
max out throughput. There is tunable /proc/sys/fs/nfs/nfs_congestion_kb.
If I tweak it to say 1GB, that is enough to give the server enough data to
saturate the disk (most of the time) and fio reaches 180MB/s as before
commit 6df25e58532b. So one solution to the problem would be to change the
default of nfs_congestion_kb to 1GB.

Generally the problem with this tuning is that faster disks may need even
larger nfs_congestion_kb, the NFS client has no way of knowing what the
right value of nfs_congestion_kb is. I personally find the concept of
client throttling writes to the server flawed. The *server* should push
back (or throttle) if the client is too aggressively pushing out the data
and then the client can react to this backpressure. Because only the server
knows how much it can handle (also given the load from other clients). And
I believe this is actually what is happening in practice (e.g. when I tune
nfs_congestion_kb to really high number). So I think even better solution
may be to just remove the write congestion handling from the client
completely. The history before commit 6df25e58532b, when congestion was
effectively ignored, shows that this is unlikely to cause any practical
problems. What do people think?

								Honza


[1] https://lore.kernel.org/all/20240524161419.18448-1-jack@suse.cz
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

