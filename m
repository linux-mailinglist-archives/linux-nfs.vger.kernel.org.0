Return-Path: <linux-nfs+bounces-5671-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034895D93E
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 00:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828381C22029
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 22:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE091C8FCD;
	Fri, 23 Aug 2024 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxo9J0fD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328821C8FBF;
	Fri, 23 Aug 2024 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724452070; cv=none; b=BKQlM1tcGl3eIp9/IQdrWOBe9eZHd6YOqk5DcQPWgEXUp9Bwy24It2alxqtiW6aKEKcS0oujwRoo5nV6zi37Ltc0Ut78F0K2OMX00lITGAXzHvHxExrPNoqTZ4tipME/NUtSpjr9k0AgudgtPdHo/1idUcLq6ei5xeW+HE0RLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724452070; c=relaxed/simple;
	bh=kty5DiXOElIaYiIXEHSyHcwD+de4TPi2RfaJ5UVWk2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZOr38H+75LHD1b7eERj1xBZ4P0eC/zN5SbGf1VQ1UOROdVDsLhdTdJ4FURWjRITVcq9tHr28LakxgdW5eH2mPibVtelIPv8biavXslro1jKvHbst2668sznc8AE8k8zTMHSMyWuLe8FUqkbqqkl/ficfq7F4+8cUdO7J1ZNuhh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxo9J0fD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6A9C4AF0C;
	Fri, 23 Aug 2024 22:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724452069;
	bh=kty5DiXOElIaYiIXEHSyHcwD+de4TPi2RfaJ5UVWk2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hxo9J0fDznkohDDBQTu5zIQLTPOkD6KaEXU9SN9xffU3U80MTtpD5xicLxAHpPqUp
	 t/9vDrwE7UDHfuW45+mwhKcxGL7FifsQeoMVPmM24EtYWu0OXTJL/uvTftXS2HyMMU
	 qFdkGVUsxNXNEQp1Zp/KvXwVpGNWPG6z8rNK1+i0N44TfzyZ1f6hFYqkgKqLHzGpkK
	 CbWm4hYl26Nqlt/3V7sEaKHgs7F4uuN2cbY5a4TCnT3XYEYEJmUMtGXpfhrr4FrbLG
	 DfTX+MwIYW236KSry8g5rOfiemVoYBdfCFXTDTO55D7Hsa4VNe5mVcqv5swvBGbNtv
	 52i5EPJJOTxTA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 23 Aug 2024 18:27:38 -0400
Subject: [PATCH 1/2] nfsd: hold reference to delegation when updating it
 for cb_getattr
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-nfsd-fixes-v1-1-fc99aa16f6a0@kernel.org>
References: <20240823-nfsd-fixes-v1-0-fc99aa16f6a0@kernel.org>
In-Reply-To: <20240823-nfsd-fixes-v1-0-fc99aa16f6a0@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kty5DiXOElIaYiIXEHSyHcwD+de4TPi2RfaJ5UVWk2o=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmyQzjBnwB9eOMq5fTWSqE/ZJyaFskXXMxxgDq1
 XgZam9B4BaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZskM4wAKCRAADmhBGVaC
 FfH9D/0Xe/CjxhYhH24GOKbcmutKn6HSRfrk/hvyfWg822GhZp5NOIosmotyXs5RNa4zVEz/8eR
 Rsz9sM5Mf799NWX85M+fqICdRaaYRgpTHpetWoCQ9y4+CS9W/2AULqNhDQ396IHJfy/gb0eCDT4
 1Nk0lizzQjKL2F+bCZD6QbN1a8U7ifb56sw2VPsRjo8JB+ymGQ7ifX6kYAjkvXi59woHxVidm0H
 c2tulhCDD8xVYS5oAcX6h6B1ApDhQAL8agAx8W/CcoPyafVTwhksIdbFuIb4gpKxnnLqXwVkKjt
 2MbcKM+7pK4MIgCwAiLIdHKxhYWWZXX0gpdPykeYvUJemdwoAoQPRKfpzri/Cos9nNHSbjA3q/a
 WWvNaTAiS23wuOf2SdSp4taKSd0SdLshhUfERsbmrxUI/Tu+GhmvvHW4CATT4MKoAl0l9JBmQ5d
 weZd6RX7c/gWLpMZQqKiC/645N8CsNjhdnLHEI3JPI1XxHOUSh+gZohJyjIURvTYZE4Y0d5Ir2O
 5H68BCL0fadeRE0yFBF50R618CaKRAUSriQTY8NKnE2ah+KMAfk/c8TAAdKo1ElqLYWXRqYIfd5
 uJ1ybswJLrbTP5B2MO9HsOY4eTHMqj/yUTiwmcaFjPOYbBvqwAFdVoUuzFBwpwGeGYXxKmsBaYg
 W/vwOnGgDxOBjXA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Once we've dropped the flc_lock, there is nothing that ensures that the
delegation that was found will still be around later. Take a reference
to it while holding the lock and then drop it when we've finished with
the delegation.

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dafff707e23a..19d39872be32 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8837,7 +8837,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file_lock_context *ctx;
 	struct file_lease *fl;
-	struct nfs4_delegation *dp;
 	struct iattr attrs;
 	struct nfs4_cb_fattr *ncf;
 
@@ -8862,7 +8861,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
 			goto break_lease;
 		}
 		if (type == F_WRLCK) {
-			dp = fl->c.flc_owner;
+			struct nfs4_delegation *dp = fl->c.flc_owner;
+
 			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
 				spin_unlock(&ctx->flc_lock);
 				return 0;
@@ -8870,6 +8870,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
 break_lease:
 			nfsd_stats_wdeleg_getattr_inc(nn);
 			dp = fl->c.flc_owner;
+			refcount_inc(&dp->dl_stid.sc_count);
 			ncf = &dp->dl_cb_fattr;
 			nfs4_cb_getattr(&dp->dl_cb_fattr);
 			spin_unlock(&ctx->flc_lock);
@@ -8879,8 +8880,10 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
 				/* Recall delegation only if client didn't respond */
 				status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
 				if (status != nfserr_jukebox ||
-						!nfsd_wait_for_delegreturn(rqstp, inode))
+						!nfsd_wait_for_delegreturn(rqstp, inode)) {
+					nfs4_put_stid(&dp->dl_stid);
 					return status;
+				}
 			}
 			if (!ncf->ncf_file_modified &&
 					(ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
@@ -8900,6 +8903,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
 				*size = ncf->ncf_cur_fsize;
 				*modified = true;
 			}
+			nfs4_put_stid(&dp->dl_stid);
 			return 0;
 		}
 		break;

-- 
2.46.0


