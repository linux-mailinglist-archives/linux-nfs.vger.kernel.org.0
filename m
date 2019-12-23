Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A188212983A
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2019 16:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLWP2l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Dec 2019 10:28:41 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33088 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfLWP2l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Dec 2019 10:28:41 -0500
Received: by mail-yb1-f193.google.com with SMTP id n66so7171372ybg.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2019 07:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WQftTBLNl0M4X4HXciAPQ457ib26AN31HI/060U2OEE=;
        b=jqpLdGyfKsB51pLeTu3gEzFNMSC7lnjyzyZb4YNvRj95WVxU6pdjWqp3X/PKHaodQb
         R8k8MyHoJ7e4X+88pruFkv3OMU8GAs67UqwZVo+i70ur/gKgMqlLF+3uoXgRQkyb+BgZ
         /uo9rDrDvPCR7I8XVid134nj2wLPQ/+vOj5gszhwnimq9i+PihTu5K2+KE5lz9jGh6fk
         BbsZWTmPbhI83XB7zhHm+eXGECQyCiyXnrTcxJIoUXLfOgc0Pr0J09gUd5hApilhSIns
         75P1rfL31mfLXQzqpmx0WYqnmplyn4u5dOrdicmXS9S/4DcdrhR5pcIArIyllPcnewST
         /O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WQftTBLNl0M4X4HXciAPQ457ib26AN31HI/060U2OEE=;
        b=qkeov8Q5gC16SXFngN4IX/G7uPTBuBQ0ff6MUIIReQmtSqvyXQk97L/kNo6dJ2uxJ0
         3jPitrdBOM6LwBsIKCAXNhilGHIdwNJoTOTJcnr8gg5N9yJJ5MK4Uf7VyauDaXE5v4JD
         95YZbstA/l4dj9jQwAz6M+yZdi7+k0kJ6mmo05SBZY+vi/KMz7shQv+1RzGTNgBoANaw
         l71b4YIZQ8E0LR9jEbA3a8iqHycDFlrKEX1MMuQYnPEbI5379OptFJYG0ra5jooeaHVB
         RB79v3NfNwYtKkeHssuR/DK0QicopL/wUc3jFfNkrrt+a0aCXKkbWDPtvkZ62fNRQtkD
         xiQA==
X-Gm-Message-State: APjAAAWrkgZoGMDanhsjWixus3n51oJxYZt/aR3aUrHLQ4RSe2KkFnRs
        cvENwtC0XGV16yuakaEpXEoiameZ
X-Google-Smtp-Source: APXvYqz86vc9iPk5dL3dex9WrL/p7umtvTtKSJpk/vF8SMP8RGapC/5JUTWDeIQKiMFU7yq1s5XyFw==
X-Received: by 2002:a25:7b44:: with SMTP id w65mr14248431ybc.77.1577114920251;
        Mon, 23 Dec 2019 07:28:40 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c66sm8060591ywf.96.2019.12.23.07.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 07:28:39 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id xBNFScTR008884;
        Mon, 23 Dec 2019 15:28:38 GMT
Subject: [PATCH v1 3/4] NFS4: Report callback authentication errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Dec 2019 10:28:38 -0500
Message-ID: <20191223152838.17724.37546.stgit@manet.1015granger.net>
In-Reply-To: <20191223152539.17724.52438.stgit@manet.1015granger.net>
References: <20191223152539.17724.52438.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This seems to be a somewhat common issue with Kerberos NFSv4.0
set-ups.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback_xdr.c |   11 ++++++++---
 fs/nfs/nfs4trace.h    |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 03a20f5716c7..79ff172eb1c8 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -18,6 +18,7 @@
 #include "callback.h"
 #include "internal.h"
 #include "nfs4session.h"
+#include "nfs4trace.h"
 
 #define CB_OP_TAGLEN_MAXSZ		(512)
 #define CB_OP_HDR_RES_MAXSZ		(2 * 4) // opcode, status
@@ -946,9 +947,13 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 
 	if (hdr_arg.minorversion == 0) {
 		cps.clp = nfs4_find_client_ident(SVC_NET(rqstp), hdr_arg.cb_ident);
-		if (!cps.clp || !check_gss_callback_principal(cps.clp, rqstp)) {
-			if (cps.clp)
-				nfs_put_client(cps.clp);
+		if (!cps.clp) {
+			trace_nfs_cb_no_clp(rqstp->rq_xid, hdr_arg.cb_ident);
+			goto out_invalidcred;
+		}
+		if (!check_gss_callback_principal(cps.clp, rqstp)) {
+			trace_nfs_cb_badprinc(rqstp->rq_xid, hdr_arg.cb_ident);
+			nfs_put_client(cps.clp);
 			goto out_invalidcred;
 		}
 	}
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index e60b6fbd5ada..e3586c16ef59 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -691,6 +691,41 @@
 		)
 );
 
+DECLARE_EVENT_CLASS(nfs4_cb_error_class,
+		TP_PROTO(
+			__be32 xid,
+			u32 cb_ident
+		),
+
+		TP_ARGS(xid, cb_ident),
+
+		TP_STRUCT__entry(
+			__field(u32, xid)
+			__field(u32, cbident)
+		),
+
+		TP_fast_assign(
+			__entry->xid = be32_to_cpu(xid);
+			__entry->cbident = cb_ident;
+		),
+
+		TP_printk(
+			"xid=0x%08x cb_ident=0x%08x",
+			__entry->xid, __entry->cbident
+		)
+);
+
+#define DEFINE_CB_ERROR_EVENT(name) \
+	DEFINE_EVENT(nfs4_cb_error_class, nfs_cb_##name, \
+			TP_PROTO( \
+				__be32 xid, \
+				u32 cb_ident \
+			), \
+			TP_ARGS(xid, cb_ident))
+
+DEFINE_CB_ERROR_EVENT(no_clp);
+DEFINE_CB_ERROR_EVENT(badprinc);
+
 DECLARE_EVENT_CLASS(nfs4_open_event,
 		TP_PROTO(
 			const struct nfs_open_context *ctx,

