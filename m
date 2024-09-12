Return-Path: <linux-nfs+bounces-6430-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C5D97748F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 00:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BE8285F35
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 22:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45CE1C245A;
	Thu, 12 Sep 2024 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tos/uB5y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866E1A3020;
	Thu, 12 Sep 2024 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181624; cv=none; b=N0YUuX0sSAWzqcr6lviB+Qmr6xOiM6p2DHOadZq0mtnKUjurch09oYMSrXTBJLqnLvTfPNNDd6fX0+SAu1QKr38xj2voVZW6aSwA7eMZgZAVkL2nnMtDjdx4Wr42iWezONNWh27wi/Zi1M1ZgyDXDjFXvZ3hP/7JYIYS1z6tUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181624; c=relaxed/simple;
	bh=zdsGZy9kgbEI3Q5/TXUAM8lqaaji8u2K+l2wok8Srd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lixmVAf3RiqU3uGThwmzub7K+h6WDP6QcGLQpl/hNysfywMJV9biyDbdyYg8NZoEZkKkTSFqJfEzB8NnKaNrc1E/d80PbdjjqwlmqbFOpZsogi8rI9u2Hoq7jK9Yznoiik8JXki0qDuBn1ZSgCh9tzQYeJu1epfjtdolLxIzOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tos/uB5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5ACC4CEC3;
	Thu, 12 Sep 2024 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726181624;
	bh=zdsGZy9kgbEI3Q5/TXUAM8lqaaji8u2K+l2wok8Srd0=;
	h=From:To:Cc:Subject:Date:From;
	b=tos/uB5ywQE2viX9ViRtznZ4nfDI0i24i99uDckZXYUUTQVAYcwRc6LhmxXNh9Hfs
	 bXB3RS5WZuGssxw3Gu45MQq7nqr66eUVGRcUSZXiD85UU5JF6NlA3sZQ5WMUijKp7G
	 rD1l69Yylp/gtNpIPONVgpUYCCJNwNrvg+xeqobWFctuwu2oN66ABJCYHhHTvggUWY
	 FZCrD9h12p2m12846nQvIcOIMgg7t7BCZyGODJs6+2hGTlP0RjGq2gETPYjLKk/v4u
	 Fr/hz8oPjXKKnFXrZqOXZFu05u8A5qAQGe2Q6E4J8yB9hEtdsTu3B1sgKj3DmFHLrG
	 t6+FmcR0xxyfA==
Received: by pali.im (Postfix)
	id 123805E9; Fri, 13 Sep 2024 00:53:40 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lockd: Fix comment about NLMv3 backwards compatibility
Date: Fri, 13 Sep 2024 00:53:20 +0200
Message-Id: <20240912225320.24178-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

NLMv2 is completely different protocol than NLMv1 and NLMv3, and in
original Sun implementation is used for RPC loopback callbacks from statd
to lockd services. Linux does not use nor does not implement NLMv2.

Hence, NLMv3 is not backward compatible with NLMv2. But NLMv3 is backward
compatible with NLMv1. Fix comment.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/lockd/clntxdr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index a3e97278b997..81ffa521f945 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -3,7 +3,9 @@
  * linux/fs/lockd/clntxdr.c
  *
  * XDR functions to encode/decode NLM version 3 RPC arguments and results.
- * NLM version 3 is backwards compatible with NLM versions 1 and 2.
+ * NLM version 3 is backwards compatible with NLM version 1.
+ * NLM version 2 is different protocol used only for RPC loopback callbacks
+ * from statd to lockd and is not implemented on Linux.
  *
  * NLM client-side only.
  *
-- 
2.20.1


