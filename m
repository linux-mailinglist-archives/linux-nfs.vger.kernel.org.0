Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDEC344EA6
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 19:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhCVShe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 14:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231504AbhCVShH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 14:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616438227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AgJ3vaE2gS3cXOaXRunCNTiZ6CQLgQQcl5CWjsvwFfI=;
        b=Kt/hwYr457R7+s4487gr7CHvkxiiWJggwllkOvfF3hoRwHk+iZGozjAalzWUQzi/hh/HsN
        /HWfOcWpswYyxUZMTeaO3TT2/P12aHEDJW3/UZGbwdqmf/ihsUbWrMUAt3gR6J5a7azG4+
        ur8n52CpmUN0I+peQ5Vq3aqVyXLyle0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-TTGLfOVmMfOUuFjhsagpfw-1; Mon, 22 Mar 2021 14:37:04 -0400
X-MC-Unique: TTGLfOVmMfOUuFjhsagpfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBBAF1012D95;
        Mon, 22 Mar 2021 18:37:02 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2955D60936;
        Mon, 22 Mar 2021 18:37:02 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id A06B410C30F7; Mon, 22 Mar 2021 14:37:01 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@fieldses.org, chuck.lever@oracle.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Ensure the transport backchannel association
Date:   Mon, 22 Mar 2021 14:37:01 -0400
Message-Id: <4c5eac26405450dc6916618952e92a9d5e387498.1616438176.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the server sends CB_ calls on a connection that is not associated
with the backchannel, refuse to process the call and shut down the
connection.  This avoids a NULL dereference crash in
xprt_complete_bc_request().  There's not much more we can do in this
situation unless we want to look into allowing all connections to be
associated with the fore and back channel.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/xprtsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c56a66cdf4ac..6a477e2acf70 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -558,6 +558,10 @@ xs_read_stream_call(struct sock_xprt *transport, struct msghdr *msg, int flags)
 	struct rpc_rqst *req;
 	ssize_t ret;
 
+	/* Is this transport associated with the backchannel? */
+	if (!xprt->bc_serv)
+		return -ESHUTDOWN;
+
 	/* Look up and lock the request corresponding to the given XID */
 	req = xprt_lookup_bc_request(xprt, transport->recv.xid);
 	if (!req) {
-- 
2.29.2

