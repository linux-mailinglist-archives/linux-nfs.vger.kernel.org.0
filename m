Return-Path: <linux-nfs+bounces-3485-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F0A8D4718
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BEBB21FAC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50BFDDA1;
	Thu, 30 May 2024 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NRn9H8iE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vlk+L6mL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uZ3sm8nk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U8lk110s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0723145352
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057921; cv=none; b=gsjzXhYHju5Kixg/gaOj2VWtdrNNBEYZfPnMx8aAE2QMl4P0yhQVZGtfxAGk3iIir9R44lgwMo72zD6USMoRitVWD1ZkEXJjLOvGICy/x/xDi6GQEA498eSg9zuMScdpxhsDacdVNC6ngdM7lLBPatF9wSiKQNwTiJzwPo5wwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057921; c=relaxed/simple;
	bh=/ZHihjIUeNrBrTt50aRsNahHxUgsSUOePPbNdBNhJa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVkqP4o0ql0NCM2AhKP74kuMSrhFlOtjKGFFBH6vWHdLZPXywzWMO1NGLX3wuMWS1ddKQ6KQuMnIEKwCKcH40VxvCdzo7HhCTkZ0vNAEF1vBm5Kbbb7MnGeLCkfq2E903iAAcxMfIuPi4apH8t7cq0PoRiq0ljAfx/dQFwy7WQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NRn9H8iE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vlk+L6mL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uZ3sm8nk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U8lk110s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5E593381E;
	Thu, 30 May 2024 08:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717057912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhLVE9indE6dsNQpPdQ4l0RyeMfvWxONuWlOkXhivII=;
	b=NRn9H8iEHdMZEu0nB9AFcPOrQLc+RxIT7WlpjNMisG8oH5ECAgCUVKH7185gBhhsNropK6
	GkfzcnIqHdJ6nvYDEf+sy2qMsp1tcDG4Z1o6DXqRCvhMzvzjtx6PwlOt7ZTPKLw37QiQgC
	Rk+8Wue/+3VwLwlPZssE92DwUhTGzmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717057912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhLVE9indE6dsNQpPdQ4l0RyeMfvWxONuWlOkXhivII=;
	b=vlk+L6mLNSbXI5h4RmSAq2tjx7fL0u2Wr8pa8ZNlPwYkhg4aojqQiwB7jXtXbtWQit+a0M
	zCaFr/aV4hWyFqAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uZ3sm8nk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U8lk110s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717057911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhLVE9indE6dsNQpPdQ4l0RyeMfvWxONuWlOkXhivII=;
	b=uZ3sm8nkS77deNiWqU7IZNo8BYAlOIrfhn7ygA+wirr0Wy2AaKNW7zfETjQaL5RrzkQ55D
	hrJHkOYTeRp5u3DxUNL0RpE+xWN85mJHpiEAE4sV6Kk+mFtJYVQt+qJKROPRjH+oGn8Cc6
	OXPVys0lVm8dxrQAHHub5fONmjXw4rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717057911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhLVE9indE6dsNQpPdQ4l0RyeMfvWxONuWlOkXhivII=;
	b=U8lk110sUGJUPpESMkLDorh1RzkZx+Xb72qIJY/OJQDjeGI0i0ALNnpNveu381MDkykDv8
	A3Zyqx29ldHvCLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAD9113A42;
	Thu, 30 May 2024 08:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GN9nNXc5WGY0DgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 May 2024 08:31:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90CFDA0A53; Thu, 30 May 2024 10:31:51 +0200 (CEST)
Date: Thu, 30 May 2024 10:31:51 +0200
From: Jan Kara <jack@suse.cz>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"nfbrown@suse.com" <nfbrown@suse.com>
Subject: Re: NFS write congestion size
Message-ID: <20240530083151.vwxw3sqzrfhglaed@quack3>
References: <20240529161102.5x3hhnbz32lwjcej@quack3>
 <4a4368fbc260b22ff96593cedc53954b2cbe47fd.camel@hammerspace.com>
 <440dcc5a-fdea-4677-9bad-b782e9801747@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <440dcc5a-fdea-4677-9bad-b782e9801747@grimberg.me>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E5E593381E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 30-05-24 10:44:01, Sagi Grimberg wrote:
