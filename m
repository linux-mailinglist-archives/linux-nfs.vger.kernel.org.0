Return-Path: <linux-nfs+bounces-13870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38826B31963
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C1CAC0C1C
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A6302759;
	Fri, 22 Aug 2025 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5xEh5Xh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB58302740;
	Fri, 22 Aug 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868788; cv=none; b=LgG7bykchOXBWGorC2yjbEChNZxsDn33Jy3mtnnQrBCgLLWatx2krTC0p1qNA+MgjEQ2PuQHVNeUcL0PJMmv0X4MR07YdIXTiARvJpOtIc7HY8oNL9NbD+pj65TUJFLXafaZMkMhdYifLwvhRpnTHMuSSEWHZgC7j0tHq6BpAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868788; c=relaxed/simple;
	bh=MIpt2BSLHopkent+Pc4BviQAh8rGZu5EaYfs2EZi8tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p23y47zYIf23UJOz04UHQii3mh5wOfJuUAGp9YokXrz2gQ4huIRQ8G/EJade7V1SbRMSPulDGM8pZgrbq9PGYg4kVGXqRXUwIYbMUfbBsWz9e+D453ZCsZ567tFh3DtlVBhUnXqNGWfrRRTJ87ROueOyk2SQJtqb7APRwy5sdI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5xEh5Xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3A1C113D0;
	Fri, 22 Aug 2025 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755868787;
	bh=MIpt2BSLHopkent+Pc4BviQAh8rGZu5EaYfs2EZi8tY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h5xEh5Xh6pSnO+c5cMhTr428fs3rAJnBLZVbiffnZz2H1yV2vi04ILwD54utcgnbD
	 B2Kfzzo3PfpqOKEwyJXhQsBwBp6rTP5OdFUOZLEDU8I4+LVCzYk4Et5VQH+4suF6mF
	 ai52oqEaCvkHjMZ0Ncb2Q2v0MYF6eO1KKWqrg71NgQ8J6pQqQyOGj151IInRaFajPS
	 TELM+NzRdvfVP0qpYFwnxzc0U30+13hCzhENlWJ9rXB6+KmROEB7sfe78FUnazKtnr
	 RjKD3XYD+m2dIIBtavH7T8WJY7wetAdqc1yRGd3GD+moztCkjX067ul0F2u8bok8KH
	 SQIZUSOjcYdfA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 Aug 2025 09:19:22 -0400
Subject: [PATCH v2 1/2] sunrpc: remove dfprintk_cont() and
 dfprintk_rcu_cont()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-nfs-testing-v2-1-5f6034b16e46@kernel.org>
References: <20250822-nfs-testing-v2-0-5f6034b16e46@kernel.org>
In-Reply-To: <20250822-nfs-testing-v2-0-5f6034b16e46@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3432; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MIpt2BSLHopkent+Pc4BviQAh8rGZu5EaYfs2EZi8tY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoqG5wQmm+eq2gCW1sHmT2OgWR4YxtPZPNqL9j0
 LxgjNHTh2uJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaKhucAAKCRAADmhBGVaC
 FVyuEACEZe7fTvY29p4GSuUH4ROq9L32YKz+KJdTazg8gMbzaFgK1cbuJ8wAhD0uJobe93eqdac
 UNmV5L1Uo+AxJ1oYxs8lSh4yHyc/3FIcA18FwE8WtNHdaG/Ern9NvKQ8b7zpKvueZXqnNrKfSE2
 1j32kD2AV85FpiPMk+Bk8I1x4weKErRBG3EmMZ+48vFZFtgD1e5bySOFA59ZkGaGJUEHZnCd3xq
 e/0elAJittGckkS20DapEpuqBF56qRZVG/6/L71L5OCL1HZ0ximyVJzfJs/5XN9iRQqqqg+8Gmb
 3QQZf7u95bnRh7/c1UUcniLXVmwIznEuD3hlx0sIua/5dEKK3UUwF3eIC6NGH5RDsg2DD1O/gza
 htgyJL48uRmVsaMCJr/9ysLAgMZ9uG4O1+cwTd7DnSq0pOwKSG6CiH9rL0lSL8tkLzQkZrrw0MU
 MisjVaqlVG8icMTe0ZOpsCeOnX6kSIukWH5s5C5h4g0FP+bls/n4Y9m9J+RBX+/OZHc6voKFc4i
 Rmw0XITzktvyHIYlppC8lH2+PYEMZakXt1rAJH3BKG1gSVaQODl0Ld9Qwf1kRnIC7XnW50psm7l
 a8MkxgAcgJyuwZ+U9/1Sikves0T3FB7o/jhbzunLO2Im9KhaS5ca+c8eGRpJ+PFmHs5S9g0ui9n
 C1Ibg0hXWuywliQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

