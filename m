Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7229291331
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2019 23:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHQVYu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Aug 2019 17:24:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40434 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfHQVYu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Aug 2019 17:24:50 -0400
Received: by mail-io1-f68.google.com with SMTP id t6so13265624ios.7
        for <linux-nfs@vger.kernel.org>; Sat, 17 Aug 2019 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EhEBJdpP5k31PHfmwaToO18TZhBuyHdwYIsFCHVfDjU=;
        b=Xd9cppub6RVxyLd4gh8KYd90CRHX16dDr3hi5UMfwbeMnNd9+AHMGwGzmcszVop2AI
         PkcSZC2wxgiEpC/iJfObuvo65kpXifkakoIR5hvCsKDYa3GhDNRBM0yCEJaEdhgwfmri
         YjOakeWQjTvSRac7nBFy2DHyBQgikASJ03sKhXolN5xrMRgzA5Z1NPQaebd+Btdc67z7
         xbgxpqP1kxuCToZfbKRaveQLDvLMwLIXNUQb+jXxdhR2lxtwN4aKhcj1JvS1MfiEkO9y
         ySUswXXr9f7HDTHikjxW8oUhHXaKAD5/B+XaK/8tKE1nDlVgU3uirZj8qUrYZMErh62N
         IBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhEBJdpP5k31PHfmwaToO18TZhBuyHdwYIsFCHVfDjU=;
        b=tMgH2xjWNY0TM8fkCJc1+i1zcPN2inYt+LbPm7nFa8Q9iOsiLVm03WMW4LDpKqfiQI
         MPgjq9T+TaS1YpvYbZ3eeCxum9LsWUZ4z8poY+N2DTA+X87He1bY8cEhU/5/nxIn8a4T
         I8hlHOgTlxC2tzUQ1MNik0aba4B11K7YQP4c4eyTPFrJx1JucP8bSuXBPV6xnCGvDs2m
         rOnVkS32oH4aYmxdcZnnW7wwGtfO0aNSdMIMWC/j5Kxpmm1Ny0vCEAod1mbqRK9pJMPx
         aoju/rCgSSLSKVLhgJngG4xFiG1TNvelMRsDLt8ApPb6wQCfMFFAwu4XBRHlVxObZ6Lp
         3Q1w==
X-Gm-Message-State: APjAAAVly86+wFA4MoTZ5Od+VlzpQRsumwW18JHUhw7xgXs72pwlt9+2
        wk1Ga5dp4H8L+AzY3/KmBo2ghMI=
X-Google-Smtp-Source: APXvYqzDLhbYtT4oFqow3dxK94rfthW36pYWdXI75fANZa8zd1QN8SoLFaWTWXLizzKNMDbRPVYhmQ==
X-Received: by 2002:a02:7121:: with SMTP id n33mr17386284jac.19.1566077088729;
        Sat, 17 Aug 2019 14:24:48 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q3sm4609806ios.70.2019.08.17.14.24.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 14:24:47 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/8] pNFS/flexfiles: Turn off soft RPC calls
Date:   Sat, 17 Aug 2019 17:22:14 -0400
Message-Id: <20190817212217.22766-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190817212217.22766-4-trond.myklebust@hammerspace.com>
References: <20190817212217.22766-1-trond.myklebust@hammerspace.com>
 <20190817212217.22766-2-trond.myklebust@hammerspace.com>
 <20190817212217.22766-3-trond.myklebust@hammerspace.com>
 <20190817212217.22766-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The pNFS/flexfiles I/O requests are sent with the SOFTCONN flag set, so
they automatically time out if the connection breaks. It should
therefore not be necessary to have the soft flag set in addition.

Fixes: 5f01d9539496 ("nfs41: create NFSv3 DS connection if specified")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index c0046c348910..82af4809b869 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -627,11 +627,16 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 			/* Add this address as an alias */
 			rpc_clnt_add_xprt(clp->cl_rpcclient, &xprt_args,
 					rpc_clnt_test_and_add_xprt, NULL);
-		} else
-			clp = get_v3_ds_connect(mds_srv,
-					(struct sockaddr *)&da->da_addr,
-					da->da_addrlen, IPPROTO_TCP,
-					timeo, retrans);
+			continue;
+		}
+		clp = get_v3_ds_connect(mds_srv,
+				(struct sockaddr *)&da->da_addr,
+				da->da_addrlen, IPPROTO_TCP,
+				timeo, retrans);
+		if (IS_ERR(clp))
+			continue;
+		clp->cl_rpcclient->cl_softerr = 0;
+		clp->cl_rpcclient->cl_softrtry = 0;
 	}
 
 	if (IS_ERR(clp)) {
-- 
2.21.0

