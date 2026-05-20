Return-Path: <linux-nfs+bounces-21725-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNLPD/duDWp9xQUAu9opvQ
	(envelope-from <linux-nfs+bounces-21725-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 10:21:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9A5899F9
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 10:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB6D73109E8D
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5373A3A9615;
	Wed, 20 May 2026 08:13:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A63A6B85;
	Wed, 20 May 2026 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264837; cv=none; b=bibP1exkV6mZxtIdn3zkPxU3v4rV9ykme6RvgTfkgIgB415/X1wB4AxufpHyWfg3ecibLQ+UCshHM84krYYu5a2CzMn761TN0bRPIf1n3kAsdbadZswIWjfKVQ4kORltUBVM7qwqukvEZA4jf2QPr1SDU0q+uTRqBnXhntp20Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264837; c=relaxed/simple;
	bh=mCej5s/Yy1VjGo+6rc5dQHYPIEQkYEXhZE8zsMN8jts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSun+71SBqF55qaLthC+/zVLHJdm5uWJ7lEBy9s1yFv9TrS4obEX2UNDK2K6lCJBU4gFDZ+9v/tj1mwB5vJBXj3v1bt4zVO0ympdZif/NveHIqH0w1FqH5BsYpJzpiRiOMrCu2Aq0MRY4liNZc0BnaliYM2PKQWaBZFtzdJWuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACHqMItbQ1qwY4YAA--.980S3;
	Wed, 20 May 2026 16:13:37 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	rakukuip@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] sunrpc: clear rq_procinfo in svc_release_rqst to prevent double-free
Date: Wed, 20 May 2026 16:13:28 +0800
Message-ID: <8c4cfe3656a817a64da9cf62e42282a1f308b9dd.1779253342.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779253342.git.rakukuip@gmail.com>
References: <cover.1779253342.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACHqMItbQ1qwY4YAA--.980S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF45tw1kJF4ruFy7Wr4Durg_yoW8AF4UpF
	WSyw47JrykKF1DZwn0yFyrZr48CFsYgr17GrZFya1fZ3W3XryUAryF9FWv9w4DAFWrWa1j
	vr1qvF4ayrs8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQENCWoNUPACIQAAsg
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-21725-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: AEE9A5899F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luxiao Xu <rakukuip@gmail.com>

The svc_release_rqst() function unconditionally calls
rqstp->rq_procinfo->pc_release. However, svc_process_common()
does not clear rq_procinfo when a worker thread starts processing
a new request.

If a previous RPC selected a procedure with a non-idempotent
release hook, and the subsequent RPC takes an early error path
before a new rq_procinfo is installed (e.g., due to an oversized
RPC fragment, bad auth, or unknown program), the stale release
hook will run against reused state from the earlier RPC. This
leads to a double-free or use-after-free vulnerability.

Fix this by setting rqstp->rq_procinfo to NULL immediately after
executing the release hook in svc_release_rqst(), ensuring that
stale procedure hooks cannot be re-triggered on early errors.

Fixes: d9adbb6e10bf ("sunrpc: delay pc_release callback until after the reply is sent")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/sunrpc/svc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d8ccb8e4b5c2..0332f05e7061 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1572,8 +1572,10 @@ static void svc_release_rqst(struct svc_rqst *rqstp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
 
-	if (procp && procp->pc_release)
+	if (procp && procp->pc_release) {
 		procp->pc_release(rqstp);
+		rqstp->rq_procinfo = NULL;
+	}
 }
 
 /**
-- 
2.43.0


