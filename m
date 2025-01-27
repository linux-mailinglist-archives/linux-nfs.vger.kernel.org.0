Return-Path: <linux-nfs+bounces-9646-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E3CA1CF6A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 02:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5851881ACF
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 01:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837917BA1;
	Mon, 27 Jan 2025 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lCxy1Y+Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ykgn752U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lCxy1Y+Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ykgn752U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255A17555
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737940997; cv=none; b=lIarGyfsnF96SFZInnyIG9nb5FhDzyH46XlklU59ejOMSK7LKZCJouzxUkeTNDFb4H47u/ojLre22FSo4I+dg1+YbPmX0zGB68wIdUIbFaO8PSGa7gDs6YD4oEL9BfCtL2+4Jbp5LWFT13oeKJZFNwX4xah6BPLwnvhQLeXSPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737940997; c=relaxed/simple;
	bh=YVvnZQXnu3CFhVI864DmMtpV7dsTABnHZPr58TJL5Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJd8PsUuiJtrYDwIRn0IC5VcM4IEU8hLUmAipK6QM9tvd7dmM+tml9GVgUPiLMqfazFJEY4Kuhr0hjXMvI0Df4w/jRGdkFFcoIo2dA9cFyu6zvugAqkOO9mrEtjqEjPHur5AhUo2e+6MlI0Xx5JZSsHJPFH5IY/ftIPDw7BCshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lCxy1Y+Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ykgn752U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lCxy1Y+Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ykgn752U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E18D22115C;
	Mon, 27 Jan 2025 01:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737940992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eGTTfcLeYe1Lqj9VIQWfNipd3vR10H9G5Zgx1auWI+w=;
	b=lCxy1Y+ZKiDQKlw68TGEAxs3/oX/KwtrLw4GaYWuQMvwVPRvinQeFTugfD0pLtynkundJf
	p5XQfiwiFt3pLYT6OGuKjMWfcmwtUW8NCS76JwkJbKXPzwKSSJkXQ14gpQCeJM8ih8/AOx
	F4RqpmXSlrDWNV63HdUadcKIsMhonm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737940992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eGTTfcLeYe1Lqj9VIQWfNipd3vR10H9G5Zgx1auWI+w=;
	b=ykgn752U5S2vM0sOtEpmvVPn3DNJ1GJg2ghH0kxmXFtfKOLzJlnqaHv5bEtBX8ke+eyYUz
	bS9OrVGe09EPFxDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737940992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eGTTfcLeYe1Lqj9VIQWfNipd3vR10H9G5Zgx1auWI+w=;
	b=lCxy1Y+ZKiDQKlw68TGEAxs3/oX/KwtrLw4GaYWuQMvwVPRvinQeFTugfD0pLtynkundJf
	p5XQfiwiFt3pLYT6OGuKjMWfcmwtUW8NCS76JwkJbKXPzwKSSJkXQ14gpQCeJM8ih8/AOx
	F4RqpmXSlrDWNV63HdUadcKIsMhonm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737940992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eGTTfcLeYe1Lqj9VIQWfNipd3vR10H9G5Zgx1auWI+w=;
	b=ykgn752U5S2vM0sOtEpmvVPn3DNJ1GJg2ghH0kxmXFtfKOLzJlnqaHv5bEtBX8ke+eyYUz
	bS9OrVGe09EPFxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 722BF13782;
	Mon, 27 Jan 2025 01:23:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 90LVCf7flmfddwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 01:23:10 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/7] nfsd: filecache: change garbage collection lists
Date: Mon, 27 Jan 2025 12:20:31 +1100
Message-ID: <20250127012257.1803314-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[
davec added to cc incase I've said something incorrect about list_lru

Changes in this version:
  - no _bh locking
  - add name for a magic constant
  - remove unnecessary race-handling code
  - give a more meaningfule name for a lock for /proc/lock_stat
  - minor cleanups suggested by Jeff

]

The nfsd filecache currently uses  list_lru for tracking files recently
used in NFSv3 requests which need to be "garbage collected" when they
have becoming idle - unused for 2-4 seconds.

I do not believe list_lru is a good tool for this.  It does not allow
the timeout which filecache requires so we have to add a timeout
mechanism which holds the list_lru lock while the whole list is scanned
looking for entries that haven't been recently accessed.  When the list
is largish (even a few hundred) this can block new requests noticably
which need the lock to remove a file to access it.

This patch removes the list_lru and instead uses 2 simple linked lists.
When a file is accessed it is removed from whichever list it is on,
then added to the tail of the first list.  Every 2 seconds the second
list is moved to the "freeme" list and the first list is moved to the
second list.  This avoids any need to walk a list to find old entries.

These lists are per-netns rather than global as the freeme list is
per-netns as the actual freeing is done in nfsd threads which are
per-netns.

Thanks,
NeilBrown

 [PATCH 1/7] nfsd: filecache: remove race handling.
 [PATCH 2/7] nfsd: filecache: use nfsd_file_dispose_list() in
 [PATCH 3/7] nfsd: filecache: move globals nfsd_file_lru and
 [PATCH 4/7] nfsd: filecache: change garbage collection list
 [PATCH 5/7] nfsd: filecache: document the arbitrary limit on
 [PATCH 6/7] nfsd: filecache: change garbage collection to a timer.
 [PATCH 7/7] nfsd: filecache: give disposal lock a unique class name.


