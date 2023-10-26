Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866CF7D88E5
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Oct 2023 21:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjJZT2i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 15:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZT2h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 15:28:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23C12A;
        Thu, 26 Oct 2023 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ToUeE8jlH67uNaR3XjokfMyr/EVi5kLp33HH0pq5Mw8=; b=iqcIoqmmABN4vQb9TcuI7xO06L
        +9xFV3rGU763GNNot3CgGUyn+WkmnlNbr8mbozea7ydt8jdiXQZ0m+tYOky12mTbafLqqsjlHEzoF
        BnwOn8xyLYr5TM8zvHVJynk3A3Hz7uVKEwC8RZ1Qted1xgFfh60qyd6BlIO2TLZBNptCCKDlLzTIV
        Mh7GknNMLRGBx63gZKP0GlpFbeqLLx6ItYgSMSeDPuXPFnGnrLmcjv+DPnTYL9jWp41KLhDX6gwIn
        +SHh/XfQTlejFP/Fwt8I8WT602eJMks6DMO+Wx0Y+kiPRge6nYQFeIfj66G15thQ3kdI75NWJAwiA
        9oQfp6KQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qw61v-00F3QG-00;
        Thu, 26 Oct 2023 19:28:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] exportfs: handle CONFIG_EXPORTFS=m also
Date:   Thu, 26 Oct 2023 12:28:30 -0700
Message-ID: <20231026192830.21288-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When CONFIG_EXPORTFS=m, there are multiple build errors due to
the header <linux/exportfs.h> not handling the =m setting correctly.
Change the header file to check for CONFIG_EXPORTFS enabled at all
instead of just set =y.

Fixes: dfaf653dc415 ("exportfs: make ->encode_fh() a mandatory method for NFS export")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org

---
 include/linux/exportfs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/linux/exportfs.h b/include/linux/exportfs.h
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -314,7 +314,7 @@ extern struct dentry *exportfs_decode_fh
 /*
  * Generic helpers for filesystems.
  */
-#ifdef CONFIG_EXPORTFS
+#if IS_ENABLED(CONFIG_EXPORTFS)
 int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
 			    struct inode *parent);
 #else
