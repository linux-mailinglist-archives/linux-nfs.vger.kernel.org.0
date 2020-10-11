Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3F328A811
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Oct 2020 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgJKPwd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Oct 2020 11:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728967AbgJKPwF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Oct 2020 11:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602431524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=KQnb4CH7LT3cdQtsJpo37voSU/mfPI7rXeisXRwZ6eQ=;
        b=PpcxYaX6353c7sbWu3Z3hXPVajPUq4Rpyh3yYOcTgbfIgFhwQ2Rx2I4W/65EMr5D8UfLDL
        LsDPGKweRFz/ho612TI3xob3/YYeQBtd6LBluNzz/CHY/b89MMcMGzoNs4hCoDXezOmFaC
        v5PPx4dtYSjJiqi+obSkZYz6OyTQBiU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-ZxiznYGxO8ifUhomEWZP-A-1; Sun, 11 Oct 2020 11:52:02 -0400
X-MC-Unique: ZxiznYGxO8ifUhomEWZP-A-1
Received: by mail-ot1-f70.google.com with SMTP id 32so5207996ott.21
        for <linux-nfs@vger.kernel.org>; Sun, 11 Oct 2020 08:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KQnb4CH7LT3cdQtsJpo37voSU/mfPI7rXeisXRwZ6eQ=;
        b=V4YNYEa10zkxEMXZBsFot1+gkFcK4K/8YyXQiVyHT5G1DZj81aYLVREiZ5qrVxvO0Y
         hDpjcau8L0bpyTPyu02xCxdjMiOR4YxQAN147I7HNSydrFf1n3cwm3OImXrgMfL4P4wz
         /f+lGtFMMTSLnd2TiZ5TmwMMFHqyhZcEAHT+rzznYySFEndZb9RM4hLofnsno/jKzOki
         HLcyr3PRTIX0yqRjt/gpeBQIUy750DnIcfbNIKZAu1AiUAHLYtKHYdnmUU5IW/g+GuDy
         ZZnAK3Hhlq4MuD8H73+wdsGt71yNeg60M1jQLisD68Ag4a5onCi+g14Jwa31zRJlcb+E
         0+TQ==
X-Gm-Message-State: AOAM533sd6u+0UDEkHSRB8UYBXJmWXLbELT9bjd5lXRNQU3jo+WjnH9Z
        DPyi646HL/xYRR2fD0A9iOY0o96LJf4gCOzN7I4039Wp5NFCoMgLXQTfilty3XQWCTL8E597JKt
        P36A8r7aepOWjWx+r0g+b
X-Received: by 2002:a9d:2264:: with SMTP id o91mr14637420ota.24.1602431521850;
        Sun, 11 Oct 2020 08:52:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1SEkn1HK15DwepPB+QXg6E52BH98J6MiRVEFvjsYtV5EAeQiPN+9fCaC/ZFRcsjNrOBDfAQ==
X-Received: by 2002:a9d:2264:: with SMTP id o91mr14637411ota.24.1602431521631;
        Sun, 11 Oct 2020 08:52:01 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q8sm7920611otf.7.2020.10.11.08.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 08:52:01 -0700 (PDT)
From:   trix@redhat.com
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nfsd: remove unneeded break
Date:   Sun, 11 Oct 2020 08:51:55 -0700
Message-Id: <20201011155155.15538-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Because every path through nfs4_find_file()'s
switch does an explicit return, the break is not needed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/nfsd/nfs4state.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c09a2a4281ec..741f64672d96 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5722,7 +5722,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
 			return find_readable_file(s->sc_file);
 		else
 			return find_writeable_file(s->sc_file);
-		break;
 	}
 
 	return NULL;
-- 
2.18.1

