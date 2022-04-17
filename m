Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE96504710
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Apr 2022 10:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiDQIYc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Apr 2022 04:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiDQIYb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Apr 2022 04:24:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413F33A715
        for <linux-nfs@vger.kernel.org>; Sun, 17 Apr 2022 01:21:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c6so14494771edn.8
        for <linux-nfs@vger.kernel.org>; Sun, 17 Apr 2022 01:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uJBTXx8OmnCmlzbMxKp0GKjgPbO3h19C+nKu0MjHcbA=;
        b=iVgr6qyXOgH1Obco8oo367olbotQPmriExW9UFQPjShJmEpFY7v1yZ6X2PRNyr5V6E
         Vh4HbKMfvsP83WcrjvgUmGKYzl01oOMwlaG20bbMxa9QI4v6cx6W2UqQqG5OaHgQoDYp
         veumu/cuTObKM86dzZmRmag4N+lW36Q9P/AHIqYIVTAkU+ElivOX1xYMc7Iiz/X0iB24
         eK9VVivtQd1BRcDI0XPOcF3rTPVcG7fHjVgr/BkSguJJn8XCaxPCtc7hJPNoo12lYwsA
         ogVBH77POh70JYiCXpDL1vGvrPUCqDE2FZf3GoJlqPi0zZByooNfi8/RHt9SxxX3FLYD
         cyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uJBTXx8OmnCmlzbMxKp0GKjgPbO3h19C+nKu0MjHcbA=;
        b=KnOfFF5a+Q6yDZpBI3QkYsPB6qGIlF+ionSoY07jjdVtGf3+NqjHK2kpclmraSayH0
         tLhvZQ9LdYsQvMuc8dHyuVOJm9F6Jz/d9EXX0/AwnB6EE3pCl2RsRhgPsyTsMqvi+SJu
         t7j14+qsQH9VWa3jgn4bOwcv/+naSEV3y2MuiNhRQ9HPCh3ECMV9Hui3qal5mqqCNq+E
         OeIkGJxjkQSghbY2dqLSPDb3mIWoiDCcSXBz3YExYrzoLOseQ4pFCL2N7T6+UhZqfsJJ
         XkdA/Q91s3VcyWeJ09CgP1abPVrCsU+al3ysIbjzE6LPhS+eL8JqPaXgk8zGyhSBpBDJ
         eQTA==
X-Gm-Message-State: AOAM5325f4QqLJniKRPZ3rzhBdkYc7KoRNtGdyVWrWzHGvxNLIBAJZq+
        VCz8KokLFfEuJv44XULM4dF+fffkVFMykA==
X-Google-Smtp-Source: ABdhPJwe4Ku2JnRVsDONA/0xjrEoabKa9yLsv2rBMcFhvmmoS3vwBMXxG6/I22GxyHuJhLhV8a9nIQ==
X-Received: by 2002:a50:ec94:0:b0:41d:9a7a:65fd with SMTP id e20-20020a50ec94000000b0041d9a7a65fdmr6991821edr.284.1650183713759;
        Sun, 17 Apr 2022 01:21:53 -0700 (PDT)
Received: from eldamar (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id cb25-20020a170906a45900b006e87e5f9c4asm3414053ejb.140.2022.04.17.01.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 01:21:52 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sun, 17 Apr 2022 10:21:51 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Bryan Schumaker <bjschuma@netapp.com>,
        Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH] nfs-utils: nfsidmap.man: Fix section number
Message-ID: <YlvOH5CA+Bvl5yQC@eldamar.lan>
References: <20220412070016.720489-1-carnil@debian.org>
 <f9ec727f-e616-4af8-ac09-2d0fd1f2ae0a@redhat.com>
 <YlXSJspEFVtBvJk0@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlXSJspEFVtBvJk0@eldamar.lan>
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

On Tue, Apr 12, 2022 at 09:25:28PM +0200, Salvatore Bonaccorso wrote:
> Hi Steve,
> 
> On Tue, Apr 12, 2022 at 10:28:50AM -0400, Steve Dickson wrote:
> > Hello,
> > 
> > On 4/12/22 3:00 AM, Salvatore Bonaccorso wrote:
> > 
> > My mailer was unable to process the attachment
> > Please in-line the patch and resend it.
> 
> That is very strange, I used git send-email to submit it, and I do not
> see where it got mangled, as it is present as well in
> 
> https://lore.kernel.org/linux-nfs/20220412070016.720489-1-carnil@debian.org/
> 
> Any idea what happened?
> 
> Here it is again, inlined in this message.
> 
> Regards,
> Salvatore
> 
> From da390ced58885b0ed80be3722d4d913909e7c543 Mon Sep 17 00:00:00 2001
> From: Ben Hutchings <benh@debian.org>
> Date: Mon, 14 Mar 2022 00:19:33 +0100
> Subject: [PATCH] nfsidmap.man: Fix section number
> 
> The nfsidmap manual page is supposed to be in section 8, but calls the
> .TH macro with a section argument of 5.  This results in an incorrect
> header and causes debhelper (in Debian) to install it in the section 5
> directory. Fix that.
> 
> Signed-off-by: Ben Hutchings <benh@debian.org>
> [Salvatore Bonaccorso: Slightly modify commit message to mention that
> the Problem is found in Debian through installing the manpage via
> debhelper]
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  utils/nfsidmap/nfsidmap.man | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/nfsidmap/nfsidmap.man b/utils/nfsidmap/nfsidmap.man
> index 2af16f3157ff..1911c41be6f9 100644
> --- a/utils/nfsidmap/nfsidmap.man
> +++ b/utils/nfsidmap/nfsidmap.man
> @@ -2,7 +2,7 @@
>  .\"@(#)nfsidmap(8) - The NFS idmapper upcall program
>  .\"
>  .\" Copyright (C) 2010 Bryan Schumaker <bjschuma@netapp.com>
> -.TH nfsidmap 5 "1 October 2010"
> +.TH nfsidmap 8 "1 October 2010"
>  .SH NAME
>  nfsidmap \- The NFS idmapper upcall program
>  .SH SYNOPSIS
> -- 
> 2.35.1

Was this version now correctly processed by your mailer?

Regards,
Salvatore
