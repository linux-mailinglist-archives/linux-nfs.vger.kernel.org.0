Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E43678019
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 16:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjAWPkm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Jan 2023 10:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjAWPkm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Jan 2023 10:40:42 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0103A5FCC
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 07:40:40 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id tz11so31670414ejc.0
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 07:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PH8xEJoD2lVkStmvDiDz5YrrHewO96Xa8lCn1SZkw0A=;
        b=O1lEzJwuBb2u3TPhYXvMuuoWojV1raP07zaUssbYZ+dOyHdH4pjS8mD03seM0rvLM2
         li4E5az7B3kxBtf0pjnXTb6xRw5Anz6ElK7qxEgY1Rqink9BIrUaDQNctu1zJUkbQg89
         sICj+OWxgBaUUtqT1krA9KPNEjY/slcf89jK/TVAJfu4Cq5XkPt1Robb/hYWxGvY2vSB
         OoVA1A0BbBTiZIU+NREEweOX9qIL648T4jdwigxY0/RSc9lq350xjKXyol3H2xREwT1Z
         gV9qd1kHBIIuoCyrFL6/GLgYYleCGrLGYNAa7ZbNb2X8TsZM6WUFtP/GA/JBfYv8Mqri
         Xicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PH8xEJoD2lVkStmvDiDz5YrrHewO96Xa8lCn1SZkw0A=;
        b=VJ3U7GLRB+9urunA2QvlGl0fjKAqv6CDxZQecU+ORU530iYdRduq5JdgBmla/C1VQ1
         bMXMA/TnhdTyQxz+OJud9WJSxTNyCClPv8oDTMpwKQSjApfZwJuy/AFN98rfK2gWE15r
         KKyXKHR7UiJbEO3EzhA1QswVYZuIbXk2b2mhtxb4T2JUm68gmxu/rHtsPraiRnbk+OjM
         mqN+/xYIpRUWM5kjzadq72YpFBuhjBULgYZfhdSAY5z6dH65SDMA641Cg1goD+Uu/zBQ
         0EUjVuLlqLEYw/IK4wLMlr3uQzMSnNVO17VrQrQAOq+2IGrr6vR+nGulp/6uazjd2QT9
         TWbQ==
X-Gm-Message-State: AFqh2kodDgBtgJZshW5Sh1PB0Xvm64dMFRw3ewwxF+S8Ip1zi8YnDntv
        0SKLjJACLPdIWobkNa727TIjyQ==
X-Google-Smtp-Source: AMrXdXtMOTCH3yUv9A/CPSTPIq9YChktH/NxXEG8+BkvRgmsm7k/8N2vUbjOy00QIukMObbeQY/aqA==
X-Received: by 2002:a17:907:924d:b0:7c1:8f78:9562 with SMTP id kb13-20020a170907924d00b007c18f789562mr18889791ejb.50.1674488439520;
        Mon, 23 Jan 2023 07:40:39 -0800 (PST)
Received: from marvin.internal.lan (193.92.101.37.dsl.dyn.forthnet.gr. [193.92.101.37])
        by smtp.gmail.com with ESMTPSA id b4-20020a1709065e4400b00865ef3a3109sm15614843eju.66.2023.01.23.07.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:40:38 -0800 (PST)
From:   Nikos Tsironis <ntsironis@arrikto.com>
To:     stable@vger.kernel.org
Cc:     bfields@fieldses.org, chuck.lever@oracle.com,
        ntsironis@arrikto.com, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com
Subject: [PATCH 5.10 0/1] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs is unmounted
Date:   Mon, 23 Jan 2023 17:40:36 +0200
Message-Id: <20230123154037.879413-1-ntsironis@arrikto.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The bug that upstream commit c6c7f2a84da45 ("nfsd: Ensure knfsd shuts
down when the "nfsd" pseudofs is unmounted") fixes in kernel v5.13
exists in kernel v5.10 too.

That is, knfsd threads are left behind once the nfsd pseudofs is
unmounted, e.g. when the container is killed.

I backported the patch to kernel v5.10, and tested it.

Trond Myklebust (1):
  nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs is unmounted

 fs/nfsd/netns.h     |  6 +++---
 fs/nfsd/nfs4state.c |  8 +-------
 fs/nfsd/nfsctl.c    | 14 ++------------
 fs/nfsd/nfsd.h      |  3 +--
 fs/nfsd/nfssvc.c    | 35 ++++++++++++++++++++++++++++++++++-
 5 files changed, 41 insertions(+), 25 deletions(-)

-- 
2.30.2

