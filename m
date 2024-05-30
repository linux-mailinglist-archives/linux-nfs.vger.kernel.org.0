Return-Path: <linux-nfs+bounces-3488-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8EA8D4A97
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 13:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924DE1F22CA8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FF01078B;
	Thu, 30 May 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HMWYrsB1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AGVTVMUa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cetku2V2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UtGoQZGo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568FD16F0D0
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068087; cv=none; b=aOS8I4ouIaDwbAXpqtNYl+MbCGEMTPlBFTJ/yqfRm3dTFPy8tsGLbk7ZOoHU4ZLLS7EKR0vHsRRqXy9O9jVRWtf28cx/gDW077LOT62sNaFSaCG52IZmlJkgB6LMS2XXTjjKH4P3r/QC/ybAMmwN6sVQtiLJE+FdB172hR6aq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068087; c=relaxed/simple;
	bh=Hb60gMSdTK9SYTdop1T5LD5gclMShPty2cev3anj+Bs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=eMxh39Jq+/uEjE+39WnUse0WnlG6zYP4oT44Uf0MAZezNi04CsPN/DFhxYBTcfXjbz1vGIX2EN+gxhjg0T2NMK71jYMLSvcdiVMsXEMomSJo9BCvPY6UqO0+uJ+6Zr9jYC808LJhTDzEuGcSK5+YD0HYZUGVLA2Xs0CAm9trxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HMWYrsB1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AGVTVMUa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cetku2V2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UtGoQZGo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A28020792;
	Thu, 30 May 2024 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717068082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BCeR/nlSizc+6SMeQXJVIQ0tByS8B4mR2zHqPnrtHQ=;
	b=HMWYrsB1iqsy4gdl3U0Hv6L2b/HK4M2h5hMnryBCz4kCP5nfSOr3iuwMDTYnqI32UsDmic
	Oi5pbq24TSt81Bu1drrhm8CiIsuHJM0TpFCHG2awqJ3joN0ZF+96kDNmeCkVxsSwdCdPFp
	36SXF1Pm/WPNYuTa/vp8HTqSHtT/S8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717068082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BCeR/nlSizc+6SMeQXJVIQ0tByS8B4mR2zHqPnrtHQ=;
	b=AGVTVMUaiK2IBwYcr21tOaqSllDU8X/aVAlfXLleIrCo33nz9gYic/CDLNRMF7Oq7ab66j
	kD/9g8zH2HQn01Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Cetku2V2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UtGoQZGo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717068081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BCeR/nlSizc+6SMeQXJVIQ0tByS8B4mR2zHqPnrtHQ=;
	b=Cetku2V2YXKDh0rI//5LtnK8PheC5h3v2V2WQkanQ1ZSjvvBju+Of9yNMkUbeG94jK0AfG
	BQRzc6NuxV/YkeeaPkVnFa4Fd9ytmILCGD8KDeRSjnZJp+rWGVQ524dD/xygrCFmA6fbyG
	pj9pF66ll+2oE52LPlvY8Bp6P+N5lUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717068081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BCeR/nlSizc+6SMeQXJVIQ0tByS8B4mR2zHqPnrtHQ=;
	b=UtGoQZGo3lOqG/ghg6BHsVJQ6YcbFGa6szjPHLCTSCnsV0WwdgIQ07Uvu+niuE34JeiF7k
	nbo2053cTvabO2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBFF313A83;
	Thu, 30 May 2024 11:21:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mAP8Fi5hWGaQOAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 30 May 2024 11:21:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Sagi Grimberg" <sagi@grimberg.me>
Cc: "Jan Kara" <jack@suse.cz>, "Trond Myklebust" <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "anna@kernel.org" <anna@kernel.org>
Subject: Re: NFS write congestion size
In-reply-to: <a86fdd86-7c3a-44e9-9d49-4b3edfab66e6@grimberg.me>
References: <>, <a86fdd86-7c3a-44e9-9d49-4b3edfab66e6@grimberg.me>
Date: Thu, 30 May 2024 21:21:13 +1000
Message-id: <171706807360.14261.8929224868643154972@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0A28020792
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.51

