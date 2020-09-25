Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6E278F3F
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 19:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgIYRAW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 13:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYRAW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 13:00:22 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D05C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:22 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z13so3511306iom.8
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rnfnS/ie1fv9ScrevDzKLJBzsPV+bWuN16l5MtcHTQE=;
        b=i3w4JTo460lYRgNp0d+HJkuYMHEY9KrVG81T8lUGa5gv6oh3uX/2wQ8ZcuItBiKzSw
         uibMG77d2SYqz/x72/jcB43unqBgG+ABAVIqw3lneGfH6hOjI1T1DcUNBP0kXwUPbwiq
         D0H0VKLjG56ndE6nWmBYKCDfAB1+XRxTlxI81/A+XSTgCWVgy1XaUFwfZQ/haa2N52x9
         moLO3agFdbEXs2QP+OH33hMqmjL7jtUhaaY9/z3Hk4867Ef5M7YY/UGzuf61/rJc85ja
         H9ovRMJVPt0hKLPoboKit1EO9ZcekbMNx02NFEwxFYLRdNNimpn/x8wGKlvJ4FxIemvh
         DXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=rnfnS/ie1fv9ScrevDzKLJBzsPV+bWuN16l5MtcHTQE=;
        b=bv64gPwJW91E4xGDZgcJkNM4U26CASeXq7bwDZ4U/5qcldYYihX9LGMclRE1hwOXSx
         GwLSGJZmzxeibLlUv+oCrWVi0ExPOLzZpotLsh8jpFJu/AFgBE6tda3OmLkRNZJpXony
         1NfvZuPPKG1WCXYMMw775mANOFYby/SKDWaeb08a7ORJY+JA56qDNbB4UWxKpWmzxPcV
         Ag2uG5jnnCEiXyrD5+IjNd3l5wl0O/z/m+iGlubxeEV7AxIJ+um0ura1ZvVnbLxiwKW3
         yuT4K0JDwchFE+UW0C6wNSXjSkHaM3m49TrSp7IcT7f0FVUZF0bi3EGOCb/9MKs+cHb5
         XqoA==
X-Gm-Message-State: AOAM531abSYkXyY77cu7M4/Wq9gBbyhGrg0IsibZ9YhVqw2imXoUUN54
        tOugOinYbQSK0HbVwcsGjgg=
X-Google-Smtp-Source: ABdhPJxrg/nxCWV/e3+2yaTnWJanmUedxKx7MHKeGDCY90FsnWFOged0nQys7Yl2g348xwyOOFtuFw==
X-Received: by 2002:a05:6602:1547:: with SMTP id h7mr977442iow.20.1601053221614;
        Fri, 25 Sep 2020 10:00:21 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g6sm1396992iop.24.2020.09.25.10.00.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:00:20 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08PH0JAf014533;
        Fri, 25 Sep 2020 17:00:19 GMT
Subject: [PATCH 5/9] NFSD: Clean up switch statement in nfsd_dispatch()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 25 Sep 2020 13:00:19 -0400
Message-ID: <160105321991.19706.2205551595824611772.stgit@klimt.1015granger.net>
In-Reply-To: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
References: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Reorder the arms so the compiler places checks for the most frequent
cases first.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b2d20920a998..3cdefb2294ce 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1030,12 +1030,12 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 
 	/* Check whether we have this call in the cache. */
 	switch (nfsd_cache_lookup(rqstp)) {
-	case RC_DROPIT:
-		return 0;
+	case RC_DOIT:
+		break;
 	case RC_REPLY:
 		return 1;
-	case RC_DOIT:;
-		/* do it */
+	case RC_DROPIT:
+		return 0;
 	}
 
 	/* need to grab the location to store the status, as


