Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC47F53AC07
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jun 2022 19:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356381AbiFARe5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jun 2022 13:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356406AbiFARe4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jun 2022 13:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99F4BA501B
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654104894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PrGy0+WSqjbldaLDiTD6I7uCOoMEI7d+ThKKSkhEAcI=;
        b=BRQZ+nCWhHfD2m/pipmm9pwpj4+39MnR1lgdYGBI0jreZcdtd2yrCMeCE0H2uFfe5YkI/3
        dMfGvvixgp4oCQ4XHJUkGf1oxhek1CyArfSyTPfP32SaANPDWquJGGfd4UN1gHNgdQyf97
        BoUfUyIciQVJBd73mhQOqxluImRaEwQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-RX-Ev_V9MUGxHAySWzqHzQ-1; Wed, 01 Jun 2022 13:34:51 -0400
X-MC-Unique: RX-Ev_V9MUGxHAySWzqHzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23F1A1C00129;
        Wed,  1 Jun 2022 17:34:51 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.12.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 318F52166B26;
        Wed,  1 Jun 2022 17:34:50 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id CB62C1A27C3; Wed,  1 Jun 2022 13:34:49 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     kolga@netapp.com, linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc: set cl_max_connect when cloning an rpc_clnt
Date:   Wed,  1 Jun 2022 13:34:49 -0400
Message-Id: <20220601173449.155273-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the initial attempt at trunking detection using the krb5i auth flavor
fails with -EACCES, -NFS4ERR_CLID_INUSE, or -NFS4ERR_WRONGSEC, then the
NFS client tries again using auth_sys, cloning the rpc_clnt in the
process.  If this second attempt at trunking detection succeeds, then
the resulting nfs_client->cl_rpcclient winds up having cl_max_connect=0
and subsequent attempts to add additional transport connections to the
rpc_clnt will fail with a message similar to the following being logged:

[502044.312640] SUNRPC: reached max allowed number (0) did not add
transport to server: 192.168.122.3

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 net/sunrpc/clnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index e2c6eca0271b..b6781ada3aa8 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -651,6 +651,7 @@ static struct rpc_clnt *__rpc_clone_client(struct rpc_create_args *args,
 	new->cl_discrtry = clnt->cl_discrtry;
 	new->cl_chatty = clnt->cl_chatty;
 	new->cl_principal = clnt->cl_principal;
+	new->cl_max_connect = clnt->cl_max_connect;
 	return new;
 
 out_err:
-- 
2.35.3

