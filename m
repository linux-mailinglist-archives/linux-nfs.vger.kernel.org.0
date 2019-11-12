Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47ECF9C64
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 22:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKLVha (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 16:37:30 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34050 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLVha (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Nov 2019 16:37:30 -0500
Received: by mail-yw1-f66.google.com with SMTP id y18so6999480ywk.1
        for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2019 13:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUTQIBz1lo0h389F7WpocUOi4Y16RndkL1U5V7h4NfU=;
        b=lwNB8SPy31L+0JKnv1Rl1lmpV48Nc0BIBOstj2STpUXpFWRgAJzNt5mrbNDy8g7tRu
         ZB912ZVVGQOaNs7qIQxCR6mN8dnLde64IFsak7x1KwJA0g9002noYWS5Z7OMFPI+h6vq
         Wl4pxulD6bGQ03yAw0Qsu3YEqDrt94ulTzU+SN35M1RQ7xyQgwAnmmFECXtDVpZ357As
         b3cMA+5lJrjxDRflcvEEJ1Mp/F18kU1HbXP8DTb4F4AVMJIAD1qozfgvVl4qNYRcrbwe
         Q3IxMrhJ1T69bsi9XMKh5HtiC08/uZNYh1UylUt706D+suSt9R2xKIQfpOSjGiSH5eyK
         gdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kUTQIBz1lo0h389F7WpocUOi4Y16RndkL1U5V7h4NfU=;
        b=AXEJm74kQCeh4bKDRcQdDh7AA3HOE36v5o0r4owHDtkE3M8hodORtTritRioG593sw
         T/LMKkbwwYQNUn8+EpBOx7CFab8lqvDC4SiDZ6v/U3/kR7Ecw+iVWaU+qmmqOSF/5j0V
         FEfVFHg2YPdwdufkzDF2zCIVJshn9qsNOp1rvJ+QoRSbt4AaKSMJspMWkev9KnwU0cLq
         bARKV8rfDbnH4UHWceMRINchrhO2O4w+QdlPKYlcIYEM0kfC80s3WZ9iutZvHw8Y4w7F
         Yb/9Lkvmv7lFVXE1DelQ5ViCw7uv0uBtoWZ5v7onkLsmhAvNDZu9QtzTVPD2bXy6yDvJ
         sjiA==
X-Gm-Message-State: APjAAAURU6FqP6QR+jO9GzCuEsHuyTzlqV52hpvv3rDd5Z3lZc5QFwdi
        6OTHKg9FIjEJORbeu2kHtwU=
X-Google-Smtp-Source: APXvYqz3IdP2gS9UXj3YvWcxQ4JfyXOzOOocq6z2Yt1jMwvHuBVEMsC4DF5sGNpv0UA/1UneAM4srw==
X-Received: by 2002:a81:58c6:: with SMTP id m189mr98123ywb.25.1573594648605;
        Tue, 12 Nov 2019 13:37:28 -0800 (PST)
Received: from localhost.localdomain (c-68-42-68-242.hsd1.mi.comcast.net. [68.42.68.242])
        by smtp.gmail.com with ESMTPSA id 137sm14233490ywu.84.2019.11.12.13.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:37:28 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 2/2] NFS: Return -ETXTBSY when attempting to write to a swapfile
Date:   Tue, 12 Nov 2019 16:37:25 -0500
Message-Id: <20191112213725.414154-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112213725.414154-1-Anna.Schumaker@Netapp.com>
References: <20191112213725.414154-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

My understanding is that -EBUSY refers to the underlying device, and
that -ETXTBSY is used when attempting to access a file in use by the
kernel (like a swapfile). Changing this return code helps us pass
xfstests generic/569

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 95dc90570786..8eb731d9be3e 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -649,7 +649,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 
 out_swapfile:
 	printk(KERN_INFO "NFS: attempt to write to active swap file!\n");
-	return -EBUSY;
+	return -ETXTBSY;
 }
 EXPORT_SYMBOL_GPL(nfs_file_write);
 
-- 
2.24.0

