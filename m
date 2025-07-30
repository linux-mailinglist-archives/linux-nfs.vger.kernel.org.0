Return-Path: <linux-nfs+bounces-13322-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC2B1676B
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 22:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401201898437
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 20:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5736E21B195;
	Wed, 30 Jul 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4ZTh0SW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5537204C0F
	for <linux-nfs@vger.kernel.org>; Wed, 30 Jul 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906166; cv=none; b=dMYxZVauwNNRkn/DHpu/9Cn5743oLkaIAi/5rbhbI2Ag0a2JKmmbQelsiK29K41KdtQWS5lWV620oMY79XDD49G2ZmkP2p+QbKSXVRbkNV867t6PCgx/D6sl/3xLlQgQQa0A82xlvYGifm5ELO5l9/zXjD/mWinZP9h4FIn63gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906166; c=relaxed/simple;
	bh=l9q1KhydXYLZiJVg4gebha3IYzAEKW/jLvTcITgGeaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BN2deI7Nqvoac+olSJby86wJOpHX3d1lQJUYSyEIj7cttkxuwU+Pw3C2Yi6X7zHa+UABrS+UHoicymkYSjp1AwYGCYgqJQY3QY3x+fpVIPxPfsQ3SZqy5HFvJ+1Q9pSPdYmR09cZbDXaoyaHERNpmnCAJerpEMf+ai9cuzU5gLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4ZTh0SW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753906163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwlSYH4pHXJHS23Q958HAkOdcfwX7Ed+I4j1/OG/8XM=;
	b=e4ZTh0SWA52KYGQ/hfOjmQReC+T3iPYsEE980v7Luby/9nZLgPx4HBcpCXvUaS7w0Q8jIq
	pYns7Yon6TV1GMG9u0i5zh5OQseovSMQWCbW3x9vxT/86FlXyRAHJGeMYib90lMmiIjGO5
	sFJAd/9Fyk90x64dCCnbM68k5UgMTMA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-PaztnwTWNkGbbyxUEbxixA-1; Wed,
 30 Jul 2025 16:09:16 -0400
X-MC-Unique: PaztnwTWNkGbbyxUEbxixA-1
X-Mimecast-MFC-AGG-ID: PaztnwTWNkGbbyxUEbxixA_1753906151
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E026189C318;
	Wed, 30 Jul 2025 20:09:04 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.90.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16AD919560BE;
	Wed, 30 Jul 2025 20:08:59 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@hammerspace.com,
	anna.schumaker@oracle.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	hare@suse.de,
	horms@kernel.org,
	kbusch@kernel.org
Subject: [PATCH 3/4] nvmet-tcp: fix handling of tls alerts
Date: Wed, 30 Jul 2025 16:08:34 -0400
Message-Id: <20250730200835.80605-4-okorniev@redhat.com>
In-Reply-To: <20250730200835.80605-1-okorniev@redhat.com>
References: <20250730200835.80605-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Revert kvec msg iterator before trying to process a TLS alert
when possible.

In nvmet_tcp_try_recv_data(), it's assumed that no msg control
message buffer is set prior to sock_recvmsg(). Hannes suggested
that upon detecting that TLS control message is received log a
message and error out. Left comments in the code for the future
improvements.

Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
Suggested-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Hannes Reinecky <hare@susu.de>
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 drivers/nvme/target/tcp.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 688033b88d38..055e420d3f2e 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1161,6 +1161,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
+		iov_iter_revert(&msg.msg_iter, len);
 		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 		if (ret < 0)
 			return ret;
@@ -1217,19 +1218,28 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
 static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd  *cmd = queue->cmd;
-	int len, ret;
+	int len;
 
 	while (msg_data_left(&cmd->recv_msg)) {
+		/* to detect that we received a TlS alert, we assumed that
+		 * cmg->recv_msg's control buffer is not setup. kTLS will
+		 * return an error when no control buffer is set and
+		 * non-tls-data payload is received.
+		 */
 		len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
 			cmd->recv_msg.msg_flags);
+		if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
+			if (len == 0 || len == -EIO) {
+				pr_err("queue %d: unhandled control message\n",
+				       queue->idx);
+				/* note that unconsumed TLS control message such
+				 * as TLS alert is still on the socket.
+				 */
+				return -EAGAIN;
+			}
+		}
 		if (len <= 0)
 			return len;
-		if (queue->tls_pskid) {
-			ret = nvmet_tcp_tls_record_ok(cmd->queue,
-					&cmd->recv_msg, cmd->recv_cbuf);
-			if (ret < 0)
-				return ret;
-		}
 
 		cmd->pdu_recv += len;
 		cmd->rbytes_done += len;
@@ -1267,6 +1277,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
+		iov_iter_revert(&msg.msg_iter, len);
 		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 		if (ret < 0)
 			return ret;
@@ -1453,10 +1464,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
-	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
-		c->recv_msg.msg_control = c->recv_cbuf;
-		c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
-	}
 	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	list_add_tail(&c->entry, &queue->free_list);
@@ -1736,6 +1743,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
 		return len;
 	}
 
+	iov_iter_revert(&msg.msg_iter, len);
 	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 	if (ret < 0)
 		return ret;
-- 
2.47.1