On Thu, 30 May 2024, Sagi Grimberg wrote:
>=20
> On 30/05/2024 11:31, Jan Kara wrote:
> > On Thu 30-05-24 10:44:01, Sagi Grimberg wrote:
> >> On 29/05/2024 20:05, Trond Myklebust wrote:
> >>> On Wed, 2024-05-29 at 18:11 +0200, Jan Kara wrote:
> >>>> Hello,
> >>>>
> >>>> so I was investigating why random writes to a large file over NFS got
> >>>> noticeably slower. The workload we use to test this is this fio
> >>>> command:
> >>>>
> >>>> fio --direct=3D0 --ioengine=3Dsync --thread --directory=3D/mnt --
> >>>> invalidate=3D1 \
> >>>>   =C2=A0=C2=A0=C2=A0 --group_reporting=3D1 --runtime=3D300 --fallocate=
=3Dposix --
> >>>> ramp_time=3D10 \
> >>>>   =C2=A0=C2=A0=C2=A0 --name=3DRandomWrites-async-257024-4k-4 --new_gro=
up --rw=3Drandwrite
> >>>> \
> >>>>   =C2=A0=C2=A0=C2=A0 --size=3D32000m --numjobs=3D4 --bs=3D4k --fsync_o=
n_close=3D1 --
> >>>> end_fsync=3D1 \
> >>>>   =C2=A0=C2=A0=C2=A0 --filename_format=3D'FioWorkloads.$jobnum'
> >>>>
> >>>> Eventually I've tracked down the regression to be caused by
> >>>> 6df25e58532b
> >>>> ("nfs: remove reliance on bdi congestion") which changed the
> >>>> congestion
> >>>> mechanism from a generic bdi congestion handling to NFS private one.
> >>>> Before
> >>>> this commit the fio achieved throughput of 180 MB/s, after this
> >>>> commit only
> >>>> 120 MB/s. Now part of the regression was actually caused by
> >>>> inefficient
> >>>> fsync(2) and the fact that more dirty data was cached at the time of
> >>>> the
> >>>> last fsync after commit 6df25e58532b. After fixing fsync [1], the
> >>>> throughput got to 150 MB/s so better but still not quite the
> >>>> throughput
> >>>> before 6df25e58532b.
> >>>>
> >>>> The reason for remaining regression is that bdi congestion handling
> >>>> was
> >>>> broken and the client had happily ~8GB of outstanding IO against the
> >>>> server
> >>>> despite the congestion limit was 256 MB. The new congestion handling
> >>>> actually works but as a result the server does not have enough dirty
> >>>> data
> >>>> to efficiently operate on and the server disk often gets idle before
> >>>> the
> >>>> client can send more.
> >>>>
> >>>> I wanted to discuss possible solutions here.
> >>>>
> >>>> Generally 256MB is not enough even for consumer grade contemporary
> >>>> disks to
> >>>> max out throughput. There is tunable
> >>>> /proc/sys/fs/nfs/nfs_congestion_kb.
> >>>> If I tweak it to say 1GB, that is enough to give the server enough
> >>>> data to
> >>>> saturate the disk (most of the time) and fio reaches 180MB/s as
> >>>> before
> >>>> commit 6df25e58532b. So one solution to the problem would be to
> >>>> change the
> >>>> default of nfs_congestion_kb to 1GB.
> >>>>
> >>>> Generally the problem with this tuning is that faster disks may need
> >>>> even
> >>>> larger nfs_congestion_kb, the NFS client has no way of knowing what
> >>>> the
> >>>> right value of nfs_congestion_kb is. I personally find the concept of
> >>>> client throttling writes to the server flawed. The *server* should
> >>>> push
> >>>> back (or throttle) if the client is too aggressively pushing out the
> >>>> data
> >>>> and then the client can react to this backpressure. Because only the
> >>>> server
> >>>> knows how much it can handle (also given the load from other
> >>>> clients). And
> >>>> I believe this is actually what is happening in practice (e.g. when I
> >>>> tune
> >>>> nfs_congestion_kb to really high number). So I think even better
> >>>> solution
> >>>> may be to just remove the write congestion handling from the client
> >>>> completely. The history before commit 6df25e58532b, when congestion
> >>>> was
> >>>> effectively ignored, shows that this is unlikely to cause any
> >>>> practical
> >>>> problems. What do people think?
> >>> I think we do still need a mechanism to prevent the client from pushing
> >>> more writebacks into the RPC layer when the server throttling is
> >>> causing RPC transmission queues to build up. Otherwise we end up
> >>> increasing the latency when the application is trying to do more I/O to
> >>> pages that are queued up for writeback in the RPC layer (since the
> >>> latter will be write locked).
> >> Plus the server is likely serving multiple clients, so removing any type
> >> of congestion handling from the client may overwhelm the server.
> > I understand this concern but before commit 6df25e58532b we effectively
> > didn't do any throttling for years and nobody complained.
>=20
> don't know about the history nor what people could have attributed problems.
>=20
> >   So servers
> > apparently know how to cope with clients sending too much IO to them.
>=20
> not sure how an nfs server would cope with this. nfsv4 can reduce slots,=20
> but not
> sure what nfsv3 server would do...

An nfsv3 server would simply respond slowly, or just drop the request.
It is not up to the client to rate-limit requests so as to make life
easier for the server.

>=20
> btw, I think you meant that *slower* devices may need a larger queue to=20
> saturate,
> because if the device is fast, 256MB inflight is probably enough... So=20
> you are solving
> for the "consumer grade contemporary disks".

No, faster devices.  The context here is random writes.  The more of
those that are in the queue on the server, the more chance it has to
re-order or coalesce requests.
We don't want the device to go idle so we want lots of data buffered.
It will take the client some moments to respond to the client-side queue
dropping below a threshold by finding some pages to write and to submit
them.  We don't want those moments to be long enough for the server-side
queue to empty.

NeilBrown

