Return-Path: <linux-nfs+bounces-16644-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DA3C771C0
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Nov 2025 04:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0761359876
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Nov 2025 03:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5242E0938;
	Fri, 21 Nov 2025 03:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y5GSGCUd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A72DEA8C;
	Fri, 21 Nov 2025 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763694165; cv=none; b=bzYW6zsfhHfc611+ajMCTKYlRCdr/6bq7Y4GodyruvDIfZIG7yvpDnP3ffqtWLFxEVOfKJs9ZQV/XB6WLlTWrGgbHozLOvXDooHcUT9fowSj7ZOTlt6B3njnaxY0qXy6RAWeTYLNKkEWgNOSG1pa31+PdmceecjBxXx3XXp4CGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763694165; c=relaxed/simple;
	bh=zqRoFl++M9d3FcWgpYUnnQ9zxxPUVHU98z/zdH7eLX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t+NDrgaUHVCN9K0hasTEFiediQ8QpZIjck64oEoM60KLFEmEczYX+0/A7Wk+L8+qAVdjoD3zN2iT1qzT7e3JWCigFINU34myc73bbgY7xHoBH+WU6laflWm9jTMY5Wcy+kxIsdyZyXtV9qCQbNmTjUbGQBmsghhb4gLUQ1wDnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y5GSGCUd; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YP
	ONgAu2nOip80epVyPAUQ8lWeekOBOryGnKGH51EfU=; b=Y5GSGCUdtzbn050548
	zDZ4HMI3Mu8bNPL0XiKHmcH32h/nPHh8VjWwaf5m/ukzu7WdjEi2SeULOK1amLan
	rc/ZPtxU6zze0jKTQ4upbGeveUYe2RLr4ofI1ZmhB7wJUHnKitwq6nm9EpJS5nf0
	TWqImjQOhUtThnja6XYx+6lmg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wA3xcca1h9pyGLoBQ--.25S2;
	Fri, 21 Nov 2025 11:01:49 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux@treblig.org,
	ligongwei@kylinos.cn,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC: use kmalloc_array() instead of kmalloc()
Date: Fri, 21 Nov 2025 11:01:39 +0800
Message-Id: <20251121030139.53241-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3xcca1h9pyGLoBQ--.25S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr48ZF13tw4fArW8Gw43GFg_yoWfWwb_WF
	yvvr4DCan7GFn0qw47urWjqF4Skw1UCr95CF9xKFyDXanrJa1kAFyxJr4rZrnxuryFyr97
	Jw4kZF98tw1xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeSJmUUUUUU==
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXA0NumkfyffYFgABsh

From: Gongwei Li <ligongwei@kylinos.cn>

Replace kmalloc() with kmalloc_array() to prevent potential
overflow, as recommended in Documentation/process/deprecated.rst.

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 16dcf115de1e..9418b1715317 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -404,7 +404,7 @@ gss_krb5_cts_crypt(struct crypto_sync_skcipher *cipher, struct xdr_buf *buf,
 		WARN_ON(0);
 		return -ENOMEM;
 	}
-	data = kmalloc(GSS_KRB5_MAX_BLOCKSIZE * 2, GFP_KERNEL);
+	data = kmalloc_array(2, GSS_KRB5_MAX_BLOCKSIZE, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-- 
2.25.1


