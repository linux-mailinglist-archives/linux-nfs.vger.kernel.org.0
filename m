Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F652254E3
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 02:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgGTAOL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Jul 2020 20:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgGTAOL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Jul 2020 20:14:11 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE682C0619D2;
        Sun, 19 Jul 2020 17:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=x4M8LG5SMLzOfK/mq7r8NQX7zsIhCrAh63LsaH5uYLo=; b=Hs6tY3KX/4u+zqyhLUxNZAsYa6
        svMttdSot4kp/k64Obbby7OI/xlFtsqokbL3ifEPg1DUtPvaAHL5hlxs1Dqsxdkf3AOgGfvKgN+j+
        XsUn4ugTbuToAWwsmoavi+qtD9wNrUtP/PMmkAE+upC6U44pGx0XRs+vYGsNIAAgq1DPPBwXCdANh
        mr5rXuAYpe2zURfnt44uwUmJDWX+dem8mbwHdxEoGAwoILI79arLtCk4xDlWVm3uBSV++OM3dlT51
        kUaHGELItm0uL7UKWmyo6eIKFt/gBrZ9cKWR+f3R8/W0tw3QYjQVkDLbALtMDRFFEbAj8lQ7u1w7i
        Ha082gSw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxJRX-0003yx-78; Mon, 20 Jul 2020 00:14:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: netns.h: delete a duplicated word
Date:   Sun, 19 Jul 2020 17:14:03 -0700
Message-Id: <20200720001403.26974-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
---
 fs/nfsd/netns.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/fs/nfsd/netns.h
+++ linux-next-20200717/fs/nfsd/netns.h
@@ -171,7 +171,7 @@ struct nfsd_net {
 	unsigned int             longest_chain_cachesize;
 
 	struct shrinker		nfsd_reply_cache_shrinker;
-	/* utsname taken from the the process that starts the server */
+	/* utsname taken from the process that starts the server */
 	char			nfsd_name[UNX_MAXNODENAME+1];
 };
 
