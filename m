Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182D840EAC2
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Sep 2021 21:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhIPTXA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Sep 2021 15:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhIPTXA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Sep 2021 15:23:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72247C061574
        for <linux-nfs@vger.kernel.org>; Thu, 16 Sep 2021 12:21:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g184so7145110pgc.6
        for <linux-nfs@vger.kernel.org>; Thu, 16 Sep 2021 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5TUDsoQrDyjua0csZZrPk5aV5feI+9Pn9Q40t9YT3E=;
        b=TwvOq3D8IsHBEHdNYoj0Dyjn2sV5Puez+nF6VgrlC8ISMDfbmrb83XmW/vt3JlLfoS
         3VTaUryeoYVnkXaLt7shzQx7ma+YbWlH/1mQUiQjmIN0wJYcxUuTRfsdtytE30S8OcRH
         l449caWmjgrcH21VKnwp+lbVJAtzh+YV7+G27eqXlMeJQ0PzE3cl5L6jKU3kkOTtNXtM
         Zz9QjTDFUFFOmhMl4GHdhIOAkkwyngK3488ZAjAn7q+ADUeG4mId6N0M9DyASJ3f07nN
         FZjUej7ugH2Rymn+EW7WyN+QzZOHebifYZhwJg6m7ZPnkffbSfYX2/oBUlZfMOC8wUEb
         5lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5TUDsoQrDyjua0csZZrPk5aV5feI+9Pn9Q40t9YT3E=;
        b=TLY/kxOysqCQC2JIuwv2CoY4WjOlLIhxZrJHE1wRLIyR8Kbs0YgOJr8Vj/fBICIRlO
         pUCnFYVcM1W6rRJOmoYpa+Xm7e5/QmmKofJfZBOJbA2lRGxQZXPoHBpakiPri5++5Iru
         qb3LdNXD4QG5XNVZP7e0x5S8o15rAoxrIt6UIqaY6qf5fWmrckOJFkaY7YFKuXujdG8y
         6qMh9L4LqEUwoCkQrGQ9UEbAtFQZc3wlBh6JFJ3phe99gmDT2bzQQKtYExp7Y2jRZMCj
         Ljf8w0/dut3tGMSeFBh7qrUKQA+MFIKods6FBVHSysxOkCoWSEDTIx0U4vsbtTzToCnN
         u8ag==
X-Gm-Message-State: AOAM532Xly0T6jZLXiM7Gv6VFhzScY3vT8g+SLM9d2Knt7vP0dL7/pCc
        JbRPzG4aqCyhxsdYhYBN/CKuWuj3MRC3jvp0guA5TOUh
X-Google-Smtp-Source: ABdhPJzvcWM/IBGcvIgVHnfkdgRY5clUENQLvzA8eO5dTEWT0mZ6cfjGpgakcCoAIRvOgf+FWjacmwQaENWqFc0G08M=
X-Received: by 2002:a05:6a00:14c4:b0:412:444e:f600 with SMTP id
 w4-20020a056a0014c400b00412444ef600mr6925298pfu.83.1631820098883; Thu, 16 Sep
 2021 12:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKANNnAQms8mGJzTAW4dDWTF=EeCWM0tQJNiGQ=7Jekqzg@mail.gmail.com>
 <A4BF67CE-BD6A-4B23-A5E2-5B71EDEF0EDD@oracle.com>
In-Reply-To: <A4BF67CE-BD6A-4B23-A5E2-5B71EDEF0EDD@oracle.com>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Thu, 16 Sep 2021 12:21:28 -0700
Message-ID: <CAOv1SKAKs=2yjdjJxuuFDib3FJJsXmSgqqyrXaamoj864ifH2A@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Mel Gorman <mgorman@suse.com>, Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the insight Chuck. I will give it a bit more time as you
suggest; I will ask if the arch devs can pull in the fix to their
kernel in the meantime.
I didn't see anyone making "backport fixes" requests in the stable
list archive recently, so it doesn't seem to be the norm, but I don't
see any other methods.

- mike

On Thu, Sep 16, 2021 at 11:58 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Sep 15, 2021, at 10:45 PM, Mike Javorski <mike.javorski@gmail.com> wrote:
> >
> > Chuck:
> >
> > I see that the patch was merged to Linus' branch, but there have been
> > 2 stable patch releases since and the patch hasn't been pulled in.
>
> The v5.15 merge window just closed on Monday. I'm sure there is a
> long queue of fixes to be pulled into stable. I'd give it more time.
>
>
> > You
> > mentioned I should reach out to the stable maintainers in this
> > instance, is the stable@vger.kernel.org list the appropriate place to
> > make such a request?
>
> That could be correct, but the automated process has worked for me
> long enough that I'm no longer sure how to make such a request.
>
> --
> Chuck Lever
>
>
>
