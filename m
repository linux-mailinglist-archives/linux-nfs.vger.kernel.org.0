Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC5FE639
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2019 21:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKOUMy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Nov 2019 15:12:54 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43833 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfKOUMx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Nov 2019 15:12:53 -0500
Received: by mail-yw1-f68.google.com with SMTP id g77so3513267ywb.10
        for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2019 12:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kZlVEc5Y/+sR1L16Fwp7UF3l7/Jc4QsG6cWtOcL2O7I=;
        b=ifLUDzMawxYOthx2+vAAAtjVJg2fbUqV9zUTB1QoFPzsBIHChFr1a3KLX69Pmg/zlB
         thXxs6YPy93e6qAAqXIqL5kc0n3QenZX31nOj83AXgwXyLg3fhk8R7ip8f6e+6HF83Xa
         pf//vs3emlLHprtVyocLyBcH6IvIZNOu/R63ngnCaRL/zhzV9KXdooKNowcA0cQtHNyk
         61dBteGQ+aj5+Lo2cv6KSPfxBmSU5X5OTtOI0OqrNh7G2l+yIAq3XAtY4Xr++H8EIYr0
         z+gHzoMEkQyUlqFZ8oAR5gBEalm3TtdZ1oKFofG/DCr/HdcAsih6oFy7G/Bjz0G5RLjD
         K2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kZlVEc5Y/+sR1L16Fwp7UF3l7/Jc4QsG6cWtOcL2O7I=;
        b=sWmcu7hRW6iJxXif/7M+zm3uDObHfYG1xt89NQSOHf2Msh5DoVvsD4vL9aksbrDmFZ
         phNvjsFTR6R8LawQxSfPL/puvpLDB0hBGDdFb5Jh5Na/LbW3n7qxJPYRjNkD432yGuu3
         Q4kFOLeAbUe4v6fHUY/RkRmUgcNCArSw+MVo+4cVLZHXAKqzZc13R1SHHt9eH1Hd/1G0
         DMMOm/SOLexyCID6RLZ4W/Xghdl8VQP9M+10eIzLFb2N0iJxngMSODr74FJXg8SoXHhf
         i8VT2xEZG2ZXg0s0wmGZlMtoxCuXcZchM0ZJtFpBE9RLLip7rDFy/4zZYilOfKlUvgY+
         EByA==
X-Gm-Message-State: APjAAAXNSaMjDQgF0BO6zxwVVO6/vAq5xiJYdlAKgT/IkqG6ZUOLtsWA
        xAK4hlbIzsnwOhBsMDpe++6p70sm
X-Google-Smtp-Source: APXvYqyNhb+JzOQ3Cq7C0FpV4ex1F/4r3JvCL/vK8rs9nTzOs25bG5D+hka/oph/+qDjRbYln//SZQ==
X-Received: by 2002:a81:6d4d:: with SMTP id i74mr10377455ywc.280.1573848772679;
        Fri, 15 Nov 2019 12:12:52 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id c72sm3536419ywb.52.2019.11.15.12.12.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 15 Nov 2019 12:12:52 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2 fix kfree in __nfs42_copy_file_range
Date:   Fri, 15 Nov 2019 15:12:49 -0500
Message-Id: <20191115201249.3700-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This is triggering problems with static analysis with Coverity

Reported-by: Colin King <colin.king@netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 396ed52c23a5..901497c7212b 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -178,7 +178,8 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count,
 				nss, cnrs, sync);
 out:
-	kfree(cn_resp);
+	if (!nfs42_files_from_same_server(file_in, file_out))
+		kfree(cn_resp);
 	if (ret == -EAGAIN)
 		goto retry;
 	return ret;
-- 
2.18.1

