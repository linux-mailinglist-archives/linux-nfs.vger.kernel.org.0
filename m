Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAAB350891
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 22:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhCaUzX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 16:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhCaUyz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 16:54:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65084C061574
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 13:54:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b7so32100584ejv.1
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEGVosLSxO9e5qOvoMg76P0txqaEyyrXFkjfnXXTgo8=;
        b=laDcO3XMNXbKFRD/HgSM+sbsRq2Fscs48Rhb8ajxKNfmFlM03ibKF94g5QDG7JN1hV
         ObCAoprytYo3OjCc80DtzZ8udOOJH7o64qcGhrsMFZ9NGtptBoVMhlNWWxEIGjrlbKrP
         9qBHAzNuCt1shxWqyJNI6D0CfQZy59E1bgam9m1kPD09pRE8UG1HypJ2o20ipMQNs1gl
         ngXyhTNOqCv7mPx0kqR3ybkyNNdJdf4f5t1wdvojMVuUtmZLk9O1/uvogvWm2/QHIeiu
         VFwVMRi+i6BTUj2qdMp7vQ1eOU3pMPCuUN5qpN6VxToQoNnBtXH+YNhlwvEmrg0VsxH+
         EO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEGVosLSxO9e5qOvoMg76P0txqaEyyrXFkjfnXXTgo8=;
        b=sN+3tRPL4glZYwSkPl73P1nrtLkfomWtGZ1Rs+pPaX/OtpS7wFx2TO601DVHxVngiH
         kzAFW3HSaRkqRfj9bs+OuO0qa8rPpMicp/ihR/KxCgPX9Jj470b7xyTHKkC7WgZueAjo
         WHlurFbyyRWzsbVE17D5DVju5vRAEQnaq4Nl3etvCwNX5tDRUypNLlOFUC23Lww3et6r
         bdtRIiMFFJkkCuWTmDDYRxsWFChbi7YYEFUELEvAj1t3HPplErnLnhz2thSAHlCN+YQS
         6KWFCqH/SdkkKPtKPJ5qDU9crmQdVqK/I9/autR/lfhtdtHKcym0ZLXLovp9b7atC5Za
         vQZQ==
X-Gm-Message-State: AOAM530B43QI2zGi7akpjoHLzxaZqOQ9FXHSlmcncVxShrm1VSrOCh0N
        FuX3R2AvTJWNcI8OETbDm7+oyw4CXYKPHYs1KvbZ1/+U
X-Google-Smtp-Source: ABdhPJzi7drke8y/rH+1zBOg7uxzXd9RDLAI5gclzbLwldsVlxQ0On+KKXb0DrZkTvbSizUpBwSueSrBjPMBCEK9/1Y=
X-Received: by 2002:a17:906:e2d4:: with SMTP id gr20mr5738860ejb.432.1617224094107;
 Wed, 31 Mar 2021 13:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210330190359.13057-1-olga.kornievskaia@gmail.com> <AAB69ABA-6AD8-4623-A823-B1B3FF8BA1FB@oracle.com>
In-Reply-To: <AAB69ABA-6AD8-4623-A823-B1B3FF8BA1FB@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 31 Mar 2021 16:54:43 -0400
Message-ID: <CAN-5tyHL4s9=Gaf=DzA3H2ZcMzMn00Lqqw+h-ZgSrogVUHJ1Rg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: fix copy stateid copying for the async copy
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 31, 2021 at 12:39 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Hi Olga-
>
> > On Mar 30, 2021, at 3:03 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> >
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > This patch fixes Dan Carpenter's report that the static checker
> > found a problem where memcpy() was copying into too small of a buffer.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Fixes: e0639dc5805a: "NFSD introduce async copy feature"
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>
> Thanks! Pushed to the for-next topic branch in:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>
> With a Reviewed-by: from Dai.

Thank you Chuck. It was pointed out that I messed up the "Fixes" line.
Do you want me to send another or can you fix it locally?

>
>
> > ---
> > fs/nfsd/nfs4proc.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index dd9f38d072dd..e13c4c81fb89 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1538,8 +1538,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >               if (!nfs4_init_copy_state(nn, copy))
> >                       goto out_err;
> >               refcount_set(&async_copy->refcount, 1);
> > -             memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid,
> > -                     sizeof(copy->cp_stateid));
> > +             memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.stid,
> > +                     sizeof(copy->cp_res.cb_stateid));
> >               dup_copy_fields(copy, async_copy);
> >               async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
> >                               async_copy, "%s", "copy thread");
> > --
> > 2.18.2
> >
>
> --
> Chuck Lever
>
>
>
