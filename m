Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0906F34F73
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 19:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFDR7p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 13:59:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46743 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfFDR7p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jun 2019 13:59:45 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so8155002iol.13
        for <linux-nfs@vger.kernel.org>; Tue, 04 Jun 2019 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GT8X+EsNYBb5UMZWBMZ2Z4O0Ne33KByhJ3ztwwgYRAs=;
        b=ifE03cODeqTZxkm/JiWk/+7Tc9DwiSxTwJHOtBdil+wuwuYxxkbz9wrlXP2QOyJOwD
         PebTqbIn8H86AYvU/mpKML0FKOAX1nYKy7x1sSfxJ2VviKwevaCsxhQ3F/xXoSHMiQ0p
         YBhhZAi89CKNJEabz1Xhgc9cf1PpDDP41OjWLpLuyXlFE9xIkWy0Po+QAiN6CHzPzBRd
         BXOec8yBrOgTd37Msurp5RFE/dr42armY86Cy+j1YpPnN8MB+e/YFyZ9n2rLefPcybWQ
         817H4SufcO90cH/0WpothfeixiI7zLwEAwfUrDDVSkM9lvI99s2gFD6iNYvZI3eutQBg
         HpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GT8X+EsNYBb5UMZWBMZ2Z4O0Ne33KByhJ3ztwwgYRAs=;
        b=Vo9NvNWEz8O2RL1QLKK7d2qQLOl4KwN18m7Mb55HruT2jSZYr8S6trBbuSZIwOElas
         +6l5aTc+0oXoCsqGN3bPkgEbm4Ck38rvf5px3+GImPybuNcARff+X1mjxI6XVenTcP/B
         +WRsU6mytbo07+APXMn8yQqf73KOd/HmYwJGSK7vvFiBw2Sg9cIVNBepfNI8xNvQpoN0
         EqTBEUpkMBgGUllLQtHTUvZNNCn5iBcEMbDPbrQy16Pb5MosZV0uGTWYGQ6PgfBOApaf
         hpRGHaOyX44qTMewoZPdk7POlQEOcmCTjSwkGXw2paGxlbtjFFDKr498spS/SAFA58SB
         +5Uw==
X-Gm-Message-State: APjAAAUGFoFAZzLZqFVLI6RKXAl55sblyx2T6CI3+sedpUn8CgeosdwS
        8Vjcy79m4txdsvIHCHM+6w==
X-Google-Smtp-Source: APXvYqz7dZShp1ZPjVCVYbHAatC6l0pUi4Lw17Rn0ic5YNQZ9H7xMAnzITYB/+3Y7ERABS76P3/g7w==
X-Received: by 2002:a6b:c411:: with SMTP id y17mr425998ioa.265.1559671184176;
        Tue, 04 Jun 2019 10:59:44 -0700 (PDT)
Received: from localhost.localdomain (50-36-175-138.alma.mi.frontiernet.net. [50.36.175.138])
        by smtp.gmail.com with ESMTPSA id u134sm8355134itb.32.2019.06.04.10.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 10:59:43 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Steve Dickson <SteveD@redhat.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/3] mountd: Fix up incorrect comparison in next_mnt()
Date:   Tue,  4 Jun 2019 13:57:32 -0400
Message-Id: <20190604175734.98657-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604175734.98657-1-trond.myklebust@hammerspace.com>
References: <20190604175734.98657-1-trond.myklebust@hammerspace.com>
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

