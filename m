Return-Path: <linux-nfs+bounces-2079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20E86670A
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 00:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8A21F21208
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Feb 2024 23:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF331BC4A;
	Sun, 25 Feb 2024 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yudRTtSo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V9JzD9B6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yudRTtSo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V9JzD9B6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31B1BC46
	for <linux-nfs@vger.kernel.org>; Sun, 25 Feb 2024 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708905409; cv=none; b=XMz4nV0CsG7XFW5yAnt5lQjr6lkTxTKaVLe7RpAlg0gGwdWVFKr6xd+UAIRDSttKspntrlpqbHgcdbs3QBgj9Ghi7xfiMCoiaVBNVYVTCz2irYFEoJVEUFL06UelNtez6j6iqfgvZQUXxBKM97Zkp+OvrF5DTtdutMy+7AbULRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708905409; c=relaxed/simple;
	bh=IVhtrv+/GpaFzLZik2j4vWxNDQtKLvyJ66wQwR1utCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGdrEDMeAKSmjU0KHHy7sDlxok0U9gkPwzJ7863fudZTCzZZZ/HyVg6to8j4yUYgbhZ7lqjOGPz1/YHGeP/zsriJF7MSIHnZ0tLVMIOtLMD3zqKfRkS3X66VFyIqKMZAfhBPXyRHNrx6aKz7zTeOL6uGjrOPwCnSFClnGsSUwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yudRTtSo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V9JzD9B6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yudRTtSo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V9JzD9B6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E689224A6;
	Sun, 25 Feb 2024 23:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708905406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBD/PTNlRql+KYKWS7ScKHrTH9Lsr83brwo7SuPfEMI=;
	b=yudRTtSo8RW6iLZmzJ/pCErEBMqgfnroPqGlJmMklspxPrRQKR7EShLvbG5BvyBhtUqM5z
	5XftDmZHs6OmcDo1Zp/wAxTLaHgfv6pLXbFghrG8urY58aG8t8BvS1A+PhDSZNkk7fuzRP
	ejHI/L4zl7zjY7+yMXpgCXAHFwOz4qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708905406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBD/PTNlRql+KYKWS7ScKHrTH9Lsr83brwo7SuPfEMI=;
	b=V9JzD9B6Yc7bTaZ0/16XCzaKpH8shIF+MQU2nQvFqbTnI5lMnijvgrVoHdoX4hLb3C2boY
	6s7vQD9YEk0DCmBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708905406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBD/PTNlRql+KYKWS7ScKHrTH9Lsr83brwo7SuPfEMI=;
	b=yudRTtSo8RW6iLZmzJ/pCErEBMqgfnroPqGlJmMklspxPrRQKR7EShLvbG5BvyBhtUqM5z
	5XftDmZHs6OmcDo1Zp/wAxTLaHgfv6pLXbFghrG8urY58aG8t8BvS1A+PhDSZNkk7fuzRP
	ejHI/L4zl7zjY7+yMXpgCXAHFwOz4qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708905406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBD/PTNlRql+KYKWS7ScKHrTH9Lsr83brwo7SuPfEMI=;
	b=V9JzD9B6Yc7bTaZ0/16XCzaKpH8shIF+MQU2nQvFqbTnI5lMnijvgrVoHdoX4hLb3C2boY
	6s7vQD9YEk0DCmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A87B13432;
	Sun, 25 Feb 2024 23:56:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BN7rC7zT22WvJgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 25 Feb 2024 23:56:44 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH 1/4] manpage: describe use of extra port for broadcast rpc
Date: Mon, 26 Feb 2024 10:53:53 +1100
Message-ID: <20240225235628.12473-2-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225235628.12473-1-neilb@suse.de>
References: <20240225235628.12473-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yudRTtSo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V9JzD9B6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[26.08%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 0E689224A6
X-Spam-Flag: NO

From: NeilBrown <neilb@suse.com>

Some people notice the extra privileged UDP port that
rpcbind creates, and wonder what it is for.  So add
a section to the man page to explain it.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 man/rpcbind.8 | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/man/rpcbind.8 b/man/rpcbind.8
index fbf0ace24b27..6ba318f5ff77 100644
--- a/man/rpcbind.8
+++ b/man/rpcbind.8
@@ -66,6 +66,25 @@ reports the condition and terminates.
 The
 .Nm
 utility can only be started by the super-user.
+.Sh "BROADCAST RPC"
+.Nm
+supports a little-used part of the ONC-RPC specification known as
+Broadcast RPC.
+A client can send a UDP broadcast message to
+.Nm
+on every host on a local subnetwork, and each
+.Nm
+will forward the request to the local service if available.
+Should the service reply,
+.Nm
+will forward that reply back to the originator.
+To support this,
+.Nm
+creates an extra UDP socket bound to an arbitrary privileged port
+number, and uses it to forward requests to local services and to
+receive replies from them.
+When configuring a firewall, the "port 111" sockets may need to
+be accessible through the firewall, but the extra UDP socket does not.
 .Sh OPTIONS
 .Bl -tag -width indent
 .It Fl a
-- 
2.43.0


