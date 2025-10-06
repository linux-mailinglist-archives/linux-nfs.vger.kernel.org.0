Return-Path: <linux-nfs+bounces-14999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB15BBF033
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 20:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECA13BBCAF
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 18:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976882D5926;
	Mon,  6 Oct 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQEL76zj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECE24A051
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776308; cv=none; b=sFZUEnK20kK3g5a/SEfiy7wIPfJHcZLDSNaYwoRqTvmNFVjaYYBc3qJuKt2rD7JoAF0czfBI8+XRmO7u1iAGrqKZBYFYaXYEJ28f8sffu3pvzbdh1l5Zpilbk1rYkorWBK2jxOuzaFpYhQNTcXFDssnUWFLspbk1KTW++LWZNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776308; c=relaxed/simple;
	bh=CG+fumGFv61wImtNKke6QtuwTOvfEH2cJ5awie9OhWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=casXPM9Knj0Qt1kOrzevKtMmgeNsX1Fn5gLA/Xamotor4xo3RIW4g3vS8XI7iWDwQyRfo2HGQJb7vp2fV60sf//2KvhPOl1enKZ99Z4uF1QX5M1ASbzDWlr3hmaaVLxUvUAxqJ5r9T+ohYz4BV3lj8wX6jJWYbQvszSjH7MweUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQEL76zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4643DC4CEF5;
	Mon,  6 Oct 2025 18:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759776308;
	bh=CG+fumGFv61wImtNKke6QtuwTOvfEH2cJ5awie9OhWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQEL76zjWKFKstYzI6t2EHKATieHO6CuEEfO+ZUzekl3Eq4BSAaaUtxszWzXnYhOC
	 5XhVc7HH/DuAEQImUSKwhpo/DF01wHxBh7Dn5m3/5U2WtJuq0RIIzW7jpI1Z1GLpNc
	 jHwyrIbaOhpvkTI/1BsngvsaEjbR3oybP9rRcdy6+18tS2PO34rNH17YH6b+Q3LUp8
	 lptoRVjIy19tObBeBdvRHdJBG7wJWTFrXE59rwaF6tH8kS3GiNzj1dBh6aBVoJ55IL
	 EW0Rdprl24phFNXNh2GYeLOqZjSBQ6cQvdJICXskjYCp8xFmWw5EgNngVyAA7VWJWU
	 z0THvP/5SsfpQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	rtm@csail.mit.edu
Subject: [PATCH v1 2/2] NFSD: Skip close replay processing if XDR encoding fails
Date: Mon,  6 Oct 2025 14:45:02 -0400
Message-ID: <20251006184502.1414-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006184502.1414-1-cel@kernel.org>
References: <20251006184502.1414-1-cel@kernel.org>
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


