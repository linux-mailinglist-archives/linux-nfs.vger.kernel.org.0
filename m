Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C43C5766E1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 20:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiGOSol (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 14:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiGOSok (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 14:44:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E930015719
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 11:44:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82FDE6233C
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 18:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC89C341C0;
        Fri, 15 Jul 2022 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657910678;
        bh=242WLO1LU1JqW0v/Oy8P+ERcqsN/jM8Wzy7wu5m9vbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pfjf3D5gVMRFfrgySNjrsO2iNDbJqXuwkELs2kdPdpHsOMmtkdtNlqSSpaCNgl8xE
         WCRE7x99UXbO745Izc7F2agVIEi2oPJGDCoMN/UkXuPAxWiHDUOrMvnTJwA6iB3E2J
         icuHnTuamb/LYEJq9Ki7vqdaZDWtvyCi1x3pvoZ/AGtZa14WN8Q7J5P4ivdoPP2Smk
         XpuTlIsy2livoA/3vrO6Euy96iUwON105s7yF1Nna/4ZCUyW1EXeNxwACISzFbBone
         /6uF1lK7gVA7d950wzExKuXIFC4QY67bRu5kkJx9+si6enRM6Wxdyds0RChW6lnDSl
         pwT3OVtJc9JSA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH v3 5/6] SUNRPC: Export xdr_buf_pagecount()
Date:   Fri, 15 Jul 2022 14:44:32 -0400
Message-Id: <20220715184433.838521-6-anna@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220715184433.838521-1-anna@kernel.org>
References: <20220715184433.838521-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

The NFS server will need this for iterating over pages in a READ_PLUS
reply

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xdr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 88b28656a05d..ea734b14af0f 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -139,6 +139,7 @@ size_t xdr_buf_pagecount(const struct xdr_buf *buf)
 		return 0;
 	return (buf->page_base + buf->page_len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 }
+EXPORT_SYMBOL_GPL(xdr_buf_pagecount);
 
 char *xdr_buf_nth_page_address(const struct xdr_buf *buf, unsigned int n,
 			       unsigned int *len)
-- 
2.37.1

