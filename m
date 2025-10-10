Return-Path: <linux-nfs+bounces-15126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FF2BCD5D4
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F18E64E674F
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC02EFDA5;
	Fri, 10 Oct 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvTb0BQw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716612F1FFE
	for <linux-nfs@vger.kernel.org>; Fri, 10 Oct 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104589; cv=none; b=oItPgJPDPBlJpi1wHRKOhtYZ0sKJv7gmuDQx6ZxQhgdmzaeYXgCr+cjCRakp4puQuE/xA7SUmRhDJudxCjrmvcORttr7b5AScgC6rCE5u3zj6bMj3lRlj95AceJ1JhM/k/x0Sa35iGoZjQEUpTKKtSIaNhWhtta43Wzms5eOg6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104589; c=relaxed/simple;
	bh=/JRwex5wgWDo2FlVwvsd8xBhlg8sSRfx9QuzhAkeFZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQmiOndV0tVhEMjIce8SzxSHWwB8EFOM6kS1d/mUSJfFkhjlsvyB9FrxgA6HRgGZlzqQOK5djiwQCWZ7UoaH3pykgRyH3kN3cv3eOXdEQ9SECd1Ofis40yMa+XFP1vUCX4+dTMQ+QtOS28AzWrlXCQQGJbf0+rRdg172Og6HEV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvTb0BQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1EAC4CEFE;
	Fri, 10 Oct 2025 13:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760104588;
	bh=/JRwex5wgWDo2FlVwvsd8xBhlg8sSRfx9QuzhAkeFZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvTb0BQwMkwwVKv+3WOPRPf4J2YDE2vyaXwh7LYQcWVJM4Aoodw4A394hH66kGHyT
	 Zv2WeUrbAdloaSsY2iag3PpyU7/EdWmi3OdsHQYainlZ+20SGssrZccUDqkRCN/WnE
	 JmOMRckfTdIoaXu/wjYA0zcewcq2whyeBUREEqFVRsmjV5bX5FdC1vanOnxQMDoFH9
	 pU8LGTaB24mOkKlQ4ALko9dIyaskfRNYp/HrVSxKstnpBhyLtaBYObNPsWSqTwtjiM
	 KClqZz25OzeTLYS6CQ+P/5gE0z88Xy89DQG/M0WsdamZH5GujuArJ4gT+cS13Mmex4
	 CP0YFfDtZyrXQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	rtm@csail.mit.edu
Subject: [PATCH v3 1/5] NFSD: Skip close replay processing if XDR encoding fails
Date: Fri, 10 Oct 2025 09:56:19 -0400
Message-ID: <20251010135623.1723-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010135623.1723-1-cel@kernel.org>
References: <20251010135623.1723-1-cel@kernel.org>
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