> On 29/05/2024 20:05, Trond Myklebust wrote:
> > On Wed, 2024-05-29 at 18:11 +0200, Jan Kara wrote:
> > > Hello,
> > > 
> > > so I was investigating why random writes to a large file over NFS got
> > > noticeably slower. The workload we use to test this is this fio
> > > command:
> > > 
> > > fio --direct=0 --ioengine=sync --thread --directory=/mnt --
> > > invalidate=1 \
> > >      --group_reporting=1 --runtime=300 --fallocate=posix --
> > > ramp_time=10 \
> > >      --name=RandomWrites-async-257024-4k-4 --new_group --rw=randwrite
> > > \
> > >      --size=32000m --numjobs=4 --bs=4k --fsync_on_close=1 --
> > > end_fsync=1 \
> > >      --filename_format='FioWorkloads.$jobnum'
> > > 
> > > Eventually I've tracked down the regression to be caused by
> > > 6df25e58532b
> > > ("nfs: remove reliance on bdi congestion") which changed the
> > > congestion
> > > mechanism from a generic bdi congestion handling to NFS private one.
> > > Before
> > > this commit the fio achieved throughput of 180 MB/s, after this
> > > commit only
> > > 120 MB/s. Now part of the regression was actually caused by
> > > inefficient
> > > fsync(2) and the fact that more dirty data was cached at the time of
> > > the
> > > last fsync after commit 6df25e58532b. After fixing fsync [1], the
> > > throughput got to 150 MB/s so better but still not quite the
> > > throughput
> > > before 6df25e58532b.
> > > 
> > > The reason for remaining regression is that bdi congestion handling
> > > was
> > > broken and the client had happily ~8GB of outstanding IO against the
> > > server
> > > despite the congestion limit was 256 MB. The new congestion handling
> > > actually works but as a result the server does not have enough dirty
> > > data
> > > to efficiently operate on and the server disk often gets idle before
> > > the
> > > client can send more.
> > > 
> > > I wanted to discuss possible solutions here.
> > > 
> > > Generally 256MB is not enough even for consumer grade contemporary
> > > disks to
> > > max out throughput. There is tunable
> > > /proc/sys/fs/nfs/nfs_congestion_kb.
> > > If I tweak it to say 1GB, that is enough to give the server enough
> > > data to
> > > saturate the disk (most of the time) and fio reaches 180MB/s as
> > > before
> > > commit 6df25e58532b. So one solution to the problem would be to
> > > change the
> > > default of nfs_congestion_kb to 1GB.
> > > 
> > > Generally the problem with this tuning is that faster disks may need
> > > even
> > > larger nfs_congestion_kb, the NFS client has no way of knowing what
> > > the
> > > right value of nfs_congestion_kb is. I personally find the concept of
> > > client throttling writes to the server flawed. The *server* should
> > > push
> > > back (or throttle) if the client is too aggressively pushing out the
> > > data
> > > and then the client can react to this backpressure. Because only the
> > > server
> > > knows how much it can handle (also given the load from other
> > > clients). And
> > > I believe this is actually what is happening in practice (e.g. when I
> > > tune
> > > nfs_congestion_kb to really high number). So I think even better
> > > solution
> > > may be to just remove the write congestion handling from the client
> > > completely. The history before commit 6df25e58532b, when congestion
> > > was
> > > effectively ignored, shows that this is unlikely to cause any
> > > practical
> > > problems. What do people think?
> > I think we do still need a mechanism to prevent the client from pushing
> > more writebacks into the RPC layer when the server throttling is
> > causing RPC transmission queues to build up. Otherwise we end up
> > increasing the latency when the application is trying to do more I/O to
> > pages that are queued up for writeback in the RPC layer (since the
> > latter will be write locked).
> 
> Plus the server is likely serving multiple clients, so removing any type
> of congestion handling from the client may overwhelm the server.

I understand this concern but before commit 6df25e58532b we effectively
didn't do any throttling for years and nobody complained. So servers
apparently know how to cope with clients sending too much IO to them.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

