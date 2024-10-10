Return-Path: <linux-nfs+bounces-7036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2B999341
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 21:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5462B24583
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 19:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3BE19DFA2;
	Thu, 10 Oct 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIQw5q6T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4F1990C1;
	Thu, 10 Oct 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590230; cv=none; b=NgSrlBVxfS1MFsOUodgTstgOChwOCtHE2E7meQZF2mCD7KHXVszlk0L2ewrLFVSQxvq9jM6KZUmull9Yr5v1jA0C3jttVc99+lyeBrH3kE9Riz/HK+sAbm380LVSFjYH/PL6V3EWpjZqJwZ4ih6QKPeM51yyv8tXkmpB9qTqIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590230; c=relaxed/simple;
	bh=q9Q/osgeAQXVfJAaHOfFlNollpmh1cJYbXNK0esuEbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=emKoAMw7nOAPN4wiEwZ43OtFw5HxUPM8rJEcG4NrHkVQNcRVsuy7ubacxfm7/c5lXB7yWG9oTS/tuPWSGWEk+NxqD9ooBKCn4pprdRZyzITzun6iXuOQ7haWS4CO42DUA1nz+ToYkLMUcxBzBZSIhdv+QkSTnxYY4Zno4E8C8ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIQw5q6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A97C4CEC5;
	Thu, 10 Oct 2024 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728590230;
	bh=q9Q/osgeAQXVfJAaHOfFlNollpmh1cJYbXNK0esuEbc=;
	h=From:Date:Subject:To:Cc:From;
	b=ZIQw5q6TCBLsIV2ZfkgA1p2lJofWPuOHM6Tt/ejVGH+5/vttDbyuK1tYkqCPOZoZb
	 rdCYx+6hosSrDLlZFVSxCkcg91CzpdsG0o/qZ+piBwMbVzfGRgFkrKcellgoM0ijU2
	 xBqUplGCOIferYXtpd1KY6lTtyQORUSLdULX0Lve1W293HbZtFutr9C0K3li3Oz9t+
	 DfaiSKLNSXgKW3yAYGfF5xD8+slECYPZEKqdbQz7bTNw3T/uW1k5gRFL7mMNmMBz7R
	 hEhggUb5N0GJrnIDQLatIHq1gLEJmZ3MgqgkpFDCp/ABHFK2/jYV3tXobHINCrSUX7
	 i0yn/hBvCsAyA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 10 Oct 2024 15:56:55 -0400
Subject: [PATCH] nfsd: handle OPEN_XOR_DELEGATION outside of st_mutex in
 open codepath
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-delstid-v1-1-1e0533c6617b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIYxCGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MD3ZTUnOKSzBTdlCSjREOjNCMTozRjJaDqgqLUtMwKsEnRsbW1AOm
 3cEdZAAAA
X-Change-ID: 20241010-delstid-db2a12f242f3
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <oliver.sang@intel.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3225; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=q9Q/osgeAQXVfJAaHOfFlNollpmh1cJYbXNK0esuEbc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnCDGN9sXfc5DauxclktLtMGkCH6tstpA0rcJWp
 Io/YqB/m0mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZwgxjQAKCRAADmhBGVaC
 FXIoEACI2vArBHpYfD5ZRa7SSQE7KeayjUjKJFCIYp+hvqbof7VzPDTU2j7e1lRd/Oj6ieHy3pG
 VLUtC8BIpyidJ03eyaOdNg9uH87WdFDUgvPEfy/yiKgZrZceper/66BDoB+x1+PtgCZ4QEABqMe
 bUDltrvBZfhC/+x2u9QeuEXssUjnPzX2dw3gSxc6L9+qyp+MaMiYhTOyRZXPu1LkhLK20WhUyfV
 NvcpfgKZOVyyxCqIyIjIxtlhZTHh9lZhm6kpk0azlQqrB1C7uX3heceswzAAnbs6alI8AF6vPe1
 XPHzbAptFv9yrWF1Vgd+W/wLiDeNVjmGnO24PzTi/3OD4+z9EtEwVwhmthLkK3VcG78CRBwqffJ
 ZNGzVl0KAD5CidMHhIZqUCozoiuFK2fIyI7bmXJNxpYxA8wbMCZNap8sQwi0WV4cDPr9Pikj+jA
 QPWhfVM1ilgMC+rHo6p4M036V9EFQSBqe9I2WeDg1+/QWe68ravqjtHztQPS6SwUzw4UmwsgIvz
 ucZUba59BSiJbBV4k9o6pABToX5lUEWVKNrQeIkMy7mCEoO9/tBv7eMjlOQ/Gk7Sb9ZdpMVzQXN
 GhU2Vu66xzpvxwDgrXjSTra10N8kwn84qpfb4WIZJZpPkDtK+eksZ2wyROJT0EwOto1Mk480QrD
 uYsF4LZSXGYS+hQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When I originally wrote these patches, I was under the mistaken
impression that I didn't need to increment the stateid in the case of an
existing stateid (because we weren't returning it). After some
discussion upstream, it turns out that the server should ignore the
WANT_OPEN_XOR_DELEGATION flag if there is an outstanding open stateid.

Given that, there is no need to expand the scope of the st_mutex to
cover acquiring the delegation. The server may end up bumping the seqid
in a brand new open stateid that it ends up discarding, but that's not a
problem.

This also seems to lower the "App Overhead" on the fs_mark test that
the kernel test robot reported.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202409161645.d44bced5-oliver.sang@intel.com
Fixes: e816ca3f9ee0 ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
We had a report of a performance regression (in the form of higer "App
Overhead") in fs_mark. After some experimentation, I found that the
cause seemed to be the change in how the mutex is handled in e816ca3f9ee0.

This patch restores the App Overhead back to its previous levels (and
may even improve it a bit -- go figure). Chuck, this should probably be
squashed into e816ca3f9ee0.
---
 fs/nfsd/nfs4state.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9c2b1d251ab31b4e504cf301d1deaa4945bd244f..73c4b983c048c101d16ec146b3f80922bcca3c69 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6120,7 +6120,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	struct nfs4_delegation *dp = NULL;
 	__be32 status;
 	bool new_stp = false;
-	bool deleg_only = false;
 
 	/*
 	 * Lookup file; if found, lookup stateid and check open request,
@@ -6175,6 +6174,9 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			open->op_odstate = NULL;
 	}
 
+	nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
+	mutex_unlock(&stp->st_mutex);
+
 	if (nfsd4_has_session(&resp->cstate)) {
 		if (open->op_deleg_want & NFS4_SHARE_WANT_NO_DELEG) {
 			open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE_EXT;
@@ -6194,17 +6196,12 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	 * returned. Only respect WANT_OPEN_XOR_DELEGATION when a new
 	 * open stateid would have to be created.
 	 */
-	deleg_only = new_stp && open_xor_delegation(open);
-nodeleg:
-	if (deleg_only) {
+	if (new_stp && open_xor_delegation(open)) {
 		memcpy(&open->op_stateid, &zero_stateid, sizeof(open->op_stateid));
 		open->op_rflags |= OPEN4_RESULT_NO_OPEN_STATEID;
 		release_open_stateid(stp);
-	} else {
-		nfs4_inc_and_copy_stateid(&open->op_stateid, &stp->st_stid);
 	}
-	mutex_unlock(&stp->st_mutex);
-
+nodeleg:
 	status = nfs_ok;
 	trace_nfsd_open(&stp->st_stid.sc_stateid);
 out:

---
base-commit: 144cb1225cd863e1bd3ae3d577d86e1531afd932
change-id: 20241010-delstid-db2a12f242f3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


