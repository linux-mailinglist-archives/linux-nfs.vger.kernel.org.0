Return-Path: <linux-nfs+bounces-12917-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6BDAFBB30
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 20:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9870A3AF157
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FE0265CB2;
	Mon,  7 Jul 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdRWAljq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F6262FF8
	for <linux-nfs@vger.kernel.org>; Mon,  7 Jul 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913975; cv=none; b=if7OA3IefqKtBPkKsLQWzQ67KuO0NqffQqmsIegCt94fdeix2Df5cniCJhYFr0rcVTlYJOB0XBueKhlUStKhTquXSJ6RyV3Rh0JRGVC5q1b/yuOaxfSHQ55KUsKDg3PwEOraq2DLOaKjhWDQG8pBokhVy/0h0E/7yNBfxuZBpKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913975; c=relaxed/simple;
	bh=pN4FU4Ls/jrjh17+kg2Kx51Dh9JaiG7rlzwNilpX9Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2rNsdCubSd9L6WRRT7tcvS74XKBX7n3CyfbYY6TUILAQmZ59Pf+6MyGuwEcDQVLc44pgnxT789AwP8AStY+xAgBN00X6EPT2pMszMKdjYlN5TYjvHPcvT1aXyPIjZFlxlMiJHPcE653TKAKU9x3u0JTI0ZQe2GAw2YV03nAaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdRWAljq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751913972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7UaVXYkQoQ+lBXJKl8sj6Psnk2uGxXUYzji8T+Xouis=;
	b=BdRWAljqHjdqNqmirtrlpmLmT94PjLMoIU8HhE2ioiwYXhlEjd5fLVxaKHOgHS5iOPS0AO
	tcui6MqpeN75U1qqphfpt4Xjz1FZvZ6DF0F93zv6n6UFXjGpdNE1NLBNkhge42ofGHZbrv
	je5HgxQcy/stoKGK8lfxon3Hj6Mqp/Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-xcgKBE3dM9aXaWbE0eB13w-1; Mon,
 07 Jul 2025 14:46:09 -0400
X-MC-Unique: xcgKBE3dM9aXaWbE0eB13w-1
X-Mimecast-MFC-AGG-ID: xcgKBE3dM9aXaWbE0eB13w_1751913968
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF9CB18011FE;
	Mon,  7 Jul 2025 18:46:07 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A08C819560AB;
	Mon,  7 Jul 2025 18:46:06 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djeffery@redhat.com,
	loberman@redhat.com
Subject: [PATCH 1/2] workqueue: Add a helper to identify current workqueue
Date: Mon,  7 Jul 2025 14:46:03 -0400
Message-ID: <baad3adf8ea80b65d83dd196ab715992a0f1b768.1751913604.git.bcodding@redhat.com>
In-Reply-To: <cover.1751913604.git.bcodding@redhat.com>
References: <cover.1751913604.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Introduce a new helper current_workqueue() which returns the current task's
workqueue pointer or NULL if not a workqueue worker.

This will allow the NFS client to recognize the case where writeback occurs
within the nfsiod workqueue or is being submitted directly.  NFS would like
to change the GFP_ flags for memory allocation to avoid stalls or cycles in
memory pools based on which context writeback is occurring.  In a following
patch, this helper detects the case rather than checking the PF_WQ_WORKER
flag which can be passed along from another workqueue worker.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 6e30f275da77..29e1096e6dfa 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -623,6 +623,7 @@ extern void workqueue_set_max_active(struct workqueue_struct *wq,
 extern void workqueue_set_min_active(struct workqueue_struct *wq,
 				     int min_active);
 extern struct work_struct *current_work(void);
+extern struct workqueue_struct *current_workqueue(void);
 extern bool current_is_workqueue_rescuer(void);
 extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
 extern unsigned int work_busy(struct work_struct *work);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9f9148075828..a96eb209d5e0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6009,6 +6009,24 @@ struct work_struct *current_work(void)
 }
 EXPORT_SYMBOL(current_work);
 
+/**
+ * current_workqueue - retrieve %current task's work queue
+ *
+ * Determine if %current task is a workqueue worker and what workqueue it's
+ * working on.  Useful to find out the context that the %current task is
+ * running in.
+ *
+ * Return: workqueue_struct if %current task is a workqueue worker, %NULL
+ * otherwise.
+ */
+struct workqueue_struct *current_workqueue(void)
+{
+	struct worker *worker = current_wq_worker();
+
+	return worker ? worker->current_pwq->wq : NULL;
+}
+EXPORT_SYMBOL(current_workqueue);
+
 /**
  * current_is_workqueue_rescuer - is %current workqueue rescuer?
  *
-- 
2.47.0


