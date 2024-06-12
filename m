Return-Path: <linux-nfs+bounces-3651-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51A9048B1
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 04:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5ED1F22BD9
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 02:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD05244;
	Wed, 12 Jun 2024 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FEXZ7Zxd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XpTd1QMI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FEXZ7Zxd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XpTd1QMI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DD3FC7
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157615; cv=none; b=YYMxPbX1UArrM37g0v2snRs/8LdUh1aU8NlWV+qhwDqsNNRkrkuEXdX2jeWi4n837YzktJsx38+mjIiHofeE/LYHkhbS0646CjfeuhETjIDCvIZWUFplFF9aEVgQ4zkpTVmCHKo5fUlpkQjGPgi1bEmS11hhJgLP+FiBBbdaUzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157615; c=relaxed/simple;
	bh=mz07f3rLqGgeL92vHaeRQeo8c2VgrwrRhV4c8nBOITE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JeH7XbA3l29LAzZFfkzjBFFjpiRLi1gTu8z7T1EcfWPQPfA7JkGFDhgsy4Qbgv+VMpCwwplOxBXWOIg9USqVqWIZ18a66pZhFSJYptMYUJJBjrs8fTBZcNRWxNfYfCpFwcN8XkOrAoQ8SISeVMBEa/arVwsJHV3YdzcW+/vHW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FEXZ7Zxd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XpTd1QMI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FEXZ7Zxd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XpTd1QMI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F8D620DC7;
	Wed, 12 Jun 2024 02:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718157605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2budf1i9wwoh1LkDGixuEWyYgN08INeWS3sLPHNKVo=;
	b=FEXZ7Zxdn44G0W/FN3ATp5uHn+gZzUdPZoFt9Mh5kgfbddzWmLwP0ye54ihKbvtl3XWUUW
	NHmlNREm/qOZca1ogmUXUy3oCVlKBSiXAAj+EESz0jlFa/CZKX/E1mTgyYtlrjiansHfrj
	d5fC31Zh3dXI4t4dCEe9UMLYEf0pIL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718157605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2budf1i9wwoh1LkDGixuEWyYgN08INeWS3sLPHNKVo=;
	b=XpTd1QMIu3lzWxWEcebdIcblWV62FddTMg2TtLL019aZh2MigHY3sxQLmFohTrzvjMze9v
	J/5Y291ComJ+LrBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718157605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2budf1i9wwoh1LkDGixuEWyYgN08INeWS3sLPHNKVo=;
	b=FEXZ7Zxdn44G0W/FN3ATp5uHn+gZzUdPZoFt9Mh5kgfbddzWmLwP0ye54ihKbvtl3XWUUW
	NHmlNREm/qOZca1ogmUXUy3oCVlKBSiXAAj+EESz0jlFa/CZKX/E1mTgyYtlrjiansHfrj
	d5fC31Zh3dXI4t4dCEe9UMLYEf0pIL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718157605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2budf1i9wwoh1LkDGixuEWyYgN08INeWS3sLPHNKVo=;
	b=XpTd1QMIu3lzWxWEcebdIcblWV62FddTMg2TtLL019aZh2MigHY3sxQLmFohTrzvjMze9v
	J/5Y291ComJ+LrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 427E213AA4;
	Wed, 12 Jun 2024 02:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xoxYNSEBaWa6fAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 02:00:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "James Clark" <james.clark@arm.com>, linux-nfs@vger.kernel.org,
 broonie@kernel.org, Aishwarya.TCV@arm.com, ltp@lists.linux.it,
 "Jan Kara" <jack@suse.cz>, "Petr Vorel" <pvorel@suse.cz>
Subject:
 Re: [LTP] [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.
In-reply-to:
 <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
References:
 <>, <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
Date: Wed, 12 Jun 2024 11:59:54 +1000
Message-id: <171815759406.14261.8092450471234028375@noble.neil.brown.name>
X-Spam-Score: -8.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On Tue, 11 Jun 2024, Amir Goldstein wrote:
> On Tue, Jun 11, 2024 at 5:30 AM NeilBrown <neilb@suse.de> wrote:
> >
> > On Fri, 07 Jun 2024, James Clark wrote:
> > >
> > > Hi Neil,
> > >
> > > Now that your fix is in linux-next the statvfs01 test is passing again.
> > > However inotify02 is still failing.
> > >
> > > This is because the test expects the IN_CREATE and IN_OPEN events to
> > > come in that order after calling creat(), but now they are reversed. To
> > > me it seems like it could be a test issue and the test should handle
> > > them in either order? Or maybe there should be a single inotify event
> > > with both flags set for the atomic open?
> >
> > Interesting....  I don't see how any filesystem that uses ->atomic_open
> > would get these in the "right" order - and I do think IN_CREATE should
> > come before IN_OPEN.
> 
> Correct.
> 
> >
> > Does NFSv4 pass this test?
> 
> Probably not.
> 
> >
> > IN_OPEN is generated (by fsnotify_open()) when finish_open() is called,
> > which must be (and is) called by all atomic_open functions.
> > IN_CREATE is generated (by fsnotify_create()) when open_last_lookups()
> > detects that FMODE_CREATE was set and that happens *after* lookup_open()
> > is called, which calls atomic_open().
> >
> > For filesystems that don't use atomic_open, the IN_OPEN is generated by
> > the call to do_open() which happens *after* open_last_lookups(), not
> > inside it.
> 
> Correct.
> 
> >
> > So the ltp test must already fail for NFSv4, 9p ceph fuse gfs2 ntfs3
> > overlayfs smb.
> >
> 
> inotify02 does not run on all_filesystems, only on the main test fs,
> which is not very often one of the above.
> 
> This is how I averted the problem in fanotify16 (which does run on
> all_filesystems):
> 
> commit 9062824a70b8da74aa5b1db08710d0018b48072e
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Tue Nov 21 12:52:47 2023 +0200
> 
>     fanotify16: Fix test failure on FUSE
> 
>     Split SAFE_CREAT() into explicit SAFE_MKNOD() and SAFE_OPEN(),
>     because with atomic open (e.g. fuse), SAFE_CREAT() generates FAN_OPEN
>     before FAN_CREATE (tested with ntfs-3g), which is inconsistent with
>     the order of events expected from other filesystems.
> 
> inotify02 should be fixed similarly.

Alternately - maybe the kernel should be fixed to always get the order
right.
I have a patch.  I'll post it separately.

Thanks for your confirmation that my understanding is correct!

NeilBrown


> 
> I did not find any other inotify test that watches IN_CREATE.
> I did not find any other fanotify test that watches both FAN_CREATE
> and FAN_OPEN.
> 
> Thanks,
> Amir.
> 


