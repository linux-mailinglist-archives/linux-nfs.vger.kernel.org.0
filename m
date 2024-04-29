Return-Path: <linux-nfs+bounces-3056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533DF8B5D5F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 17:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70B31F20F62
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087A85C46;
	Mon, 29 Apr 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EapE+rdM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61584FB1
	for <linux-nfs@vger.kernel.org>; Mon, 29 Apr 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403818; cv=none; b=arRNjYPvyesT0dlZqWAd+Yjk8Z4+2DkexCZLh4BOh21Y11OcEmlDVgr7b6VH3vNeOMkErpcn/piQm4DMcYh9KgAOdCUsPcL1iBftePepe7wBu56A3ozW8PrSxNStnOozudUdSOW9N4EACJ2ppCwDyCFXAe9LC5/8wmGfcSLILL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403818; c=relaxed/simple;
	bh=hVDtiqkUVpBr0M36QAEcmy3ez9j1sFFjPq1SVVBzGWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrHsvczDuQs6pmQMtnpfy1YI8y6sQ4dA8HHDx7IByBlKn+ZBTfL6YiALVWJoFSoPE6OtJpisXUZhoXSNeNMTaQE8qaHeXjxpCeNfQz0375vtN1jauncxB6EyD4VoIB8OsqChUjTLi32i3ZsSeJHyaTfyqTKGLV7z2y9sV79rAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EapE+rdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCF2C116B1;
	Mon, 29 Apr 2024 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714403817;
	bh=hVDtiqkUVpBr0M36QAEcmy3ez9j1sFFjPq1SVVBzGWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EapE+rdMUOoUALv30emr2Pb+nKSh7VRDTKg8EaSFwPkH7va+CcoJ9LywRaZTTv9WL
	 5izoJykaUeTYM+Hm9d4UxgN6TD01CvLBjDMSwDdMyAVf4JqQ4CsqBbRbwo8f/a1EzL
	 xg+3m4micGDc5jXpqNkqD7zWbjpcymiUbSMhvLbSKHVFlTIfHXX/hKHjPzsss5FV4H
	 FGJbzTzDDCtbUY7sgcrCBU4cl+7vPtUxKXYe3NhT0uKk69PV9gaBF8+0nOaBYbcktg
	 WvMelqpqRl5uN69K96GbdwIcMk8MqmY/vg9yz7HOzcA8ACQk4zvZ/u+LV0u9cYk/0b
	 MZmsSf81KzNXQ==
From: cel@kernel.org
To: Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <dai.ngo@oracle.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/4] NFS: Refactor trace_nfs4_offload_cancel
Date: Mon, 29 Apr 2024 11:16:35 -0400
Message-ID: <20240429151632.212571-8-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151632.212571-6-cel@kernel.org>
References: <20240429151632.212571-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=chuck.lever@oracle.com; h=from:subject; bh=PFexzvVQS3P5KVYhC39j1YlMZNK/I7/rZcc+TZfynw8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmL7nWwxjwe14PepKfrata+QZ9OHOo8+Bc/RRyf GIlH+wGOWOJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZi+51gAKCRAzarMzb2Z/ l2qdEACveY5i5wFKeUMScJfgh9Y4q0ZZi1yGhXBS3Pvn1WvtPR5ek9sCWNTVeqTHWIxCWjlXbny lJqNAGHwGFKKXrwtPIctBi6LPNuJlsyTiyZiCI8ujYdcj333zkyEINkLIoEEBXimmkcE/VbgYUZ /I5HshExfMgQ5HZbh8mRcZygWKT2Zbk5GyrnlJoDPY37ql4GGdG77vBKqbnbvRrblaAT4q3ic2M jryLwM1OPeMqKFjdKa80Ka1gitIii3aSr+bHIl4MMulYOkq+54eSMrog54WJ7Jqg7FYFHNA5OII qqEx+lXoXj5qHliL7ayT0sDWpdBmK9Ac/tWoIOTG0jKciYlpptV2Qkl5Oz0AznENYtOSyWN56tz 3hz9WNw4EZVkC/pcbRbGqwBnc5UR54mr+rsMUoyW2LpB72klYg+MRDJ1WhXjaqXaN0V8DYMG7ku ds8ArPTpAfxr8T72+Xuiu7VEc14JmsI0goGy89eEM/8Di8vXST1Z+/OVfYcmauj/EUlu9emVTkb BU6ttT47fud8jPHMDWCggIi3pOUEOf3auuDVR1JTIOUzVo7J0ba1GH5upyGJmkKaLCF168gkpyJ PnG+sJ01SBh/3+SbPqryeGlv8AvJcqAtcDTJma9T1W0kgy7ulJTBRdjFNhBP/8zQDK90ouh6uMZ f5WnZpOyLdVeBQQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I'm about to add a trace_nfs4_offload_status trace point that looks
just like this one, so promote trace_nfs4_offload_cancel to a trace
class. A subsequent patch adds the new trace_nfs4_offload_status
tracepoint.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4trace.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 10985a4b8259..8f32dbf9c91d 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2524,7 +2524,7 @@ TRACE_EVENT(nfs4_copy_notify,
 		)
 );
 
-TRACE_EVENT(nfs4_offload_cancel,
+DECLARE_EVENT_CLASS(nfs4_offload_class,
 		TP_PROTO(
 			const struct nfs42_offload_status_args *args,
 			int error
@@ -2556,6 +2556,14 @@ TRACE_EVENT(nfs4_offload_cancel,
 			__entry->stateid_seq, __entry->stateid_hash
 		)
 );
+#define DEFINE_NFS4_OFFLOAD_EVENT(name) \
+	DEFINE_EVENT(nfs4_offload_class, name,  \
+			TP_PROTO( \
+				const struct nfs42_offload_status_args *args, \
+				int error \
+			), \
+			TP_ARGS(args, error))
+DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_cancel);
 
 DECLARE_EVENT_CLASS(nfs4_xattr_event,
 		TP_PROTO(
-- 
2.44.0


