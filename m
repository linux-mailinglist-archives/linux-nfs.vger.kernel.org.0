Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAC3526A4A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 21:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383806AbiEMTTu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 15:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357966AbiEMTTh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 15:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2F7A3C72A
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652469498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EKGhowWyRRV6nPFlDJ1JS9fAb9Qu7X6oHPKRxEN4oMU=;
        b=BxQKkOFItsd3RwDAikSAhhf9nIgzEXiOVwb4YqeDTKQycfR12OIjuogPFfdQ1SgxYd1CRH
        YyMml1/r1QreJ+F92YGvya/TRUYUC+C/cw+mD40Ud4nlflHvumKtPzLVT7ysHRoQ68Jt3S
        pongRIWJFEb1IcB/pckOdU49y82vXXM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-2Et5rqR9MNedV_c3n0xoVA-1; Fri, 13 May 2022 15:18:17 -0400
X-MC-Unique: 2Et5rqR9MNedV_c3n0xoVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F56C811E76
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 19:18:17 +0000 (UTC)
Received: from nyarly.redhat.com (ovpn-116-111.gru2.redhat.com [10.97.116.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BA5414DFB85;
        Fri, 13 May 2022 19:18:14 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Thiago Becker <tbecker@redhat.com>
Subject: [PATCH] nfsrahead: getopt return type is int
Date:   Fri, 13 May 2022 16:18:08 -0300
Message-Id: <20220513191808.2930668-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While compiling for aarch64, the compiler throws the warning below
because char is unsigned for aarch64.

main.c: In function ‘main’:
main.c:145:48: warning: comparison is always true due to limited range of data type [-Wtype-limits]
  145 |         while((opt = getopt(argc, argv, "dF")) != -1) {
      |

This makes nfsrahead to run forever. Fix opt type to the same as getopt
type.

Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfsrahead/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/nfsrahead/main.c b/tools/nfsrahead/main.c
index 5fae941c..c83c6f71 100644
--- a/tools/nfsrahead/main.c
+++ b/tools/nfsrahead/main.c
@@ -135,10 +135,9 @@ static int conf_get_readahead(const char *kind) {
 
 int main(int argc, char **argv)
 {
-	int ret = 0, retry;
+	int ret = 0, retry, opt;
 	struct device_info device;
 	unsigned int readahead = 128, log_level, log_stderr = 0;
-	char opt;
 
 
 	log_level = D_ALL & ~D_GENERAL;
-- 
2.35.1

