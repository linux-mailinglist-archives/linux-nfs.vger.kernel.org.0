Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE42414DE
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Aug 2020 04:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHKCSn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Aug 2020 22:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHKCSn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Aug 2020 22:18:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E08FC06174A;
        Mon, 10 Aug 2020 19:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=FDgWfRdb7sBPKRkD1CaN3MgEIO4tPkEjDVHYa1wkGMM=; b=RcR2sqZEQyUvV/LQhBmIXE8Bq1
        njBwGb+/Zowore43lmKN9TXwJKeWvotOMH70cQKwwzzHFkoWU0rocSdJVcvDtiaqGHaVyzoy6Hdfi
        r9dI7POHPQnfSZ3rPaNlOYUg/ieX+iHBA1Dv9XCj9s2fDMVRszki4p9FBnyjCWQ6Pst4mzDH/5INh
        zktwiRX98BD5DaWpaU1zPlVC4/3hJNLEHf4BVmx6d1L8QVdBeSDfccTtPJszX3g9z7oiyaFp+JkK6
        /Xb7/teKY0tNuTh1J8nqOXn2WIbPwH66lNYJHRWM4MWg0aIX4QtFc1+SQj4piVsUKumakqjzTphe9
        vOxbt5sw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Js6-0006pr-DE; Tue, 11 Aug 2020 02:18:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH] fs: nfs: delete repeated words in comments
Date:   Mon, 10 Aug 2020 19:18:35 -0700
Message-Id: <20200811021835.25084-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Drop duplicated words {the, and} in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org
---
 fs/nfs/fs_context.c |    2 +-
 fs/nfs/nfs4xdr.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200807.orig/fs/nfs/fs_context.c
+++ linux-next-20200807/fs/nfs/fs_context.c
@@ -982,7 +982,7 @@ static int nfs23_parse_monolithic(struct
 		/*
 		 * The legacy version 6 binary mount data from userspace has a
 		 * field used only to transport selinux information into the
-		 * the kernel.  To continue to support that functionality we
+		 * kernel.  To continue to support that functionality we
 		 * have a touch of selinux knowledge here in the NFS code. The
 		 * userspace code converted context=blah to just blah so we are
 		 * converting back to the full string selinux understands.
--- linux-next-20200807.orig/fs/nfs/nfs4xdr.c
+++ linux-next-20200807/fs/nfs/nfs4xdr.c
@@ -5252,7 +5252,7 @@ static int decode_readlink(struct xdr_st
 	 * The XDR encode routine has set things up so that
 	 * the link text will be copied directly into the
 	 * buffer.  We just have to do overflow-checking,
-	 * and and null-terminate the text (the VFS expects
+	 * and null-terminate the text (the VFS expects
 	 * null-termination).
 	 */
 	xdr_terminate_string(rcvbuf, len);
