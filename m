Return-Path: <linux-nfs+bounces-21811-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAy4IYOIEGriYwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21811-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 18:46:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 062DD5B7B82
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 18:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B43BE3020118
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833E47799F;
	Fri, 22 May 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/hyr3eJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276040963B;
	Fri, 22 May 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468265; cv=none; b=GZbRXpDjdkI37VpfZ5PTiC7gAa3bnFTQvAjyLsWUYJ7VGNXgc7SDbBC5CqCVdmwmKLrO8WvG8iCzUb6U0mX6sFNxWVkEJDK/xkEJIV4B9GFqAOB5tgzHFDrj9TN10133A9vrcpOuptLFqFFmERWNsTC5VaGwFoYMkIo65UcD03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468265; c=relaxed/simple;
	bh=weTvBs1MjU+aC8Cdqkl6LwmSWO3h+MHoIDx9hJ6G68U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DM6Hhvmt6SKBGNnIWI+00ejxnwJANgSCc3yQMcyDLr9iynUZLFiG4RoJ+zyjaVb8qad34qk3vJE5X8ebfIRP2vY5pEqvMdn0cMYWmZ22jawsnr/tCRHK9kFUoHUF7OMdGhsKGzCSv9JcqUJhbTKlJaOJuNpunqZ6MGePGKLUGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/hyr3eJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0183E1F00A3D;
	Fri, 22 May 2026 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468263;
	bh=gu5wLq9eA0hzzZ217be+ZqxxCAWuDHV5yrh5Ki1KnbY=;
	h=From:Date:Subject:To:Cc;
	b=P/hyr3eJgc1k1xl5tvz8xpHEziO8Xcw81HJtYP7+wYVZhvhnp1ypj345e6SIY9Lqe
	 bnTYk8CcXnIYGrOhxSjQ+G2OkG5gbfH2cHetv3L7LYCo5bP1Af4AswI2EuJlONpqBz
	 qT0shV7pBcF+oG3YZ/gthZR3k80H2Xta6vRlofYKP0hvuf0yRnfHURT7biKFDgWUsS
	 EZI/K8xii1fB8gbh+iTcSOXktM7FTDsGdd45mSdqevog/dfONapWMF2THXvVTRCxpv
	 vvgZTPm/dW++xJwpPTvIjKDLLz6QyC+ePglWqnqsvPRetmvMnaQQM1Hpie2WL+gwXe
	 InZHd5c4Q36XQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 12:44:19 -0400
Subject: [PATCH] nfsd: reset write verifier on deferred writeback errors
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260522-missing_verifier_reset_on_wb_err-v1-1-bf9f427f9b26@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQqDMBAFf0X2bCANqYi/ImUx9Wn3YCy7ogXx3
 xs8zmFmTjKowKirTlLsYrLmAo+6ovdnyDOcjIUp+ND4ZwhuETPJM+/FmwTKCsPGa+YjMVRdbD1
 SE4eIBCqZr2KS373oX9f1B34r9x9yAAAA
X-Change-ID: 20260522-missing_verifier_reset_on_wb_err-480eb64a4ebe
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chris Mason <clm@meta.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=weTvBs1MjU+aC8Cdqkl6LwmSWO3h+MHoIDx9hJ6G68U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEIfmT4qidPuF8ByAne8hxFlsQQ7JEZ//9c5vn
 YhUdYs+nWCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCH5gAKCRAADmhBGVaC
 FU/VEACMXNVKmK9t0uc1V5+1G0XfPOHVD7hrYQc2O/XrDYDhIoJbzftdE3hdOjTByiqZNHGC4Lg
 dPN+V5RnKtaH8YIRQ1Bt/tBKOSWsQn6Z0I0EM2nreu0v+nt8HGtXAJKU4ogfVVOlFG7ux6+X7cd
 G1Hz9/53tPwXP+Pe77H63cQv0ULgqIzXsTstvQKZGu/FxihTYn91AhaxcRVSNi/A6Qo7q1dGtlO
 caZCluA9xIky240kn2mhHl7CA57NniFOaIgWYM0TLw63tyGgOyuQo3XL53LVoVvDGkoIdlRt6MC
 EHb5ZqD2MhviS8GtAvMgFlw0l3/0y7jLXveYJ1STWognq8ZaMYv+efbCeycwKUV/E4mWsJ0pICl
 XiXgVLFqY2OIvugrqZHl49XjRElq0NDggcmOaBeYtNYfyLV/g18F437pWVFktA+Xb+sesMcKmZF
 OG6YK/Tk5st322x7EcRVDx/ke0Q5Lq2tHdTNRig2HbZnZhrB9epZM0wpmEYHiFPk7+g1lHeLwaU
 C2AlU2zAkuh+7uK3b3Anou/LFpdSayJx3kuEz5nS+d0rsKOrkdRVsBcQlGY6iGQWfxqZlZScGaN
 pTvVCWqPN3K9wEBR4kUM50XuSSAV+iW4i10kO1rqVgywiRMdJuwcS7DkprVrQpw6B7komT16nJl
 M8Mt2+28S3I1HdA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21811-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 062DD5B7B82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd_vfs_write() and nfsd_commit() both call filemap_check_wb_err() to
detect deferred writeback errors, but neither rotates the server's write
verifier (nn->writeverf) when this check fails. Every other
durable-storage-failure path in these functions calls
commit_reset_write_verifier() before returning an error.

The missing rotation means clients holding UNSTABLE write data under the
current verifier will COMMIT, receive the unchanged verifier back, and
conclude their data is durable — silently dropping data that failed
writeback. This violates the UNSTABLE+COMMIT durability contract
(RFC 1813 §3.3.7, RFC 8881 §18.32).

Add commit_reset_write_verifier() calls at both filemap_check_wb_err()
error sites, matching the pattern used by adjacent error paths in the
same functions. The helper already filters -EAGAIN and -ESTALE
internally, so the calls are unconditionally safe.

Reported-by: Chris Mason <clm@meta.com>
Assisted-by: kres:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cba473969429..7e6468bdc723 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1513,8 +1513,10 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	nfsd_stats_io_write_add(nn, exp, *cnt);
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
-	if (host_err < 0)
+	if (host_err < 0) {
+		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
+	}
 
 	if (stable && fhp->fh_use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
@@ -1694,6 +1696,8 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 			nfsd_copy_write_verifier(verf, nn);
 			err2 = filemap_check_wb_err(nf->nf_file->f_mapping,
 						    since);
+			if (err2 < 0)
+				commit_reset_write_verifier(nn, rqstp, err2);
 			err = nfserrno(err2);
 			break;
 		case -EINVAL:

---
base-commit: 6167e81847ba3adca17d8881ed9415beae993e2d
change-id: 20260522-missing_verifier_reset_on_wb_err-480eb64a4ebe

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


