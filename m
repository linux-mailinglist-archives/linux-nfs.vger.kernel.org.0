Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780512D0C9F
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Dec 2020 10:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgLGJGp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Dec 2020 04:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgLGJGp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Dec 2020 04:06:45 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012F3C0613D0;
        Mon,  7 Dec 2020 01:06:08 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id lb18so4446028pjb.5;
        Mon, 07 Dec 2020 01:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ttg1rgPf81KMFs3MAsw98RgUM6DZxTe/dh3Tbs/2el8=;
        b=ZFe+vJuxVzwH6L3xGq5RxOLkK6FCo7WC4pnxuzJXiN5yjhDSs/P9z0HpSHzHQMZwHk
         vojv4LMDJU2lgqID3kGeJeSvDg5jTuBQowGitGi2HAL909530T5mmCadxNGsuM91y0pD
         2PHQ0GeL9Jr+Fe1OWwp6tSn83DRVy3e/IQHiM+YJ4I7spXpsIwKkmx+xSSFfWnpZiYsp
         LCuAkZVEkMTh9tQFZDwyZkptVpDghq5IoQXxAUJPaKvu3ZJMe7FitqTrEhGwQvd49gQ8
         VkqEwWMA+dK1eNzRI+Xm3cqehrPUlHU1+LW6SVOItOREWF8qKljE7xLDx6Fe3QoQ1jDy
         qlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ttg1rgPf81KMFs3MAsw98RgUM6DZxTe/dh3Tbs/2el8=;
        b=TrUDFvushVkgeGooSXIhxEeukgL9rIUJqayS1nt5wyE1QOpcl6J5BXEYL8ts68xal2
         SQOj1gw7adLyHOaHGet2U9fIa3TfYbht6IwJ1M8yKRC4aFNT6ypiawsjl2kohTOhekmx
         mb/VDewlx1Vriw85cL0rSVhR9G73/sgHEisA3of5YhGUyBjXusd2GrsfC5FCcMAHLVcq
         BIyKsJ3SS8vojWxLEyjqhIX6C4R7oPkMRNIfUDxaPSWXJJcix9ZHaB+qJ8kL32Kch7RD
         rRCTUC2l1SKkMzZj66Q2QZqq8DBBfM+wqBt3UW56CS9kD16WIjrZe9wL3qNCz5IxYT6Y
         6tug==
X-Gm-Message-State: AOAM532qiE6E9xB9WrgfV94YkmjqWsB/GZkVvdznz6YaZJj9lxgtWNva
        qOQuq7oVIrdcedsbIaPD3z7QPR/WPvZQHg==
X-Google-Smtp-Source: ABdhPJzEn5m248AQgPmsUejwM6smpfpdVRvAV+OT6/3BbNRW9SkbTwoS4BWlRaE1LHutf4OoFJpNTQ==
X-Received: by 2002:a17:90a:6ac5:: with SMTP id b5mr15929315pjm.210.1607331967547;
        Mon, 07 Dec 2020 01:06:07 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id j18sm10600078pgk.6.2020.12.07.01.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 01:06:06 -0800 (PST)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Geliang Tang <geliangtang@gmail.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] NFSv4.1: use BITS_PER_LONG macro in nfs4session.h
Date:   Mon,  7 Dec 2020 17:03:52 +0800
Message-Id: <0070adebf1d8e260de713537cc2f6c860c9026ed.1607331694.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use the existing BITS_PER_LONG macro instead of calculating the value.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 fs/nfs/nfs4session.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4session.h b/fs/nfs/nfs4session.h
index b996ee23f1ba..3de425f59b3a 100644
--- a/fs/nfs/nfs4session.h
+++ b/fs/nfs/nfs4session.h
@@ -34,7 +34,7 @@ enum nfs4_slot_tbl_state {
 	NFS4_SLOT_TBL_DRAINING,
 };
 
-#define SLOT_TABLE_SZ DIV_ROUND_UP(NFS4_MAX_SLOT_TABLE, 8*sizeof(long))
+#define SLOT_TABLE_SZ DIV_ROUND_UP(NFS4_MAX_SLOT_TABLE, BITS_PER_LONG)
 struct nfs4_slot_table {
 	struct nfs4_session *session;		/* Parent session */
 	struct nfs4_slot *slots;		/* seqid per slot */
-- 
2.26.2

