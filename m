Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6332DA47
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 20:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhCDTVz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 14:21:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232049AbhCDTVZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 14:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614885599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w8c5TIXwf2GBYdrRK9JPr1JvSg2LByaiuoMXcLsFy6Y=;
        b=BanX1CDL01bF1c2MmpoAR13EqvJNoUplHYIR7HlGXVbciYtOck6PW2a/6t9gb36vdIXEAt
        NdqcB6XCk2xl1a8GWoOKLktYXfLkjjzwkWc6UzIIli6X6UMay2fCox6yupnuQ5X67cLUrz
        JIaefeeYYNurFkOA127CbYkPGJ1Op1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-2gE1is_TPs2-1Vy3WegpnQ-1; Thu, 04 Mar 2021 14:19:57 -0500
X-MC-Unique: 2gE1is_TPs2-1Vy3WegpnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 582DB1018F76;
        Thu,  4 Mar 2021 19:19:56 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-112-125.rdu2.redhat.com [10.10.112.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 280D7627DC;
        Thu,  4 Mar 2021 19:19:56 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 63E311A003C; Thu,  4 Mar 2021 14:19:55 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     libtirpc-devel@lists.sourceforge.net
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] libtirpc: disallow calling auth_refresh from clnt_call with RPCSEC_GSS
Date:   Thu,  4 Mar 2021 14:19:55 -0500
Message-Id: <20210304191955.1928383-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Disallow calling auth_refresh from clnt_{dg,vc}_call if the client is
using RPCSEC_GSS.  Doing so can recurse back into clnt_{dg,vc}_call,
where we'll self-deadlock waiting on the condition variable.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 src/auth_gss.c       | 6 ++++++
 src/clnt_dg.c        | 8 ++++++++
 src/clnt_vc.c        | 9 +++++++++
 tirpc/rpc/auth_gss.h | 2 ++
 4 files changed, 25 insertions(+)

diff --git a/src/auth_gss.c b/src/auth_gss.c
index d871672..e317664 100644
--- a/src/auth_gss.c
+++ b/src/auth_gss.c
@@ -982,3 +982,9 @@ rpc_gss_max_data_length(AUTH *auth, int maxlen)
 	rpc_gss_clear_error();
 	return result;
 }
+
+bool_t
+is_authgss_client(CLIENT *clnt)
+{
+	return (clnt->cl_auth->ah_ops == &authgss_ops);
+}
diff --git a/src/clnt_dg.c b/src/clnt_dg.c
index abc09f1..e1255de 100644
--- a/src/clnt_dg.c
+++ b/src/clnt_dg.c
@@ -61,6 +61,9 @@
 #include <sys/uio.h>
 #endif
 
+#ifdef HAVE_RPCSEC_GSS
+#include <rpc/auth_gss.h>
+#endif
 
 #define MAX_DEFAULT_FDS                 20000
 
@@ -334,6 +337,11 @@ clnt_dg_call(cl, proc, xargs, argsp, xresults, resultsp, utimeout)
 		salen = cu->cu_rlen;
 	}
 
+#ifdef HAVE_RPCSEC_GSS
+	if (is_authgss_client(cl))
+		nrefreshes = 0;
+#endif
+
 	/* Clean up in case the last call ended in a longjmp(3) call. */
 call_again:
 	xdrs = &(cu->cu_outxdrs);
diff --git a/src/clnt_vc.c b/src/clnt_vc.c
index 6f7f7da..a07e297 100644
--- a/src/clnt_vc.c
+++ b/src/clnt_vc.c
@@ -69,6 +69,10 @@
 #include "rpc_com.h"
 #include "clnt_fd_locks.h"
 
+#ifdef HAVE_RPCSEC_GSS
+#include <rpc/auth_gss.h>
+#endif
+
 #define MCALL_MSG_SIZE 24
 
 #define CMGROUP_MAX    16
@@ -363,6 +367,11 @@ clnt_vc_call(cl, proc, xdr_args, args_ptr, xdr_results, results_ptr, timeout)
 	    (xdr_results == NULL && timeout.tv_sec == 0
 	    && timeout.tv_usec == 0) ? FALSE : TRUE;
 
+#ifdef HAVE_RPCSEC_GSS
+	if (is_authgss_client(cl))
+		refreshes = 0;
+#endif
+
 call_again:
 	xdrs->x_op = XDR_ENCODE;
 	ct->ct_error.re_status = RPC_SUCCESS;
diff --git a/tirpc/rpc/auth_gss.h b/tirpc/rpc/auth_gss.h
index 5316ed6..f2af6e9 100644
--- a/tirpc/rpc/auth_gss.h
+++ b/tirpc/rpc/auth_gss.h
@@ -120,6 +120,8 @@ void	gss_log_debug		(const char *fmt, ...);
 void	gss_log_status		(char *m, OM_uint32 major, OM_uint32 minor);
 void	gss_log_hexdump		(const u_char *buf, int len, int offset);
 
+bool_t	is_authgss_client	(CLIENT *);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.25.4

