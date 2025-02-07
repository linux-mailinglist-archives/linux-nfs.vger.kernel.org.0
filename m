Return-Path: <linux-nfs+bounces-9955-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B080DA2D019
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 22:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8647A2C5E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CC31DA614;
	Fri,  7 Feb 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHujIiPb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9031D958E;
	Fri,  7 Feb 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965254; cv=none; b=p/9AbNoIr+gLdNfsdGsCtLbVVyirDfKjvAHE6hWaDEBO32U2UDcsE12+PXCxI43RjLioR4JMV6C5Y5i2mNidk0naeCsEWOACfVaaoyVqdvwfJApoMaiL/rpB+MokDVURA43b8WABvjWVMPGLJJB+A0hnYkzhZ+2h3zPVpHvRb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965254; c=relaxed/simple;
	bh=WkackGrGMoGLipWj2QIgI9MXLbcBGVQWZmAGTjaaZQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZSawVUmIfGImJ8BhU7X8FmCI0lyCdm3/gxDfm27EwczFX8TAOS0gY7r6lDslTHfNXjvBY2FOemhuHtWKdBmXajEs/Y2JoZQlRqnybsnlwfHmYVZFRae8e4bFv2N0MBIzFIJJZoo0dBBzf/kWxFlFct0TW9c21ATl2CM5J4wU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHujIiPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECA3C4CEE8;
	Fri,  7 Feb 2025 21:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965254;
	bh=WkackGrGMoGLipWj2QIgI9MXLbcBGVQWZmAGTjaaZQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QHujIiPbcuNJ2QxIbFwkLMY+EfhNTOkjo6rTkfzK86kUYUIiIcEGH1du2b8FhQ2av
	 +zA/pXks6xmme+d25+8bqS1s4gi05jqf3Zc+H0rdJp4cbTzL4YJcfJQJgEkvq58uWn
	 UDa6lrcFDAul02lQgOgPQCd+5kK0nlt9/sXIF46iCCEab1yf2nGr/SHPYefTfJxLfF
	 18x+m6wGUtKDbdGy1aZq/Zd6IyyhWYidWmoUK5Uq1SQxB0+qaqy5ZYE1Zrk1SNsn+U
	 O7QqzLHXeRbK93yJQ9tHQa+84u2DQ9LAU8x6FDAcrcAV1O2BWhdzqGKdB5tPqK6OsM
	 4Ce0TA5Kx/+iw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 07 Feb 2025 16:53:51 -0500
Subject: [PATCH v5 4/7] nfsd: when CB_SEQUENCE gets ESERVERFAULT don't
 increment seq_nr
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-nfsd-6-14-v5-4-f3b54fb60dc0@kernel.org>
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
In-Reply-To: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WkackGrGMoGLipWj2QIgI9MXLbcBGVQWZmAGTjaaZQQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpoEA88xU7j4Uhr2L7Aowh25dW6s6jKoMbj6pp
 CEdNjJjEqmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6aBAAAKCRAADmhBGVaC
 FeRiEAC+OGcli75lZBFUjeT3161+StQze9nUSaz5mZE3H6enKR6pJv5VZXOTEvLBXbYwyMvogzr
 8RO1PzczpSf0lqjqBnkHQI2PT0RJjSdbVcuGJOgpEjafcxt9pxSksknSTC46Sh3Z5YH0Yeh9a4h
 p0n5608nUb68iIGuGlymvrXbJJXVVfWteO/MXO9KhC7nORU9x3zAUm4G3+o9NveHrzEsLEv+3ay
 ibxbqUjjTdd1zJhQEeTzlWZUSTcKF8W88VzZq/tZRB10aYjZBbumAAaAQrNx52DuMF6R6OlKxie
 s/88N9PrQ3+fgjPblJmHMkd5j97FrkTPvUnyj1KCs4KnnhTYzKZDUwaKXUfFtPlME9+6RRFpA4s
 rQhJT0T4mqUwOQ9k1agic+kdX97JLW+2B1/lYBqa4sTtXBUXgLFyDo7XniE1PlcmsmFa5EyMpWL
 +2kYq18alTQuKBsvZ9xi5YAp2zTfd+wDfwWxIeEEgPZmE/x0+/pdmXVslnp+WLsrWjxvnM/qSCi
 eLza1RCTxjukDcHuFwokaKsS4CJ60epG20uTpqwwGLXNkr72IxAY40kC5ogEJDxbDN3RLGRxhVO
 5A6bh7WKaGGY6YfHxJ6u18s6nIILoylez51U0WUV53BYI8kkWEzwv2zPX2DNSH9AEMNNSNr+aoa
 yOaIgjEj5XelDrQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

ESERVERFAULT means that the server sent a successful and legitimate
reply, but the session info didn't match what was expected. Don't
increment the seq_nr in that case.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1e601075fac02bd5f01ff89d9252ab23d08c4fd9..d307ca1771bd1eca8f60b62a74170e71e5acf144 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1369,7 +1369,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		ret = true;
 		break;
 	case -ESERVERFAULT:
-		++session->se_cb_seq_nr[cb->cb_held_slot];
+		/*
+		 * Call succeeded, but CB_SEQUENCE reply failed sanity checks.
+		 * The client has gone insane. Mark the BC faulty, since there
+		 * isn't much else we can do.
+		 */
 		nfsd4_mark_cb_fault(cb->cb_clp);
 		break;
 	case 1:

-- 
2.48.1


