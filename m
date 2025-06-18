Return-Path: <linux-nfs+bounces-12560-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F77CADEDA4
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 15:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C133BC815
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 13:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079BC2E92CF;
	Wed, 18 Jun 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaJ4k48I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0D2E92A9;
	Wed, 18 Jun 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252775; cv=none; b=m9+n6GNmipXXjjYekpi27PhD33/LuE6v26kLvNhr8so3ntQ4C7KNeZPaivwYcEcixGpsBCrDe846o885lrpQKmRdXvSOrsnID/vevoiYCObdVwmyFWrLpaVZlV+iYsny7DNX8uFQ1DGBtVm4cW18i4oFSZ7/SgsOp6wJTkPS3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252775; c=relaxed/simple;
	bh=Kj4KG3pu1OsywXHvSD3bQycaZRNcuCFo2JaNg0X1CAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+tADw3VcPanAGvlLEp1iCt6lcb614AUxmjOQSrJ8FYt5cmLFxoVBxCRbshjwu3EidQx1pPcz4ZxXTqJE7F3GGJN4hYefgkYlUR4Ti5a5lXwGBYV94WoLrO9UwL7/MM+p7gwczdLd1jZpyrSTrggrStvjrCIvjW4nYWis4zBQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaJ4k48I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303D1C4CEF3;
	Wed, 18 Jun 2025 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750252774;
	bh=Kj4KG3pu1OsywXHvSD3bQycaZRNcuCFo2JaNg0X1CAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BaJ4k48Im0qw6GhLE1SBLrjw+l7NnqNpJUJFZuczsjRMyMrJDGh36yIWl+IUBvhbR
	 hecJWpvVfbTPKYXQZTAsZuuyvBS1nrkAzf0vDBoHTmOKRco7Sm9HcceJcet8BlLJbO
	 oM6P/njiUanc8lSMH262BqYdmOm8koRBDRYCU5CGfaCKoJAj68KVwSqTHTsrinFB/G
	 Oey4kUWss7rHyO/OUnQlwu9FiMIIMMqajTnZjxxJeN7rSZJGbyE3aX7zRx4Yksm8tk
	 5lNrB+nTIIPJrSADPzY//3BDy4DUi36bm6oTWAdmqtge9DCChlgeHeZGKSRGfR+8Vc
	 4ZeRoaj7Ce3Bw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Jun 2025 09:19:13 -0400
Subject: [PATCH v2 2/4] nfs: add a tracepoint to
 nfs_inode_detach_delegation_locked
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-nfs-tracepoints-v2-2-540c9fb48da2@kernel.org>
References: <20250618-nfs-tracepoints-v2-0-540c9fb48da2@kernel.org>
In-Reply-To: <20250618-nfs-tracepoints-v2-0-540c9fb48da2@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Coddington <bcodding@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Kj4KG3pu1OsywXHvSD3bQycaZRNcuCFo2JaNg0X1CAA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoUrzkQLLPDJvQvoZ1JbxobIhOgfdwHIFq31W7d
 BAJVwx4VECJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFK85AAKCRAADmhBGVaC
 FXTPEACMu9c7zDvkjF1+oAejS+AnBJz/kyPzfm5WWxg1WPJ2HQel+V8wRCo4XyKEsY8xnAVm2vB
 zg5QQ34efHxOAirKpTsGa+0TVgXvmBfi/6h2Rkj/SITiAuQn8XyTUb2ctymYlfRR8v5CU4f+H83
 SVL4I9sQXD+4ASqMg6OWWGgPKrODahtCVJN1fpycDeQ2dFZhxKaaBbALXDTSu4+BRAEuqxXS7XE
 /9CH+8k1cOwfwkNJeSnXrIrZP2SbdcQ/eNZh5OQFwb89/rKoRH+t0XF37ApeUO16+Xbg9bto8Yv
 DKYB1RZ0uxFDqHrcxsG2BWfvYhXbnG8H6+Yi3sPsU7/e36TkagrYGHoNVQjKCndT2YMPEnytQoh
 3ZW5L3hYrMGzYI+BxaI+T7ID4UWFfQucwcZC+L4yuSYXjZrYfJr0vcNM26CRo1bTZIrrbujzcMz
 CZf+3xdt+lcRVkijn+CkozszYYYqN5GJvBc/qu6wCz77O48lOGcAJJSegGpGXpD0BdQzXnv6c8X
 orgMCRKElbvjmKaon0UwLSuWFQ1LsZI9r1ArOMGVR3n+788dR5UxC1n8O/olSylKgTSr4nsvoiE
 P6DgAjpTB0C6as5AlccyXMcVFgyi9ZPZGWxGIFwYHklA450cIv9t0mAApB710DFofjDIaDMczDX
 67vGKD3fUxRj90Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We have tracepoints for setting a delegation and reclaiming them. Add a
tracepoint for when the delegation is being detached from the inode.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c | 2 ++
 fs/nfs/nfs4trace.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 10ef46e29b2544920c026f023885301d5d8e22cd..78a97d340bbd98390ca8302176c17caf08dcab4a 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -355,6 +355,8 @@ nfs_detach_delegation_locked(struct nfs_inode *nfsi,
 		rcu_dereference_protected(nfsi->delegation,
 				lockdep_is_held(&clp->cl_lock));
 
+	trace_nfs4_detach_delegation(&nfsi->vfs_inode, delegation->type);
+
 	if (deleg_cur == NULL || delegation != deleg_cur)
 		return NULL;
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index deab4c0e21a0642ee97b0b81f8c55812f5028f7c..6e1c4590ef9bf60eac994e85be816e82f5e0c741 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -956,6 +956,7 @@ DECLARE_EVENT_CLASS(nfs4_set_delegation_event,
 			TP_ARGS(inode, fmode))
 DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_set_delegation);
 DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_reclaim_delegation);
+DEFINE_NFS4_SET_DELEGATION_EVENT(nfs4_detach_delegation);
 
 TRACE_EVENT(nfs4_delegreturn_exit,
 		TP_PROTO(

-- 
2.49.0


