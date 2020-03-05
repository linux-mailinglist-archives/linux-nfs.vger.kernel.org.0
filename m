Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3B517B24C
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2020 00:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgCEXiQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Mar 2020 18:38:16 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33240 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEXiQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Mar 2020 18:38:16 -0500
Received: by mail-yw1-f66.google.com with SMTP id j186so569365ywe.0
        for <linux-nfs@vger.kernel.org>; Thu, 05 Mar 2020 15:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WQRagZjEQb6MuQ+PTLGl2br/RKPZAlzPZPRzayKDcCo=;
        b=rzsMKUm3uCTZYz/NxaV/Zg8AoIUKbfFVLvpfGOUTERinjkyaSpJ2XJF3DEpcVYG5TT
         Ju+ltUcjIFB/Gn1PTnjqN/afCY757Q+BWo7WJzOPBT5Qyu51C8TOjerVEdHWKaUYiLsv
         uOMl0bkyVVR1Icyy99jz7LutIrvPUFQn9DUzLsjTnju/iThl1F+4YnaTFynh63g6C9IL
         WaE0o/7xue7Ltw5D8iqwlFET9L3XjFiirR4C8wB7gfvV8bXfx2I9wtL21+2K9FbdMYYV
         0o9gHXfzblUF8ZxcffxDMZAUuv9WQHwzCDd92UKK9ZBmKvAHAhCyOy5cbRgfIYLX6eNf
         zp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WQRagZjEQb6MuQ+PTLGl2br/RKPZAlzPZPRzayKDcCo=;
        b=hApwzK0yCXS0oTb0HSGcy4w+K0nTsyg12Zd495XLK+206c8cunVrQUrpPs8+XrXxTL
         60OKpZkQaLNNZTRBqmu4wnW9C3/9U0NAEkF7tHTvsIMUyn/0bTlPystapAo+bxNQr3dq
         DgPxa82Umc++P2cvhgm4UGGDKQC4dIYA6hqX/kxUwq5rRYvIl4PMES+sYyneFWyff9X8
         LQfkaAh0MH9d9ar3Jf40uSBFPg/oJwF5NjtOzO5a5tU0SX9ydM80Dzlu6F1I8TDyuiNt
         tZymf5c8683Zw+Ij2j4yvcaJ0XlPbWmgxK2B9wr3GBUvPBjUY1iQ76W5sOOYU07F0opE
         AV/Q==
X-Gm-Message-State: ANhLgQ0sQ2Gfz7nB+QwIPRaAHuwJSWsvB1qJZRZx5vuSantc+WdlCJjv
        /QAy6L8RJbS74Dq+FrsKiDU=
X-Google-Smtp-Source: ADFU+vvuj+zkNsesgGqN0406+nK8NifKsqSGoPO10NF/cdxTMtbfCnqcOqvd9jRI+BW9/e+uOjhSXw==
X-Received: by 2002:a25:6a56:: with SMTP id f83mr844067ybc.17.1583451495687;
        Thu, 05 Mar 2020 15:38:15 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f205sm10724400ywa.2.2020.03.05.15.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 15:38:15 -0800 (PST)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 025NcBvJ026831;
        Thu, 5 Mar 2020 23:38:12 GMT
Subject: [PATCH] NFSD: Fix NFS server build errors
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, kolga@netapp.com, yuehaibing@huawei.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 05 Mar 2020 18:38:11 -0500
Message-ID: <20200305233433.14530.61315.stgit@klimt.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

yuehaibing@huawei.com reports the following build errors arise when
CONFIG_NFSD_V4_2_INTER_SSC is set and the NFS client is not built
into the kernel:

fs/nfsd/nfs4proc.o: In function `nfsd4_do_copy':
nfs4proc.c:(.text+0x23b7): undefined reference to `nfs42_ssc_close'
fs/nfsd/nfs4proc.o: In function `nfsd4_copy':
nfs4proc.c:(.text+0x5d2a): undefined reference to `nfs_sb_deactive'
fs/nfsd/nfs4proc.o: In function `nfsd4_do_async_copy':
nfs4proc.c:(.text+0x61d5): undefined reference to `nfs42_ssc_open'
nfs4proc.c:(.text+0x6389): undefined reference to `nfs_sb_deactive'

The new inter-server copy code invokes client functions. Until the
NFS server has infrastructure to load the appropriate NFS client
modules to handle inter-server copy requests, let's constrain the
way this feature is built.

Reported-by: YueHaibing <yuehaibing@huawei.com>
Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Yue - does this work for you? The dependency is easier for me to
understand.

Bruce and Olga - OK with this temporary solution?

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index f368f3215f88..99d2cae91bd6 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -136,7 +136,7 @@ config NFSD_FLEXFILELAYOUT
 
 config NFSD_V4_2_INTER_SSC
 	bool "NFSv4.2 inter server to server COPY"
-	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2
+	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2 && NFS_FS=y
 	help
 	  This option enables support for NFSv4.2 inter server to
 	  server copy where the destination server calls the NFSv4.2

