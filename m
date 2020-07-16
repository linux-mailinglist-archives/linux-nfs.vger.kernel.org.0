Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E3B221986
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jul 2020 03:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGPBbo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 21:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgGPBbo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 21:31:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB08C061755;
        Wed, 15 Jul 2020 18:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zDto2dguB1r5kca2xIH2GzdAwSan1+3DwNl3tVgA/Ks=; b=Nealkybv6uiGWaTvKKZ8bC+HcO
        yOy332uKDrdW6DATNZ/CmQHWEWd21r6puf1JIzgV0giMkFyxXGXKozVfdQpwSwKgDBRvtMSqDb4jC
        jR7uL7ngY1HAznyUmRAjGJVWbBqEDbhRYF8bDCxFlxhOI7boyvLuaJYkxyOqs7NDdx3y8e0bwa0vz
        f6Wd50qJSQjN+cxd7OEHnqDCHw1BM3C0FltUhM8I88b0e94KnxMdS4k0nLrnsyrYsSgkO2STP1RdQ
        eJkB6m5KSRX7br2aj3jfwAijTy/Tov4xw/7AnA3FoFH55LGWU3EH0hJXU81sR37tnipeD2dD0tRJP
        nvdwxWVw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvskI-0000cE-HI; Thu, 16 Jul 2020 01:31:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sunrpc: fix duplicated word in <linux/sunrpc/cache.h>
To:     LKML <linux-kernel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Message-ID: <94cab2ce-65bb-f65c-e28a-c7aa5d4a13bb@infradead.org>
Date:   Wed, 15 Jul 2020 18:31:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Change "time time" to "time expiry_time" to match the field name.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org
---
 include/linux/sunrpc/cache.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/sunrpc/cache.h
+++ linux-next-20200714/include/linux/sunrpc/cache.h
@@ -45,7 +45,8 @@
  */
 struct cache_head {
 	struct hlist_node	cache_list;
-	time64_t	expiry_time;	/* After time time, don't use the data */
+	time64_t	expiry_time;	/* After time expiry_time, don't use
+					 * the data */
 	time64_t	last_refresh;   /* If CACHE_PENDING, this is when upcall was
 					 * sent, else this is when update was
 					 * received, though it is alway set to


