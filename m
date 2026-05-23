Return-Path: <linux-nfs+bounces-21877-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEBLC0fqEWqbrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21877-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:56:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A65C0283
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC8E2301C58C
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F9732573F;
	Sat, 23 May 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGH8ECXZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B52BB1D;
	Sat, 23 May 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558896; cv=none; b=HGocYCCnP1uwqDFzGq35kKVHixvqHrPmyflKgQpLPcH927sF7Vf69+bbIG8WDFC7idwpkgAZZJaeXCxYm2DIxFW5X5/CZcaCxpWCLm19jLW4UkKh/cgHv5hsXc1nnkbX4psx7HRcBH3Qyfr8Md1m0qghncxy2OIK+mZUNq/WhMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558896; c=relaxed/simple;
	bh=zjzC6WZgyCQNvgmUsQfpb6/kcemhlapPaIznXJ6qDpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYRWohvpnpnD3UW/Hb8/VQ6vrbjEbxT9SQGUULr3Nh2TqRp9oeTMUB05B173dageRqe5kTweqRBUbRb6fNCp/6Ekyi2/dnTCnPkLUCrliZ+1GNOqGndQa/52t3k8OGEBkvPaUXwYGg5hPozhg4T63ZU1xE6ZO0dyzhjh6mFspfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGH8ECXZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93D61F000E9;
	Sat, 23 May 2026 17:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558894;
	bh=7bBokGp6YKVtCQZrud5e4II/4wZ3rZBymvn2I3mXFbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bGH8ECXZQWVB8xYKDY/34dL7P/Mpormzto6UFwYqmQQ8V7u/iWPHMQTPBkPItAfkE
	 JYt1o4Cf3CN+cxfmAzr35RKANhG/cmjfmksUsM7WzHVSpgYMHN3Gf0ZuFv44EHsQkG
	 5c6hR6iM1fBLLGWl1087vym9DDLVALaOOffnORm0ZfnH5ybe1PyWRRQEeu90AKgoDB
	 Jw2dFEijdb+pzOPHlcGU7KJWjzyYOiV43iwFqaQc4PwA8Zbp5ATunapeAj83YgVs7z
	 H3BqQnMH2LDOG2MvAZHZvX6Ua6wiohmfMIA9nYPkFYfAuWtOIlr24mdMezTmn2Hvz9
	 pETrQg4iAiu/A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 23 May 2026 20:54:14 +0300
Subject: [PATCH 02/17] proc: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-b4-fs-v1-2-275e36a83f0e@kernel.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
In-Reply-To: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
To: Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Dave Kleikamp <shaggy@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Kees Cook <kees@kernel.org>, 
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-ext4@vger.kernel.org, linux-mm@kvack.org, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21877-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,szeredi.hu,debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 812A65C0283
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A few functions in fs/proc/base.c use __get_free_page() to allocate a
temporary buffer.

kmalloc() is a better API for such use and it also provides better
scalability and more debugging possibilities.

Replace use of __get_free_page() with kmalloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/proc/base.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..e129dc509b79 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -261,7 +261,7 @@ static ssize_t get_mm_proctitle(struct mm_struct *mm, char __user *buf,
 	if (pos >= PAGE_SIZE)
 		return 0;
 
-	page = (char *)__get_free_page(GFP_KERNEL);
+	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 
@@ -284,7 +284,7 @@ static ssize_t get_mm_proctitle(struct mm_struct *mm, char __user *buf,
 			ret = len;
 		}
 	}
-	free_page((unsigned long)page);
+	kfree(page);
 	return ret;
 }
 
@@ -347,7 +347,7 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
 	if (count > arg_end - pos)
 		count = arg_end - pos;
 
-	page = (char *)__get_free_page(GFP_KERNEL);
+	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 
@@ -371,7 +371,7 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
 		count -= got;
 	}
 
-	free_page((unsigned long)page);
+	kfree(page);
 	return len;
 }
 
@@ -908,7 +908,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mm)
 		return 0;
 
-	page = (char *)__get_free_page(GFP_KERNEL);
+	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 
@@ -949,7 +949,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 
 	mmput(mm);
 free:
-	free_page((unsigned long) page);
+	kfree(page);
 	return copied;
 }
 
@@ -1016,7 +1016,7 @@ static ssize_t environ_read(struct file *file, char __user *buf,
 	if (!mm || !mm->env_end)
 		return 0;
 
-	page = (char *)__get_free_page(GFP_KERNEL);
+	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 
@@ -1062,7 +1062,7 @@ static ssize_t environ_read(struct file *file, char __user *buf,
 	mmput(mm);
 
 free:
-	free_page((unsigned long) page);
+	kfree(page);
 	return ret;
 }
 

-- 
2.53.0


