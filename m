Return-Path: <linux-nfs+bounces-12070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32289ACC5A6
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 13:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A087A5571
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 11:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8622F772;
	Tue,  3 Jun 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueSe/xHw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68AB22F763;
	Tue,  3 Jun 2025 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950953; cv=none; b=snHHJw01A58bryt/cl6sIZWWYCU/iFQAwbuFJvr2qXZvA4tHbSisC9A7EE3xdyEuUd0nGTHTSeaFkZJLgnyWdAKjohGusHEsoSYjPMCr3uCM1To434SihA1tCT+8YMRk1KB9Zweyz2f6BtpYKu5bpm0zeSJkvhF7uFCR5DaA0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950953; c=relaxed/simple;
	bh=gGasBQyt+ZOsCCBdHYduRO46MAtmoQkiJmvgSAWw3TI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8noTSOagRK321y1ht3Ik1BHyQs5QexTWAcjS5jbjsxkT9T8xDQk/q0ozKzQr/1WJNIzKQile29GU7GYxcLzEfBXdnPJ2Ja7dDJDwQGI3YCtY4aF0vSCqPHSs2GgeEX0SCAsgv97sZbPCA4kSxrc/wqOnM636pRlvzImr1Y/hfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueSe/xHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57BFC4CEF2;
	Tue,  3 Jun 2025 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748950953;
	bh=gGasBQyt+ZOsCCBdHYduRO46MAtmoQkiJmvgSAWw3TI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ueSe/xHwxulw+7Pcmc02Pk17MuEgQp7UZhwEJXmVWYnEEbweBVKuuAPqa7CIVUMQS
	 2xsZlMBoAS8XNnpQ/up0Kwul0r9G7kWzW2jckP+Ej5zvOL3lLzTDoPbevMUHR/a5Xv
	 I2I1cv2cvEd/YKq2mHhiuEL5dve34R8+d95BVUV7CQ7WSfOxbPc91FRkqZE+H08MA0
	 I9rQI/kpVhZNcjKg5fHqKPxakvSKojtrEEeRVC+GGoLaGOZ1xI2+vE93drM4lNA+l2
	 yVAk8ljx8rK0mMkoXW+9h3CW8AfPhFy8ksQwry7tf7kaI2hZWlQQ9INF0WyYNCs1z2
	 NmiKa+814Ec9g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 03 Jun 2025 07:42:24 -0400
Subject: [PATCH 2/4] nfs: add a tracepoint to
 nfs_inode_detach_delegation_locked
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-nfs-tracepoints-v1-2-d2615f3bbe6c@kernel.org>
References: <20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org>
In-Reply-To: <20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gGasBQyt+ZOsCCBdHYduRO46MAtmoQkiJmvgSAWw3TI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPt+mgkJb77tze4pEPRx7Kv/BDj4ymMp+Q/CqZ
 0ignz9MthCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD7fpgAKCRAADmhBGVaC
 FYaRD/4gXQK9m6mqlAX7kcXtaSi+RSei6SRSRl1UaVp/mk6UcuTKDlmry4JukfGnIzVUA7Vbo+C
 CYLT627M54enBKcc4cx27IlZlluHf12jz7j4vAbmvDmu0SyQgUsrOe6LIyO/M0n3dD+9aTr6xQg
 dNloVz6t9d8UGHYYEhzFlL9onrvn4OEoI+/tOTr9cOhB8+bBTD8yrnPqaUH5mpD2jJb0hrPGU+2
 WTODMzlHvxS4BAgX78CabybYD0qSxO2p1WIFxrwyy/gPPphrZgBvNBqb1k6egkleEdmOQ4lIkVH
 2ewdsJ4RCprjCKMR+uebH3lEWiPWsoswmqBc4zMmSlSfrfjZyklwPYu8KXRO1LEn2+WUJtpTf0C
 vEb/lJvg9OjYnybInLmoERMKItRdkZ4upgOuAj3L9471inObMyiLSVBRNrLPWQDdck4FidnRZ4Q
 PT9iNBqITLXz9cnQtrsTG+oF3fIqMmFAD/pWCaOo4POh/RAFJOvcodAOC+yx1Tka85qD3L+PudS
 BD66rMlAApOofzmhWVAMxTO1uVYYXAXi3DhOrRaebqyAJgb+P9gt/AqOQcXkQEwfJJdNwOjJv8S
 5NkGkBgb/TgXFecOejsX5jb6rB1+206NfJdoItrE9IIaw1TPJv/84hzkm9ble5W9ELvjQ9iyU/N
 CCSDoWy3yCgVCcg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We have tracepoints for setting a delegation and reclaiming them. Add a
tracepoint for when the delegation is being detached from the inode.

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


