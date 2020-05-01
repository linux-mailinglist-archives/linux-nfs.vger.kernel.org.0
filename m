Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA511C1C21
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgEARnB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgEARnA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:43:00 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573A9C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:43:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id v18so5086682qvx.9
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eqiSLYH4rONyA5taIkTlAN6bgSJZ9blCTCjeQaIdYU0=;
        b=rJ4kyYEGpSJEit43Ba6dm1KvD0ZLjN5qYMCPJTYZUrH/hZiVzYOMrRg+4/snbzevtm
         xTQZnVFn2hYVGtvQSVYJrwgsq6VaPqepNmMPlTPvhaxFhBiSFECDQHOlinL+KPCn8qCg
         0qfMCBKAzk4AV6rT2HS4gCCCxLSuVZTZ64hu6Tcfz55DmywrLjOKo5vSJJ/bHT/beiEs
         trXbRur3sPV9QfduwALd2CAi+pF5ZKgsDoOnfbpNgf9rKoBoVfmoQ1fLBnn15bG1Eoca
         7qxQqHcCeWOVLozh0r2uL4qSpz1R4hw0w978S7+GLQBxwaL66sZpChS8GGNBJPQrcDGw
         Muvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eqiSLYH4rONyA5taIkTlAN6bgSJZ9blCTCjeQaIdYU0=;
        b=Gt9wzfmwqxAPe+5EONbw+mOL+Wld+4vNugq91WOqOJDkKekJPcNpVECjmgPqaEPLna
         5WM9IhLWwHr97onD9NtjsJfHa9LGhk976IMhKazb4MGEXyXD4YZnKzZnCxcP0OThJG8i
         nalX97nuXzPRaTfKr3WGEAlMSuxj4tkrlvBmFscguxptsuPCjDBBvFOozPSUiX1DPojm
         KEpEtCDPnElBgSL4txck1LIHrwXJrpBP/r9K/IDoXVSICi4/gE3MvU4m+Z/kWVK0FGqF
         78wSK4JdP7lMoG8PKRyDWZ11wGsPxX52KHbV9XHJifEPxFnozG0MQDOs0Xa1k6OUo53b
         sUbg==
X-Gm-Message-State: AGi0Pubd0AsynOUwTz6zWZtxuBHBK66DvTHPUewKQZxE4QORaXKikV/J
        v3OL7+T/mgm84ob+QTIWyK9F0tEL
X-Google-Smtp-Source: APiQypJW9O4V4gIjjWtlGRKJnhpGWiht2xPS6/AVf21ekOZhzgQG6GIjJGGLPGcD2DDwOfH8PRGLnw==
X-Received: by 2002:a0c:ed26:: with SMTP id u6mr5167554qvq.220.1588354979414;
        Fri, 01 May 2020 10:42:59 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c69sm3181150qkg.104.2020.05.01.10.42.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:42:58 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HgvhO026790
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:42:57 GMT
Subject: [PATCH 1/2] NFSD: Squash annoying compiler warning
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:42:57 -0400
Message-ID: <20200501174257.3941.61365.stgit@klimt.1015granger.net>
In-Reply-To: <20200501174124.3941.36405.stgit@klimt.1015granger.net>
References: <20200501174124.3941.36405.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Fix gcc empty-body warning when -Wextra is used.

../fs/nfsd/nfs4state.c:3898:3: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 88433be551b7..8b83341cae6b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3881,12 +3881,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	unconf = find_unconfirmed_client_by_name(&clname, nn);
 	if (unconf)
 		unhash_client_locked(unconf);
+	/* We need to handle only case 1: probable callback update */
 	if (conf && same_verf(&conf->cl_verifier, &clverifier)) {
-		/* case 1: probable callback update */
 		copy_clid(new, conf);
 		gen_confirm(new, nn);
-	} else /* case 4 (new client) or cases 2, 3 (client reboot): */
-		;
+	}
 	new->cl_minorversion = 0;
 	gen_callback(new, setclid, rqstp);
 	add_to_unconfirmed(new);

