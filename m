Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7D27D080
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgI2OEc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgI2OE1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:04:27 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01AFC061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:26 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y2so5003977ila.0
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=O+9Q0DHCqAEnSq7SktVxjWAQglOZ+y4pJdzweRaL1uQ=;
        b=f+8/M+lKG7qyLy+ey96gNKsf/k/n0GoGTSBupR9uEQHXGXKF7OfRZ1HAVA+YOHjwb1
         bZsMkhKKfaF9Zu95jJJcPYxVi0F53anCJj0YnpFJBIg7tJbQmv+CNfe5/NfxKeY9khS9
         2hUUXMb+j9HrIAyhZzJzWtBXD7MPxclIKOSDQ9lSn8z3BiaW1wUheHjluN/wsk/mvfhz
         ZfII2thmClrDd2zOOd1xovhbWPmQVLFYQ2ZoihIQFYyaioBaPHbLsUhBmD+6xq/DHiJB
         pbGf2ZpNJuOV5BqbDkbIVgyQDnIfIU5vor6H3QVd2cQV+M1LhzkD04AkOty8ADjXX/7D
         g56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=O+9Q0DHCqAEnSq7SktVxjWAQglOZ+y4pJdzweRaL1uQ=;
        b=tUJQGnC1/2aORVugGmVTZJ6NO///Qxe79iDXfCT3Cz0zr8FdX/XA3y43Lzs7neJPPu
         jO+QoX4WSZwlx/u79zpvRL9Hq5wIJWMozdwpEVK9IS8Tov7tCXosysxsSLi36rISb/U2
         TlkyZjMHgZYc82gY0yayjbh0uBZ7zWSb5gd3lxm4rN2NvrO5etRfs5atR4uKHaN6QaS2
         QUkIB7T0v0AHQvGB/bqU/LiEVXdn7Up3xQjWnMGbvAf3uoLqes3pOoNnnWY/zqTlDq0C
         dP1fsWv+eNZarqx7ucjcnyHyRTPY6sHHnoqze2ff52xtePmCIEY4sMkWfwrVyXPpMvOl
         YV1w==
X-Gm-Message-State: AOAM531UEksJa35Tjnq1VkwmxAMCnFARNlGGoYoDtKOZTBxHzWLt+7zH
        pAjbiQas0TP4tBj228SwIak=
X-Google-Smtp-Source: ABdhPJw/mRQUA3+fdsuqFPTV0IWXjBiILlQDWtic6Y3i39GMzkeOePxVdXC+R/3ND+azsw3rmtfj0w==
X-Received: by 2002:a05:6e02:8a:: with SMTP id l10mr3317966ilm.130.1601388266314;
        Tue, 29 Sep 2020 07:04:26 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i144sm1745859ioa.55.2020.09.29.07.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:04:25 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TE4ORR026439;
        Tue, 29 Sep 2020 14:04:24 GMT
Subject: [PATCH v2 09/11] NFSD: Set *statp in success path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:04:24 -0400
Message-ID: <160138826463.2558.7846998437714554728.stgit@klimt.1015granger.net>
In-Reply-To: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
References: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

*statp is supposed to be set in every path through nfsd_dispatch().
The success case appears to leave *statp uninitialized.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 283d29ecae43..08776b44cde6 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1065,6 +1065,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 
 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
 out_cached_reply:
+	*statp = rpc_success;
 	return 1;
 
 out_too_large:


