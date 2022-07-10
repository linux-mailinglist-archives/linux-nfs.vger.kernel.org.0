Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7812F56D0D7
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Jul 2022 20:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiGJSqK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 10 Jul 2022 14:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGJSqJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 10 Jul 2022 14:46:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EEDBC3E;
        Sun, 10 Jul 2022 11:46:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34204B80CB7;
        Sun, 10 Jul 2022 18:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5472C3411E;
        Sun, 10 Jul 2022 18:46:05 +0000 (UTC)
Subject: [PATCH v1] NFSD: Decode NFSv4 birth time attribute
From:   Chuck Lever <chuck.lever@oracle.com>
To:     imammedo@redhat.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 10 Jul 2022 14:46:04 -0400
Message-ID: <165747876458.1259.8334435718280903102.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFSD has advertised support for the NFSv4 time_create attribute
since commit e377a3e698fb ("nfsd: Add support for the birth time
attribute").

Igor Mammedov reports that Mac OS clients attempt to set the NFSv4
birth time attribute via OPEN(CREATE) and SETATTR if the server
indicates that it supports it, but since the above commit was
merged, those attempts now fail.

Table 5 in RFC 8881 lists the time_create attribute as one that can
be both set and retrieved, but the above commit did not add server
support for clients to provide a time_create attribute. IMO that's
a bug in our implementation of the NFSv4 protocol, which this commit
addresses.

Whether NFSD silently ignores the new birth time or actually sets it
is another matter. I haven't found another filesystem service in the
Linux kernel that enables users or clients to modify a file's birth
time attribute.

This commit reflects my (perhaps incorrect) understanding of whether
Linux users can set a file's birth time. NFSD will now recognize a
time_create attribute but it ignores its value. It clears the
time_create bit in the returned attribute bitmask to indicate that
the value was not used.

Reported-by: Igor Mammedov <imammedo@redhat.com>
Fixes: e377a3e698fb ("nfsd: Add support for the birth time attribute")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    9 +++++++++
 fs/nfsd/nfsd.h    |    3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 61b2aae81abb..2acea7792bb2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -470,6 +470,15 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 			return nfserr_bad_xdr;
 		}
 	}
+	if (bmval[1] & FATTR4_WORD1_TIME_CREATE) {
+		struct timespec64 ts;
+
+		/* No Linux filesystem supports setting this attribute. */
+		bmval[1] &= ~FATTR4_WORD1_TIME_CREATE;
+		status = nfsd4_decode_nfstime4(argp, &ts);
+		if (status)
+			return status;
+	}
 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
 		u32 set_it;
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 847b482155ae..9a8b09afc173 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -465,7 +465,8 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 	(FATTR4_WORD0_SIZE | FATTR4_WORD0_ACL)
 #define NFSD_WRITEABLE_ATTRS_WORD1 \
 	(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP \
-	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_MODIFY_SET)
+	| FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_CREATE \
+	| FATTR4_WORD1_TIME_MODIFY_SET)
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 #define MAYBE_FATTR4_WORD2_SECURITY_LABEL \
 	FATTR4_WORD2_SECURITY_LABEL


