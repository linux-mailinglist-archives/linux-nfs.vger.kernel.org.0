Return-Path: <linux-nfs+bounces-4481-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7607B91DD12
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 12:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4611F21131
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF09512D752;
	Mon,  1 Jul 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u8TUnFSX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aXUHzfti";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u8TUnFSX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aXUHzfti"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E2047F60
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831067; cv=none; b=uzyaLI2rardQGpCyLD6pFVvE7o0cAbNz/+1MJXpw8XSzOZ4McnA7n+3xWTR/bqSU+Pmx5dpsdeF8pvgkiIC017PB4aRGL7l5Uiw6Ggh/kRgpRg9Kqv4wEmsqg7fmv9KJeT4bIT0POSwqDcfYdu0LpmVHdzxAAv7wdVSsW29MR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831067; c=relaxed/simple;
	bh=EAvWN3B/OzWBY0s/FBT3XMcRk7fnqo6349gDNEpdhoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SSbeuvcRpU4SHzPAtXVvTjmqYnApwdY4I4l/VOYZ96LQZ/epRwrz/bnPjw3aL8NjQHzzrioIrN3JijyaM7A7ELCf/FlqHR3+e0dNIizUKZqZ7UNO6dY2Ufx2k7UR7BksBmYkffxOPydLPbOYudPe2EWe9w5TkItF7wkknaLHarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u8TUnFSX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aXUHzfti; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u8TUnFSX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aXUHzfti; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C0D71F828;
	Mon,  1 Jul 2024 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719831064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=S2HqJH0a6xgadTTJl8rI6O2Xeo/UirUZfVeHWwwYLS0=;
	b=u8TUnFSXDV6q/DhaWB+b2YRiTknGAGoxaegho3OjTa89enNEn5BxPub02oyIf5mzbYJ8JA
	mtF6VjdRLKWhsI3M3Zq6wkf7m6eJPzRFlSoI7AnN5OO8s0n8yOBL0qcZ+isobZNoyAHpy7
	+634zQaPUhkQr5vyJlVvZLqgbZZRf68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719831064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=S2HqJH0a6xgadTTJl8rI6O2Xeo/UirUZfVeHWwwYLS0=;
	b=aXUHzfti60zsFMSf4iU7yMYADXwINd2zDVp+y39DWEnWdNSWT9d6g0zPhX1dYECQ8AA3j8
	i1GlhltQh0gMWNBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719831064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=S2HqJH0a6xgadTTJl8rI6O2Xeo/UirUZfVeHWwwYLS0=;
	b=u8TUnFSXDV6q/DhaWB+b2YRiTknGAGoxaegho3OjTa89enNEn5BxPub02oyIf5mzbYJ8JA
	mtF6VjdRLKWhsI3M3Zq6wkf7m6eJPzRFlSoI7AnN5OO8s0n8yOBL0qcZ+isobZNoyAHpy7
	+634zQaPUhkQr5vyJlVvZLqgbZZRf68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719831064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=S2HqJH0a6xgadTTJl8rI6O2Xeo/UirUZfVeHWwwYLS0=;
	b=aXUHzfti60zsFMSf4iU7yMYADXwINd2zDVp+y39DWEnWdNSWT9d6g0zPhX1dYECQ8AA3j8
	i1GlhltQh0gMWNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 703C1139C2;
	Mon,  1 Jul 2024 10:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJVeGxiKgmYxLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jul 2024 10:51:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B2B2A088D; Mon,  1 Jul 2024 12:50:56 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	linux-nfs@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH RESEND v2 0/3] nfs: Improve throughput for random buffered writes
Date: Mon,  1 Jul 2024 12:50:45 +0200
Message-Id: <20240617073525.10666-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=jack@suse.cz; h=from:subject:message-id; bh=EAvWN3B/OzWBY0s/FBT3XMcRk7fnqo6349gDNEpdhoE=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGNKaOr9xTS7TYpL9OzFF9bVy2KXi954XMkqzHP+Ke01dbJeR sdGik9GYhYGRg0FWTJFldeRF7WvzjLq2hmrIwAxiZQKZwsDFKQAT8V/J/r/AYnaPgAHX9XC1wMdbzb Zl6nh0qx7538tUe17AaqHUtBdatl2yx20TQ5wtYyfe05b5PW/j/0gZhwsOHe8DKxZde3DN1rbY087p /5pDOXa2zyJdGOve3I2/6126/tqqFze87n546Jb4a3Hjn/KOifJWi9wvxrz+ox0pFybi5+IgtoNl17 pq2yIx1rN2UnbGnVx1HyISupvD93qWWTyq8b52TX5vSefmyhTDhIQFd0Vue7jf7eG8UW+f9ntbwbcZ Oz9uW+wg5cQVF1Wz9uKr2bpt2yK19m7ZO+OT1cQrOQ9qgn2Md71+qXtg02u9/xsPHpSXa7YyOb5UKJ ZX9a4Np33e065SO07DP3lKRnvLAQ==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.67
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.67 / 50.00];
	BAYES_HAM(-2.87)[99.43%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

[Resending because of messed up mailing list address]

Hello,

this is second revision of my patch series improving NFS throughput for
buffered writes.

Changes since v1:
* Added Reviewed-by tags
* Made sleep waiting for congestion to resolve killable

Original cover letter below:

I was thinking how to best address the performance regression coming from
NFS write congestion. After considering various options and concerns raised
in the previous discussion, I've got an idea for a simple option that could
help to keep the server more busy - just mimick what block devices do and
block the flush worker waiting for congestion to resolve instead of aborting
the writeback. And it actually helps enough that I don't think more complex
solutions are warranted at this point.

This patch series has two preparatory cleanups and then a patch implementing
this idea.

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20240612153022.25454-1-jack@suse.cz # v1

