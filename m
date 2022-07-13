Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC4573CEF
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 21:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbiGMTIi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 15:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiGMTIf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 15:08:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3290FB5B
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 12:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0FBAB82120
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 19:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3965FC3411E;
        Wed, 13 Jul 2022 19:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739310;
        bh=6+eHd8H9jHMNlhID7997tVEizQaw08h5kwQLixpxpYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzIsME98G7Xb4it3DslA3TOrsfuSWSJTglaKFFXsoBvDvodtH0Y0yD9kxcFlzVhV9
         2K76KWS+nAw8kI0kkeEA2DpqEYQFjn5Ia39LprinHswzySeS7AURLzJFiBe3hmHIAJ
         5Vqbgq0KJ4RzJXAZP9qIYhMwijo7Uy1EUjP2UmvLdNvYBqyHp3WKudw7d2hYH2c6Nt
         WBYX7l4mDw/snPSMa4DXWtJ+ntQY04hltXGGNhYI5g9EtvVj4cge61PD7gl+yZsoYI
         gfo2Pr4QTrTZq6Ww+BbcrOFotDVgZhq4VQ6cPCqxOSfbvnYilcSKKZnTUcgGL0tSjb
         l+PKz/ZNAWB9g==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH v2 5/6] SUNRPC: Export xdr_buf_pagecount()
Date:   Wed, 13 Jul 2022 15:08:24 -0400
Message-Id: <20220713190825.615678-6-anna@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713190825.615678-1-anna@kernel.org>
References: <20220713190825.615678-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.37.0

