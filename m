Return-Path: <linux-nfs+bounces-10083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39703A34188
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 15:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CFF3A42B8
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2025 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC0F281363;
	Thu, 13 Feb 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2AQMbcW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246028135D;
	Thu, 13 Feb 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455713; cv=none; b=Pvs12JX1nJ1Yc5AW/YubwSod3LiomlxTvPRJX5XM1/FWfk8PiMI7kANW0duiSDjftG8n3MhFVcUIQUVDBGT3+CdVvTzDWUZbCDfaLNawfkEQnsB4Ho62FOzbrWkdGwb8YzMxys+ZfnEBglqu9EXiR3EViYtGV+Fd61lACdiKWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455713; c=relaxed/simple;
	bh=kgqP5pYJ/bpUOryhSSQygdgkcdkG/n6XTOBq4HLVNBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mUPtbQHxP/xVoKz09mm712dyHIC4Fyv4Aap12HOlGR8WkGanzXBk1a31vDRPSw4gL2bdNob+UA8LBjaF/Gf66rSYC0xq4ZnEJBcQ1FtbGMAIDg2ZpltuS2eNQn1lnERZXj9GlhUgzGh5urE8LLKpVcWY4SyavDW0/ElIMc6+7To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2AQMbcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E84FC4CED1;
	Thu, 13 Feb 2025 14:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739455713;
	bh=kgqP5pYJ/bpUOryhSSQygdgkcdkG/n6XTOBq4HLVNBc=;
	h=From:Date:Subject:To:Cc:From;
	b=G2AQMbcWIiltv4YQF1dCdzBJzyosDkOzWz+6pKrfrS4/ugEuos9FG8twISb17VG6f
	 gP4K2A27eKMVNhzPWWE+Rmr6PeQATQPD5scFYM6f8duObt7Mh1LGtX0VZefutDX5AC
	 nZiQjbl9Gnj2zaHSPLOlVvVPh8a5/4YDVLWZtsWjZsMK1JywqaEBNqBaEKwdlhCsS9
	 3MH9TgazeaDtqHaREK1gwytR44VZR/uwq9TZl1kMGEqF5k50rvMxS4UDE+msPi4kjK
	 sNe7EThewWBHJiBd5kVEGcaLHSwN8gRgzP/mhpJKIx+0pNIL9tILDfBm65lJchaj/3
	 uAiR3/orlFwkA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Feb 2025 09:08:29 -0500
Subject: [PATCH v2] nfsd: allow SC_STATUS_FREEABLE when searching via
 nfs4_lookup_stateid()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-nfsd-fixes-v2-1-55290c765a82@kernel.org>
X-B4-Tracking: v=1; b=H4sIANz8rWcC/22MTQ7CIBBGr9LMWgwMJRZXvYfpgrRDSzRgBkM0D
 XcXu3b5vp+3QyYOlOHa7cBUQg4pNsBTB/Pm4koiLI0BJRqJCkX0eRE+vCkL7wbZX+SAWhtohyf
 TUbT9bWq8hfxK/DncRf3Sv5qihBJWG9Kut8r6ebwTR3qcE68w1Vq/9F3YG6UAAAA=
X-Change-ID: 20250212-nfsd-fixes-fa8047082335
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kgqP5pYJ/bpUOryhSSQygdgkcdkG/n6XTOBq4HLVNBc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnrfzgaAgVp35tw3jiwtFWlWUPkiLVe/vqgWWfP
 d1sla5m2kyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6384AAKCRAADmhBGVaC
 FaUcD/4pDvsQgqmZFuZw1lsrSiYhAUxs6EWKotDMSQ3E5sMZtjRGaOvntcs4vS60qxJ4nqqmh9d
 EOZeOkRGdaEmDeeclhoHGCDnk/ViUx1MhOhonJTSHwK8sYGHrMePG9VeOv3JbtVTQnJX+Bgt72J
 KbpHHfejnSzvgtvVIWNaUvGLGLM2RfuF7K7flncFIDLBAUJwoA9+2VlTJwhtciRgYy219SZ3GrC
 Q6qq1MShcmYS7S1UlAwKGERmt9pXiciYHZHs3XLBgIl2XCOwHGjJAkKSNkdZWmejzfb7JrZhzLd
 4y3W/JPjIiAaLel8Qfn4jTNsBRIQHYYhAtWnSoytHIV0asWCF9eFl/PLEj42QqrQ/NvFjAOMJ6Q
 uX+wM082RaVODY4yHOQCKPJUVetLM88pj1Rx0vCUPPW1SljXR5cNYcxBrotca8/pXFWbWv2CqlM
 VwMbb3xDl3ypiZZ/5syQ2ih6L42DdwNqzDDxGSujm9eBQJpB3blVYzNA+BK+8MnORFKMkrm5lOk
 lI1NmXW0RaC2l/xeTv7pfvhOB+fcXI/gWLmOVF+AFa9dDhFod4A5HEaB5I+JDlMIV0P3GlKp/nu
 ul+Y8JnVCzQCloL7UcFx/5/mFow8fJfFjUS0KeLM3IEuFktXjo1llw7UJYj0Zny5l81goyeDQA6
 tDa3Unx5E0NLS6w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The pynfs DELEG8 test fails when run against nfsd. It acquires a
delegation and then lets the lease time out. It then tries to use the
deleg stateid and expects to see NFS4ERR_DELEG_REVOKED, but it gets
bad NFS4ERR_BAD_STATEID instead.

When a delegation is revoked, it's initially marked with
SC_STATUS_REVOKED, or SC_STATUS_ADMIN_REVOKED and later, it's marked
with the SC_STATUS_FREEABLE flag, which denotes that it is waiting for
s FREE_STATEID call.

nfs4_lookup_stateid() accepts a statusmask that includes the status
flags that a found stateid is allowed to have. Currently, that mask
never includes SC_STATUS_FREEABLE, which means that revoked delegations
are (almost) never found.

Add SC_STATUS_FREEABLE to the always-allowed status flags, and remove it
from nfsd4_delegreturn() since it's now always implied.

Fixes: 8dd91e8d31fe ("nfsd: fix race between laundromat and free_stateid")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- remove SC_STATUS_FREEABLE from the mask passed in nfsd4_delegreturn()
- add note to changelog about pynfs test, and Fixes: tag
- Link to v1: https://lore.kernel.org/r/20250212-nfsd-fixes-v1-1-935e3a4919fc@kernel.org
---
 fs/nfsd/nfs4state.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 153eeea2c7c999d003cd1f36cecb0dd4f6e049b8..83e078e52d3a5891f706023cf7d9fabdf26b6705 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7051,7 +7051,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		 */
 		statusmask |= SC_STATUS_REVOKED;
 
-	statusmask |= SC_STATUS_ADMIN_REVOKED;
+	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
 
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
@@ -7706,9 +7706,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
 
-	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG,
-				      SC_STATUS_REVOKED | SC_STATUS_FREEABLE,
-				      &s, nn);
+	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED, &s, nn);
 	if (status)
 		goto out;
 	dp = delegstateid(s);

---
base-commit: 4990d098433db18c854e75fb0f90d941eb7d479e
change-id: 20250212-nfsd-fixes-fa8047082335

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


