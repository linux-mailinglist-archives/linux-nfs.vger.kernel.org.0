Return-Path: <linux-nfs+bounces-10358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8458A45582
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 07:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1126E3A397C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 06:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E56416DEB1;
	Wed, 26 Feb 2025 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Ryd1Gjz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pg6eKyTj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1Ryd1Gjz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pg6eKyTj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37F29D0E
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550914; cv=none; b=FiSeaognNi92qDbOsSIbpO1W/ifT94dQsBRYAG2kJo9noD2lhJ/If32bWMs4IweHO9v04b6s+H0gHizgg4G+hVDNFfzRvsjTZZEjgWonuSkRR/KfZk/mq5cyhAZlcVThlSQPk32RgLRPtazO9oouVfoPx+m8jN1FxUzEWPIQrtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550914; c=relaxed/simple;
	bh=noePQ+k583ZABFlfyu1FABV0xEHnCCG0BYycaHIkOno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfdXxiV2Mo6XTjOWZT9Z58l3ZAehNpJUff99IycteJJOdjYvCZB9HvGo4iN3IP5rvzNRbpBaZg67YyGECNJWqn27R9AQ8yFveMK8f9MRSxkmsWa1Zow5gsW+U5bsduosivQxDrTHJl1yxxtEhQhj0kpKbYVU7/h9bwDK3MO0auc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1Ryd1Gjz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pg6eKyTj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1Ryd1Gjz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pg6eKyTj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 118BF1F387;
	Wed, 26 Feb 2025 06:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740550911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GsUbRjR7STMcrejmqE7MqQ7Uepz+xT8omD7rEytZC8U=;
	b=1Ryd1GjzkUcRgVby5P/jdheqCIoX+Z1XRPaUnrmZF4lcGRe1pEQeJyB3VDHwfLnguT0A1Z
	JFXKbhk4G6pvRZ/ApTQOAw0AdVBQgkdc1H3wwfyhbwpH4QbbqeXcV/6N7TH92+dHFu06Hp
	KiM9dGkluylmcgCUKRAozJWkKJGBGMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740550911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GsUbRjR7STMcrejmqE7MqQ7Uepz+xT8omD7rEytZC8U=;
	b=pg6eKyTjcp21+/MpNyN8nCAWiYHDP715ydv32SMXJAVPp/N16TevHpzxukvjM37fsbz3DU
	S1N0dgGybHa8rWAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740550911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GsUbRjR7STMcrejmqE7MqQ7Uepz+xT8omD7rEytZC8U=;
	b=1Ryd1GjzkUcRgVby5P/jdheqCIoX+Z1XRPaUnrmZF4lcGRe1pEQeJyB3VDHwfLnguT0A1Z
	JFXKbhk4G6pvRZ/ApTQOAw0AdVBQgkdc1H3wwfyhbwpH4QbbqeXcV/6N7TH92+dHFu06Hp
	KiM9dGkluylmcgCUKRAozJWkKJGBGMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740550911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GsUbRjR7STMcrejmqE7MqQ7Uepz+xT8omD7rEytZC8U=;
	b=pg6eKyTjcp21+/MpNyN8nCAWiYHDP715ydv32SMXJAVPp/N16TevHpzxukvjM37fsbz3DU
	S1N0dgGybHa8rWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4952C1377F;
	Wed, 26 Feb 2025 06:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yyeRM/uyvmcjIAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 26 Feb 2025 06:21:47 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] prep patches for my mkdir series
Date: Wed, 26 Feb 2025 17:18:30 +1100
Message-ID: <20250226062135.2043651-1-neilb@suse.de>
X-Mailer: git-send-email 2.48.1
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

These two patches are cleanup are dependencies for my mkdir changes and
subsequence directory locking changes.  Both have been discussed with
the maintainers.  I would like these to land via the VFS tree to smooth
the way for landing the mkdir series which I plan to repost after these
are in vfs.all.

The patches are against 6.14-rc4

Thanks,
NeilBrown

 [PATCH 1/2] nfs/vfs: discard d_exact_alias()
 [PATCH 2/2] nfsd: drop fh_update() from S_IFDIR branch of

