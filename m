Return-Path: <linux-nfs+bounces-7596-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 864749B7BDA
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 14:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC831F21B8E
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E3519DFA7;
	Thu, 31 Oct 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAkCpXdF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7F13D886
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382012; cv=none; b=aywpUG7YcUwG2MzSw0PnTtPThQtc3tFqorON1OB35Uj7ocvsNf7gaKQ7mvav+fMRcjiwbGiD9cFPyaV9lS/qee0nHft2HpmtBsg4VcCn01xSB6lGkMY+6Oatv9foyh7i/nVFaFHtWXr4bzOj7jfmJA4O/bwS4H4LKVbVL1oIPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382012; c=relaxed/simple;
	bh=jDPHsTqM4u1zffi9aGCCX5Y00anFzQ8z+399eg6DlSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9J1R7+WSO5WtFIk10YBOZ476VGRKaD8oKmi0e+k41DIPab8cGqUi3CZWnOV2bU51HZqjMX+KDWxqRfind2GhfdHo3rTnSfAMNmtAsAwdyfPg74oEdrwJY9zxOmWvz71PyK8pcG+RqLal+s6gFmqcw8ia0h1LEEvqhwgDhVdZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAkCpXdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A6EC4AF0E;
	Thu, 31 Oct 2024 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730382011;
	bh=jDPHsTqM4u1zffi9aGCCX5Y00anFzQ8z+399eg6DlSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAkCpXdFxMywzeSytwkvhJ3Kv3y4Tju0ImOFhxmP+gPDDu31BV0TjHNBVkTk/9AWI
	 gCQlOIYuqjwcEXo3QCNVSFySgo5JrR0sVCUgSFbzIKG6+H4RdgFQ113qFw+u0XzV0A
	 oVQ85sJTMPwuTJyNxqLW0R5JFzYcPmNkZt/efUynvIu1n5eOqvQgQM9tiex60WoUf4
	 HneDGHAyBHxVEhKIiW1LgTPcOsb0CjaySC9CumFGxZ1bAsSaBIX5kOViGiGbpp8BtA
	 IwsbLlOmYN8RkBU5gnjWNnhXZYlqQ3v065fDJcoQFY5Fg237tE429TKa6aswEqcMK9
	 8zRhFUVSNeLYg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 1/8] NFSD: Add a tracepoint to record canceled async COPY operations
Date: Thu, 31 Oct 2024 09:40:02 -0400
Message-ID: <20241031134000.53396-11-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031134000.53396-10-cel@kernel.org>
References: <20241031134000.53396-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=chuck.lever@oracle.com; h=from:subject; bh=AKWa+nOgmQoiN8QUBVa8o/eESoN74iwZpXr9UQyrS9o=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnI4i2Psqa6CNB4Q6b4uWArfE8EzFJ9PPLVrF41 n5ox1fwJQeJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyOItgAKCRAzarMzb2Z/ ly3QEACvatI0U/AnrR7swUMns2kKoUeaNyiT2aVxLLBTBS1wjiUmfhBocVX2o5YQ5DThomwuaFB Yo2ah75vu4QPKU5HIcfhcCSSZJ24Rc8RVoP7mk0vKNdyxfgi9ofZ2nIHfwq6lLVMnWwxxIAOLRG fpHStfxVBJaVC+ipOjFXYfdbjTcF9hfQUX7U0EB9EXpk01oW7ii9xBuf3zSAsof+cRIXbzfPGkT 4dwuD6VXgAs7PqXqCXSSybGkt8Kqlhr1Eb8D/tfT1GIk+Bew/Au+8h8rgrdER1i/Q7aJjmCeeMe Whdm0JZKcreGQQmWv+9MYGo1Q17hdgGHO5iChR9ikuj5ryXdd4NL0NHzZwm+IKfRws8GCe0iTJX RafbmgbR2BrXRIcvfhyCS/1PR9/4q/nnaRXvh2b4Nk5T02v3yT44D9cNEkSRZLD63q9crlM8zdF ZIk7/yI3Kf2SRQCBRrUVl6vUTFNPmVQi6smm6UXFx9c5J3DQiKychKXYFKmv51wvr7HQUynrbWY lXUXGKpr4aSF7JbpQ0GiCoHtvKhzRWEjwDqhgOzbwcV90U5ryrn0FtNJSCMCWqJWFpSHHCVekBE ccnHUomx0kUvjtVsyg8WoldFIfnR//od9D0+Mxww/+quVyu3Mj0hPi8xtKtALUrRKmww837DYZZ 4O48qGj9cIeUurg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |  1 +
 fs/nfsd/trace.h    | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d32f2dfd148f..9f6617fa5412 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1287,6 +1287,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 
 static void nfsd4_stop_copy(struct nfsd4_copy *copy)
 {
+	trace_nfsd_copy_async_cancel(copy);
 	if (!test_and_set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags))
 		kthread_stop(copy->copy_task);
 	nfs4_put_copy(copy);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b8470d4cbe99..acbc7f37cdc5 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2232,7 +2232,7 @@ TRACE_EVENT(nfsd_copy_done,
 	)
 );
 
-TRACE_EVENT(nfsd_copy_async_done,
+DECLARE_EVENT_CLASS(nfsd_copy_async_done_class,
 	TP_PROTO(
 		const struct nfsd4_copy *copy
 	),
@@ -2301,6 +2301,15 @@ TRACE_EVENT(nfsd_copy_async_done,
 	)
 );
 
+#define DEFINE_COPY_ASYNC_DONE_EVENT(name)		\
+DEFINE_EVENT(nfsd_copy_async_done_class,		\
+	nfsd_copy_async_##name,				\
+	TP_PROTO(const struct nfsd4_copy *copy),	\
+	TP_ARGS(copy))
+
+DEFINE_COPY_ASYNC_DONE_EVENT(done);
+DEFINE_COPY_ASYNC_DONE_EVENT(cancel);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.47.0


