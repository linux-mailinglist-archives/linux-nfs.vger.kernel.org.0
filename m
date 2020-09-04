Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0374A25E364
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 23:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgIDVjR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 17:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgIDVjQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 17:39:16 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7096C061244
        for <linux-nfs@vger.kernel.org>; Fri,  4 Sep 2020 14:39:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 60so5827857qtc.9
        for <linux-nfs@vger.kernel.org>; Fri, 04 Sep 2020 14:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2LI8ZS6thsnmwtkE94coF3xSF8n1VrowAa+YD7V2zn0=;
        b=nBVnYxfNYQSWux6R89VF0B21WHV4S3e93+xpW2SjiqpNMKBdKvZscLu6Boyz1/iaeA
         BO8XeuUmdxFUfW9t+2g0/g10L7yJl/X/dFwNumnfdKL8tP8BNvsJExeX/glbXyCR6pAe
         Lx7QWYVmATTGQfkjRZyZQXI88bXCv487cQMG+/KU0C6BFyXd+T5OEiamCnvYgDQx27Yq
         tLuqc+ojugPPoB/LE7/RkGVlrgsqg9b3yQ85W6DOJL3DJ0Ps3sLxOmTiRsMbvCjvUgfd
         bJOrBkq16ODkhG8cqXd0ge7RPGCXJ7uPn5znl28zgtelnXAHjv9JxbhPlW2AeNCMFoCz
         jvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2LI8ZS6thsnmwtkE94coF3xSF8n1VrowAa+YD7V2zn0=;
        b=VL1UEjIhnGk7oELH7UIUnIDpZlXhCPQPzIbSfNaZvJPYy+pxJcLJLwvVNzhRNPiEK0
         JjcPaZ+BkWpdEeP9N5Xa2omXKwEuc3oia1kM8Y6ERH5STYdPnrk0k/rIs13fo1aUuDNP
         EqRxXBNF8IPYgybsdWK2b7ms7FAlIq1ZYNX5q9RMFBksMO5aRhe2B9K9NojsY8Qpp+cY
         6Ujh68XV7Vs9Gig/m04T2wTDImdLdjO76Oljyo5ZgwbGhFKfxCwdm7MWMsYeTN6TJII9
         rMoiL6DswELT4kw4mO1X9dzn5SLG04zD4ofnNCo7x9viuBZVe4wrqT6ucvw0SteK3Vsd
         qm+A==
X-Gm-Message-State: AOAM533zp7TRKkZ6K/2WA6Q/lADX0YTxfQbk0FHtvuv8nZYfBczIcD/P
        GbSRgt+Oa7qGXtP2YSnFUMyLQXyd1iA=
X-Google-Smtp-Source: ABdhPJz6sLY8yz1KCleEzlW9q70ww/qaFmsLdcgVstHcYmYy4jyao2uXhUPJhNE/pFgCTZXouTTKiQ==
X-Received: by 2002:ac8:44b5:: with SMTP id a21mr10303557qto.314.1599255555127;
        Fri, 04 Sep 2020 14:39:15 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 16sm5475901qks.102.2020.09.04.14.39.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 14:39:14 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 084LdCAf013974;
        Fri, 4 Sep 2020 21:39:12 GMT
Subject: [PATCH v3] NFS: Zero-stateid SETATTR should first return delegation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 04 Sep 2020 17:39:12 -0400
Message-ID: <159925549303.442575.12094515313356787546.stgit@manet.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a write delegation isn't available, the Linux NFS client uses
a zero-stateid when performing a SETATTR.

NFSv4.0 provides no mechanism for an NFS server to match such a
request to a particular client. It recalls all delegations for that
file, even delegations held by the client issuing the request. If
that client happens to hold a read delegation, the server will
recall it immediately, resulting in an NFS4ERR_DELAY/CB_RECALL/
DELEGRETURN sequence.

Optimize out this pipeline bubble by having the client return any
delegations it may hold on a file before it issues a
SETATTR(zero-stateid) on that file.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4proc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Changes since v2:
- Return the delegation only for NFSv4.0 non-truncate cases

Changes since v1:
- Return the delegation only for NFSv4.0 mounts

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index f8946b9468ef..099ae32981a2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3293,8 +3293,10 @@ static int _nfs4_do_setattr(struct inode *inode,
 
 	/* Servers should only apply open mode checks for file size changes */
 	truncate = (arg->iap->ia_valid & ATTR_SIZE) ? true : false;
-	if (!truncate)
+	if (!truncate) {
+		nfs4_inode_make_writeable(inode);
 		goto zero_stateid;
+	}
 
 	if (nfs4_copy_delegation_stateid(inode, FMODE_WRITE, &arg->stateid, &delegation_cred)) {
 		/* Use that stateid */


