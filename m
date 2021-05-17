Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAED386B60
	for <lists+linux-nfs@lfdr.de>; Mon, 17 May 2021 22:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhEQUbJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 May 2021 16:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234249AbhEQUbH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 May 2021 16:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621283390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=TMRLkyQIIL/jKTOWEBP4faEmTsG2NdYmd6F+Nt9noWo=;
        b=aru0i8+IGJJKn8WE+Lyqk1do023yJWl6Dw+JmYt+mTjkLKyiOjnalImgZlagfFLUjDT5uN
        EJbXZTlkVq2cbsVhP/Y2FrteEEH060zVLyQX+cV4XZliZM+43/JM4nOnXIoPagg1lgDj1D
        EJGOZYIRVbnBB0k8P2Y1rBnNikw+BYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-XkE700rzO-qCL6cuG5VS_A-1; Mon, 17 May 2021 16:29:49 -0400
X-MC-Unique: XkE700rzO-qCL6cuG5VS_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3799A803626;
        Mon, 17 May 2021 20:29:48 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-119-128.rdu2.redhat.com [10.10.119.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCF9E5D6D7;
        Mon, 17 May 2021 20:29:47 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] nfsd4: Expose the callback address and state of each NFS4 client
Date:   Mon, 17 May 2021 16:29:45 -0400
Message-Id: <1621283385-24390-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1621283385-24390-1-git-send-email-dwysocha@redhat.com>
References: <1621283385-24390-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In addition to the client's address, display the callback channel
state and address in the 'info' file.  Define and use a common
function for this information that can be used by both callback
trace events and the NFS4 client 'info' file.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfsd/nfs4state.c |  2 ++
 fs/nfsd/trace.c     | 15 +++++++++++++++
 fs/nfsd/trace.h     |  9 ++-------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b2573d3ecd3c..f3b8221bb543 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2385,6 +2385,8 @@ static int client_info_show(struct seq_file *m, void *v)
 		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
 			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
 	}
+	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
+	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
 	drop_client(clp);
 
 	return 0;
diff --git a/fs/nfsd/trace.c b/fs/nfsd/trace.c
index f008b95ceec2..6291b5d10824 100644
--- a/fs/nfsd/trace.c
+++ b/fs/nfsd/trace.c
@@ -2,3 +2,18 @@
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
+
+const char *cb_state2str(const int state)
+{
+	switch (state) {
+	case NFSD4_CB_UP:
+		return "UP";
+	case NFSD4_CB_UNKNOWN:
+		return "UNKNOWN";
+	case NFSD4_CB_DOWN:
+		return "DOWN";
+	case NFSD4_CB_FAULT:
+		return "FAULT";
+	}
+	return "UNDEFINED";
+}
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 10cc3aaf1089..8908d48b2aa6 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -876,12 +876,7 @@
 	TP_printk("client %08x:%08x", __entry->cl_boot, __entry->cl_id)
 )
 
-#define show_cb_state(val)						\
-	__print_symbolic(val,						\
-		{ NFSD4_CB_UP,		"UP" },				\
-		{ NFSD4_CB_UNKNOWN,	"UNKNOWN" },			\
-		{ NFSD4_CB_DOWN,	"DOWN" },			\
-		{ NFSD4_CB_FAULT,	"FAULT"})
+const char *cb_state2str(const int state);
 
 DECLARE_EVENT_CLASS(nfsd_cb_class,
 	TP_PROTO(const struct nfs4_client *clp),
@@ -901,7 +896,7 @@
 	),
 	TP_printk("addr=%pISpc client %08x:%08x state=%s",
 		__entry->addr, __entry->cl_boot, __entry->cl_id,
-		show_cb_state(__entry->state))
+		cb_state2str(__entry->state))
 );
 
 #define DEFINE_NFSD_CB_EVENT(name)			\
-- 
1.8.3.1

