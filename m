Return-Path: <linux-nfs+bounces-10360-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26012A45584
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 07:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267AA17438A
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 06:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D9D266EF3;
	Wed, 26 Feb 2025 06:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nqt1c/D5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GQntugfE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yeFGslk+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z5DkLJqv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADEF29D0E
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550932; cv=none; b=jlv5tr/rBRCQamT6/Muwhy/iZZJD7fTX761WLRczAYVvybqW9xRw3PiZWnkUb6phr/4fPLKl9aJRoUI8bbZGFTng9t0AK3yzxe5PZUO8nV/+Cf+3Eu/eMm3YK3gfc+EBe/KhgHm3we7WDDJbxh7hOkzhUbSiGmaXhRxI9X9S164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550932; c=relaxed/simple;
	bh=1o8BraiCPl1O92Gqsdl/9Ayyur17Nyjg7TSPlN6bO5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBK0j2siFmf+DbNsgBCJSild/Y2b7r2pm+jqCJLNvQfa458KA+BzroEGAYYUStZFvphBJgzsBVUOszj4x0I0gmllLMs8bu7Rvv4vKJdqRe/emjFGKyo/3pnw8GBSgkekzrY/a6VjOr74MXwtogGCamXr01qGSv0MHQHZ/Oq/01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nqt1c/D5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GQntugfE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yeFGslk+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z5DkLJqv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F24041F45E;
	Wed, 26 Feb 2025 06:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740550928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKYPaxwdjWkolQA4ZchTM2TVABl/DDSdkZNctQZLvJY=;
	b=nqt1c/D5LhvUHhH15ZAriad/7UYbSr1Y/Sso2HHC3E+I+OHR/Hx86+OrqXUAHLX7Vqd1pn
	ug2jmBlvYLY1zDzExnBs2hySSbB6gLl4Wq++VPZwgmvBpJeTNK3sK26zRRVcNb9Aj1IiVB
	8MGAqlVxD3l9JnWnJJVlROf51ts2X98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740550928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKYPaxwdjWkolQA4ZchTM2TVABl/DDSdkZNctQZLvJY=;
	b=GQntugfEiZKKvcx7C126O/Xv0gxXxUf8fucUh9Ri7B9MhuORmVv82iOFxM7F5OvTndsFd+
	ulE1bBV/2xLpe9AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740550927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKYPaxwdjWkolQA4ZchTM2TVABl/DDSdkZNctQZLvJY=;
	b=yeFGslk+M6AV5AZ2HZxrML4rDGf7XLttX7ajR6g7TsH49AQESP03BA8DTdxPwoGAqzvblK
	+08gKJZGLXFQnrasPRJUJDdyZj7h0Fjn8f82UCFpzWBtdlmBl5UmgqdF0+4eHdmsyVFoou
	ekrJN2J/tFgh9B748wM3J/vlZuDUbco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740550927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKYPaxwdjWkolQA4ZchTM2TVABl/DDSdkZNctQZLvJY=;
	b=Z5DkLJqvOBrpYNkv+dkXNPIBn8BLyXosJCq7IUk+eXcKjf3teF9+sCq4k5Mt5+Md0VmRtd
	ehu/yF7khhIOcgCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B9791377F;
	Wed, 26 Feb 2025 06:22:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xEPUNgyzvmc1IAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 26 Feb 2025 06:22:04 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: drop fh_update() from S_IFDIR branch of nfsd_create_locked()
Date: Wed, 26 Feb 2025 17:18:32 +1100
Message-ID: <20250226062135.2043651-3-neilb@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226062135.2043651-1-neilb@suse.de>
References: <20250226062135.2043651-1-neilb@suse.de>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

nfsd_create_locked() doesn't need to explicitly call fh_update().
On success (which is the only time that fh_update() matters at all),
nfsd_create_setattr() will be called and it will call fh_update().

This extra call is not harmful, but is not necessary.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/vfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29cb7b812d71..1035010f1198 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1505,11 +1505,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			}
 			dput(resfhp->fh_dentry);
 			resfhp->fh_dentry = dget(d);
-			err = fh_update(resfhp);
 			dput(dchild);
 			dchild = d;
-			if (err)
-				goto out;
 		}
 		break;
 	case S_IFCHR:
-- 
2.48.1


