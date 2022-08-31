Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E6E5A8778
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 22:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiHaUVC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 16:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiHaUVB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 16:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4301D34CF
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661977260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=vNbUZw9ZAyuBRA0HADclM+IyPC7OPrvHhvFWLFi8hs8=;
        b=H1V6AmARTch72lw7AroOcF+KSCR8mLJD9S5WJWWT+fDC+A8RVGxhHb5GqXWdFGbh+vrAPI
        l1SOQBy1oqMhfNT2U4VGYMLFzQ85wArRTndGjnmAKznqyXBkt8IUAGnBDCliSy6GYuNrSV
        goJF0Q6qtJHGbMf+W87htItWEyYcjqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-yBdNikoGNnmuMCrdv0mglQ-1; Wed, 31 Aug 2022 16:20:58 -0400
X-MC-Unique: yBdNikoGNnmuMCrdv0mglQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4F1B101A54E;
        Wed, 31 Aug 2022 20:20:57 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43BBB40C141D;
        Wed, 31 Aug 2022 20:20:57 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: client call_decode WARN_ON memcmp race since 72691a269f0b
Date:   Wed, 31 Aug 2022 16:20:55 -0400
Message-ID: <6806AB48-F7D6-4639-8D03-E31BA25C4CF3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Trond,

Since "72691a269f0b SUNRPC: Don't reuse bvec on retransmission of the
request" I can sometimes pop the WARN_ON() in call_decode(), usually on
generic/642.

I think there's a kworker halfway through

xprt_complete_rqst() ->
       xprt_request_dequeue_receive_locked()

between these two linse:
         xdr_free_bvec(&req->rq_rcv_buf);
         req->rq_private_buf.bvec = NULL;

And at the same time the task is doing the WARN_ON(memcmp()) in
call_decode.

I'm not sure of a good fix - perhaps we can fixup the other paths that
require the NULL check in xdr_alloc_bvec() so we don't have to set bvec =
NULL.

Any thoughts?

Ben

