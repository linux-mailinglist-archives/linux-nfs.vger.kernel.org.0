Return-Path: <linux-nfs+bounces-21837-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEagCme0EGrRcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21837-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:54:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 769D65B9B37
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36705307F9EB
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74A737204A;
	Fri, 22 May 2026 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx7FSfzP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E048352028;
	Fri, 22 May 2026 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779479085; cv=none; b=LXcj++85eq03oabbFuxvXSTjMadNK2saorTWWO14JIM+xIX24XMIzi2Clyi09A2wjIy4rae7u1xdmr/sTfO1eWnvVyyQIJKiCum4pwV4Li3YXX+tfVXaelmldHLLfjrzde0yLxGfAV/INTxIQyqDOGhCi0mvsHUypWYGrkfCyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779479085; c=relaxed/simple;
	bh=iZJxebvKghfe1rCQsKYYOuvu/RVKqe3FJW01lvjawoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fImIlktngOTmhif11rKkhlRUxl6gagD+Idx8myO4vllmHHg9RkzqqKdfv98Ej63NK5U+rDUk/vTLPjYfhWAe+xg5oHFdGpAvSx+kqhxW0QqIvFJmqV9MPSPyeJVv1I+9O82dkedcF8QniEI69fOpOvLDK125rJ+ECgCGlbMHxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx7FSfzP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B421F1F000E9;
	Fri, 22 May 2026 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779479084;
	bh=spOZqTYTOq5USNgHvQEPYKLjJcL1F/gnjOVCoB4BRQ8=;
	h=From:To:Cc:Subject:Date;
	b=Rx7FSfzPgdVw9sL2DYfcxQCsRufYim57ncCtinfsDYvBRaaKCCzGTzo9C7WXZbqgW
	 Uiws/ZAfyKMkCkHyw5iZWidmO9O8YxgA/XiL+9qiyPstQVqjtinu12KbeuPzYvCSN/
	 JGtduV9z+2ML3EA6qySBD7OKx1NECpSEWzRj0MwLnRzYFW0epkKbDT8Q1db2RSEjd1
	 uiD69PgmumNwvDe3pU41qwPdkKDrkg/3UPeYH+2MJz48qHFgkwtkGuhklG/Ute55bN
	 f7ANpvO98nZwLkcFkyqXL+f+hKUtGm6omRBRWWPMm2wrAZJlyFkUZa/er49LpnA9WH
	 vgv5ykIdmCHFA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	stable@vger.kernel.org
Subject: [PATCH] nfsd: reset write verifier when async COPY writeback fails
Date: Fri, 22 May 2026 15:44:41 -0400
Message-ID: <20260522194441.436065-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21837-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 769D65B9B37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Async COPY captures nn->writeverf at request time and reports it to
the client via CB_OFFLOAD after the worker kthread completes. When
the post-copy vfs_fsync_range() or filemap_check_wb_err() in
_nfsd_copy_file_range() reports an error, the worker correctly
leaves NFSD4_COPY_F_COMMITTED clear so that CB_OFFLOAD encodes
wr_stable_how as NFS_UNSTABLE, but the server's write verifier is
not rotated.

A client that receives NFS_UNSTABLE in CB_OFFLOAD follows up with
COMMIT to make the copied data durable. With the verifier
unchanged, COMMIT returns the same value the client just received
via CB_OFFLOAD, and the client concludes the copy is durable --
silently dropping the data whose writeback in fact failed. This
violates the UNSTABLE+COMMIT durability contract (RFC 7862 section
15.1, RFC 8881 section 18.32) and matches the bug just fixed in
nfsd_vfs_write() and nfsd_commit().

Rotate nn->writeverf at the writeback-failure site. The async COPY
worker has no svc_rqst, so commit_reset_write_verifier() is not
available here; calling nfsd_reset_write_verifier() directly
mirrors the trace-less reset already used by
nfsd_file_check_write_error() for the same purpose.

Fixes: eac0b17a77fb ("NFSD add vfs_fsync after async copy is done")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8561540ab2db..26f09e2ac4f3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1972,6 +1972,8 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
 			status = filemap_check_wb_err(dst->f_mapping, since);
 		if (!status)
 			set_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags);
+		else
+			nfsd_reset_write_verifier(copy->cp_nn);
 	}
 	return bytes_copied;
 }
-- 
2.54.0


