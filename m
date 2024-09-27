Return-Path: <linux-nfs+bounces-6670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4B7987EA7
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 08:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F3C3B23DD7
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Sep 2024 06:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA115E5C8;
	Fri, 27 Sep 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J1nFSF6u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CznP8pxa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J1nFSF6u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CznP8pxa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501515D5C1
	for <linux-nfs@vger.kernel.org>; Fri, 27 Sep 2024 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419754; cv=none; b=HIMxPx/KhFmkI23gRTDIWjxlSouZVruCk5cLmTPfKA9yNQR2Cr60Y7XKzHoCwiow+9q8p3DJhx7D9+LlvQNHpUHTTWllicqwpY+WDvjMNtMMXfatbGufnPK0f05LeFuKPu0h8NPtN0wgVkkEQtaUh5+tqjmqS5hGfjWgUh2QLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419754; c=relaxed/simple;
	bh=VYft8UjDBcmKK5qxVZt2dOwEYV/5CWlseKPL2Cl/zDM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=iHHv3LHzkU7qdi+QWzK9oJqrpfwAIibt4cfCPbaQCJvJr4qJPdpGhycF2d6PkXKFmfKf2Q+rZ2CVm3W7bJKh8jsAyoTp0rjNxulxIYJ6xShj0MlQKKrCmmePSKM+cpB2ezAhQEf/b913Dt3wXjMW6p7de7EuDgHBcJf/40EkPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J1nFSF6u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CznP8pxa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J1nFSF6u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CznP8pxa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2705D219AE;
	Fri, 27 Sep 2024 06:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727419750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=plfEbB+2T87iSmqqclqUg3X9yjRrfddD2jPJwVitxrE=;
	b=J1nFSF6uwLF/4Y4LJUltSd5ytgcfP0q9lb4aCUGSW9h9y0vr8Wc11o+kEipLvQqhz5NWEx
	fdTFUBevYwvixJaaBIlCdct6QAzh0j3L6g1RIS3jDcigyDKtYZFhjnfCll5mjAYE0NZSOu
	K+RrcGyRtsW7/Uepkfj4f9fb/zvGGs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727419750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=plfEbB+2T87iSmqqclqUg3X9yjRrfddD2jPJwVitxrE=;
	b=CznP8pxamcl9UYGyOIwv/mkA4WH9wvzYBPnRuMFyy+uSlUvYuOLWeiVH0QKLt+0U57U2Qi
	LDEY4RC+G9sJ4ACg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J1nFSF6u;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CznP8pxa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727419750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=plfEbB+2T87iSmqqclqUg3X9yjRrfddD2jPJwVitxrE=;
	b=J1nFSF6uwLF/4Y4LJUltSd5ytgcfP0q9lb4aCUGSW9h9y0vr8Wc11o+kEipLvQqhz5NWEx
	fdTFUBevYwvixJaaBIlCdct6QAzh0j3L6g1RIS3jDcigyDKtYZFhjnfCll5mjAYE0NZSOu
	K+RrcGyRtsW7/Uepkfj4f9fb/zvGGs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727419750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=plfEbB+2T87iSmqqclqUg3X9yjRrfddD2jPJwVitxrE=;
	b=CznP8pxamcl9UYGyOIwv/mkA4WH9wvzYBPnRuMFyy+uSlUvYuOLWeiVH0QKLt+0U57U2Qi
	LDEY4RC+G9sJ4ACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BFC31386E;
	Fri, 27 Sep 2024 06:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LhwEFGRV9mYAFgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 27 Sep 2024 06:49:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc: fix prog selection loop in svc_process_common
Date: Fri, 27 Sep 2024 16:49:01 +1000
Message-id: <172741974136.470955.11402099885897272884@noble.neil.brown.name>
X-Rspamd-Queue-Id: 2705D219AE
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:dkim,suse.de:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO


If the rq_prog is not in the list of programs, then we use the last
program in the list and we don't get the expected rpc_prog_unavail error
as the subsequent tests on 'progp' being NULL are ineffective.

We should only assign progp when we find the right program, and we
should initialize it to NULL

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 86ab08beb3f0 ("SUNRPC: replace program list with program array")
Signed-off-by: NeilBrown <neilb@suse.de>
---

Hi Anna,
 could you take this please - a fix to a patch in your latest pull
 request to Linus.
Thanks,
NeilBrown


 net/sunrpc/svc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 7e7f4e0390c7..79879b7d39cb 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1321,7 +1321,7 @@ static int
 svc_process_common(struct svc_rqst *rqstp)
 {
 	struct xdr_stream	*xdr = &rqstp->rq_res_stream;
-	struct svc_program	*progp;
+	struct svc_program	*progp = NULL;
 	const struct svc_procedure *procp = NULL;
 	struct svc_serv		*serv = rqstp->rq_server;
 	struct svc_process_info process;
@@ -1351,12 +1351,9 @@ svc_process_common(struct svc_rqst *rqstp)
 	rqstp->rq_vers = be32_to_cpup(p++);
 	rqstp->rq_proc = be32_to_cpup(p);
 
-	for (pr = 0; pr < serv->sv_nprogs; pr++) {
-		progp = &serv->sv_programs[pr];
-
-		if (rqstp->rq_prog == progp->pg_prog)
-			break;
-	}
+	for (pr = 0; pr < serv->sv_nprogs; pr++)
+		if (rqstp->rq_prog == serv->sv_programs[pr].pg_prog)
+			progp = &serv->sv_programs[pr];
 
 	/*
 	 * Decode auth data, and add verifier to reply buffer.
-- 
2.46.0


