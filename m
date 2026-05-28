Return-Path: <linux-nfs+bounces-22056-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H2kEiK6GGptmggAu9opvQ
	(envelope-from <linux-nfs+bounces-22056-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:56:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E561C5FA9E9
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8E823066553
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA8367F3A;
	Thu, 28 May 2026 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMTxol24"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EBA367F39;
	Thu, 28 May 2026 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005339; cv=none; b=IvpFSUZYHpZgYywH4NC9yeZ7fOqeVIBroBq8aOlPaYhgAXwxpb4qveWFRX4GRt7+FkawX2vJzcFZS0be5tGWk5aF+87pSS9A9UqdZ2FtAZb/BXC4KazPbrOT3mxYK/k5iLDpMGnWlI4EquV4K/rnkLM5xjI0lI/htegx0b3EKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005339; c=relaxed/simple;
	bh=UbQcjF1aflAaonH5RYIn6VQryJ6M+npfRRDLBTJOvg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2DYLzQfmvuoISbcmgxQ45+uy4ygT8ZrKshcaHx/vfUBo0MeGKvcvRqsnWgJumQ5KzSKCTHtLhKX+0JaodQhnVQFfli8zzqHhq5EKQUC8r9FHFC2ae9GR8VPL+w5UxdVO/5S/HQl3JDhQhhLTKz6cE80QQXoSzPhcb0yNmfwFOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMTxol24; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4991F00A3A;
	Thu, 28 May 2026 21:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005337;
	bh=5v+H8BNr/R9YGsFJQjJXGp6wWRKHN8YLFQ2smYTVaEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NMTxol24bsAQF3ENt0MYho8Bwinw96mA117TG/8SsojzFCXgigfKA0Wavfxc9dyVb
	 cFLlNQmN+IxkzYu16bG051vRTK5WOf81f55OGY+LZjdqhhvoleCwYAHD6YKw61xqHo
	 laxCkxkz8CxLjfBqmocmjurg3WGUf5gGVCRGiRKRg9C2JXPZ0hpOsZSFo3dY4pjkvU
	 9XxAKJma5gKD04syaMO3RtWFd6S4ScfrMcVL6k4nO/geUSxhzF2UYTKvg6EKJb7MFO
	 Yp4c22B/Qa4Jdllu4OhXvQYn1SaBuqKI7rSSyEvcw2fBdl+fz9ZUp9yyOh8Lq2Qkpu
	 b93Zl9V9fzQMg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 28 May 2026 17:55:19 -0400
Subject: [PATCH 08/10] nfsd: fix partial-write detection in
 nfsd_direct_write
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-nfsd-fixes-v1-8-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2421; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1+zAyObpPwUeMrDlZP4+lDrpr9oaGw29ATNniqWkcjE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGLnLihC8bAm7gQOtVdbQagkPiJZH5sr5Nn16j
 QQzWPS2HbWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahi5ywAKCRAADmhBGVaC
 FZSKD/0e2eczik0V5+94G7F81QBu46AzcLogayiX0UdJ2yaj65QyI9FikD8casBeSv+DaCz6src
 aW2pWFI6yJ1Vk+OiiWBQ/g69sUBMrK7/c0NSTbnVp6lhPrgnnShZmEHUeovEljuhtySDjAKRqJ5
 QZyd8cq5bFaVqt3e6OIEHdVqeREP2qHFSqJLR6AD59VLqG7BS32Pts0BIvI/VBoKMz/GBsDVDSR
 Igi2hqO249dvYqDefHNH6CfYJp6iIBMih4UePRLro0hqm11uVLgqg914QM39sqLIsMgPH04pV8q
 Uy68w10t0NZERBy66tW6qycvELyRNVbq/dO7IEC6v5JPqs7/HuW4MUDXCu+7PUl0djXPqvPxkq3
 s0s6/Wx9iGwX6i9xY33r13KssRkCcPLhrGmBnHWs5hbWh3X0vUxtrra8TPV43cZFcNvnnIhlBlv
 UgSxrUN2vm06oJt/SK9S3wiYreQmsC/9YTtYX3n1JFUYR40Bg6d0B75r/RltdW+EjkvEBk1AINX
 N3g28r4J6Rh3SrTB6km+BEStf8qhuW0VB1KP2lfgKFP9lVXEEqHb8HKyEdBHMVFg1bgtKK1VV+Y
 S6gJqH3uVgtwms+V1BwlmDLQ5sLZ9YKC+Me6NKCxvDwWXKtS01hKFZK+wjQDWGHetwJ2GG1+gX0
 4AeAvwJtalijUYA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22056-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E561C5FA9E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

nfsd_direct_write() walks a list of write segments and, after each
vfs_iocb_iter_write(), tries to detect a short write so the loop can
stop before placing the next segment at a wrong file offset:

    host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
    if (host_err < 0)
            return host_err;
    *cnt += host_err;
    if (host_err < segments[i].iter.count)
            break;	/* partial write */

vfs_iocb_iter_write() runs the iter through ->write_iter(), which
advances the iter by the number of bytes written. By the time the
check runs, segments[i].iter.count is the residual, not the original
request length:

    before write_iter: iter.count == original_len
    after  write_iter: iter.count == original_len - host_err

The condition then reduces to host_err < original_len - host_err, so
the break fires only when less than half of the segment was written.
Any short write completing between 50% and 99% of the segment slips
through; the loop advances to the next segment with kiocb->ki_pos
only bumped by the short amount, writing the next segment's payload
at the wrong offset and over-reporting *cnt to the NFS client.

Snapshot the segment's byte count before the write and compare
host_err against that snapshot so any short write breaks the loop.

Fixes: 06c5c97293e3 ("NFSD: Implement NFSD_IO_DIRECT for NFS WRITE")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/vfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 980217f755b7..619f252af4d1 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1380,6 +1380,7 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct file *file = nf->nf_file;
 	unsigned int nsegs, i;
 	ssize_t host_err;
+	size_t expected;
 
 	nsegs = nfsd_write_dio_iters_init(nf, rqstp->rq_bvec, nvecs,
 					  kiocb, *cnt, segments);
@@ -1401,11 +1402,13 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				kiocb->ki_flags |= IOCB_DONTCACHE;
 		}
 
+		expected = iov_iter_count(&segments[i].iter);
+
 		host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
 		if (host_err < 0)
 			return host_err;
 		*cnt += host_err;
-		if (host_err < segments[i].iter.count)
+		if (host_err < (ssize_t)expected)
 			break;	/* partial write */
 	}
 

-- 
2.54.0


