Return-Path: <linux-nfs+bounces-7793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01E9C2825
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F198F28401C
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C031F1DE881;
	Fri,  8 Nov 2024 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRbvGpwa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2AD1E1C07
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109205; cv=none; b=KZBiOVCAP2jhBzOy5MbmWOoqjyeGVQ4I+otL1hnUEymERYnt8IOKQ79pEU8y/Cro+bgyKkTf2licx+jGlfr5iDsbb0i6WDzd2SENY1RCQUxxKwPR+KXqCAWdKyhXuTPnquHPfhHKJ8lLSsF1URWMPkCdiZMcLxnLKlR7vj40Fnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109205; c=relaxed/simple;
	bh=1bz1oRimYkuZRUsqEVHEp1zaBPwmKys67gE15v4tO6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhoCzVO/T8Wt+DZeFqM5Km4oCkzPbph+pC0S8RlTA2GbA0Z23dWLfMbYoc11HmzAWILuBoReKqftCP7u61ejkWD0HUjwJBmYUWPMI9lbDer+DL8lf0c6QWFekiNIFdtivUrlLjfu2ONLSQPvznb7OxHQPg7FjY/fL+xgIpFgBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRbvGpwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED79C4CED3;
	Fri,  8 Nov 2024 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109205;
	bh=1bz1oRimYkuZRUsqEVHEp1zaBPwmKys67gE15v4tO6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRbvGpwacx8wohoA0T+Xp7gmpLic873hAVVmMGhTBjvcbAJWWRWFlt8n2ObKw8fLY
	 4oWGPCprRL80uW+9pgBRklF7ME4G73ApMQ1/v2Okdhxwx7saFhfBubFezuajmJI8D7
	 JHM4hBi+Jc5Op6KSxeIwSS/tceEjFd+JW++KYvfz8Xu+w7QwsFTb/sbsKwABF3OpQL
	 p8BqPguPhuqd1v1kF4C+VIbRAIzSzDgSC8H+mSOAR0SZ8HEFmBAFKazxaPEeAfQvow
	 xWQORAx+xS5+89I8erC5elMk5CcLH9USjTAW4bjs651O5bTe+6XUq8FKnMBhRs/sYf
	 WuCzGhm2tVAlg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 01/19] nfs/localio: must clear res.replen in nfs_local_read_done
Date: Fri,  8 Nov 2024 18:39:44 -0500
Message-ID: <20241108234002.16392-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

Otherwise memory corruption can occur due to NFSv3 LOCALIO reads
leaving garbage in res.replen:
- nfs3_read_done() copies that into server->read_hdrsize; from there
  nfs3_proc_read_setup() copies it to args.replen in new requests.
- nfs3_xdr_enc_read3args() passes that to rpc_prepare_reply_pages()
  which includes it in hdrsize for xdr_init_pages, so that rq_rcv_buf
  contains a ridiculous len.
- This is copied to rq_private_buf and xs_read_stream_request()
  eventually passes the kvec to sock_recvmsg() which receives incoming
  data into entirely the wrong place.

This is easily reproduced with NFSv3 LOCALIO that is servicing reads
when it is made to pivot back to using normal RPC.  This switch back
to using normal NFSv3 with RPC can occur for a few reasons but this
issue was exposed with a test that stops and then restarts the NFSv3
server while LOCALIO is performing heavy read IO.

Fixes: 70ba381e1a43 ("nfs: add LOCALIO support")
Reported-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 8f0ce82a677e..637528e6368e 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -354,6 +354,12 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
 
 	nfs_local_pgio_done(hdr, status);
 
+	/*
+	 * Must clear replen otherwise NFSv3 data corruption will occur
+	 * if/when switching from LOCALIO back to using normal RPC.
+	 */
+	hdr->res.replen = 0;
+
 	if (hdr->res.count != hdr->args.count ||
 	    hdr->args.offset + hdr->res.count >= i_size_read(file_inode(filp)))
 		hdr->res.eof = true;
-- 
2.44.0


