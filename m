Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B16E3991F3
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 19:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhFBRx1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 13:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229679AbhFBRx1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 13:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622656303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s6UZKLgwhcMevilGdxiPCEz/FQqnIHgCCgrBhslF5Ps=;
        b=hDxUz9fRMtZrMGdQo3SGqJB3IlsLW7RAPsE/k5sEEMKuIEAMz0i2LppL120CCSvp4GnDit
        wmsfDqHSQUutLG5euxskI8PKtw8RGzkh1yMrlNfPq0hE5ewUC+RDqB236d8k/OI1P4sLMl
        jv5bCO0DNYU5Sq38wKbNw5+aTv4bSv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-xw5EqpMOPb-W5kVKAiDvtw-1; Wed, 02 Jun 2021 13:51:42 -0400
X-MC-Unique: xw5EqpMOPb-W5kVKAiDvtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 097563464C;
        Wed,  2 Jun 2021 17:51:41 +0000 (UTC)
Received: from f34-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF86D61008;
        Wed,  2 Jun 2021 17:51:40 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] nfsd4: Expose the callback address and state of each NFS4 client
Date:   Wed,  2 Jun 2021 13:51:39 -0400
Message-Id: <20210602175139.436357-2-dwysocha@redhat.com>
In-Reply-To: <20210602175139.436357-1-dwysocha@redhat.com>
References: <20210602175139.436357-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In addition to the client's address, display the callback channel
state and address in the 'info' file.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c404c6ec52af..967912b4a7dd 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2358,6 +2358,21 @@ static void seq_quote_mem(struct seq_file *m, char *data, int len)
 	seq_printf(m, "\"");
 }
 
+static const char *cb_state2str(int state)
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
+
 static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
@@ -2386,6 +2401,8 @@ static int client_info_show(struct seq_file *m, void *v)
 		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
 			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
 	}
+	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
+	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
 	drop_client(clp);
 
 	return 0;
-- 
2.31.1

