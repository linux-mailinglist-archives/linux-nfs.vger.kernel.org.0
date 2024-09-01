Return-Path: <linux-nfs+bounces-6105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4193E967654
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Sep 2024 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3F71F217EB
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Sep 2024 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C07166F28;
	Sun,  1 Sep 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lixb/oG9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kxnNr8uq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lixb/oG9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kxnNr8uq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988951448D9
	for <linux-nfs@vger.kernel.org>; Sun,  1 Sep 2024 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725192385; cv=none; b=o9aUt2Bv93tqO6RidsEQATT5OASY8EVJ/dlNf1R3gglq+JYdSpG5E4e/fP3j5oZTt047gd+R/UXuZnpbgpxfr/xxrFCGMrrY5oCYvdBxoBSR0bg8cM4KQUygZmjbf+a3PiTt2/2XBxLXOAujQlsjo/YKGXHHrS0KLsTvBYno/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725192385; c=relaxed/simple;
	bh=xMl+ZEXNWFEUFlWkqqL0OnTvNzuEOxnuMRuCvjlmDjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esVnKJiQ2nQbwREaG8ctH+GQP8bER1LD7OrA7oqt+gq/oG1UuyDXWJ1o+KZ/5xS5VMnUI8L6pWeEQWL5PJy3sEzPxthN6uNv25GWihzF2DRS4HPhAkAB5/4K5TwwfH0NS7TcRVQwftBLlk49hUlgJFudI1/Lc6dAMMszMjq5Gro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lixb/oG9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kxnNr8uq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lixb/oG9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kxnNr8uq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D8EE21ADD;
	Sun,  1 Sep 2024 12:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725192381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b4YjQsAWNMfH/JM3gBbpk+CUwYlUczQlT5awgefuRL8=;
	b=Lixb/oG9ZdX43u9HWfEYEUiPw6gy3RwJgN2W7Tklnlev8102Rri7XkvQAvFQmG4c36qlUX
	R8mYW+T/9wgUtbqyCpWlz5WIOR/vec/l1E+ZuzjdFkuR0l+D6cV36cHAZleaU3cpQY8Bn5
	u7JC7lKFW+b5h7Py2XRZ/tmna2Ld1u8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725192381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b4YjQsAWNMfH/JM3gBbpk+CUwYlUczQlT5awgefuRL8=;
	b=kxnNr8uq7iwPGvbZVsIAMy5cREQS5tNHrqNsLlSzTbf2i16Bkfj8TnoNHBUKBZXJlMFvlD
	KRLr1aoSLmvQM9BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Lixb/oG9";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kxnNr8uq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725192381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b4YjQsAWNMfH/JM3gBbpk+CUwYlUczQlT5awgefuRL8=;
	b=Lixb/oG9ZdX43u9HWfEYEUiPw6gy3RwJgN2W7Tklnlev8102Rri7XkvQAvFQmG4c36qlUX
	R8mYW+T/9wgUtbqyCpWlz5WIOR/vec/l1E+ZuzjdFkuR0l+D6cV36cHAZleaU3cpQY8Bn5
	u7JC7lKFW+b5h7Py2XRZ/tmna2Ld1u8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725192381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b4YjQsAWNMfH/JM3gBbpk+CUwYlUczQlT5awgefuRL8=;
	b=kxnNr8uq7iwPGvbZVsIAMy5cREQS5tNHrqNsLlSzTbf2i16Bkfj8TnoNHBUKBZXJlMFvlD
	KRLr1aoSLmvQM9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6E431397F;
	Sun,  1 Sep 2024 12:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aUdfL7xY1GYlDAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Sun, 01 Sep 2024 12:06:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net,
	Petr Vorel <pvorel@suse.cz>,
	Steve Dickson <SteveD@RedHat.com>
Subject: [PATCH rpcbind 1/1] rpcb_prot.x: Update _PATH_RPCBINDSOCK
Date: Sun,  1 Sep 2024 14:06:09 +0200
Message-ID: <20240901120609.197824-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9D8EE21ADD
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

2f9ce0c updated rpcb_prot.h, but rpcb_prot.x must be updated as well.

Fixes: 2f9ce0c ("Move rpcbind.sock to /run")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Actually, tirpc/rpc/rpcb_prot.h should be generated by rpcgen, but I
just updated the header.

 tirpc/rpc/rpcb_prot.x | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tirpc/rpc/rpcb_prot.x b/tirpc/rpc/rpcb_prot.x
index 472c11f..e0e6031 100644
--- a/tirpc/rpc/rpcb_prot.x
+++ b/tirpc/rpc/rpcb_prot.x
@@ -410,8 +410,8 @@ program RPCBPROG {
 %#define	RPCBVERS_3		RPCBVERS
 %#define	RPCBVERS_4		RPCBVERS4
 %
-%#define	_PATH_RPCBINDSOCK	"/var/run/rpcbind.sock"
-%#define	_PATH_RPCBINDSOCK_ABSTRACT "\0/run/rpcbind.sock"
+%#define	_PATH_RPCBINDSOCK	"/run/rpcbind.sock"
+%#define	_PATH_RPCBINDSOCK_ABSTRACT "\0" _PATH_RPCBINDSOCK
 %
 %#else		/* ndef _KERNEL */
 %#ifdef __cplusplus
-- 
2.45.2


