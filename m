Return-Path: <linux-nfs+bounces-3691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D883904C7C
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 09:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69931F23027
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5565F16C859;
	Wed, 12 Jun 2024 07:13:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0F16C84C
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176382; cv=none; b=CNsrpjrOMCSMWV6wn4gLDILOZIY47mUqk4BAhchyuWKYI26iiTNkVIa02vzENVSfPklyuyp6ChpKV8G5OoxMhcrnympYpA/RN+KPcObhvVzYW/wDp4NFxEwInKux0P+JzdIIJKdVCj+TleLPVEH/4ffS+RKIU0oSgcW8OUuxU2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176382; c=relaxed/simple;
	bh=oefK0prUp9ZDgjET0rnByZCSaYJI0kchlhsoN1Y3384=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDNI3oeo1igdHs4fKHRAXQ9ooIAnhpT88BdKTGiHXGDKgwvxjW0Erm2T22GA7gsPwQQ5k37U86BSmRAyWd8GipCLj/NRqQw7lmCcf4auRiZZb77EPIl05w3Cbh9XKFUFEHkmHChtn9k32o5tjzOYqWJcVgmAnyATpbarJwhf64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C43A433FC7;
	Wed, 12 Jun 2024 07:12:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85308137DF;
	Wed, 12 Jun 2024 07:12:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U3GPH3pKaWboRQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 12 Jun 2024 07:12:58 +0000
Date: Wed, 12 Jun 2024 09:12:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Amir Goldstein <amir73il@gmail.com>, James Clark <james.clark@arm.com>,
	linux-nfs@vger.kernel.org, broonie@kernel.org,
	Aishwarya.TCV@arm.com, ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Subject: Re: [LTP] [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC
 correctly.
Message-ID: <20240612071252.GA98398@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <>
 <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
 <171815759406.14261.8092450471234028375@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171815759406.14261.8092450471234028375@noble.neil.brown.name>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C43A433FC7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

> On Tue, 11 Jun 2024, Amir Goldstein wrote:
> > On Tue, Jun 11, 2024 at 5:30 AM NeilBrown <neilb@suse.de> wrote:

> > > On Fri, 07 Jun 2024, James Clark wrote:

> > > > Hi Neil,

> > > > Now that your fix is in linux-next the statvfs01 test is passing again.
> > > > However inotify02 is still failing.

> > > > This is because the test expects the IN_CREATE and IN_OPEN events to
> > > > come in that order after calling creat(), but now they are reversed. To
> > > > me it seems like it could be a test issue and the test should handle
> > > > them in either order? Or maybe there should be a single inotify event
> > > > with both flags set for the atomic open?

> > > Interesting....  I don't see how any filesystem that uses ->atomic_open
> > > would get these in the "right" order - and I do think IN_CREATE should
> > > come before IN_OPEN.

> > Correct.


> > > Does NFSv4 pass this test?

> > Probably not.


> > > IN_OPEN is generated (by fsnotify_open()) when finish_open() is called,
> > > which must be (and is) called by all atomic_open functions.
> > > IN_CREATE is generated (by fsnotify_create()) when open_last_lookups()
> > > detects that FMODE_CREATE was set and that happens *after* lookup_open()
> > > is called, which calls atomic_open().

> > > For filesystems that don't use atomic_open, the IN_OPEN is generated by
> > > the call to do_open() which happens *after* open_last_lookups(), not
> > > inside it.

> > Correct.


> > > So the ltp test must already fail for NFSv4, 9p ceph fuse gfs2 ntfs3
> > > overlayfs smb.


> > inotify02 does not run on all_filesystems, only on the main test fs,
> > which is not very often one of the above.

> > This is how I averted the problem in fanotify16 (which does run on
> > all_filesystems):

> > commit 9062824a70b8da74aa5b1db08710d0018b48072e
> > Author: Amir Goldstein <amir73il@gmail.com>
> > Date:   Tue Nov 21 12:52:47 2023 +0200

> >     fanotify16: Fix test failure on FUSE

> >     Split SAFE_CREAT() into explicit SAFE_MKNOD() and SAFE_OPEN(),
> >     because with atomic open (e.g. fuse), SAFE_CREAT() generates FAN_OPEN
> >     before FAN_CREATE (tested with ntfs-3g), which is inconsistent with
> >     the order of events expected from other filesystems.

> > inotify02 should be fixed similarly.

> Alternately - maybe the kernel should be fixed to always get the order
> right.
> I have a patch.  I'll post it separately.

@Amir, if later Neil's branch get merged, maybe we should use on fanotify16
creat() on the old kernels (as it was in before your fix 9062824a7 ("fanotify16:
Fix test failure on FUSE")), based on kernel check.

Kind regards,
Petr

> Thanks for your confirmation that my understanding is correct!

> NeilBrown



> > I did not find any other inotify test that watches IN_CREATE.
> > I did not find any other fanotify test that watches both FAN_CREATE
> > and FAN_OPEN.

> > Thanks,
> > Amir.



