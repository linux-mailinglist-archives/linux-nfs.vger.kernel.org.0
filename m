Return-Path: <linux-nfs+bounces-4285-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A2B915A42
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 01:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A1928674A
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 23:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9315E19FA92;
	Mon, 24 Jun 2024 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GAO7wQu8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n01LpZ7Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GAO7wQu8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n01LpZ7Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A41A2562
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719270538; cv=none; b=t/5+WjnH3Bh1/tZMaR60c+V2C+MDjPdOXTZDdI3w+BYvZCbMJv6qvpdn6mdQXYETq8iwQNU36F5Z+0YfbboFN7Zcw+1c3xTtVM8/CnQRqXRjLAwXqkzVmOyL/rDF475QhDSNT9sVD5n4uFDJgkljpmajEDP2RbZUHnS8t5hi8UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719270538; c=relaxed/simple;
	bh=ZKG3Mv0Vx823DTifHNP0YUwPVeCjYRt0N/tcGY/CmsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsbKuP4slFG5k+oauQY+cehF/0WwvCwwaP+L9o0yc6IDZ4Z2YEXeKSkbVeTnfFfZE7NZT6R4d9JvQEY8CPHSrSSKd5x44OSU78oSk+Vxowwa57YPibox8wUzV1XTlzOdwNMFromHSQ86PCWdU93ugATmUikAH3kGyAxygimHru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GAO7wQu8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n01LpZ7Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GAO7wQu8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n01LpZ7Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7846221A15;
	Mon, 24 Jun 2024 23:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719270534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXMtkGnjjCSX8B4PrtTIPLrttdZuNQiBGbDlDvZtG4M=;
	b=GAO7wQu8A1mZVCdltO7/sY4APt6oNV9h6g5vYky68GFKXp554eD6vkSk0AKrgU1zzXsC2W
	PFVIteHSjzBlj76IjBFrVZ1jxpfqSH2WYSzCgZ75JHmEy5lSV185k33Hv2SvrqIPfnar2m
	zhFcmVgVs9XwjbGYtfnkMIKBd0dl5BI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719270534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXMtkGnjjCSX8B4PrtTIPLrttdZuNQiBGbDlDvZtG4M=;
	b=n01LpZ7ZpJGOTqxkBbVcjLtZMnU5YxpE7igQWp1J+1s+fyz0+UlKx5YdyG61asKdoeG0hZ
	uLbgaAS+f32KOPBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GAO7wQu8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n01LpZ7Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719270534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXMtkGnjjCSX8B4PrtTIPLrttdZuNQiBGbDlDvZtG4M=;
	b=GAO7wQu8A1mZVCdltO7/sY4APt6oNV9h6g5vYky68GFKXp554eD6vkSk0AKrgU1zzXsC2W
	PFVIteHSjzBlj76IjBFrVZ1jxpfqSH2WYSzCgZ75JHmEy5lSV185k33Hv2SvrqIPfnar2m
	zhFcmVgVs9XwjbGYtfnkMIKBd0dl5BI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719270534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXMtkGnjjCSX8B4PrtTIPLrttdZuNQiBGbDlDvZtG4M=;
	b=n01LpZ7ZpJGOTqxkBbVcjLtZMnU5YxpE7igQWp1J+1s+fyz0+UlKx5YdyG61asKdoeG0hZ
	uLbgaAS+f32KOPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D56BE1384C;
	Mon, 24 Jun 2024 23:08:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s4hvHoP8eWZuGwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Jun 2024 23:08:51 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/2] nfsd: initialise nfsd_info.mutex early.
Date: Tue, 25 Jun 2024 09:04:56 +1000
Message-ID: <20240624230734.17084-2-neilb@suse.de>
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
X-Rspamd-Queue-Id: 7846221A15
X-Spam-Score: -5.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

nfsd_info.mutex can be dereferenced by dsvc_pool_stats_state()
immediately after the the new netns is created.  Currently this can
trigger an oops.

Move the initialisation earlier before it can possibly be dereferenced.

Fixes: 7b207ccd9833 ("svc: don't hold reference for poolstats, only mutex.")
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Closes: https://lore.kernel.org/all/c2e9f6de-1ec4-4d3a-b18d-d5a6ec0814a0@linux.ibm.com/
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsctl.c | 2 ++
 fs/nfsd/nfssvc.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 533b65057e18..c848ebe5d08f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2169,6 +2169,8 @@ static __net_init int nfsd_net_init(struct net *net)
 	nn->nfsd_svcstats.program = &nfsd_program;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
+	nn->nfsd_info.mutex = &nfsd_mutex;
+	nn->nfsd_serv = NULL;
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index cd9a6a1a9fc8..89d7918de7b1 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -672,7 +672,6 @@ int nfsd_create_serv(struct net *net)
 		return error;
 	}
 	spin_lock(&nfsd_notifier_lock);
-	nn->nfsd_info.mutex = &nfsd_mutex;
 	nn->nfsd_serv = serv;
 	spin_unlock(&nfsd_notifier_lock);
 
-- 
2.44.0


