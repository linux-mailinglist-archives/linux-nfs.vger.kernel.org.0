Return-Path: <linux-nfs+bounces-4286-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2497D915A43
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 01:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC83B235BD
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4B1A2553;
	Mon, 24 Jun 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yEg38E1j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zmc9p+Pd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yEg38E1j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zmc9p+Pd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07519FA92
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719270544; cv=none; b=sj5yRoCGm+q4Lps+h35skkWc+DE/xn+jD3gUn28gTZXvKtrISIFXe9oml4BV+BwbvRaOhgn/vXzFM+HoTSWvWlsXvvYFk+qExcvgdVhRt3ul0449c8/fe+wTvGue2n9jYAiWeYKaI3ZP42JTKxAHSHhl3dJ3RY65jMmElS5OLR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719270544; c=relaxed/simple;
	bh=XhB3q4wBzdYO+hqhkKTi1xpsaLyRC0ZrWcvtFB5AuCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUshMxueNp1QflXmKXZjCNbRnYQZK1bY3LI0TDHmxT2zFPYQLugoC3bhJxvnjbDSOqNPKKkHODqg9Kzb1gpUi2M987jBoaVamRISAEbZ7+O4UTa/KVEDnqlphY8XuKSK6NqahB5VXLTHTEazeLepht/QsbNCFCzWZyn/EQMI990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yEg38E1j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zmc9p+Pd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yEg38E1j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zmc9p+Pd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A8681F7E7;
	Mon, 24 Jun 2024 23:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719270541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4m8h2r4d3O1V72gjB+ZmpoEgee47F37BldhuQUZ348=;
	b=yEg38E1j0Wvwpqq43uhJ9006omaiWtmIMwHa27uQpXf0FbF1Fgye2sKm9N1vUB+YjVpipx
	/uXB6Yd2lCnusyt8ar/Rwuqk9NGarVS63lsKM3+9S6johBsnr6Dv1fJnlWOFOWrelrjFvt
	pjOb8O5J3TWZDQdXNkEi+LkNKggeuqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719270541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4m8h2r4d3O1V72gjB+ZmpoEgee47F37BldhuQUZ348=;
	b=Zmc9p+PdxN6PygZZFafI4sHyln0WJyz1Bv027ZXqi9d/S5NFpkRYlpc4Rhzzawspk7B13A
	jrzDkbFx/5ix3vDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719270541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4m8h2r4d3O1V72gjB+ZmpoEgee47F37BldhuQUZ348=;
	b=yEg38E1j0Wvwpqq43uhJ9006omaiWtmIMwHa27uQpXf0FbF1Fgye2sKm9N1vUB+YjVpipx
	/uXB6Yd2lCnusyt8ar/Rwuqk9NGarVS63lsKM3+9S6johBsnr6Dv1fJnlWOFOWrelrjFvt
	pjOb8O5J3TWZDQdXNkEi+LkNKggeuqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719270541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4m8h2r4d3O1V72gjB+ZmpoEgee47F37BldhuQUZ348=;
	b=Zmc9p+PdxN6PygZZFafI4sHyln0WJyz1Bv027ZXqi9d/S5NFpkRYlpc4Rhzzawspk7B13A
	jrzDkbFx/5ix3vDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91DC11384C;
	Mon, 24 Jun 2024 23:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uYPmDYr8eWZ4GwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Jun 2024 23:08:58 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/2] Revert "nfsd: fix oops when reading pool_stats before server is started"
Date: Tue, 25 Jun 2024 09:04:57 +1000
Message-ID: <20240624230734.17084-3-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624230734.17084-1-neilb@suse.de>
References: <20240624230734.17084-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

This reverts commit 8e948c365d9c10b685d1deb946bd833d6a9b43e0.

The reverted commit moves a test on a field protected by a mutex outside
of the protection of that mutex, and so is obviously racey.

Depending on how the race goes, si->serv might be NULL when dereferenced
in svc_pool_stats_start(), or svc_pool_stats_stop() might unlock a mutex
that hadn't been locked.

This bug that the commit tried to fix has been addressed by initialising
->mutex earlier.

Fixes: 8e948c365d9c ("nfsd: fix oops when reading pool_stats before server is started")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc_xprt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 49a3bea33f9d..dd86d7f1e97e 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1421,13 +1421,12 @@ static void *svc_pool_stats_start(struct seq_file *m, loff_t *pos)
 
 	dprintk("svc_pool_stats_start, *pidx=%u\n", pidx);
 
-	if (!si->serv)
-		return NULL;
-
 	mutex_lock(si->mutex);
 
 	if (!pidx)
 		return SEQ_START_TOKEN;
+	if (!si->serv)
+		return NULL;
 	return pidx > si->serv->sv_nrpools ? NULL
 		: &si->serv->sv_pools[pidx - 1];
 }
@@ -1459,8 +1458,7 @@ static void svc_pool_stats_stop(struct seq_file *m, void *p)
 {
 	struct svc_info *si = m->private;
 
-	if (si->serv)
-		mutex_unlock(si->mutex);
+	mutex_unlock(si->mutex);
 }
 
 static int svc_pool_stats_show(struct seq_file *m, void *p)
-- 
2.44.0


