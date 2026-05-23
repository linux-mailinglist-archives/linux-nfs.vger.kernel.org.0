Return-Path: <linux-nfs+bounces-21888-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFQeOX7rEWqzrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21888-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 20:01:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A81A5C0450
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 20:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1077930698AB
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A515036BCCC;
	Sat, 23 May 2026 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPMImHOH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAAC304972;
	Sat, 23 May 2026 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558978; cv=none; b=CTedX1hOW9QMD0LscWcvwBIIFTItobfRXOfcNMnGtHBUtMIf4o7mkV4w6PRh3KOQySATrGIALNYRqfJP/RkjwBhoHz1rAB/6+0fWgowJ3tbUE8sY3Ns1Ay0m/zPUJaJSbC4MeONRCxPDlmH001cxI7tUdX46KAv2mBmrH9k4tgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558978; c=relaxed/simple;
	bh=9jocJk3xNegPSqjFg768bKmBGXxSKUoFZQXOKLQq6xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3i9vY+iJH3tKwTMt6A1rxVg/rQAdP0v29ah2Zy2jtzx3Ix5KvjJknvZfIDP+h/OpWPeTDcuV2OD7yEYG42lbF+8Msd8B1gKPe5CisAa1xFIeZcOfRKNeMTyIv58wgpoUPn41X93IVTfspZzAjZaEm9bByf3eEWeGZ4ZIaGwfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPMImHOH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369561F00A3A;
	Sat, 23 May 2026 17:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558977;
	bh=Lb9R1+4tK0UkG7ujaRwCAX/p5J9rcF0zL4gQIBfdRGo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IPMImHOHZX9R3AYIw3MrZ7UCgx62XFn7hoyyedz0iFQPJGvDjWaHpwmxJB5koBaxa
	 /Zc5t8a2CPG487TQZEccpAsZr3Cf1rO92HRpgstttNSWqixLgLGXd0DvsUS9tZtlla
	 d329bJbl/Atss8Vx+9BzQKI0uNEQtubea4TOBfBsFNekgNqOkGDqHmCQSubaFIZfAT
	 TauGSVKvJQhiO+GYyWyay/Wiwy869ulfv9WbRoBbyef941Hh/lralRMIiBOuObnSZQ
	 Z4Cg5jGvVivL+u0EWcq3emC3mmNYhjnSI624SUa8QgsCk9k0C1+RlnpQa3FfKJZTlc
	 xbJ0tHiFeZ+0g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 23 May 2026 20:54:25 +0300
Subject: [PATCH 13/17] fs/select: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-b4-fs-v1-13-275e36a83f0e@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21888-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A81A5C0450
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

poll_get_entry() allocates new memory for poll_table entries using
__get_free_page().

kmalloc() is a better API for such use and it also provides better
scalability and more debugging possibilities.

Replace use of __get_free_page() with kmalloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 75978b18f48f..6fa63e48cdee 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -150,7 +150,7 @@ void poll_freewait(struct poll_wqueues *pwq)
 		} while (entry > p->entries);
 		old = p;
 		p = p->next;
-		free_page((unsigned long) old);
+		kfree(old);
 	}
 }
 EXPORT_SYMBOL(poll_freewait);
@@ -165,7 +165,7 @@ static struct poll_table_entry *poll_get_entry(struct poll_wqueues *p)
 	if (!table || POLL_TABLE_FULL(table)) {
 		struct poll_table_page *new_table;
 
-		new_table = (struct poll_table_page *) __get_free_page(GFP_KERNEL);
+		new_table = kmalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!new_table) {
 			p->error = -ENOMEM;
 			return NULL;

-- 
2.53.0


