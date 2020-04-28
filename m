Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5C21BCD96
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2020 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgD1Ukz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 16:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD1Ukz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Apr 2020 16:40:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1871CC03C1AB
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 13:40:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d16so45913edq.7
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 13:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1e/+0rJu6sttOCE71vF3BjLvRarQVAfjIsm/LFNOa9w=;
        b=EPXd0on1Ihro4GG0qsWkp8SnWvI5a0rW/THa5Bz96SW3FrnEZkKdXnd2ePH5cgcIkC
         BROY/710IVUCRN6bIGMKno/Dg1n7Hu+9hPrjWMYPt84TQlKshjZdjTA3a7kB2XldCT2Q
         fW18qbeqCSbPxMhKj/aSL/nENfxyCfyFMxiKT8pvOasdXv8mmrU5pLKLjOuEBPxjrHag
         NuMP5A3f8f359JK+B8JrTBA45dfCnBD9DozW25gCaqaN6o62k48qPMuJ76KpEV5sFsNo
         RnI8tAMg96IkCFGOpigCAq+NMiLOE0FrqELIQpLQMRDkYj9j+cI6SfzeO/dPplFn2zBK
         A5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1e/+0rJu6sttOCE71vF3BjLvRarQVAfjIsm/LFNOa9w=;
        b=PbxHfvitzYaWDB8OozqKGFte8mtFYO29u7UzLXyCE9EFEfpbrAF+IgztXyXUaF+kX3
         wux6qUZz2eRAXuhtoLttoitekP1QqVWoTzV8tm1+FUKnvhui2dvzrzH7/IxPwimFM7aI
         BMQyS42+EAiJH9buoIXKeSkcGRNYBRoBDtaKqH92eMl9PTuYFUfviLSyvfH47X8wowyv
         uN3SNgZP2OCT9NSlEJHoXmLS2fdE5MsPrT4wLeJRWo6vf7zgCszqi8FVmmKfrizRAhkI
         6Mywp36x/NHTayK19pwy95OEU4OXVJa/2pMZAkb55EI9270Ji9HTCFpkWwhuBQ9In89L
         HVEw==
X-Gm-Message-State: AGi0Pua6Wxj0Ux4X9LiioU4FRLJ1M4ZEqsJHOyDpcgDyZFAQ2Ffbcz3I
        6SqVV3cd7L6mXrbvNZiiCuVUcnFpxjptYuQYGrUI3h8m
X-Google-Smtp-Source: APiQypIdgQ0wj57RDeDD9/5dB1pns37+k+TedIC1UeK1+niLokxrwc4eKnVq8VZ5UBhfjBos5CJLoX7qRD35FQk9fR0=
X-Received: by 2002:aa7:d1cc:: with SMTP id g12mr24738564edp.84.1588106453546;
 Tue, 28 Apr 2020 13:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
 <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
In-Reply-To: <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 28 Apr 2020 16:40:42 -0400
Message-ID: <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 28, 2020 at 2:47 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Hi Olga,
>
> On Tue, 2020-04-28 at 14:14 -0400, Olga Kornievskaia wrote:
> > Hi folk,
> >
> > Looking for guidance on what folks think. A client is sending a LINK
> > operation to the server. This compound after the LINK has RESTOREFH
> > and GETATTR. Server returns SERVER_FAULT to on RESTOREFH. But LINK is
> > done successfully. Client still fails the system call with EIO. We
> > have a hardline and "ln" saying hardlink failed.
> >
> > Should the client not fail the system call in this case? The fact
> > that
> > we couldn't get up-to-date attributes don't seem like the reason to
> > fail the system call?
> >
> > Thank you.
>
> I don't really see this as worth fixing on the client. It is very
> clearly a server bug.

Why is that a server bug? A server can legitimately have an issue
trying to execute an operation (RESTOREFH) and legitimately returning
an error.

NFS client also ignores errors of the returning GETATTR after the
RESTOREFH. So I'm not sure why we are then not ignoring errors (or
some errors) of the RESTOREFH.


> Thanks
>   Trond
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
