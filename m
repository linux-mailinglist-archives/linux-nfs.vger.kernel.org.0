Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4433D3376AD
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Mar 2021 16:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhCKPQt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Mar 2021 10:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhCKPQp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Mar 2021 10:16:45 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCABBC061574
        for <linux-nfs@vger.kernel.org>; Thu, 11 Mar 2021 07:16:44 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ci14so46791357ejc.7
        for <linux-nfs@vger.kernel.org>; Thu, 11 Mar 2021 07:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iS35RINPwek9sYrmwIdtdev4hQvrv6SYs3iEezhdbCQ=;
        b=m1qgdwrhLNEzS88Pzq8Ohk5JANyl+TKKr/Yfs8gvxaIStF0Cjth5rqkFH3B5NMXCaU
         Xn5r83eZSOssYA9K447CZVBZ8xujafbWSmEaxc1twdkqEQCHlIWXhp+dM0THFmrItPZ7
         NpMQsbsOiklHtzQVn6esYTILZNpprFevMZwSLql9pL9NiSeDzR243awFLfwGRuR/hWYP
         JpVGwMm9lT5cFYQjfTL3iKizIFQWCbzK0l6S2AItnrCuZ1gPF4zSW29NdlI7PyYRiPdR
         jiZSBCsZgSKmGT1gNalu7vru+f/UnDBiN/jlpIr7miBVB4CYGQVObBYiGlstklalVDwM
         ILcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iS35RINPwek9sYrmwIdtdev4hQvrv6SYs3iEezhdbCQ=;
        b=QK0Cy0oWxrXDCb2hpL7r5c6rX7qroB74TQUdZpAyN4D/2UHYEvrSAZerpK5BY1AMBb
         sSftw04lnbXexHY2InxvmKWut+guqthUsxfKGco4jbKwGylHYTjZ1B2BQK47TG4/1KKU
         5YJ0WPP1i2KEd++1GLfNOMmgI1nhwBR5YlmxNOUzQnvQynqNs0VXlqmNn4duNWhJMmJY
         rgXZN5UO3LjBqphZqnFlA7UnhtTj1LzX/saraqCQR7dx3jkeb1jE1QyCKUH3DrjFcL8M
         mR1jRHgjAtWEPexabQO7aZnd8/HkAz/grLMj1xdtAOGiNvkXXuC4EfWfRo4UR8pzD1Fg
         yYCw==
X-Gm-Message-State: AOAM532tTZrDwV5MvBcX0z93qswS8xHnGAGCtbuo9a1m5KrmsQf7RSGQ
        //WjvkFGf4cYz3nxFlFE86chZpdR4AtcIfAvGUw=
X-Google-Smtp-Source: ABdhPJy0wiVfyXrbzJbvNYpXQKI/XyiqigeP/X7yJXTReGJitCh/6Vk1iCvQssOtEx8ynJThRtl8VnLjkQkzHsht960=
X-Received: by 2002:a17:906:b20b:: with SMTP id p11mr3621106ejz.0.1615475803469;
 Thu, 11 Mar 2021 07:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
 <YEeWK+gs4c8O7k0u@pick.fieldses.org> <4ca27c770577376b0a39f0cfcfb529b96d6d5aae.camel@hammerspace.com>
 <CAN-5tyFttTHRdnELORJwCER_KPGBNk4W3eLwG0Z=QkwmPQh1UQ@mail.gmail.com>
 <d205a6a77273534666b3c33065934b9f66e7b103.camel@hammerspace.com>
 <YEjb9ZadFqa9Vu9O@pick.fieldses.org> <CAN-5tyFZ8fS6fjOJEu2NkRYUX6HrA5XNKPWyWN+UVtQT6Gp4kQ@mail.gmail.com>
 <2BAF1E3E-6FDB-46FF-8A63-0CA7EE5B6535@oracle.com>
