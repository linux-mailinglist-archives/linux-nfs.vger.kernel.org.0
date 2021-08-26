Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89B93F8EC2
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 21:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbhHZTfa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 15:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhHZTf3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 15:35:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149FEC061757
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 12:34:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 17so3935251pgp.4
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMrAHFwTOOxPSr7liVCdsJYpe8w0r6TSIQ3hmL51Bv0=;
        b=NvlM36PKZHuLE9g25zMfCQ78ovLs7eaa/xEK3vjIiOUmKw5RKHs67tZdfPlNveyYxz
         FCstlz1z7Lj8NORlcnotT+2vfVvcSpjRbwN77h4SMG3+pblAcF6pb5ZdkpwzEZsz1tzj
         DazL6pgcdJztjzzDR28aTEVCZZIy0ntDoxroDO+Ark5URoPZrGxx1K6u5hP50ZutjPHs
         5TW8MzJKJCOfLsUFOzKcqtaY9SnUuqJglgTTPJlHhL+ecvbpcPzl3vJ+1vYkWILtK7pm
         mhLr/Oe859oRVgY2Ac2fnqSMaJPezVgT/Kb6eV8kxcWs6nIT44HbpQ5ToojO4CgSDt5Z
         MbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMrAHFwTOOxPSr7liVCdsJYpe8w0r6TSIQ3hmL51Bv0=;
        b=EIPnqZIHQJOcmTcOogoXd2cNYCjWcnAHT75OAVzKfkVAJiyUN62kmYEOLhoVpYrtFq
         u+iTnB26OqW3pJFjqDlr32CTeb7+6uwpNIjXAWxrQj2vaipLoT2cUSi7NVg8HWMZIc5F
         Gv9niGPdGDGGeKWI+d6bT/qwqsyOwA4OuBxAAMbfdzH360/tuAdt1sh0SwGVpPw0bBSF
         /s9mdJbPhiidEb3J81I1LhwldTIpz6t96daQ0FrzWS+qdW3IjA1V4Id+lLGQhZaAY1Po
         VFxyFB3DA4BYvrFeCtHQO+Obpl0BddXJmqePdRxFoYYtbLZFWMqWrBnbRPG5WLUyDPF3
         XUOg==
X-Gm-Message-State: AOAM5315vCdrZskDtfHlAMZ6z8CAqAwUD4QiMQKOOEiAVnfCWy1WXr1z
        SQtnRTmQSmygfENOuh84rui6FVwxrikU38DQHSY=
X-Google-Smtp-Source: ABdhPJxxCxfTZFX6y4TQs9zt2r8i0XXYuakXz224Mlaja9kELqF+w9DosTRREONbF2wZ3cUIUVKlkBVf0ptdB/zYdzw=
X-Received: by 2002:a63:4f03:: with SMTP id d3mr4641875pgb.217.1630006481478;
 Thu, 26 Aug 2021 12:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>
 <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com> <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>
 <162915491276.9892.7049267765583701172@noble.neil.brown.name>
 <162941948235.9892.6790956894845282568@noble.neil.brown.name>
 <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>
 <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com>
 <162960371884.9892.13803244995043191094@noble.neil.brown.name>
 <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com> <162966962721.9892.5962616727949224286@noble.neil.brown.name>
In-Reply-To: <162966962721.9892.5962616727949224286@noble.neil.brown.name>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Thu, 26 Aug 2021 12:34:29 -0700
Message-ID: <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I finally had the chance to test with the offloading disabled on the
server. Unfortunately, the issues remain, may even be more frequent,
but I can't rule out confirmation bias on that one.

Not sure where to go from here.

- mike

On Sun, Aug 22, 2021 at 3:00 PM NeilBrown <neilb@suse.de> wrote:
>
> On Sun, 22 Aug 2021, Mike Javorski wrote:
> > 5.12.15-arch1:
> > ===============
> > 14723 137 0.00921938
> >
> > 5.13.12-arch1: (no freezes)
> > ===============
> > 15333 206 0.013257
> >
> > 5.13.12-arch1: (with freezes)
> > ===============
> > 9230 299 0.0313779
> >
> > So a decent bump w/ 5.13, and even more with the freezes.
>
> Thanks.  9->13 isn't as much as I was hoping for, but it might still be
> significant.
>
> > This machine is an older Opteron server w/ nforce networking. Not sure
> > how much offloading it actually does.
>
> The tcpdump showed the server sending very large packets, which means
> that it is at least doing TCP segmentation offload and checksum offload.
> Those are very common these days.
>
> Thanks,
> NeilBrown
