Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756356100A8
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 20:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiJ0Svr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 14:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiJ0Sva (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 14:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B425BCA3
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666896688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qu8rUzIvrChAdR0IXP5wP2th9rLwu5gu2Hk99eh/PUM=;
        b=Jsccx+LRkgIaKMRyWESf8+EILg5bSfVEwLR21EUC+PE39FJJXi2wiBHJ1uZQfN0B1I+DqL
        1Qz47jo3uH79jgvqsR9NGWY1aSgKk7V/W66y6NFTHZHtEVi+qQv/zAjXPD0t27hKxRSxXi
        IfUb1nBcxb7pdKhH3dcyvbAxHfdC6DI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-vUyIKQDDM5eqY3piCYqq3A-1; Thu, 27 Oct 2022 14:51:26 -0400
X-MC-Unique: vUyIKQDDM5eqY3piCYqq3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B96C823F65
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 18:51:26 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 622F440C6EC3
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 18:51:24 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [RFC PATCH 0/1] nfsd: Set v4 version when only a minor version is set
Date:   Thu, 27 Oct 2022 14:51:20 -0400
Message-Id: <20221027185121.15044-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make sure the v4 version is set when only a minor
version is set in /etc/nfs.conf

Set v4 version if only minor version are specified

When vers4 in /etc/nfs.conf is set to 'n', all minor
version are disabled as well. But when vers4 is set
'y' all minor version are settable. Meaning 

vers4=n
vers4.2=y 
does not work. rpc.nfsd complains there are no
version set. 

vers4=y
vers4=y
does work.

Now the rpc.nfsd(8) man page does say 
   vers4  Enable or disable a major NFS version.
   
It could be changed to 
    vers4  Enable or disable all major NFS versions.
    
Or the two line patch attached could be applied.

Steve Dickson (1):
  nfsd: Set v4 version when only a minor version is set

 utils/nfsd/nfsd.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.37.3

