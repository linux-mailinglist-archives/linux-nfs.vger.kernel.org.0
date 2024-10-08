Return-Path: <linux-nfs+bounces-6937-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58CD995099
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 15:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486C4283E9F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126CF1DF25D;
	Tue,  8 Oct 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgb/kUVz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F913959D
	for <linux-nfs@vger.kernel.org>; Tue,  8 Oct 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395267; cv=none; b=Pssj+xD5JbkT5Ds7vj5D2ArTBDgYJ/z8DVahU9PNxriVOyAftdy89AsWj0WvQBLamfAkMrsa20awizkGJ3BgzfD1D4O1qAYJZrNaE2mbfwvxrIPGPltaKaEKb3a9GeQLPuNsz4xu0EZseCbSJUte8uF96hCrEdD1r4pI5pgrEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395267; c=relaxed/simple;
	bh=mTuGx4SVXiwdAajUEXjZTtwIyz4nkfEwR1uOqVPMuCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aalz7SBBUJy/b2ITzdCN3KUEvot4sWVgKNjs4DUHurbmw6CoRcmijEkJ2khRuSIDiddKLYnvt27tqYwYthC5Qqykmg3GBRmBlH6Heqs0VzE0qFnYTvnA8YEnnMFbIDCrHZPUv41mGAKzrL6s1mi8WHjN3m6eiyxAe5CuO2elFEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgb/kUVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E99C4CEC7;
	Tue,  8 Oct 2024 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728395265;
	bh=mTuGx4SVXiwdAajUEXjZTtwIyz4nkfEwR1uOqVPMuCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jgb/kUVzwMJEBLjOkqbQL/DBXvwrpJJdNjiFS9+oAK+4Z+twyWCYNtheONK5sjWCU
	 cAPCwfqlcttGZcRHfpNhJ3uvuRI5+Cosx4Lw4YJMkm0/5joDU3bUUhvWGPRosnyq99
	 J6KddWt+l0hzi5oQV0IW47DKAhCjqgAEihXxKmP4dNb7idI9LKjvcAIgvpeDWJNYRH
	 31aKZACCEXWM7OkZOvCaX2MRE7iD4arua6t9Hc1IJeaBwSvlT6n5KxxXx5/D6M2Ld2
	 tXfZQAGUttm0ezy8rl5x+AaOgeK+ZKD4fI5k0l3lE83zGjRvRT3d7J1xltAxqoMJTN
	 C/92vQv8t2sbQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 9/9] NFS: Refactor trace_nfs4_offload_cancel
Date: Tue,  8 Oct 2024 09:47:28 -0400
Message-ID: <20241008134719.116825-20-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008134719.116825-11-cel@kernel.org>
References: <20241008134719.116825-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772; i=chuck.lever@oracle.com; h=from:subject; bh=IaGhxkPgZ+sQTuTFNMR0JSleOsMlw4QR5wI39oikoOs=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBTfzpQmb6HEtYmELUH9elKb7GPIoET1mkTsdw yN2KJkGdV2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwU38wAKCRAzarMzb2Z/ l1nGD/4k9s+d7eWx8m1eBDB8lycftq2Kvm0yaiLjCpSmOq0eT0lw7v0LBx4QAWZzfC4QzZhK3SL +1JUUxE0mJ56w/yodviejjp3TFcV21XTTYH/pGzFHjneqhh15qDFS7odowVBCAvxkLP1toe9i99 kIZMCYbVOeMPr9VQ5xSUcUtHFkyGRrCoRHKVsOuwBLMg4CuoB5iC89ukR+XrQC1XmJQik3q2+/e D7B77CbaYEzhWhHbiZOWNVGTyCcjuP+hlmMEPNi+V55OV7sNTToumphNkMnr8mmIFKDoAuAGiiw nNHJoKekQq/QG911bMPRP/aWIAnu1lA0RfO6x3r3D6i6/YRU6WSya8AXjtnyeFG0CVif7dwTtZr VoE2BocKeFkqOQ8jdyabNYuumijXfbnjnPWHnUUCGlTVIWHadPLC2pD5tf7MJU4GaD8k1dWR/V5 jK9gF6WtlWud5lANqX0wUmRYc9R9oTJfxfF8wHu9Fb3ZZN7j8eH2fMYi5XuRV9JI9avjYhdiz1f oGfrbq789mDy75NbPL/i7yssuzCv2SemalVhOefVuSW12m2MJ0mLdvw/BPEk3tt+lKXlCQ0iZuD GPUIUPyedg66c208NwVsaV9XHMEHbzcjYESESMt0MhReuHAuxbvBRlE4zC1+Y8xNElRqBZxh497 jHkfGY2Tf4uiCBg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add a trace_nfs4_offload_status trace point that looks just like
trace_nfs4_offload_cancel. Promote that event to an event class to
avoid duplicating code.

An alternative approach would be to expand trace_nfs4_offload_status
to report more of the actual OFFLOAD_STATUS result.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs42proc.c |  2 ++
 fs/nfs/nfs4trace.h | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index fc4f64750dc5..969293bf8228 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -630,6 +630,8 @@ static void nfs42_offload_status_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs42_offload_data *data = calldata;
 
+	trace_nfs4_offload_status(&data->args, task->tk_status);
+
 	if (!nfs4_sequence_done(task, &data->res.osr_seq_res))
 		return;
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 22c973316f0b..bc67fe6801b1 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2608,7 +2608,7 @@ TRACE_EVENT(nfs4_copy_notify,
 		)
 );
 
-TRACE_EVENT(nfs4_offload_cancel,
+DECLARE_EVENT_CLASS(nfs4_offload_class,
 		TP_PROTO(
 			const struct nfs42_offload_status_args *args,
 			int error
@@ -2640,6 +2640,15 @@ TRACE_EVENT(nfs4_offload_cancel,
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
+DEFINE_NFS4_OFFLOAD_EVENT(nfs4_offload_status);
 
 DECLARE_EVENT_CLASS(nfs4_xattr_event,
 		TP_PROTO(
-- 
2.46.2


