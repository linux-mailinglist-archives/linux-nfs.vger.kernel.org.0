Return-Path: <linux-nfs+bounces-21750-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIU7NB+vDmr6AwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21750-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 09:07:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C301B59FE3D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 09:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FDED301F836
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 07:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F32375F65;
	Thu, 21 May 2026 07:07:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038931C84A0;
	Thu, 21 May 2026 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347222; cv=none; b=Ci8SHjCMikKbDUmAXhTUozlWpB+n0iO+A11loV5DHtLyG4VwKuNn/m2tOdaplejE6bY4GJXPYc56vPdWNPaSyVF+rq5Un5voe7BuN9D7OkH4ewfrLyIn6qFR1KbpYDLZJjmKgFoU7bKk1+o5o1d9gY82ODzIC0fCNpkitYMuGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347222; c=relaxed/simple;
	bh=dAWZfna6Pjx056Xmt8A2aqxUta8fHgD1aFGNw7yPiXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+EWWFKm+5oIlXQHYhhFbXg2WXsBC/WcYSSJarUqx1eDVxC3ZwNGom2iAyzBeEfrDESDG5vgSqS0VMF7S3VEFqZn7hb8vb9G77mAIBTIJR94RiI7+GeR5hssDpJT1odgnU0gQyyzqYGz1xiO2pAMCwk8dNZrEtqz2KPxtzcytpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnyML9rg5qfNQcAA--.32197S2;
	Thu, 21 May 2026 15:06:37 +0800 (CST)
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
	cel@kernel.org,
	rakukuip@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH v2 1/1] sunrpc: harden rq_procinfo lifecycle to prevent double-free
Date: Thu, 21 May 2026 15:06:32 +0800
Message-ID: <20260521070636.900264-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnyML9rg5qfNQcAA--.32197S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1fAr4UXr1rCF18WrykKrg_yoW5WFW8pa
	yFvw4UA34DKwnrWwn3X3y8Zr4FvFsY9r47GrW7t3sxZ3W5XrykCryF9FyY9rsFyr4F9w4j
	va1Y9a1ay398X37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQANCWoNUPAFugAKs3
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,gmail.com,lzu.edu.cn];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-21750-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-nfs@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	DMARC_DNSFAIL(0.00)[lzu.edu.cn : query timed out];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C301B59FE3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luxiao Xu <rakukuip@gmail.com>

The svc_release_rqst() function executes the callback inside
rqstp->rq_procinfo->pc_release. However, if a worker thread begins
processing a new request and encounters an early error path (e.g.,
unsupported protocol, short frame, or bad auth) before a valid
rq_procinfo is installed, a stale release hook can be re-triggered
against reused state from the previous RPC, resulting in a double-free
or use-after-free vulnerability.

Harden the lifecycle of rq_procinfo by:
1. Ensuring svc_release_rqst() always clears rq_procinfo after the
   optional pc_release() call, regardless of whether the hook exists.
2. Explicitly clearing rq_procinfo at request entry in svc_process()
   before any early decode or drop paths.
3. Ensuring svc_process_bc() does the same at backchannel entry.

This guarantees that error flows will not encounter a non-NULL stale
rq_procinfo pointer when there is nothing to release.

Fixes: d9adbb6e10bf ("sunrpc: delay pc_release callback until after the reply is sent")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Suggested-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
changes in v2:
- Extended the fix to clear rq_procinfo at request entries (both in
  svc_process and svc_process_bc) before early decode/drop paths.
- Moved the pointer clearing in svc_release_rqst outside the
  conditional block to ensure it always clears, as suggested by Chuck.
- v1 Link: https://lore.kernel.org/all/8c4cfe3656a817a64da9cf62e42282a1f308b9dd.1779253342.git.rakukuip@gmail.com/
---
 net/sunrpc/svc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d8ccb8e4b5c2..67933c10fe5a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1574,6 +1574,8 @@ static void svc_release_rqst(struct svc_rqst *rqstp)
 
 	if (procp && procp->pc_release)
 		procp->pc_release(rqstp);
+
+	rqstp->rq_procinfo = NULL;
 }
 
 /**
@@ -1596,6 +1598,7 @@ void svc_process(struct svc_rqst *rqstp)
 	 * Setup response xdr_buf.
 	 * Initially it has just one page
 	 */
+	rqstp->rq_procinfo = NULL;
 	rqstp->rq_next_page = &rqstp->rq_respages[1];
 	resv->iov_base = page_address(rqstp->rq_respages[0]);
 	resv->iov_len = 0;
@@ -1648,6 +1651,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 	int proc_error;
 
 	/* Build the svc_rqst used by the common processing routine */
+	rqstp->rq_procinfo = NULL;
 	rqstp->rq_xid = req->rq_xid;
 	rqstp->rq_prot = req->rq_xprt->prot;
 	rqstp->rq_bc_net = req->rq_xprt->xprt_net;
-- 
2.43.0


