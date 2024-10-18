Return-Path: <linux-nfs+bounces-7288-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C359A4634
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 20:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2848285F2D
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EC820969C;
	Fri, 18 Oct 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdt0v5Wu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A202204F7E;
	Fri, 18 Oct 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277121; cv=none; b=OMUccTBLOLlU93QHnzhBfySR43DQoXnUojvngyvTr9welquZTac4XkTPTw6JETiwfFDZhda1iMtuKQcgzgcDCe7gnmmO92Sm2LSRGXdhzPKWk6Z1efateZ4Bl4//oqMFzmFThU/3KCdcZUZu02Th0yrdBVGaO0Sw5d4C00M36Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277121; c=relaxed/simple;
	bh=nqOHeFQ2YRLvNuQnzNCeXfKbiKvT2jPMl5MlLaketm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DECpvfBU3W4De5MY2z57WJ29mwvC52sfy1NRq7URMhDhzRGWEo0iRE/WNIrrGBPokK2j1RqWGYvQGXb4awl/yEAAqaxmvCa6kOPfDJjajc1B0hRNE9W4BbnfFVhlc1hv2RG2I3cb8kV4Hls+zggziTAajm3wvFbIhuITlYgw9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdt0v5Wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F85CC4CEC5;
	Fri, 18 Oct 2024 18:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729277121;
	bh=nqOHeFQ2YRLvNuQnzNCeXfKbiKvT2jPMl5MlLaketm0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cdt0v5WuBZwbM92TN4NWGoiptAy941Qrkvr4/PzlCaRsWq17hZTvsRcfT7otJcOTI
	 940mdN0t8gTB/Wb+5auw8vGE3V9AG0YsTkSyoQaH4vC787/eQrsMXLYOvYLAkKWOZj
	 e5DGEMDwaiXxbbYlq1mLRIIrw/tEMtR1d7GMAxQrxAq1D+lCHX6G0NKuKXVRAaKg5p
	 iDQkNL/MnRoTkINb33edzo+mayws4k0bdLooirSjVDY/vKNnh7Sck18xe4ym9Qts6m
	 EnMNV0qU4SUgmlv8Cx9DWEE+IOFFVUDu3Sjux1kjkbklOH0Ad3P3aSn6TbBFTsOnzR
	 ThcCfu7qTqNiw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 18 Oct 2024 14:45:00 -0400
Subject: [PATCH 2/3] nfsd: allow SETATTR to provide a READ deleg for
 updating time_access
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-delstid-v1-2-c6021b75ff3e@kernel.org>
References: <20241018-delstid-v1-0-c6021b75ff3e@kernel.org>
In-Reply-To: <20241018-delstid-v1-0-c6021b75ff3e@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nqOHeFQ2YRLvNuQnzNCeXfKbiKvT2jPMl5MlLaketm0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnEqy9XQrUlXxAyr+TMhXGfnZmk/eZ9unJoB+zv
 dVgMg5f8NOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZxKsvQAKCRAADmhBGVaC
 FfJGEACqSZFgGLtViE3R9zqaof9Q4EK+c4YwOks0iZUs0cIysdS2sF/4jjuvY/YMoGtCjrsugIP
 6WN2J1+eEYhDckZ9tg87m1qhPgvzDRrKHXk4g8VFqUtCJw4LtkiqbNQaxAAs9b9IEwRosR13LHG
 lpioUIvh/eqey6LCS/dP1LiRBdH6227N95tM6mrKHgyB9U8BOpAr50lBq5VTy9MWIHuQLu5oaCO
 OF7ufFi6+Cg+Cy0aIHk22xyzWf8Rp4jHZKfg5O/5yXFgJ/HRk4xhNjSPuIX9LB285zPx7KYoGFB
 T5Qjut+jUGVYa2Buc45ymKq9eS+M9K/C12wL5jc524YVwZKo33opKucABdSgaazD8FFeA/utL9H
 NrnrQmMFhRoppNFqO7gTgAw2kAz39BffUOoNa6PtVkTRfbI6odk+VZhDjs4ty8XXv6MSVl8PkRY
 M6j81YQGxE8lU7ZDfwNcynGMQpIChxC7FpuEHPicSeDqNJLsbsRRP1+N3zzlCQZHp6JxBVtwfi9
 NNF6yUAgGkSd7NErWHBOHaHuA9GpdgaOVqTr4BJNROaurZc0wbfFRNx5cyXarG9loLAClcYSPJG
 nIxTfAdKwzQhbZX1AcNpC/cotk/UHmrX3XcODHeImEUyKGYKj+Rjlik27LitrpQqtDx9B0eH9UE
 pNsoRGGHqjAhU6g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, we request a WR_STATE stateid for all SETATTR requests. If
TIME_DELEG_ACCESS bit is set, set the RD_STATE bit in the mask as well
so that we can use either sort of stateid. Also fix nfs4_check_delegmode
to check for the absence of RD_STATE instead of the presence of the
WR_STATE when testing for a read delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 7 ++++++-
 fs/nfsd/nfs4state.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 320c4f79662e65848dc824885566d48e696fe97c..f843b56b7b2056cbb69669e50c9ca9797cb91f0f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1143,9 +1143,14 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 					      FATTR4_WORD2_TIME_DELEG_MODIFY);
 
 	if (deleg_attrs || (setattr->sa_iattr.ia_valid & ATTR_SIZE)) {
+		int flags = WR_STATE;
+
+		if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS)
+			flags |= RD_STATE;
+
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
-				WR_STATE, NULL, &st);
+				flags, NULL, &st);
 		if (status)
 			return status;
 	}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7905ab9d8bc6820dbb7ecb6f29c1e14b036e0de5..4ec58aab10410471bab25b3780facad4d77441e7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5444,7 +5444,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 static inline __be32
 nfs4_check_delegmode(struct nfs4_delegation *dp, int flags)
 {
-	if ((flags & WR_STATE) && deleg_is_read(dp->dl_type))
+	if (!(flags & RD_STATE) && deleg_is_read(dp->dl_type))
 		return nfserr_openmode;
 	else
 		return nfs_ok;

-- 
2.47.0


