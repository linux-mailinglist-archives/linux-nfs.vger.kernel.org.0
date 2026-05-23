Return-Path: <linux-nfs+bounces-21880-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCsOJwrqEWqbrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21880-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:55:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF545C020C
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAADA3004D1F
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85093191CA;
	Sat, 23 May 2026 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATnUMplv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960932BB1D;
	Sat, 23 May 2026 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558918; cv=none; b=D5Yk0u2ixDcwBAQvavekfbdCFPwVAeeEVKRCgVVR46Nc539eMWY1fMdLF6PTf/Kcg8468KVzP1DOTabDtC5Mi5kQcyYmVGOH/EcX8G8KNJK3cLBmOY0tp5bhZ3AmWU7nV2l6MoJW2sKL102bw/lQHNcxtZOHudWesX8ceMuEQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558918; c=relaxed/simple;
	bh=FrSccbbs0hyrfruPAQEdMfu5TavFD0FZc2PEdgCxv1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itaqZc5Hm+YH5oPgEUxe3N0PNYg910DPWHS39iuupv/xz5vK6qCLh/RTLykTH4uMY8KcyVsSn9yh8Ho+REhIiyN74J6+8aRvkXipOqfo7+iJgEGDG+8FdZaPkU8Ol/dyhp0gudiVCQTj5iZyXd4yXs3COl39fos/lOdcK7+ft5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATnUMplv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587A61F00A3A;
	Sat, 23 May 2026 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558917;
	bh=iuTtZ9uTCrL2gUy5rhFYUqVCvakrQG2oy3wSLfhPcVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ATnUMplvANtFqXnPMMG7NSH8t5x5kTr2rh2BxFK2/mVjIEx0Csre+Yxnx89gvCEvB
	 uHhDVFvMFOGe5KELFWAxCXbgCTVrBKUMFRuF0LRLv78XqrCqluzw3rTHXpk0yXii4K
	 fDJU8jmq2k/g/NjGNa5JSW+CPvvN53gcwu2ld51g061LrLeCS7I3OlrWU8/r17dOxF
	 bJ5qv7tKsbMQ1Om/1fVqqTAJpam8n6zNmdQ1U/w3peqvRTGFGpN7qetPQI+JDlr74U
	 +IrL/dYO28YRNMgTFDRp3h8h0WxOISk9xbTS2rZ8iV2rThE32PwWKlR2cNbCHn6/tO
	 lPASwzWfCy/xA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 23 May 2026 20:54:17 +0300
Subject: [PATCH 05/17] NFS: replace __get_free_page() with kmalloc() in
 nfs_show_devname()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-b4-fs-v1-5-275e36a83f0e@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21880-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7BF545C020C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfs_show_devname() allocates a tmemporary buffer __get_free_page().

kmalloc() is a better API for such use and it also provides better
scalability and more debugging possibilities.

Replace use of __get_free_page() with kmalloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/nfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 4cd420b14ce3..8f8a03a68d3d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -623,7 +623,7 @@ static void show_implementation_id(struct seq_file *m, struct nfs_server *nfss)
 
 int nfs_show_devname(struct seq_file *m, struct dentry *root)
 {
-	char *page = (char *) __get_free_page(GFP_KERNEL);
+	char *page = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	char *devname, *dummy;
 	int err = 0;
 	if (!page)
@@ -633,7 +633,7 @@ int nfs_show_devname(struct seq_file *m, struct dentry *root)
 		err = PTR_ERR(devname);
 	else
 		seq_escape(m, devname, " \t\n\\");
-	free_page((unsigned long)page);
+	kfree(page);
 	return err;
 }
 EXPORT_SYMBOL_GPL(nfs_show_devname);

-- 
2.53.0