KERN_CONT hails from a simpler time, when SMP wasn't the norm. These
days, it doesn't quite work right since another printk() can always race
in between the first one and the one being "continued".

Nothing calls dprintk_rcu_cont(), so just remove it. The only caller of
dprintk_cont() is in nfs_commit_release_pages(). Just use a normal
dprintk() there instead, since this is not SMP-safe anyway.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/write.c               |  6 +++---
 include/linux/sunrpc/debug.h | 24 ++----------------------
 2 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index d881486d235ba042feedd2dd59d6a60b366b9600..4d5699b4a1fabff39e67998af40561620b532db6 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1862,7 +1862,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 				nfs_mapping_set_error(folio, status);
 				nfs_inode_remove_request(req);
 			}
-			dprintk_cont(", error = %d\n", status);
+			dprintk(", error = %d\n", status);
 			goto next;
 		}
 
@@ -1872,11 +1872,11 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 			/* We have a match */
 			if (folio)
 				nfs_inode_remove_request(req);
-			dprintk_cont(" OK\n");
+			dprintk(" OK\n");
 			goto next;
 		}
 		/* We have a mismatch. Write the page again */
-		dprintk_cont(" mismatch\n");
+		dprintk(" mismatch\n");
 		nfs_mark_request_dirty(req);
 		atomic_long_inc(&NFS_I(data->inode)->redirtied_pages);
 	next:
diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index f6aeed07fe04e3d51d7f9d23b10fe86d36241b45..99a6fa4a1d6af0b275546a53957f07c9a509f2ac 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -23,12 +23,8 @@ extern unsigned int		nlm_debug;
 
 #define dprintk(fmt, ...)						\
 	dfprintk(FACILITY, fmt, ##__VA_ARGS__)
-#define dprintk_cont(fmt, ...)						\
-	dfprintk_cont(FACILITY, fmt, ##__VA_ARGS__)
 #define dprintk_rcu(fmt, ...)						\
 	dfprintk_rcu(FACILITY, fmt, ##__VA_ARGS__)
-#define dprintk_rcu_cont(fmt, ...)					\
-	dfprintk_rcu_cont(FACILITY, fmt, ##__VA_ARGS__)
 
 #undef ifdebug
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
@@ -37,29 +33,14 @@ extern unsigned int		nlm_debug;
 # define dfprintk(fac, fmt, ...)					\
 do {									\
 	ifdebug(fac)							\
-		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);		\
-} while (0)
-
-# define dfprintk_cont(fac, fmt, ...)					\
-do {									\
-	ifdebug(fac)							\
-		printk(KERN_CONT fmt, ##__VA_ARGS__);			\
+		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
 } while (0)
 
 # define dfprintk_rcu(fac, fmt, ...)					\
 do {									\
 	ifdebug(fac) {							\
 		rcu_read_lock();					\
-		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);		\
-		rcu_read_unlock();					\
-	}								\
-} while (0)
-
-# define dfprintk_rcu_cont(fac, fmt, ...)				\
-do {									\
-	ifdebug(fac) {							\
-		rcu_read_lock();					\
-		printk(KERN_CONT fmt, ##__VA_ARGS__);			\
+		printk(KERN_DEFAULT fmt, ##__VA_ARGS__);				\
 		rcu_read_unlock();					\
 	}								\
 } while (0)
@@ -68,7 +49,6 @@ do {									\
 #else
 # define ifdebug(fac)		if (0)
 # define dfprintk(fac, fmt, ...)	do {} while (0)
-# define dfprintk_cont(fac, fmt, ...)	do {} while (0)
 # define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
 # define RPC_IFDEBUG(x)
 #endif

-- 
2.50.1


