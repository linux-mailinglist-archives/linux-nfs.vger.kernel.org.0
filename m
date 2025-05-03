Return-Path: <linux-nfs+bounces-11393-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563DFAA813A
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98A817F478
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E43E27A468;
	Sat,  3 May 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm9rAKmO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880B27A45F;
	Sat,  3 May 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285108; cv=none; b=CoLXMs17C9rickPG0JF0ofosU/nXKkmk/gfV5iUJyTZlLfHP14n2QbG6ayg3f9bWKFPaQ9da6Gr9vUWze5eacNkhe4mo1o2QHboTYSJuLW9W+OUw7oCBdduDIOoB7eP9D84UJCRii/ghh20F3a7MWtNaCl5YbHb9tIqtMIHfoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285108; c=relaxed/simple;
	bh=xI3WTpyUPVUnn1x5XonAZorokqime/TlzydhgGCwrWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOwhQXuDd0+nQg1FyzBe77H7lnYjfJtOc1zwysnV/9rBH303sU3jAoXiZbw849liObJqI1GarKa6TyLJknHveoof09j1uEfLXZXm2VDwVB+4p9VVPrN1VnpYnNvi+itrZzqmY8ToaoD/ypK9Yv/HpCwq6l2j4EPgkRWbMA4S78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm9rAKmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF23DC4CEEB;
	Sat,  3 May 2025 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285107;
	bh=xI3WTpyUPVUnn1x5XonAZorokqime/TlzydhgGCwrWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mm9rAKmOsTXp3eO/L+4FpkZcsBi9BUVl3qUJGmwVMrMBLqLQ4KwFyxEvdEcjU2hHm
	 IrtyHmOrC9RWiMpLsyZ9JrJkysPNJoAPxyQ3S/pxnbqV34dRMl6CcLqHBIty62y383
	 ospPZJmy3kay1c5J7LNltreZoFPnBdm4zv/KToNjzZpOx+rQ78aVpojKDIKAPcUX+E
	 FI8nPHp6Hclv202N/ijHlZfjoP7lnyQFC6UQgRcsuK37pymgJt+AfVhZ9EC2aUrkez
	 3eDx8zrplArbkMOM5KF5iHznDOQ19m0aejKpR6uENTEgrgn3BrTMaIIx0t16WJpIai
	 YhKIQxA95XO1g==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:19 -0400
Subject: [PATCH v3 03/17] nfsd: add a tracepoint to nfsd_lookup_dentry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-3-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xI3WTpyUPVUnn1x5XonAZorokqime/TlzydhgGCwrWI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIseKdUdzZF6CkgmbrxIGGRykTl0eQsBCOdC
 RgjuC27Ma2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLAAKCRAADmhBGVaC
 FWTUD/9ASzvRqYzRZ7gzcdfNHCUIy4Yd7gJw22QCldun4WXzIPBxELE9cm5JN6v838f0+BoDFnf
 o7xqJR9yKXBKUouKNTXp4PaGQwmu+W/e/RfYYq1iFqlQEQo0v/+XElAwBGahclhGbnGhYVv7qYV
 9l2pjcRLbRglQiUgC5HJZroRUZ0zhvbVE/s3eznXaoUBbGG1k4hnb5vZPjeKbEzSh9mlGcB2jjd
 ZBq0u0hDlHSNUr+eaSMEFoAs5Wd616hM/slOfbIoLYGHO/jPws4QMTWlwZ5rlP9tmvHPAb9b6ys
 ijqWyosAsbJQPIhgnl0FEBJmCS5IoUmSRp6W4VsRbz+ISCbV7Ck9eLpAO61fFJ+eQb2Vv77KeeG
 sSUEFLwWP4eBDf1nF4iray+tXcQzo+/9ZJMNvVUchSOS3p22TgOBF1XOp+g3/e4E/1rLQvXE+Vq
 rfCG0KAz2BwS055n5oE+DtZzReGqxNn0jsSTDpH0UZ1BDgZy5Ii1LNG/KkIcqDs1EUCQRZrJAvq
 zWCzdniJXQzNOIoj4gEATEcSZbjivxku7ArRTqTzorjbdxyrjQ67T5GvrLzg4YYiAwXqp1ZJbnq
 MGrtUpWassDGZm3yTjDRnUkoDt8qptoZnbwK+wo0s6boQIJ/ja0wLkP4ozYqXg0zqfg9O++Pzl6
 ey3rpmPpEg4xBFg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...and drop the dprintk.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 19 +++++++++++++++++++
 fs/nfsd/vfs.c   |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c496fed58e2eed15458f35a158fbfef39a972c55..382849d7c321d6ded8213890c2e7075770aa716c 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2372,6 +2372,25 @@ TRACE_EVENT(nfsd_setattr,
 	)
 )
 
+TRACE_EVENT(nfsd_lookup_dentry,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *fhp,
+		 const char *name,
+		 unsigned int len),
+	TP_ARGS(rqstp, fhp, name, len),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__string_len(name, name, len)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__assign_str(name);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
+		  __entry->xid, __entry->fh_hash, __get_str(name))
+);
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 55476fe6d9adbd338d96a9dd8f732638cd072a44..276fbb572ead90fd07cde6922a697e07148926de 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -246,7 +246,7 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct dentry		*dentry;
 	int			host_err;
 
-	dprintk("nfsd: nfsd_lookup(fh %s, %.*s)\n", SVCFH_fmt(fhp), len,name);
+	trace_nfsd_lookup_dentry(rqstp, fhp, name, len);
 
 	dparent = fhp->fh_dentry;
 	exp = exp_get(fhp->fh_export);

-- 
2.49.0


