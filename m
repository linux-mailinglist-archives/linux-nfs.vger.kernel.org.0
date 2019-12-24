Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9702612A25E
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2019 15:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfLXOgf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Dec 2019 09:36:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34000 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfLXOge (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Dec 2019 09:36:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id z22so16160260ljg.1;
        Tue, 24 Dec 2019 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=/+YjS98Z9lwGK4xAtM+uHlhw7vC65cvgwuOwRf+cKv8=;
        b=LcXQ49j9nMxaAtMUCiy3D861QVGqLzjtMMfejFuiI+WrDjyKPrpMqBwCK7/aFRcGY4
         rB1dIwxRW/onbueUeIAvymTVf2tW07/AwwMVX7Tb800xESyXk78lquiC1/tTUAikbJ3z
         BeVkICbxoxOUeHepLe+X0JwzcRwocJJ75qIV9g4Ad/VodgHtyGWrHi0wSjGcnvLPw3+a
         8jLJ4K7/l144SBDNBgMFU/kGqq2th507b4Or36PCWO6HL7z6p/STai8r49PxZb20I6y+
         5/fXTZoVrF7Yye9sKTt53r8uqZ5ZPze9xiOunKs+upP2ig9RP0OMolYj9q18hJwupr+8
         m1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=/+YjS98Z9lwGK4xAtM+uHlhw7vC65cvgwuOwRf+cKv8=;
        b=EwfWNCnlApzsZ7WVu65eciFckrT/3i+6sE3v3g7+Y5UHhuRqTIG5lP5s/PU0n138KL
         Z/PndXchoWIOMQYQbUXZPPkaNz2B0h8SFSoY2dMlGY1hLGixevACdwStib12+fbZREvD
         zBOv8XFgW0+m26G3aKA0o9Vnpx+/tnZ1XUGlMTSa1CFJFXO7w90Ru0iC0yvVUQ18BAmH
         LON7MfPs7nCgGmgjKJ4wJYzDOChyMd/3T8gXiqIF8zUyK6uVVyT+mbAdJDf49HfasEwy
         oGiPNe0FFfMzuUCgahUnjBCLbaqH9J2IKHQrTOCMIPI2umwSMkZtz0+2rEit0XdYQC8A
         fo6Q==
X-Gm-Message-State: APjAAAU3P/tK3jVt2ABJ/Joyi9W0BFNJ0+2CLdDUAo9myKkP0NfDwFCk
        vatZqOKvBgVLA5lQ43dgjZxqtXxEarM=
X-Google-Smtp-Source: APXvYqxGyd+HGVG1hizaf+ozPOcB/EjrLVF5gjv1Ltb04bhDlsiUSXUY2WMUcJ496kjlT+swZmtLPw==
X-Received: by 2002:a2e:b1c3:: with SMTP id e3mr20781533lja.137.1577198192208;
        Tue, 24 Dec 2019 06:36:32 -0800 (PST)
Received: from loulrmilkow1 (227.46-29-148.tkchopin.pl. [46.29.148.227])
        by smtp.gmail.com with ESMTPSA id l22sm5539885ljj.44.2019.12.24.06.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 06:36:31 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>
Cc:     "'Trond Myklebust'" <trond.myklebust@hammerspace.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease
Date:   Tue, 24 Dec 2019 14:36:31 -0000
Message-ID: <001901d5ba67$8954ede0$9bfec9a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdW6ZxKSwNGVh9l6R3GFPFG08PYEHA==
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Robert Milkowski <rmilkowski@gmail.com>

Currently, each time nfs4_do_fsinfo() is called it will do an implicit
NFS4 lease renewal, which is not compliant with the NFS4 specification.
This can result in a lease being expired by an NFS server.

Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
---
 fs/nfs/nfs4proc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d3716..b6cad9a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5016,19 +5016,23 @@ static int _nfs4_do_fsinfo(struct nfs_server *server, struct nfs_fh *fhandle,
 
 static int nfs4_do_fsinfo(struct nfs_server *server, struct nfs_fh *fhandle, struct nfs_fsinfo *fsinfo)
 {
+	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
-	unsigned long now = jiffies;
+	unsigned long last_renewal = jiffies;
 	int err;
 
 	do {
 		err = _nfs4_do_fsinfo(server, fhandle, fsinfo);
 		trace_nfs4_fsinfo(server, fhandle, fsinfo->fattr, err);
 		if (err == 0) {
-			nfs4_set_lease_period(server->nfs_client,
+			/* no implicit lease renewal allowed here for v4.0 */
+			if (clp->cl_minorversion == 0 && clp->cl_last_renewal != 0)
+				last_renewal = clp->cl_last_renewal;
+			nfs4_set_lease_period(clp,
 					fsinfo->lease_time * HZ,
-					now);
+					last_renewal);
 			break;
 		}
 		err = nfs4_handle_exception(server, err, &exception);
-- 
1.8.3.1


