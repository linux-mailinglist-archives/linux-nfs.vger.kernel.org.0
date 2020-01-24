Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 638D4147E89
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2020 11:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389081AbgAXKMB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jan 2020 05:12:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29410 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387509AbgAXKMA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jan 2020 05:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579860720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pMjOSZK58N7M6Rhz2Q0zLJbK9wOAIHwivc/jQo31Ecg=;
        b=ejlzaLX68r6XqyXu1e3sjK36xew6tEE7/kN4FUasqClhzhOjjRW1UxCAlfODLG+9qIh7hZ
        z/WKEplZWVq8K0XTQsHmrBnmdJAopeOG6m73olus4+bL4W1PpZ4olRck1nPVbgdpRw40vX
        AeRXrVU0wmGbbs/VrujK1Egtdw7c7ZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-8SFVgEeCM9OIiyyyXZdlaQ-1; Fri, 24 Jan 2020 05:11:58 -0500
X-MC-Unique: 8SFVgEeCM9OIiyyyXZdlaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E13A18A8C86;
        Fri, 24 Jan 2020 10:11:57 +0000 (UTC)
Received: from idlethread.redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1F99A4B60;
        Fri, 24 Jan 2020 10:11:55 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, trond.myklebust@hammerspace.com,
        linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc: expiry_time should be seconds not timeval
Date:   Fri, 24 Jan 2020 11:11:54 +0100
Message-Id: <20200124101154.22760-1-rbergant@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When upcalling gssproxy, cache_head.expiry_time is set as a
timeval, not seconds since boot. As such, RPC cache expiry
logic will not clean expired objects created under
auth.rpcsec.context cache.

This has proven to cause kernel memory leaks on field.

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svca=
uth_gss.c
index 8be2f209982b..725cf5b5ae40 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1211,6 +1211,7 @@ static int gss_proxy_save_rsc(struct cache_detail *=
cd,
 		dprintk("RPC:       No creds found!\n");
 		goto out;
 	} else {
+		struct timespec boot;
=20
 		/* steal creds */
 		rsci.cred =3D ud->creds;
@@ -1231,6 +1232,9 @@ static int gss_proxy_save_rsc(struct cache_detail *=
cd,
 						&expiry, GFP_KERNEL);
 		if (status)
 			goto out;
+
+		getboottime(&boot);
+		expiry -=3D boot.tv_sec;
 	}
=20
 	rsci.h.expiry_time =3D expiry;
--=20
2.21.0

