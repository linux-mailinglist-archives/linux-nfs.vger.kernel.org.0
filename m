Return-Path: <linux-nfs+bounces-12454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8289FAD95E7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 22:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E32B173649
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 20:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DDA235066;
	Fri, 13 Jun 2025 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMM6Ixpe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8122DF9E
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845278; cv=none; b=Pf/JnKn1u4dUJdAsT66wfqAtWDObs1+KbYI5Qo0OfT8cPBzzpAFpDbsjvDlb1yueN4YOfqFIsDziVtwnx8eoEStptQZ7JQq66AyDRz0cAoYOALikhDX+0UIjwMBQqv+i889Nlc3DSiF2twqT7ZKgys2uVVsdNfY60h2b1dcNf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845278; c=relaxed/simple;
	bh=Qq2XImfZnpLj0zrdh6fum6am1oTUWVV5DQeDc42T/T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tfc1tPc6KSOZT8YYiZer1gMCG07aAsG0mXOyF9P40UZHDzjKwbi55L2jYSQoZpr80QDahVkL/R8iSwR7WBhLLASXMowqkKZ+S5ILkKVy9j04Vbj5aZf1Oyp+o9RlaM6/e1SV8fSmIDTsnQQMBiiR5r1I45L1c4i5ToHuyw1HIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMM6Ixpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96517C4CEF0;
	Fri, 13 Jun 2025 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749845278;
	bh=Qq2XImfZnpLj0zrdh6fum6am1oTUWVV5DQeDc42T/T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LMM6IxpeCjNCzh4up8SwYXX+E1XL3nKc0tGwm7JSmy03kV12FblCoar5/BBrBsv9V
	 adAL7zMhu6OH04AXrYU+yvyg25e4zTYkdz/cSCiHSswnaVuUEQRdDzPMeVSBDWuU2U
	 814hZghbJnT/thov4PhXEaLRxrpKc0kUtfKn7CdFmrzL/7mNigAL53dSZilKzRY3wg
	 nleaRBvfvVU446gBvKheTXysvnHOz7StPkh6W2R84Io+V4zasdaC6Q8g7EffAe6ysq
	 ySxnM2bVpGHUVxfWmDjNpNkZePNipqkSvOe0AVYRpQUkYG6vE0yu1IANc07jiIH8He
	 3K5UdmMQEiSjg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v1 2/5] NFSD: Remove definitions for unused trace_nfsd_file_lru trace points
Date: Fri, 13 Jun 2025 16:07:44 -0400
Message-ID: <20250613200747.7110-2-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613200747.7110-1-cel@kernel.org>
References: <20250613200747.7110-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Events nfsd_file_lru_add_disposed and nfsd_file_lru_del_disposed
were added by commit 4a0e73e635e3 ("NFSD: Leave open files out of
the filecache LRU") but they were never used.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 93875c7ba358..79a18a694d46 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1343,9 +1343,7 @@ DEFINE_EVENT(nfsd_file_gc_class, name,					\
 	TP_ARGS(nf))
 
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_add);
-DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_add_disposed);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del);
-DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_lru_del_disposed);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_in_use);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_writeback);
 DEFINE_NFSD_FILE_GC_EVENT(nfsd_file_gc_referenced);
-- 
2.49.0


