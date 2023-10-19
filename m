Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC457CFEB0
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Oct 2023 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbjJSPvf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Oct 2023 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjJSPve (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Oct 2023 11:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1264612F
        for <linux-nfs@vger.kernel.org>; Thu, 19 Oct 2023 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697730645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=qeE4BGFCkLj2qm7GcwiuddicRFkUnuFrBJk1ce+9kPg=;
        b=BUa/ojmIOoqlvlm9vcaxk2lwXuQvGYrhscjdj9WkqaKEkofJOBgCN5EP4GrjYDFsgnyf6Y
        LSw1SPyLJur+Su5rjkN64t40lvThIXTaygSjnZKdGuRaWx7RtFHEwBbNp/9vi1b+Oxob4J
        B/dM1OtymzZ1zOqC1WXzM/9FOJFXHVQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-w9ufUKlrNVSAm-DUTZlTdw-1; Thu, 19 Oct 2023 11:50:19 -0400
X-MC-Unique: w9ufUKlrNVSAm-DUTZlTdw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84D398E6D05
        for <linux-nfs@vger.kernel.org>; Thu, 19 Oct 2023 15:50:18 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C68F492BFA
        for <linux-nfs@vger.kernel.org>; Thu, 19 Oct 2023 15:50:18 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: TEST_STATEID storms
Date:   Thu, 19 Oct 2023 11:50:16 -0400
Message-ID: <27B8CCE5-56B5-4F12-A9F2-82C7925C2B2A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This picks up a discussion we had at bakeathon - I'll try to summarize quickly.

There's been new reports of TEST_STATEID storms where clients spend all of
their cpu and network resources sending TEST_STATEID.

In network captures, we see both SEQ4_STATUS_RECALLABLE_STATE_REVOKED and
SEQ4_STATUS_CB_PATH_DOWN.

Now we can see that the NFS server really is seeing the callback channel
drop, and we see -ERESTARTSYS from nfsd_cb_done and -EINVAL from
nfs_cb_setup_err.  I think the server may be spuriously shutting down the
callback rpc_client, which does rpc_killall_tasks for any pending callbacks.

I started playing with the upstream client, and noticed that if the client
is idle with nconnect > 1, the XS_IDLE_DISC_TO (5 minutes) can take down the
connection with the callback channel for v4.1.  We recently prioritized this
first connection, perhaps we can disable the idle timeout for it.

There's some weird behavior for nconnect=16, we only get 12 connections at
first, then my client usually only primes 5 of them with a SEQUENCE within
the next 5 minutes, and tears down the callback connection, then re-connects
all 16 again.

This whole situation makes delegations a huge net loss in this setup.

Can anyone remember why we wanted XS_IDLE_DISC_TO back in the
single-connection TCP days?

Ben

