Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD92FF5906
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 22:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKHVC3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 16:02:29 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34046 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfKHVC2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Nov 2019 16:02:28 -0500
Received: by mail-yw1-f68.google.com with SMTP id y18so2688464ywk.1
        for <linux-nfs@vger.kernel.org>; Fri, 08 Nov 2019 13:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUTQIBz1lo0h389F7WpocUOi4Y16RndkL1U5V7h4NfU=;
        b=K7OyVudcsUR3x4+revehF3TEa8uQ+twUXieYexOuKXmHONlt/LxNPDySb8sHS/+0Oi
         nojUtXRc3aM1/pG+XjPlVnYIQ3c0r6KtXFwyUS1bOFZjQdlI9w+SSzeRtquDaETK1XkP
         X5J7rM0tgxoTYhyKKrxlg60dmMkOIA7q1qc95O77/B0PofZwj4GCaVx0iw0zavK1xzAV
         s4vxWSxmgsPSaKDQ4OG1Oyb+0Q9NIrN4gg4i88ofcVjzZH95ZDRCxNoaO/7n1RsXeQX4
         XdY0v4PY6SeGMDfl6fsHOGk6zdpvIFYbKVtj+j2AMLi+zd7+SH31QOey7fSZjlht5GI8
         RN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kUTQIBz1lo0h389F7WpocUOi4Y16RndkL1U5V7h4NfU=;
        b=cITkz0FCfP2cBJfVT9UczyPfannpAChEldnHQWiq/4EcJSOOSfGpGzS/5jDHVJHPQ5
         QkJsezFFPju4i8gjN6qEbueB0+F12JQHI2I3K1Fl8Yr0FE3mJ60OqlznrRNXjg0s1r3z
         8MuQTzvSix4L2ZhNfeDfsWOWRLndr043MSA7vhhZEI5SoXBeKXys8rT5+Sn8TWfL6NhK
         02OfzIZ4ev5XFZgWsqPzlGdyNa4tOXSt/7GisW74rcJRQXry8qxgk94UU4cNOh2YQDzj
         S70VidfEqNjlg68v7qj+dxuzftmzoAwYGYzbHzqb3/DuogQ0pI8MRfKP0tavSo+m0iQW
         vPLw==
X-Gm-Message-State: APjAAAW06eu5/mqZSrD6xASKZRYs/3ioVYp6icJEu6LxNOygr1DntDcR
        iviYd85jMKNWAY5as228ABU=
X-Google-Smtp-Source: APXvYqzt9UhbuRFTgGe7C1uPSt0zDkVAzW8J+tYw8ckrjXX5PR2zsA78NgKR2QkfTEjgNl+abbJGyw==
X-Received: by 2002:a0d:d583:: with SMTP id x125mr8408656ywd.213.1573246947785;
        Fri, 08 Nov 2019 13:02:27 -0800 (PST)
Received: from localhost.localdomain (c-68-42-68-242.hsd1.mi.comcast.net. [68.42.68.242])
        by smtp.gmail.com with ESMTPSA id p126sm1904033ywc.16.2019.11.08.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:02:27 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 2/2] NFS: Return -ETXTBSY when attempting to write to a swapfile
Date:   Fri,  8 Nov 2019 16:02:24 -0500
Message-Id: <20191108210224.33645-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108210224.33645-1-Anna.Schumaker@Netapp.com>
References: <20191108210224.33645-1-Anna.Schumaker@Netapp.com>
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

