Return-Path: <linux-nfs+bounces-15047-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A45FEBC54FA
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 15:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F1174F89BB
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DE82877CB;
	Wed,  8 Oct 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhUlFQ3A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329F286420
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931557; cv=none; b=XPYORv7kYV/t7jlvR8KWhnJ1juB5hcEO4j6Bx/GILbJm5Jej9ZdPFDNwV8cZPbyXEwDq8vBOBlSAcfft24FGmzzg6fcl60FS5DIHMroLvSmgy3Hp7mVij6CIgMiavm6WXnVWFXM1j7HaS8/ioDO/Czo+PWqBySD2TA0rvVZZqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931557; c=relaxed/simple;
	bh=hTY/gF3q3ciVfbQNC1FYoDaCOMQAb84VLM7UmCYem1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1DuVu11jzlufDAYsnqe6RNQI2NVu0PIxFlRC/R9jTae1z9EjIwitQW85TH26wKMpJe5mXNDAkULoafFF2wNIMoUf7D5SoZrA7xVhQkNAjLzh8urZwB6QuiuEHEhDeBBuTYciC+Ywg8lDPSX9wwYmS07Juimy0jhdjTDuNvGjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhUlFQ3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8095C4CEE7;
	Wed,  8 Oct 2025 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759931556;
	bh=hTY/gF3q3ciVfbQNC1FYoDaCOMQAb84VLM7UmCYem1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhUlFQ3A8/QIHDtLtF9ycaAe9fRtj1lFkgBtFxdOIWYTauOUtDO/KdQAOKFBgkqmA
	 7plch+05jwSlAdMPyHpqDbh0hk0dbvSCT66eoremI7h9MlcGCXnlyQeRgFp0Z4zVhh
	 wpE8pquNWx2RPS6V/SEECNXg3RGdSNQGezLTc3ZY0FGVG8Cn2IUpzN67lB4Jc774kL
	 7qtmfjoCFqJk2mXtCYoRpHY5eIsj9kZNN4N91+xV98lSWFINfmeQK6ikS+mAs13V4B
	 qbK24CuUp4IuFAy67J32459euZ/yqGQ01yGa/mLQf/13TRLdreRZXlLxh06hQC3ndF
	 FOKV47ZZ4Hk1g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 2/6] NFSD: Prevent a NULL pointer dereference in fh_getattr()
Date: Wed,  8 Oct 2025 09:52:26 -0400
Message-ID: <20251008135230.2629-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008135230.2629-1-cel@kernel.org>
References: <20251008135230.2629-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In general, fh_getattr() can be called after the target dentry has
gone negative. For a negative dentry, d_inode(p.dentry) will return
NULL. S_ISREG() will dereference that pointer.

Avoid this potential regression by using the d_is_reg() helper
instead.

Suggested-by: NeilBrown <neil@brown.name>
Fixes: d11f6cd1bb4a ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..16182936828f 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -696,10 +696,9 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
 		.mnt		= fhp->fh_export->ex_path.mnt,
 		.dentry		= fhp->fh_dentry,
 	};
-	struct inode *inode = d_inode(p.dentry);
 	u32 request_mask = STATX_BASIC_STATS;
 
-	if (S_ISREG(inode->i_mode))
+	if (d_is_reg(p.dentry))
 		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
 
 	if (fhp->fh_maxsize == NFS4_FHSIZE)
-- 
2.51.0


