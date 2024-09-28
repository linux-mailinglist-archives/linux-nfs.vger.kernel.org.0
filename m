Return-Path: <linux-nfs+bounces-6685-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D962C9891E6
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 00:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650CC1F237DD
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Sep 2024 22:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2AD14AD2D;
	Sat, 28 Sep 2024 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LOUsPkCh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ei9J4Fn9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LOUsPkCh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ei9J4Fn9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703182488
	for <linux-nfs@vger.kernel.org>; Sat, 28 Sep 2024 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727562213; cv=none; b=MApHMK0gUyEiLqyNzUQPDD3MoWHpsL1Ts87TzThPCiobe7Il6KvoB8w9K7HOW4D3/tCox60b+ST/bV0Q0fZm/47Je+eVs0iyvb+IY+YBTeJI/D7A0GnpHqz9V1WXY/kczsDFUyw/3uujWzicLEP8wzssEbUqYJ7KtFOmiwii5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727562213; c=relaxed/simple;
	bh=5stBzbSmfNhK60ptW0KWq4kqULKgplXhCkwRoEyhyCs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tIFwPB5KSXXBaWh9jh+gYserqgKxihm6koYPNpmS8LkNQvgGDIW/G39KRlIjrq7txwhLpAc7PGJ9EiCCib79Y0tzSugE9pZXvA2ujVmjxD80gWD+rS9GInlwnnmSA5BFgCir3Ms6c8of/l0YL9h2Iwuxl2eDUMjo93uQgmMWkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LOUsPkCh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ei9J4Fn9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LOUsPkCh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ei9J4Fn9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEF591F399;
	Sat, 28 Sep 2024 22:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727562208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxQaszsw3IyyQfsEnc0A6r7CFY194XNWM+n+BWZBRoY=;
	b=LOUsPkChGWbB4E488gZZlovIj2TTDK5xR5VGBZRfUp2wqT1dozmhDiG0UeSBIxChX6aDCq
	+ZE0obr9MY4pErI0c/552gh+7gT4HPXXXt7BiJ1r3J2i8k/oStm4ES5odUgGJtPW/U+FSV
	qfTaWW9eKUwUSLkqRe5N1cKQOymUClI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727562208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxQaszsw3IyyQfsEnc0A6r7CFY194XNWM+n+BWZBRoY=;
	b=Ei9J4Fn9GICB505fRDTiZk7rgNbUnu0bYsnofitPsKiMuQfDIxX+YKenp+4tnQ35zhgZC0
	hHvZnNF2A9cFoAAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727562208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxQaszsw3IyyQfsEnc0A6r7CFY194XNWM+n+BWZBRoY=;
	b=LOUsPkChGWbB4E488gZZlovIj2TTDK5xR5VGBZRfUp2wqT1dozmhDiG0UeSBIxChX6aDCq
	+ZE0obr9MY4pErI0c/552gh+7gT4HPXXXt7BiJ1r3J2i8k/oStm4ES5odUgGJtPW/U+FSV
	qfTaWW9eKUwUSLkqRe5N1cKQOymUClI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727562208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxQaszsw3IyyQfsEnc0A6r7CFY194XNWM+n+BWZBRoY=;
	b=Ei9J4Fn9GICB505fRDTiZk7rgNbUnu0bYsnofitPsKiMuQfDIxX+YKenp+4tnQ35zhgZC0
	hHvZnNF2A9cFoAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0A2713A97;
	Sat, 28 Sep 2024 22:23:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KmbhGN2B+GbxIAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 28 Sep 2024 22:23:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Harald Dunkel" <harri@afaics.de>
Cc: "syzbot" <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>,
 "Jeff Layton" <jlayton@kernel.org>, Dai.Ngo@oracle.com,
 chuck.lever@oracle.com, kolga@netapp.com, linux-nfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tom@talpey.com
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_umount
In-reply-to: <eb6ef7e3-8980-4202-8b99-012d9269b236@afaics.de>
References: <>, <eb6ef7e3-8980-4202-8b99-012d9269b236@afaics.de>
Date: Sun, 29 Sep 2024 08:23:18 +1000
Message-id: <172756219838.470955.2955513122187106920@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Sat, 28 Sep 2024, Harald Dunkel wrote:
> Hi folks,
> 
> On 2024-09-21 09:58:55, Harald Dunkel wrote:
> > NeilBrown wrote:
> >>
> >> We can guess though.  It isn't waiting for a lock - that would show in
> >> the above list - so it might be waiting for a wakeup, or might be
> >> spinning.
> >> The only wake-up I can imagine is in one of the memory-allocation calls,
> >> but if the system were running out of memory we would probably see
> >> messages about that.
> >>
> > 
> > I have seen something like this. I am running NFS inside a container,
> > using legacy cgroup. When it got stuck it claimed I cannot login
> > into the container due to out of memory. When it happens again, I
> > can send you the exact error message. The next hung nfsd is overdue,
> > anyway.
> > 
> 
> my NFS server got stuck again last night. Unfortunately the service was
> recovered by a colleague, so I had no chance to check the memory. Attached
> you can find the log files of both nfs container and LXC server, with
> /proc/sys/kernel/hung_task_all_cpu_backtrace set to 1.
> 
> I dropped the kernel mailing list from this reply, due to large attachments.
> Hopefully this was OK?
> 
> Hope this helps. Please mail if I can help
> Harri
> 

Thanks for the logs.  The point to flush_workqueue() being a problem,
presumably from nfsd4_probe_callback_sync(), though I'm not 100% sure of
that.  Maybe some deadlock in the callback code.  I'm not very familiar
with that code and nothing immediately jumps out.

I had thought that hung_task_all_cpu_backtrace would show a backtrace of
*all* tasks - I missed the "cpu" in there.
If if it happens again and if you can
  echo t > /proc/sysrq-trigger
to get stack traces of everything, that might help.  Maybe it won't be
necessary if I or someone else can spot a deadlock with
flush_workqueue().

Thanks,
NeilBrown

