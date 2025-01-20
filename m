Return-Path: <linux-nfs+bounces-9388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5048AA16635
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 05:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53EC18898AD
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 04:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AD8155316;
	Mon, 20 Jan 2025 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="xDELt6zF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9684A2B;
	Mon, 20 Jan 2025 04:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737348938; cv=none; b=MV9muIStwKCDUbxJCCTe2OLEAdDDEryTx0KyCgDBfN+gj+B22UhoVsH5mVSDKWyu+DTjjyJiYeaoZRzu7PvrrHhTLmGOQ4jZdnCXIofTQk410p6DUA8PrfYZVxXYvpFUoqvQadZrTy3APPS4w1jXKVfM7CSfTgIY5NT5QtRr/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737348938; c=relaxed/simple;
	bh=MN7ciMv3ykQQ8/B1G1lVz1FgEvsD+Yx9aJdqCLS7g1I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KvdKmRYarsG0e42UsCQDVf4KKbngGfztclsKIVhzXOYlvkRQfiTfD9byf6VfHauleeuwNvEfwDW1eu/r+6xIHLE0zafyEFlFajwY5g3QdGhZuBsbxttpZkmjBtkXCa7J16turB1XMog6xQQ4VaLdWDyTHY4lLC8F3Z7ziJyxpk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=xDELt6zF; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YbyhM1Vtqz9sc8;
	Mon, 20 Jan 2025 05:55:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1737348931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rrYKeGFLsHGSZ5GvrDU0SE64XtkrNNqCHmJUGmuWCiE=;
	b=xDELt6zF7IkU7u+ZSve+W0vyYBxgEDfTqTetM2AiAjuOZRaTt2Fu189yHzailrj4283yzH
	SKd6m1wlo9xx9pmjTe8cah6FVjRXJW+pu2sKVNlCm4nzymKFt6T4PQ1occblDUaOVbfP69
	vSImiz+gRo1sl7MaCwKjcQjjOy0VpHR7aRF7AI0kIlHgkNysLGknH5b4l64J4lm88GPt0J
	mG8nflJqlYxuFTLOhtmPJmity5dt0Js7i4+n+CnPejRDkqV4s+c2CTpsoe+Qh80Mwimvoo
	QTRA5+GvCAterjwwJPp5IW5dyqt/aM17H4nYSdLnPEtcMgdi2YDpAtBDj6Oh4w==
Date: Sun, 19 Jan 2025 23:55:27 -0500
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Subject: [PATCH] NFSv4: harden nfs4_get_uniquifier() function
Message-ID: <k7n2k4zqqnf6yisotj6ofgne7lvmwgy3yghygvwixfmkyrcwgl@4z26pbujl3gq>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 4YbyhM1Vtqz9sc8

If the incorrect buffer size were passed into nfs4_get_uniquifier
function then a memory access error could occur. This change prevents us
from accidentally passing an unrelated variable into the buffer copy
function.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 fs/nfs/nfs4proc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 405f17e6e0b4..18311bf5338d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6408,7 +6408,7 @@ static void nfs4_init_boot_verifier(const struct nfs_client *clp,
 }
 
 static size_t
-nfs4_get_uniquifier(struct nfs_client *clp, char *buf, size_t buflen)
+nfs4_get_uniquifier(struct nfs_client *clp, char *buf)
 {
 	struct nfs_net *nn = net_generic(clp->cl_net, nfs_net_id);
 	struct nfs_netns_client *nn_clp = nn->nfs_client;
@@ -6420,12 +6420,12 @@ nfs4_get_uniquifier(struct nfs_client *clp, char *buf, size_t buflen)
 		rcu_read_lock();
 		id = rcu_dereference(nn_clp->identifier);
 		if (id)
-			strscpy(buf, id, buflen);
+			strscpy(buf, id, sizeof(buf));
 		rcu_read_unlock();
 	}
 
 	if (nfs4_client_id_uniquifier[0] != '\0' && buf[0] == '\0')
-		strscpy(buf, nfs4_client_id_uniquifier, buflen);
+		strscpy(buf, nfs4_client_id_uniquifier, sizeof(buf));
 
 	return strlen(buf);
 }
@@ -6449,7 +6449,7 @@ nfs4_init_nonuniform_client_string(struct nfs_client *clp)
 		1;
 	rcu_read_unlock();
 
-	buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
+	buflen = nfs4_get_uniquifier(clp, buf);
 	if (buflen)
 		len += buflen + 1;
 
@@ -6496,7 +6496,7 @@ nfs4_init_uniform_client_string(struct nfs_client *clp)
 	len = 10 + 10 + 1 + 10 + 1 +
 		strlen(clp->cl_rpcclient->cl_nodename) + 1;
 
-	buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
+	buflen = nfs4_get_uniquifier(clp, buf);
 	if (buflen)
 		len += buflen + 1;
 
-- 
2.48.0


