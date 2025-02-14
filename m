Return-Path: <linux-nfs+bounces-10125-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3FBA36296
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 17:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579E93B40B1
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F9F26770E;
	Fri, 14 Feb 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD7bMyjK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C559245002
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548671; cv=none; b=Pd6IF1E0yt1lL/2T5VwZEJZdEtF4YgL0OovDXiQd7Bi99+aem0scliA6HsZQ7rnGK5xO7O+nDsNssZVjrySyejCH/mj1Iqz6RHSLFmCo87irPg5UGvYjEn4SHONkjOfmGmyQGm5X9Nfvktrguir7lK/ggTQBwhZkASJ4tLZRI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548671; c=relaxed/simple;
	bh=CLBVbWkNRA23qaMrTddi5L/iaUzexYkHibsCI2XTuLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIdsG5Lfm8FO+OfAiqrEaOKGUCpfdiIDnTold8dwm0mNqb+qfdS47Mc+h3UgH2bXYPKqHK5Kwj6jEJE/QmYESsyYpBWh09P6WKHN4RG69MWnuI2GZH+OmTBWRfvy2CBOI74F1/xrBMrd/FQapY2eqV/HBXOsjIVGx49xOaHjmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD7bMyjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7455FC4CEDD;
	Fri, 14 Feb 2025 15:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739548671;
	bh=CLBVbWkNRA23qaMrTddi5L/iaUzexYkHibsCI2XTuLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fD7bMyjKav2jCB3Nm3uiGq/4r7g7ErJp3ZoY/6hNpQqAUDkHq6WmDdXMm6L+Mafng
	 aEfMaNtO75HY1viBU/UGFmzyrLa2emzgSe+tcWLhGKRnK8DvN5Z1PsGg337+27Ckei
	 zz/V9splzBMFX/ArTjKWkJea25robuwahzS+cnFOpgH9JqA7PWIXzR3TFHvaWmOdmO
	 5qNoUi7qzkrLqvZvC0q40HridGVGTe57dWBGRTOUJdHuow39ve0u65tPdFgxvfG6W7
	 GH0MqhFa4mJ5RF1qNmNQGLKCVWWY8+EDdBrPtqKZP/GQ6ZQsh2LZDC5bFQ8k77ptwa
	 IBtfqE2Joi0Eg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/3] NFSD: Record call's slot index
Date: Fri, 14 Feb 2025 10:57:44 -0500
Message-ID: <20250214155746.18016-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250214155746.18016-1-cel@kernel.org>
References: <20250214155746.18016-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The slot index number of the current COMPOUND has, until now, not
been needed outside of nfsd4_sequence(). But to record the tuple
that represents the referring call, the slot number will be
needed when processing subsequent operations in the COMPOUND.

I've brute-forced this by adding a field to nfsd4_compound_state,
but there's probably a way to add the index to nfsd4_slot. I'm just
not sure yet whether slot table resizing might change the index that
a struct nfsd4_slot represents.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  | 1 +
 fs/nfsd/nfs4state.c | 1 +
 fs/nfsd/xdr4.h      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 23052fa0e8bf..d09a96cbec1e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2792,6 +2792,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 
 	resp->xdr = &rqstp->rq_res_stream;
 	resp->statusp = resp->xdr->p;
+	cstate->slot_idx = -1;
 
 	/* reserve space for: NFS status code */
 	xdr_reserve_space(resp->xdr, XDR_UNIT);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b7a0cfd05401..c38601c9bf13 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4415,6 +4415,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	else
 		slot->sl_flags &= ~NFSD4_SLOT_CACHETHIS;
 
+	cstate->slot_idx = seq->slotid;
 	cstate->slot = slot;
 	cstate->session = session;
 	cstate->clp = clp;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c26ba86dbdfd..561894ff4b01 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -186,6 +186,7 @@ struct nfsd4_compound_state {
 	/* For sessions DRC */
 	struct nfsd4_session	*session;
 	struct nfsd4_slot	*slot;
+	int			slot_idx;
 	int			data_offset;
 	bool                    spo_must_allowed;
 	size_t			iovlen;
-- 
2.47.0