In-Reply-To: <2BAF1E3E-6FDB-46FF-8A63-0CA7EE5B6535@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 11 Mar 2021 10:16:32 -0500
Message-ID: <CAN-5tyEV0+DDgjXsfdiVhpeVNOprOmYQf24CdOCr+fayOmR3Bw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 11, 2021 at 10:10 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Mar 10, 2021, at 5:09 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > On Wed, Mar 10, 2021 at 9:47 AM J. Bruce Fields <bfields@redhat.com> wrote:
> >>
> >> On Tue, Mar 09, 2021 at 08:59:51PM +0000, Trond Myklebust wrote:
> >>> On Tue, 2021-03-09 at 15:41 -0500, Olga Kornievskaia wrote:
> >>>> On Tue, Mar 9, 2021 at 3:22 PM Trond Myklebust <
> >>>> trondmy@hammerspace.com> wrote:
> >>>>>
> >>>>> On Tue, 2021-03-09 at 10:37 -0500, J. Bruce Fields wrote:
> >>>>>> On Tue, Mar 09, 2021 at 09:41:27AM -0500, Olga Kornievskaia
> >>>>>> wrote:
> >>>>>>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>>>>>
> >>>>>>> When the server tries to do a callback and a client fails it
> >>>>>>> due to
> >>>>>>> authentication problems, we need the server to set callback
> >>>>>>> down
> >>>>>>> flag in RENEW so that client can recover.
> >>>>>>
> >>>>>> I was looking at this.  It looks to me like this should really be
> >>>>>> just:
> >>>>>>
> >>>>>>        case 1:
> >>>>>>                if (task->tk_status)
> >>>>>>                        nfsd4_mark_cb_down(clp, task->tk_status);
> >>>>>>
> >>>>>> If tk_status showed an error, and the ->done method doesn't
> >>>>>> return 0
> >>>>>> to
> >>>>>> tell us it something worth retrying, then the callback failed
> >>>>>> permanently, so we should mark the callback path down, regardless
> >>>>>> of
> >>>>>> the
> >>>>>> exact error.
> >>>>>
> >>>>> I disagree. task->tk_status could be an unhandled NFSv4 error (see
> >>>>> nfsd4_cb_recall_done()). The client might, for instance, be in the
> >>>>> process of returning the delegation being recalled. Why should that
> >>>>> result in the callback channel being marked as down?
> >>>>>
> >>>>
> >>>> Are you talking about say the connection going down and server should
> >>>> just reconnect instead of recovering the callback channel. I assumed
> >>>> that connection break is something that's not  recoverable by the
> >>>> callback but perhaps I'm wrong.
> >>>
> >>> No. I'm saying that nfsd4_cb_recall_done() will return a value of '1'
> >>> for both task->tk_status == -EBADHANDLE and -NFS4ERR_BAD_STATEID. I'm
> >>> not seeing why either of those errors should be handled by marking the
> >>> callback channel as being down.
> >>>
> >>> Looking further, it seems that the same function will also return '1'
> >>> without checking the value of task->tk_status if the delegation has
> >>> been revoked or returned. So that would mean that even NFS4ERR_DELAY
> >>> could trigger the call to nfsd4_mark_cb_down() with the above change.
> >>
> >> Yeah, OK, that's wrong, apologies.
> >>
> >> I'm just a little worried about the attempt to enumerate transport level
> >> errors in nfsd4_cb_done().  Are we sure that EIO, ETIMEDOUT, EACCESS is
> >> the right list?
> >
> > Looking at call_transmit_status error handling, I don't think
> > connection errors are returned. Instead the code tries to fix the
> > connection by retrying unless the rpc_timeout is reached and then only
> > EIO,TIMEDOUT is returned.
> >
> > Can then my original patch be considered without resubmission?
>
> Bruce has authorized v1 of this patch, but that one has the
> uncorrected patch description. Post a v4?

v1's description is accurate. It reflects that only authentication
errors are handled.

>
>
>
> >> --b.
> >>
> >>>
> >>>>
> >>>>>>
> >>>>>> --b.
> >>>>>>
> >>>>>>>
> >>>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>>>>>> ---
> >>>>>>> fs/nfsd/nfs4callback.c | 1 +
> >>>>>>> 1 file changed, 1 insertion(+)
> >>>>>>>
> >>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> >>>>>>> index 052be5bf9ef5..7325592b456e 100644
> >>>>>>> --- a/fs/nfsd/nfs4callback.c
> >>>>>>> +++ b/fs/nfsd/nfs4callback.c
> >>>>>>> @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task
> >>>>>>> *task, void *calldata)
> >>>>>>>                switch (task->tk_status) {
> >>>>>>>                case -EIO:
> >>>>>>>                case -ETIMEDOUT:
> >>>>>>> +               case -EACCES:
> >>>>>>>                        nfsd4_mark_cb_down(clp, task-
> >>>>>>>> tk_status);
> >>>>>>>                }
> >>>>>>>                break;
> >>>>>>> --
> >>>>>>> 2.27.0
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>> --
> >>>>> Trond Myklebust
> >>>>> Linux NFS client maintainer, Hammerspace
> >>>>> trond.myklebust@hammerspace.com
> >>>>>
> >>>>>
> >>>
> >>> --
> >>> Trond Myklebust
> >>> Linux NFS client maintainer, Hammerspace
> >>> trond.myklebust@hammerspace.com
>
> --
> Chuck Lever
>
>
>
