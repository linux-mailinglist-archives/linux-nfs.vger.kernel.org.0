Return-Path: <linux-nfs+bounces-13841-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DB9B300D5
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7354B5C8A3A
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 17:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD4D30E82A;
	Thu, 21 Aug 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN+ASG5k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1532308F02;
	Thu, 21 Aug 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796631; cv=none; b=qH5QQ8uUswMQWGQldOiYaMpi9BpgmEpr9ZlTLDJghhIh48Fya17f559vDsbcdqnpVPglKfTLzesW4fg/5RhwF70WP6Druusbp73TfdTUWZG3bC67giLCQmYUVasGEf1TfIpMEI0NyJ8pxo4UPAVqYjibkUq2XC8reFTA2Y/Yqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796631; c=relaxed/simple;
	bh=iCzcRrcwe30YJqfH+ihdMh/GY7hej9hpcaYcBAlmZbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VziPL3CpBOsD1FD/4L9rZUflDWM1CcpQxSXAU+vWRPVzB8JCP2oEstbq8Bm5VidKBSY9uWJoS52e9nE3esHgjKRHDk4EAiU9g9s3rcUjQteVMCZ86mqEF5t43T4Ob+eIr+ZeiYvZht1EK2Uf0D3aqnIKhQC3axiEYhzV7lDlFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN+ASG5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11BCC116C6;
	Thu, 21 Aug 2025 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796631;
	bh=iCzcRrcwe30YJqfH+ihdMh/GY7hej9hpcaYcBAlmZbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eN+ASG5kgRl5KA2sU7dgk0+2nyQ8bLAlElf1IltEboQAQqQO+7DS+/19GClHpFdU/
	 yF9eGhiO1M9CZl2PYQ6Mh1/02BVRuN+zfASlXUFU7wQHJGTt71NH664+NbvJfPEgse
	 mdXw+1cta/kGYwMSUaZrTXBXF6w6CBz48e20nZGCcxY2LqwmvYz653ky84QxxJQVEy
	 UxcQ/MEQ/ctJPwA45HK+A6WlE74rrtpwiBg2k3V/lVkn56LWz9HXJVGcJBH465q40p
	 L0CEwRh3Zef4XBv8QH2cZBvZb/YXl6IVTwVTOE2M0rHwo2J/C+AeP8U/DwDdnROHH/
	 BJcojUik/xtTA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 21 Aug 2025 13:16:53 -0400
Subject: [PATCH 1/2] sunrpc: remove dfprintk_cont() and dfprintk_rcu_cont()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-nfs-testing-v1-1-f06099963eda@kernel.org>
References: <20250821-nfs-testing-v1-0-f06099963eda@kernel.org>
In-Reply-To: <20250821-nfs-testing-v1-0-f06099963eda@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3492; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=iCzcRrcwe30YJqfH+ihdMh/GY7hej9hpcaYcBAlmZbI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBop1SUMM3cjDxDGm8FM13lZRUSJ7egAOIb2aF5K
 dBGzwt3fD6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaKdUlAAKCRAADmhBGVaC
 FcRkEACEvHwv8SNysi12A3SmbtlRMRZxjNVagVnDT1I6052h1zcginDNI4NjbaYCyai7YhDKBUV
 5yBYoMHOqwy57DeJikPcGUIkA8h7BZ2kRkrcpetGoDpHED6XfIDkThPqn9Nzhe3pfNu2W5ET3df
 x4xOhMRhTjy0Iz4UzaRMxW8tqJQ3Qy7bHjPJEsK+C1xgfIroN2ywW4uRVLONGrHHIkZxaS9i9tA
 KZh+DbbgyD1AMhB98KhAN9xFXZSXYwFTzNI0G5SMh4QKR8yjMggyO58f0G1yGYsoUgnsDriadBj
 osy3a6mBtZtbVjSkzShtttURbuRF3VbODgbJvM1L0un1AzIT3yyQfzuMSzB4r/+bKjeHEN5lAW7
 b5NAIOxH3GU3gDx3KONi3LtS0lBJXv6X1B9bYDmecqQ/kKyHW/R/jeCoONnOJP56v6k3UPWwkZ1
 cbLe1j71ENc0Xk/Jx7JffHDN1u1M+iihGGHPFvovKK9Fxa2C+9GyE4cRtOUYb/LHqhqTy35ZZdU
 r55CbMEndkqtRIe4l9rk18QTT6FeRgDINLErgj/mLiyOrjE/+YPpFN8zwPC6tnVYZHXe4L6Oiir
 7TqnlGCEFWHq07EVv/jV4a+iEJre5S+/0A+WlxeCzGJn8EBKhPAVjz7Ljsiy4QjFM5jnqlXh6G+
 6OpfZaDwdjTzrqA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

KERN_CONT hails from a simpler time, which SMP wasn't the norm. These
days, it doesn't quite work right since another printk() can always race
in between the first one and the one being "continued".

Nothing calls dprintk_rcu_cont(). The only caller of dprintk_cont() is
in nfs_commit_release_pages(). Just use a normal dprintk() there
instead, since this is not SMP-safe anyway. With that, we can also drop
KERN_DEFAULT from the format since it's implied.

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


