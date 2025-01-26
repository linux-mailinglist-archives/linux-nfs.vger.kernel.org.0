Return-Path: <linux-nfs+bounces-9643-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0118EA1CF03
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 23:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A00E3A507C
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 22:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE328399;
	Sun, 26 Jan 2025 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YIdmd+u3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Rza3CHyZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YIdmd+u3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Rza3CHyZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4F9AD39
	for <linux-nfs@vger.kernel.org>; Sun, 26 Jan 2025 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737930820; cv=none; b=LG3rUNLWnnLRoWdBsIVh480dQVkYSXjhumIQgTm5LbDxCdn/70ne0d/7NzEo+wrYykOuPe7RG3/HM+Iqg5vfETBLbKpg2/B48zcxAAk4MI7xb2IRy769dN+YCDljq67WNK+w6SCTRNN14gqnlSz4vRf0ObY/SWMv5w2WmsbNAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737930820; c=relaxed/simple;
	bh=gf0CqhsiMBGuz9GW87mrn8E0dX2hpwdcL2lXryBr3RQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=A6NmTXpxaVreDibdKNtUWLzV1wqbyOszZni3R/mbxxg5scoJWd3GNIilatJXM2U+6V7YK+Ev9rqHs0ikwr6ZCwCMeFY0TxRSvtFfRIJQrpW5JujafK7qiHwlg0mbZH6Wf/zWWrNTNtrQ2fH6fPtdoLAw/j3KAOSxVw9mSeHy0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YIdmd+u3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Rza3CHyZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YIdmd+u3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Rza3CHyZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B13C21133;
	Sun, 26 Jan 2025 22:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737930816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baBmZusrIlolKujoV8oA/CW6KrviLg8uwrNeOIkqCHI=;
	b=YIdmd+u34C/Ks+Cdwj7tX+gb9NoY+1K3q4CkuEQHKWYvVgDP7g7mhRSeEm8t4y5z5fIjeB
	jR1jAZELM/ZPkJBjswa0DVN1ByRXqfGlWcKHPuSdZMlLLDLG0dM5iJ8k5aQi0af2OuSDL3
	ywSTnMmhuU4+fFZjivaj6F81oN98+vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737930816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baBmZusrIlolKujoV8oA/CW6KrviLg8uwrNeOIkqCHI=;
	b=Rza3CHyZ0n5Ye1/7GQ6GR4DErgr+3zHIeCobXd6L+qa67QlCZAOMx/vno/dazr0InHdl55
	R6r2A8OiFG5WpEAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YIdmd+u3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Rza3CHyZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737930816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baBmZusrIlolKujoV8oA/CW6KrviLg8uwrNeOIkqCHI=;
	b=YIdmd+u34C/Ks+Cdwj7tX+gb9NoY+1K3q4CkuEQHKWYvVgDP7g7mhRSeEm8t4y5z5fIjeB
	jR1jAZELM/ZPkJBjswa0DVN1ByRXqfGlWcKHPuSdZMlLLDLG0dM5iJ8k5aQi0af2OuSDL3
	ywSTnMmhuU4+fFZjivaj6F81oN98+vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737930816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baBmZusrIlolKujoV8oA/CW6KrviLg8uwrNeOIkqCHI=;
	b=Rza3CHyZ0n5Ye1/7GQ6GR4DErgr+3zHIeCobXd6L+qa67QlCZAOMx/vno/dazr0InHdl55
	R6r2A8OiFG5WpEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71F4613A60;
	Sun, 26 Jan 2025 22:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QVI2CT64lmeDJwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 26 Jan 2025 22:33:34 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 2/4] nfsd: filecache: move globals nfsd_file_lru and
 nfsd_file_shrinker to be per-net
In-reply-to: <c9adeaa6-0d6d-4b20-ad70-61d7a4cf344b@oracle.com>
References: <>, <c9adeaa6-0d6d-4b20-ad70-61d7a4cf344b@oracle.com>
Date: Mon, 27 Jan 2025 09:33:31 +1100
Message-id: <173793081107.22054.1714283530462488590@noble.neil.brown.name>
X-Rspamd-Queue-Id: 9B13C21133
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 24 Jan 2025, Chuck Lever wrote:
> On 1/22/25 5:10 PM, NeilBrown wrote:
> > On Thu, 23 Jan 2025, Chuck Lever wrote:
> >> On 1/21/25 10:54 PM, NeilBrown wrote:
> >>> The final freeing of nfsd files is done by per-net nfsd threads (which
> >>> call nfsd_file_net_dispose()) so it makes some sense to make more of the
> >>> freeing infrastructure to be per-net - in struct nfsd_fcache_disposal.
> >>>
> >>> This is a step towards replacing the list_lru with simple lists which
> >>> each share the per-net lock in nfsd_fcache_disposal and will require
> >>> less list walking.
> >>>
> >>> As the net is always shutdown before there is any chance that the rest
> >>> of the filecache is shut down we can removed the tests on
> >>> NFSD_FILE_CACHE_UP.
> >>>
> >>> For the filecache stats file, which assumes a global lru, we keep a
> >>> separate counter which includes all files in all netns lrus.
> >>
> >> Hey Neil -
> >>
> >> One of the issues with the current code is that the contention for
> >> the LRU lock has been effectively buried. It would be nice to have a
> >> way to expose that contention in the new code.
> >>
> >> Can this patch or this series add some lock class infrastructure to
> >> help account for the time spent contending for these dynamically
> >> allocated spin locks?
> > 
> > Unfortunately I don't know anything about accounting for lock contention
> > time.
> > 
> > I know about lock classes for the purpose of lockdep checking but not
> > how they relate to contention tracking.
> > Could you give me some pointers?
> 
> Sticking these locks into a class is all you need to do. When lockstat
> is enabled, it automatically accumulates the statistics for all locks
> in a class, and treats that as a single lock in /proc/lock_stat.
> 

Ahh thanks.  So I don't need to do anything as this lock has it's own
spin_lock_init() so it already has it's own class.
However.... the init call is :

	spin_lock_init(&l->lock);

so that appear in /proc/lock_stat as

      &l->lock:
or maybe
      &l->lock/1:
or even
      &l->lock/2:

Maybe I should change the "l" to something more unique. "nfd" ??
Or I could actually define a lock_class_key and call __spin_lock_init:

   __skin_lock_init(&l->lock, "nfsd_fcache_disposal->lock", &key,
     false);

There is no precedent for that though.

NeilBrown

