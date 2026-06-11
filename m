Return-Path: <linux-nfs+bounces-22465-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3JMILrXPKmpExQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22465-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:09:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C2B672F3A
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:09:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22465-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22465-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 300233144989
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BD73EFD14;
	Thu, 11 Jun 2026 15:04:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40C3EFFDC;
	Thu, 11 Jun 2026 15:03:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190242; cv=none; b=fMT116XcTAfGD1KdE4r1M2dlUiu1FvYIoIz3WTR/k6qbF+5u4YEHpv6ZtDL0wELwvAok0IPhZjuE24GBvywEUkcsE3uFHeVeyWL+E+VKAZQcmLinCWxLiGJetj7aHUA7vByHq9ZuEk6aFtiQ+UpoIlixU6IdwXacyu5/3a43uas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190242; c=relaxed/simple;
	bh=E/L9NW3Sj8d3/sowxE/wcEU8GspbVJT0M3nxIyY9t1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1CGpd7uQnIwFA9NwLAURnGUN8wdhS2nGrksAHCN4S7FCYBIBItKUStf9QgMtXSBTWzlsE6cDMbQ2cBp/AVpaulg1JG13PuIpCDY6cnC6+mwqli6iVUm/ikgXrbD07MvuBsjcQ7XtH3XBadUEgjVopozMIN1OpJrVvoUryrZ4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowACnCt5czipqHSAYEw--.25148S2;
	Thu, 11 Jun 2026 23:03:57 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] NFS: fix refcount leak in nfs_direct_write_schedule_iovec()
Date: Thu, 11 Jun 2026 23:03:54 +0800
Message-ID: <20260611150354.90801-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnCt5czipqHSAYEw--.25148S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JF1xAFy7uF47Zr13Cw18uFg_yoW8JrW7pr
	W09ry7KFn5ArWxtr97ZF1xZw17uFZ2vrW3Jr48Aw4xZrn5GF13ZFyjqa45XF1Ykrs5JFWU
	Zrs8K3W7A3WjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfsqAUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgPA2oqh3jZWAAAs2
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
	TAGGED_FROM(0.00)[bounces-22465-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24C2B672F3A

When nfs_direct_write_schedule_iovec() fails to start any write
operations (requested_bytes == 0), it bails out after calling
inode_dio_end() but before releasing the dreq->io_count reference
that was unconditionally acquired by get_dreq().  The normal
success path balances that via put_dreq(), which decrements the
io_count and eventually calls nfs_direct_write_complete().  The
leaked reference prevents proper cleanup of the direct write request.

Add the missing put_dreq() in the early exit path before calling
nfs_direct_req_release().

Cc: stable@vger.kernel.org
Fixes: 65caafd0d214 ("SUNRPC reverting d03727b248d0 ("NFSv4 fix CLOSE not waiting for direct IO compeletion")")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 fs/nfs/direct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 41a6cabb0592..99bd72a4601c 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -956,6 +956,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 	 */
 	if (requested_bytes == 0) {
 		inode_dio_end(inode);
+		put_dreq(dreq);
 		nfs_direct_req_release(dreq);
 		return result < 0 ? result : -EIO;
 	}
-- 
2.50.1 (Apple Git-155)


