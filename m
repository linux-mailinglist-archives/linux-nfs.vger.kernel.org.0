Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64460381123
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhENT4h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232211AbhENT4g (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 15:56:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72BB161461;
        Fri, 14 May 2021 19:55:24 +0000 (UTC)
Subject: [PATCH v3 02/24] NFSD: Add an RPC authflavor tracepoint display
 helper
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org
Date:   Fri, 14 May 2021 15:55:23 -0400
Message-ID: <162102212372.10915.16884773556406844003.stgit@klimt.1015granger.net>
In-Reply-To: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
References: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
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
index 42ad2a02f953..1b50640cdf96 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -841,6 +841,22 @@ DEFINE_NFSD_CB_EVENT(setup);
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


