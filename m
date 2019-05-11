Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9401A748
	for <lists+linux-nfs@lfdr.de>; Sat, 11 May 2019 11:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfEKJcg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 11 May 2019 05:32:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41875 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEKJcg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 11 May 2019 05:32:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id f12so1938249plt.8;
        Sat, 11 May 2019 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cjTU4+uCmuJ0Yl4gp0FKzJLeKrgb5vL6eBPDXpXp/sA=;
        b=isjLUCToOhKYz4fsEzEXiHviDVgUBwtR4ealGTQhSNkBISnGWNBD/U53iUBuPYU8Sl
         XJU+PZdLZw8iQEbxjiIY+IVqRn6YciuB2IoCoWEc39mOtH6bwLquQMMNJq62STuxAO3l
         UN366TgrQy8PNWqonJ8I2dOo9cvc4WwIbMtwORDRzodYNBbXfTBP6dbm88BE7A4ca+S3
         kjo698hHF44VZ7lEnwJaS5F6g8Df1K/apa2CXcBMxjXSOK0U6Ro6HZwShC+A19YJ/D3p
         rs/Ec7Um85PbYxfLXuqlHvp2L0xyuSTUNUKm5adQN7szjTNAbV1lTscNdWDwoap9SwzB
         eOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cjTU4+uCmuJ0Yl4gp0FKzJLeKrgb5vL6eBPDXpXp/sA=;
        b=NiVr3MWmwkPMJW6RvDQY5xRu1jLM7+7GtjcJjJtFNN5eyEl79+tJGE+tdQBpmP/yK2
         MjXqQC4PnAnoAsxKXE4EFnEvti3rsvoZPHW7ZxCANBTG3F/x5H+OJCrrYmdRjksPPyYM
         Rf6f5sPjz9rPGEe1nmpU1CeFSZaL8oRvWnbIqvdcf0G1VQqTuhblvZU4NTZt37loskL4
         Y7zUZ6kKAGCxHscjWzMcQrdkpjbQMqf+fawpwTaPfrQSnX5OKoDr/jfjRjzRbbHraX7D
         /ZB54T/qVPtR5V4iN+uT6siqi3H1w6cn2UfUD0SYvWwBGY7o9PesLPHqF/bPmNH6UMBn
         p6oA==
X-Gm-Message-State: APjAAAUk6ubtNnCZlUyihn/lruC5QkM7azdGZ/kZkHyhmN5AbA3uCDIh
        d8meB1LB7i53MzdDSp8OBvM=
X-Google-Smtp-Source: APXvYqxL3VR80XppbSKs4um3c/utB9FSipbRkfynylW9joT60R9D/V8K1s/KJLWNbBQuIc5XJsHVfg==
X-Received: by 2002:a17:902:2a07:: with SMTP id i7mr19428997plb.125.1557567155676;
        Sat, 11 May 2019 02:32:35 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id o73sm22880681pfi.137.2019.05.11.02.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 02:32:35 -0700 (PDT)
Date:   Sat, 11 May 2019 15:02:28 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfs/dns_resolve.c: Move redundant headers to the top 
Message-ID: <20190511093228.GA8757@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFS uses either the kernel's DNS service or its own depending on whether
CONFIG_NFS_USE_KERNEL_DNS is enabled or not.

4 header files which are:
(i) #include <linux/module.h>
(ii) #include <linux/sunrpc/clnt.h>
(iii) #include <linux/sunrpc/addr.h>
(iv) #include "dns_resolve.h"

These 4 header files are used regardless of whether
CONFIG_NFS_USE_KERNEL_DNS is enabled or not. But they have been included
under #ifdef CONFIG_NFS_USE_KERNEL_DNS and also the #else section(if
CONFIG_NFS_USE_KERNEL_DNS is not enabled).

Move these redundant headers to the top of the file i.e include them
before #ifdef CONFIG_NFS_USE_KERNEL_DNS.

Tested by compiling the kernel and also running
./scripts/checkincludes.pl on fs/nfs/dns_resolve.c

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 fs/nfs/dns_resolve.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/dns_resolve.c b/fs/nfs/dns_resolve.c
index a7d3df8..b34e575 100644
--- a/fs/nfs/dns_resolve.c
+++ b/fs/nfs/dns_resolve.c
@@ -7,14 +7,15 @@
  * Resolves DNS hostnames into valid ip addresses
  */
 
-#ifdef CONFIG_NFS_USE_KERNEL_DNS
-
 #include <linux/module.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/addr.h>
-#include <linux/dns_resolver.h>
 #include "dns_resolve.h"
 
+#ifdef CONFIG_NFS_USE_KERNEL_DNS
+
+#include <linux/dns_resolver.h>
+
 ssize_t nfs_dns_resolve_name(struct net *net, char *name, size_t namelen,
 		struct sockaddr *sa, size_t salen)
 {
@@ -33,24 +34,19 @@ ssize_t nfs_dns_resolve_name(struct net *net, char *name, size_t namelen,
 
 #else
 
-#include <linux/module.h>
 #include <linux/hash.h>
 #include <linux/string.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/socket.h>
 #include <linux/seq_file.h>
 #include <linux/inet.h>
-#include <linux/sunrpc/clnt.h>
-#include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/cache.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/nfs_fs.h>
 
 #include "nfs4_fs.h"
-#include "dns_resolve.h"
 #include "cache_lib.h"
 #include "netns.h"
 
-- 
2.7.4

