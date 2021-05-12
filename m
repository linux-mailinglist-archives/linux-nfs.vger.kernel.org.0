Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0A37CAE7
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbhELQcs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239083AbhELQHR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:07:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B01261D0F;
        Wed, 12 May 2021 15:36:02 +0000 (UTC)
Subject: [PATCH v2 10/25] NFSD: Add an RPC authflavor tracepoint display
 helper
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:36:01 -0400
Message-ID: <162083376150.3108.15103579597974596896.stgit@klimt.1015granger.net>
In-Reply-To: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To be used in subsequent patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index cef826f64575..7ccf17077c3b 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -878,6 +878,22 @@ DEFINE_NFSD_CB_EVENT(setup);
 DEFINE_NFSD_CB_EVENT(state);
 DEFINE_NFSD_CB_EVENT(shutdown);
 
+TRACE_DEFINE_ENUM(RPC_AUTH_NULL);
+TRACE_DEFINE_ENUM(RPC_AUTH_UNIX);
+TRACE_DEFINE_ENUM(RPC_AUTH_GSS);
+TRACE_DEFINE_ENUM(RPC_AUTH_GSS_KRB5);
+TRACE_DEFINE_ENUM(RPC_AUTH_GSS_KRB5I);
+TRACE_DEFINE_ENUM(RPC_AUTH_GSS_KRB5P);
+
+#define show_nfsd_authflavor(val)					\
+	__print_symbolic(val,						\
+		{ RPC_AUTH_NULL,		"none" },		\
+		{ RPC_AUTH_UNIX,		"sys" },		\
+		{ RPC_AUTH_GSS,			"gss" },		\
+		{ RPC_AUTH_GSS_KRB5,		"krb5" },		\
+		{ RPC_AUTH_GSS_KRB5I,		"krb5i" },		\
+		{ RPC_AUTH_GSS_KRB5P,		"krb5p" })
+
 TRACE_EVENT(nfsd_cb_setup_err,
 	TP_PROTO(
 		const struct nfs4_client *clp,


