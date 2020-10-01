Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87350280A9F
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 00:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbgJAW7V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 18:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAW7U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Oct 2020 18:59:20 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4E4C0613D0
        for <linux-nfs@vger.kernel.org>; Thu,  1 Oct 2020 15:59:20 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id v54so684596qtj.7
        for <linux-nfs@vger.kernel.org>; Thu, 01 Oct 2020 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NAQgFLU0xvn0325Zpv3YqSXN/5aWGx8HSCBAMEQAeus=;
        b=pNlE4PpX9tFXwbOYpRiOJwMSk9u2nsvlqRcHSLtdEACya9PTOdCdyk7BX5GgFctdb9
         Pl/Ci1cWWwP0SAmT8B8QGvUZp1Ybz+3sc+B76wVSO6ijmB4m/gB09zxTIKaBmbg48xPa
         7zv2k6wy3REny8qgvbsvGPAm1Z3dstiFRby6JtP8abX9Cvnqwesp60O4Q1R7o9Xx+YUf
         TNGEKKcC0lifxdHpfuNX8oLuEkZuWzU3OjCR1uvm/OkTlkjbqwSIXw5hbqZbjZtKlwyA
         t4gxZ7O2zuy7pIYIb2vvIcJS7Ri0MMEXeNDsNDCNfR/2KrxNmGaJE32jHuuekdprooKk
         s5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=NAQgFLU0xvn0325Zpv3YqSXN/5aWGx8HSCBAMEQAeus=;
        b=GIWseGp0/U0cq3B38Mr6T6ZLwmJr5cIQTTze5/Z11vrrWemmQpJreklBtOwnm4Abfe
         c+Fxj7I+QW3Mkj6v6p1hGHrF5+gc4aJ7eAGyWB/X5joSs9McEfREsfw/Gv2FvnOSERkj
         G6i/JvJRZqf44POLiq34JiNKFdROBfg9sOTMUYgfzoveIa9fKcSjAyVPHp2BbSp92Bmh
         5/5dLXN3l7TNthO10fC3j/u73XJVt4glcTElGw3/KS9mRf6pEG1f9F8d6JDWIzW0h1RH
         RLdWxCQI6voUZxnog8EHf586dzzAHGrq4w+dLotSP3KH8FRTGwJR+XlkOachoMQiDyXh
         fgbg==
X-Gm-Message-State: AOAM531jhEHdkVSIl2dIsHmPcqwHSOEf+ecjDF9/YzU4Ny/6wIlAz7uQ
        f4adz4KxTc9owvjTfiuCsug4gjyLZoN+uA==
X-Google-Smtp-Source: ABdhPJwYokdXC4tHg0bQJsTTTajhpcPZ2yHoSxXBcN4gd2ylmrct6odsh/wHWvbdhA/kpVSDwwIq1Q==
X-Received: by 2002:ac8:1387:: with SMTP id h7mr10423576qtj.386.1601593159599;
        Thu, 01 Oct 2020 15:59:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r64sm7307215qkf.119.2020.10.01.15.59.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 15:59:18 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 091MxIxe032580;
        Thu, 1 Oct 2020 22:59:18 GMT
Subject: [PATCH v3 06/15] NFSD: Clean up switch statement in nfsd_dispatch()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 01 Oct 2020 18:59:18 -0400
Message-ID: <160159315816.79253.16042817887755242154.stgit@klimt.1015granger.net>
In-Reply-To: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
References: <160159301676.79253.16488984581431975601.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Reorder the arms so the compiler places checks for the most frequent
case first.

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


