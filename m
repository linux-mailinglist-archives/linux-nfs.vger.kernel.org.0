Return-Path: <linux-nfs+bounces-6062-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D914896682C
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D7B1F23136
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0AF1BB69B;
	Fri, 30 Aug 2024 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z/848rN7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7JwsGMCS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nXd2QJMX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VwdgA0yp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14991BB68D
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039571; cv=none; b=HL6J1EdnHbzPp6lXmNlzhLszexEF4IpRiPy9sALvyCaxazqdRqD2QM27nff8LSCI4H5FXp/MyIp6beH5j4atb0XSntuVduvwDNyNC4EMZ9XOpSE9jC8rSuJQEAvpMEBl2vL/a6q1tayAYroUWW71zxV0uacNCcvdUabXX3DxvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039571; c=relaxed/simple;
	bh=t7Es6aEBsJn0utjIBPNY0i64DYFGaVRK9YQS1jGFzjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NdSPGhYCHGaB6r0E6KMQp4Stz9dqWgxf7k1fTb9eGwYeFeRiKW8nH2PwSUrFUQF5UBnwEM1iTvqE1IrmNFiWQYmziyO+RgRw+lE9FlyPwgbETe45UWBiSxkY67TLq68FlIkqZxoaejNo8sF7mUILOHXrKL4Pbanc5GPGJIDvjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z/848rN7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7JwsGMCS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nXd2QJMX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VwdgA0yp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 960381F7E2;
	Fri, 30 Aug 2024 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725039567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wkaKdDXbMaJBonm66U77xfRliVrPeT5hymustPh0RZY=;
	b=Z/848rN7d/ubg0Qdt38TTgfVrw9Mthiu1BSZ0CgStqL32OM3Bz5yawNxVT36xb9b7XHUJX
	vzSmy/gkDIbkDWQNQ7WOH+56ucGQR7nAHwqg1r4zL0y1m/laa/Xa2YN1r6I4bQAlu6RMAM
	ei+kBe/zIJGxYCoEVnWjFYThAyDT+bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725039567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wkaKdDXbMaJBonm66U77xfRliVrPeT5hymustPh0RZY=;
	b=7JwsGMCSpPqQQAvZAUjN47oztbaAEFaa0YzLF4tM+HiZH6TIztWJkJWl+6fIBfDMuiaquC
	d0kKMttq0m2IdkDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725039565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wkaKdDXbMaJBonm66U77xfRliVrPeT5hymustPh0RZY=;
	b=nXd2QJMXJJazbQQjsT4+3YKnkd/c1mfWte3xQMVJUmN1uE3OomYFOmHjdlQonGSouMMsNa
	LsfAXXiQoWZe5g/OVlwmlR4BiBDMIvvMBO6z+DDI7jMA/nEm+GGCWgKlnmZF/7OaSHKhLP
	9QFndcL6sSZTkwrGCTcZD0EOXbpbP9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725039565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wkaKdDXbMaJBonm66U77xfRliVrPeT5hymustPh0RZY=;
	b=VwdgA0ypjXwBKQ/Aun1ALp9G8L64DEHMWH1WgTQ/hhNMFsKzj9fkTxq61fHw6ROTjLwO73
	79iuby3bPQ6YdFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58F2213A3D;
	Fri, 30 Aug 2024 17:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F5yQFM0D0ma7IQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 30 Aug 2024 17:39:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net,
	Thomas Blume <thomas.blume@suse.com>,
	Steve Dickson <SteveD@RedHat.com>,
	Josue Ortega <josue@debian.org>,
	NeilBrown <neilb@suse.de>,
	Thomas Blume <Thomas.Blume@suse.com>,
	Yann Leprince <yann.leprince@ylep.fr>,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH rpcbind 1/1] Move rpcbind.lock to /run
Date: Fri, 30 Aug 2024 19:39:20 +0200
Message-ID: <20240830173920.88877-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

From: Thomas Blume <thomas.blume@suse.com>

Most of the distros have /var/run as symlink to /run.

Because /var may be a separate partition, and could even be mounted via
NFS, having to look directly to /run help to avoid issues rpcbind
startup early in boot when /var might not be available.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Thomas Blume <thomas.blume@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: I chose opensuse patch for the simplicity, instead of Debian
patch, which unsets _PATH_RPCBINDSOCK (libtirpc).

I'll send a separate patch for libtirpc.

Kind regards,
Petr

 src/rpcbind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rpcbind.c b/src/rpcbind.c
index ecebe97..9887b82 100644
--- a/src/rpcbind.c
+++ b/src/rpcbind.c
@@ -105,7 +105,7 @@ char *nss_modules = "files";
 /* who to suid to if -s is given */
 #define RUN_AS  "daemon"
 
-#define RPCBINDDLOCK "/var/run/rpcbind.lock"
+#define RPCBINDDLOCK "/run/rpcbind.lock"
 
 int runasdaemon = 0;
 int insecure = 0;
-- 
2.45.2


