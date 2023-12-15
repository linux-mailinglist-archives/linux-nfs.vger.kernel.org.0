Return-Path: <linux-nfs+bounces-614-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5216F813EEC
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 02:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0101F22C02
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 01:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E2815CA;
	Fri, 15 Dec 2023 01:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lnln5ssN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ktoJ29Jp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lnln5ssN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ktoJ29Jp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BAA1383
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D4BB2210C;
	Fri, 15 Dec 2023 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702602068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VayVtLY1uJfO53T1MkAg0/Hq/5boamJdiuvk/FnVkV4=;
	b=Lnln5ssNxX+4o2EaiQ6uzTI6TUyqlU0KfLMMQuOVxDYfoh52s9BzqH9iKMu3RY8a9fEZ0S
	i3FhjiwE5p0ybKv+5T+2KoQ493kIMuzb59wqEny3GoXQXmqOhrCYo0f1fNR3FADokZe51r
	fUtOppkSFvIZu9RCg5zZYzKxA+jgRIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702602068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VayVtLY1uJfO53T1MkAg0/Hq/5boamJdiuvk/FnVkV4=;
	b=ktoJ29Jp/fSL3ZKp8mOYdyjOFdC0KZI0ppO03FqVgmLIV+Z5d0HPDCF/zKkvzFmfFhLHi5
	U67S+0ZFpmaIQ+Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702602068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VayVtLY1uJfO53T1MkAg0/Hq/5boamJdiuvk/FnVkV4=;
	b=Lnln5ssNxX+4o2EaiQ6uzTI6TUyqlU0KfLMMQuOVxDYfoh52s9BzqH9iKMu3RY8a9fEZ0S
	i3FhjiwE5p0ybKv+5T+2KoQ493kIMuzb59wqEny3GoXQXmqOhrCYo0f1fNR3FADokZe51r
	fUtOppkSFvIZu9RCg5zZYzKxA+jgRIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702602068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VayVtLY1uJfO53T1MkAg0/Hq/5boamJdiuvk/FnVkV4=;
	b=ktoJ29Jp/fSL3ZKp8mOYdyjOFdC0KZI0ppO03FqVgmLIV+Z5d0HPDCF/zKkvzFmfFhLHi5
	U67S+0ZFpmaIQ+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84B5A137E8;
	Fri, 15 Dec 2023 01:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e8dXD1Kle2XLTwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Dec 2023 01:01:06 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/5] nfsd: hold nfsd_mutex across entire netlink operation
Date: Fri, 15 Dec 2023 11:56:33 +1100
Message-ID: <20231215010030.7580-4-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215010030.7580-1-neilb@suse.de>
References: <20231215010030.7580-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 7.27
X-Spam-Flag: NO
X-Spam-Flag: NO
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[26.10%]
X-Spam-Level: ****
X-Spam-Score: 4.90
Authentication-Results: smtp-out1.suse.de;
	none

Rather than using svc_get() and svc_put() to hold a stable reference to
the nfsd_svc for netlink lookups, simply hold the mutex for the entire
time.

The "entire" time isn't very long, and the mutex is not often contented.

This makes way for us to remove the refcounts of svc, which is more
confusing than useful.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsctl.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 2923da1537d2..3368eb5342dc 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1521,11 +1521,10 @@ int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb)
 	int ret = -ENODEV;
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv) {
-		svc_get(nn->nfsd_serv);
+	if (nn->nfsd_serv)
 		ret = 0;
-	}
-	mutex_unlock(&nfsd_mutex);
+	else
+		mutex_unlock(&nfsd_mutex);
 
 	return ret;
 }
@@ -1697,8 +1696,6 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
  */
 int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
 {
-	mutex_lock(&nfsd_mutex);
-	nfsd_put(sock_net(cb->skb->sk));
 	mutex_unlock(&nfsd_mutex);
 
 	return 0;
-- 
2.43.0


