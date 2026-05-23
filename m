Return-Path: <linux-nfs+bounces-21881-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIdXAyTqEWqbrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21881-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:55:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5AF5C0257
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD38E300BC70
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEB2348875;
	Sat, 23 May 2026 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSKIMgV4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2C3330662;
	Sat, 23 May 2026 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558926; cv=none; b=KDxI1eNSN50GySDPuTcX9Dcaa49P1W4hCV5ZNKESG60yiFYjBp/73Fe3F+DUJ/683zchH+XO4WWUu/txVKZf43fXl62doZxz59mXjNURzzKuAIJATamce7nVrS0hzlVJaHkjOJGFMonYlINbXRNp128oLkQvE7c7uMJkWj6T/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558926; c=relaxed/simple;
	bh=MMjGYQ83G7dlBEgngWbzjzg8jJEgk+XNn0ECKJj3GxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BmlU1XNTAEdELMC4OCIGbPn2NgM2cIiOLY6JIqGMLKRfuIJKtxaxM1iph9zBgkRuOj1i/bGJdRL0L+akYNk4nubsImqK9oAuRi1s6u2T5oLOplhcwGrlEJaeqM0kVg0Aq3H1vZZ7jr4oZ/z6qqkRlv59KyWMNh0rp95gUNczmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSKIMgV4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9901F000E9;
	Sat, 23 May 2026 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558924;
	bh=KmuweU/KpiHBgBQmq/LYn9YmIagqoe1ON60urAlAxBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lSKIMgV425Pk6eUE5rd09QAtj32QltS3Ct51p6+09BGTmdEQiN5fqWWbJ245sUP40
	 fD+9vsAUhHfZiBF7kZk4yyCoKjlty4W70KXoxE+Ngbl0YdsNhSPh3mXM7spbkSdT9q
	 FW4lT+b8U7o+ks/hQF/nJzYdKq1MUjcxvvmOuC/5iwz6Q0NcqfULhL2m2G2Q11S6J9
	 o0NVR6VLe5fABPC3cen+hZVxg0f3wxU+YECMqnVyK+B+MhAGByBix7x+POvJzfsX4C
	 4YbA4pwrEQu1kMJT2ze16r1ZZ7qSXRvF8GvvHRFRVrT1Q4+E7RfGIzP+/4fdoFv+I5
	 DZtpEIhLt/Y5Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 23 May 2026 20:54:18 +0300
Subject: [PATCH 06/17] NFS: remove unused page and page2 in
 nfs4_replace_transport()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-b4-fs-v1-6-275e36a83f0e@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21881-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EE5AF5C0257
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Temporary buffers page and page2 allocated by nfs4_replace_transport() and
passed to nfs4_try_replacing_one_location() are never used.

Remove them and the code that allocates and frees memory for these buffers.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/nfs/nfs4namespace.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 14f72baf3b30..2a03f02bba7c 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -481,7 +481,6 @@ int nfs4_submount(struct fs_context *fc, struct nfs_server *server)
  * Returns zero on success, or a negative errno value.
  */
 static int nfs4_try_replacing_one_location(struct nfs_server *server,
-		char *page, char *page2,
 		const struct nfs4_fs_location *location)
 {
 	struct net *net = rpc_net_ns(server->client);
@@ -541,21 +540,12 @@ static int nfs4_try_replacing_one_location(struct nfs_server *server,
 int nfs4_replace_transport(struct nfs_server *server,
 			   const struct nfs4_fs_locations *locations)
 {
-	char *page = NULL, *page2 = NULL;
 	int loc, error;
 
 	error = -ENOENT;
 	if (locations == NULL || locations->nlocations <= 0)
 		goto out;
 
-	error = -ENOMEM;
-	page = (char *) __get_free_page(GFP_USER);
-	if (!page)
-		goto out;
-	page2 = (char *) __get_free_page(GFP_USER);
-	if (!page2)
-		goto out;
-
 	for (loc = 0; loc < locations->nlocations; loc++) {
 		const struct nfs4_fs_location *location =
 						&locations->locations[loc];
@@ -564,14 +554,11 @@ int nfs4_replace_transport(struct nfs_server *server,
 		    location->rootpath.ncomponents == 0)
 			continue;
 
-		error = nfs4_try_replacing_one_location(server, page,
-							page2, location);
+		error = nfs4_try_replacing_one_location(server, location);
 		if (error == 0)
 			break;
 	}
 
 out:
-	free_page((unsigned long)page);
-	free_page((unsigned long)page2);
 	return error;
 }

-- 
2.53.0


