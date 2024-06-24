Return-Path: <linux-nfs+bounces-4247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A4B914085
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 04:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69D81F210F0
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 02:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E96F8C1F;
	Mon, 24 Jun 2024 02:32:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0925184E;
	Mon, 24 Jun 2024 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719196322; cv=none; b=jict9e2OqLisJyip+q7m8R+tJ1sspBQf1iwCko9XbEq8NZPD+w96Tp9BCzC+PwIwG0qxQ8alpffkKsG+99wZg1CXfheO+RUSWzTAMwseEOspDa0fPheQ+MgFuLtlGrwBUnck2qkgQvbeAkGz6eFgB/eqBljR9epE4MZdfSHrKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719196322; c=relaxed/simple;
	bh=T/dFU7iTQCsW2lO42YyVOIMR0++XazxvQDnGNfFbkpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p1MXu0+6KUdjFBsmfm/5BfZFXvYuoCR79A4f0zZaXPcjGn2oX3KB6+idN27KrKL0zC6Ris2yAgLUlcU8sUAAisDvYQ4w6qoCPExgc7PywcczYLzgzpd64lFiAJIt083tIuw5Xz/7txADJKhyIa9oXvvbZLinfx6Sq6nb1AqDzn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowACXnJh32nhmOhwkEg--.59814S2;
	Mon, 24 Jun 2024 10:31:27 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] SUNRPC: check mlen in ip_map_parse()
Date: Mon, 24 Jun 2024 10:31:18 +0800
Message-Id: <20240624023118.2268917-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXnJh32nhmOhwkEg--.59814S2
X-Coremail-Antispam: 1UD129KBjvdXoWrAFyDtF17tFW5tw1UCry7trb_yoWxWFgEgr
	WIyr47Wrs8G3Z8A3y2q39Yv347Ka1kAFn5ur9rAFZxG3WvvF1YyrZ5Wrs3JFnrWrWUtrWr
	Jr1qyryagw12vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

We should check the parameter mlen before using 'mlen - 1'
expression for the 'mesg' array index.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 net/sunrpc/svcauth_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 04b45588ae6f..816bf56597dd 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -196,7 +196,7 @@ static int ip_map_parse(struct cache_detail *cd,
 	struct auth_domain *dom;
 	time64_t expiry;
 
-	if (mesg[mlen-1] != '\n')
+	if (mlen && mesg[mlen - 1] != '\n')
 		return -EINVAL;
 	mesg[mlen-1] = 0;
 
-- 
2.25.1


