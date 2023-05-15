Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16D3702E36
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjEONfm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241728AbjEONfl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:35:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C1E69
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB4E861712
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D2DC433D2;
        Mon, 15 May 2023 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684157739;
        bh=DnsMeWvdSaBVKvmpnUV7cBhE98A78xWeNyOIopdDGS0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iyBwKOKIujeV0T/j5gc4wCmkE74X7jmDsL/gfw+k+z4S9JRKYSwgm32as0kCIolu6
         gGNRjIrhzNsgrAih/MDXzUoVdSAUYxS6/UlPC08fTzRF0Iuj0dEi7HHozfafVJf4XH
         G5x6HHBvABfhrMoh/djbMry1fS/gTGBm1sLkZW+nS6yfpwLZtN0YDkxAiP+QbHWJ2a
         klu26LTM/eebSWjHRecyd/Y7xpFcMXn4Yw4WQWu2dVrHasOIG0id5cxirv50q1oVJw
         fpOLGBxcjkbNi6OcCIYSyEny1s+gHlTcWZwjzINNb+rc/mR4aRLhOoAR3X6ttgG4yt
         SNI4JGwMti6JA==
Subject: [PATCH 1/3] NFSD: Clean up nfsctl white-space damage
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 15 May 2023 09:35:38 -0400
Message-ID: <168415773803.9589.477208057932221355.stgit@manet.1015granger.net>
In-Reply-To: <168415762168.9589.16821927887100606727.stgit@manet.1015granger.net>
References: <168415762168.9589.16821927887100606727.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7b8f17ee5224..a9bbe6806276 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -336,7 +336,7 @@ static ssize_t write_filehandle(struct file *file, char *buf, size_t size)
 	len = qword_get(&mesg, dname, size);
 	if (len <= 0)
 		return -EINVAL;
-	
+
 	path = dname+len+1;
 	len = qword_get(&mesg, path, size);
 	if (len <= 0)
@@ -350,7 +350,7 @@ static ssize_t write_filehandle(struct file *file, char *buf, size_t size)
 		return -EINVAL;
 	maxsize = min(maxsize, NFS3_FHSIZE);
 
-	if (qword_get(&mesg, mesg, size)>0)
+	if (qword_get(&mesg, mesg, size) > 0)
 		return -EINVAL;
 
 	/* we have all the words, they are in buf.. */
@@ -358,7 +358,7 @@ static ssize_t write_filehandle(struct file *file, char *buf, size_t size)
 	if (!dom)
 		return -ENOMEM;
 
-	len = exp_rootfh(netns(file), dom, path, &fh,  maxsize);
+	len = exp_rootfh(netns(file), dom, path, &fh, maxsize);
 	auth_domain_put(dom);
 	if (len)
 		return len;
@@ -430,8 +430,8 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
  * OR
  *
  * Input:
- * 			buf:		C string containing whitespace-
- * 					separated unsigned integer values
+ *			buf:		C string containing whitespace-
+ *					separated unsigned integer values
  *					representing the number of NFSD
  *					threads to start in each pool
  *			size:		non-zero length of C string in @buf
@@ -538,7 +538,7 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
 	char *sep;
 	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 
-	if (size>0) {
+	if (size > 0) {
 		if (nn->nfsd_serv)
 			/* Cannot change versions without updating
 			 * nn->nfsd_serv->sv_xdrsize, and reallocing
@@ -649,11 +649,11 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
  * OR
  *
  * Input:
- * 			buf:		C string containing whitespace-
- * 					separated positive or negative
- * 					integer values representing NFS
- * 					protocol versions to enable ("+n")
- * 					or disable ("-n")
+ *			buf:		C string containing whitespace-
+ *					separated positive or negative
+ *					integer values representing NFS
+ *					protocol versions to enable ("+n")
+ *					or disable ("-n")
  *			size:		non-zero length of C string in @buf
  * Output:
  *	On success:	status of zero or more protocol versions has
@@ -722,7 +722,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 }
 
 /*
- * A transport listener is added by writing it's transport name and
+ * A transport listener is added by writing its transport name and
  * a port number.
  */
 static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cred *cred)
@@ -849,9 +849,9 @@ int nfsd_max_blksize;
  * OR
  *
  * Input:
- * 			buf:		C string containing an unsigned
- * 					integer value representing the new
- * 					NFS blksize
+ *			buf:		C string containing an unsigned
+ *					integer value representing the new
+ *					NFS blksize
  *			size:		non-zero length of C string in @buf
  * Output:
  *	On success:	passed-in buffer filled with '\n'-terminated C string
@@ -898,9 +898,9 @@ static ssize_t write_maxblksize(struct file *file, char *buf, size_t size)
  * OR
  *
  * Input:
- * 			buf:		C string containing an unsigned
- * 					integer value representing the new
- * 					number of max connections
+ *			buf:		C string containing an unsigned
+ *					integer value representing the new
+ *					number of max connections
  *			size:		non-zero length of C string in @buf
  * Output:
  *	On success:	passed-in buffer filled with '\n'-terminated C string
@@ -1082,7 +1082,7 @@ static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
  * OR
  *
  * Input:
- * 			buf:		any value
+ *			buf:		any value
  *			size:		non-zero length of C string in @buf
  * Output:
  *			passed-in buffer filled with "Y" or "N" with a newline


