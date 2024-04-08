Return-Path: <linux-nfs+bounces-2705-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C89C89B5D4
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 04:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503952816DC
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 02:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7354115C3;
	Mon,  8 Apr 2024 02:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x9qZHUdp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l4zXBeYx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TYSQjRmN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aY9/kA6G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C515A8
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 02:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542332; cv=none; b=pwH+MPOVlO0WuK7MXQm4xt0YsAChbDdxQF8elk7IZ0rWgPNFz1JNYTcQT1WV2AlTIwIeH8t8Vw5XvXwiIu5Ufz8saJzoL8GFdn9vwQs0WaqZyw62lE2QSnfgodsM5bluj8ACLfJAzdjjVDlK1LuDwUSpT90d/SmmEOz6lOviwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542332; c=relaxed/simple;
	bh=sHgcz6t1Lmtsb8tjKsX+5WWSSsEzf3on3CiiJuSdBEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqPnuRVA47BY5Gm/+Vghr/oV9jtGbYeFLD6ONQaTQJeoSS4AAB0bke9gb3A9OMI+aj2sez26s5PiG57BfeHmOznzKaBbK5DSXsLueT0aiJa81hyCta1Hck41xwIIx9necS7thNuTen5GvL7Rn/utPDWbY1Q6zS7hpRepyuaT0nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x9qZHUdp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l4zXBeYx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TYSQjRmN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aY9/kA6G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF5DC21753;
	Mon,  8 Apr 2024 02:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iGs5rO14bJ90XHrYDHqC8Bga0bIaEP4t13qlhqHouak=;
	b=x9qZHUdpy7+ZOJoBG2yH0XlsxpftVjNQIGMi3Me+SC6SEQ1JzxEnjZG8Dh2WJzeEnbaqVY
	ZXUiU5ON4y/dqljD3nP/Iyod44Hbc606sEI8h9xp1mNsbckq+WKGpDpnJtP5oCaJV0B1xi
	g0sBRiYRH6jK55q4PKWjX/JH9+RcTSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iGs5rO14bJ90XHrYDHqC8Bga0bIaEP4t13qlhqHouak=;
	b=l4zXBeYxFN3C0DtGgv3Kauj2kH8ktIf17cmqGp98/qZOv41r45UncMz1chHFNaoxBdGQ46
	p77DtJsOEC13BOAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TYSQjRmN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="aY9/kA6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712542328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iGs5rO14bJ90XHrYDHqC8Bga0bIaEP4t13qlhqHouak=;
	b=TYSQjRmN87kBvdITIRVyDrBstCRiHmLMywYr4AceCagQb46EGJkNKQibk0ELVHRvNSkerR
	jFsTH3xyT7rjEvVghZSs9Fkg37GfV1m4v/GSzUMLLSb4qkMrWEhHD/8+SX1gYt42Dc0NZb
	r2hN9TqedGLfOvXko8xdZjlKevg3oDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712542328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iGs5rO14bJ90XHrYDHqC8Bga0bIaEP4t13qlhqHouak=;
	b=aY9/kA6GEpsz7A94XvR5zk1h0+y9Pl54nAqjc8BQPL9wn61EbrxB9P7dRpJ+SP324XztAr
	SciCsPD5YracWTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5696D13796;
	Mon,  8 Apr 2024 02:12:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I++kOnVSE2brEQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 08 Apr 2024 02:12:05 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/4 v4] nfsd: fix deadlock in move_to_close_lru()
Date: Mon,  8 Apr 2024 12:09:14 +1000
Message-ID: <20240408021156.6104-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-1.70)[93.12%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EF5DC21753
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.71

This series replaces 
   nfsd: drop st_mutex and rp_mutex before calling move_to_close_lru()
which was recently dropped as a problem was found.
The first two patches rearrange code without important functional change.
The last two address the two relaced problems of two different mutexes which are 
held while waiting and can each trigger a deadlock.

This is against v6.9-rc2.

Thanks,
NeilBrown

 [PATCH 1/4] nfsd: perform all find_openstateowner_str calls in the
 [PATCH 2/4] nfsd: move nfsd4_cstate_assign_replay() earlier in open
 [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in
 [PATCH 4/4] nfsd: drop st_mutex before calling move_to_close_lru()

