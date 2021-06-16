Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB07D3A8E17
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 03:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhFPBMZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Jun 2021 21:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFPBMY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Jun 2021 21:12:24 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D01DC06175F
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:18 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d196so900568qkg.12
        for <linux-nfs@vger.kernel.org>; Tue, 15 Jun 2021 18:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SfaMZZ0vlI2y02Jl2xfftekKLJe3H9jraX9ERFYGAI=;
        b=pnmuJJDTjZKmT1iM/Sfw/piCjDqR4AEUk7qUZSCI9wq3/WrWpE3mM7pEB+zmtqaGUi
         RRFKi2F+Lno54mt/kgYBQey5BVVghKFuw8cr6SO4L69ItXDLHulCbK+3TC1vqVWg8YSI
         KYyMcM4sHuI1MLygQ3lNVcoXkhLsjdwWURKtplSejglklvKBdoWkGslgdYJsPWWF9Zyk
         ezGhAJTUQ+R1SAGGdH+qp655lOSxysGwnAYYv3GiUlD7J3MxYimPS8DXzyQZlDT+ImIX
         WiL6uHEfY0G6zX3fJIwqnDPjcgMv/Ro1nr4ePgo1+ifJHtJUIieE9WEaH03BE/w765Cc
         YSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SfaMZZ0vlI2y02Jl2xfftekKLJe3H9jraX9ERFYGAI=;
        b=GVpH0s/wrxnERL7egYMhY54+srrFl2bjCvKxu0f1Q6OvHsOTBBTX6y96ZMpY6lzplb
         Yv0zT1KJVu/22X+k5vEvdjjGVMfzpSxmATYFW1l6t/smkTQ16VL4QN40fzEJ21a0i//p
         PEJxO25oYC7T96/TR2CdIdv6ooH3V97XemSBonopMYhQJjM3JJglFvizeLeeg1xtPTpL
         os40V490kKUl2YeibT2d0SrQiUVX+r0i8fWDo7BftwkminImlgu3q2XagI95wYOwXUKl
         a2W8r06oEBlwlHr0rCYG7dkG2xLPTjS0gHQXlfqtwfz9WGmmoieZxrTU+EXAjVDGi24A
         6dow==
X-Gm-Message-State: AOAM533VsCGbHf/K217QnBiYfXmp+n3VU1w+QNXnRSE9FGKBC9bwgJYZ
        l+Q8lAOD902clazwOLf7IZqrSGyc2urSbQ==
X-Google-Smtp-Source: ABdhPJyt2GqshBcIok8/b0K5IeOFphvBXRQpVcNppGeBiWLtWOAM+vYiUx0EBF8VTJVD25r5LtwdeA==
X-Received: by 2002:a05:620a:1299:: with SMTP id w25mr2664359qki.320.1623805817704;
        Tue, 15 Jun 2021 18:10:17 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m189sm546007qkd.107.2021.06.15.18.10.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 18:10:17 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/6] SUNRPC keep track of number of transports to unique addresses
Date:   Tue, 15 Jun 2021 21:10:08 -0400
Message-Id: <20210616011013.50547-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
References: <20210616011013.50547-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently, xprt_switch keeps a number of all xprts (xps_nxprts)
that were added to the switch regardless of whethere it's an
nconnect transport or a transport to a trunkable address.
Introduce a new counter to keep track of transports to unique
destination addresses per xprt_switch.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprtmultipath.h | 1 +
 net/sunrpc/clnt.c                    | 2 +-
 net/sunrpc/xprtmultipath.c           | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index b19addc8b715..bbb8a5fa0816 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -18,6 +18,7 @@ struct rpc_xprt_switch {
 	unsigned int		xps_id;
 	unsigned int		xps_nxprts;
 	unsigned int		xps_nactive;
+	unsigned int		xps_nunique_destaddr_xprts;
 	atomic_long_t		xps_queuelen;
 	struct list_head	xps_xprt_list;
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 9bf820bad84c..e6801a481d02 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2761,7 +2761,7 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 
 	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
 			&rpc_cb_add_xprt_call_ops, data);
-
+	data->xps->xps_nunique_destaddr_xprts++;
 	rpc_put_task(task);
 success:
 	return 1;
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 07e76ae1028a..584349c8cad4 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -138,6 +138,7 @@ struct rpc_xprt_switch *xprt_switch_alloc(struct rpc_xprt *xprt,
 		xps->xps_iter_ops = &rpc_xprt_iter_singular;
 		rpc_sysfs_xprt_switch_setup(xps, xprt, gfp_flags);
 		xprt_switch_add_xprt_locked(xps, xprt);
+		xps->xps_nunique_destaddr_xprts = 1;
 		rpc_sysfs_xprt_setup(xps, xprt, gfp_flags);
 	}
 
-- 
2.27.0

