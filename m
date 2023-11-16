Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF27EE5B4
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 18:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjKPRL3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 12:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPRL2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 12:11:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D541A5
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 09:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700154684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ymV3s3bEKcNtX5vsiN+AkDfnW20QXlre0yO2FfbIFLY=;
        b=QV67bfcgd541+Lnf56JGtGwR0GA1Vv3W2ULwiLQ/ZNMdpu05cW7TSbvHFcquaMBRzAXfN+
        kXGi5FV11YTC77H860sDebwcuXyeGuSC2esYs08xygI/S6fz/UdxIhrD/QSajnz15qgsc2
        2ZFY5ThXO+OCIJborwW3+F9j7X/QWgw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-A1X2lqhKOvSSqyJE9fL4TA-1; Thu, 16 Nov 2023 12:11:22 -0500
X-MC-Unique: A1X2lqhKOvSSqyJE9fL4TA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3830685C1A1
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 17:11:22 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC900C157E4
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 17:11:21 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Blocklayoutdriver deadlock with knfsd
Date:   Thu, 16 Nov 2023 12:11:20 -0500
Message-ID: <1CC82EC5-6120-4EE4-A7F0-019CF7BC762C@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I ran into this old problem again recently, last discussed here:
https://lore.kernel.org/linux-nfs/F738DB31-B527-4048-94A7-DBF00533F8C1@re=
dhat.com/#t

Problem is that clients can easily issue enough WRITEs that end up in

__break_lease
xfs_break_leased_layouts
=2E..
nfsd_vfs_write
=2E..
svc_process
svc_recv
nfsd

=2E. so that all the knfsds are there, and nothing can process the
LAYOUTRETURN.

I'm pretty sure we can make the linux client a bit smarter about it (I sa=
w
one LAYOUTGET and one conflicting WRITE in the same TCP segment, in that
order).

But what can knfsd do to defend itself?

Ben

