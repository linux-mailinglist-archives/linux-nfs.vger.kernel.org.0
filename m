Return-Path: <linux-nfs+bounces-10508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F24A54AF2
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 13:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09C03B0DCE
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 12:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579C920F081;
	Thu,  6 Mar 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msxHK9XV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52320F073;
	Thu,  6 Mar 2025 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264718; cv=none; b=RcDYPSGhY542FUA2ygBFn+KIPdrkfg0DkKU5gHB+cEQ5W7k2z89W+1CKU0fO42vd3TqMTVtYxVg5vNGZLjjLXBrwKOMh8rIkvJ9FEunItW4A+uiVjVv98+xyv2oXBjrycWIO05yqrkLeVzKdRhVSU+//FqtYY8HXky/lgG7cY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264718; c=relaxed/simple;
	bh=dyD83E6xBgj8xEPdWKHMuiwEZpx2QwPrP55hvE4goOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zo9QBJOOoTRv7ZFX67QwjVm/nn6r9qffwodlySsMhTNy5tg279twRKDu71mh2EtMyVAHAH0pcX6SInjPPCEcvmHx2aAJTOCuxAvG+I31JFI7XjkuNYvu5yDnbFHoslRDQUTCfABo7LvFIJO1/IDfEZu5V/anOZYWBwundRljBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msxHK9XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5713AC4CEE9;
	Thu,  6 Mar 2025 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741264717;
	bh=dyD83E6xBgj8xEPdWKHMuiwEZpx2QwPrP55hvE4goOM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=msxHK9XVTE/iAEB1CIFbZ3xuYCpuVOzc1hQROyhx73F7J5zvYznz9WZDNmnmN3VuN
	 cp+MCgnB7fiHcyeQQMjYPUxpNKIBLu6EK+qJXESr2iTvGa3rNcYaDSbZ3tpxWQ4+pe
	 2+h41P267DhcbaimMWpY+AiAgrAOyb6s0fiKzrU0CYgIalQRmJPVAUtr6xIvidHses
	 MAbWL/ifA8OQInDxRL46X3ki7DnTPpmDhW8DmLzWFKyMyMmBxkUf9+798XS9yBb1x3
	 SRUf8jdZZYWGpXpdQsAh0rTwVEOv6psszH/4VO0Wd3o9rZgNOoABLZFaZaEbGnrQHt
	 UlwDITkIQzuuw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 06 Mar 2025 07:38:16 -0500
Subject: [PATCH 4/4] sunrpc: keep a count of when there are no threads
 available
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-nfsd-tracepoints-v1-4-4405bf41b95f@kernel.org>
References: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
In-Reply-To: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Sargun Dillon <sargun@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3042; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dyD83E6xBgj8xEPdWKHMuiwEZpx2QwPrP55hvE4goOM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnyZdFnf7gFL693DACTwjc5lS7TCYZ6V0GGpM6p
 b+7E2endsWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ8mXRQAKCRAADmhBGVaC
 FYnJEACXHTkEJe6iR66DsLQGjBAXCPwcK40MVENvsNzhhADmEbTed0FKW2o9iZcIwZmz3MQKo10
 NOc6VALWuBSiBw+ygP6x6sIpa8z4q1PV0gfwWCwTj2obQ/R3w82GJJ5jEeZgeklj3gyGdOaIjeZ
 My4cT5af4xHXEhqHK2AyRBZqxr1THlO/X5WeuXxlfXhdC3dfKznTytd15InNgWPR/XuCEGceILo
 Uqd9b3+R7vCNjiSZbA3RBxkTmZE43kxAWX3aJ82Mb5sAPOSSAUU7GQZgW/6OniLEGFkx+D53igu
 oT7F+bOCJcbs8stmAYeXh/YOiTggE7KiEM/P5KthWrqSmi4l08ec/YQ0TTFXY52CMwz/uEajPKn
 geYlij3FgIEYMKSpcW4B69flPCzMwxhMKXLvPDfrq0ZGeKGp8OiIOUP3QT4j4dfQlVoUsVkPkSH
 RgE3YY8SDo8IndxL55Oun6KWtElhmWEn281alhqhOVsztjkpfmFWYKJZbNimZuba2EzO+9Wb0lc
 SIXWJZFkfgUF6Z2gy8UkLSLOu4Zt6s8HAOke8lMA+e91pJ4eegMmtXt4sab2SV8542IuPJNuTo+
 M6nt0XgrFK5joSao7n0Nu73oi4lCk5zy11brcXBcp0JBZjBTpVi5Thy5TzRUJpVhlF6V6q/Pq4f
 OlrKhKhi7AU3z0Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new percpu counter and pool_stat that can track how often the
kernel went to wake up a thread, but they all were busy.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/svc.h | 1 +
 net/sunrpc/svc.c           | 4 +++-
 net/sunrpc/svc_xprt.c      | 7 ++++---
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 74658cca0f38f21e2673c84c7bcae948ff7feea6..179dbfc86887374e1a0a2b669c5839cb622dd3f5 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -44,6 +44,7 @@ struct svc_pool {
 	struct percpu_counter	sp_messages_arrived;
 	struct percpu_counter	sp_sockets_queued;
 	struct percpu_counter	sp_threads_woken;
+	struct percpu_counter	sp_no_threads_avail;
 
 	unsigned long		sp_flags;
 } ____cacheline_aligned_in_smp;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e7f9c295d13c03bf28a5eeec839fd85e24f5525f..789f08022aec210b6df08036997ef801d3c73ac8 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -545,6 +545,7 @@ __svc_create(struct svc_program *prog, int nprogs, struct svc_stat *stats,
 		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
 		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
+		percpu_counter_init(&pool->sp_no_threads_avail, 0, GFP_KERNEL);
 	}
 
 	return serv;
@@ -629,6 +630,7 @@ svc_destroy(struct svc_serv **servp)
 		percpu_counter_destroy(&pool->sp_messages_arrived);
 		percpu_counter_destroy(&pool->sp_sockets_queued);
 		percpu_counter_destroy(&pool->sp_threads_woken);
+		percpu_counter_destroy(&pool->sp_no_threads_avail);
 	}
 	kfree(serv->sv_pools);
 	kfree(serv);
@@ -756,7 +758,7 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 		return;
 	}
 	rcu_read_unlock();
-
+	percpu_counter_inc(&pool->sp_no_threads_avail);
 }
 EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index ae25405d8bd22672a361d1fd3adfdcebb403f90f..b2c5a74e4609e8f4a3f5f4637dd9b46b40b79324 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1451,15 +1451,16 @@ static int svc_pool_stats_show(struct seq_file *m, void *p)
 	struct svc_pool *pool = p;
 
 	if (p == SEQ_START_TOKEN) {
-		seq_puts(m, "# pool packets-arrived sockets-enqueued threads-woken threads-timedout\n");
+		seq_puts(m, "# pool packets-arrived sockets-enqueued threads-woken threads-timedout no-threads-avail\n");
 		return 0;
 	}
 
-	seq_printf(m, "%u %llu %llu %llu 0\n",
+	seq_printf(m, "%u %llu %llu %llu 0 %llu\n",
 		   pool->sp_id,
 		   percpu_counter_sum_positive(&pool->sp_messages_arrived),
 		   percpu_counter_sum_positive(&pool->sp_sockets_queued),
-		   percpu_counter_sum_positive(&pool->sp_threads_woken));
+		   percpu_counter_sum_positive(&pool->sp_threads_woken),
+		   percpu_counter_sum_positive(&pool->sp_no_threads_avail));
 
 	return 0;
 }

-- 
2.48.1


