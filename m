Return-Path: <linux-nfs+bounces-20222-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JLdLuJLuGlTbgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20222-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 19:28:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B06629F0B7
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 19:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A12D3026A9A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374D5218845;
	Mon, 16 Mar 2026 18:28:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8E3A257E;
	Mon, 16 Mar 2026 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685728; cv=none; b=XvznvbDtGqRmQuTvaColwz+CcvVXjTCl7whW43L1HQaOryiVffJu55XZcGL7yRiqnjedSU6psmDWaTPyC4WejqLajJ23wMp4rm0AEDNKTBKMUTx6mbHSS1bWzYhuYTRR/4NhFnZP1zmeluyBbXuW0GqhSR3W8JTFzwSxQleLTeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685728; c=relaxed/simple;
	bh=2JGaOQ+/5MbtItPoxYx8/+miveKJkF/K7tVtM+JJsnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+eUfqzWpKkkH8gDxEUe5Z9mhOibZ1INnkudE5uu+zMB7f5FoRkFn860ZeIiTxiuIKoonhLVfdlCYl43Navrd829V7W+iO2nmR5jonW8RM13XrSbHCYjORu+aQq8QsickIh3gAONOCDgv4m5tqTAG2G7FfX6cIjHYu95CFLoSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D75C19421;
	Mon, 16 Mar 2026 18:28:47 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: fix comment typo in nfsxdr
Date: Mon, 16 Mar 2026 14:28:45 -0400
Message-ID: <20260316182845.155269-1-joseph.salisbury@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[oracle.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20222-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[joseph.salisbury@oracle.com,linux-nfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.909];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B06629F0B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The file contains a spelling error in a source comment (occured).

Typos in comments reduce readability and make text searches less reliable
for developers and maintainers.

Replace 'occured' with 'occurred' in the affected comment. This is a
comment-only cleanup and does not change behavior.

Fixes: f5dcccd647da ("NFSD: Update the NFSv2 READDIR entry encoder to use struct xdr_stream")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
---
 fs/nfsd/nfsxdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index fc262ceafca9..ae71e0621317 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -605,7 +605,7 @@ svcxdr_encode_entry_common(struct nfsd_readdirres *resp, const char *name,
  *
  * Return values:
  *   %0: Entry was successfully encoded.
- *   %-EINVAL: An encoding problem occured, secondary status code in resp->common.err
+ *   %-EINVAL: An encoding problem occurred, secondary status code in resp->common.err
  *
  * On exit, the following fields are updated:
  *   - resp->xdr
-- 
2.47.3


