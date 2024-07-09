Return-Path: <linux-nfs+bounces-4757-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BB292C671
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 01:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74751C224FB
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 23:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0D156F3C;
	Tue,  9 Jul 2024 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k9/vqXxT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+XbylW6g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k9/vqXxT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+XbylW6g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3B1509BD;
	Tue,  9 Jul 2024 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566788; cv=none; b=eqFS3mTeJExwsnvZhcrpvPW/OJppzfXc3dBnGuJlMQQYkdUxKIjA9zWRLotxZnc3vfagPU3yTb96V+0hybJuP3Ke0yFDSSIqS8ECULAl/w9BLaq6ri+A859Mf+7A7IX5Jzi4iFVNXaCfB7js1QbsLAPLJkb9NxbF525UpsTyptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566788; c=relaxed/simple;
	bh=b/s21hwgUctXd/+avvt3JeKnrJBBAzIDE3Gg2rhieLU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=m648egV1qA98cL/RWcvPjCyz/7hsvyLhjnfAUe+KanjAVFLGf0htbeOS72DC4R2s18ETx61ngbiNxaLSCFy/rfenlSLHJ+j/qJsrVXhmQgWdScY0Y7U47fXif07/PtPhWeXpp2R90lQ3toHStVUW45nCq84wfVAxZiXSfsQyOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k9/vqXxT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+XbylW6g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k9/vqXxT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+XbylW6g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F4761F7A4;
	Tue,  9 Jul 2024 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720566785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6PKMJQI3MzIXTGas0ngwth5zI/3inxDJ0TRzr7rZK4=;
	b=k9/vqXxT+GZLRRxHhtIm2lLA/eC/je9btnB8E6s6JH5IDk5wpGp7z2AgEk9lRp3UJUL9uH
	7dBDVh/RffKpb8N0NwnHxAs7+zxSqDWwGVYLuMX1U7Ht4iYTukL3hJm0OaxjhPtnb7xng+
	9rxxgld+lhQ6SXrpBziFuNdoGRdJcKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720566785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6PKMJQI3MzIXTGas0ngwth5zI/3inxDJ0TRzr7rZK4=;
	b=+XbylW6gtKDF3C+V/j+E3JSPMqXsRRb6j3EL+wT83K5Ksf/jT/A5rG4ZUPXQ+0uyt8qsI2
	XGiAl5AB+lNo7eBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720566785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6PKMJQI3MzIXTGas0ngwth5zI/3inxDJ0TRzr7rZK4=;
	b=k9/vqXxT+GZLRRxHhtIm2lLA/eC/je9btnB8E6s6JH5IDk5wpGp7z2AgEk9lRp3UJUL9uH
	7dBDVh/RffKpb8N0NwnHxAs7+zxSqDWwGVYLuMX1U7Ht4iYTukL3hJm0OaxjhPtnb7xng+
	9rxxgld+lhQ6SXrpBziFuNdoGRdJcKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720566785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6PKMJQI3MzIXTGas0ngwth5zI/3inxDJ0TRzr7rZK4=;
	b=+XbylW6gtKDF3C+V/j+E3JSPMqXsRRb6j3EL+wT83K5Ksf/jT/A5rG4ZUPXQ+0uyt8qsI2
	XGiAl5AB+lNo7eBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A38251369A;
	Tue,  9 Jul 2024 23:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MfN9Ef7DjWYgMgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 09 Jul 2024 23:13:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Dave Chinner" <david@fromorbit.com>, "Mike Snitzer" <snitzer@kernel.org>,
 linux-xfs@vger.kernel.org, "Brian Foster" <bfoster@redhat.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
In-reply-to: <ZoVdAPusEMugHBl8@infradead.org>
References: <>, <ZoVdAPusEMugHBl8@infradead.org>
Date: Wed, 10 Jul 2024 09:12:58 +1000
Message-id: <172056677808.15471.5200774043985229799@noble.neil.brown.name>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Thu, 04 Jul 2024, Christoph Hellwig wrote:
> On Wed, Jul 03, 2024 at 09:29:00PM +1000, NeilBrown wrote:
> > I know nothing of this stance.  Do you have a reference?
> 
> No particular one.
> 
> > I have put a modest amount of work into ensure NFS to a server on the
> > same machine works and last I checked it did - though I'm more
> > confident of NFSv3 than NFSv4 because of the state manager thread.
> 
> How do you propagate the NOFS flag (and NOIO for a loop device) to
> the server an the workqueues run by the server and the file system
> call by it?  How do you ensure WQ_MEM_RECLAIM gets propagate to
> all workqueues that could be called by the file system on the
> server (the problem kicking off this discussion)?
> 

Do we need to propagate these?

NOFS is for deadlock avoidance.  A filesystem "backend" (Dave's term - I
think for the parts of the fs that handle write-back) might allocate
memory, that might block waiting for memory reclaim, memory reclaim
might re-enter the filesystem backend and might block on a lock (or
similar) held while allocating memory.  NOFS breaks that deadlock.

The important thing here isn't the NOFS flag, it is breaking any
possible deadlock.

Layered filesystems introduce a new complexity.  The backend for one
filesystem can call into the front end of another filesystem.  That
front-end is not required to use NOFS and even if we impose
PF_MEMALLOC_NOFS, the front-end might wait for some work-queue action
which doesn't inherit the NOFS flag.

But this doesn't necessarily matter.  Calling into the filesystem is not
the problem - blocking waiting for a reply is the problem.  It is
blocking that creates deadlocks.  So if the backend of one filesystem
queues to a separate thread the work for the front end of the other
filesystem and doesn't wait for the work to complete, then a deadlock
cannot be introduced.

/dev/loop uses the loop%d workqueue for this.  loop-back NFS hands the
front-end work over to nfsd.  The proposed localio implementation uses a
nfslocaliod workqueue for exactly the same task.  These remove the
possibility of deadlock and mean that there is no need to pass NOFS
through to the front-end of the backing filesystem.

Note that there is a separate question concerning pageout to a swap
file.  pageout needs more than just deadlock avoidance.  It needs
guaranteed progress in low memory conditions.   It needs PF_MEMALLOC (or
mempools) and that cannot be finessed using work queues.  I don't think
that Linux is able to support pageout through layered filesystems.

So while I support loop-back NFS and swap-over-NFS, I don't support them
in combination.  We don't support swap on /dev/loop when it is backed by
a file - for that we have swap-to-file.

Thank you for challenging me on this - it helped me clarify my thoughts
and understanding for myself.

NeilBrown

