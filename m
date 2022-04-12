Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7278B4FE895
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 21:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiDLT1z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 15:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358876AbiDLT1t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 15:27:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6027FE2
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 12:25:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso2231582wml.5
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PVkQSpkYnmD3vFyfW39/ocvVWM7nU8BPMK/qODYyvh8=;
        b=Kxkr+qd5CrvkKA2Ge9gdOLi4hWKEfGl4VvNKl4cVzphYt4HvkbwzmBdWfbFIQWwQYU
         DZiQWAMv9E892k7FrVwIWKmy1SoUiyAlJrHEMBZyeTo7NRonIeWuuGjMWeCHa42VyYEK
         +vEFIfx0ZS4cbGTpBUlBHSEjdwJKdDJFLYG1cqE7oki3mnU/Ce02rU31A2QsA4Svapwm
         XVraDUG1JQOZ3eeFhGhSQY8SYOuZsQQ8peGuC42n0Uo0s6FYzYxJ2E8RHOm8ddLOCLsz
         92VR11pFigvtgDCaHCrLYxNDXw2pEqz8oCLfuq8rY3Di4fqyXXTnJU7U6NIbGiRWHaYj
         1jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PVkQSpkYnmD3vFyfW39/ocvVWM7nU8BPMK/qODYyvh8=;
        b=ydRnl8Xg/gROqTrbi5eKbOAtExq8yMqnxPghu/+JUx6zWm/EMX84LDaHuYuSysDLVA
         FxZpXJp38rqRPYvvJwdBcgXX8C+6Hfp0YNq6YYFmryXLh8zy64HwdZE3hZAtON1O3T8j
         HGbQCzs95VDrSH75f6Jx7z1uFxHsA54QpvPbpRNhz4L0bY5PorKUSpKI4D1eIOxRo0gY
         oyDzLaQTqSsn84o3Q290eqzA9vVpYNsJmZ4lQY6tdxyMXzrHNnYtRyRHQ+YcEl5Hc0bb
         GK7LiYw4lYlll74+0g3OXPERQApDGCVLKatX8+nKVxRhnehRc0MO8sjU1AyTqCkp0wEI
         7jnA==
X-Gm-Message-State: AOAM533+XAIT7ZZL+i4ggSe29u6VfHD7F7kEIZ88pel9dYR8pllT5Gih
        174XZjKUHddqXPsLlMtNsjQ=
X-Google-Smtp-Source: ABdhPJzrp7a+QZQZBvOQ9K4wMfOD06mpxAMbDqD7iBR8d2CewHfR+jMUyE8rq8YfVzPGPaAMESXSuA==
X-Received: by 2002:a05:600c:2744:b0:38e:b6f7:d548 with SMTP id 4-20020a05600c274400b0038eb6f7d548mr5462162wmw.49.1649791528498;
        Tue, 12 Apr 2022 12:25:28 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c7401000000b0038ed3bb00c9sm244595wmc.6.2022.04.12.12.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:25:27 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Tue, 12 Apr 2022 21:25:26 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Bryan Schumaker <bjschuma@netapp.com>,
        Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH] nfs-utils: nfsidmap.man: Fix section number
Message-ID: <YlXSJspEFVtBvJk0@eldamar.lan>
References: <20220412070016.720489-1-carnil@debian.org>
 <f9ec727f-e616-4af8-ac09-2d0fd1f2ae0a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ec727f-e616-4af8-ac09-2d0fd1f2ae0a@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

On Tue, Apr 12, 2022 at 10:28:50AM -0400, Steve Dickson wrote:
> Hello,
> 
> On 4/12/22 3:00 AM, Salvatore Bonaccorso wrote:
> 
> My mailer was unable to process the attachment
> Please in-line the patch and resend it.

That is very strange, I used git send-email to submit it, and I do not
see where it got mangled, as it is present as well in

https://lore.kernel.org/linux-nfs/20220412070016.720489-1-carnil@debian.org/

Any idea what happened?

Here it is again, inlined in this message.

Regards,
Salvatore

From da390ced58885b0ed80be3722d4d913909e7c543 Mon Sep 17 00:00:00 2001
From: Ben Hutchings <benh@debian.org>
Date: Mon, 14 Mar 2022 00:19:33 +0100
Subject: [PATCH] nfsidmap.man: Fix section number

The nfsidmap manual page is supposed to be in section 8, but calls the
.TH macro with a section argument of 5.  This results in an incorrect
header and causes debhelper (in Debian) to install it in the section 5
directory. Fix that.

Signed-off-by: Ben Hutchings <benh@debian.org>
[Salvatore Bonaccorso: Slightly modify commit message to mention that
the Problem is found in Debian through installing the manpage via
debhelper]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 utils/nfsidmap/nfsidmap.man | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/nfsidmap/nfsidmap.man b/utils/nfsidmap/nfsidmap.man
index 2af16f3157ff..1911c41be6f9 100644
--- a/utils/nfsidmap/nfsidmap.man
+++ b/utils/nfsidmap/nfsidmap.man
@@ -2,7 +2,7 @@
 .\"@(#)nfsidmap(8) - The NFS idmapper upcall program
 .\"
 .\" Copyright (C) 2010 Bryan Schumaker <bjschuma@netapp.com>
-.TH nfsidmap 5 "1 October 2010"
+.TH nfsidmap 8 "1 October 2010"
 .SH NAME
 nfsidmap \- The NFS idmapper upcall program
 .SH SYNOPSIS
-- 
2.35.1

