Return-Path: <linux-nfs+bounces-8925-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE19A01DC9
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 03:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5090D161AF0
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2025 02:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63500846D;
	Mon,  6 Jan 2025 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wfmcRNkg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ot+UnYG5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wfmcRNkg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ot+UnYG5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB823A0
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jan 2025 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131682; cv=none; b=RalL89pPR38IASlaZPYNbPBgg/sqd2tElaDDo2NNn1i43EmKXYoZSU30AOBpl4ab4Zwy3WOihE9pWYi35XoieL+p/y5h1sHRmEEyQRfc04Ppp8mT5zNiOh6DoCAndCgt9n+FAxxrbKTI8pULPCWuPOneLhbnpKTfU1peQELfKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131682; c=relaxed/simple;
	bh=AvCHLmgBMa0COILasIaWGqTiPwU6ngEmKQeSYMORfEI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OLz10PlR+ZrEFJRfWiHL7vguE5HGrEkQaqwUU8m42i2R1+YCDMple7Em1vmnm7qSVk+siHdXm227961aGtPXJwuNweMBf9MU2//KtuhdEo1EwmtFjz8VEByHmrmKpNQEudf+QIhz2WdzleeRFNNBSfpyi+rbP3dur2IwOtTxO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wfmcRNkg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ot+UnYG5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wfmcRNkg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ot+UnYG5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A910C1F749;
	Mon,  6 Jan 2025 02:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736131678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCxQbsvhjv4FNpQbnxkh8ymKF7RbPxj13dHShEo5xI4=;
	b=wfmcRNkgxTZGhkk9lEkJ4caVTyWpISzgZl2R3xAhFq7pv1/b2RXUrhaLCT5FDlblUPE0XA
	tc+QmFjd/8W/N9zzHQOxBr1qfEm6I9Clz2IjhYDiCIYa/1Vu8AtCYKqZInWoHIwaEouWdY
	2cIyGjr47anyMjIV1Wz1CC/WDrJdvVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736131678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCxQbsvhjv4FNpQbnxkh8ymKF7RbPxj13dHShEo5xI4=;
	b=Ot+UnYG5o6zQJxEjMhwFmLkyUm+YR1s+jgnTMKoSLJMyQBTMBYyqm2J1GZOpzgGsdAGfVX
	egv+dtMbszaXMlBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736131678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCxQbsvhjv4FNpQbnxkh8ymKF7RbPxj13dHShEo5xI4=;
	b=wfmcRNkgxTZGhkk9lEkJ4caVTyWpISzgZl2R3xAhFq7pv1/b2RXUrhaLCT5FDlblUPE0XA
	tc+QmFjd/8W/N9zzHQOxBr1qfEm6I9Clz2IjhYDiCIYa/1Vu8AtCYKqZInWoHIwaEouWdY
	2cIyGjr47anyMjIV1Wz1CC/WDrJdvVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736131678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCxQbsvhjv4FNpQbnxkh8ymKF7RbPxj13dHShEo5xI4=;
	b=Ot+UnYG5o6zQJxEjMhwFmLkyUm+YR1s+jgnTMKoSLJMyQBTMBYyqm2J1GZOpzgGsdAGfVX
	egv+dtMbszaXMlBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E39C0139AB;
	Mon,  6 Jan 2025 02:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jnxAJVtEe2eHFAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 06 Jan 2025 02:47:55 +0000
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
In-reply-to: <354b8db5-0929-43ea-9934-69ee59b5d3a0@oracle.com>
References: <>, <354b8db5-0929-43ea-9934-69ee59b5d3a0@oracle.com>
Date: Mon, 06 Jan 2025 13:47:52 +1100
Message-id: <173613167253.22054.240015159831425031@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, 06 Jan 2025, Chuck Lever wrote:
> On 1/5/25 5:28 PM, NeilBrown wrote:
> > On Sun, 05 Jan 2025, Chuck Lever wrote:
> >> On 1/3/25 5:53 PM, Tejun Heo wrote:
> >>> On Sat, Jan 04, 2025 at 09:50:32AM +1100, NeilBrown wrote:
> >>>> On Fri, 03 Jan 2025, cel@kernel.org wrote:
> >>> ...
> >>>> I think that instead of passing "list_lru_count()" we should pass some
> >>>> constant like 1024.
> >>>>
> >>>> cnt = list_lru_count()
> >>>> while (cnt > 0) {
> >>>>      num = min(cnt, 1024);
> >>>>      list_lru_walk(...., num);
> >>>>      cond_sched()
> >>>>      cnt -= num;
> >>>> }
> >>>>
> >>>> Then run it from system_wq.
> >>>>
> >>>> list_lru_shrink is most often called as list_lru_shrink_walk() from a
> >>>> shrinker, and the pattern there is essentially that above.  A count is
> >>>> taken, possibly scaled down, then the shrinker is called in batches.
> >>>
> >>> BTW, there's nothing wrong with taking some msecs or even tens of msecs
> >>> running on system_unbound_wq, so the current state may be fine too.
> >>
> >> My thinking was that this work is low priority, so there should be
> >> plenty of opportunity to set it aside for a few moments and handle
> >> higher priority work. Maybe not worrisome on systems with a high core
> >> count, but on small SMP (eg VM guests), I've found that tasks like this
> >> can be rude neighbors.
> > 
> > None of the different work queues are expected to "set aside" the work
> > for more than a normal scheduling time slice.
> > system_long_wq was created "so that flush_scheduled_work() doesn't take
> > so long" but flush_scheduled_work() is never called now (and would
> > generate a warning if it was) so system_long_wq should really be
> > removed.
> > 
> > system_unbound_wq uses threads that are not bound to a CPU so the
> > scheduler can move them around.  That is most suitable for something
> > that might run for a long time.
> 
> That's not my understanding: unbound selects a CPU to run the work
> item on, and it can be (and usually is) not the same CPU as the one
> that invoked queue_work(). Then it isn't rescheduled. The work items
> are expected to complete quickly; work item termination is the typical
> reschedule point. My understanding, as always, could be stale.

