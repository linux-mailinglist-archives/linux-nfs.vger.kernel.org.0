Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C087342C92
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 18:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406304AbfFLQqg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 12:46:36 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34850 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404956AbfFLQqf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jun 2019 12:46:35 -0400
Received: by mail-vs1-f68.google.com with SMTP id u124so10679785vsu.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2019 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5DEfH5SQKrIP7Tmn6AUF+yksRS9DcFrxwaZxglD0AA=;
        b=MEp6nbBDv8Z4VREA4J6yMVjL+DN/nssMiPJ9VTwz/df+d9lLCSKV8kOi8n91OoGPeq
         guWCvIy/ZjjA63mSXhSBIaV6jM8ub6vW4+QKiBS3GHspssrghM93F9meXxJKr/nHUoIX
         yngc3ytx48ouyMUGCIHzYqU/VOw9SvJFtOjey9gBp13WvuI47fYLhfoAOJs2BFMPw+3U
         7P8o776m125AesOwZwE7MvOMHhXAFZXHFHyuARJbGFoKuDxBpj6gxe7pU92BYYUopFJk
         l/PQ97YjcyzH25bWyuWYrfCiPi6YWBsr1t4Vre9JdljDOfzI1n4p8xX1ZBPUt6tkOS4H
         ZLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5DEfH5SQKrIP7Tmn6AUF+yksRS9DcFrxwaZxglD0AA=;
        b=cAHBBHHcaR9iHRai7p+aUOyi9FPXxzfklrjITL70Dw76aBvqWuNaGDNcmMChbKH5J2
         yZHRvbiflQYAAIFfCNC3qMRHEi8iJ6tEDWIr+J04EYKwTKQoIlDuVzwkY13mX8UMowSA
         C3oNR5BvRT+lwjfimiG39wPnU+EBg9luCjEGz3sh+nxLKg0/hnMf5zjtR67to7upT1DI
         zrpaCWVTbomkr1w0XC4+olqmCta3hiNEQkFmzMdSU1qyIF7Sg63oAVHS9MLyMs906ZSY
         Ka2ykfpg2BhtrCnb9ltt275FKMVSSZQ4Oj0q60cqu5CpFp83p4KO0j2XGwiqkwvxkJ0C
         oerg==
X-Gm-Message-State: APjAAAWaBISbjo4kAAHGLAmHBiJEq2/mJB9ZkGBkMDfJIolh2T4u4WaJ
        b0KYeaXD86oSRj/jQAE1M+BPcfCogDkwkO2/Ya8=
X-Google-Smtp-Source: APXvYqxugNl/QyyCJrxMzSLNbRNkf9UAfJw4ZicdEarSR8+jv5+wuXUATPjDN9Liz46DJxubkCip/4F/nTsmULBtIn8=
X-Received: by 2002:a67:dc1:: with SMTP id 184mr12759907vsn.164.1560357994474;
 Wed, 12 Jun 2019 09:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190409113713.30595-1-xiubli@redhat.com> <6a152a89-6de6-f5f2-9c16-5e32fef8cc64@redhat.com>
 <81ba7de8-1301-1ac9-53fb-6e011a592c96@RedHat.com> <d1a7662c-deb1-0fb4-9707-ccfb680ffcbc@redhat.com>
In-Reply-To: <d1a7662c-deb1-0fb4-9707-ccfb680ffcbc@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 12 Jun 2019 12:46:23 -0400
Message-ID: <CAN-5tyFTR+bu9KTBHpLVdpbXEtXsCc2yLRcaPfMe+u0NKYmHBQ@mail.gmail.com>
Subject: Re: [PATCH] svc_run: make sure only one svc_run loop runs in one process
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Steve Dickson <SteveD@redhat.com>,
        libtirpc-devel@lists.sourceforge.net,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 12, 2019 at 3:45 AM Xiubo Li <xiubli@redhat.com> wrote:
