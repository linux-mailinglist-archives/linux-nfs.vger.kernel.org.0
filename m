Return-Path: <linux-nfs+bounces-9266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B948A12F26
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 00:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C703D3A5F39
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824D11DD9AC;
	Wed, 15 Jan 2025 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlDhPfDL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246C1D89F1
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983458; cv=none; b=Un8xVz43ZEo9p/O0cEDdD5JM3FBLdD5mGkJyi6Y0dcIKWxwm00IQmvSoiSwR6VJlR5AnIXnkUTWsk3rUZDMwDpqYTc3qrlg3uQjs3zWUBfIMci50vyWMrqgXffmIym5lEM9IVludm0uxE+qwHAe2Xi7gC/+6MUUZjuY1grMDhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983458; c=relaxed/simple;
	bh=wdAL3AmdxgQyk4/kkFdGs2uiFSmUu0ohUcOvOppAhgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VYMWjCe3FUtCMmGCSwGZIua3x0RhLxmvbXM1m/R/nSLV6N6/w/PA9D22mcUbWMm8+ZeFixhaygDNcy2xhIvqnhNkq4oyTlHMZYTpGY0RMmeyyqjINkqeMK26+pth3sSfuW0qSngGFBOns+K/a4gS+D/zsf0+Avmplt5G+KYfXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlDhPfDL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736983455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okJ2iBJnvdGXT865beEMteDRB0jkKmfgn98JZvOqWS8=;
	b=LlDhPfDLTJdjbhL3vx8lLuCDO8Ya+hFXgHq1DDJyOhz8LnsfWidQJJGTKtOBgWvQvv1I3i
	lboSCNeohQmaxQ99/R0BEfU/u0+upsYlPiCyBt7iATu/SNNfZdl3tKd+srM2ZNEeiUl851
	OQv+bMfAnQxIT0iRA/xqh/0N9fIUZMQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-Ha82_0aONy6MS7CbtthNTQ-1; Wed,
 15 Jan 2025 18:24:14 -0500
X-MC-Unique: Ha82_0aONy6MS7CbtthNTQ-1
X-Mimecast-MFC-AGG-ID: Ha82_0aONy6MS7CbtthNTQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A6BB19560BB;
	Wed, 15 Jan 2025 23:24:13 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 246B030001BE;
	Wed, 15 Jan 2025 23:24:11 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/3] llist: add ability to remove a particular entry from the list
Date: Wed, 15 Jan 2025 18:24:04 -0500
Message-Id: <20250115232406.44815-2-okorniev@redhat.com>
In-Reply-To: <20250115232406.44815-1-okorniev@redhat.com>
References: <20250115232406.44815-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

nfsd stores its network transports in a lwq (which is a lockless list)
llist has no ability to remove a particular entry which nfsd needs
to remove a listener thread.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 include/linux/llist.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 2c982ff7475a..fe6be21897d9 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -253,6 +253,42 @@ static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
 	return __llist_add_batch(new, new, head);
 }
 
+/**
+ * llist_del_entry - remove a particular entry from a lock-less list
+ * @head: head of the list to remove the entry from
+ * @entry: entry to be removed from the list
+ *
+ * Walk the list, find the given entry and remove it from the list.
+ * The caller must ensure that nothing can race in and change the
+ * list while this is running.
+ *
+ * Returns true if the entry was found and removed.
+ */
+static inline bool llist_del_entry(struct llist_head *head, struct llist_node *entry)
+{
+	struct llist_node *pos;
+
+	if (!head->first)
+		return false;
+
+	/* Is it the first entry? */
+	if (head->first == entry) {
+		head->first = entry->next;
+		entry->next = entry;
+		return true;
+	}
+
+	/* Find it in the list */
+	llist_for_each(head->first, pos) {
+		if (pos->next == entry) {
+			pos->next = entry->next;
+			entry->next = entry;
+			return true;
+		}
+	}
+	return false;
+}
+
 /**
  * llist_del_all - delete all entries from lock-less list
  * @head:	the head of lock-less list to delete all entries
-- 
2.47.1


