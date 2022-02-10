Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3824B14D5
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Feb 2022 19:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbiBJSBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Feb 2022 13:01:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243363AbiBJSBm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Feb 2022 13:01:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A05D115A
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 10:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644516097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oQ4j1SNFz6kfXDzicrUoMV6UXDgqNJu4L6VYR6hqqg8=;
        b=M88SjrGgtojP0G7fuE+sTofXCn0ly0pr6pi7PQU+nFN6DvMx0O4bJCpu7TnFUELiGqq7Cd
        9ynaDbYKv7FRcSVx+HLWdbaMCldUgCXTOOgKU69zyaoEnldjf3vSw2LnebiQXoj04X64Ru
        5FLJTf0AJ1zwm9bdmR6DthoJjJYumaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-12E9_TjiPrWHHvPWgyod-g-1; Thu, 10 Feb 2022 13:01:36 -0500
X-MC-Unique: 12E9_TjiPrWHHvPWgyod-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B44541091DB7
        for <linux-nfs@vger.kernel.org>; Thu, 10 Feb 2022 18:01:11 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 920D985F01;
        Thu, 10 Feb 2022 18:01:11 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 12C3110C30F0; Thu, 10 Feb 2022 13:01:11 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] nfsuuid and udev examples
Date:   Thu, 10 Feb 2022 13:01:09 -0500
Message-Id: <cover.1644515977.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Changes on v2:
	- add forgotten aclocal/libuuid.m4

Benjamin Coddington (2):
  nfsuuid: a tool to create and persist nfs4 client uniquifiers
  nfsuuid: add some example udev rules

 .gitignore                       |   1 +
 aclocal/libuuid.m4               |  17 +++
 configure.ac                     |   4 +
 tools/Makefile.am                |   1 +
 tools/nfsuuid/Makefile.am        |   8 ++
 tools/nfsuuid/example_udev.rules |  28 +++++
 tools/nfsuuid/nfsuuid.c          | 203 +++++++++++++++++++++++++++++++
 tools/nfsuuid/nfsuuid.man        |  33 +++++
 8 files changed, 295 insertions(+)
 create mode 100644 aclocal/libuuid.m4
 create mode 100644 tools/nfsuuid/Makefile.am
 create mode 100644 tools/nfsuuid/example_udev.rules
 create mode 100644 tools/nfsuuid/nfsuuid.c
 create mode 100644 tools/nfsuuid/nfsuuid.man

-- 
2.31.1

