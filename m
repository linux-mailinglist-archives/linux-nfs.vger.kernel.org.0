Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA92F27D078
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgI2OEG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgI2OEG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:04:06 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CBC061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:06 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e5so4964771ilr.8
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rnfnS/ie1fv9ScrevDzKLJBzsPV+bWuN16l5MtcHTQE=;
        b=JqRd6xUReE68e+AsGMga/jfWtuyATDtq51VDkEFSZOv6yxaZoLl6mArqwqUwycvBLE
         wcPowVqwTpnMxES2OKifrxig4Oa0D5pTo5IOPm2M8f1tfPABrmBAUTQtJ7NHfTuV1i2M
         tPUeqOzCA2wQSjNmeX6gWQBa8mYnJeQ6vmNGYzsDMwCNM/ysoz639HaRcSSi4ltsK7W6
         +Vx3t06Qzn1O5rPZxWnS6HDgsW00cimlw53f3UMLo5RG7rcBs+5P4e68KVVgkqAs8UGr
         +m8fLkvml0F1jXnMPPUKIXeTeTso5kMGzF+mVxn8LRrTRIQhq/KwFAU02OBaHw0PAy0P
         ryJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=rnfnS/ie1fv9ScrevDzKLJBzsPV+bWuN16l5MtcHTQE=;
        b=nTkgygU/x7zyqgkFkzGCMT2i3PxK9t0Bxlu4zwVm/PyXeExnabwlo0Ro6q3iqm/oiI
         BN2/Zz8A3vpDQQcMNQiz1lsLYPBNhFkguU4VpZvoC0q6otXJKV+mEExKtZMYffleYOad
         YVNG1R0zimDplUx0882pOChA1U7ux4XdVA0OxtSHu2+/OP+sUVuEEDIipNtFZaltY2ju
         /Bax6cGi4GKCB0EDg2HtFGAk73FrFvWwMSx73TfqhuW25mZwPdEe3Au9iVdK5fJrHP6z
         KU0SX4HHk9Gm1/9xsN3VpsDJhpBHN7cfUHVj3l6yn6E4NY/i6s0x/4p1+4gyWIBZmP0u
         vKPQ==
X-Gm-Message-State: AOAM532+PSMy+d4BdKAFj67fqrEJwBn0Qy8n4BP9z6O8mSXpqAg+2m0D
        gyZsJWucch7n6ZCptui184ShX2OAPrJSng==
X-Google-Smtp-Source: ABdhPJztfFD/aTTDcEHDvoF0MNrau0mZvNu7dqLQYWcHFCDFbkzs1LhdaKZb7OFGcqKSNr5L7VjYPA==
X-Received: by 2002:a92:c60e:: with SMTP id p14mr3059737ilm.17.1601388245505;
        Tue, 29 Sep 2020 07:04:05 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t22sm2528859ili.9.2020.09.29.07.04.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:04:04 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TE43Aq026427;
        Tue, 29 Sep 2020 14:04:03 GMT
Subject: [PATCH v2 05/11] NFSD: Clean up switch statement in nfsd_dispatch()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:04:03 -0400
Message-ID: <160138824365.2558.3730697804206958272.stgit@klimt.1015granger.net>
In-Reply-To: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
References: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
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


