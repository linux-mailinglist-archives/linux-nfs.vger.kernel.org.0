Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468476AA0D7
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 22:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjCCVJb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 16:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjCCVJa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 16:09:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6F4193D0
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677877724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SJTOiCA2HhFHmxe/e++KVExAOw+0rLbcFweO0cDZ7N0=;
        b=AMEepWPhZaCZUaJXNEt1NF6Eqe2watInZ5vdybLDXdmZocIm7EUcyRoFuCBYzWGgA/Dg//
        ljYYMIXuLQstjNEmU9tV0LlETVtM1vIV0JKfV/6wOhvjqElZKDh5IwKRQG7L31pb5v01uv
        wHYHtg8La3xRsNVS9V8U1wZwIqghfq0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-0K8A4YkQMx2q_6UK5tx3mw-1; Fri, 03 Mar 2023 16:08:39 -0500
X-MC-Unique: 0K8A4YkQMx2q_6UK5tx3mw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55DD82810C13;
        Fri,  3 Mar 2023 21:08:38 +0000 (UTC)
Received: from bcodding.csb (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 292E1492C14;
        Fri,  3 Mar 2023 21:08:38 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id A395B10C30F0; Fri,  3 Mar 2023 16:08:32 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] NFSv4 callback service ate my homework
Date:   Fri,  3 Mar 2023 16:08:31 -0500
Message-Id: <cover.1677877233.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A system with very low autofs timeouts for many mounts of v4.0 exports,
while attempting to mount with the non-specific vers=4 option would run out
of memory every few days.  Each mount was doing the v4.2, v4.1, v4.0
negotiation and constantly setting up and tearing down the backchannel
service for positive minorversions.  We found a probable cause:
wake_up_process() isn't guarunteed to execute the threadfn; kthread_stop()
can race in and prevent it.

Benjamin Coddington (1):
  SUNRPC: Fix a server shutdown leak

 net/sunrpc/svc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.31.1

