Return-Path: <linux-nfs+bounces-21891-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKuHBBbsEWqzrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21891-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 20:04:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D855C048C
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 20:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C92593083944
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9D936BCCC;
	Sat, 23 May 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBZAZdcE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8036A374;
	Sat, 23 May 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779559000; cv=none; b=dlyBXmzE6JBsbDGhViCynL8EJkWag+l2e09U/7Jzh92uBIujq0OiafK7zNNiY6bBRLOu7+7Zwx7ILuiMKsajjOnOb+avcF8IcsjrWQROfaFopdQ4kMcLy/J+lRWbQDudcY4c39lqVJjsq/Rr/U+Skpd/DkJcRWtO0sGHh2aeRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779559000; c=relaxed/simple;
	bh=XU20uLrOwUf9z96AonyK2eJYbZ7IIPLDPk49CorEEY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MBarusJs5RL80YZEdZp3IqX0NDtqffPA/WSXGJHdrcEiRHMh12MgyGdntESAzOW51pujwoyQD+okXk8HaWJCAm6fHDILJfzGD4RPpYkjMib6je92ZAMEU6P4aRGzsftS8E49ZHOZYC9xb6Qsw4TisK1sBsMoGZmsmbpnotwZsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBZAZdcE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30DC1F000E9;
	Sat, 23 May 2026 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558999;
	bh=ukrRzZydclNePROfQDTuyRdGagizkwrv8BiO6E2x4AA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BBZAZdcEVz/p/msk+v6WT2AsRtCoFYBx3Z0qlKQpUVbqTTbkufOrda1SFIO7l1SpK
	 0+apuNi1AgkI0nv8JogTKz8wOv4b5mpvv9u/xDPzwAED3kA3JFSABvqXVcMQHbe+lH
	 VfZAKI61R0AS0GYB6HHcfVezMPaXJquvTDImNyT6NiTXW+RaW6vpy7tY0D+UKyAawh
	 jCVkOl/9QaWWRWLTIeXzvccQTZ8YykJTCul62f93TjwBE+wLiNuNiL1GEnrH4p3nuK
	 9ErpfHG5KC/WNMAH6vNpsC3L+3apRTMtE61nyfp/IroAR1bZ/zd+pANUHOaQfbyAvV
	 D/d7xN/FwOJkQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 23 May 2026 20:54:28 +0300
Subject: [PATCH 16/17] binfmt_misc: replace __get_free_page() with
 kmalloc()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-b4-fs-v1-16-275e36a83f0e@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21891-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 76D855C048C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bm_entry_read() allocates temporary buffer using __get_free_page().

kmalloc() is a better API for such use and it also provides better
scalability and more debugging possibilities.

Replace use of __get_free_page() with kmalloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/binfmt_misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index b3d8fd70e8b1..84349fcb93f1 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -704,7 +704,7 @@ bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	ssize_t res;
 	char *page;
 
-	page = (char *) __get_free_page(GFP_KERNEL);
+	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 
@@ -712,7 +712,7 @@ bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 
 	res = simple_read_from_buffer(buf, nbytes, ppos, page, strlen(page));
 
-	free_page((unsigned long) page);
+	kfree(page);
 	return res;
 }
 

-- 
2.53.0


