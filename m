Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1AB6B0C22
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 16:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCHPG0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 10:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCHPGK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 10:06:10 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6463BA874
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 07:06:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 771BE6081100;
        Wed,  8 Mar 2023 16:06:00 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LA_Cgx6NjAPV; Wed,  8 Mar 2023 16:06:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2CB7D6418F4F;
        Wed,  8 Mar 2023 16:06:00 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CqnZoB0OBev0; Wed,  8 Mar 2023 16:06:00 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 10CFC6418F2B;
        Wed,  8 Mar 2023 16:06:00 +0100 (CET)
Date:   Wed, 8 Mar 2023 16:05:59 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Cc:     trond.myklebust@hammerspace.com,
        chris chilvers <chris.chilvers@appsbroker.com>
Message-ID: <1497292229.221220.1678287959937.JavaMail.zimbra@nod.at>
Subject: mountd: Possible bug in next_mnt()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: 9BMFbQ13uvU7jVXUa76Mw87Q1yrJGg==
Thread-Topic: mountd: Possible bug in next_mnt()
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!

next_mnt() finds submounts below a given path p.
While investigating into an issue in my crossmount patches for nfs-utils I noticed
that it does not work when fsid=root, rootdir=/some/path/ and then "/" is being exported.
In this case next_mnt() is asked to find submounts of "/" but returns none.

In my opinion this wrong because every mount is a submount of "/".

The following change fixes the problem on my side but I'm not sure whether
"/" is a special case in mountd where next_mnt() has to bail out.

diff --git a/support/export/cache.c b/support/export/cache.c
index 2497d4f48df3..be20cb34adcb 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -410,13 +410,13 @@ static char *next_mnt(void **v, char *p)
                *v = f;
        } else
                f = *v;
-       while ((me = getmntent(f)) != NULL && l > 1) {
+       while ((me = getmntent(f)) != NULL && l >= 1) {
                char *mnt_dir = nfsd_path_strip_root(me->mnt_dir);
 
                if (!mnt_dir)
                        continue;
 
-               if (strncmp(mnt_dir, p, l) == 0 && mnt_dir[l] == '/')
+               if (strncmp(mnt_dir, p, l) == 0 && (l == 1 || mnt_dir[l] == '/'))
                        return mnt_dir;
        }
        endmntent(f);

Comments? :-)

Thanks,
//richard
