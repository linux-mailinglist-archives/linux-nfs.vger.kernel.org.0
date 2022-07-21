Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D2157D685
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiGUWHa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiGUWH2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:07:28 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6658C88744
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:27 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id n13so1529574ilk.1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kzKDy/oo4K872vTHa81TxBHb9FldfgxoqNd8x+GKTI4=;
        b=moggTBNZcWBvpwHRjT5KolGGTNVPOE3z5BsWxKYLw7+VIL3v+HES87qP+c8PY+HMz4
         r4O/ybup5gahRfDp2lushqzqxriQa2rkOO7HZx/hZ4pf5HX0T4gC5t9fc9N9uYesWlVE
         IuxuSbCw8h25k9M9pKO9lYZX2XhK1CqonKO0zb5QfKr40B4X9llo3hS67iEX90AJ/7kI
         GDnCuys5UrJnJQ1npeWv7i1hD0Zf9DmN7Ll8sE2bmC6/6RI85LxS4VP9YlztrnYbsj57
         ymY1FGryT/jM5oPpBo5nfOzQ0mr2y7tIoa0ApbTE824Trr5PV5plEfWWxeDGSc5GxAnS
         bIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzKDy/oo4K872vTHa81TxBHb9FldfgxoqNd8x+GKTI4=;
        b=XiUOFGCE3dfP2Tot4AZnq8vEIdcPE/DzWCQ4M4VvYhPjBILON/9YCIVGwg98PCmqA0
         M0dCuq5IlsYZRlhMC9DAMdPQ8r30aZH7/obZwWboq3m6uTfjgcjbGpXLSfDP0RGhsWFo
         9IBzCuHchCOT1GrAx/cqDyBTsEdvBPYip2NhkYBXIo6Mgaqss27fTHlfqDMdPYrgP1/z
         QSVOgGwuAvOCvsO3DCjOI3swusjgYhPV8SPPnafVUGeTW7taiRcEBczE6ZE+/DPFV8ux
         mwLPjX9TgK0EuYzP7obOgiwNFSDIUM8brp41CtK/iXonH1mMBtJzFUneRgaD4QWmuVZz
         m5pg==
X-Gm-Message-State: AJIora8eEqzCm+0cG5a9oIX7dHOswc6siV1kITMzawooK3sA13ca73Pc
        Ru8ilMxwyGK8plgz7kyTSd/BIuSDqa0=
X-Google-Smtp-Source: AGRyM1vVVyJx47HPNsgRr4PJDssGu/Dt2bL8i1XimME6XlwEKTPtbh9j1jWcVCfIjfcvEQqx6gi4eg==
X-Received: by 2002:a05:6e02:1b0b:b0:2dc:ffce:db4 with SMTP id i11-20020a056e021b0b00b002dcffce0db4mr228691ilv.184.1658441246844;
        Thu, 21 Jul 2022 15:07:26 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a05663811cb00b00341668383cfsm1281105jas.33.2022.07.21.15.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:07:26 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 09/11] SUNRPC export xprt_iter_rewind function
Date:   Thu, 21 Jul 2022 18:07:12 -0400
Message-Id: <20220721220714.22620-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
References: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make xprt_iter_rewind callable outside of xprtmultipath.c

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprtmultipath.h | 2 ++
 net/sunrpc/xprtmultipath.c           | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index 9fff0768d942..c0514c684b2c 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -68,6 +68,8 @@ extern void xprt_iter_init_listoffline(struct rpc_xprt_iter *xpi,
 
 extern void xprt_iter_destroy(struct rpc_xprt_iter *xpi);
 
+extern void xprt_iter_rewind(struct rpc_xprt_iter *xpi);
+
 extern struct rpc_xprt_switch *xprt_iter_xchg_switch(
 		struct rpc_xprt_iter *xpi,
 		struct rpc_xprt_switch *newswitch);
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 39a8a2f9c982..e77f8ad50b6f 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -480,7 +480,6 @@ struct rpc_xprt *xprt_iter_next_entry_offline(struct rpc_xprt_iter *xpi)
  * Resets xpi to ensure that it points to the first entry in the list
  * of transports.
  */
-static
 void xprt_iter_rewind(struct rpc_xprt_iter *xpi)
 {
 	rcu_read_lock();
-- 
2.27.0

