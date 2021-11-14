Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0FC44FB85
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Nov 2021 21:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhKNUTB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Nov 2021 15:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231469AbhKNUTA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 14 Nov 2021 15:19:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5AA160462;
        Sun, 14 Nov 2021 20:16:05 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1] NFSD: Fix exposure in nfsd4_decode_bitmap()
Date:   Sun, 14 Nov 2021 15:16:04 -0500
Message-Id:  <163692036074.16710.5678362976688977923.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.33.1
User-Agent: StGit/1.3.dev16+g8b8350b
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; h=from:subject:message-id; bh=6PQ12RVYtNIegMl1lKCVc4HXdJsEeWk6Av8H3dYttKE=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhkW59pA9xGCSiLsUAueeBbSylQY/P2r2QrOm86H/B KrsKckqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYZFufQAKCRAzarMzb2Z/l+1fD/ 941SGsewbbC3F0QlDZ3cax73JBEtt+RbAf9rrAD4RAx6JzTkx0YmovQ9sQdIpldYkKMGu2cir/E2jt vqQB9fWRNBxLm9MtPFPQa9hYjKnO5ElsWxueeX4bYmjecbxyhMAeh0zWbcWpHwB2gbRGwEkzTv3pWD ymoQOiIAkTqMzse+ID0T9VNkqKmst8ZtYqixfyPSFxZ6liSb7YCF7JTbQDHIL6wuyS0L+OKbhUmlkj cNJNRrG/UqZVrDd6dGmKGnlPnKz9BGBf3QHSOK7lFi70FI3NigfMijTjFTp3D6EhOl8aAezKxzEKZS 21uTcCkY00lWvKuWuf+iC+y/ljYjlbR3j0sKYSX75zSpeL5uV1SpDPT9O1dLPmR0AqnwpAf6B4KNVG DIeajZfC7f1YnTaKd3M5oz6fRC/G6inm4Q9xHvehQRdyu1bBvcgmbGJxtulSOWhzPZjve0AbYeuvUh eQtFLzFi5k8YqwzsTv0rX4eDCHrmSFLY4/CY0gCvUhZeDDxsli9Szb1u3E5ZDU4Ne8W1VYsiAh1QGp TtJyhkh5vXc4dfcnMKERLwJ9fcLmqk+gdfS2wymOlM0zVMa2yIflfR2RNP5O/ZS+hR9fH8/DykLguf 9QnlbcmhRpMd6R0bA4gt5qataR5kDQ73ZJbodkeVHsUHLGyhN2MOyh4z2CJw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rtm@csail.mit.edu reports:
> nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if the RPC
> directs it to do so. This can cause nfsd4_decode_state_protect4_a()
> to write client-supplied data beyond the end of
> nfsd4_exchange_id.spo_must_allow[] when called by
> nfsd4_decode_exchange_id().

Rewrite the loops so nfsd4_decode_bitmap() cannot iterate beyond
@bmlen.

Reported by: rtm@csail.mit.edu
Fixes: d1c263a031e8 ("NFSD: Replace READ* macros in nfsd4_decode_fattr()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Hi Bruce-

This version is cleaned up slightly and has been tested as follows:

- I am not able to crash a patched server using rtm's nfsd_1
- No new FAILUREs with NFSv4.1 pynfs tests
- No new failures with xfstests on NFSv4.1 or NFSv4.2
- No new failures with the git regression suite on NFSv4.1 or NFSv4.2
- No reports of NFS4ERR_BADXDR or GARBAGE_ARGS during xfs or git regr

Hopefully that exercises enough uses of nfsd4_decode_bitmap() to be
confident that it is working properly.

I tested this on top of my XDR tracepoint series, so the line numbers
might be a little off from your current tree. However, it should
otherwise apply cleanly.

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5ff481e9c85d..479d3452ce6c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -288,11 +288,8 @@ nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen)
 	p = xdr_inline_decode(argp->xdr, count << 2);
 	if (!p)
 		return nfserr_bad_xdr;
-	i = 0;
-	while (i < count)
-		bmval[i++] = be32_to_cpup(p++);
-	while (i < bmlen)
-		bmval[i++] = 0;
+	for (i = 0; i < bmlen; i++)
+		bmval[i] = (i < count) ? be32_to_cpup(p++) : 0;
 
 	return nfs_ok;
 }

