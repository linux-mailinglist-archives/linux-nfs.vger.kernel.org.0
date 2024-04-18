Return-Path: <linux-nfs+bounces-2891-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4298A9C55
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Apr 2024 16:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24CF1F25FBA
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Apr 2024 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5053168AE6;
	Thu, 18 Apr 2024 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eix3wOfP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABF165FC6
	for <linux-nfs@vger.kernel.org>; Thu, 18 Apr 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449471; cv=none; b=lCo1fFrBFwYYQtcYQ2RG7SudYy21IfIYbCuWB9Roww7TVHW++SpJWYo0wlTSxxkH3s5jw6QYT/hb+CxoNaT03AaW8WBU+6vbYbKP+g201B2mcKVvDGL0e6J+dZeNad79zTctYXXLVi2QUvO5Re2v1kdZ7J/zx+kKkHPODU8qKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449471; c=relaxed/simple;
	bh=sdK8LoF87Y6JbVVOv2ODAxywOBAr2YR1jjcQyh+Gyws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K1xkdbx8hdoVUoYrRH+IYz48yGy8hNnzoqTg2dSSZo7i5LHm8BfoV315+nd4CKQV0hHk+HssAGtYQiL8d8IKtRxfK1GnBWXs87rf6bqG7r2cyPQ9uMa2mb3o9KtEQwR+v2emb4O4KUGUOvKRelX6YtY48u4omYGQZ1BjKqPE6l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eix3wOfP; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d9c78d1087so9223039f.2
        for <linux-nfs@vger.kernel.org>; Thu, 18 Apr 2024 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713449466; x=1714054266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o1GgdQA8HVFN6+//oQBM7PP7ubUlQ1+XxS+s4+bMP4w=;
        b=eix3wOfPkUsfySGMaqiBGqIYI96gO9Sy7ioRldHD1jsrXHCl5vhRPMy1NOsmP/P/LV
         ATOdu1uACmekXFm3BWwjU/KRiyzVOrjBs+6xF4aFUXJIhMHF1cdqndHRJ7oWCuH8sTxS
         29O8sAW3KWYe7Kh5Sez+SnAF3M+N6I3ZCy7A8GTp6zPSS9EckPS30pCQksKajUt06IAK
         fWB1jggFUhzgC3RFvSCOmwYEdP4eYRPObYDqMk9RxnfYYHtCIkenF73IluVOYYzF2gOT
         H+jpZ2X42WEZgIvt0dhu1SEJtMBzLcQTTuYPU3IgaiBehgilXY2Sf9qpcu8RnNyl0URy
         767Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449466; x=1714054266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1GgdQA8HVFN6+//oQBM7PP7ubUlQ1+XxS+s4+bMP4w=;
        b=rJXBaoTIRHoSLnTczf5zNdz/eeqgvco3nHavrZqn902INDPMDZ9Zx4b80lxJ9pe8zW
         MlXgaUIIiD4V8ozgJ1z5Ys6MFyicrn85oyiAiKHnw+K43BuVeg9xdUsrdh58wSVaZqSO
         IToAmdQKSL/rR3n80qa6Q51/C1aV0Ia3/+KxTWGx/lnO15HUoXd26/wGapWT1ZEWOMQ3
         GYb/w5BBssqVnWmZ66jxeM5y9mhiAxGK3XUVKtGtmf1GdmvZGtYzWws5haH1s/7Sg+PI
         rNrrEosTJlJlLJiBvkgnzwC7lX28YGCNjSP49jC8Gfo33i0iIED/gru+zajgiabIwFV4
         b2Nw==
X-Gm-Message-State: AOJu0YzJZAndXdEqPMxF/bZt1fdzFjQAGaNDJpwbQbz0D9yinhVCHGCQ
	21mAjCdzTDaF1O5WNxnHEx9sDUM9cFDnmyoIaEkaXrtsQvTHqPoJfOstgHOA
X-Google-Smtp-Source: AGHT+IFFpsjA27LDqjPV6Z4xsq5oGrdRg7/VgdNgRXX3sFBjPYd0Phoh0ohH7tQJI5Od8TwJMqRRNw==
X-Received: by 2002:a6b:7a0d:0:b0:7da:34e7:ba4f with SMTP id h13-20020a6b7a0d000000b007da34e7ba4fmr985625iom.1.1713449465748;
        Thu, 18 Apr 2024 07:11:05 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:71e8:2764:5b55:efc9])
        by smtp.gmail.com with ESMTPSA id u9-20020a05663825c900b00482c1c35826sm448485jat.10.2024.04.18.07.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:11:05 -0700 (PDT)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC: fix handling expired GSS context
Date: Thu, 18 Apr 2024 10:11:04 -0400
Message-Id: <20240418141104.95269-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

In the case where we have received a successful reply to an RPC request,
but while processing the reply the client in rpc_decode_header() finds
an expired context, the code ends up propagating the error to the caller
instead of getting a new context and retrying the request.

To give more details, in rpc_decode_header() we call rpcauth_checkverf()
will call into the gss and internally will at some point call
gss_validate() which has a check if the current’s context lifetime
expired, and it would fail. The reason for the failure gets ‘scrubbed’
and translated to EACCES so when we get back to rpc_decode_header() we
just go to “out_verifier” which for that error would get converted to
“out_garbage” (ie it’s treated as garballed reply) and the next
action is call_encode. Which (1) doesn’t reencode or re-send (not to
mention no upcall happens because context expires as that reason just
not known) and it again fails in the same decoding process. After
re-trying it 3 times the error is propagated back to the caller
(ie nfs4_write_done_cb() in the case a failing write).

To fix this, instead we need to look to the case where the server
decides that context has expired and replies with an RPC auth error.
In that case, the rpc_decode_header() goes to "out_msg_denied" in that
we return EKEYREJECTED which in call_decode() is sent to “call_reserve”
which triggers an upcalls and a re-try of the operation.

The proposed fix is in case of a failed rpc_decode_header() to check
if credentials were set to be invalid and use that as a proxy for
deciding that context has expired and then treat is same way as
receiving an auth error.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>

--- This looks like a day-0 problem and should probably be back
ported to earlier kernels.
---
 net/sunrpc/clnt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 28f3749f6dc6..f19ad55017c9 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2698,8 +2698,19 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 		goto out_msg_denied;
 
 	error = rpcauth_checkverf(task, xdr);
-	if (error)
+	if (error) {
+		struct rpc_cred *cred = task->tk_rqstp->rq_cred;
+
+		if (!test_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags)) {
+			rpcauth_invalcred(task);
+			if (!task->tk_cred_retry)
+				goto out_err;
+			task->tk_cred_retry--;
+			trace_rpc__stale_creds(task);
+			return -EKEYREJECTED;
+		}
 		goto out_verifier;
+	}
 
 	p = xdr_inline_decode(xdr, sizeof(*p));
 	if (!p)
-- 
2.39.1


