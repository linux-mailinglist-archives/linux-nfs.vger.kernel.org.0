Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2AEBD29DA
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbfJJMqe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:46:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32859 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbfJJMqe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:46:34 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so13416191ior.0
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x28Vl5d2oxzfE0+B3js0awQzQgdstOVsyD6DKTtZNjE=;
        b=aIfDZBHqKluYtejOu9S0tYmibqCeBacYSMkeTboO9JVno+FVOPRzlntfYSz/S++VqV
         c0KkD4Pe7lbS/8zuFcXVK3hKdrhksolKj3y8VKMKuhda1Yp5Rz7PWXxED9qYBfc80dch
         vD+ZvihRMlFxBPTiW0biJbo0H9m75otG7RSSzidfCtYUB+SUGG8fDNLqCyrmlYRZm3k8
         FXoeEr8O8PqIuURKNz0Ohq/M8a19rvXE1IRcntYpBMSdrAQRgc2GWIQS5LgmreR09FS9
         /vXEtZAC0gVtJkFkQGmMUoN0vg4s011AylgZbYCMTw0rt+lKkclaW1f4uOjnY2oi6u45
         tOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x28Vl5d2oxzfE0+B3js0awQzQgdstOVsyD6DKTtZNjE=;
        b=btsbVo//TxNdb7eLEwFYxYhWozLTB/t5A4Tv2QrEJc92T+nzsdkIQSRYgko+zZxCrd
         13n72uiq8DTEKQg/PT6LlGKXtmsxeI9gWRdlvFhTY0QwOOWMsNtk8iT/dDsic3L7KuSz
         LL5rw5qR3JhHgaeze00hJFVnZ0f13sAYruZuZQxIfL9wtKUpNTnSR8c+a+U5syd9LZOr
         CsGqaoCbNad2ziMD4dWdd7v7WFLie4oWMZTa751QScJbnOfe0ttjdikpZMz68WfnVFa2
         /6G1X9MCrlIE4RwslyyOr28vLQ0wALRSaK0yZcQGAD76WsoJGcikDpkhRcLRkh/Zh0Bt
         uFIQ==
X-Gm-Message-State: APjAAAUkJqbjd8R0SMg3SrKpaO4nDnMu92TLJ+i/pVddJ2D3MRRmVkgz
        WwvTccvCX31fX3otCz2/aU37Z42G
X-Google-Smtp-Source: APXvYqzZoATeli2B7siM8Z/kyDgnJUs9VKa8+yARpfZL9QylwLeOMNM6nhjJ8kDPIgpONyZMCSCK1w==
X-Received: by 2002:a05:6638:928:: with SMTP id 8mr10130357jak.124.1570711593239;
        Thu, 10 Oct 2019 05:46:33 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.46.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:46:32 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 07/20] NFS: COPY handle ERR_OFFLOAD_DENIED
Date:   Thu, 10 Oct 2019 08:46:09 -0400
Message-Id: <20191010124622.27812-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

If server sends ERR_OFFLOAD_DENIED error, the client must fall
back on doing copy the normal way. Return ENOTSUPP to the vfs and
fallback to regular copy.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs42proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 6ed5a16..50538b9 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -391,7 +391,8 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 			args.sync = true;
 			dst_exception.retry = 1;
 			continue;
-		} else if (err == -ESTALE &&
+		} else if ((err == -ESTALE ||
+				err == -NFS4ERR_OFFLOAD_DENIED) &&
 				!nfs42_files_from_same_server(src, dst)) {
 			nfs42_do_offload_cancel_async(src, &args.src_stateid);
 			err = -EOPNOTSUPP;
-- 
1.8.3.1

