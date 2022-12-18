Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4418650437
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Dec 2022 18:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiLRRho (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Dec 2022 12:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiLRRhU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Dec 2022 12:37:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4307F202
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 08:41:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 597ACB80BAB
        for <linux-nfs@vger.kernel.org>; Sun, 18 Dec 2022 16:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4FFC433EF;
        Sun, 18 Dec 2022 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671381703;
        bh=Yty2yghX/PY19eOtJid0OflOIGns1EAuLZN7D08hrrM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r0QCOE8xiJrFeM6pqZz9Jk04IsiAvMm0UFcNW52mQSvixxNwh+EFmav0b2k+PqO+q
         X4jUQaa2f7sCDyk1KYnXsIif76UkQufftiYcfX3pAM7V3rCz2VOxAPMtnaGu2rtvYn
         NV1RzVKbjLL7VpLqQwWhyuDJ+ReFcHAIy/5ufADZqgsVPdGL7XFLEXqEOa2ul22NFr
         DrRPNFJUwryL3ObWWx7U2c7eVlUzbuZAjui8XHvLX/cph0QJbewK3pucPyjbz/VOeW
         nUPqwd661Y35C5iF5CWYfCrsMVGUtd7ShkzoppN5qjpR4DGmrLNNnYkLMzW839/6O4
         sXI5zZPtMSQRA==
Subject: [PATCH 3/6] nfsd(7): Clarify description of
From:   cel@kernel.org
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org, debian@helgefjell.de
Date:   Sun, 18 Dec 2022 11:41:41 -0500
Message-ID: <167138170181.1584402.14449106893754326594.stgit@morisot.1015granger.net>
In-Reply-To: <167138168903.1584402.12231405451604036910.stgit@morisot.1015granger.net>
References: <167138168903.1584402.12231405451604036910.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Man page: nfsd.7
Issue:    The first sentence is somewhat logical, but is this really the speciality of this file?

"This is a somewhat unusual file in that what is read from it depends on what "
"was just written to it.  It provides a transactional interface where a "
"program can open the file, write a request, and read a response.  If two "
"separate programs open, write, and read at the same time, their requests "
"will not be mixed up."

Reported-by: Helge Kreutzmann <debian@helgefjell.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 utils/exportfs/nfsd.man |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/utils/exportfs/nfsd.man b/utils/exportfs/nfsd.man
index 6992e10829e7..e1f3f65fb297 100644
--- a/utils/exportfs/nfsd.man
+++ b/utils/exportfs/nfsd.man
@@ -64,23 +64,17 @@ that number.
 
 .TP
 .B filehandle
-This is a somewhat unusual file  in that what is read from it depends
-on what was just written to it.  It provides a transactional interface
-where a program can open the file, write a request, and read a
-response.  If two separate programs open, write, and read at the same
-time, their requests will not be mixed up.
+This file provides a transactional interface where a program can
+read back a filehandle for a path as exported to a given client.
 
-The request written to
-.B filehandle
-should be a client name, a path name, and a number of bytes.  This
-should be followed by a newline, with white-space separating the
-fields, and octal quoting of special characters.
-
-On writing this, the program will be able to read back a filehandle
-for that path as exported to the given client.  The filehandle's length
-will be at most the number of bytes given.
+Each written request to
+.I filehandle
+should be a client name, a path name, and a number of bytes.
+This should be followed by a newline, with white-space separating
+the fields and octal quoting of special characters.
 
-The filehandle will be represented in hex with a leading '\ex'.
+The returned filehandle is represented in hex with a leading '\ex'.
+The filehandle's length will be at most the number of bytes given.
 
 .TP
 .B clients/


