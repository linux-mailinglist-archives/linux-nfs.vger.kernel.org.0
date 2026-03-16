Return-Path: <linux-nfs+bounces-20221-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIRTAxJLuGlTbgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20221-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 19:25:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9248629EFF3
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 19:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C74F30242BC
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A089315D58;
	Mon, 16 Mar 2026 18:25:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ECF3016F1;
	Mon, 16 Mar 2026 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685518; cv=none; b=J0fT/harKKm4/mpwl6BFkcjDSZHJSE9DOq5InR6fwQIDbimsjtPqt9wyozwvkxVHHzjfWOUfwQPUHkhWBCMYaa81wIPrbTDPiUAc3dQ4E0wNJuKcnvbSnqcCh9VHvd49ceD/jQJ4qZSz4hdhnHEF5/0vgpPz31A5JFJAQwxHuOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685518; c=relaxed/simple;
	bh=efGJWkE8U3TCx9phHcaMg7PMxqk0si0nap9W0C6sESQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KlBnFrdL+lUKADVaurKwjAhHrqt4w5GYHQ++6qlMIylvlG0bwmbtiT2xoDqtlvX7ZXOo1stajnrgKhI43C5WBfF1pfIwDbO/fBzx6IAxv4j2iNoMQ5tnBGGCQnJRxTBYHLlq+2u0/+WowfZVEzPGq9a4WQWa0zL2WYUDJhzddSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE220C19421;
	Mon, 16 Mar 2026 18:25:17 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: fix comment typo in nfs3xdr
Date: Mon, 16 Mar 2026 14:25:16 -0400
Message-ID: <20260316182516.153940-1-joseph.salisbury@oracle.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20221-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[joseph.salisbury@oracle.com,linux-nfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 9248629EFF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The file contains a spelling error in a source comment (occured).

Typos in comments reduce readability and make text searches less reliable
for developers and maintainers.

Replace 'occured' with 'occurred' in the affected comment. This is a
comment-only cleanup and does not change behavior.

Fixes: 7f87fc2d34d4 ("NFSD: Update NFSv3 READDIR entry encoders to use struct xdr_stream")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
---
 fs/nfsd/nfs3xdr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index ef4971d71ac4..2ff9a991a8fb 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1069,7 +1069,7 @@ svcxdr_encode_entry3_common(struct nfsd3_readdirres *resp, const char *name,
  *
  * Return values:
  *   %0: Entry was successfully encoded.
- *   %-EINVAL: An encoding problem occured, secondary status code in resp->common.err
+ *   %-EINVAL: An encoding problem occurred, secondary status code in resp->common.err
  *
  * On exit, the following fields are updated:
  *   - resp->xdr
@@ -1144,7 +1144,7 @@ svcxdr_encode_entry3_plus(struct nfsd3_readdirres *resp, const char *name,
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


