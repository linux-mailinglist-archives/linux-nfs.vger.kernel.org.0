Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B71C131960
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgAFU1q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:46 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36343 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFU1q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:46 -0500
Received: by mail-yb1-f195.google.com with SMTP id w126so20729422yba.3
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3RZF081h0n2EOEc31Pc7IloAelAP8r+igP5Mlubtyk=;
        b=Y4O/7kynJ063IwPSbStbiygP6oEh7CgCjbWr3yWYwFKuxj3Sn1idlYPKWSbthgJgcV
         UIV74+uSGJe/tVqZdKalEZodcd4X/sNu1WVWSnKsSihbWXIhOegbGuC8b9yIj2Nv63B1
         RzJfOIzHHaLf55QSgyf3PSgjGRdPq5jFmiYLbImLt64lNUStAmzr9RgyG1HgXZGMiCT+
         HCsEORW3NEoLWgxzMqQo40Fga6zOETk9U79WGT1hKR8/AmQolb01h3yP3y6GRyL3/6RO
         XHVR+LkbpfAVbtwFoR8YLTAXzMkg7LuMLmoH+wBacFUh9Vqhpy5ftFMVy2chyRl0u0qy
         OQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3RZF081h0n2EOEc31Pc7IloAelAP8r+igP5Mlubtyk=;
        b=GpaLqUTX/5wGWzJUBz0s7YbjVBm3QQop3gxruToMcXws++FH4yTr6BetmxRAnO5R1X
         SKViY+7teSqzlG49gmwin2nVEqVe+qt6kUnUVINqln/BcPrr6VXJuyd75ulDoxO3Wf0d
         0qM2KOEfTX8dDD5Q2Stx2XIqKknTcEVcsZtca7E6zBoavRMb4b14KDDGzKgSpzEloAoN
         sbvZrbja/GwoijJ799OiZIjJOjBBNCBGElfdrpcVTzW6m2OmHnua0VTtFTdTNbFNpOPB
         NcvMD4fXuILt4YkCqW+gD1fZ2LSeAfuV5Cr2WFIV+qjDOA3UHAvaCPIRoi+em4UrDrbv
         kiLw==
X-Gm-Message-State: APjAAAXfIJVFnBX4BoY6xSnd6AQIR7gs3io8WDgnJO+Fj5gElFDpYgVi
        hEOtAMuFR3oM97CzlfmzgA==
X-Google-Smtp-Source: APXvYqziXtPi/zqJTg2fwzwiQAzPT6tO6hW3aVN5mqO1XMXAhpgJ12gnzuNLT6nhUC54eXJOw0bkRA==
X-Received: by 2002:a25:7ac2:: with SMTP id v185mr44063564ybc.331.1578342465028;
        Mon, 06 Jan 2020 12:27:45 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:44 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 15/15] NFS: Fix nfs_direct_write_reschedule_io()
Date:   Mon,  6 Jan 2020 15:25:14 -0500
Message-Id: <20200106202514.785483-16-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-15-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
 <20200106202514.785483-4-trond.myklebust@hammerspace.com>
 <20200106202514.785483-5-trond.myklebust@hammerspace.com>
 <20200106202514.785483-6-trond.myklebust@hammerspace.com>
 <20200106202514.785483-7-trond.myklebust@hammerspace.com>
 <20200106202514.785483-8-trond.myklebust@hammerspace.com>
 <20200106202514.785483-9-trond.myklebust@hammerspace.com>
 <20200106202514.785483-10-trond.myklebust@hammerspace.com>
 <20200106202514.785483-11-trond.myklebust@hammerspace.com>
 <20200106202514.785483-12-trond.myklebust@hammerspace.com>
 <20200106202514.785483-13-trond.myklebust@hammerspace.com>
 <20200106202514.785483-14-trond.myklebust@hammerspace.com>
 <20200106202514.785483-15-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The 'hdr->good_bytes' is defined as the number of bytes we expect to
read or write starting at offset hdr->io_start. In the case of a partial
read/write we may end up adjusting hdr->args.offset and hdr->args.count
to skip I/O for data that was already read/written, and so we must ensure
the calculation takes that into account.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 29f00da8a0b7..b768a0b42e82 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -824,7 +824,8 @@ static void nfs_direct_write_reschedule_io(struct nfs_pgio_header *hdr)
 		dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
 		/* fake unstable write to let common nfs resend pages */
 		hdr->verf.committed = NFS_UNSTABLE;
-		hdr->good_bytes = hdr->args.count;
+		hdr->good_bytes = hdr->args.offset + hdr->args.count -
+			hdr->io_start;
 	}
 	spin_unlock(&dreq->lock);
 }
-- 
2.24.1

