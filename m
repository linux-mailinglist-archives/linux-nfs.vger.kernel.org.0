Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D5514470C
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2020 23:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAUWOp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jan 2020 17:14:45 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46081 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgAUWOp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jan 2020 17:14:45 -0500
Received: by mail-yb1-f194.google.com with SMTP id p129so2130829ybc.13
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2020 14:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nGQRAx1j0iUIeJXIYNBONA0R2/M3zFx9yOJ0Y8LcXcI=;
        b=bpeKCWjE19adRUmpGt4nvULU8aMOKnSAsCv4ExtNhbfmk1cnVOg4Rxs6KqQdC1QD8K
         KhrrYzfITw72tzPHrxZk4kHI6Ts6W+sAi6au8xzB5gXSfp5SJup17fFb6J7UncqHE3zC
         vur+JxAWpnZtHVG7Wnee9dAZBIu1BzSsLmbFCcVIkGA+r3AJItorpe+G3a4tlIMtVJr2
         yxLXzyOKiI5oEKOo9TT/gdU6GzZtO/N9GFkMeJLXd/Ot2jWJXJzLc1jKVlTfC5nS4MOH
         06juNsnHA6jUWOXJEH1ZdSXD3kjTEK6gIFI7pXeRSGQsENW3TjROKcVq6ao6ANY8wBBH
         helw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nGQRAx1j0iUIeJXIYNBONA0R2/M3zFx9yOJ0Y8LcXcI=;
        b=KHZhokOsAc0Rn5PzgKiWii+jerrG7Y+XKnRSgMPluepLEhqdig61+X+mS5sW95Eh2o
         uJ7OOphiJWgmyqdacrcNMJyi0RqNePPdrC7KAPt+kKPM/UXHwXlrVHe5oh2ai6C/wiIB
         vskpIPyekF9/LdtqkjSopEQuWN7ZoiGftryg2QKZLp6KHQZUMyhB8tK7BcUXr3PBLFqN
         GgCxJhPQY/SbJrjC8Af36J2wbDV+ttCKJbgHLvqyXi9uHKb+uW2r7jkhlSCW5JIiFFZf
         uaagMDkZlnKqeefskyo915DCWTbFn+omYCVc2oSbMhlj258MqM88AJMlpEZyrbihHfI6
         HOjQ==
X-Gm-Message-State: APjAAAUwQ3uq4w21a1/+KaWBUWmi1vCTwYPTbrGB4UZmWxZvgWeWQ4Do
        Dr4gshJg66BzWDPVwH96YlPWhuT5
X-Google-Smtp-Source: APXvYqyYzo51pqs2tqQptbXlqvGYMNStYQAEWLZ8GqDN2n8r/UdmEf87io7D9fOlMx0ejq5fAW6bbQ==
X-Received: by 2002:a25:d9c3:: with SMTP id q186mr5520759ybg.466.1579644883824;
        Tue, 21 Jan 2020 14:14:43 -0800 (PST)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x184sm17788731ywg.4.2020.01.21.14.14.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 21 Jan 2020 14:14:42 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2 re-initialize cn_resp in case of a retry
Date:   Tue, 21 Jan 2020 17:14:41 -0500
Message-Id: <20200121221441.29521-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If nfs42_proc_copy returned a EAGAIN, we need to re-initialize the
memory in case memory allocation fails.

Fixes: 66588abe2 ("NFSv4.2 fix kfree in __nfs42_copy_file_range")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 620de90..9f72efe 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -177,8 +177,10 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count,
 				nss, cnrs, sync);
 out:
-	if (!nfs42_files_from_same_server(file_in, file_out))
+	if (!nfs42_files_from_same_server(file_in, file_out)) {
 		kfree(cn_resp);
+		cn_resp = NULL;
+	}
 	if (ret == -EAGAIN)
 		goto retry;
 	return ret;
-- 
1.8.3.1

