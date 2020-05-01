Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0958C1C0DFD
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 08:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgEAGWp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 02:22:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27465 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728126AbgEAGWp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 02:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588314164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BoTBgggpU8NL8r7V5cVTwFDIt+EnRLA6YPyOr17wFSs=;
        b=T11NIQ/lBr3iQlUCG6xDEsdVwjdJVlLit9iATOfPUvYdckQAI5rI7agMF8yLVQIrjdLk5D
        oClD4NoCyir/3lUUiWCkFmS1qZU9df5hahhQmzbFpsr5NeHqTVtNLtdHaq0mQuRtuyuXmk
        VsH4l23oYe26bAXT4pNGVPmYIU2DjE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-qbtqjVoQP_mUhtj0CsW39w-1; Fri, 01 May 2020 02:22:39 -0400
X-MC-Unique: qbtqjVoQP_mUhtj0CsW39w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C2621895A28
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 06:22:38 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.74.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 628021002382;
        Fri,  1 May 2020 06:22:34 +0000 (UTC)
From:   Kenneth D'souza <kdsouza@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     bfields@redhat.com, kdsouza@redhat.com, agaikwad@redhat.com
Subject: [PATCH] nfsd4: Make "info" file json compatible.
Date:   Fri,  1 May 2020 11:52:30 +0530
Message-Id: <20200501062230.19693-1-kdsouza@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently the output returned by client_info_show() is not
pure json, fix it so user space can pass the file properly.

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
---
 fs/nfsd/nfs4state.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c107caa56525..f2a14f95ffa6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2341,19 +2341,24 @@ static int client_info_show(struct seq_file *m, v=
oid *v)
 	if (!clp)
 		return -ENXIO;
 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
-	seq_printf(m, "clientid: 0x%llx\n", clid);
-	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr=
);
-	seq_printf(m, "name: ");
+	seq_printf(m, "{\n");
+	seq_printf(m, "\t\"clientid\": \"0x%llx\",\n", clid);
+	seq_printf(m, "\t\"address\": \"%pISpc\",\n", (struct sockaddr *)&clp->=
cl_addr);
+	seq_printf(m, "\t\"name\": ");
 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
-	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
+	seq_printf(m, ", ");
+	seq_printf(m, "\n\t\"minor version\": %d,\n", clp->cl_minorversion);
 	if (clp->cl_nii_domain.data) {
-		seq_printf(m, "Implementation domain: ");
+		seq_printf(m, "\t\"Implementation domain\": ");
 		seq_quote_mem(m, clp->cl_nii_domain.data,
 					clp->cl_nii_domain.len);
-		seq_printf(m, "\nImplementation name: ");
+		seq_printf(m, ", ");
+		seq_printf(m, "\n\t\"Implementation name\": ");
 		seq_quote_mem(m, clp->cl_nii_name.data, clp->cl_nii_name.len);
-		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
+		seq_printf(m, ", ");
+		seq_printf(m, "\n\t\"Implementation time\": \"[%lld, %ld]\"\n",
 			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
+		seq_printf(m, "}\n");
 	}
 	drop_client(clp);
=20
--=20
2.21.1

