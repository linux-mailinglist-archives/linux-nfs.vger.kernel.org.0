Return-Path: <linux-nfs+bounces-13339-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D48B175ED
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 20:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EDE567CD4
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 18:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51590B644;
	Thu, 31 Jul 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hd25AoEj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB922F774
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984890; cv=none; b=OQyqsiIDFeZv5k1KjckbluNoom4uKrO/cAGqe3PgTpIN3HKWAUW6Y7h4HJmovmGoFMiLM6YRglYtTgFj2mk2G7HYIffDh6JoWSyMtxhphFnefxgf4CNKrsi7/pW0hUR+Lg4jw7sON+9fOssnu+vL8s0BYSVMNdupOB4gr9j4TCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984890; c=relaxed/simple;
	bh=Hzp7CeU9ZZCx4rScgTOoqgQtuHdjcuwqaM4I3/l1BJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RG5sB9jJf4NougZdVYMutJehZfXnbk+Y1+VVh8EQDofPgQ+JdoRSYiUKHDDSSmT+SsHJYJBCT0JTj9sJ5S6xpiPrUbXs/AejGJhEhGPnOwKwshMxWGbjr7Qfa26vtt8SmFouD3J3egFU0IwuStqFKKBni5mHx4+wmPGLxoyVw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hd25AoEj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753984887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgDTg6o9aZfig0iHBAAhNM0B4m3NdMq96NVOVqq6qlE=;
	b=Hd25AoEjuNvS/HgPFAL8BINQ9a4DoDy6kb5gGcWcwFeHDhTIaSw1Z8a5VDocBO+kD9iBXN
	YzsRyt0uS45lc3luXkbzexaZKW/6X6H+JCiZ3LUOGCLdWguO6Ou87FH+vsBVtAUC/cEVmz
	8j2YPrfgWXQpSRq4JgnuvCDSMk8P47A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-CKAe2FdYOz2Wb91LQcmHfA-1; Thu,
 31 Jul 2025 14:01:23 -0400
X-MC-Unique: CKAe2FdYOz2Wb91LQcmHfA-1
X-Mimecast-MFC-AGG-ID: CKAe2FdYOz2Wb91LQcmHfA_1753984879
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 144DB19560AF;
	Thu, 31 Jul 2025 18:01:19 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1788B30001B9;
	Thu, 31 Jul 2025 18:01:14 +0000 (UTC)
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
Subject: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
Date: Thu, 31 Jul 2025 14:00:57 -0400
Message-Id: <20250731180058.4669-4-okorniev@redhat.com>
In-Reply-To: <20250731180058.4669-1-okorniev@redhat.com>
References: <20250731180058.4669-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 drivers/nvme/target/tcp.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 688033b88d38..98cee10de713 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -120,7 +120,6 @@ struct nvmet_tcp_cmd {
 	u32				pdu_len;
 	u32				pdu_recv;
 	int				sg_idx;
-	char				recv_cbuf[CMSG_LEN(sizeof(char))];
 	struct msghdr			recv_msg;
 	struct bio_vec			*iov;
 	u32				flags;
@@ -1161,6 +1160,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
+		iov_iter_revert(&msg.msg_iter, len);
 		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 		if (ret < 0)
 			return ret;
@@ -1217,19 +1217,28 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
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
@@ -1267,6 +1276,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
+		iov_iter_revert(&msg.msg_iter, len);
 		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 		if (ret < 0)
 			return ret;
@@ -1453,10 +1463,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
-	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
-		c->recv_msg.msg_control = c->recv_cbuf;
-		c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
-	}
 	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	list_add_tail(&c->entry, &queue->free_list);
@@ -1736,6 +1742,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
 		return len;
 	}
 
+	iov_iter_revert(&msg.msg_iter, len);
 	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 	if (ret < 0)
 		return ret;
-- 
2.47.1


