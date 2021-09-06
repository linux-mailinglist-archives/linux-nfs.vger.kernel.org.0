Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A42D4014ED
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Sep 2021 03:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbhIFCAm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Sep 2021 22:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbhIFCAm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Sep 2021 22:00:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B556CC061575;
        Sun,  5 Sep 2021 18:59:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so3320961pjc.3;
        Sun, 05 Sep 2021 18:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=lL/gGNTGH9DC6PNdYT9D3YTeFu4Msr6Mh1n9Bkcpt+I=;
        b=a1nY/qBjMOjzV9rNW9tJLMV0pIcbDyaGWIb9A7UiPDxyfejOhT9zKnLXuCVJGi3dXU
         Ck9nSSQn+nJ+VzZ/w8cADCDfwn4PwkrFk8YOmuFNw+ES62CRMCXpjHmClOwsYJJ9NOwL
         vUId7+I4ibGxnWf6Vj/O5wm24nKs4ucZWdD/r53mCAzdbFVD1OjXaopjG0JvlU+3X+6U
         h9+TODQB80z9PciqZigmNUegyjzjZQ1u/G/E9LHT9DthgFHUdIVj73V4f5yHuXAOot/+
         5Nx7nOOViFpXnhMICGcUdW4vH49O4jJW4zEVzn/mqpGEmtL58uZFVNCzI0cPiaHYarz+
         jSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lL/gGNTGH9DC6PNdYT9D3YTeFu4Msr6Mh1n9Bkcpt+I=;
        b=Dj5/UljJf7hQuWE8UoTkA7ZCSRXl3UBFgrSM81nuH8LeSixEg7ymSsoltIRVWkYikG
         GmpG5ZnbG5zgX+h2LyIqez7OejIpIPiAXE4KS4xQD3yIkXT4VmKP+KKNgOuZE+aex0Pw
         qkITg/8HcPHkuZwIhVhwrI1s7Z4kE0VHIhB0REztUMIwMkFmO3NUm0iL+j4Zh+NzOZIu
         MICWjOg8i+xh4PZf3oR4eKRoGfdY8N/pBCSXYWA4Z43VD3XZOKGvVJ4qEgGPHlLo2V5V
         k4++3A+2Fe+yziKzEWT4E+/oSdM/AZuWIF5MHypLubs1leirU9j0XyDr+vo0KWCbc6jq
         m+eg==
X-Gm-Message-State: AOAM533STjDns0X706vOlaE7ZxL7y531oFjBsACx5Bs3X09Pt73b0cLY
        bFGuwBc70ZpOmbaE6tejAVQ=
X-Google-Smtp-Source: ABdhPJzes0CjsVGE7pEjW1LLfpBpTPz2z91olb7uM6pHTm+WcRjAmDDVq6jdRQ9IrRzSSvM9SLrmlg==
X-Received: by 2002:a17:90a:bf06:: with SMTP id c6mr11419229pjs.55.1630893578044;
        Sun, 05 Sep 2021 18:59:38 -0700 (PDT)
Received: from localhost (natp-s01-129-78-56-229.gw.usyd.edu.au. [129.78.56.229])
        by smtp.gmail.com with ESMTPSA id w5sm6757301pgp.79.2021.09.05.18.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 18:59:37 -0700 (PDT)
From:   Baptiste Lepers <baptiste.lepers@gmail.com>
Cc:     Baptiste Lepers <baptiste.lepers@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Tao Peng <bergwolf@primarydata.com>,
        Tom Haynes <loghyr@primarydata.com>,
        Weston Andros Adamson <dros@primarydata.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pnfs/flexfiles: Fix misplaced barrier in nfs4_ff_layout_prepare_ds
Date:   Mon,  6 Sep 2021 11:59:24 +1000
Message-Id: <20210906015925.13705-1-baptiste.lepers@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

_nfs4_pnfs_v3/v4_ds_connect do
   some work
   smp_wmb
   ds->ds_clp = clp;

And nfs4_ff_layout_prepare_ds currently does
   smp_rmb
   if(ds->ds_clp)
      ...

This patch places the smp_rmb after the if. This ensures that following
reads only happen once nfs4_ff_layout_prepare_ds has checked that data
has been properly initialized.

Fixes: d67ae825a59d6 ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 4 ++--
 fs/nfs/pnfs_nfs.c                         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index c9b61b818ec1..bfa7202ca7be 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -378,10 +378,10 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 		goto noconnect;
 
 	ds = mirror->mirror_ds->ds;
+	if (READ_ONCE(ds->ds_clp))
+		goto out;
 	/* matching smp_wmb() in _nfs4_pnfs_v3/4_ds_connect */
 	smp_rmb();
-	if (ds->ds_clp)
-		goto out;
 
 	/* FIXME: For now we assume the server sent only one version of NFS
 	 * to use for the DS.
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index cf19914fec81..02bd6e83961d 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -895,7 +895,7 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 	}
 
 	smp_wmb();
-	ds->ds_clp = clp;
+	WRITE_ONCE(ds->ds_clp, clp);
 	dprintk("%s [new] addr: %s\n", __func__, ds->ds_remotestr);
 out:
 	return status;
@@ -973,7 +973,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 	}
 
 	smp_wmb();
-	ds->ds_clp = clp;
+	WRITE_ONCE(ds->ds_clp, clp);
 	dprintk("%s [new] addr: %s\n", __func__, ds->ds_remotestr);
 out:
 	return status;
-- 
2.17.1

