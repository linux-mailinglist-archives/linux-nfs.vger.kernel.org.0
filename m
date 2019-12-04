Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADF4113636
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 21:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfLDUOA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 15:14:00 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40152 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLDUN7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 15:13:59 -0500
Received: by mail-yw1-f67.google.com with SMTP id i126so239934ywe.7
        for <linux-nfs@vger.kernel.org>; Wed, 04 Dec 2019 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rRaJqBMw2JaW2HjFrmxgGVunQOxyxkDl+7LN3gRpOHI=;
        b=ointL4y1KsYc/kePdaCgPTA6kC73zJZiys40A3EMgatjCxTq4ofOUQqSmSkGGCcC2/
         J4TxLTTpPL0k5acDZHb/H+nkh9G14nlR7i4gvbiJcam1y2JPHfvdPXHkZlHkik5f+ear
         zStYyrWzL1k/VN7wLGobRaY+SuXSQ2jDGySDkgiYBwhPgIg0cSjbMYdbpgZIkmJPny69
         SIWREIENLdqqg8SIaV0gZZq+N2DBrrtzxGJOUKIDT1R9veJPBBbp7D/CsR5Pl6lq5xwq
         5u9prj/Q96V6Jf66LzjhePBPE8NrdFbeDqpN4/P/Gwah6r+ykjJrr4/Cw1Ga2Dmu1fse
         ryRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rRaJqBMw2JaW2HjFrmxgGVunQOxyxkDl+7LN3gRpOHI=;
        b=Mf5HO9k58VfTp2bZyYewxiINgwlfr+/7wCyN6pgFxufe9TemTr9m0H/5R7m2e6VN9W
         Bt+E5b54L4gMg+W+rcVBa+H8cvte1ydpGAO+7bZLazyD+n4h8iacmkk9fiOwZ+JdN44i
         fN2+vZaln9ayGgPebK6SIdFJ/vBiYuAXg2quGd4Sb0KMvh5zg+MfdN3d/L+y2swRuHQL
         m+UkLh3VwNB0XOpJbFQF6xVm4yi6v070DuxQdYREKzhmkRlye0efrPpwxWs6a1NC63Oh
         WMIJZ5toJsko+gTrzdDJQa4rzo6UTIAcGa7ofcnljSrTGGsU3Bhe1KXx1isv7chI6pRe
         z2jg==
X-Gm-Message-State: APjAAAWKbopLl1uvqnr06iI6cCYSQts9fHtfVJx/DCJN43GaRSfyvbR2
        5J2/NQRJsGGe710XM8mLs/ia5yMz
X-Google-Smtp-Source: APXvYqycMmq3BlwfHRpLnwW0oJR1mAdtZ6itCPmkSxq76cVN++MNQhWjRaSIp2zkbDXrBiLfwhMX3A==
X-Received: by 2002:a81:9301:: with SMTP id k1mr3306238ywg.143.1575490438848;
        Wed, 04 Dec 2019 12:13:58 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id o69sm3496446ywd.38.2019.12.04.12.13.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 12:13:58 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSD fix mismatching type in nfsd4_set_netaddr
Date:   Wed,  4 Dec 2019 15:13:52 -0500
Message-Id: <20191204201354.17557-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191204201354.17557-1-olga.kornievskaia@gmail.com>
References: <20191204201354.17557-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fix __be32 and u32 mismatch in return and assignment.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: dbd4c2dd8f13 ("NFSD add COPY_NOTIFY operation")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfsd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 0ff6ef9..c679afd 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -388,7 +388,7 @@ static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
 
 extern const u32 nfsd_suppattrs[3][3];
 
-static inline u32 nfsd4_set_netaddr(struct sockaddr *addr,
+static inline __be32 nfsd4_set_netaddr(struct sockaddr *addr,
 				    struct nfs42_netaddr *netaddr)
 {
 	struct sockaddr_in *sin = (struct sockaddr_in *)addr;
-- 
1.8.3.1

