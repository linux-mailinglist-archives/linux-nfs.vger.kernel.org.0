Return-Path: <linux-nfs+bounces-22516-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /cjvDuIdK2qp2wMAu9opvQ
	(envelope-from <linux-nfs+bounces-22516-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:43:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC966753FD
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:43:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OTZ9HjbJ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22516-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22516-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9D963195D19
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269124418DF;
	Thu, 11 Jun 2026 20:39:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E4FC0A;
	Thu, 11 Jun 2026 20:39:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210350; cv=none; b=ACQ8nQb6I8QsR/3A1qSlzhDBH3MT5rJUE45Kuz+SK6Rj36v2M8PwwLs624vAV2axEEQPBkVOHQJSvaOIhIZQcORmQeH1xNYTVYhPeFKCyfVfk3Nv0MyLG1hvDISNGvGP0d3YZN47uk2Da4Lu+wcqz3YM6IXGaqaEPFHCW1gt03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210350; c=relaxed/simple;
	bh=BLRS1QfNPqSzaWd9ltdq7mD7QRgzKYfRVz8Ya6pJEPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mSdxJAbzMFxJW2WitZISAsWXg2JdCBHpSWxlAr5X38AR0x/ZvcDH0Kjj9k098u7nv7oyO0+QF/JYgB+LZM5z5RkF9mkIxAymofkAfMAe1qY0HyWwa3bqTVzBP6gU8G3cxPbRilTuv9t0mHc+wlblnQ2cz2rqssr9inW9qU5V3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTZ9HjbJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366D61F000E9;
	Thu, 11 Jun 2026 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781210347;
	bh=L1D9xPLmGDmv13FugeRYYEoTnEeiIXht+joTvUzMY7g=;
	h=From:Date:Subject:To:Cc;
	b=OTZ9HjbJ3R8ViokuTRA97cvk+QrdGdXAID3ETOUsp7k7+HLbtOQPklWDAmrQBCioC
	 aKSwdu0awyEuHh/n0zQrPy3SL9eLlJFKzrh4bbToA2nybJsBJDQ2niQj5nsuKThyOC
	 emH32A8UXy5eg5IG5mrKbUjxBL99K8YvR6UXW7rgmZRyU0mz87O1PlgDNREWx0P3TH
	 pGPQlW9NoH39zB91WzbjJ3FxYie4GQZJoZDnriFWeaLumJKBpKqO6H+70FxodUIWfB
	 zHBES3mMTfcaVxWqd1y/rIMzz7OmZBSX7rXOsg2aVfLG0WedpDiBbxZ0IuSpOXuoJ4
	 G52/S0hS3JWmA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:38:56 -0400
Subject: [PATCH] nfs/localio: fix nfsd_file ref leak on nfs_local_doio()
 init failure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfs-localio-v1-1-b42b2587b6c5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBMcFwN1lWhhOtaAaChEIN49a
 fkW/zeoXIQrrFODwo9UyWkA5wncZdPJSvwwGG1IE6JKoaqYnY2SFbL3C2HQBzGM4i4c5P1v297
 7BzIlwa9dAAAA
X-Change-ID: 20260611-nfs-localio-1edd961f0b6e
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jeff Layton <jeff.layton@primarydata.com>, 
 Lance Shelton <lance.shelton@hammerspace.com>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2394; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BLRS1QfNPqSzaWd9ltdq7mD7QRgzKYfRVz8Ya6pJEPE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxzks7ntxmn+eK8COMHqgwul2RRnS3C9nc6mP
 Xg02W7p1H+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisc5AAKCRAADmhBGVaC
 FR5rEACa5OQuOxu6ax8Bmod/Qt9DTu/E4q+NHDap/Fu57cCamosyfhlybXjqXiQ88hbBFWHKpsU
 IrSz+eAPV6Fb/1eSQ4NOqNsEfpK7Z+7IRxeY4+dA3i4VrmVrQX9/Xr5kaPEtUHP7ZAu1ubgrWiP
 nbHS6S4oM0s4xOYZOzZR3A2UtUmKGC6IoMBlDfu7jp5NB0friFhufXGP3LDTvBapWifT16XMXx7
 vMQCYnPjZyfZuen46JjGH+RufBoCP0TiJswj81FvI0sZTDpR57H3LSVXxlw6RthDNXH8Vxn/k8q
 w2lCevFyzJV/Bm7InOTnQ8Uye/6Ness0dYPBfXxcqTpR+/KYKPMnhnhFrQwwZLv5NXe8jhaEvao
 TlrEc8hD5obfQ+JROFDFtDk2kMaTOXgM9+FZknM9LxG/HxviH9d35q7CMaYNqQw8tRtRajzDoP0
 5+lDnDYP2lTOYMFiqvuuGDqtgzgpzmKajsGqgFp1L9NHk0Mx0+S58/6oAWPr+vbPibx4wHBgKN6
 EfQbI9NHzoyzDJA80yW9tYQOSWbWmPzJHX0RVsMKvik4UicYQ3xmSG+PYXKgPIp+8RGcTCquPeX
 nuHm9wgNIZW9HUGQhlFkzotm+yKZQCLqSY1xxi3HWzUAPsP2IjfJaNQmOy1Zttrt0eNBW4Y/I/J
 6Z9ufPcr4Nm8gJQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22516-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:jeff.layton@primarydata.com,m:lance.shelton@hammerspace.com,m:snitzer@kernel.org,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EC966753FD

Two early return paths in nfs_local_doio() fail to release the localio
(nfsd_file) reference passed in by the caller:

- When hdr->args.count is zero, the function returns 0 without calling
  nfs_local_file_put().

- When nfs_local_iocb_init() fails (e.g. -ENOMEM from allocation or
  -EOPNOTSUPP if the file lacks read_iter/write_iter), the function
  returns the error without releasing localio or completing the hdr
  lifecycle.

A leaked nfsd_file pins the associated net namespace reference,
blocking network namespace teardown, and holds a reference on the
exported filesystem, preventing unmount.

Fix the zero-count path by adding the missing nfs_local_file_put()
call. Fix the iocb init failure path by jumping to a new cleanup label
that releases localio, sets hdr->task.tk_status, and calls
nfs_local_hdr_release() -- matching the existing error handling pattern
for the post-iocb error path.

Fixes: e77c464c31b3 ("nfs/nfsd: add "local io" support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I had originally sent this as part of a pile of nfsd patches, but Chuck
pointed out that this was client side.
---
 fs/nfs/localio.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index e55c5977fcc3..63cf6e2cc745 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -970,12 +970,16 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 	struct nfs_local_kiocb *iocb;
 	int status = 0;
 
-	if (!hdr->args.count)
+	if (!hdr->args.count) {
+		nfs_local_file_put(localio);
 		return 0;
+	}
 
 	iocb = nfs_local_iocb_init(hdr, localio);
-	if (IS_ERR(iocb))
-		return PTR_ERR(iocb);
+	if (IS_ERR(iocb)) {
+		status = PTR_ERR(iocb);
+		goto out_put_localio;
+	}
 
 	switch (hdr->rw_mode) {
 	case FMODE_READ:
@@ -996,6 +1000,12 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 		nfs_local_hdr_release(hdr, call_ops);
 	}
 	return status;
+
+out_put_localio:
+	nfs_local_file_put(localio);
+	hdr->task.tk_status = status;
+	nfs_local_hdr_release(hdr, call_ops);
+	return status;
 }
 
 static void

---
base-commit: ec039126b7fac4e3af35ebccaa7c6f9b6875ba81
change-id: 20260611-nfs-localio-1edd961f0b6e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


