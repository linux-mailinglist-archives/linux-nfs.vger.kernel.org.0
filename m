Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177D97D71C1
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjJYQbj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 12:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJYQbi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 12:31:38 -0400
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87991
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698251488;
        bh=fdURGibl0c7gXJtCTDzqXqgfXp0ppJMBARCaqiarhkY=;
        h=From:To:Cc:Subject:Date;
        b=s/gfuaAaMBj01v4xchWj2VH8lIRPEbl3XfLhRxI29ysksR7drrviKdvQ5I044pmGT
         gP3uEVz2IRlQASw6LFnlk5iiuD85AhIQqXSyNTu5YV92uYjHVk/6jTr2qa+CPoL5xn
         Dcbb6Ln2NlMMXVdClnanbdEe8E099nXi5c7MxAhM=
Received: from localhost.localdomain ([36.142.182.134])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 64939A66; Thu, 26 Oct 2023 00:25:09 +0800
X-QQ-mid: xmsmtpt1698251109tmx76kybs
Message-ID: <tencent_990266C2252CF3FBEBDE512E5BEEA67CAF06@qq.com>
X-QQ-XMAILINFO: MiPTq5wGoKOm0vYukzGfSUw1Klf+302xW78V3YWzatPbbMx/IkClKr8QJ+5Kqu
         pRYqejzWp10yo+XMPbjJV5MG2Pz2HgF+0SuLJfgWR3N0WGlLh6nff7LwRzWAg8kl5Apl32t2ZWje
         tGHEOypQg/2fPQAS5lnRfdWESKLnsq4D95MUN6R+JzuUoIGdDuChmshh7sm+Dm4tLK51CWW6rBGb
         uCnUifEdc/dlzL2YZK3APFvOCfOI+bc5DuuIzCojAr7SCg9eBKov/M3Z+Q0dPlxWKlhEWTCjtvqe
         kGUbs8rarx5gMJpJwu9iBV2GrXsvNnpe6+xuT+rYTUhWjMvCpzPtKrzlIp4MyaoZWM4g/ihPzn8V
         it2Aa0g1GNgzp1YOr9hFvT60JvFZCi2beFcHsHysQc8H3Z/0jki1QG7EkIGa4uMizRXzpEF6TUBb
         kFBFV4uavCDY7Lj2kxpUs8Kr1yWudjfTXX2lnZe/7gBJ6nn4X6vIGRIMYqwwAGnaEjkNjaklUE8l
         BYF6r2qebjNRvnOo2RNECBGIpPq/g1es+ZxRP1f2m02n/gti/7+sr4cdnpFg7NxmUIT+34zfkioa
         zwcd+otQYyRHtK1gssSYQiFPDNEurTY1p8OcO+Xi/pqjvWdEx3bniyIKScfWv2oinv28dmBnHBkO
         AIcImlDDuJTxrg9+mFtSGxNeID+pKHFrI9C1d2xYSIkNLnF4SjTcIlwf4m6iev0Si+MB1q1u9vjX
         /P2FP4PefENCiibH/FOFVVpsW/o1G1RP/ADCDulmrNR/lqcUA3bv/kJ3x8P5tBaYdSj/PxUaAHjc
         vAxiD7WWljTDcOPP2ZtdIWaE6pYlzra1l8Qgcgoby7s986uE2Iftb5t3JdFOZ1ZYo7yMXRyTdcK5
         OcAxVAQW7LmC8IyOyPKSwLNGBgq3/g+Oq7Kg2C6JTctOkIEi1D+d0dqZkaH1QElPMBj2gzEWoM1H
         ofLTQ7R4CpNFcEjE6aaEkd0oYkmqdTpms2pxFQNGPA5QhCYobLDpjEv8mGOFe8gClLvdFVi5f6wf
         RvxtIXWjOFBKr5nrFNh4ZMNKXKweUpcgTFAZJjv6i/Vwe+Tffi
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   Zhuohao Bai <zhuohao_bai@foxmail.com>
To:     steved@redhat.com
Cc:     falcon@tinylab.org, forrestniu@foxmail.com, baizhh21@lzu.edu.cn,
        tanyuan@tinylab.org, linux-nfs@vger.kernel.org,
        Zhuohao Bai <zhuohao_bai@foxmail.com>
Subject: [RFC PATCH] _rpc_dtablesize: Decrease the value of size.
Date:   Thu, 26 Oct 2023 00:24:42 +0800
X-OQ-MSGID: <20231025162442.1501-1-zhuohao_bai@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In the client code, the function _rpc_dtablesize() is used to determine the memory allocation for the __svc_xports array.

However, some operating systems (including the recent Manjaro OS) can have _SC_OPEN_MAX values as high as 1073741816, which can cause the __svc_xports array to become too large. This results in the process being killed.

There is a limit to the maximum number of files. To avoid this problem, a possible solution is to set the size to the lesser of 1024 and this value to ensure that the array space for open files is not too large, thus preventing the process from terminating.

Signed-off-by: Zhuohao Bai <zhuohao_bai@foxmail.com>
---
 src/rpc_dtablesize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rpc_dtablesize.c b/src/rpc_dtablesize.c
index bce97e8..2027af4 100644
--- a/src/rpc_dtablesize.c
+++ b/src/rpc_dtablesize.c
@@ -41,7 +41,7 @@ _rpc_dtablesize(void)
 	static int size;
 
 	if (size == 0) {
-		size = sysconf(_SC_OPEN_MAX);
+		size = min(1024, sysconf(_SC_OPEN_MAX));
 	}
 	return (size);
 }
-- 
2.25.1

