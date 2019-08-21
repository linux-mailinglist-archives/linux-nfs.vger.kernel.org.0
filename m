Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256DD980AF
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2019 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfHUQux (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Aug 2019 12:50:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40557 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUQux (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Aug 2019 12:50:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id c3so2691274wrd.7
        for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2019 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=71vBF9Nkj97VaM9+zpTLtKEAxz9Hk4j5VybXZlaHuEs=;
        b=zEuhU6HBuQ92PbJrpP0i6WDrf3IjzncUSfWfRvSPm1P07ZhWQw6I/NunPSmkyshUBE
         pp29Qsgy9CT4+WuijOb29qrijejHx0PEsprDXe9IvpccBNsHcfLgzKbLsEr4zpEA9tuJ
         G5jFkf5oIA8jd86qcmzEXFmC7uqRhyq8Rulk3byKWl0cK3UN798bGYKIQoBndeXOcqBl
         l5ydcqGIjpuAHVGdZ6xiJdMEGfypJppnXidzHAp+ojAPoo+MRSx40iVFzwuqjZf/TfSZ
         3LkXlttwT7EE5GFzmO4w74iJp2eF4N8bZmZNoFmsGXV7WYLIK8v64baLD+27UuLtCkUn
         ik9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=71vBF9Nkj97VaM9+zpTLtKEAxz9Hk4j5VybXZlaHuEs=;
        b=ajRY64XbG4gIk8rnRMfu8ysxZPhJ1Yf/l0D76/4wtozgN7QrhE8yrl03a2YFgzA4iI
         vIs0YTuBM7PasfDhk8uU/yqHL9/7tiXhdzVahdRo0YxREvyb3/R6fdc7QPY4WL6Fw32m
         C1LqZQKH43N7YF34Wxgc5VrFqSwjofLUtyJn5QY23krEnAA+gkF+RS4cyDE7N4jwXWHN
         Q6OJ7aSB4CeLMGsilh8BtEOXPzWONVFxiq0a9GGgL8QzeedWjR6+Y5N1d1ONnYo5qxDk
         pBZsI6W6xBA8J3wPUycqt2N00Mq89ge0wzwqEEYxwhiBzpU4Abw/GsgltOZLjmSfn3Tr
         H4BA==
X-Gm-Message-State: APjAAAWOCmAznAachsLppzKvEMMIZlIE1wAgoHZ/T28+7c+Jxs3KZ/HG
        bIM9WcDkkL37jFxM3EFSKN4QL325gMQ=
X-Google-Smtp-Source: APXvYqyawkfX6qplwMPr9TTv4WGBlctftg7uUJBywnKXWrvCZYrHtFwlerDXMUjjoeRM+xt5uU5JOA==
X-Received: by 2002:adf:db01:: with SMTP id s1mr43251184wri.164.1566406250693;
        Wed, 21 Aug 2019 09:50:50 -0700 (PDT)
Received: from localhost.localdomain ([82.166.81.77])
        by smtp.gmail.com with ESMTPSA id j9sm26206636wrx.66.2019.08.21.09.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Aug 2019 09:50:50 -0700 (PDT)
From:   Alex Lyakas <alex@zadara.com>
To:     linux-nfs@vger.kernel.org
Cc:     shyam@zadara.com, Alex Lyakas <alex@zadara.com>
Subject: [RFC-PATCH] nfsd: when unhashing openowners, increment openowner's refcount
Date:   Wed, 21 Aug 2019 19:49:06 +0300
Message-Id: <1566406146-7887-1-git-send-email-alex@zadara.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

release_openowner() expects an extra refcnt taken for the openowner,
which it is releasing.

 With nfsd_inject_forget_client_openowners() and nfsd_inject_forget_openowners(),
we unhash openowners and collect them into a reaplist. Later we call
nfsd_reap_openowners(), which calls release_openowner(), which releases all openowner's stateids.
Each OPEN stateid holds a refcnt on the openowner. Therefore, after releasing
the last OPEN stateid via its sc_free function, which is nfs4_free_ol_stateid,
nfs4_put_stateowner() will be called, which will realize its the last
refcnt for the openowner. As a result, openowner will be freed.
But later, release_openowner() will go ahead and call release_last_closed_stateid()
and nfs4_put_stateowner() on the same openowner which was just released.
This corrupts memory and causes random crashes.

After we fixed this, we confirmed that the openowner is not freed
prematurely. It is freed by release_openowner() final call
to nfs4_put_stateowner().

However, we still get (other) random crashes and memory corruptions
when nfsd_inject_forget_client_openowners() and
nfsd_inject_forget_openowners().
According to our analysis, we don't see any other refcount issues.
Can anybody from the community review these flows for other potentials issues?

Signed-off-by: Alex Lyakas <alex@zadara.com>
---
 fs/nfsd/nfs4state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7857942..4e9afca 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7251,6 +7251,7 @@ static u64 nfsd_foreach_client_lock(struct nfs4_client *clp, u64 max,
 			func(oop);
 			if (collect) {
 				atomic_inc(&clp->cl_rpc_users);
+				nfs4_get_stateowner(&oop->oo_owner);
 				list_add(&oop->oo_perclient, collect);
 			}
 		}
-- 
1.9.1

