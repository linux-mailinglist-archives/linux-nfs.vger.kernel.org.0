Return-Path: <linux-nfs+bounces-7883-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EB09C49AB
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 00:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2EDB26455
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 23:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB6818A6D1;
	Mon, 11 Nov 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aLLI/A6I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cg9D4MbB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aLLI/A6I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cg9D4MbB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA817623C
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731367412; cv=none; b=mGjCdxAtBV5YGRWfyhpco/I0ahCWXvByULa6/+07o0Gn+OKR9hby6Ho4sOPdWlzgu3V0e+SNUL/o2RuE2cJ8EF2JhV3kEFwz36LcdvH1dnEZQRUPORulqinPeILPw3U/CfHr4yArL5y9ithpOnNoTNJK27hk5DGClWuK7cy8vkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731367412; c=relaxed/simple;
	bh=owxtZDoq/5qKsuitQCbjheZqlHWHyTt7ZmTYCSeFTvI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=X7sif+192irlY6+1KTELx8r7Y2+OyGOnIrY5lTTGzQuTUZbC+A3t3/mYojxzZS8M0LxrltqBq9AiLWzrwWayKJwGi979kE4vd5Ny4cPnQ87dqIxwwLh8S1Gr4eDkO2/8k86ntzZ8bjQtUcsnrY/Gom2B7SwkECcepmTjRVDcUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aLLI/A6I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cg9D4MbB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aLLI/A6I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cg9D4MbB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD9F6218EC;
	Mon, 11 Nov 2024 23:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731367408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVOo8Wx7C9vkyQLyAz0xe6zNGaRlFWuhPf9CWqIOb2M=;
	b=aLLI/A6IW/P86ugLjhbisvSZUClTBcmtHulgZ9DlXXK6AUrad/6wr06Ry0rkFfwZnoUi88
	6dAVnKC6p2069gOlvu/WjvIaYw1ZQEoX7NDVBB99A9Uoqsj3oTAqrqyzDMg3qlr6aSVlH4
	gCrJWSkycv7fI17jCkoNRaI1ZiLgGs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731367408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVOo8Wx7C9vkyQLyAz0xe6zNGaRlFWuhPf9CWqIOb2M=;
	b=cg9D4MbBEWr2ejsq+LFgWD2W5i4jWlYFLQ+8R27DXlYuRlsf73cCPc+I+P5U64yd3euITx
	uuFVV37vwO0xASCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731367408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVOo8Wx7C9vkyQLyAz0xe6zNGaRlFWuhPf9CWqIOb2M=;
	b=aLLI/A6IW/P86ugLjhbisvSZUClTBcmtHulgZ9DlXXK6AUrad/6wr06Ry0rkFfwZnoUi88
	6dAVnKC6p2069gOlvu/WjvIaYw1ZQEoX7NDVBB99A9Uoqsj3oTAqrqyzDMg3qlr6aSVlH4
	gCrJWSkycv7fI17jCkoNRaI1ZiLgGs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731367408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVOo8Wx7C9vkyQLyAz0xe6zNGaRlFWuhPf9CWqIOb2M=;
	b=cg9D4MbBEWr2ejsq+LFgWD2W5i4jWlYFLQ+8R27DXlYuRlsf73cCPc+I+P5U64yd3euITx
	uuFVV37vwO0xASCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5F72137FB;
	Mon, 11 Nov 2024 23:23:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8SAYH+6RMmfreAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 23:23:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock
 member of nfs_uuid_t
In-reply-to: <ZzKE6aQyEKiIgMLG@kernel.org>
References: <>, <ZzKE6aQyEKiIgMLG@kernel.org>
Date: Tue, 12 Nov 2024 10:23:19 +1100
Message-id: <173136739945.1734440.14539377225286667908@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 12 Nov 2024, Mike Snitzer wrote:
> On Tue, Nov 12, 2024 at 07:35:04AM +1100, NeilBrown wrote:
> > 
> > I don't like NFS_CS_LOCAL_IO_CAPABLE.
> > A use case that I imagine (and a customer does something like this) is an
> > HA cluster where the NFS server can move from one node to another.  All
> > the node access the filesystem, most over NFS.  If a server-migration
> > happens (e.g.  the current server node failed) then the new server node
> > would suddenly become LOCALIO-capable even though it wasn't at
> > mount-time.  I would like it to be able to detect this and start doing
> > localio.
> 
> Server migration while retaining the client being local to the new
> server?  So client migrates too?

No.  Client doesn't migrate.  Server migrates and appears on the same
host as the client.  The client can suddenly get better performance.  It
should benefit from that.

> 
> If the client migrates then it will negotiate with server using
> LOCALIO protocol.
> 
> Anyway, this HA hypothetical feels contrived.  It is fine that you
> dislike NFS_CS_LOCAL_IO_CAPABLE but I don't understand what you'd like
> as an alternative.  Or why the simplicity in my approach lacking.

We have customers with exactly this HA config.  This is why I put work
into make sure loop-back NFS (client and server on same node) works
cleanly without memory allocation deadlocks.
  https://lwn.net/Articles/595652/
Getting localio in that config would be even better.

Your approach assumes that if LOCALIO isn't detected at mount time, it
will never been available.  I think that is a flawed assumption.

> 
> > So I don't want NFS_CS_LOCAL_IO_CAPABLE.  I think tracking when the
> > network connection is re-established is sufficient.
> 
> Eh, that type of tracking doesn't really buy me anything if I've lost
> context (that LOCALIO was previously established and should be
> re-established).
> 
> NFS v3 is stateless, hence my hooking off read and write paths to
> trigger nfs_local_probe_async().  Unlike NFS v4, with its grace, more
> care is needed to avoid needless calls to nfs_local_probe_async().

I think it makes perfect sense to trigger the probe on a successful
read/write with some rate limiting to avoid sending a LOCALIO probe on
EVERY read/write.  Your rate-limiting for NFSv3 is:
   - never probe if the mount-time probe was not successful
   - otherwise probe once every 256 IO requests.

I think the first is too restrictive, and the second is unnecessarily
frequent.
I propose:
   - probe once each time the client reconnects with the server

This will result in many fewer probes in practice, but any successful
probe will happen at nearly the earliest possible moment.

> 
> Your previous email about just tracking network connection change was
> an optimization for avoiding repeat (pointless) probes.  We still
> need to know to do the probe to begin with.  Are you saying you want
> to backfill the equivalent of grace (or pseudo-grace) to NFSv3?

You don't "know to do the probe" at mount time.  You simply always do
it.  Similarly whenever localio isn't active it is always appropriate to
probe - with rate limiting.

And NFSv3 already has a grace period - in the NLM/STAT protocols.  We
could use STAT to detect when the server has restarted and so it is worth
probing again.  But STAT is not as reliable as we might like and it
would be more complexity with no real gain.

I would be happy to use exactly the same mechanism for both v3 and v4:
send a probe after IO on a new connection.  But your solution for v4 is
simple and elegant so I'm not at all against it.

> 
> My approach works.  Not following what you are saying will be better.

 - server-migration can benefit from localio on the new host
 - many fewer probes
 - probes are much more timely.

NeilBrown


> 
> Thanks,
> Mike
> 


