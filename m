Return-Path: <linux-nfs+bounces-11404-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365CDAA814D
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC83462D41
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB6D27D792;
	Sat,  3 May 2025 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUg+D97a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3E27D788;
	Sat,  3 May 2025 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285119; cv=none; b=fcNXCJ1YnqwDxlp15Clg9Df16EUK/TM8NwARIvKm5hZm1V8iQdzbeTA1sP1J6RCO/Eqoa+VZNePubrO41fwecsjV/kV486eDaTzvcIjbYxPsF5PkpFjY1QwiRdQspGzJKPEeeuvZX7M5+PSsfHzKwfbOR65GK1TD2HzfT2r/ktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285119; c=relaxed/simple;
	bh=BMpTJCCODEIlgGU/6woI0of3j2GU2RwUH3lrQRd+v+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stKt6GYOim2tjd3S+t+vnGJLozRzgBx33VXovNcut/kjMSuDEjzM6216C1NDYGByAsXdy/iVFv9h2vBHwTt1jVXdRiwTI+bwfO8BtRSpzDq4JZrLmLGv84wfmQNFSADXXjnpDwjhI7nO+3Pn+u4+iSivJu/9x6FgPNlWV1kfPvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUg+D97a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD44C4CEE3;
	Sat,  3 May 2025 15:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285119;
	bh=BMpTJCCODEIlgGU/6woI0of3j2GU2RwUH3lrQRd+v+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iUg+D97aWD53JORCvpE1EKhKdne9oJNZQaz8LCFB0z1hc9rcn1SkwWTbIwd448OSY
	 J6TSIoR4+Oobhzm/5rA/8Mh1T0tomG3POQkd5xPJddXQhaB1rvHoGRyVjj7cjgBNLm
	 gE4fFywA8zkHj93lCiklya2KlPFTFPri0JFeedp1bnIWekD8NdzuREBEnWOOAELkzC
	 tR1lrpTBe0XvdGOHT97Ydps+4mRFspK+yguls8+Penm6q128W2eKQOfV+FRmFs+VIp
	 ro1MOJ/xGLemfNXKoeqTE92m9AVSeCs/608WFZqtindIz3lksZ+JciPzY20S6ESDXw
	 qyQxPiFO1GLPA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:30 -0400
Subject: [PATCH v3 14/17] nfsd: remove REMOVE/RMDIR dprintks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-14-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BMpTJCCODEIlgGU/6woI0of3j2GU2RwUH3lrQRd+v+8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIumvhTVZQ9ofLWGDmWBpKZq+rOTPhDlAIf1
 8Tv+NwLi5SJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLgAKCRAADmhBGVaC
 FUd4D/4qKLb/YE0TOKver9MLh/sjFv18oeBt9f4ioNqY6JLZEuJac9mLkqFct4yrp2p/LF1uHrW
 gNZiTrUvPIzEH5lY434PK+gcsQY8aDA1LDmPUMdQjU/OLOS8JsBsnZsXHgAM/NEvyX4PJ7ONIwj
 PZnJJc0UmKmvZ5SKAtF+pwrh+uzHq8YQ9nOLZXjA/y8vWZuW4NfhKfm8TlbDpif8zWKgNoy5sdO
 06kSiEG7zGlKYn96jKhdU9zjYqs7U0O3M2Hh6m4gAwpnRVyYD9brWxJYZm4buUQkDKUBfkD1NSr
 6hu1aUBs29pnTRWYXKD7R8cRVfedRCGk+l3THohqt1OpMNHlrED0INK4zbjkdYqwukPM10DTUnj
 BFfDl4CYeKz6fJ5yCaRu36J1kbJWCuMqR5IeggZRIfv6zwf1e8FeWX+HEkClVbIn6uvQmuEXXz/
 VWcacWQHirfovLEbTm0uJvu/Qf2BSi4VLKHGbqwGETmq0tWv/d/b/s0y7axogOGDXdqW+3W3/ys
 vltSzgoJMmKsHg+uS+W3ZILvDF78KNDk5MaHmsK0foXcHl04T1vhn+xK2b/CWS37TiX22FUm9yE
 QSRc/G6Lu38TzK1yFoCI8vusiAWrchKNsrt3FOOll1cXwT5AOn/xNUppW2P2N89KnAX8nvxE0r4
 ayn64HaGPHYww3g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c | 10 ----------
 fs/nfsd/nfsproc.c  |  5 -----
 2 files changed, 15 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 7ed4932e82f330b4e382c0129ba8cff10f2d44e0..fca65adc43d3b70323938ff8a595ce7eb0a7ca57 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -496,11 +496,6 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 	struct nfsd3_diropargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: REMOVE(3)   %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
-
 	/* Unlink. -S_IFDIR means file must not be a directory */
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
@@ -518,11 +513,6 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 	struct nfsd3_diropargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RMDIR(3)    %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
-
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
 				   argp->name, argp->len);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 449732bb64f85283d7f208087dc47d39df3f5e68..41011a7f19397a300c5c6b468871a18b9f3fc210 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -445,9 +445,6 @@ nfsd_proc_remove(struct svc_rqst *rqstp)
 	struct nfsd_diropargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: REMOVE   %s %.*s\n", SVCFH_fmt(&argp->fh),
-		argp->len, argp->name);
-
 	/* Unlink. -SIFDIR means file must not be a directory */
 	resp->status = nfsd_unlink(rqstp, &argp->fh, -S_IFDIR,
 				   argp->name, argp->len);
@@ -565,8 +562,6 @@ nfsd_proc_rmdir(struct svc_rqst *rqstp)
 	struct nfsd_diropargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RMDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
-
 	resp->status = nfsd_unlink(rqstp, &argp->fh, S_IFDIR,
 				   argp->name, argp->len);
 	fh_put(&argp->fh);

-- 
2.49.0


