Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF06E0F3F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Apr 2023 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjDMNwz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Apr 2023 09:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjDMNwu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Apr 2023 09:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DE87280
        for <linux-nfs@vger.kernel.org>; Thu, 13 Apr 2023 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681393923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B7GgR7IsxIkffahtry2Nj63PUFsJG3FcJvFXpSBJLNA=;
        b=T7+QvR3y6EGIKj22s2vgU4ppZyTw/Y6vX8MU0Cc2TDHONEnodzmbQRFM+NdezIZ/1eiehK
        hyjkJGy8nGg49HCYuSvNAZxtxCMzqpQhyiwaoTK+DWBq7ybg9sJf9HZrHcNv/J+cLB0u6W
        FXnFHa4T9cqywZJm/l79raAn3Se3m6A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-jphSqTr7PGaLvWhPkTXB_g-1; Thu, 13 Apr 2023 09:51:59 -0400
X-MC-Unique: jphSqTr7PGaLvWhPkTXB_g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C45411C07597;
        Thu, 13 Apr 2023 13:51:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0C43492B00;
        Thu, 13 Apr 2023 13:51:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
cc:     dhowells@redhat.com, Scott Mayhew <smayhew@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sunrpc: Fix RFC6803 encryption test
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1078409.1681393916.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 13 Apr 2023 14:51:56 +0100
Message-ID: <1078410.1681393916@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

    =

The usage_data[] array in rfc6803_encrypt_case() is uninitialised, so clea=
r
it as it may cause the tests to fail otherwise.

Fixes: b958cff6b27b ("SUNRPC: Add encryption KUnit tests for the RFC 6803 =
encryption types")
Link: https://lore.kernel.org/r/380323.1681314997@warthog.procyon.org.uk/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Scott Mayhew <smayhew@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-nfs@vger.kernel.org
cc: linux-crypto@vger.kernel.org
---
 net/sunrpc/auth_gss/gss_krb5_test.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss=
_krb5_test.c
index ce0541e32fc9..aa6ec4e858aa 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -1327,6 +1327,7 @@ static void rfc6803_encrypt_case(struct kunit *test)
 	if (!gk5e)
 		kunit_skip(test, "Encryption type is not available");
 =

+	memset(usage_data, 0, sizeof(usage_data));
 	usage.data[3] =3D param->constant;
 =

 	Ke.len =3D gk5e->Ke_length;

