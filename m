Return-Path: <linux-nfs+bounces-6023-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3366B96554D
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 04:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5674F1C22588
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A9B380;
	Fri, 30 Aug 2024 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s+0jdwQB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ASk/zJ4S";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s+0jdwQB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ASk/zJ4S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED52C18C
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985540; cv=none; b=uifrPvrA2E0AgOOEtHeYB3nJZW7X9QbZ3A2tGTSkiQpATQVUif0J59GUnfP3Z0+ZCggaUgf0bBwcTRhCV428RjzX8e+g7DsFSnM2rHnhX75zqTLbA4KnRansuCQXZluMPwXryNdy4vP6bLxwRMVifwnaEf7G21X8o2XsBKHX4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985540; c=relaxed/simple;
	bh=kceb6VbV7q6m6vdLnYFOEwDXV47r9PHlV1gCaykYXLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRaxBcG2sXYRj/uDxd3RSC8kjOqJoYCmm3Aes0RE2zyKanwR30AqqFknQzAHFkrA8uBJt5ZZP35rGQP220giSzhemSLoZ8ao0ibyPvQQPFuxnpECDkVlpTn41SbXnEssykRAilAP2ziqRlkERqx+vPPylZOCDD8DzQtPu7Cp4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s+0jdwQB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ASk/zJ4S; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s+0jdwQB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ASk/zJ4S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 59F03219F0;
	Fri, 30 Aug 2024 02:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W39Gx7xvGSGXI2BCobuFbZKxxNdwPb6u4fxkeHkJ9+k=;
	b=s+0jdwQByGgcIp+ZjeSLIbsbjHaW1LsWP5PBij2Isr1v+Cf///hvz04Etpt1GX9wb4sNFv
	7IjiiSiEqlgzt2Whtrc1R8DtNx+F+DZ1GLY7k+uwUGwFNHsGQh6DRXncAZIAxaoWmqMyZF
	TFI6fz+fj56MPbPcw3fvmZf5k/RMUNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W39Gx7xvGSGXI2BCobuFbZKxxNdwPb6u4fxkeHkJ9+k=;
	b=ASk/zJ4SVvMygtKzVdvnQlAGypVftbw4z+wPS/qFdk+sEZYMJCmUUGyNDPhW3iQMChmLnK
	2IDe/a7VYi9XptDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W39Gx7xvGSGXI2BCobuFbZKxxNdwPb6u4fxkeHkJ9+k=;
	b=s+0jdwQByGgcIp+ZjeSLIbsbjHaW1LsWP5PBij2Isr1v+Cf///hvz04Etpt1GX9wb4sNFv
	7IjiiSiEqlgzt2Whtrc1R8DtNx+F+DZ1GLY7k+uwUGwFNHsGQh6DRXncAZIAxaoWmqMyZF
	TFI6fz+fj56MPbPcw3fvmZf5k/RMUNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W39Gx7xvGSGXI2BCobuFbZKxxNdwPb6u4fxkeHkJ9+k=;
	b=ASk/zJ4SVvMygtKzVdvnQlAGypVftbw4z+wPS/qFdk+sEZYMJCmUUGyNDPhW3iQMChmLnK
	2IDe/a7VYi9XptDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2D12136A4;
	Fri, 30 Aug 2024 02:38:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RoyjIb8w0WbFFwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 02:38:55 +0000
From: NeilBrown <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v14-plus 00/25] Address netns refcount issues for localio
Date: Fri, 30 Aug 2024 12:20:13 +1000
Message-ID: <20240830023531.29421-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Following are revised versions of 6 patches from the v14 localio series.

The issue addressed is net namespace refcounting.

We don't want to keep a long-term counted reference in the client
because that prevents a server container from completely shutting down.

So we avoid taking a reference at all and rely on the per-cpu reference
to the server being sufficient to keep the net-ns active.  This involves
allowing the net-ns exit code to iterate all active clients and clear
their ->net pointers (which they need to find the per-cpu-refcount for
the nfs_serv).

So:
 - embed nfs_uuid_t in nfs_client.  This provides a list_head that can
   be used to find the client.  It does add the actual uuid to nfs_client
   so it is bigger than needed.  If that is really a problem we can find
   a fix.

 - When the nfs server confirms that the uuid is local, it moves the
   nfs_uuid_t onto a per-net-ns list.

 - When the net-ns is shutting down - in a "pre_exit" handler, all these
   nfS_uuid_t have their ->net cleared.  There is an rcu_synchronize()
   call between pre_exit() handlers and exit() handlers so and caller
   that sees ->net as not NULL can safely check the ->counter

 - We now pass the nfs_uuid_t to nfsd_open_local_fh() so it can safely
   look at ->net in a private rcu_read_lock() section.

I have compile tested this code but nothing more.

Thanks,
NeilBrown

 [PATCH 14/25] nfs_common: add NFS LOCALIO auxiliary protocol
 [PATCH 15/25] nfs_common: introduce nfs_localio_ctx struct and
 [PATCH 16/25] nfsd: add localio support
 [PATCH 17/25] nfsd: implement server support for NFS_LOCALIO_PROGRAM
 [PATCH 19/25] nfs: add localio support
 [PATCH 23/25] nfs: implement client support for NFS_LOCALIO_PROGRAM

