Return-Path: <linux-nfs+bounces-8373-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB729E6404
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6E22846C3
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE416145B0C;
	Fri,  6 Dec 2024 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hqiugIFv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kptQAseT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hqiugIFv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kptQAseT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128EF1552F5
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451602; cv=none; b=qhp35pXuctG/9lQWxJuUvS2jlmvuzrT8nPW6TExXIkTdZFwAcfQ4lFLKRhDT35KGK9MNMVVM7lcitWMVZp+r8Y76hZIVHXgnyxAFD+d8qEKYpQHyAaVLBeY13Z2eo1uyMoc54iKX7w241LlZMhFqfQ+80dD86LEBY0kk8USZ3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451602; c=relaxed/simple;
	bh=OEIix47lsgUsH65VfPAQ/F35ZGfY9LfZNRUHhKTlLgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwVEwKopzaUAb2eHQl0UVcysdJoD4mHBYCg0pIpiwwv6OdLLElI65R7PkY9J/5umfKbpdxOmAhNGyeTAxPmiLU6aY7Xfq6q50GevNTDwI61bcWhcxojjlLUHen4YvLM4kF5CBW9uF/zDrG/DvujgZe4cHO/PJooB2jTdy2KXrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hqiugIFv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kptQAseT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hqiugIFv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kptQAseT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8734D21167;
	Fri,  6 Dec 2024 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQYsArZVCxQ9KLyhSii2t67THJLbro2ryY8Mm5r1D24=;
	b=hqiugIFvMYH9YEIDtnlLPjpRwdKj8t8j3cmdS/xARVIlcFGffKLANAqVaSoNRHsFOYBOi6
	Q5Ix8t+wjicqqD9MbY89vfkYCOaHYbGGkWacaluc4l46UWHhuPYcGouKDIxHiAnQlYP25p
	UD8ZjRfVoOT/OS5s7SIaBiR37+W5szQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQYsArZVCxQ9KLyhSii2t67THJLbro2ryY8Mm5r1D24=;
	b=kptQAseT7seWPLyDXdGzt3K8038k8bXeokoqHlTzEJ+V5MbMsNnwkPbKiXxkeer/0WSWpn
	brU8Tl6rt8yTikBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQYsArZVCxQ9KLyhSii2t67THJLbro2ryY8Mm5r1D24=;
	b=hqiugIFvMYH9YEIDtnlLPjpRwdKj8t8j3cmdS/xARVIlcFGffKLANAqVaSoNRHsFOYBOi6
	Q5Ix8t+wjicqqD9MbY89vfkYCOaHYbGGkWacaluc4l46UWHhuPYcGouKDIxHiAnQlYP25p
	UD8ZjRfVoOT/OS5s7SIaBiR37+W5szQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQYsArZVCxQ9KLyhSii2t67THJLbro2ryY8Mm5r1D24=;
	b=kptQAseT7seWPLyDXdGzt3K8038k8bXeokoqHlTzEJ+V5MbMsNnwkPbKiXxkeer/0WSWpn
	brU8Tl6rt8yTikBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45BFF13A15;
	Fri,  6 Dec 2024 02:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YYLJOk1fUmdpJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:19:57 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 10/11] nfs: use atomic_dec_and_wake_up()
Date: Fri,  6 Dec 2024 13:15:36 +1100
Message-ID: <20241206021830.3526922-11-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206021830.3526922-1-neilb@suse.de>
References: <20241206021830.3526922-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

In two places nfs uses wake_up_var() after atomic_dec_and_test() on the
same var.  This is correct as no extra barriers are needed in this case.
This can be made more clear by using the atomic_dec_and_wake_up()
interface.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/pagelist.c | 3 +--
 fs/nfs/write.c    | 6 +-----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 7f3914064cee..a1b4c77cbc68 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -557,8 +557,7 @@ static void nfs_clear_request(struct nfs_page *req)
 		req->wb_page = NULL;
 	}
 	if (l_ctx != NULL) {
-		if (atomic_dec_and_test(&l_ctx->io_count)) {
-			wake_up_var(&l_ctx->io_count);
+		if (atomic_dec_and_wake_up(&l_ctx->io_count)) {
 			ctx = l_ctx->open_context;
 			if (test_bit(NFS_CONTEXT_UNLOCK, &ctx->flags))
 				rpc_wake_up(&NFS_SERVER(d_inode(ctx->dentry))->uoc_rpcwaitq);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 50fa539611f5..3b709cfff0da 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1658,11 +1658,7 @@ void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
 
 bool nfs_commit_end(struct nfs_mds_commit_info *cinfo)
 {
-	if (atomic_dec_and_test(&cinfo->rpcs_out)) {
-		wake_up_var(&cinfo->rpcs_out);
-		return true;
-	}
-	return false;
+	return atomic_dec_and_wake_up(&cinfo->rpcs_out);
 }
 
 void nfs_commitdata_release(struct nfs_commit_data *data)
-- 
2.47.0


