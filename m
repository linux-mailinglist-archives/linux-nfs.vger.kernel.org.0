Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB16A970E
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 13:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCCMQJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 07:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCCMQI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 07:16:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2115F52B
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 04:16:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48E1961803
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 12:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ACEC433A4;
        Fri,  3 Mar 2023 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845766;
        bh=lXNsnnyMZ8YivRXo4MeP5TdEPXqtm5tRkyYrmwwaNL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaqXkWU6y0t4KkhhD86nBgOJU3izyvk2TV6+8rZmUShQ6E3MZSphq+3gzCyVvd9xP
         J/KYbD0+8ipZyOJTUkZM66i1mBqd3TiyqDDlFMD8OyWQUq4DsWwFoHHkY5aa3Lj1e1
         1RNbL8xfCu+ihTbMs27Ka03mp38gyYKv71cScaZtj0Y9qD2Gekk8LDSfievLanY5ZR
         oASZS5EjhPt5+YB/Sc1G3QPelZCmSzfYuh+rsJTTJolnO8elYfoGvb67Ltu6v5SYUJ
         cvbkw4gtHAOg/sZ7K10rSFM0xzE/MLac89caZmw1MVCLWQHY61FwiDdQZEoNHTawgR
         hXlT17HO6lLNg==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, yoyang@redhat.com
Subject: [PATCH 2/7] lockd: remove 2 unused helper functions
Date:   Fri,  3 Mar 2023 07:15:58 -0500
Message-Id: <20230303121603.132103-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303121603.132103-1-jlayton@kernel.org>
References: <20230303121603.132103-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/lockd/lockd.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 0168ac9fdda8..26c2aed31a0c 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -99,21 +99,11 @@ struct nsm_handle {
 /*
  * Rigorous type checking on sockaddr type conversions
  */
-static inline struct sockaddr_in *nlm_addr_in(const struct nlm_host *host)
-{
-	return (struct sockaddr_in *)&host->h_addr;
-}
-
 static inline struct sockaddr *nlm_addr(const struct nlm_host *host)
 {
 	return (struct sockaddr *)&host->h_addr;
 }
 
-static inline struct sockaddr_in *nlm_srcaddr_in(const struct nlm_host *host)
-{
-	return (struct sockaddr_in *)&host->h_srcaddr;
-}
-
 static inline struct sockaddr *nlm_srcaddr(const struct nlm_host *host)
 {
 	return (struct sockaddr *)&host->h_srcaddr;
-- 
2.39.2

