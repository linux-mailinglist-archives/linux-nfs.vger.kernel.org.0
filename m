Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF175ADAAC
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 16:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405124AbfIIODU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 10:03:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38649 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405126AbfIIODU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Sep 2019 10:03:20 -0400
Received: by mail-io1-f65.google.com with SMTP id k5so3601051iol.5
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2019 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tm3Z204lhcQueHhZs5vFp/leKoUofNIJTGBebGTHcyI=;
        b=l7yesDn0PKJ0N97K2Q7aNFpVYN75fBcYJ7iEOHWfZdWDF//sP+Z6d9FpWjtnxcNSr+
         gyDSjuDm80tNSretPry+2wSgGkQSpvtyohF5PWZd8qiJ1RwiUfrV/XfabFb2ViOA1yTW
         buOa3YIc0ylcpRHrh+lnIT8CstJZd2tCwQUQkellP9mSgzBxgXCfztqyaFiUviFEHJQ1
         i1zHQnut3ZeX+A4FZlUrreINYeQQDFaq9OR9EZg8zR0ZXH9rYBtdLIHFDk1LMQ/4nkav
         25A/acH1cGREZKhv3cxBGyBZ6tRPb/q8Eikv3kSTlbbpVqMWjPD/50nqNHpwHEvRfLZN
         q4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tm3Z204lhcQueHhZs5vFp/leKoUofNIJTGBebGTHcyI=;
        b=P8rsMSVAuxBXPfgwWGGVJOoNVFiR+N1bDNkiDVhhRkKy/pidvV/ehI70gMd66tkTq3
         /OqIU5oDwkC/+oHrhZtPY+S2wYDSOJQ9orf5wMCzZiL4427cjCPj1x+skHQqYIijsm+7
         u7jdLAOq0PTn0b11r8/zscAIEd0AmOeNv5qc5d8VQAy76bIiMEYxbEux/QxJp2mavZUB
         Mfdywj+WolTLlW+Ef80pMNfE4mZEMTsr1TnQQah1OjWtQejqKXCGBXzTH2ZMuOhcMt/Y
         3XWqMhF50dC49/1oPZvEXBA89P0wXUC0qcjg8pmMipi6aAX6B0CwJy5CnWWwsRPU9sr4
         hgBQ==
X-Gm-Message-State: APjAAAWmXlLi/C3jP9F1EU7oHzDToG7is+H1YMzhvcX2XtF50h1xYebE
        9IQSm7iXiviXbXixE4GX3lyRZGVQsg==
X-Google-Smtp-Source: APXvYqwBegJSXPQgnQS7GEYW85/wSxyVZjnJUDcbahY5gUDiVbHn9cwqjMA4lQu4vlTitgQdKVo40Q==
X-Received: by 2002:a5d:9591:: with SMTP id a17mr14563566ioo.303.1568037799513;
        Mon, 09 Sep 2019 07:03:19 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id h70sm33727176iof.48.2019.09.09.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:03:19 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/9] NFSv4: Fix OPEN_DOWNGRADE error handling
Date:   Mon,  9 Sep 2019 10:01:02 -0400
Message-Id: <20190909140104.78818-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909140104.78818-6-trond.myklebust@hammerspace.com>
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
 <20190909140104.78818-2-trond.myklebust@hammerspace.com>
 <20190909140104.78818-3-trond.myklebust@hammerspace.com>
 <20190909140104.78818-4-trond.myklebust@hammerspace.com>
 <20190909140104.78818-5-trond.myklebust@hammerspace.com>
 <20190909140104.78818-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If OPEN_DOWNGRADE returns a state error, then we want to initiate
state recovery in addition to marking the stateid as closed.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index cbaf6b7ac128..025dd5efbf34 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3394,7 +3394,9 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 					task->tk_msg.rpc_cred);
 			/* Fallthrough */
 		case -NFS4ERR_BAD_STATEID:
-			break;
+			if (calldata->arg.fmode == 0)
+				break;
+			/* Fallthrough */
 		default:
 			task->tk_status = nfs4_async_handle_exception(task,
 					server, task->tk_status, &exception);
-- 
2.21.0

