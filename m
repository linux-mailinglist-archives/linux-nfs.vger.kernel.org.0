Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E6F7E1F54
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Nov 2023 12:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjKFLGJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Nov 2023 06:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLGI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Nov 2023 06:06:08 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D443BD
        for <linux-nfs@vger.kernel.org>; Mon,  6 Nov 2023 03:06:02 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7b91faf40so50416507b3.1
        for <linux-nfs@vger.kernel.org>; Mon, 06 Nov 2023 03:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1699268761; x=1699873561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8eQFXRz1+eVeUVTUJbNVUI35xFRyhK0H616uICMypvQ=;
        b=DkHktdPSwusYLs811mHNm0ojqwUgnrwDMOl5SMFj0sTjgK0QlC5VpV38IiLeS18YaV
         7l+lvftEFKJRdFHr/zkQCaGo66014I+YMZ77M8/8PtGlTEkKh6zGQIemeC4NML0BR7vD
         p2TWfwd5O8kXjrDEf6G20NOsEB+dHO8JFiCE7AwAzcXZNvBbdOkan+Y1yGuFDMuufao/
         ajDC9qEb4WxR5akJ8hhv9K0iO4AEXfCU4ccbQhwJ89aHRhobofpDPJ9BZMiKakfgeGfw
         /TwL/NJsx97ZC94j9MfieMy9Kyhj2mCvochsU0eD1uYhVeaTDq4AaV6w3hRq94qlijhc
         Kf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699268761; x=1699873561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eQFXRz1+eVeUVTUJbNVUI35xFRyhK0H616uICMypvQ=;
        b=eJg/PTzvUpYzXypZ4zpKK3DNGz2Vb+YL9z6qqaGpDEQBYSUqzBLCxrnvD2kD3X3Tkg
         Cep5i02tPUqhZ+mGRr/CDHDLuZi25li6qp2CfQoc1jyizQf5iNX2/zIm7Fp8sdJq9W44
         HPZnRZt71MnebNupHf9psbgpSDpOSgxFFOow8BKkpPXPJ0BZp4GaZImOVwB7Q7iLh0FX
         SYqXai0dlusOegyli/Q0ibATWSMPWtCCRgYv5NxD+zBAPaQOkoQMQjbtSfvzihofUqWd
         sYHGKwzrwWZLOQZXT5DqVbrGf3zkCzV7JAAHINaNaXgsoJGg7UASF8dH1VgDrED02R9W
         g1Tg==
X-Gm-Message-State: AOJu0YwFmNb+viV3z7fKpnw+LZ2kEYBq95ezLNPFxjpPZKWr7/xBO5Io
        xHbaFJkhDKGogIq2NOdppcG1rzD/CxH9ZjpAJPTQzA==
X-Google-Smtp-Source: AGHT+IE9DdV8iOIkYb9W2P8pTvIS1a446QZ1sdtujw1ecGskNEqrDzyo/haVtqjkLdXyAtoYrvu5NBp9w99wnRL8noY=
X-Received: by 2002:a81:9b11:0:b0:59b:f18b:efa0 with SMTP id
 s17-20020a819b11000000b0059bf18befa0mr8842738ywg.36.1699268761443; Mon, 06
 Nov 2023 03:06:01 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGNPSi-+3WdeMsOjkJ2vOqZcRE2S6i=eqi+UA2RmzywAyg@mail.gmail.com>
 <ZUT_W8yoJ5wqSvLv@debian.me>
In-Reply-To: <ZUT_W8yoJ5wqSvLv@debian.me>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 6 Nov 2023 11:05:25 +0000
Message-ID: <CAPt2mGNYQwd6S90NXU8p+SDufCUmTLqKQb8MuB+s-hr=1g3uJw@mail.gmail.com>
Subject: Re: autofs mount/umount hangs with recent kernel?
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux NFS <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 3 Nov 2023 at 14:10, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Fri, Nov 03, 2023 at 09:40:44AM +0000, Daire Byrne wrote:
> > Hi,
> >
> > We have large compute clusters that, amongst other things, spend their
> > day mounting & unounting lots of Linux NFS servers via autofs. This
> > has worked fine for many years and client kernel versions and was
> > working without incident even with our current v6.3.x production
> > kernels.
> >
> > During the v6.6-rc cycle while testing that kernel, I noticed that
> > every now and then, the umount/mount would hang randomly and the
> > compute host would get stuck and not complete it's work until a
> > reboot. I thought I'd wait until v6.6 was released and check again -
> > the issue persists.
> >
> > I have not had the opportunity to test the v6.4 & v6.5 kernels in
> > between yet. The stack traces look something like this:
>
> Please do bisection to find the exact commit that introduces your
> regression. See Documentation/admin-guide/bug-bisect.rst in the kernel
> sources for more information.

I tested the v6.5.10 kernel and I can't reproduce with that, so I
guess I'll start the process of bisecting between v6.5.10 & v6.6.

It takes around 24 hours and 72 client hosts until we see it happen on
at least one, so it'll be slow going.

Weirdly, I also have the v6.6 kernel running on a different set of
hosts and they have not shown the problem at all. The only difference
being AMD clients with higher process concurrency = bad, and Intel
clients with less process concurrency = okay.

> >
> > [202752.264187] INFO: task umount.nfs:58118 blocked for more than 245 seconds.
> > [202752.264237]       Tainted: G            E      6.6.0-1.dneg.x86_64 #1
>
> Can you reproduce on untainted (vanilla) kernel?

Yea, I'm not sure what is going on there. Some compile issue as it's
the "deflate" module complaining about a missing key.

> > And like I said, the mount/umount against the server hangs
> > indefinitely on the client. It is somewhat interesting that autofs
> > still tries to trigger a subsequent mount even though the umount has
> > not completed.
> >
> > The NFS servers are running RHEL8.5 and we are using NFSv3. I also
> > reproduced it with a fairly recent nfs-utils-2.6.2 on the client
> > compute hosts.
>
> What distro on the client?

It's EL79 on the client but I have updated the nfs-utils to something
more modern. I have not updated the autofs package though.

I'll report back in a week or so...

Cheers,

Daire
