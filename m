Return-Path: <linux-nfs+bounces-5598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E77295C25B
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 02:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A119283834
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 00:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29591C2FC;
	Fri, 23 Aug 2024 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V2p7nlko";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="djeaBOYg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V2p7nlko";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="djeaBOYg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA87BA46
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372618; cv=none; b=GcMFUifW1SKu3qDqhyEsAbR3hIpIp/30a+yiRhNq8BP/LwnEoSb+YOiIxnh00mG9gnwxyy74ELt0b8xYa3Q8KNYFIiJ7JxMTp0sVglU0sIYIGFiudxdU6AbvLXZvK7SU9AAvbCIj4nNpnvxVvkrgMNTvuVZuIUqCPuR9ZBAhRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372618; c=relaxed/simple;
	bh=Hw5+ZoZqsLYAabJkIG8K6mpv94YdJv30yQ0YfSJLUSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKT6mkk0fjBRy9sgwWlNv7cxu2vcA68ldc4J2vbFxmPpq8p7ij6EufU0G/8MeCmUF6Xjc4uZ7gyIsD25SCbXjp4j/TP+uADZzv2Mj3hjc8i/w28YiedfdJfhibaqbDtxOcIsm0kux/JE3buLXDSUvVxFbg4dgPJnylkVR9D3CK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V2p7nlko; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=djeaBOYg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V2p7nlko; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=djeaBOYg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8645120275;
	Fri, 23 Aug 2024 00:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724372614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qK1lEeH1+es5wgvsmrLQ9MztehyVkgOhmI0TSlCJ0ZU=;
	b=V2p7nlkouE+Zxv0fu2011mm0I6PXy4Gtnf99s+/ezPgXaVhusTkJsWz8cFkUD9eI9i/rV0
	/ZHvafs65N6QkOPhPOBuGonY4vapztTn9PehB7c1CorAcd2uui24lMlblAoH8giKqxgENd
	anMGdKd6l8Q1SpggQZvsbJl4+OJyobs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724372614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qK1lEeH1+es5wgvsmrLQ9MztehyVkgOhmI0TSlCJ0ZU=;
	b=djeaBOYgfM5ltx9TWeZvYFj/zcuJVohT69WjcCIc4G9WRyx3+j+yBdspbpAgTeV/wHNEYE
	AcLH3nPzr/YR2gBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724372614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qK1lEeH1+es5wgvsmrLQ9MztehyVkgOhmI0TSlCJ0ZU=;
	b=V2p7nlkouE+Zxv0fu2011mm0I6PXy4Gtnf99s+/ezPgXaVhusTkJsWz8cFkUD9eI9i/rV0
	/ZHvafs65N6QkOPhPOBuGonY4vapztTn9PehB7c1CorAcd2uui24lMlblAoH8giKqxgENd
	anMGdKd6l8Q1SpggQZvsbJl4+OJyobs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724372614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qK1lEeH1+es5wgvsmrLQ9MztehyVkgOhmI0TSlCJ0ZU=;
	b=djeaBOYgfM5ltx9TWeZvYFj/zcuJVohT69WjcCIc4G9WRyx3+j+yBdspbpAgTeV/wHNEYE
	AcLH3nPzr/YR2gBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42755139D3;
	Fri, 23 Aug 2024 00:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YN06D4bWx2bwBwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 00:23:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-nfs@vger.kernel.org
Cc: libtirpc-devel@lists.sourceforge.net,
	Josue Ortega <josue@debian.org>,
	Steve Dickson <SteveD@RedHat.com>,
	NeilBrown <neilb@suse.de>,
	Thomas Blume <Thomas.Blume@suse.com>,
	Yann Leprince <yann.leprince@ylep.fr>,
	Petr Vorel <pvorel@suse.cz>
Subject: [PATCH rpcbind 2/4] man/rpcbind: Add Files section to manpage
Date: Fri, 23 Aug 2024 02:23:20 +0200
Message-ID: <20240823002322.1203466-3-pvorel@suse.cz>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.78 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.892];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.78
X-Spam-Flag: NO

From: Josue Ortega <josue@debian.org>

Previous commit added 3 non-default files, mention them in man page.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 man/rpcbind.8 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/man/rpcbind.8 b/man/rpcbind.8
index fbf0ace..cdcdcfd 100644
--- a/man/rpcbind.8
+++ b/man/rpcbind.8
@@ -150,6 +150,14 @@ starts up. The state file is created when
 .Nm
 terminates.
 .El
+.Sh FILES
+The
+.Nm
+utility tries to load configuration file in following order:
+.Bd -literal
+.Pa /etc/rpcbind.conf
+.Pa /etc/default/rpcbind
+.Pa /etc/sysconfig/rpcbind
 .Sh NOTES
 All RPC servers must be restarted if
 .Nm
-- 
2.45.2


