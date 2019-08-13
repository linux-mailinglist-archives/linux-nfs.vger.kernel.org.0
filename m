Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963818BB8A
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2019 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfHMOaQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Aug 2019 10:30:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40141 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbfHMOaQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Aug 2019 10:30:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id c34so33195957otb.7
        for <linux-nfs@vger.kernel.org>; Tue, 13 Aug 2019 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NDJE5CZ+uCjqNTTP+cuonA/hlMWMDmWKmwaE8OcBxbQ=;
        b=mZgTtvlqQk/GEbUI6yc4ktldB0mxqblGsNZ05qBCOubzSdeZqQVCwbumH40ISuv55J
         X88v0Yw7TUQkmEtpzcYv7hLrqFrDDiowY7//P9Kv1e20+SdFkKK8S9trG1WxEJ4wRpl5
         0E/Q8HgIAC3Sy3EQQxNXNEF3vgUUEIlhy8QFE6DZ4q6Lw1xF0pCCMpxC6++qImpeHAPm
         wEL3xtpCYpo0zypNlWL6fSaWGRghCRJZGSc9DI2rL8ArZfF9XGv8Vl78Efoekmz9mqSN
         Ml0otJwa6LDIWAmwoak4xVnfLAjxskpXEki9Epnxa6ANPsmxoAxMdhH35BnEWhxYWyrB
         phbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDJE5CZ+uCjqNTTP+cuonA/hlMWMDmWKmwaE8OcBxbQ=;
        b=EAUUJKE3nj3kM9/mqtT2VCSHFdyDRjkgvFENaiXPz5gnjtjLq/ApX7GZJnqTNZglHV
         HUHCr2YtGLUBs76aJ6dfcwFq5j6vx2F83m5YCry8u+OGDr/9+JOomEdQrJLBjaOMWhX1
         pU9/D1qKAtwLh9ylG7VPAGZFhn1T1LPdyxc/Ey/oVFUZqJzG53jrJlV1bCjpyYYHjodY
         yFZfetEOEFh9aKy/oSYq4fgjpcJfeUWd3pRU5OgyhZgY81BqKDT8Nl3v/te8rJki1sW/
         62bmDV0c3ADBBzUEc3fe8gj5VSUf7GdroVR1AtdwpbKXPsKLgKY8bTv5zrHI5Uxq0zs2
         uXpA==
X-Gm-Message-State: APjAAAXLjgIICSS1ojGNeJR0YJtF6PvO1vQAUYLBKiF+yfstV0/ASj9+
        G9FsK4msmw8wwdfVDwfjzJkTtp0=
X-Google-Smtp-Source: APXvYqwI9slPQqMy/iSI7Txz103yIZHxXRoKp17NI2TtGnrZwMy2faay9NYpiCNNvWICW0HkJTOkZw==
X-Received: by 2002:a5d:8f8a:: with SMTP id l10mr14561070iol.306.1565706615299;
        Tue, 13 Aug 2019 07:30:15 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o6sm9429161ioh.22.2019.08.13.07.30.14
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:30:14 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] NFSv4: Fix return values for nfs4_file_open()
Date:   Tue, 13 Aug 2019 10:28:03 -0400
Message-Id: <20190813142806.123268-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813142806.123268-1-trond.myklebust@hammerspace.com>
References: <20190813142806.123268-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, we are translating RPC level errors such as timeouts,
as well as interrupts etc into EOPENSTALE, which forces a single
replay of the open attempt. What we actually want to do is
force the replay only in the cases where the returned error
indicates that the file may have changed on the server.

So the fix is to spell out the exact set of errors where we want
to return EOPENSTALE.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 96db471ca2e5..339663d04bf8 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -73,13 +73,13 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		switch (err) {
-		case -EPERM:
-		case -EACCES:
-		case -EDQUOT:
-		case -ENOSPC:
-		case -EROFS:
-			goto out_put_ctx;
 		default:
+			goto out_put_ctx;
+		case -ENOENT:
+		case -ESTALE:
+		case -EISDIR:
+		case -ENOTDIR:
+		case -ELOOP:
 			goto out_drop;
 		}
 	}
-- 
2.21.0

