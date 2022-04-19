Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34FA507A89
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Apr 2022 21:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbiDST7B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Apr 2022 15:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbiDST7A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Apr 2022 15:59:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E81F26562
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 12:56:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u3so23897469wrg.3
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BJ1t1/kNntgUuD3efr/7SKOKpx6bEKehZyOENyPE/oo=;
        b=DQ2sTR2L0pvXXl0gI9V/HRvgLH8N+LSZb5TJg2cnHz0HM6WZdpwtb+Iz/P8/UFlmQ+
         q1nktunLfFd1mI8JLtvq+X6SHrambJmyNOP3RNpwe+f79BrIqyFoF/IzZ5j9VBVJ2s8b
         /zjxBuprM5PjNWCVZugjwVMf5jybjSzhVGaP/0/vlyJo1qNi/IyXTs6R1Ql0ZtdFJyK3
         rdcywSeCI0yKgw4MYZF9iAtBDKzH65pnEsgjHbRN0/pi99VMUnGTU0UZzsMaw77a9Fu9
         GpUf+16g+AeoeRtwxEzBQBm1iKOopDVZhFV4Dp4C06tXs+2btIkfdlB33E0FQt54Ah4J
         dPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BJ1t1/kNntgUuD3efr/7SKOKpx6bEKehZyOENyPE/oo=;
        b=ds45zTW4LpyNh9DHWJCdJZDPXhEMEVR0ftogF47IhRZoE9tLwAMmCtKdUdXoS1qFBw
         Z/fy7tMBG8Gv4yeUeNuiRkk/Bd2b3EzKo1y5ergJzbPxHtNURNVf3IKwWB2/EY2+G2Al
         ReSMWHNh2XSCx3ObQXtHwtQAyHHGJ3MncTq/0UHVhLVPzUpGkbzstEWD1JLrBl5FC0+a
         lg18fL/tJiMr3bHzyzokJ16uRHGbnJtzcAYy8oUFTez7oFsmXspy3qjgumHRmSVQoy7M
         7sgRA+P48Qt9adykHhl6eMQs0Hb4K5b6T9IL8A++6v1gouaOtHAN3EjF9OuimyavADHZ
         KnOw==
X-Gm-Message-State: AOAM532Iu8mVCOhDbpmPBC+51xBjsdBw/czjPELTTthtl5RBTRMlPu7o
        T9BKx0NA02vrZwppi3wbPXQ=
X-Google-Smtp-Source: ABdhPJxC5CEiNYpwhbT+Qilwv7xHA5oU6gnWbdD9t4X/oi0ax6SQJgURoOlV00Tl7NI4PE5bcsDu1A==
X-Received: by 2002:a5d:4384:0:b0:20a:953a:4681 with SMTP id i4-20020a5d4384000000b0020a953a4681mr8856470wrq.266.1650398174473;
        Tue, 19 Apr 2022 12:56:14 -0700 (PDT)
Received: from eldamar (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm19605651wmc.7.2022.04.19.12.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 12:56:14 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Tue, 19 Apr 2022 21:56:13 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Bryan Schumaker <bjschuma@netapp.com>,
        Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH] nfs-utils: nfsidmap.man: Fix section number
Message-ID: <Yl8T3Y5adggNfwa2@eldamar.lan>
References: <20220412070016.720489-1-carnil@debian.org>
 <f9ec727f-e616-4af8-ac09-2d0fd1f2ae0a@redhat.com>
 <YlXSJspEFVtBvJk0@eldamar.lan>
 <YlvOH5CA+Bvl5yQC@eldamar.lan>
 <af22ce3e-2cc0-b32a-87da-204360cd1b4a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af22ce3e-2cc0-b32a-87da-204360cd1b4a@redhat.com>
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

On Tue, Apr 19, 2022 at 03:17:45PM -0400, Steve Dickson wrote:
> Hey!
> 
> Sorry for the delay...
> 
> On 4/17/22 4:21 AM, Salvatore Bonaccorso wrote:
> > Hi Steve,
> > 
> > On Tue, Apr 12, 2022 at 09:25:28PM +0200, Salvatore Bonaccorso wrote:
> > > Hi Steve,
> > > 
> > > On Tue, Apr 12, 2022 at 10:28:50AM -0400, Steve Dickson wrote:
> > > > Hello,
> > > > 
> > > > On 4/12/22 3:00 AM, Salvatore Bonaccorso wrote:
> > > > 
> > > > My mailer was unable to process the attachment
> > > > Please in-line the patch and resend it.
> > > 
> > > That is very strange, I used git send-email to submit it, and I do not
> > > see where it got mangled, as it is present as well in
> > > 
> > > https://lore.kernel.org/linux-nfs/20220412070016.720489-1-carnil@debian.org/
> > > 
> > > Any idea what happened?
> > > 
> > > Here it is again, inlined in this message.
> > > 
> > > Regards,
> > > Salvatore
> > > 
> > >  From da390ced58885b0ed80be3722d4d913909e7c543 Mon Sep 17 00:00:00 2001
> > > From: Ben Hutchings <benh@debian.org>
> > > Date: Mon, 14 Mar 2022 00:19:33 +0100
> > > Subject: [PATCH] nfsidmap.man: Fix section number
> > > 
> > > The nfsidmap manual page is supposed to be in section 8, but calls the
> > > .TH macro with a section argument of 5.  This results in an incorrect
> > > header and causes debhelper (in Debian) to install it in the section 5
> > > directory. Fix that.
> > > 
> > > Signed-off-by: Ben Hutchings <benh@debian.org>
> > > [Salvatore Bonaccorso: Slightly modify commit message to mention that
> > > the Problem is found in Debian through installing the manpage via
> > > debhelper]
> > > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> > > ---
> > >   utils/nfsidmap/nfsidmap.man | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/utils/nfsidmap/nfsidmap.man b/utils/nfsidmap/nfsidmap.man
> > > index 2af16f3157ff..1911c41be6f9 100644
> > > --- a/utils/nfsidmap/nfsidmap.man
> > > +++ b/utils/nfsidmap/nfsidmap.man
> > > @@ -2,7 +2,7 @@
> > >   .\"@(#)nfsidmap(8) - The NFS idmapper upcall program
> > >   .\"
> > >   .\" Copyright (C) 2010 Bryan Schumaker <bjschuma@netapp.com>
> > > -.TH nfsidmap 5 "1 October 2010"
> > > +.TH nfsidmap 8 "1 October 2010"
> > >   .SH NAME
> > >   nfsidmap \- The NFS idmapper upcall program
> > >   .SH SYNOPSIS
> > > -- 
> > > 2.35.1
> > 
> > Was this version now correctly processed by your mailer?
> Yeah I got it... thanks... but...
> Are you saying that this man page should be in chapter 5
> or it is fact Debian installs into chapter 5?
> 
> In RHEL and Fedora we install it in chapter 8... If it
> belongs in a different chapter I have no problem changing
> it... I just need to know why.

Apologies, so this was apparently not very clear. That it belongs into
section 8 is right. Debian installed it into the wrong section because
the section in the manpage itself refers to 5. This is what the patch
tries to inline, and fix the wrong argument to the .TH macro.

Because the manpage incorrectly calls the .TH macro with a section
argument of 5 the debhelper program in Debian installs the manpage
into section 5.

Does this clarifies?

Regards,
Salvatore
