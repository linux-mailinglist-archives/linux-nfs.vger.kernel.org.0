Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6426486A88
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 20:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbiAFTco (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 14:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243322AbiAFTco (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 14:32:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3579C061245
        for <linux-nfs@vger.kernel.org>; Thu,  6 Jan 2022 11:32:43 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a18so12399655edj.7
        for <linux-nfs@vger.kernel.org>; Thu, 06 Jan 2022 11:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYaC399z6RUJdM6tOuzUnSOkHDAGwkeT8GgIKPWayzI=;
        b=lPQWPbjlqcGflk/2dOmK0qvHj/FUJkzr4TABGUHSql8JsDxt5X0DiPCrmwdtkN12kO
         jgDVtN/O4Z6MSKKuKXefSPOC9jmXvvISNNzQthsSa0IguCGA/RlueirP8re/17E/uO1Q
         /CGFxF5Rn/lsoMJlzk3rOEGaffIU81qc44yTnqNt0huJicibye22DwKF5igwGTi9XFxt
         QG+zCokC+D3XApeuE8HzGDYxUheD5GNAjeHf1SIQRYAPc3aHO7uSZZI5s7LXdslRzWzy
         hXOmvDpQLy8FGpVrk2iAZYKn+Rn5dBbMPps59rU3U6XyFb/Ie3eudGlvXIL73vgb7ory
         cuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYaC399z6RUJdM6tOuzUnSOkHDAGwkeT8GgIKPWayzI=;
        b=ejU4Bog/7AJPMzvCury21t02S1VAcioJvPhMqSTd3qC0IHyUgYqC9sBJKsKmwhZ0Y0
         ZQesg/r0TlNRmwDDRYnvVv+cRbkATbE14brah3nvhKfKVX3L0TGRyW3xhIkCP9ha16/n
         x/vwiOHq5FWxUMDrnI4GOLli811Qf4OtQny9Uat2DiomB56si6wxW/dP/bO2LAWlRrwt
         9jyFrIOFLf2sjhA7pGp+MK8061bbK93P8lxW6KXdSNnaMzeED6BMOd4ojNfEw3nXu3uy
         m6SHLl3Upn+unkLfNaMcPGHVduIUb0Ik1W35Q4btwf4m8jLGYLFOVORFrjn/TRXqf/pa
         cNPA==
X-Gm-Message-State: AOAM531mLl3tsyPSnzk57PRjMEl9/9Vb6enN15bWetKeTNADqM0jqdjX
        CdKAvCrXmLQmw730kHJ8xQCIOqC1ExJVTr5Txu0=
X-Google-Smtp-Source: ABdhPJz8VyVLoBWPR/s/zA3au0F5Hyn/U6KreeBMu8rEQNoPHsfisEsIevMWXR6Axa360VPrejM3GGthnXfa2JmFn7M=
X-Received: by 2002:a17:907:7254:: with SMTP id ds20mr49462990ejc.140.1641497562311;
 Thu, 06 Jan 2022 11:32:42 -0800 (PST)
MIME-Version: 1.0
References: <7318.1641394756@crash.local> <20220105201313.GE25384@fieldses.org>
 <88B4B5A4-74B1-4D6C-8210-BE6C754EE5FF@oracle.com>
In-Reply-To: <88B4B5A4-74B1-4D6C-8210-BE6C754EE5FF@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 6 Jan 2022 14:32:31 -0500
Message-ID: <CAN-5tyGAu-LfcaB0V1QvNS533PmqEP7Zqgxd=oQEaxFGmCn+_A@mail.gmail.com>
Subject: Re: nfsd v4 server can crash in COPY_NOTIFY
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        "rtm@csail.mit.edu" <rtm@csail.mit.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 6, 2022 at 12:41 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 5, 2022, at 3:13 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Wed, Jan 05, 2022 at 09:59:16AM -0500, rtm@csail.mit.edu wrote:
> >> If the special ONE stateid is passed to nfs4_preprocess_stateid_op(),
> >> it returns status=0 but does not set *cstid. nfsd4_copy_notify()
> >> depends on stid being set if status=0, and thus can crash if the
> >> client sends the right COPY_NOTIFY RPC.
> >>
> >> I've attached a demo.
> >>
> >> # uname -a
> >> Linux (none) 5.16.0-rc7-00108-g800829388818-dirty #28 SMP Wed Jan 5 14:40:37 UTC 2022 riscv64 riscv64 riscv64 GNU/Linux
> >> # cc nfsd_5.c
> >> # ./a.out
> >> ...
> >> [   35.583265] Unable to handle kernel paging request at virtual address ffffffff00000008
> >> [   35.596916] status: 0000000200000121 badaddr: ffffffff00000008 cause: 000000000000000d
> >> [   35.597781] [<ffffffff80640cc6>] nfs4_alloc_init_cpntf_state+0x94/0xdc
> >> [   35.598576] [<ffffffff80274c98>] nfsd4_copy_notify+0xf8/0x28e
> >> [   35.599386] [<ffffffff80275c86>] nfsd4_proc_compound+0x2b6/0x4ee
> >> [   35.600166] [<ffffffff8025f7f4>] nfsd_dispatch+0x118/0x174
> >> [   35.600840] [<ffffffff8061a2e8>] svc_process_common+0x2f4/0x56c
> >> [   35.601630] [<ffffffff8061a624>] svc_process+0xc4/0x102
> >> [   35.602302] [<ffffffff8025f25a>] nfsd+0xfa/0x162
> >> [   35.602979] [<ffffffff80027010>] kthread+0x124/0x136
> >> [   35.603668] [<ffffffff8000303e>] ret_from_exception+0x0/0xc
> >> [   35.604667] ---[ end trace 69f12ad62072e251 ]---
> >
> > We could do something like this.--b.
> >
> > Author: J. Bruce Fields <bfields@redhat.com>
> > Date:   Wed Jan 5 14:15:03 2022 -0500
> >
> >    nfsd: fix crash on COPY_NOTIFY with special stateid
> >
> >    RTM says "If the special ONE stateid is passed to
> >    nfs4_preprocess_stateid_op(), it returns status=0 but does not set
> >    *cstid. nfsd4_copy_notify() depends on stid being set if status=0, and
> >    thus can crash if the client sends the right COPY_NOTIFY RPC."
> >
> >    RFC 7862 says "The cna_src_stateid MUST refer to either open or locking
> >    states provided earlier by the server.  If it is invalid, then the
> >    operation MUST fail."
> >
> >    The RFC doesn't specify an error, and the choice doesn't matter much as
> >    this is clearly illegal client behavior, but bad_stateid seems
> >    reasonable.
> >
> >    Simplest is just to guarantee that nfs4_preprocess_stateid_op, called
> >    with non-NULL cstid, errors out if it can't return a stateid.
> >
> >    Reported-by: rtm@csail.mit.edu
> >    Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
> >    Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 1956d377d1a6..b94b3bb2b8a6 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6040,7 +6040,11 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
> >               *nfp = NULL;
> >
> >       if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
> > -             status = check_special_stateids(net, fhp, stateid, flags);
> > +             if (cstid)
> > +                     status = nfserr_bad_stateid;
> > +             else
> > +                     status = check_special_stateids(net, fhp, stateid,
> > +                                                                     flags);
> >               goto done;
> >       }
>
> Thanks, Bruce. I'll take this provisionally for v5.17. Olga, can you
> provide a Reviewed-by: ?

I reproduced the original problem (thank you for the reproducer).

Reviewed-by and Tested-by.

>
>
> --
> Chuck Lever
>
>
>
