Return-Path: <linux-nfs+bounces-3819-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6AD908605
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 10:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911EC1C21003
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 08:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B25149C44;
	Fri, 14 Jun 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MV0Zq5S3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yOYESIXv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MV0Zq5S3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yOYESIXv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA4262BE
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353103; cv=none; b=ncne+PVoTYtEgoEqnNwxToIHP3by1qtHgNvBRsI2d5uPZk9BAtRK6EoPKJZYk/+8o3keT2rIdbrrXnlEbSx3qfpknto2kyBgU7PWcNr3WgG+ScluwH/NKy/G1lJh5B5w7VOTfjUvWNWMfhTLNdGC/SN8Ooqft9pVLpn5G0wN9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353103; c=relaxed/simple;
	bh=nkDet/m9/bK/l71NTJhAWjYMEKOjZde3D+/2JPRbW7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwV+tkdljRpstgJqoDcOc7/9ozORh7PWWqNByt+RAng4BNmMeie9K+wEmi6LI8EvVfID9k1cANPwAH3ID+S9jxD9CCNspMmRgins/LVu9HgbT7t1RXF5yoN/5tuJlzZr4IWcy8s7jL1/hXzrXqcmZO9915UYlaaufl3VIfwz9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MV0Zq5S3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yOYESIXv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MV0Zq5S3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yOYESIXv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1DB220207;
	Fri, 14 Jun 2024 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718353099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYqOxoD36u8V4oSBzFdqoifR0Tb4tgfBlg3Eo3eE0WE=;
	b=MV0Zq5S3eOE414OZLyPu3UkR/Naojbvhtlvju9/XeOrGPDCYl+LHynIlLDZlbHmx4OIMAP
	MU5C1X6buO3QVCx4koU1aGwfY5FuULMVI1U4ORm/3SGtUcCbjwAKghxsYaXyQRD19NmK94
	Q05sUwJqAj1K0t2NnETtAOcl5OHysmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718353099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYqOxoD36u8V4oSBzFdqoifR0Tb4tgfBlg3Eo3eE0WE=;
	b=yOYESIXvAqPPOplDaWgGq5jsEhnFzSOCUh3CIUpxl/CnL9NRC0v5qhO3G17rPrXpkUtygj
	b1vyOU7s38/BWeBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718353099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYqOxoD36u8V4oSBzFdqoifR0Tb4tgfBlg3Eo3eE0WE=;
	b=MV0Zq5S3eOE414OZLyPu3UkR/Naojbvhtlvju9/XeOrGPDCYl+LHynIlLDZlbHmx4OIMAP
	MU5C1X6buO3QVCx4koU1aGwfY5FuULMVI1U4ORm/3SGtUcCbjwAKghxsYaXyQRD19NmK94
	Q05sUwJqAj1K0t2NnETtAOcl5OHysmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718353099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYqOxoD36u8V4oSBzFdqoifR0Tb4tgfBlg3Eo3eE0WE=;
	b=yOYESIXvAqPPOplDaWgGq5jsEhnFzSOCUh3CIUpxl/CnL9NRC0v5qhO3G17rPrXpkUtygj
	b1vyOU7s38/BWeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B416E13AB1;
	Fri, 14 Jun 2024 08:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0lx5K8v8a2bCYAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 14 Jun 2024 08:18:19 +0000
Date: Fri, 14 Jun 2024 10:18:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neilb@suse.de>, James Clark <james.clark@arm.com>,
	linux-nfs@vger.kernel.org, broonie@kernel.org,
	Aishwarya.TCV@arm.com, ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Subject: Re: [LTP] [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC
 correctly.
Message-ID: <20240614081817.GA168224@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
 <171815759406.14261.8092450471234028375@noble.neil.brown.name>
 <20240612071252.GA98398@pevik>
 <CAOQ4uxgyHrTR_-b5tKdtuCoyoKdrVWb=-h-CbiSP2pHVHM--CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgyHrTR_-b5tKdtuCoyoKdrVWb=-h-CbiSP2pHVHM--CQ@mail.gmail.com>
X-Spam-Score: -3.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	REPLYTO_EQ_FROM(0.00)[]

> On Wed, Jun 12, 2024 at 10:12 AM Petr Vorel <pvorel@suse.cz> wrote:

> > > On Tue, 11 Jun 2024, Amir Goldstein wrote:
> > > > On Tue, Jun 11, 2024 at 5:30 AM NeilBrown <neilb@suse.de> wrote:

> > > > > On Fri, 07 Jun 2024, James Clark wrote:

> > > > > > Hi Neil,

> > > > > > Now that your fix is in linux-next the statvfs01 test is passing again.
> > > > > > However inotify02 is still failing.

> > > > > > This is because the test expects the IN_CREATE and IN_OPEN events to
> > > > > > come in that order after calling creat(), but now they are reversed. To
> > > > > > me it seems like it could be a test issue and the test should handle
> > > > > > them in either order? Or maybe there should be a single inotify event
> > > > > > with both flags set for the atomic open?

> > > > > Interesting....  I don't see how any filesystem that uses ->atomic_open
> > > > > would get these in the "right" order - and I do think IN_CREATE should
> > > > > come before IN_OPEN.

> > > > Correct.


> > > > > Does NFSv4 pass this test?

> > > > Probably not.


> > > > > IN_OPEN is generated (by fsnotify_open()) when finish_open() is called,
> > > > > which must be (and is) called by all atomic_open functions.
> > > > > IN_CREATE is generated (by fsnotify_create()) when open_last_lookups()
> > > > > detects that FMODE_CREATE was set and that happens *after* lookup_open()
> > > > > is called, which calls atomic_open().

> > > > > For filesystems that don't use atomic_open, the IN_OPEN is generated by
> > > > > the call to do_open() which happens *after* open_last_lookups(), not
> > > > > inside it.

> > > > Correct.


> > > > > So the ltp test must already fail for NFSv4, 9p ceph fuse gfs2 ntfs3
> > > > > overlayfs smb.


> > > > inotify02 does not run on all_filesystems, only on the main test fs,
> > > > which is not very often one of the above.

> > > > This is how I averted the problem in fanotify16 (which does run on
> > > > all_filesystems):

> > > > commit 9062824a70b8da74aa5b1db08710d0018b48072e
> > > > Author: Amir Goldstein <amir73il@gmail.com>
> > > > Date:   Tue Nov 21 12:52:47 2023 +0200

> > > >     fanotify16: Fix test failure on FUSE

> > > >     Split SAFE_CREAT() into explicit SAFE_MKNOD() and SAFE_OPEN(),
> > > >     because with atomic open (e.g. fuse), SAFE_CREAT() generates FAN_OPEN
> > > >     before FAN_CREATE (tested with ntfs-3g), which is inconsistent with
> > > >     the order of events expected from other filesystems.

> > > > inotify02 should be fixed similarly.

> > > Alternately - maybe the kernel should be fixed to always get the order
> > > right.
> > > I have a patch.  I'll post it separately.

> > @Amir, if later Neil's branch get merged, maybe we should use on fanotify16
> > creat() on the old kernels (as it was in before your fix 9062824a7 ("fanotify16:
> > Fix test failure on FUSE")), based on kernel check.


> I am hoping that the fix could be backported to v6.9.y and then we
> won't need to worry about older LTS kernels for fanotify16, because
> fuse only supports FAN_CREATE since v6.8.

Great! Thanks for info.

Kind regards,
Petr

> Thanks,
> Amir.

