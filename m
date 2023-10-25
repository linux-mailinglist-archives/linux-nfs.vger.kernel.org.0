Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF797D71BD
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjJYQ3Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjJYQ3W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 12:29:22 -0400
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE3F9C
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698251354;
        bh=fdURGibl0c7gXJtCTDzqXqgfXp0ppJMBARCaqiarhkY=;
        h=From:To:Cc:Subject:Date;
        b=ULVGRX5eIzOF3WaXBlmJVBt08PhRmRyGA1vM+6+w9pP/pKZkYHAAylfMDUNyvf2Bs
         rPus8NpvdqNVO2p42iZurJ+WmVEzkFeAmQ9xTGaeCDJ5PBw6iyoEnYHLWK+VBogaA5
         51Jxpqc7BYP5I5fDI/bSVByVgi1L2NtSnjL87l0s=
Received: from localhost.localdomain ([36.142.182.134])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 6EA22473; Thu, 26 Oct 2023 00:27:42 +0800
X-QQ-mid: xmsmtpt1698251262thnyghwih
Message-ID: <tencent_E6816C9AF53E61BA5E0A313BBE5E1D19B00A@qq.com>
X-QQ-XMAILINFO: NwwvG5JPXID4Vv4OMA6iDAAbWOI6QoDZISgFNtYzKhfw8PNs4mdSfVokkfPFE+
         IwvrCd4xzS4lj707ZFgTEKgzOnpZG/1YRfupB0Z6lRFKJhPHdQG7UfATP3LpYs0ZidCaNkW4PuAV
         gvHBGeL/MsuE5joODf6eNbn+pxyYsYSIXTtrnPN+7AmTquo+AAXG+skSh8LkLDARVTeFL+XUaoFT
         s8nDtOBzqKVZY1B685X9L2r3g3X+yk+w8FkY1k6cLz01hx93/HXb6Aeu/OZIdIWBMhGfq7CGeM1J
         Nl+ERNP07bpm2tn7vOIqlZfgdlU3EkXiUHjFPYQa1B7mV/3ssBYntFgmV7COrNc0ExlE1mbXiO9w
         yNZ8bnvv48L4F4uJB1n5ZnD9YFwLA+CqOiSrD6y44vsA/kXe4k0WSJ01Eyrxm0WQO+MjYFqsli1O
         AcVL8l45gwIENVh1f3T+pGssUXhu5wZof0oBCK90CnNiZx0b6FumQDzsV7gt5iMjtXNITeXK/MvQ
         nIrhGvQgYFBfKy1iMKNezzE5dvxYr96mwu/ZToRHho8bJl8sP3ZtCVUoziiSMPIxGMCIKv/YLDf8
         TZwtcUFhM3WuqCf1UEBd2Zwq+aXBPkwjsJNApHIXmc3qvcANsnYRZ/k1O3ruoSrKDNfMmi+3V7Xh
         MwFZP2ioSfa6esjSngZn/5alUGcgGxnnzaejVyShrT7sdT2isOi2Be9ggi3Lba//SJsfr9e5GYi7
         xE4vVyGWdr0Wk8K8sOk7jQkV20aCg35/yQk6WS65Llm6YX/9mB/4jpCkxkyrPrhLz/crvKpjiz2j
         QF0RHe7HF9t+uOuz5KaD4kOQBu6MxzIcxNHD5dLs6n1t4IZx6+0HEwpW/p9f39gbORzlW5Qp3TMS
         lHx1fnV+G6+D7DAzbdtVodbdhTCUEvY78xGs9d9ZF1EcIhV8dv+LfD7GdaQzmjY7I0CnhKx39m9y
         15IPxVOyewKYCeOo+Rdly3rw5/nowGZ/kSgDWmWmvQzYclIYDkiIY0u9pIpMAV2eCVjwN1dMxCpO
         u+gahPvzwo+fwmHGK3mkjSb1yxRC0/BkDi+q9YZgpD6EiQ/ifuopv/pPZqO76K/jWiHj3lHOKiJ5
         HZ5eW+EkmqUZ2TBUQIBC2cLIl6/i02QI0S04ZYUEGqahuPPLhqz8GkyrNAv89p/JjI5d6M
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Zhuohao Bai <zhuohao_bai@foxmail.com>
To:     steved@redhat.com
Cc:     falcon@tinylab.org, forrestniu@foxmail.com, baizhh21@lzu.edu.cn,
        tanyuan@tinylab.org, linux-nfs@vger.kernel.org,
        libtirpc-devel@lists.sourceforge.net,
        Zhuohao Bai <zhuohao_bai@foxmail.com>
Subject: [RFC PATCH] _rpc_dtablesize: Decrease the value of size.
Date:   Thu, 26 Oct 2023 00:27:16 +0800
X-OQ-MSGID: <20231025162716.1551-1-zhuohao_bai@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

