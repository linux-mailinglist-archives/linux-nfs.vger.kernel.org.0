Return-Path: <linux-nfs+bounces-1611-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FFD8431B4
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 01:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC961C22347
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 00:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810F7364;
	Wed, 31 Jan 2024 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YqgoiyEI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FrTqrpwN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MRzAjnQZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wNPGsNZn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C82360
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706660269; cv=none; b=e2Is0KOKObJe7zk2tJQGhsAnEk36/7mSaAM+n61CUJIG42CMHjzKrqwQQNPK8p/Z9Iiojs8lPGN/8PLR6dchloUelKjrkefWinjUWVxWkbTSmVkH7fB+/waZYETx700sd0pdODLtUHfd3ZCIzJgnoiXZc+5ZcvkErBaYh18J1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706660269; c=relaxed/simple;
	bh=mwsZvwAhTyp6ww17AaYAgxxNkDhf8el9AIMoV+knaKc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=QWzt6RbMgFJ4aeXphpjW/5F/qyaeLiexqwDpeIQJI84zM8kNHSx3xhn9d/llh99VmkNuqtaHdHQbiv0AkSsS3NKQbIWAnUquvWKP383tIanbPwLA38JE0bHA9fCol+ZSrxxDJyyMAjDugXN1ta5/AYaBYpKqiZwATWGkJTkt9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YqgoiyEI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FrTqrpwN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MRzAjnQZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wNPGsNZn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9EA621FE9;
	Wed, 31 Jan 2024 00:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706660266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/URase/yMjkQrlm99YxjIBb/auRLj2bEOX7vrmedeF8=;
	b=YqgoiyEIOUW9j0I4AIz5yusmjcD44bEqURohoBN4JcDwTLRzMTXSaanCC5qcpYaUEY61Fs
	XpY1jl8sbojY2It5T5vJsdIjwROhBklULlpwcXQfRHdC2R5gcdH+/QiKj1VNb/jBUqAhze
	Lr6WJ83IesTjLDUdhoBYpgtSDTvEP6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706660266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/URase/yMjkQrlm99YxjIBb/auRLj2bEOX7vrmedeF8=;
	b=FrTqrpwNhpNOrkDzsqD3ZwlDxDcy00z8Gpsqnby7SKlSn8+GrLzlPjSaYJMg2j/+KzdqmI
	FfYkcyi6ldktqTBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706660265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/URase/yMjkQrlm99YxjIBb/auRLj2bEOX7vrmedeF8=;
	b=MRzAjnQZiEWi4Qk/ZArfUJMDXQcveRqAEhsC1s2Ycxqd1mZDqevIW6fjJ3dYHBySEUhU4M
	/bhVuNFXpTZHbOa6DIM2gLOwHdbsIplEMs0c622azo4u+JwdSESxPG4dAwXQGX1i2rtVzM
	yhAFUh8JEFSp+yoUUsL2QTIlqFP5Kbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706660265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/URase/yMjkQrlm99YxjIBb/auRLj2bEOX7vrmedeF8=;
	b=wNPGsNZnAlXSlrjZjVHnLNcIde6BDTyC+p6j/d8DGUSmYY2hENCjfBy/HOMUdo68hb7uFr
	JG7kT2F3DunD5hAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58447139B1;
	Wed, 31 Jan 2024 00:17:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MV8CBKeRuWUqagAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 31 Jan 2024 00:17:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Vasily Averin <vasily.averin@linux.dev>
Subject: [PATCH] nfsd: don't call locks_release_private() twice concurrently
Date: Wed, 31 Jan 2024 11:17:40 +1100
Message-id: <170666026049.21664.14325649754684255655@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MRzAjnQZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wNPGsNZn
X-Spamd-Result: default: False [-2.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[34.53%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A9EA621FE9
X-Spam-Level: 
X-Spam-Score: -2.31
X-Spam-Flag: NO


It is possible for free_blocked_lock() to be called twice concurrently,
once from nfsd4_lock() and once from nfsd4_release_lockowner() calling
remove_blocked_locks().  This is why a kref was added.

It is perfectly safe for locks_delete_block() and kref_put() to be
called in parallel as they use locking or atomicity respectively as
protection.  However locks_release_private() has no locking.  It is
safe for it to be called twice sequentially, but not concurrently.

This patch moves that call from free_blocked_lock() where it could race
with itself, to free_nbl() where it cannot.  This will slightly delay
the freeing of private info or release of the owner - but not by much.
It is arguably more natural for this freeing to happen in free_nbl()
where the structure itself is freed.

This bug was found by code inspection - it has not been seen in practice.

Fixes: 47446d74f170 ("nfsd4: add refcount for nfsd4_blocked_lock")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a66d66b9f769..12534e12dbb3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -318,6 +318,7 @@ free_nbl(struct kref *kref)
 	struct nfsd4_blocked_lock *nbl;
 
 	nbl = container_of(kref, struct nfsd4_blocked_lock, nbl_kref);
+	locks_release_private(&nbl->nbl_lock);
 	kfree(nbl);
 }
 
@@ -325,7 +326,6 @@ static void
 free_blocked_lock(struct nfsd4_blocked_lock *nbl)
 {
 	locks_delete_block(&nbl->nbl_lock);
-	locks_release_private(&nbl->nbl_lock);
 	kref_put(&nbl->nbl_kref, free_nbl);
 }
 
-- 
2.43.0


