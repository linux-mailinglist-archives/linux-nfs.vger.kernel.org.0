Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FECEE2247
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 20:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbfJWSCc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 14:02:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40526 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732839AbfJWSCc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 14:02:32 -0400
Received: by mail-io1-f65.google.com with SMTP id p6so17847116iod.7
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=beourHHK3Tt/w32cLN284QNtyjqBFbo7qRssvfUyxD8=;
        b=cIvE58oeLc4RmK79wdXSZ1jS3/T+9Ea+R4y98zDkfePE+QB54WBBnRk5ezPebjiaqp
         u847e93rikcnYdrxHE8sptEMMZ6f7uMPjLTr76sp5FKhzQHcO2JlmxroHHHjGtfEhnl+
         +jz6D3fcPvQNZBfHU8wk/W99DD6zyY3TgdWc8H/P0QQ71bSOL4GBf+k4txbRZPmlm34f
         yoA6qaUKz/aGGoKgPhnFwsNKuP2nTz6mk7vTFq7PI4F/sC6uPyBf8aUiuQBgNZOuk8Nw
         J9Wlm+AL7/t4dDRlsy3a8DvlcEnBcFMVL20zv2chAIoKBXDHmgJEkDUjVmcasvvUT/Th
         KojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=beourHHK3Tt/w32cLN284QNtyjqBFbo7qRssvfUyxD8=;
        b=t9zLN9uGKJCaM9fB8cr2gYI3oiYTJERDBKzb2smmkDcFD5Pzhb7+SEPRDuPCI6uqt2
         EfB4WSU0AF7OoIgdg0Gg7xIRbqKigwzmCyQV2RDpty7uB0bsm8arm7Czfn8xjG0+J9fZ
         3Tu3bnJigaIvwcPWeaEKVsdK41z12kuwenVZu3icUiPPpgGumNM5d7rpr8MhaS8vKH3F
         E+3XNEXeJy2UJB4+kKqHtkzqdUV9JdvvknMkmD7VgsE7eWJIp4d+yynNma7JCtIQ7Dlt
         HGZRoqyjDBUK18WAkp/Bt263q1b5Zv1gNZvb9kEQGpVdaC3SJBdXsvsrf/y5OXwpCYzW
         RUzw==
X-Gm-Message-State: APjAAAUhYgVTQLXwk4PB331FritOUhfZ9oe5g7YXsZ6mJsL0jF2laVuq
        9AXeZN0jGMUk2fTJrJqvZ5odQz/l
X-Google-Smtp-Source: APXvYqx3b3gZoW6S34gDoIgb75qEdEIUnDAv2dDlr9LBoqDYhnmROZ71pUrYAMP3v5N3XUzoN7ygZw==
X-Received: by 2002:a5e:d904:: with SMTP id n4mr4568454iop.186.1571853750269;
        Wed, 23 Oct 2019 11:02:30 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e67sm2356363ill.42.2019.10.23.11.02.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 11:02:29 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x9NI2SjY012960
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 18:02:28 GMT
Subject: [PATCH RFC 2/2] NFS4: Report callback authentication errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 23 Oct 2019 14:02:28 -0400
Message-ID: <20191023180228.6450.9132.stgit@manet.1015granger.net>
In-Reply-To: <20191023180049.6450.65440.stgit@manet.1015granger.net>
References: <20191023180049.6450.65440.stgit@manet.1015granger.net>
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
index 73a5a5e..7066826 100644
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
index b2f395f..b86f3f5 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -598,6 +598,41 @@
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