If the work item will never schedule, then there isn't much point in
using a work queue.  The code can be run inline, or with a timer.

> 
> But that's neither here nor there: I've dropped the patch to replace
> system_unbound_wq with system_long_wq.
> 
> 
> > system_wq is bound to the CPU that schedules the work, but it can run
> > multiple work items - potentially long running ones - without trouble by
> > helping the scheduler share the CPU among them.  This requires that they
> > can sleep of course.
> > 
> > I haven't seen the actually symptoms that resulted in the various
> > changes to this code, but that last point is I think the key one.  The
> > work item, like all kernel code, needs to have scheduler points if it
> > might run for a longish time.  list_lru_walk() doesn't contain any
> > scheduling points so giving a large "nr_to_walk" is always a bad idea.
> 
> That might be a overstated... I don't see other consumers that are so
> concerned about rescheduling. But then it's not clear if they are
> dealing with lengthy LRU lists.

There are very few callers of list_lru_walk().
shrink_dcache_sb() is the closest analogue and it uses batches of 1024.
xfs_buftarg_drain() uses batches of LONG_MAX !!!

Mostly the lru is walked in a shrinker callback, and the shrinker
manages the batch size.

Thanks,
NeilBrown

> 
> 
> >> We could do this by adding a cond_resched() call site in the loop,
> >> or take Neil's suggestion of breaking up the free list across multiple
> >> work items that handle one or just a few file releases each.
> > 
> > I guess I should send a proper patch.
> 
> More comments in reply to that patch. Generally speaking, I'm
> comfortable chopping up the work as you propose, we just have to
> address some details.
> 
> 
> -- 
> Chuck Lever
> 


