Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C14239ABFF
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFCUwi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCUwi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:52:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D90F2613E7;
        Thu,  3 Jun 2021 20:50:52 +0000 (UTC)
Subject: [PATCH 03/29] lockd: Common NLM XDR helpers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:50:52 -0400
Message-ID: <162275345217.32691.12086548088820348898.stgit@klimt.1015granger.net>
In-Reply-To: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
References: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a .h file containing xdr_stream-based XDR helpers common to both
NLMv3 and NLMv4.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcxdr.h |  151 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 fs/lockd/svcxdr.h

diff --git a/fs/lockd/svcxdr.h b/fs/lockd/svcxdr.h
new file mode 100644
index 000000000000..c69a0bb76c94
--- /dev/null
+++ b/fs/lockd/svcxdr.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Encode/decode NLM basic data types
+ *
+ * Basic NLMv3 XDR data types are not defined in an IETF standards
+ * document.  X/Open has a description of these data types that
+ * is useful.  See Chapter 10 of "Protocols for Interworking:
+ * XNFS, Version 3W".
+ *
+ * Basic NLMv4 XDR data types are defined in Appendix II.1.4 of
+ * RFC 1813: "NFS Version 3 Protocol Specification".
+ *
+ * Author: Chuck Lever <chuck.lever@oracle.com>
+ *
+ * Copyright (c) 2020, Oracle and/or its affiliates.
+ */
+
+#ifndef _LOCKD_SVCXDR_H_
+#define _LOCKD_SVCXDR_H_
+
+static inline bool
+svcxdr_decode_stats(struct xdr_stream *xdr, __be32 *status)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, XDR_UNIT);
+	if (!p)
+		return false;
+	*status = *p;
+
+	return true;
+}
+
+static inline bool
+svcxdr_encode_stats(struct xdr_stream *xdr, __be32 status)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT);
+	if (!p)
+		return false;
+	*p = status;
+
+	return true;
+}
+
+static inline bool
+svcxdr_decode_string(struct xdr_stream *xdr, char **data, unsigned int *data_len)
+{
+	__be32 *p;
+	u32 len;
+
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		return false;
+	if (len > NLM_MAXSTRLEN)
+		return false;
+	p = xdr_inline_decode(xdr, len);
+	if (!p)
+		return false;
+	*data_len = len;
+	*data = (char *)p;
+
+	return true;
+}
+
+/*
+ * NLM cookies are defined by specification to be a variable-length
+ * XDR opaque no longer than 1024 bytes. However, this implementation
+ * limits their length to 32 bytes, and treats zero-length cookies
+ * specially.
+ */
+static inline bool
+svcxdr_decode_cookie(struct xdr_stream *xdr, struct nlm_cookie *cookie)
+{
+	__be32 *p;
+	u32 len;
+
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		return false;
+	if (len > NLM_MAXCOOKIELEN)
+		return false;
+	if (!len)
+		goto out_hpux;
+
+	p = xdr_inline_decode(xdr, len);
+	if (!p)
+		return false;
+	cookie->len = len;
+	memcpy(cookie->data, p, len);
+
+	return true;
+
+	/* apparently HPUX can return empty cookies */
+out_hpux:
+	cookie->len = 4;
+	memset(cookie->data, 0, 4);
+	return true;
+}
+
+static inline bool
+svcxdr_encode_cookie(struct xdr_stream *xdr, const struct nlm_cookie *cookie)
+{
+	__be32 *p;
+
+	if (xdr_stream_encode_u32(xdr, cookie->len) < 0)
+		return false;
+	p = xdr_reserve_space(xdr, cookie->len);
+	if (!p)
+		return false;
+	memcpy(p, cookie->data, cookie->len);
+
+	return true;
+}
+
+static inline bool
+svcxdr_decode_owner(struct xdr_stream *xdr, struct xdr_netobj *obj)
+{
+	__be32 *p;
+	u32 len;
+
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		return false;
+	if (len > XDR_MAX_NETOBJ)
+		return false;
+	p = xdr_inline_decode(xdr, len);
+	if (!p)
+		return false;
+	obj->len = len;
+	obj->data = (u8 *)p;
+
+	return true;
+}
+
+static inline bool
+svcxdr_encode_owner(struct xdr_stream *xdr, const struct xdr_netobj *obj)
+{
+	unsigned int quadlen = XDR_QUADLEN(obj->len);
+	__be32 *p;
+
+	if (xdr_stream_encode_u32(xdr, obj->len) < 0)
+		return false;
+	p = xdr_reserve_space(xdr, obj->len);
+	if (!p)
+		return false;
+	p[quadlen - 1] = 0;	/* XDR pad */
+	memcpy(p, obj->data, obj->len);
+
+	return true;
+}
+
+#endif /* _LOCKD_SVCXDR_H_ */


