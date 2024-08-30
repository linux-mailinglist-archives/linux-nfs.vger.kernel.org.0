Return-Path: <linux-nfs+bounces-6042-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E302965813
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 09:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D511C2279C
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 07:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CADE15689B;
	Fri, 30 Aug 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KsGcEFhW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="txOczBw7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KsGcEFhW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="txOczBw7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DC915442F
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001641; cv=none; b=YJGw2oHcyHGefLXqwpblswO2PO5hI1LfruKUARIeDGPDYX2WM2glbz3wI5F/ncKfHp4PQrdUVSOBwDD7bnd1LuQDNheGyi1psAOCMHf87uvK4gdBXfZTGmu0DTTnDz69NzKif6UhEGjz9L4JKnl0WDJx7JPSyL0kUR4qes4N4P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001641; c=relaxed/simple;
	bh=exfot3F62PKOwBoQ9/teqmxe83yyE2XpNqy02Lcm3yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jX46n5N0wokytk02NXWbebuQWPhhOCQxX/uzbzLf6ZSeQFkre8Qu4Ex1t6U4w/1pifF5pM0dSbJbZQ1Y/ygaLYn6b20uzGf+zW1iFetOQ09pNh1U49ifrX2F1U7riyn169Q3kkttHDC+jE/sqPs9cFWxcnj6cF9MAGpL6DKASfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KsGcEFhW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=txOczBw7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KsGcEFhW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=txOczBw7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B54171F7A6;
	Fri, 30 Aug 2024 07:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725001637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRs3bOKCCLfqMCIpV5OncLVAksUc75DeLbCf3ohIa5A=;
	b=KsGcEFhWCUqRe6U7aLrxC98/Bu06lmrFu+jpukqC2LI9WTiedW1Cy6ndBl+LOW23XT2Utu
	oDWLIwQBowQpAxEMcycb9/XJYH0Djy8jhWEFsSzPOrwl82eNYlizcL9BphNyRLRN8oWP1S
	ybcns6jn050dmSZt2AWFj8PZNzi5+co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725001637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRs3bOKCCLfqMCIpV5OncLVAksUc75DeLbCf3ohIa5A=;
	b=txOczBw7rcNsnfDBg4OwRsDwVjfydYowDbPv4zFhLnQbpL4tAK7CqL28+X1utfCsEZegOx
	w8pR9fW++FkRlKCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725001637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRs3bOKCCLfqMCIpV5OncLVAksUc75DeLbCf3ohIa5A=;
	b=KsGcEFhWCUqRe6U7aLrxC98/Bu06lmrFu+jpukqC2LI9WTiedW1Cy6ndBl+LOW23XT2Utu
	oDWLIwQBowQpAxEMcycb9/XJYH0Djy8jhWEFsSzPOrwl82eNYlizcL9BphNyRLRN8oWP1S
	ybcns6jn050dmSZt2AWFj8PZNzi5+co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725001637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRs3bOKCCLfqMCIpV5OncLVAksUc75DeLbCf3ohIa5A=;
	b=txOczBw7rcNsnfDBg4OwRsDwVjfydYowDbPv4zFhLnQbpL4tAK7CqL28+X1utfCsEZegOx
	w8pR9fW++FkRlKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 712DB13A44;
	Fri, 30 Aug 2024 07:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r0oICqRv0WZ/XAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 07:07:16 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd: use clear_and_wake_up_bit()
Date: Fri, 30 Aug 2024 17:03:16 +1000
Message-ID: <20240830070653.7326-2-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240830070653.7326-1-neilb@suse.de>
References: <20240830070653.7326-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
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
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

nfsd has two places that open-code clear_and_wake_up_bit().  One has the
required memory barriers.  The other does not.

Change both to use clear_and_wake_up_bit() so with have the barriers
without the noise.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4recover.c | 5 +----
 fs/nfsd/nfs4state.c   | 3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 67d8673a9391..b10cfb217fa2 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1895,10 +1895,7 @@ nfsd4_cltrack_upcall_lock(struct nfs4_client *clp)
 static void
 nfsd4_cltrack_upcall_unlock(struct nfs4_client *clp)
 {
-	smp_mb__before_atomic();
-	clear_bit(NFSD4_CLIENT_UPCALL_LOCK, &clp->cl_flags);
-	smp_mb__after_atomic();
-	wake_up_bit(&clp->cl_flags, NFSD4_CLIENT_UPCALL_LOCK);
+	clear_and_wake_up_bit(&clp->cl_flags, NFSD4_CLIENT_UPCALL_LOCK);
 }
 
 static void
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b67f151837c1..3f85575ee0db 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3076,8 +3076,7 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
 			container_of(ncf, struct nfs4_delegation, dl_cb_fattr);
 
 	nfs4_put_stid(&dp->dl_stid);
-	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
-	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
+	clear_and_wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
 }
 
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
-- 
2.44.0


