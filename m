Return-Path: <linux-nfs+bounces-8920-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6DBA01C24
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 23:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCBB3A35DE
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 22:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F9D1CBA02;
	Sun,  5 Jan 2025 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hVxLlcJZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ym+kmXeQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hVxLlcJZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ym+kmXeQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56AC36B
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jan 2025 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736116146; cv=none; b=eeQYaXNx/wHQ4lHzQ0uynSMoxg/qDVhctGfKEL0JUvzbY2xsGO0w+7HZl2ea7Zs2C/ke+kKZx7e2BXr7DMUvV8SsBU3hkBTPe87Kc0SVfJQ/5khs4XkoCRMIns3m4ACj7swQ8Wshz7pGeij+G9IlUyrtxnxidliMw701pwfKG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736116146; c=relaxed/simple;
	bh=GvO8gJbYeTWc8q2jGoKPr+U48oKl8zPFHjq8HhqsT2w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oYlShEEGSjhc2bQXOOPO8DDii8GGSmT1dCvalK5vHc8OyJ7ehFRE/gSMdswSMGzw7GzmkBaJoRJtZ3wuqL/BMmx6zLs9ceRPJsAOOq1bbk8plfBDn6ffnmFoh0ovP2Dap/0FQ6XxFd/iR8Bx7Rp8wOTCJr31yqd/KAYxBLYypd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hVxLlcJZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ym+kmXeQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hVxLlcJZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ym+kmXeQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A3EC71F383;
	Sun,  5 Jan 2025 22:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736116142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dEeOXhV2Fl5lzQGFDm9nFYy3CCHIAQhsiAtdJ24MvM=;
	b=hVxLlcJZXbb7OCfvzQ79WfsjBEvsJe6Udk8lcsARaNgA4tVqgRugJzsChDFqVS3iqJ61Ry
	bKw4pUqFyrNS3yT7ZaskQAfCc/bPGuw0inz3d6BukCvASm6i6GqPW6HI6mS7Bjhja0crtL
	qvfbn5X3La7Jne1wdFcxB0gO3NBM//0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736116142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dEeOXhV2Fl5lzQGFDm9nFYy3CCHIAQhsiAtdJ24MvM=;
	b=Ym+kmXeQ2kD9DxoGHTUrOZyBCzWkL84IdWFBQwuMlETDS6ZBAT2WBEzep1fXLxnFugEy3S
	5+dqdhs/ZPWrMUAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hVxLlcJZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ym+kmXeQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736116142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dEeOXhV2Fl5lzQGFDm9nFYy3CCHIAQhsiAtdJ24MvM=;
	b=hVxLlcJZXbb7OCfvzQ79WfsjBEvsJe6Udk8lcsARaNgA4tVqgRugJzsChDFqVS3iqJ61Ry
	bKw4pUqFyrNS3yT7ZaskQAfCc/bPGuw0inz3d6BukCvASm6i6GqPW6HI6mS7Bjhja0crtL
	qvfbn5X3La7Jne1wdFcxB0gO3NBM//0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736116142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dEeOXhV2Fl5lzQGFDm9nFYy3CCHIAQhsiAtdJ24MvM=;
	b=Ym+kmXeQ2kD9DxoGHTUrOZyBCzWkL84IdWFBQwuMlETDS6ZBAT2WBEzep1fXLxnFugEy3S
	5+dqdhs/ZPWrMUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E308B137CF;
	Sun,  5 Jan 2025 22:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2txuJasHe2cCWwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 05 Jan 2025 22:28:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Tejun Heo" <tj@kernel.org>, cel@kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH v1 2/2] NFSD: Change the filecache laundrette workqueue again
In-reply-to: <3212763d-7c93-45ee-8b27-fe5d6a9e7fe8@oracle.com>
References: <>, <3212763d-7c93-45ee-8b27-fe5d6a9e7fe8@oracle.com>
Date: Mon, 06 Jan 2025 09:28:52 +1100
Message-id: <173611613288.22054.13027633542289679485@noble.neil.brown.name>
X-Rspamd-Queue-Id: A3EC71F383
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sun, 05 Jan 2025, Chuck Lever wrote:
> On 1/3/25 5:53 PM, Tejun Heo wrote:
> > On Sat, Jan 04, 2025 at 09:50:32AM +1100, NeilBrown wrote:
> >> On Fri, 03 Jan 2025, cel@kernel.org wrote:
> > ...
> >> I think that instead of passing "list_lru_count()" we should pass some
> >> constant like 1024.
> >>
> >> cnt = list_lru_count()
> >> while (cnt > 0) {
> >>     num = min(cnt, 1024);
> >>     list_lru_walk(...., num);
> >>     cond_sched()
> >>     cnt -= num;
> >> }
> >>
> >> Then run it from system_wq.
> >>
> >> list_lru_shrink is most often called as list_lru_shrink_walk() from a
> >> shrinker, and the pattern there is essentially that above.  A count is
> >> taken, possibly scaled down, then the shrinker is called in batches.
> > 
> > BTW, there's nothing wrong with taking some msecs or even tens of msecs
> > running on system_unbound_wq, so the current state may be fine too.
> 
> My thinking was that this work is low priority, so there should be
> plenty of opportunity to set it aside for a few moments and handle
> higher priority work. Maybe not worrisome on systems with a high core
> count, but on small SMP (eg VM guests), I've found that tasks like this
> can be rude neighbors.

None of the different work queues are expected to "set aside" the work
for more than a normal scheduling time slice.
system_long_wq was created "so that flush_scheduled_work() doesn't take
so long" but flush_scheduled_work() is never called now (and would
generate a warning if it was) so system_long_wq should really be
removed. 

system_unbound_wq uses threads that are not bound to a CPU so the
scheduler can move them around.  That is most suitable for something
that might run for a long time.

system_wq is bound to the CPU that schedules the work, but it can run
multiple work items - potentially long running ones - without trouble by
helping the scheduler share the CPU among them.  This requires that they
can sleep of course.

I haven't seen the actually symptoms that resulted in the various
changes to this code, but that last point is I think the key one.  The
work item, like all kernel code, needs to have scheduler points if it
might run for a longish time.  list_lru_walk() doesn't contain any
scheduling points so giving a large "nr_to_walk" is always a bad idea.

> 
> We could do this by adding a cond_resched() call site in the loop,
> or take Neil's suggestion of breaking up the free list across multiple
> work items that handle one or just a few file releases each.

I guess I should send a proper patch.

NeilBrown

> 
> -- 
> Chuck Lever
> 


