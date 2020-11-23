Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6293C2C12BF
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 19:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgKWR75 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 12:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgKWR74 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 12:59:56 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71157C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 09:59:56 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k1so5100856eds.13
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 09:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HztncPfF704t+eeN0sTPh0NpfCj1j7x/JtQpeDiRkY=;
        b=QE6y5wFOroThChJJdnw7HiW3pawzaF8Md7YjoLhcoS5z/pjnZqrovUvQuO2uASK+9Y
         kde+xEFc8mbxtoS1TZ0B9FrTINwqWhhyCKWUWl1T25Beevm3F6n9naEYm/O26+L6Q+rn
         5VM3WOdqWQTB32uT4fM/19d2CjmHpr0HOjgqztUuGs6i+TqUGdOU0k0B92TT2z8Cp1tf
         ePR92gV0uVbby7GUULgOtH8fCWCJp9DyVPj6QCxghwl572kjplPMLK1bm708cdCyrlS3
         BLLKF4Fu2Dywv+ipHz3tz9ey062GgkRQS5fp5PpKCkMCWgbJvdb5pug67hEiwAkq29CQ
         QI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HztncPfF704t+eeN0sTPh0NpfCj1j7x/JtQpeDiRkY=;
        b=VoJCvztS9BgSx1SoTJUoDVR2/Wb9jdBG71bCuWvlePosxIC4YJsGKutY4MJCbnyEIS
         dzcDyzCq3Nk75sRjLKPybakpodnt7zDVlqAwQYJD7JGDOqvYopiq9gZB5TVbRj5zdCIV
         T72QICDVz7MuNIhrSV+D+rRWewV/txP/Q2YT93DcuY8HNyGV+2g+RiUsF9XB+n8vCfN7
         mOM5tO179TuNSxYjAVB3bDgTsIdaf+0jtYQf7uXyQmlGo6noRFvZ6ahUfYSgygY3UQyU
         nq/9FN1H5FvPnC3yOrWeLeB94LiSR4KTLaynk55Pl7WmK+Zj0HOn+aVDYHL5nFc5d3mE
         xAbg==
X-Gm-Message-State: AOAM532enlYDIoLRXLPU89L6NBUdy5VKTdKN5kPAt0NsmlDVM5ezp0Hy
        Zf0oqPJpoxOss7/txbvvTzAoAQiFTEWmS9Zf0kbotLNC
X-Google-Smtp-Source: ABdhPJwfXLPX9n3gKrR7HAXRbZyra9JQSo1WPPlHMyG4RcFgptDu48lF6Jg6rsC0rBpseoRVlneZfINiyhdBk8oRP5U=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr389384edm.28.1606154395113;
 Mon, 23 Nov 2020 09:59:55 -0800 (PST)
MIME-Version: 1.0
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com> <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com> <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com> <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
 <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com> <4687FA42-6294-418D-9835-EDE809997AE3@oracle.com>
In-Reply-To: <4687FA42-6294-418D-9835-EDE809997AE3@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 23 Nov 2020 12:59:43 -0500
Message-ID: <CAN-5tyEd8iDfEW0WsXyPsoM73tUSAXQgyhAfRbRbRZCem_cwPw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 23, 2020 at 12:37 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Nov 23, 2020, at 11:42 AM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > Hi Frank, Chuck,
> >
> > I would like your option on how LISTXATTR is supposed to work over
> > RDMA. Here's my current understanding of why the listxattr is not
> > working over the RDMA.
> >
> > This happens when the listxattr is called with a very small buffer
> > size which RDMA wants to send an inline request. I really dont
> > understand why, Chuck, you are not seeing any problems with hardware
> > as far as I can tell it would have the same problem because the inline
> > threshold size would still make this size inline.
> > rcprdma_inline_fixup() is trying to write to pages that don't exist.
> >
> > When LISTXATTR sets this flag XDRBUF_SPARSE_PAGES there is code that
> > will allocate pages in xs_alloc_sparse_pages() but this is ONLY for
> > TCP. RDMA doesn't have anything like that.
> >
> > Question: Should there be code added to RDMA that will do something
> > similar when it sees that flag set?
>
> Isn't the logic in rpcrdma_convert_iovs() allocating those pages?

No, rpcrdm_convert_iovs is only called for when you have reply chunks,
lists etc but not for the inline messages. What am I missing?


> > Or, should LISTXATTR be re-written
> > to be like READDIR which allocates pages before calling the code.
>
> AIUI READDIR reads into the directory inode's page cache. I recall
> that Frank couldn't do that for LISTXATTR because there's no
> similar page cache associated with the xattr listing.
>
> That said, I would prefer that the *XATTR procedures directly
> allocate pages instead of relying on SPARSE_PAGES, which is a hack
> IMO. I think it would have to use alloc_page() for that, and then
> ensure those pages are released when the call has completed.
>
> I'm not convinced this is the cause of the problem you're seeing,
> though.
>
> --
> Chuck Lever
>
>
>
