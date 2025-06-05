Return-Path: <linux-nfs+bounces-12120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BF7ACE98D
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 08:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CD31760EC
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 06:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443712AF19;
	Thu,  5 Jun 2025 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eN5T2daD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mykBatRq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eN5T2daD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mykBatRq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7F51FC8
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749103255; cv=none; b=QepjFIcVo/osfhr1sxdXYUJtO1wL6+tY5PRGYDzvks9YkliWUzuihxfyDFE/05EyyuXYmXOOZDqts3MsKtTVLiwTRWtMnUE5AAhY0Vjs93BCdsRBpWgbBQQ734BzHxy3K2R90BlMP9PnPh/CGjBv1R84V5ite+jhy3pHxEVGsuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749103255; c=relaxed/simple;
	bh=c5D/n1dg5cRzwvbA1u4iSa6s517R9zs3DFR66bN4S+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUuqOthkYvAFcr9Oba4w2HJifpFPGj+tElHO+EyjOloJXErSq+qWOALwIaCZbMpF3DHhTN3E638AsiIcgMbICs5NkW44XmBDUjhFFCArR/kdHKhnyI9ybap7PR10FCVd1g4aVNotLunwUs9C3mQHZNv0KdaxADA8wnMYfAjs/xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eN5T2daD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mykBatRq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eN5T2daD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mykBatRq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8AE1D22AA5;
	Thu,  5 Jun 2025 06:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749103251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7gLTCOXPV6EfoHlJeLt4y7PACTAT2pHxG5ynf6RAG1w=;
	b=eN5T2daDfRd5AXBkM3KlWvNcviMekJkyDsMLihStmHizejjt9yyBfSDc2l1vgt/fJDN1ZK
	OfITHvt1wMPrtNtusVv0zqc/HuPVFAUeviggYOiagBJcIk7GfTekb/BTgCt9iVuEmAOCVY
	VcJqfBIP2x6J3Iwl53OgRVpx9qdYlh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749103251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7gLTCOXPV6EfoHlJeLt4y7PACTAT2pHxG5ynf6RAG1w=;
	b=mykBatRqkuwZN36hzLF1ah/VJeup1nT99APt/LCA/oBZVAuyHhb4x/10C0WI9WhcrVxGR/
	p2Nr3IQi++UdkODQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eN5T2daD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mykBatRq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749103251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7gLTCOXPV6EfoHlJeLt4y7PACTAT2pHxG5ynf6RAG1w=;
	b=eN5T2daDfRd5AXBkM3KlWvNcviMekJkyDsMLihStmHizejjt9yyBfSDc2l1vgt/fJDN1ZK
	OfITHvt1wMPrtNtusVv0zqc/HuPVFAUeviggYOiagBJcIk7GfTekb/BTgCt9iVuEmAOCVY
	VcJqfBIP2x6J3Iwl53OgRVpx9qdYlh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749103251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7gLTCOXPV6EfoHlJeLt4y7PACTAT2pHxG5ynf6RAG1w=;
	b=mykBatRqkuwZN36hzLF1ah/VJeup1nT99APt/LCA/oBZVAuyHhb4x/10C0WI9WhcrVxGR/
	p2Nr3IQi++UdkODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DE461373E;
	Thu,  5 Jun 2025 06:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dyIDFpMyQWicEQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 05 Jun 2025 06:00:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net,
	Petr Vorel <pvorel@suse.cz>,
	Steve Dickson <SteveD@RedHat.com>,
	=?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH rpcbind 1/2] man/rpcbind: Update list of options
Date: Thu,  5 Jun 2025 08:00:41 +0200
Message-ID: <20250605060042.1182574-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8AE1D22AA5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

-L was removed in 718ab7e, -w added in 9b1aaa6, -f added in eb36cf1.

Fixes: 718ab7e ("Removed the documentation about the non-existent '-L' flag")
Fixes: 9b1aaa6 ("Allow the warms start code to be enabled at compile time...")
Fixes: eb36cf1 ("rpcbind: add no-fork mode")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 man/rpcbind.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/rpcbind.8 b/man/rpcbind.8
index cdcdcfd..cd0f817 100644
--- a/man/rpcbind.8
+++ b/man/rpcbind.8
@@ -11,7 +11,7 @@
 .Nd universal addresses to RPC program number mapper
 .Sh SYNOPSIS
 .Nm
-.Op Fl adhiLls
+.Op Fl adfhilsw
 .Sh DESCRIPTION
 The
 .Nm
-- 
2.49.0


