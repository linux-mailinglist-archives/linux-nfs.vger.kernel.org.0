Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C5964B919
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiLMQBL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 11:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiLMQBL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 11:01:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5C7F27
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 08:01:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10084B81247
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 16:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45000C433EF;
        Tue, 13 Dec 2022 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670947266;
        bh=Ey3pwmerBWpPFTqOSp7nxEmjBKBkKaoQMy+X5VaQifE=;
        h=From:To:Cc:Subject:Date:From;
        b=lxg0l04zMChevWDvgMs+0n9BMVT5lDb6UrTqrqHTbAuv+5ko1ZpOU50EJAMSN7r0f
         Hb19OsvJAMB/4qkE6BBM64K3n/wizPFzOR1fD1/xznenitCc3BmCkLrBluavrvX920
         ufwWpo0jcN4JzSacct3H5yFb98OHyGQVmp0fn5LU0KKB1BtbBDKTTJUDT0DOsy7zLd
         KoYJ/knb3PvlnrqXGKIiik68ilMt5nRd/VCooVkNR7WXtGTpgOmxMFxS/Moj7zPqSA
         r8I5VUni7fYFZXGxGAPMMqu6hyaHhb9ii5BuScwkmuLw7cQG/2ZFShx86xr+bp8ado
         HOk0/0LgG6QXg==
From:   Jeff Layton <jlayton@kernel.org>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        JianHong Yin <jiyin@redhat.com>
Subject: [nfs-utils PATCH] Don't allow junction tests to trigger automounts
Date:   Tue, 13 Dec 2022 11:01:04 -0500
Message-Id: <20221213160104.198237-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

JianHong reported some strange behavior with automounts on an nfs server
without an explicit pseudoroot. When clients issued a readdir in the
pseudoroot, automounted directories that were not yet mounted would show
up even if they weren't exported, though the clients wouldn't be able to
do anything with them.

The issue was that triggering the automount on a directory would cause
the mountd upcall to time out, which would cause nfsd to include the
automounted dentry in the readdir response. Eventually, the automount
would work and report that it wasn't exported and subsequent attempts to
access the dentry would (properly) fail.

We never want mountd to trigger an automount. The kernel should do that
if it wants to use it. Change the junction checks to do an O_PATH open
and use fstatat with AT_NO_AUTOMOUNT.

Cc: Chuck Lever <chuck.lever@oracle.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2148353
Reported-by: JianHong Yin <jiyin@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/junction/junction.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/support/junction/junction.c b/support/junction/junction.c
index 41cce261cb52..0628bb0ffffb 100644
--- a/support/junction/junction.c
+++ b/support/junction/junction.c
@@ -63,7 +63,7 @@ junction_open_path(const char *pathname, int *fd)
 	if (pathname == NULL || fd == NULL)
 		return FEDFS_ERR_INVAL;
 
-	tmp = open(pathname, O_DIRECTORY);
+	tmp = open(pathname, O_PATH|O_DIRECTORY);
 	if (tmp == -1) {
 		switch (errno) {
 		case EPERM:
@@ -93,7 +93,7 @@ junction_is_directory(int fd, const char *path)
 {
 	struct stat stb;
 
-	if (fstat(fd, &stb) == -1) {
+	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) == -1) {
 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
 				__func__, path);
 		return FEDFS_ERR_ACCESS;
@@ -121,7 +121,7 @@ junction_is_sticky_bit_set(int fd, const char *path)
 {
 	struct stat stb;
 
-	if (fstat(fd, &stb) == -1) {
+	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) == -1) {
 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
 				__func__, path);
 		return FEDFS_ERR_ACCESS;
@@ -155,7 +155,7 @@ junction_set_sticky_bit(int fd, const char *path)
 {
 	struct stat stb;
 
-	if (fstat(fd, &stb) == -1) {
+	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) == -1) {
 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
 			__func__, path);
 		return FEDFS_ERR_ACCESS;
@@ -393,7 +393,7 @@ junction_get_mode(const char *pathname, mode_t *mode)
 	if (retval != FEDFS_OK)
 		return retval;
 
-	if (fstat(fd, &stb) == -1) {
+	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) == -1) {
 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
 			__func__, pathname);
 		(void)close(fd);
-- 
2.38.1

