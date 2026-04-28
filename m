Return-Path: <linux-nfs+bounces-21243-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIDBGjJw8Gn9TQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21243-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 10:30:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D794801E8
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 10:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26ACC3076D4C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5054374728;
	Tue, 28 Apr 2026 08:25:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E93921ED
	for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364700; cv=none; b=C+JzM1LvdLjppsP2S+tQzy5+wFAuytnB7LlyzIJmTQK53saDphyFUQUDQqHoULJtz+5Psf0rHtj6tV9CVzl/gpx9oB9a0LU9xF9AFYI9ha6AJoA5gXlGwhMZvqurBZTErUuqNsN3vIv+YuNJrlzKwWTl3ZxGk1wqT+dkfhymhVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364700; c=relaxed/simple;
	bh=CQ3GaHA7NL7ewDN3CSbNEb9w0aVmEQz7PCK/5xpVBPs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HGrMWj3zSgzw6krxidvblJISl7sGc7lIzS4ukZe+72b5XdN6LdfD14+ExW4Kq7WfP8Irqou2ygj4hYtF20Smmz7T4U/lTnTWgUVOGWnZOQR+Tu16QdQhvfoKpvnyRovj3uC+tMTQFZvtf2cLU8UXQNLBDqMGnYOMfFkFWTLgFD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488d2079582so131211405e9.2
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2026 01:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364697; x=1777969497;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/SOIwk6JFY4kiwKYICkEYlTGSV7bIkJwlX50Zyd5eU=;
        b=C53dEVkraofd38DBC76woj5Sa5SB19dY8zA9FvwgnqzATST2XUGUznjOdYym+GFBmd
         ggmcKnw0sdXJvZuiR3GgJQmH/Ib+AucxICtDZmsRddjLwjDLeQQP35wDjCMPOqLk9GdZ
         w82DPSY+ADo9wyBivdxCuqnp1fuDX3FrJUfDUpdR5dDvplzFHsDaZX+ns2eWazfr2fh/
         CntaxgVrUf8B3B1MCTWCBm7jDIBc7afPEzN04L4mql4+9a2NqjY2OBeW0Sh5qUeO8iXz
         emWqf4mdZc4xqkVzTLzyqu0ALw34LuFW8M3pcToZpdOK+CGe+7PgQHt4h1sM+ue6JFZI
         vbnw==
X-Gm-Message-State: AOJu0Yw/jhrILcPNohRv+lXiqKkGBBlMwwDPbdyE053DvzsZAbmjRkMF
	UEI8SwvvmczlVJJ/FNPIVnp0/FMqE+CE8NI3eE381jppg3nQzsr+rfY7WofhqA==
X-Gm-Gg: AeBDiev6p2PAOMvdH/uGO9E8AzObf2YUkg4VPykGeHkWKqEUI3zZ7zHaT2ikbBcRam1
	G5Q3nE8s73DK3os1C6btZucOyqG6Y770FnJtCpVgXpWcCo9tdmtle86A0CmEtWvXxZkvdEzrGqs
	hg2ahLfOcOoSLYv70+WsmFwBnTYO+kT7sgP355rTeyvFVIb2lKEBpXyDgNjmUUsk2rqBQ6eluXW
	CeFqEQD+m0eMBKDOr0pqA5ppqfm8cJU1DvaUR60UvUE34G74Dgfa6usIdF4WRucUm3bXgIG9GI3
	i3f0U2qI1Q5uzIihh/pfrnUYYOJFlsCMwjXbDdWmKXhYv6ir1n+cxbCmfB1ZAp99ig4fACJiBv+
	pmAwF+k7FBNCE0as2wBYB49yI1Yp1MD+mT23b7ig66ip0DQksmmRANpeXLy3VH69lbMWUIeRiEA
	NOg0MTWOnLDc+PT8koFs/q0i88/XGI65PfOhGWEU3DhIzXSZmNanKXLyTj2zXT8ftP0XpOPBgxl
	mJSutKhYgk1Wrn8aNLHNl5i
X-Received: by 2002:a05:600c:3b1b:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-48a77afdb10mr32046075e9.11.1777364696692;
        Tue, 28 Apr 2026 01:24:56 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775eb91dsm13394375e9.20.2026.04.28.01.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:24:56 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nfs@vger.kernel.org,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH rfc] NFSv4: Keep delegation post REMOVE in case server supports preserved-unliked
Date: Tue, 28 Apr 2026 11:24:54 +0300
Message-ID: <20260428082454.26045-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D9D794801E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21243-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[grimberg.me];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sagi@grimberg.me];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.949];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,grimberg.me:replyto,grimberg.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

If the server returns NFS4_OPEN_RESULT_PRESERVE_UNLINKED, it means that
the file handle is kept alive for as long as the file is opened (or its
delegation is held). Hence, we can skip re-opening the file and returning
the delegation in this case.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fs/nfs/nfs4proc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 91bcf67bd743..129424eacf99 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4921,10 +4921,17 @@ static int nfs4_proc_remove(struct inode *dir, struct dentry *dentry)
 	int err;
 
 	if (inode) {
-		if (inode->i_nlink == 1)
-			nfs4_inode_return_delegation(inode);
-		else
+		/*
+		 * nlink > 1 or server supports NFS_INO_PRESERVE_UNLINKED
+		 * the inode is not going away. we're promised to keep the
+		 * inode alive past REMOVE for as long as any client reference
+		 * remains. So we can keep the delegation around.
+		 */
+		if (inode->i_nlink > 1 ||
+		    test_bit(NFS_INO_PRESERVE_UNLINKED, &NFS_I(inode)->flags))
 			nfs4_inode_make_writeable(inode);
+		else
+			nfs4_inode_return_delegation(inode);
 	}
 	do {
 		err = _nfs4_proc_remove(dir, &dentry->d_name, NF4REG);
-- 
2.43.0


