Return-Path: <linux-nfs+bounces-4700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873E7929A4F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 02:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086981F21247
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 00:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5436D;
	Mon,  8 Jul 2024 00:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xa8k6WWA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iDDunpHB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W7Wf6be+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dPzWjX3p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE0365;
	Mon,  8 Jul 2024 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720397286; cv=none; b=dhRwsNi92jx90CwKsi8vn5LPBwplOnvcvtWspqvhXOMBTkQr//VYEXIqR4S/fi5k++X0RMuiotlwIde3rptzosyK2kgtnM4oJ7vfmDiRIHmlW28m3htAka8y+yU0N5A+7sdwO7XdfpAsNwqz+Z80WQo4iDf2SH9rMhmeWfmIabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720397286; c=relaxed/simple;
	bh=kR/DivCPp+vVJb25kmVPpw81uu1O1l31jCYAw5a8oWw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=V79mAPE5m32/82H3iOz6NLungnrN3FzWwxxMjf+52VXMGw7YGTdN7rLcH8PdeJbQ5AcdUKCTVXo/TCA6u7IV3joq1K3WxvT82PXhsrTgLz5jGEL6O8CdRu/UNEKFVgOWgGwGCYdNE01Y9EbghTQ0zApMWRfXLKCL8XGcyPNKFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xa8k6WWA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iDDunpHB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W7Wf6be+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dPzWjX3p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9102121289;
	Mon,  8 Jul 2024 00:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720397282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfheGOdxMjbNmXPDKOkN1sXv8CIiS440Kq9f1zCDcxQ=;
	b=Xa8k6WWAtn18Cq6O+eOFHd5oFXyR2MHBcRWQ/9dPyfRsKWtQdHGB0e9xR9eKFBg5sXZ7rc
	cfgE6OL2AgHmVmy2FxMYnZuM7rKZPcv6WKJ8HY+pryANH8/wZderpKfd75vhvz1B+UYM8b
	Q9GOurqp9Q5EPDqAPx7xJh3AaoE7hF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720397282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfheGOdxMjbNmXPDKOkN1sXv8CIiS440Kq9f1zCDcxQ=;
	b=iDDunpHBJkNZZf9u2Xq7dYLuwg/fbcYRN6mTUUtNI2oABJ3lzBSTmYgfz4X1XK8QQMIu8i
	BWFxxOQxFDPGsTDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720397280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfheGOdxMjbNmXPDKOkN1sXv8CIiS440Kq9f1zCDcxQ=;
	b=W7Wf6be+AdsofALecMqN08WWK0giirw5BNUQDjgpTktDqhK5o8NWW2CffHRU+R3BCyyxfY
	hg8xuxF21ldfPOELQ1C7Cs5GYeOBau/Dz/7pp8OX2ZrRC14nHmHmAVl08gLZeF+SzPuVgA
	eb3f0J7X5EwduAmc+OE3U6prQycPJ+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720397280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfheGOdxMjbNmXPDKOkN1sXv8CIiS440Kq9f1zCDcxQ=;
	b=dPzWjX3pWCT5MjpXnTkscBlcZB5Fkm49wf7Q8+XvQcgF5lqBXjparJ1nEsP0gqC9iCTnG4
	MkXKvcnN6fnOzyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E260713796;
	Mon,  8 Jul 2024 00:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qxiOIdwti2aTIAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 08 Jul 2024 00:07:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "syzbot" <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, Dai.Ngo@oracle.com,
 chuck.lever@oracle.com, kolga@netapp.com, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, tom@talpey.com
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_umount
In-reply-to: <9825cc5ff85d4a2a4ce1c955f49681bef8d03442.camel@kernel.org>
References: <000000000000f8ed54061ca0d9a5@google.com>,
 <9825cc5ff85d4a2a4ce1c955f49681bef8d03442.camel@kernel.org>
Date: Mon, 08 Jul 2024 10:07:48 +1000
Message-id: <172039726840.11489.12386749198888516742@noble.neil.brown.name>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.97%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[b568ba42c85a332a88ee];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Sun, 07 Jul 2024, Jeff Layton wrote:
> On Sat, 2024-07-06 at 21:37 -0700, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    1dd28064d416 Merge tag 'integrity-v6.10-fix' of ssh://ra.=
k..
...
> > 2 locks held by syz.4.2691/12623:
> >  #0: ffffffff8f63ad70 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/n=
etlink/genetlink.c:1218
> >  #1: ffffffff8e5fff48 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_nl_listener_set_=
doit+0x12d/0x1a90 fs/nfsd/nfsctl.c:1940
> > 2 locks held by syz.0.2871/13167:
> >  #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: __super_l=
ock fs/super.c:56 [inline]
> >  #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: __super_l=
ock_excl fs/super.c:71 [inline]
> >  #0: ffff88804e1920e0 (&type->s_umount_key#77){++++}-{3:3}, at: deactivat=
e_super+0xb5/0xf0 fs/super.c:505
> >  #1: ffffffff8e5fff48 (nfsd_mutex){+.+.}-{3:3}, at: nfsd_shutdown_threads=
+0x4e/0xd0 fs/nfsd/nfssvc.c:632
>=20
> Above there are two tasks that are holding/blocked on the nfsd_mutex.
> The first is the stuck thread. The second is a task that took it in
> nfsd_nl_listener_set_doit. I don't see a way to exit that function
> without releasing that mutex, so it seems likely that thread is stuck
> too for some reason. Unfortunately, we don't have a stack trace from
> that task, so I can't tell what it's doing.
>=20

We can guess though.  It isn't waiting for a lock - that would show in
the above list - so it might be waiting for a wakeup, or might be
spinning.
The only wake-up I can imagine is in one of the memory-allocation calls,
but if the system were running out of memory we would probably see
messages about that.

I wonder if it could be looping in svc_xprt_destroy_all(), and sitting
in the msleep() when the hang is detected so there are no locks to
report.   I can't see while it would block there.

It would really help to get a full task list.
There is a sysctl for that: /proc/sys/kernel/hung_task_all_cpu_backtrace

Could that be enabled?

NeilBrown

