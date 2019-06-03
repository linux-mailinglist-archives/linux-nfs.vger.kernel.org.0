Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2018033651
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfFCRQC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 13:16:02 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35421 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfFCRP4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jun 2019 13:15:56 -0400
Received: by mail-it1-f195.google.com with SMTP id n189so9385524itd.0
        for <linux-nfs@vger.kernel.org>; Mon, 03 Jun 2019 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GT8X+EsNYBb5UMZWBMZ2Z4O0Ne33KByhJ3ztwwgYRAs=;
        b=oXfU8Kd+U3YooLaIdo2/Uk53G9kxv6p6ODuXkBiZM8GzLU3MvCCrosJ2j4JL+MHojs
         /72WbxaLQlHQXcZrM9Y/BCT8+XU3tFJqi6sX3kW8qwrCEtf+dCGCoI+tAE+hJ3ZmanQq
         zishqNcmHAo93zyHAigQMrqhXRytR7ngC5JRV8KWSWzGLv2v6kYWQds3XKZ0nnrNdT4+
         VColuGs3k5QIercFxjE97kcyOWqKlGcxdvlT0t/3zyNvblteJUefn++kb1DtYVd2gKxV
         dTOLJbr0HK1LVessxeYmZEWP4ml+qWQboqKQzfZeF/fXb9JasWX2VQfRaap3kgjxhIw+
         BRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GT8X+EsNYBb5UMZWBMZ2Z4O0Ne33KByhJ3ztwwgYRAs=;
        b=lwcJCDTZsyoVtjzWo6f5NRS+pESGMIIsPYylIl6sfoGZ9ZNeS2Xi66DEEcWEemntEQ
         ns35cyq1APkg7OTSWxpYXpHYKYkrOcE71sFRQ20YG+RVHaG2Zj3TldEXiyC4E8i5y7P3
         fpRYku4FCO7hRGjJ5APgpWpPasiINy647U8cuzExQUxPnzoheDx/7lYV9jqBbJhWImgz
         4sl4t0A1CUezDnZqazUr+L8Cqd3NlqSe5pwYlORC78tuSSL90p8REdjw7zBOgvvJ15WJ
         5nVrSp/N8Sln1BXfto/U1oljF1yxJxyFLgUmF/3Rc53uunm4PVcaG6ijfTuoGi4bj1/O
         Rl9g==
X-Gm-Message-State: APjAAAX5AbF4cygK1EKNAtFVXfCe3YgwV8CdQMy4q5b/oDKwhCY+1Tep
        TXv+21ZkdrD7KaYQ8l8eNL4HSEI=
X-Google-Smtp-Source: APXvYqxnKPEb4K6rViVc8FY38myUuvCBqLU4L170ybmlL4AX+lnZZgDtxxwtUi91xiejLHorikLsRg==
X-Received: by 2002:a02:c95a:: with SMTP id u26mr2423772jao.15.1559582155559;
        Mon, 03 Jun 2019 10:15:55 -0700 (PDT)
Received: from localhost.localdomain (50-36-175-138.alma.mi.frontiernet.net. [50.36.175.138])
        by smtp.gmail.com with ESMTPSA id b8sm1971375ioj.16.2019.06.03.10.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 10:15:55 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] mountd: Fix up incorrect comparison in next_mnt()
Date:   Mon,  3 Jun 2019 13:12:25 -0400
Message-Id: <20190603171227.29148-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603171227.29148-1-trond.myklebust@hammerspace.com>
References: <20190603171227.29148-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We want to ensure that we compare the full name of the last component.

Reported-by: "J. Bruce Fields" <bfields@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 utils/mountd/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/mountd/cache.c b/utils/mountd/cache.c
index d818c971bded..d616d526667e 100644
--- a/utils/mountd/cache.c
+++ b/utils/mountd/cache.c
@@ -400,7 +400,7 @@ static char *next_mnt(void **v, char *p)
 	while ((me = getmntent(f)) != NULL && l > 1) {
 		mnt_dir = nfsd_path_strip_root(me->mnt_dir);
 
-		if (strncmp(mnt_dir, p, l) == 0 && mnt_dir[l] != '/')
+		if (strncmp(mnt_dir, p, l) == 0 && mnt_dir[l] == '/')
 			return mnt_dir;
 	}
 	endmntent(f);
-- 
2.21.0

