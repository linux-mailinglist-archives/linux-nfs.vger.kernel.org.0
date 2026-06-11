Return-Path: <linux-nfs+bounces-22467-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q+OJCbLYKmoPyAMAu9opvQ
	(envelope-from <linux-nfs+bounces-22467-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:48:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4A06732F0
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:48:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22467-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22467-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9415330BBA1D
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10706347BA9;
	Thu, 11 Jun 2026 15:47:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93712580F2;
	Thu, 11 Jun 2026 15:47:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192877; cv=none; b=dfV0PfzDLGo7vCoPub07bsZHQhjZy1cIqMu0QYC6ZbaAm9HJgBI0sY8IUKWjfg7jlKzqkQnQARRCWvy873mAxtunx+CgEaeZ5ZGETpkiGpeqeqt8Umt6IRP3yMT12mTKa4X5vfi4CDXj49enGy69jZaPFXHhoHFAcxXBYocpNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192877; c=relaxed/simple;
	bh=kNrKk5l1Gt8OvBbcZPhYp+2wcuU0yVvLXqJKt2RWbIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g3E0m7rZS58alxVLpriWZeLVOTwAkbHXRU5W0I9e9UOBBSqNUVXAp3kdEig4/J2eSaWn4yUkldFsTnmUCqsdALye+PBmoTFAZO2H5bHgP5JxBZwx6HlhO1dgmHBRuB5aCfN3CpYj96iwORFhUU4mS82L0F2gBkdl7nI6w48gKX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowACXCOyl2CpqzgQZEw--.1470S2;
	Thu, 11 Jun 2026 23:47:51 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] pnfs: fix refcount leak in pnfs_report_layoutstat()
Date: Thu, 11 Jun 2026 23:47:47 +0800
Message-ID: <20260611154747.94154-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXCOyl2CpqzgQZEw--.1470S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4UJry3KryUGw1rGF15Arb_yoW8Xr15pr
	Wruw4Y9F98Xr10yr9Fyws3Zw1I9Fs3Xw4UCrn7Kr1293WrJw1SqFWFv340qr10yF48Z3Wj
	g3y5KFWI9a4DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUcBMtUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoPA2oqzu4deAAAsE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22467-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D4A06732F0

When pnfs_report_layoutstat() calls pnfs_get_layout_hdr() and passes
the reference through the inode field of the layoutstats data to
nfs42_proc_layoutstats_generic(), if rpc_run_task() in that function
fails (IS_ERR), nfs42_proc_layoutstats_generic() returns immediately
without releasing the reference.  This leaks the layout header
reference, leaks the allocated data, and leaves the
NFS_INO_LAYOUTSTATS flag stuck on the inode, preventing further
layoutstat reporting.

Fix by calling nfs42_layoutstat_release(data) before returning on
rpc_run_task() error, matching the existing error handling for a
missing inode.

Cc: stable@vger.kernel.org
Fixes: be3a5d233922 ("NFSv.2/pnfs Add a LAYOUTSTATS rpc function")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 fs/nfs/nfs42proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7602ede6f75f..7637ad894563 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1076,8 +1076,10 @@ int nfs42_proc_layoutstats_generic(struct nfs_server *server,
 	nfs4_init_sequence(server->nfs_client, &data->args.seq_args,
 			   &data->res.seq_res, 0, 0);
 	task = rpc_run_task(&task_setup);
-	if (IS_ERR(task))
+	if (IS_ERR(task)) {
+		nfs42_layoutstat_release(data);
 		return PTR_ERR(task);
+	}
 	rpc_put_task(task);
 	return 0;
 }
-- 
2.50.1 (Apple Git-155)