>
> On 2019/6/11 22:54, Steve Dickson wrote:
> > Sorry for the delay....
> >
> > On 5/15/19 10:55 PM, Xiubo Li wrote:
> >> Hey ping.
> >>
> >> What's the state of this patch and will it make sense here?
> > I'm not sure it does make sense.... Shouldn't the mutex lock
> > be in the call of svc_run()?
>
> Hi Steve,
>
> Yeah, mutex lock should be in the call of svc_run(). This is exactly
> what I do in this change.
>
> If the libtirpc means to allow only one svc_run() loop in each process,
> so IMO this change is needed. Or if we will allow more than one like the
> glibc version does, so this should be one bug in libtirpc.

Has there been effort into made into investigating what's causing the
crashes? We perhaps should make an effort to see if svc_run() is
thread-safe and examine which functions it uses and which might not be
thread safe. You might be able to allow greater parallelism then 1
thread in a svc_run() function by just making some not-thread safe
functions wrapped in pthread locks.

>
> Thanks.
> BRs
> Xiubo
>
>
> > steved.
> >
> >> Thanks
> >> BRs
> >>
> >> On 2019/4/9 19:37, xiubli@redhat.com wrote:
> >>> From: Xiubo Li <xiubli@redhat.com>
> >>>
> >>> In gluster-block project and there are 2 separate threads, both
> >>> of which will run the svc_run loop, this could work well in glibc
> >>> version, but in libtirpc we are hitting the random crash and stuck
> >>> issues.
> >>>
> >>> More detail please see:
> >>> https://github.com/gluster/gluster-block/pull/182
> >>>
> >>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> >>> ---
> >>>    src/svc_run.c | 19 +++++++++++++++++++
> >>>    1 file changed, 19 insertions(+)
> >>>
> >>> diff --git a/src/svc_run.c b/src/svc_run.c
> >>> index f40314b..b295755 100644
> >>> --- a/src/svc_run.c
> >>> +++ b/src/svc_run.c
> >>> @@ -38,12 +38,17 @@
> >>>    #include <string.h>
> >>>    #include <unistd.h>
> >>>    #include <sys/poll.h>
> >>> +#include <syslog.h>
> >>> +#include <stdbool.h>
> >>>        #include <rpc/rpc.h>
> >>>    #include "rpc_com.h"
> >>>    #include <sys/select.h>
> >>>    +static bool svc_loop_running = false;
> >>> +static pthread_mutex_t svc_run_lock = PTHREAD_MUTEX_INITIALIZER;
> >>> +
> >>>    void
> >>>    svc_run()
> >>>    {
> >>> @@ -51,6 +56,16 @@ svc_run()
> >>>      struct pollfd *my_pollfd = NULL;
> >>>      int last_max_pollfd = 0;
> >>>    +  pthread_mutex_lock(&svc_run_lock);
> >>> +  if (svc_loop_running) {
> >>> +    pthread_mutex_unlock(&svc_run_lock);
> >>> +    syslog (LOG_ERR, "svc_run: svc loop is already running in current process %d", getpid());
> >>> +    return;
> >>> +  }
> >>> +
> >>> +  svc_loop_running = true;
> >>> +  pthread_mutex_unlock(&svc_run_lock);
> >>> +
> >>>      for (;;) {
> >>>        int max_pollfd = svc_max_pollfd;
> >>>        if (max_pollfd == 0 && svc_pollfd == NULL)
> >>> @@ -111,4 +126,8 @@ svc_exit()
> >>>        svc_pollfd = NULL;
> >>>        svc_max_pollfd = 0;
> >>>        rwlock_unlock(&svc_fd_lock);
> >>> +
> >>> +    pthread_mutex_lock(&svc_run_lock);
> >>> +    svc_loop_running = false;
> >>> +    pthread_mutex_unlock(&svc_run_lock);
> >>>    }
> >>
> >>
> >>
> >> _______________________________________________
> >> Libtirpc-devel mailing list
> >> Libtirpc-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/libtirpc-devel
>
>
