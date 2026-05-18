Return-Path: <linux-nfs+bounces-21661-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL7bNwoyC2oZEgUAu9opvQ
	(envelope-from <linux-nfs+bounces-21661-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 17:36:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5322757017C
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD3D330520A8
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E373F165C;
	Mon, 18 May 2026 15:31:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D62D8378;
	Mon, 18 May 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118275; cv=none; b=qTeEvp7dn7+TTmMD4vKQk0Qg3IDcfIqKvQflKqEEWJqaA2EaS0A1M+Y4jatMf6iWLN2zrsp9IwYTdx35eEQmobwKVJai4WUmGTjg3deXLxirUkulooWsHVqzRqVVdwHHwWF+QDPy6CAzjluPuZlDDyfU4ztvWiWhSy4sqOG/Hgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118275; c=relaxed/simple;
	bh=qhbDMOvMPQeHRe/9aaGcQ3ujNEB6olbTTpOnMHb3mOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fnkkvkOz8wJPA56q3coXsHZrNhJKlJPprFJ1bSF7AWRavrE3BnDlPyeIICZkx9juW6Rd7Hoxb92EWFE4vFwQwhLLddvXefspFhLdV7MM6IrnuphMwNF84C5f66mlzPqjyHHuYWXdK5Wn9ErW6b/GFq0k9qwniuSMrNcTv5UbEhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHKN+rMAtq0WBoEQ--.4645S2;
	Mon, 18 May 2026 23:30:51 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nfsd: fix use-after-free in nfsd4_lock() when releasing new lock stateid
Date: Mon, 18 May 2026 15:30:48 +0000
Message-Id: <20260518153048.1343021-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHKN+rMAtq0WBoEQ--.4645S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWrKrW7tF13Wr4fWrWxJFb_yoW8WrWrpr
	s7Ja13KFWUXF4IqFsrZ3yUZFn5Gw1Fgr15Kryvq39Iyws3Xr13WryF934q9w4qvrWxXa1D
	XF1Dtws8Ww4DX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZtxDUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkLA2oLKugMcgAAsb
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21661-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5322757017C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When processing a new lock request that fails with an error,
nfsd4_lock() may call release_lock_stateid() on a newly created
lock stateid.  release_lock_stateid() can free the stateid via
nfs4_put_stid() if it is the last reference, but the caller
subsequently accesses lock_stp->st_mutex and lock_stp->st_stid,
leading to a use-after-free.

Fix this by moving mutex_unlock() before release_lock_stateid()
and jumping over the remaining lock_stp cleanup after release,
since release_lock_stateid() already handles the final put.
This ensures no further access to lock_stp after it may be freed.

Fixes: 5db1c03feb00 ("nfsd: clean up lockowner refcounting when finding them")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 fs/nfsd/nfs4state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 88c347957da5..cef9d8ddfc43 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8388,13 +8388,18 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		 * If this is a new, never-before-used stateid, and we are
 		 * returning an error, then just go ahead and release it.
 		 */
-		if (status && new)
+		if (status && new) {
+			mutex_unlock(&lock_stp->st_mutex);
 			release_lock_stateid(lock_stp);
+			goto out_no_lock_stp;
+		}
 
 		mutex_unlock(&lock_stp->st_mutex);
 
 		nfs4_put_stid(&lock_stp->st_stid);
 	}
+
+out_no_lock_stp:
 	if (open_stp)
 		nfs4_put_stid(&open_stp->st_stid);
 	nfsd4_bump_seqid(cstate, status);
-- 
2.34.1


