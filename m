Return-Path: <linux-nfs+bounces-15024-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1375BC207A
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 18:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A3A19A3042
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 16:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8F02E6CBE;
	Tue,  7 Oct 2025 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGoMmPQH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA71553AA
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853059; cv=none; b=mAQf4pAjS0ryJGX3dg2SkhtRz5PFOMjRMmd2WwhVdLxKeguYgNmjYj9m+voyAQ5yFEuAFuTJLjM1RsAnPeFr+UEVHgjPWc589F/F4sM+ba7a91uQIxxv98ES+ozoMHzzRvKW6z3sTpGAEVDu/RGvJPAHLBJVHDSfKs6ep900xRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853059; c=relaxed/simple;
	bh=zQHm3MHRAL97IlUmAj5Iv/2q8sXf/iXJXGWo1sBG7a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7fskHx4sSOM651ao3rAJVgP1WSwUeWfi6VyjMN38jh8WyJK79zP/v4bM2Sy4auB2dZTqioTHUp0KazHn8U4wCQXIDhr6JS2JoTh7Z06+9rjGlhOONYt1Oet8Pr6MiXVIYvJJFfTT2Dfz5gVxVZPtdzpnCu75vrxJ+XjckCyBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGoMmPQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F24FC4CEF7;
	Tue,  7 Oct 2025 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759853058;
	bh=zQHm3MHRAL97IlUmAj5Iv/2q8sXf/iXJXGWo1sBG7a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGoMmPQHlwg2h2H9vAqMJ67e8Cuo50El+A8nqEF8ohJgeFpOR1pjxcrhtPz1xQAiU
	 zfLV5P5gqc46+SenMHNlZLxOAalL+ANsQVAXR2ifqgcD/r88NDy7/zE6RU5rzsrIlx
	 BLq1eOl43tYYvfdFycL5pAb7hKvfHFIAf09zZ0AVNTCUXZNnAOo+PUjmiHRWkE5cjt
	 BKTKRBr5hS6Gk5lPi9yv+h+46stARwHw9t/ci1ozBy7DNa8ehD22qgOyAGx+aXNVii
	 edgaUM+/fY7YjdZJ5VXCg0xxiidiid9AvG2Vo9Bnq9/Vu6Vru3/i8QBk+qPBQqWORz
	 zGZE10/G0AD0w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	rtm@csail.mit.edu
Subject: [PATCH v2 1/4] NFSD: Skip close replay processing if XDR encoding fails
Date: Tue,  7 Oct 2025 12:04:10 -0400
Message-ID: <20251007160413.4953-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007160413.4953-1-cel@kernel.org>
References: <20251007160413.4953-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The close replay logic added by commit 9411b1d4c7df ("nfsd4: cleanup
handling of nfsv4.0 closed stateid's") cannot be done if encoding
failed due to a short send buffer; there's no guarantee that the
operation encoder has actually encoded the data that is being copied
to the replay cache.

I think there are deeper problems here. Is stateid sequencing
screwed up if XDR encoding fails? Does NFSv4.1+ even need to care
about this?

Reported-by: <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/c3628d57-94ae-48cf-8c9e-49087a28cec9@oracle.com/T/#t
Fixes: 9411b1d4c7df ("nfsd4: cleanup handling of nfsv4.0 closed stateid's")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 230bf53e39f7..85b773a65670 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5937,8 +5937,7 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 		 */
 		warn_on_nonidempotent_op(op);
 		xdr_truncate_encode(xdr, op_status_offset + XDR_UNIT);
-	}
-	if (so) {
+	} else if (so) {
 		int len = xdr->buf->len - (op_status_offset + XDR_UNIT);
 
 		so->so_replay.rp_status = op->status;
-- 
2.51.0


