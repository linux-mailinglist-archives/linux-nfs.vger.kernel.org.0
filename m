Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB887021CA
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 04:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjEOCku (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 May 2023 22:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjEOCkt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 May 2023 22:40:49 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD2DB1;
        Sun, 14 May 2023 19:40:48 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-76c626eb5d1so164493339f.0;
        Sun, 14 May 2023 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684118447; x=1686710447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRqArO1xlVO8y07C9Kq3Ze/xf8lx/06+pxjfGbghf1U=;
        b=rlGEcm1rr9RT7uyn1BG8/fpiyYW9r173W7AsGyGqPM1m3jB7V5Ia+0DxAsGkKqhrP4
         dOUh/PuNZtWVAhh9/cjR67zs2gqLfV0p/DIARdDQpNZok2aHGYPcEUEDbKcLT+V2NNOg
         1vynJ1u7+/9s6gUG5PoRtb/XqU9/00zj5QeB6LT8DQ1UgNWUEV+Lkl3WlETSfxQn0R96
         VV18qxs/Yr3OShMJHYz6htCQMuUxcXq0mtduE60epU7aaSVETNf6M4+L7LM+aQlJG2Yo
         FkTLkU+WtexgKPNWJ+mH1Jx4a3F1Ojr7fLcT+zgfv3pQOYHTTy8yGWPjMf7pz+8vVFlQ
         /llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684118447; x=1686710447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRqArO1xlVO8y07C9Kq3Ze/xf8lx/06+pxjfGbghf1U=;
        b=Uk+BhAKkJXV5ibdGjaCXiAPVtyKN/Gwiju9p7nPGnb/gOfH2JUBE/O2tcj9zoABdly
         GR+CIjwl61iDhloMywBjwnwIWDV225rQruEPY212SEkWpQqXnT8NDAd/WQZXGZ7EEXia
         DvHDJcdY/w23/af53kNWc4JQyHcCeu0eyYWrALTfznoix5ppruI+n0CpwStNSGoYBzgE
         l2Rku5JJj9lXgohV6x7vulBPpKUI7S7Dj8oKd6FTyp/AQrJx0JTcDAT0zF6b9pSC/GUA
         I3LYhnA/vXWEXsJQwziiuoKOjOHhQV9xgrXc50kOHuAo6LGLFczR4FVxbsMwRfO9dUbh
         +5Kg==
X-Gm-Message-State: AC+VfDz1hdOY9LG19zdiXgJ/YpSi7LhiE6fyx20EfPZZPlxi4cf24qcp
        yjuA9pHj1HMnWI0RifwV0zzxQBlORtQ1fA==
X-Google-Smtp-Source: ACHHUZ673EELvUM7wj+EIQ9aZ+8WRulhRkjG31VOPUwsuxk8yUAPBgiZrZQcuGc05IcaUkVupoKVDA==
X-Received: by 2002:a5d:8513:0:b0:762:f8d4:6f9 with SMTP id q19-20020a5d8513000000b00762f8d406f9mr21178023ion.2.1684118447533;
        Sun, 14 May 2023 19:40:47 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id m31-20020a056638271f00b00417a49f03absm4333478jav.64.2023.05.14.19.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 19:40:47 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] NFSD: Remove open coding of string copy
Date:   Mon, 15 May 2023 02:40:44 +0000
Message-ID: <20230515024044.2677124-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Instead of open coding a __dynamic_array(), use the __string() and
__assign_str() helper macros that exist for this kind of use case.

Part of an effort to remove deprecated strlcpy() [1] completely from the
kernel[2].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 fs/nfsd/trace.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4183819ea082..72a906a053dc 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1365,19 +1365,19 @@ TRACE_EVENT(nfsd_cb_setup,
 		__field(u32, cl_id)
 		__field(unsigned long, authflavor)
 		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
-		__array(unsigned char, netid, 8)
+		__string(netid, netid)
 	),
 	TP_fast_assign(
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
 		__entry->cl_id = clp->cl_clientid.cl_id;
-		strlcpy(__entry->netid, netid, sizeof(__entry->netid));
+		__assign_str(netid, netid);
 		__entry->authflavor = authflavor;
 		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
 				  clp->cl_cb_conn.cb_addrlen)
 	),
 	TP_printk("addr=%pISpc client %08x:%08x proto=%s flavor=%s",
 		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
-		__entry->netid, show_nfsd_authflavor(__entry->authflavor))
+		__get_str(netid), show_nfsd_authflavor(__entry->authflavor))
 );
 
 TRACE_EVENT(nfsd_cb_setup_err,
-- 
2.40.1.606.ga4b1b128d6-goog


