Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0A6033A7
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 21:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJRT6x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 15:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJRT6t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 15:58:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E09AC29
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 12:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDBB5B82106
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 19:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81616C4314C;
        Tue, 18 Oct 2022 19:58:45 +0000 (UTC)
Subject: [PATCH v4 4/7] NFSD: Use const pointers as parameters to fh_ helpers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Tue, 18 Oct 2022 15:58:44 -0400
Message-ID: <166612312451.1291.10615396222464284428.stgit@manet.1015granger.net>
In-Reply-To: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enable callers to use const pointers where they are able to.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index c3ae6414fc5c..513e028b0bbe 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -220,7 +220,7 @@ __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
 
 static __inline__ struct svc_fh *
-fh_copy(struct svc_fh *dst, struct svc_fh *src)
+fh_copy(struct svc_fh *dst, const struct svc_fh *src)
 {
 	WARN_ON(src->fh_dentry);
 
@@ -229,7 +229,7 @@ fh_copy(struct svc_fh *dst, struct svc_fh *src)
 }
 
 static inline void
-fh_copy_shallow(struct knfsd_fh *dst, struct knfsd_fh *src)
+fh_copy_shallow(struct knfsd_fh *dst, const struct knfsd_fh *src)
 {
 	dst->fh_size = src->fh_size;
 	memcpy(&dst->fh_raw, &src->fh_raw, src->fh_size);
@@ -243,7 +243,8 @@ fh_init(struct svc_fh *fhp, int maxsize)
 	return fhp;
 }
 
-static inline bool fh_match(struct knfsd_fh *fh1, struct knfsd_fh *fh2)
+static inline bool fh_match(const struct knfsd_fh *fh1,
+			    const struct knfsd_fh *fh2)
 {
 	if (fh1->fh_size != fh2->fh_size)
 		return false;
@@ -252,7 +253,8 @@ static inline bool fh_match(struct knfsd_fh *fh1, struct knfsd_fh *fh2)
 	return true;
 }
 
-static inline bool fh_fsid_match(struct knfsd_fh *fh1, struct knfsd_fh *fh2)
+static inline bool fh_fsid_match(const struct knfsd_fh *fh1,
+				 const struct knfsd_fh *fh2)
 {
 	if (fh1->fh_fsid_type != fh2->fh_fsid_type)
 		return false;


