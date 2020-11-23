Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9022C15EA
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbgKWUJe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731389AbgKWUJd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:09:33 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA7C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:33 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id e10so6898245qte.4
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=U87VMX6PWpNDIh5Rr5x8DdmKsUeOe3Wv2RQH43fVpmo=;
        b=gOZbPCiCb81ZJF6O5YbmLbgTaiHpQkzeFnLxZklG/bDbaVcuWbfaFn089LW7iRyyhh
         EHhzEHl5h2QOTIw41LeH8azqvBliVizaCmzQJCW3b/VnHn3xJmzNfKuK6sfR7Xba2plq
         VfghwhpMAOQHTyanFgLm+FsXSrOTmqjsZCc8DoNEXM7dT2jGI43nPD57s6fwyPuJirDX
         ymB3NyWdWCqCupZ+OzDqI1RAkXYehSshBhITiP/JXTOgUEdeIxQqyhC4MNh2kAc6iZ8s
         lksCkkEy+Kgo3Nl5e5r5V8Q/gfuc1XxkX26GpQ9n9WaSPI0s1oLrpPDiZ0H8JTtlKV8m
         9MkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=U87VMX6PWpNDIh5Rr5x8DdmKsUeOe3Wv2RQH43fVpmo=;
        b=Tu9RmNUl/VgtoXkHt3bm9OrKGMpr6oNinHm4YgRZqZe7gJQB5fXD5dVcstqc2VJ+uq
         bFNWlW6oMzrKN0N31+4tIJEHOLZVQrl3IhZ1jNs9bG+p8OyQKrK3uEhA76t21MDGLvWw
         8xhqhw6wWfnI3ZKckEcKRne/+JW6PN1+WSeRilTqXBxqMDVktSHyeJQY+G75O0puHpfz
         MrSHL4yIyCobVKvrVEEvmbKn2aZYEDTUdVHxllhEYN2hB7nD9fd/nDRNyE+Y6xBPg6Zg
         /tCVd2z2RePlfnRAleJ91pBYA7V0Pts2ekh9+Hlegc+odj7o3gR010dh1BhLyljvR42k
         Id4g==
X-Gm-Message-State: AOAM5324RQOvqBP3HxzfJv8LZGZGDJlR1qX0oRufIq5rdURFbfP+PPY5
        0PMtgdUVbQ0VZerT7nlHsivrTXO5+Lg=
X-Google-Smtp-Source: ABdhPJzm9dTE6qQYFmOfhmt/WWREMPGZ2Szd/cpz51xYs2xG/nkw5GVoxndN+F2dvhHN2IvnGIZTSQ==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr939434qtv.56.1606162172383;
        Mon, 23 Nov 2020 12:09:32 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r14sm10494889qtu.25.2020.11.23.12.09.31
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:09:31 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK9UA3010465
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:09:30 GMT
Subject: [PATCH v3 63/85] NFSD: Replace READ* macros in
 nfsd4_decode_free_stateid()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:09:30 -0500
Message-ID: <160616217073.51996.17726050216615997950.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index bde832994be4..b326d5b4e7f8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1685,13 +1685,7 @@ static __be32
 nfsd4_decode_free_stateid(struct nfsd4_compoundargs *argp,
 			  struct nfsd4_free_stateid *free_stateid)
 {
-	DECODE_HEAD;
-
-	READ_BUF(sizeof(stateid_t));
-	free_stateid->fr_stateid.si_generation = be32_to_cpup(p++);
-	COPYMEM(&free_stateid->fr_stateid.si_opaque, sizeof(stateid_opaque_t));
-
-	DECODE_TAIL;
+	return nfsd4_decode_stateid4(argp, &free_stateid->fr_stateid);
 }
 
 static __be32


