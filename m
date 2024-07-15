Return-Path: <linux-nfs+bounces-4892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67CF930F09
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A29B20BB1
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EF513AD11;
	Mon, 15 Jul 2024 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UCzUTmzD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OjwUK6bR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UCzUTmzD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OjwUK6bR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075A6AB8
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029651; cv=none; b=W+zANjxIPuXcYDYoQWosTkecWarTHk1tgyYi0iTJcBQrRMoXCFKnPNaZ8GkepKFcupe9p05IvWhi2GyPBuGAI6LPMBLjAw2JllICUNED6YFUz1ts+cz33QXOGkmWBOgBqt4OCAcCKtIXuqj7+1X9ZhYRALq3/3YbPmqe3uVvejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029651; c=relaxed/simple;
	bh=9aTLlOP7FxUseg5Y3TsRULjyaqcxmIxJpBqi2xOv/q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrId1pAIDRKyIJB/C11xow2SnWgOfwbsMzw1zfQfdz4sqxRrg9RmoSWAfIbH+xQvZILfBpyqbSyXB11w6U8roOFNx6hhFELAlWyhCKJc4LJa8UW/Ze4GB6SptdgXtm3RvClTJg/YgyRzoG4JwUN+PAFwz1pCTEBhI6rNrbieyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UCzUTmzD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OjwUK6bR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UCzUTmzD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OjwUK6bR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 546461F7B2;
	Mon, 15 Jul 2024 07:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DkgA9kb/4lyBLsw+CUWFqfW8hTtwohSUmTmPpPPsSc4=;
	b=UCzUTmzDtURvkRswchGBKpxxKQVOQgq+z3bY8w7BigjUWZWSDjNorRoHXJEqufg2gwb80Y
	/e0GImnxTkbCagRmlzu51cLCvCkmg36134X6X54Wm7APbThPTz0QY+Z2tEofE3A+PdILHG
	t5FHSX7Mq8bMiUbuH/ktyWtNc9GGMZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DkgA9kb/4lyBLsw+CUWFqfW8hTtwohSUmTmPpPPsSc4=;
	b=OjwUK6bRSqyohjbT5xY3fM7CiVqhdS0KYcGu+uXkkoCleB/Noti4yw0LDxgoyRqyy0T61U
	oez3PaFx2obd8UAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UCzUTmzD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OjwUK6bR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DkgA9kb/4lyBLsw+CUWFqfW8hTtwohSUmTmPpPPsSc4=;
	b=UCzUTmzDtURvkRswchGBKpxxKQVOQgq+z3bY8w7BigjUWZWSDjNorRoHXJEqufg2gwb80Y
	/e0GImnxTkbCagRmlzu51cLCvCkmg36134X6X54Wm7APbThPTz0QY+Z2tEofE3A+PdILHG
	t5FHSX7Mq8bMiUbuH/ktyWtNc9GGMZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DkgA9kb/4lyBLsw+CUWFqfW8hTtwohSUmTmPpPPsSc4=;
	b=OjwUK6bRSqyohjbT5xY3fM7CiVqhdS0KYcGu+uXkkoCleB/Noti4yw0LDxgoyRqyy0T61U
	oez3PaFx2obd8UAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E596F137EB;
	Mon, 15 Jul 2024 07:47:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2qRXJgzUlGasbQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:47:24 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 00/14 RFC] support automatic changes to nfsd thread count
Date: Mon, 15 Jul 2024 17:14:13 +1000
Message-ID: <20240715074657.18174-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 546461F7B2

This patch set (against nfsd-next) enables automatic adjustment of the
number of nfsd threads.  The number can increase under high load, and
reduce after idle periods.

The first few patches (1-6) are cleanups that may not be entirely
relevant to the current series.  They could safely land any time and
only need minimal review.

Patch 9,10,11 remove some places were sv_nrthreads are used for things
other than counting threads.  It is use to adjust other limits.  At the
time this seemed like an easy and sensible solution.  I now have to
repent of that short-cut and find a better way to impose reasonable
limits.

These and the other sundry patches (7,8,12) can, I think safely land
whenever that get sufficient review.  I think they are sensible even if
we won't end up adjusting threads dynamically.

Patches 13 and 14 build on all this to provide the desired
functionality.  Patch 13 allows the maximum to be configured, and patch
14 starts or stops threads based on some simple triggers.

For 13 I decided that if the user/admin makes no explicit configuration,
then the currently request number of threads becomes a minimum, and a
maximum is determined based on the amount of memory.  This will make
the patch set immediately useful but shouldn't unduly impact existing
configurations.

For patch 14 I only implemented starting a thread when there is work to
do but no threads to do it, and stopping a thread when it has been idle
for 5 seconds.  The start-up is deliberately serialised so at least one
NFS request is serviced between the decision to start a thread and the
action of starting it.  This hopefully encourages a ramping up of thread
count rather than a sudden jump.

There is certain room for discussion around the wisdom of these
heuristics, and what other heuristics are needed - we probably want a
shrinker to impose memory pressure of the number of threads.  We
probably want a thread to exit rather than retry when a memory
allocation in svc_alloc_arg() fails.

I certainly wouldn't recommend patch 14 landing in any hurry at all.

I'd love to hear what y'all think, and what experiences you have when
testing it.

Thanks,
NeilBrown





