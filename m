Return-Path: <linux-nfs+bounces-1018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237AE82A03A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 19:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65521F24280
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jan 2024 18:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0C4D58A;
	Wed, 10 Jan 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv2uk/5I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94154D580;
	Wed, 10 Jan 2024 18:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2B2C43390;
	Wed, 10 Jan 2024 18:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704911258;
	bh=+SelCmVb8KGUBbLTDiox9JoF5IguEGEVwjz0JhZCWv4=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=Bv2uk/5I6WjKA1yBu2Lq9ck0Azh6NtsxYIYO8cmDnLg4WSRr9r/CV2wx4QaEV12mk
	 KNERQRsAoq6/6jgvqub1nwYvwAJ37u4Ayhufsa4pp3ODFpY/tZnKyITg2wO35PoeUV
	 PEEusjt1kg/EZ24uJutr1/JWwxo8QGmEEUo0ewbIE7weP5dytBYVKE2FRMyIs75rvq
	 V6onwOKLaNwtTCb1dFAWCbq29qU+KufY6XqhYhjp5yu/kMXlCWuWLUuIFTSZaht977
	 JOaewqa0bjDwlsoE8T8+nckLzOPi45mHk+hMmlea3iuemH1SFmv1D80FXqs5cHd7IU
	 Bklj4kHpOzM7A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 10 Jan 2024 13:27:27 -0500
Subject: [PATCH fstests 1/2] generic/465: don't run it on NFS
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240110-fixes-v1-1-69f5ddd95656@kernel.org>
References: <20240110-fixes-v1-0-69f5ddd95656@kernel.org>
In-Reply-To: <20240110-fixes-v1-0-69f5ddd95656@kernel.org>
To: Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, Yongcheng Yang <yoyang@redhat.com>, 
 linux-nfs@vger.kernel.org, fstests@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+SelCmVb8KGUBbLTDiox9JoF5IguEGEVwjz0JhZCWv4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlnuGYCLikuHkgBnkLJRlXkTny9neRBxpM6c2gF
 fT+iEQGq8+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZZ7hmAAKCRAADmhBGVaC
 FRqtD/0Ueu8hyqAusMYHOqGN+Ac9GZadZJRaWealXF9uanZZK3bN/5u+6rUZ/uJ/4SlVYCAjNFD
 EMqFFKpPscyMHt9MzF5IfssSpypq7BVK9ZYgLvkf1Wm3HbQtvGZwlq0MsAuvr2VyDpbAJiQ6mhU
 968kd5waJl/f9SGy9B5mhIb8tAJ55A+vCYPaSgxNFUeWOKjzFA5Nj0Tr6Oe43j6ZWxD6nDYwBrW
 V2nFJlK+nvjAmWS+jOqEA3EPdd79uN3uPrNu9bG4emBeJO6g1Yw6FBh4Orfq18wkPaU9Hx4I1Kh
 tJDsAn2mqikZJgBOTfI1jOHALZjwu0FJ+TLFH8TewgBhsMkmaWCxQTGa7I+cB8+kooWOZTcp8xk
 dzfxe3RpkIbVVOsQz1dnCfb9tTWlXcTLD84/2unEHmuWdscc0A1wwpM/ht3BpuephJ03JIoZJ5h
 IklfDYqwCEGc69UQvXA9IMQODoc/ejE2WyCvsjAbYjv/DOit/KHaoLSHg7hS355xcMA+yOpTzNg
 xnhBxdJdItiMFFr9KUE4lUToEdcKm2QMlv4kSk5vnxql53tn2c91TJs+y0OMhI7K6TJnCe/IaG6
 bz3cYOynbN9RkhHXWhefXtufHR4+NOftIYcRxqC8lTYtqieSAfqemsnvmVoSRLQG57zq5XTp+2Y
 OVFoNFGAHZSL9KA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This test kicks off a thread that issues a read against a file, while
writing to the file in 1M chunks. It expects that the reader will see
either the written data or a short read.

NFS allows DIO reads and writes to run in parallel. That means that it's
possible for them to race and the reader to see NULLs in the file if
things get reordered.

Just skip this test on NFS, since we can't guarantee that it will
reliably pass.

Cc: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/linux-nfs/2f7f6d4490ac08013ef78481ff5c7840f41b1bb4.camel@kernel.org/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/465 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/465 b/tests/generic/465
index 73fdfb5548af..0745d6a1dd3a 100755
--- a/tests/generic/465
+++ b/tests/generic/465
@@ -21,7 +21,7 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
-_supported_fs generic
+_supported_fs ^nfs
 
 _require_aiodio aio-dio-append-write-read-race
 _require_test_program "feature"

-- 
2.43.0


