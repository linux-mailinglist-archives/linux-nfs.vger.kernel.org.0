Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460992E951C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 13:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbhADMme (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 07:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbhADMme (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 07:42:34 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF4C061574
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jan 2021 04:41:53 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a13so12892812qvv.0
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 04:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dPiea3HG8U2/FXKL70iDYeCFWJ9iHhzEX/zCrRF5I60=;
        b=LhO+0QMKP3kd+aKfzoDm3r4F9aCFE8KmYOsRdB94DEeh2jTDBS+Lh7ctsGCxPZeZPv
         im7p73EJgF/dYblDMo4k3VtIFD4hs25B+0jAcoCrzTW04wk/R874qZQZdJzVj+PTuGOT
         O1ZD79Up7unc2E12Ms8XVwlMOncUu3LcO89Q4z9/c93qVeurTxXDObmqu4iWDJPvO2xP
         bpvv0w+j/hl7X+CQkXmJSme7piABm5AxvzDAtDxOjqS6K4EmStjrvHvkALf7nyZmu3be
         is0D4fb+1RdsTiWSBVXg1f6nZnO75lcdoQGtKjMapI0tEwX62ZJlgwUrWhxW54KyECDX
         Y0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dPiea3HG8U2/FXKL70iDYeCFWJ9iHhzEX/zCrRF5I60=;
        b=IA5YmKHavqQc99xp1WyxzMSfacTYnXAuCDUutRqJXUKJyeqzlg+gFFnQl0HeYnCSLj
         KWkNAAmKyICNApnbFKnSwOSpygy8rw4rWEqgNqb4AagcpNd01VOICb3wTJBm3afKzi6D
         Y6XfnGSuP+WVIfQM7/xrsCU4mG4wl5lGOrGPnBpOfLy76uUD8iGr8Bp3pZdFg51OCd47
         BHewSKSkRGAvmxPbp9AUHaFX6+mpNjbARK8Ndf+aXvJi5jVar+BZdCgahH+GeXw2EHAk
         6eqTL8Whd34QtfVMiRbzSN9XebeccP1oNxI+6MFGL2u5P9DpNXCbbaQLHAksumE8o8NZ
         zrWA==
X-Gm-Message-State: AOAM530/7fKfnn3KlLSx1+dstcjLefKhIXSeiVYPcZU9DCyqFF7nDe/e
        f3hA/H3TlfDXl9dMI3+GKEL4pTVoADs=
X-Google-Smtp-Source: ABdhPJzfRzENAzdghlo8M4U4B9zFnKhjzX+EIEgsfETf+4Kp8NGvpv+nSxOSOC2bMzueUMPJmRNqtw==
X-Received: by 2002:a0c:f444:: with SMTP id h4mr77360805qvm.12.1609764112617;
        Mon, 04 Jan 2021 04:41:52 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y15sm37034950qto.51.2021.01.04.04.41.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 04:41:52 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 104Cfo3q017703
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jan 2021 12:41:50 GMT
Subject: [PATCH] NFSD: Fix sparse warning in nfssvc.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Jan 2021 07:41:50 -0500
Message-ID: <160976407141.1221.6463173831960865696.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

fs/nfsd/nfssvc.c:36:6: warning: symbol 'inter_copy_offload_enable' was not declared. Should it be static?

The parameter was added by commit ce0887ac96d3 ("NFSD add nfs4 inter
ssc to nfsd4_copy"). Relocate it into the source file that uses it,
and make it static. This approach is similar to the
nfs4_disable_idmapping, cltrack_prog, and cltrack_legacy_disable
module parameters.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    5 +++++
 fs/nfsd/nfssvc.c   |    6 ------
 fs/nfsd/xdr4.h     |    1 -
 3 files changed, 5 insertions(+), 7 deletions(-)

Hi-

I intend to include this with the first NFSD v5.11-rc pull request.


diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4727b7f03c5b..8d6d2678abad 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -50,6 +50,11 @@
 #include "pnfs.h"
 #include "trace.h"
 
+static bool inter_copy_offload_enable;
+module_param(inter_copy_offload_enable, bool, 0644);
+MODULE_PARM_DESC(inter_copy_offload_enable,
+		 "Enable inter server to server copy offload. Default: false");
+
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 #include <linux/security.h>
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 00384c332f9b..f9c9f4c63cc7 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -33,12 +33,6 @@
 
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
-bool inter_copy_offload_enable;
-EXPORT_SYMBOL_GPL(inter_copy_offload_enable);
-module_param(inter_copy_offload_enable, bool, 0644);
-MODULE_PARM_DESC(inter_copy_offload_enable,
-		 "Enable inter server to server copy offload. Default: false");
-
 extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index a60ff5ce1a37..c300885ae75d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -568,7 +568,6 @@ struct nfsd4_copy {
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
 };
-extern bool inter_copy_offload_enable;
 
 struct nfsd4_seek {
 	/* request */


