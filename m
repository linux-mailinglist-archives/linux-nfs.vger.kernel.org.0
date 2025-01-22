Return-Path: <linux-nfs+bounces-9470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E8FA194BD
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 16:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBABF1626A8
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473B12144D7;
	Wed, 22 Jan 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVzSo/hc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5262144D3;
	Wed, 22 Jan 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558618; cv=none; b=OpF+UlLalZn9Xjf3eDgzAYn9aazsnVKF6brswF/euLJ+ydPhzq+3nPE2JLNN+A5lVGDc2OaRLH0bVIdgKRwPvW55khw6K1cm+63KpE2qmn47ByXsgUSXG/cLfjjK9Vu+N28KHHOYXWiL2JPiPwez/S7IIYf3jIbuCq3R1Q4E/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558618; c=relaxed/simple;
	bh=01VNuo9sCy2OZ1EzRUtaPQ5zp/Wo1uknGrkWQLqPatI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LjclNM/cwJEn1SPpwLKXv+jymR9336+iX5jHr4zlJXENzUAAuRXuo52Yr9OvlMzBFQOcIqDJXpJx2LfpMdmB3XmQ0HNM9qub/vO+cFDzmgOwaLodi2zbLsPvuGRw8d/Nh0oM868vvnGZUqIPnVD2PCBdNfI/HA2VRI/ejLVu9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVzSo/hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C722EC4CED6;
	Wed, 22 Jan 2025 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737558617;
	bh=01VNuo9sCy2OZ1EzRUtaPQ5zp/Wo1uknGrkWQLqPatI=;
	h=From:Date:Subject:To:Cc:From;
	b=ZVzSo/hcOHygA2cZXUKUVxXEvMta3M+ElHHFr3JeYIYTXoH4sPnGmpWllzCuwRr4B
	 9g9DFBDUfvMDpqrNkjsHTHYHFvEuvWTfkxSiinmX6b8A4iAOwe53pdEInsE9I9DpG1
	 RShh/V3ep0w0T2vLfXKjsEe8hwLjKWbesqZ6cX6I3VoS2xDpBXpart5U+/CxhscVhg
	 mOdHw9Q7usxgX1hgDucRP7XIMpWz/MGgvnR4JyVRBFJNqLcBV8+uet9Vc42wuyYkp/
	 f11XfJSmmnMKQ2VAD+W0N/5T6M+9WA9tLWMhP0nUqjTcSKGZQIqxu33Jv2v40dCDGR
	 VnUuwuwSgPzLA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 22 Jan 2025 10:10:02 -0500
Subject: [PATCH] nfsd: always handle RPC_SIGNALLED earlier in
 nfsd4_cb_sequence_done()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-nfsd-6-14-v1-1-6e1fb49ac545@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEkKkWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyMj3by04hRdM11DE11z82TDxBTTFMs0A0MloPqCotS0zAqwWdGxtbU
 ASBDKQ1sAAAA=
X-Change-ID: 20250122-nfsd-6-14-77c1ad5d9f01
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2838; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=01VNuo9sCy2OZ1EzRUtaPQ5zp/Wo1uknGrkWQLqPatI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkQpSET7Z2r/gMzvWeZImmoTi9PrYpC2rUGC+Z
 r1Fbv8C3tSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5EKUgAKCRAADmhBGVaC
 FVpbD/4nVVB1GqMCVpzE4LARmGrDO7dqlHLj/qd3sHtQote5CqOSwfIgPJhAMbjifKmahG7QhZK
 I39FUCPYCUlWabpUbYVYqCzh68xk0QdOztAyuQR9rIfefcnEzbPQyZDxthe0ttqQHtjv1WDJsd5
 UBmmyONhdJDw2E2Xr6gh410T1tZbuqUMa/JJySUcbmsTMVRL+Bh0cvfOoTTntfS04zyMulOFLjW
 k2QkdT8JXi2ciK+JlVtWND4LzQF7NM38/VxtccKF2+f08OGlHW/38dJ4W2riQ8hTKJKZ4vnGZHc
 h9j/Ly3YqZsLhPIg0NNzFfb2xYtVD5IgOQLTsuRDjFZ6rorDqgVo4IUa3GfPDuKEEGSAkQNYOyB
 eDB7IJJZoRWRpsg5UCROJuKZ87MpbjdkgyxvlHihlLu0YEmoY6LWWsO+kUPBmPJ9eoBC60RLL9j
 rUgWSHT3E96Qcz4phhntLv+q1ZsLYBzTjhOf3P6IoS3HdlfnI6/+AL59kftnKiVwmLmwsYZcUho
 krH3SK+LXMMeuzI/uvd9Cp4eg7TER6D+b2qwwfkfHBXIc+1hIILoY5tKuCt8f/QoCkNjxuI7J9i
 +/z+iUK0DALC2/ord68vyPklZ3Pv/OZ5X9eDpJaW3lpQNK2wJnMMva7OYHrzdcIu56uKMacLUpr
 aQr4XFuUsitOjuA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The v4.0 client always restarts the callback when the connection is shut
down (which is indicated by RPC_SIGNALLED()). The RPC is then requeued
and the result eventually should complete (or be aborted).

The v4.1 code instead processes the result and only later decides to
restart the call. Even more problematic is the fact that it releases the
slot beforehand. The restarted call may get a new slot, which would
could break DRC handling.

Change nfsd4_cb_sequence_done() such that RPC_SIGNALLED() is handled the
same way irrespective of the minorversion. Check it early, before
processing the CB_SEQUENCE result, and immediately restart the call.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 50e468bdb8d4838b5217346dcc2bd0fec1765c1a..05afdf94c6478c7d698b059fa33dd9e7af49b91e 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1334,21 +1334,24 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	struct nfsd4_session *session = clp->cl_cb_session;
 	bool ret = true;
 
-	if (!clp->cl_minorversion) {
-		/*
-		 * If the backchannel connection was shut down while this
-		 * task was queued, we need to resubmit it after setting up
-		 * a new backchannel connection.
-		 *
-		 * Note that if we lost our callback connection permanently
-		 * the submission code will error out, so we don't need to
-		 * handle that case here.
-		 */
-		if (RPC_SIGNALLED(task))
-			goto need_restart;
+	/*
+	 * If the backchannel connection was shut down while this
+	 * task was queued, resubmit it after setting up a new backchannel
+	 * connection.
+	 *
+	 * If the backchannel connection is permanently lost, the submission
+	 * code will error out, so there is no need to handle that case here.
+	 *
+	 * For the v4.1+ case, do this without releasing the slot or doing
+	 * any further processing. It's possible that the restarted call will
+	 * be a retransmission of an earlier call to the server and that will
+	 * help ensure that the DRC works correctly.
+	 */
+	if (RPC_SIGNALLED(task))
+		goto need_restart;
 
+	if (!clp->cl_minorversion)
 		return true;
-	}
 
 	if (cb->cb_held_slot < 0)
 		goto need_restart;
@@ -1403,9 +1406,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	}
 	trace_nfsd_cb_free_slot(task, cb);
 	nfsd41_cb_release_slot(cb);
-
-	if (RPC_SIGNALLED(task))
-		goto need_restart;
 out:
 	return ret;
 retry_nowait:

---
base-commit: a8acd0de47f22619d62d548b86bcfc9a4de2b2c6
change-id: 20250122-nfsd-6-14-77c1ad5d9f01

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


