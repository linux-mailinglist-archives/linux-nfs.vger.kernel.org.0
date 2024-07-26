Return-Path: <linux-nfs+bounces-5054-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC97C93CCB1
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 04:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9931F21703
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 02:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEA18E11;
	Fri, 26 Jul 2024 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ACI2Rb9K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aevdTTci";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ACI2Rb9K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aevdTTci"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D27320B
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721960753; cv=none; b=Eb9coZjdObh2O6HWvKSdaqK8ipDKAwnYTbohlyPnKwAU78oBgVE0nE3c0HY9vZWJo7Emtkjuh9D+EKbqxyCL1ErgSr0Lm1q/U2xEl1/pYHc+mJjUYXs26jp0yZG3zzcao4xydlP5VBr6Q1N8M/Yn/88zWd2WoUXmKPv6YLTEaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721960753; c=relaxed/simple;
	bh=wz22thfoBVhP4zdD/NG+YgFf7U6nRbqwW/WHmCrj86g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnTHPvPMqEP5BlPrbZjqFsxi7zS2Ldk5FR1f0YqaCyZFZd1lnA7EznMwW19NvksjJrcPJ+PBKkebNh9XG9ZPCRd+L77gQr4Y9LgjDYuddwZLGdp9mv7BFI5KJEQY49luyG2Sf2EVB6LyDsPL9RHapAk5ggGPZQRE2IH6u++UCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ACI2Rb9K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aevdTTci; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ACI2Rb9K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aevdTTci; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41D1B218CE;
	Fri, 26 Jul 2024 02:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MMpzMKvx/FiZnaXWer/nljAoUb+VpQtPNUIMSREEYrY=;
	b=ACI2Rb9KhQe/Md64pC6geeNVuWHr2sYLj1Tj7+yS1s765XZ9YEUG5t2Me9fmTOdFH9qb8n
	10VtjNXO5CqI8JPIO23a8XteNqNQi+x+D0AwKYypyIaIDZy1W9DOvPrTATf5h9WbzRJmO0
	S5hZxCqWNvIe3pd+DnFbKaZ5xAKO/KY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MMpzMKvx/FiZnaXWer/nljAoUb+VpQtPNUIMSREEYrY=;
	b=aevdTTcituoZqI03SGAzEbEcc2C324K5hR5+KukN42hG3Smtjg328r+UzUYK3ZlCEKFaw1
	4apqeMrLEttSNCDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721960750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MMpzMKvx/FiZnaXWer/nljAoUb+VpQtPNUIMSREEYrY=;
	b=ACI2Rb9KhQe/Md64pC6geeNVuWHr2sYLj1Tj7+yS1s765XZ9YEUG5t2Me9fmTOdFH9qb8n
	10VtjNXO5CqI8JPIO23a8XteNqNQi+x+D0AwKYypyIaIDZy1W9DOvPrTATf5h9WbzRJmO0
	S5hZxCqWNvIe3pd+DnFbKaZ5xAKO/KY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721960750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MMpzMKvx/FiZnaXWer/nljAoUb+VpQtPNUIMSREEYrY=;
	b=aevdTTcituoZqI03SGAzEbEcc2C324K5hR5+KukN42hG3Smtjg328r+UzUYK3ZlCEKFaw1
	4apqeMrLEttSNCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27075138A7;
	Fri, 26 Jul 2024 02:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zcrzMisJo2aSWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Jul 2024 02:25:47 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/6] nfsd: assorted clean-ups
Date: Fri, 26 Jul 2024 12:21:29 +1000
Message-ID: <20240726022538.32076-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

My recent series (that may not now be needed) to allow fh_verify() to
not be given an rqstp pointer (instead taking the individual fields that
it actually needs) exposed several opportunities for improving code
cleanliness.  This series provides just those.

I'm not convinced that the last 2 are a genuine improvement, but that
follow a pattern set by earlier patches, and maybe they are a good idea.

There is some minor behavioural change in that some error codes are
changed as described in patch 3.

Thanks,
NeilBrown

 [PATCH 1/6] nfsd: Don't pass all of rqst into rqst_exp_find()
 [PATCH 2/6] nfsd: Pass 'cred' instead of 'rqstp' to some functions.
 [PATCH 3/6] nfsd: Move error code mapping to per-version xdr code.
 [PATCH 4/6] nfsd: use nfsd_v4client() in nfsd_breaker_owns_lease()
 [PATCH 5/6] nfsd: further centralize protocol version checks.
 [PATCH 6/6] nfsd: move V4ROOT version check to nfsd_set_fh_dentry()

