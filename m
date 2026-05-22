Return-Path: <linux-nfs+bounces-21843-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJBVC6HOEGpeeAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21843-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 23:46:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0D5BAA3B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 23:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A44F300ECBC
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D63314D0;
	Fri, 22 May 2026 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1niuY1W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994721CC51
	for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486362; cv=none; b=Gujkc74dTKpfzIn0cep076IlLGwRClIb6HZ6x0uZ0e1zu4EB4eOT2Y3EfmTYj0pWk8TGebzyH7SQ2MGpSeyH7vNt9HkChXroLdPL6zTahAm/U5sZEyzcp5nSJEonYO8MMX0jIeDZNrtifHZRnH299vdY/ts9QtRlNKhcU8rrUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486362; c=relaxed/simple;
	bh=ZU3qdS8Z+iz7NqAZtnE1VpCFBjFO6sy4CvZJ3S/DRKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfKFpYYG87hKNfaGkoTpIsSXueriiBwLEZButE0tzSPo0C+/X/ANKlEOl71gLJpoY019EiXhnb0j4yGfCcF0PXC3HCY2Es6J1tR4HOLugLXwk3KByFjx6exqEwEGKGbCpnS++b0uvFSl8WHCkPan2gtzqbjA+VLr/Adm9OBTrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1niuY1W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5F41F000E9;
	Fri, 22 May 2026 21:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779486360;
	bh=1rqdk6wdnOGSmMzErkzyKHae9mnBO5Mjefcpg06uvH4=;
	h=From:To:Cc:Subject:Date;
	b=Y1niuY1WQJNAUAKjsAN/LEG/7yj3eyJgPetI81IVwyWI7nxK0AgzUAG31M4Q9Rjzj
	 2ttUWj6sSi10Kn7x7Nt3/zE38lLW2o/kLHnFhY4hoSpTdYWzJZn9GKCszuBnsumi3i
	 olEyqBNkOa1QWBz6MwfP/2EHyE4FhCfaod4qoroYhYjOSZ4YbfUZv24Vv0F9C9t+7e
	 vEXoKdGt1+ijONcQzFcLpD2USupyqOQ3/dAAJA+PS9ecJB2AkadB78gyUr2jdzj7M0
	 dOi4cpMh+UC1chgyVD78bep2mVuZrFDN32MkwqKV1nyyFrTtG0Koha9bFPeoLEegEE
	 ZKBKHmCRrPliA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH] nfsd: sample writeback error cursor before async COPY loop
Date: Fri, 22 May 2026 17:45:58 -0400
Message-ID: <20260522214558.460859-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21843-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,oracle.com:email]
X-Rspamd-Queue-Id: 70E0D5BAA3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

_nfsd_copy_file_range() samples dst->f_wb_err into "since"
after the copy loop, then uses it to detect writeback errors
via filemap_check_wb_err() once vfs_fsync_range() returns.
Because the nfsd_file cache reuses a single struct file
across requests targeting the same inode, a concurrent
COMMIT or stable WRITE on dst advances dst->f_wb_err to the
current mapping->wb_err via file_check_and_advance_wb_err()
during its own vfs_fsync_range(). If that advancement lands
between the writeback error appearing in mapping->wb_err
and the COPY worker sampling "since", the worker captures
the already-advanced cursor, errseq_check() sees cur ==
since and returns zero, and NFSD4_COPY_F_COMMITTED is set
even though writeback failed. CB_OFFLOAD then encodes
wr_stable_how = FILE_SYNC4, the client treats the copied
data as durable, and the failure becomes silent data loss.

Sample since once at the start of the function. The cursor
then reflects state in effect before this COPY issues any
writes, and filemap_check_wb_err() detects any error that
occurs during the copy regardless of which thread first
observes it. This matches the pattern used by
nfsd_vfs_write() and nfsd4_clone_file_range().

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260522194441.436065-1-cel@kernel.org?part=1
Fixes: 555dbf1a9aac ("nfsd: Replace use of rwsem with errseq_t")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 93fcaf90d6ae..3024d51d6fb7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1950,6 +1950,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
 	/* See RFC 7862 p.67: */
 	if (bytes_total == 0)
 		bytes_total = ULLONG_MAX;
+	since = READ_ONCE(dst->f_wb_err);
 	do {
 		/* Only async copies can be stopped here */
 		if (kthread_should_stop())
@@ -1965,7 +1966,6 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
 	} while (bytes_total > 0 && nfsd4_copy_is_async(copy));
 	/* for a non-zero asynchronous copy do a commit of data */
 	if (nfsd4_copy_is_async(copy) && copy->cp_res.wr_bytes_written > 0) {
-		since = READ_ONCE(dst->f_wb_err);
 		end = copy->cp_dst_pos + copy->cp_res.wr_bytes_written - 1;
 		status = vfs_fsync_range(dst, copy->cp_dst_pos, end, 0);
 		if (!status)
-- 
2.54.0


