Return-Path: <linux-nfs+bounces-5599-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 508DB95C25C
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 02:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4069B22245
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 00:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E3D304;
	Fri, 23 Aug 2024 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cBbGsXGu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rE+JCLu6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cBbGsXGu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rE+JCLu6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B0BE47
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372618; cv=none; b=qOaHagpK2cLenty11OQfN6tVQOEbxRwhb4CQohg3MTIrNpgdNHcOIp8ahaKlhgsn++DEAmTgbDUU9WvBFKEbPs1ik5EeFmTWPrh2Z6dy/twBl6PZdWKHjncBxhya3XWF1njMgwILEqAgJJOHhvg5b1k7s0O2VvX+x/FQLni7+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372618; c=relaxed/simple;
	bh=DeWStmxRzPZhkhgRRHbOh951xt5AbZg3JiYSj2pdLH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfpyXQEsimg3UC4VpJ4zFfNwaofv5B9TFEjdBFncFP6cyns62eGOtTfcmB7MVI1qFFuBW9UIadSCzVuRb8fvWjo1Rhewdzc4+5IDRal0gi7ql3FscVdR18mJyI62991CJUzcH9/F89uGUCyBWMVzDKFKgw61qsgESLPlsmjbdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cBbGsXGu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rE+JCLu6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cBbGsXGu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rE+JCLu6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BAA2920276;
	Fri, 23 Aug 2024 00:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724372614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGmWjijc4DaZd1GoSAPtlPR5QSbdLTiNWvwyl+uT40o=;
	b=cBbGsXGuxDlYZv4iFR6iAey9Foa6BoD4nxHjR5kSuU2PUtpTz0VlKWAhz9WSfPCUU/FspN
	ywy8qBOFOgqsvz9fKPNkMQj64KgguwEG8HuRFxHrVNBBRrfwCtaJt3Y/iKQOVF3l2YKJUV
	Ram5Imu4FAJjSNXEY6/fbnpj4crfC+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724372614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGmWjijc4DaZd1GoSAPtlPR5QSbdLTiNWvwyl+uT40o=;
	b=rE+JCLu6ceV7V++7jWeleWJaEqDrJaSMBa6eSlNHrlZ32z75w2pTGMkKQl89iHDDT6mPEn
	P6pJnyV/p6auk8Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724372614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGmWjijc4DaZd1GoSAPtlPR5QSbdLTiNWvwyl+uT40o=;
	b=cBbGsXGuxDlYZv4iFR6iAey9Foa6BoD4nxHjR5kSuU2PUtpTz0VlKWAhz9WSfPCUU/FspN
	ywy8qBOFOgqsvz9fKPNkMQj64KgguwEG8HuRFxHrVNBBRrfwCtaJt3Y/iKQOVF3l2YKJUV
	Ram5Imu4FAJjSNXEY6/fbnpj4crfC+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724372614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGmWjijc4DaZd1GoSAPtlPR5QSbdLTiNWvwyl+uT40o=;
	b=rE+JCLu6ceV7V++7jWeleWJaEqDrJaSMBa6eSlNHrlZ32z75w2pTGMkKQl89iHDDT6mPEn
	P6pJnyV/p6auk8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E20213A3A;
	Fri, 23 Aug 2024 00:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WIvIIYbWx2bwBwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 00:23:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net,
	Petr Vorel <pvorel@suse.cz>,
	Steve Dickson <SteveD@RedHat.com>,
	Josue Ortega <josue@debian.org>,
	NeilBrown <neilb@suse.de>,
	Thomas Blume <Thomas.Blume@suse.com>,
	Yann Leprince <yann.leprince@ylep.fr>,
	Johannes Segitz <jsegitz@suse.com>
Subject: [RFC][PATCH rpcbind 3/4] systemd/rpcbind.service.in: Add various hardenings options
Date: Fri, 23 Aug 2024 02:23:21 +0200
Message-ID: <20240823002322.1203466-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823002322.1203466-1-pvorel@suse.cz>
References: <20240823002322.1203466-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

We've been running rpcbind 1.2.6 with it in openSUSE since 2021.

NOTE: In systemd < 244 (released Nov 2019) some of these options are
unknown and will produce warnings, see

https://en.opensuse.org/openSUSE:Security_Features#Systemd_hardening_effort

Cc: Johannes Segitz <jsegitz@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 systemd/rpcbind.service.in | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/systemd/rpcbind.service.in b/systemd/rpcbind.service.in
index c5bbd5e..272e55a 100644
--- a/systemd/rpcbind.service.in
+++ b/systemd/rpcbind.service.in
@@ -10,6 +10,16 @@ Requires=rpcbind.socket
 Wants=rpcbind.target
 
 [Service]
+ProtectSystem=full
+ProtectHome=true
+PrivateDevices=true
+ProtectHostname=true
+ProtectClock=true
+ProtectKernelTunables=true
+ProtectKernelModules=true
+ProtectKernelLogs=true
+ProtectControlGroups=true
+RestrictRealtime=true
 Type=notify
 # distro can provide a drop-in adding EnvironmentFile=-/??? if needed.
 EnvironmentFile=-/etc/rpcbind.conf
-- 
2.45.2


