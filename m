Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6D03B2577
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jun 2021 05:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFXDbQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 23:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFXDbQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 23:31:16 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991A6C061756
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:28:57 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i17so4674053ilj.11
        for <linux-nfs@vger.kernel.org>; Wed, 23 Jun 2021 20:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ee336bxKIuOlvF/K5YoW63n+TrKhakpxaOkSHP+m6V8=;
        b=FonW707Y1W5GpBPoA1S3MPdDGZSccKChkes8/XwIOhVF+nvoHm2BBGL7pgjZaHZsd5
         yDk2vfcFpQg4jv7WlBh/4/qMKilZGQBFMYVzmMLTONM6DD79uTAWAWxslE26sBLW0NxH
         k9fLOVi2WMUCO/CzxBirhe9XfelaaZqpAmsQ6xi4BfHe0uLwQT+F9PGt2/Z8A1Ci9qaF
         3zzBjIQ2/BcHos/uLeE8oVvUP+ilXyY1HBJBZkl8T60MLs+RpD9kYw8Un2AanlyR57uf
         Fhht8RmF5PYYlCRZb/k1hOaDZDhuMujpNIEzLcIhke9fB8gns085wQ9b9dN3bXiwyF7T
         GGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ee336bxKIuOlvF/K5YoW63n+TrKhakpxaOkSHP+m6V8=;
        b=EDi4MFtOCF1hEwpx3mDjDZEC0UTk4mYJjxOXedHUfULTn6EXrO1i3YANKDm+9Gmf6J
         /AeQL/grx6oZ0XLu5q//D6sZPNA0q2nE82jJxVJU03GJBelyLm6phBNQSV0b7K166Ano
         nHEV1RM0fgmyguIsOyMgnSP4WTu9m3CEUCxwr8ieu0EZIi8Ir0VHshsy9b4aBbzGPk8v
         rS0lzRRWCKqZ+8yjOF+fnO/OU8H2R58/DrKuJuXqbWZ7kfyTTCJAMEse746r3jcdXOcj
         XSHWPRKW8BaGKeaYLTC2Zz4Cix7H/I5We/oH36Kez1S8zKrKBQQhl+LSJhpQF8hrbhVf
         dk0w==
X-Gm-Message-State: AOAM530FThLdhg05RO+YoDqRACr3jXWVm4PSNSp9X/UvM7HiWft6jG3N
        kRVmCTbBSQyfdgRa+b1Ec2h1VaJ1noc4+w==
X-Google-Smtp-Source: ABdhPJz42lrXOqyBFyc1hU0uTETF4BeT/HivI0e37hsHcH3SapA5Tj9uzt2iRyD+gztFQRxbI46rQg==
X-Received: by 2002:a05:6e02:13ad:: with SMTP id h13mr2032009ilo.128.1624505337089;
        Wed, 23 Jun 2021 20:28:57 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:fd18:15dc:e0e4:e39e])
        by smtp.gmail.com with ESMTPSA id g4sm1026780ilk.37.2021.06.23.20.28.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jun 2021 20:28:56 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/8] SUNRPC mark the first transport
Date:   Wed, 23 Jun 2021 23:28:46 -0400
Message-Id: <20210624032853.4776-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
References: <20210624032853.4776-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

When an RPC client gets created it's first transport is special
and should be marked a main transport.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h | 1 +
 net/sunrpc/clnt.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 13a4eaf385cf..692e5946c029 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -293,6 +293,7 @@ struct rpc_xprt {
 	struct rcu_head		rcu;
 	const struct xprt_class	*xprt_class;
 	struct rpc_sysfs_xprt	*xprt_sysfs;
+	bool			main; /*mark if this is the 1st transport */
 };
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 4d8fd9d9c264..7ca946567e13 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -412,6 +412,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	}
 
 	rpc_clnt_set_transport(clnt, xprt, timeout);
+	xprt->main = true;
 	xprt_iter_init(&clnt->cl_xpi, xps);
 	xprt_switch_put(xps);
 
-- 
2.27.0

