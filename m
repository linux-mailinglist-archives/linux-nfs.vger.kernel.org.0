Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BDC450A5C
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Nov 2021 17:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhKORBb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 12:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhKORBX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 12:01:23 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A213FC061200
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 08:58:21 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id p4so9154340qkm.7
        for <linux-nfs@vger.kernel.org>; Mon, 15 Nov 2021 08:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzVElRvg5LoAVTeE9+Xvz2quw/GX7qMg60dkLCfCGd0=;
        b=oXNaaq91Bc1ppacy75fl1ulKIVe/UfjxN5S5EstTslz8Ki8Dup3k3z8cT75aykeZyO
         L89rrYPNbk2w93EpJ9RSpMeTd+7G470CvEEZiJEmeqOdUzofnaC+EeAaR69mkNFJtbLa
         sRZp6CfQ6CYAOAlxkPlQIFZ8j44Q/vG8J45uvIJ7QbNu2NaHZmH2ppghfm0jRuaoVARH
         ydCvj7PITgDLEN3hsPBouP8JpQADplH0rSMD9X7E6GXPfS07IBQQWXeNRDaFaP+3UuBb
         IeHopIVMUtSc4KpfW3vUxRUZjNOBVhFKd6tyGCPyqdTlD6Zww2euPc/C8USGdLjbyIgj
         5w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QzVElRvg5LoAVTeE9+Xvz2quw/GX7qMg60dkLCfCGd0=;
        b=1v0YxPyxdRgYJ7ayGI3HV4cuhuSUEJ/TJTS/vHCp4hSRjXbcMSnGsT6yzUrTdt7fJQ
         uNxMsAICQRpiLAeXoawmu3NqJM+Ii/knYggRWKhDA92WBAf/XlbFP6XC6tNPzjxGuGw8
         lKuy9W/q/vN/vbul+ES80vJ/BDVIqqi3sMMXfnnPM0ip+PpNRtuD0cuiQE5T/29iIVnG
         uBOPYJDlp/t8nMpo7CebJxiUaMnrkkeS6Pwth4G7a727U2x/8TPwSyA8W94r/T1d8OdO
         LleasVg4vkK/stuBLho4YeFVzjqO0jfONI+zHER5kpolz2a35Ts6W2MZhiWcaNw1p273
         IyqA==
X-Gm-Message-State: AOAM5316Y3kL5Lv7GsjbAr3xM9oCRJrR7uE2kwuFaxGeIAnLx1cEFBJR
        RhmTslJ/B3NybTkQdS3Dz7g=
X-Google-Smtp-Source: ABdhPJyAv9xdw9khYfRrpLLQzoP1/K7pAuvmBXBMFKK3ri5tbX42lSOFMFVmhE44geElK6sPV9WI1g==
X-Received: by 2002:a05:620a:440b:: with SMTP id v11mr407693qkp.160.1636995500278;
        Mon, 15 Nov 2021 08:58:20 -0800 (PST)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id v7sm6988472qki.98.2021.11.15.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:58:19 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 2/3] sunrpc: Provide a helper function for accessing the number of xprts
Date:   Mon, 15 Nov 2021 11:58:17 -0500
Message-Id: <20211115165818.2583501-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165818.2583501-1-Anna.Schumaker@Netapp.com>
References: <20211115165818.2583501-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 267b7aeaf1a6..0a94fe1036a8 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -238,6 +238,7 @@ const char *rpc_proc_name(const struct rpc_task *task);
 
 void rpc_clnt_xprt_switch_put(struct rpc_clnt *);
 void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *, struct rpc_xprt *);
+unsigned int rpc_clnt_xprt_switch_num_xprts(struct rpc_clnt *);
 bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
 			const struct sockaddr *sap);
 void rpc_cleanup_clids(void);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a312ea2bc440..399768a443ea 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2994,6 +2994,16 @@ void rpc_clnt_xprt_switch_add_xprt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_add_xprt);
 
+unsigned int rpc_clnt_xprt_switch_num_xprts(struct rpc_clnt *clnt)
+{
+	unsigned int num;
+	rcu_read_lock();
+	num = rcu_dereference(clnt->cl_xpi.xpi_xpswitch)->xps_nxprts;
+	rcu_read_unlock();
+	return num;
+}
+EXPORT_SYMBOL_GPL(rpc_clnt_xprt_switch_num_xprts);
+
 bool rpc_clnt_xprt_switch_has_addr(struct rpc_clnt *clnt,
 				   const struct sockaddr *sap)
 {
-- 
2.33.1

