Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B9B3EAEB9
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Aug 2021 04:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbhHMCxi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 22:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbhHMCxi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 22:53:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4FBC061756
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 19:53:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l11so10029895plk.6
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 19:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzLiSlIsVSup/4qeCvh7Ri+f3EZxwQPJOIuD6v+NfLY=;
        b=Zu9VB643K8+wLNdjTuXaVdyXQoGZPdwuwzqhT8iCdwYiZ1Xk1KGZQUVLOEyjebi6Ol
         u9RfuTNIAkAwp5NKI9Z0Z+m+/sM0OsBBwvt3d+VM7jDPmDUGHNpbuga7tGpmraiziJyt
         BdwjLr+r0JdmBAGyfSPcP75tdscDsLaZiUTevodHUvTKfuRsWzTC57bllEsChdRHYNzV
         0I7gcai2RQfuIybSxkoZwrsXaU764kyQWi5vGdHqXUeHt9Y2CN91Cr8U0Xb/QN63sa3+
         MGlZl/oXM275TdpQ0kLMl+fMLt5TngDKnNTOH1cVTjHTUpjeB5pmcYufOSeB9juhDkJb
         JqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzLiSlIsVSup/4qeCvh7Ri+f3EZxwQPJOIuD6v+NfLY=;
        b=AqvMV0N+9hbpJ9JXUw0z8V4FJEPVMVVaxup2VvYm8NfOUUyY+XP5735Rzn3PrQn8ZC
         7sfPx9UOd/SIkFiLE82l3XerhEWoDkLZa6JgGXQtZMcYX8k193V9wyJ7T8tTMW2Xmm41
         Dhsxpu6ov/V07Nd5ABrV+3NrW5Tr5RQgt1DgTvpzDHTKnnm4gG0ElYCdHF2uRNktg07w
         AfjbMftqctu5NDZ/wDenE/WedCp1o8v+ZOCoPPpW9hZLNLmG49tF8GhhVTy51qzT9k5y
         dQVP6xYxxadsiU+5wXbMRRHsYkJ7KthpuEZhSTlEcyR9OuRR4Bq0eR7lrt012jaBMSgO
         5BMw==
X-Gm-Message-State: AOAM530fp/SeMoNbPyvFt4KnIYGzkD+Q+HQhAMZqktodBaA+IIkl0GM3
        R8wj+yTLFlA5+QFtfmD9m60JQGuYuBp2pj0Mw1A=
X-Google-Smtp-Source: ABdhPJxguQ28+DrEzDJvQqKvBKLMnGEHxoozcfVTuuOB9AFsAiNfGrbeI4X5b0BWvpgA3AsN2wZ1HabLlZzpyzWuOoQ=
X-Received: by 2002:a05:6a00:1386:b029:3cb:d3d4:f0b0 with SMTP id
 t6-20020a056a001386b02903cbd3d4f0b0mr309445pfg.24.1628823191574; Thu, 12 Aug
 2021 19:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com> <162882238416.1695.4958036322575947783@noble.neil.brown.name>
In-Reply-To: <162882238416.1695.4958036322575947783@noble.neil.brown.name>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Thu, 12 Aug 2021 19:53:00 -0700
Message-ID: <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The "semi-known-good" has been the client. I tried updating the server
multiple times to a 5.13 kernel and each time had to downgrade to the
last 5.12 kernel that ArchLinux released (5.12.15) to stabilize
performance. At each attempt, the client was running the same 5.13
kernel that was being deployed to the server. I never downgraded the
client.

Thank you for the scripts and all the details, I will test things out
this weekend when I can dedicate time to it.

- mike

On Thu, Aug 12, 2021 at 7:39 PM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 13 Aug 2021, Mike Javorski wrote:
> > Neil:
> >
> > Apologies for the delay, your message didn't get properly flagged in my email.
>
> :-)
>
> >
> > To answer your questions, both client (my Desktop PC) and server (my
> > NAS) are running ArchLinux; client w/ current kernel (5.13.9), server
> > w/ current or alternate testing kernels (see below).
>
> So the bug could be in the server or the client.  I assume you are
> careful to test a client against a know-good server, or a server against
> a known-good client.
>
> >                                                                 I
> > intend to spend some time this weekend attempting to get the tcpdump.
> > My initial attempts wound up with 400+Mb files which would be
> > difficult to ship and use for diagnostics.
>
> Rather than you sending me the dump, I'll send you the code.
>
> Run
>   tshark -r filename -d tcp.port==2049,rpc -Y 'tcp.port==2049 && rpc.time > 1'
>
> This will ensure the NFS traffic is actually decoded as NFS and then
> report only NFS(rpc) replies that arrive more than 1 second after the
> request.
> You can add
>
>     -T fields -e frame.number -e rpc.time
>
> to find out what the actual delay was.
>
> If it reports any, that will be interesting.  Try with a larger time if
> necessary to get a modest number of hits.  Using editcap and the given
> frame number you can select out 1000 packets either side of the problem
> and that should compress to be small enough to transport.
>
> However it might not find anything.  If the reply never arrives, you'll
> never get a reply with a long timeout.  So we need to check that
> everything got a reply...
>
>  tshark -r filename -t tcp.port==2049,rpc  \
>    -Y 'tcp.port==2049 && rpc.msg == 0' -T fields \
>    -e rpc.xid -e frame.number | sort > /tmp/requests
>
>  tshark -r filename -t tcp.port==2049,rpc  \
>    -Y 'tcp.port==2049 && rpc.msg == 1' -T fields \
>    -e rpc.xid -e frame.number | sort > /tmp/replies
>
>  join -a1 /tmp/requests /tmp/replies | awk 'NF==2'
>
> This should list the xid and frame number of all requests that didn't
> get a reply.  Again, editcap can extract a range of frames into a file of
> manageable size.
>
> Another possibility is that requests are getting replies, but the reply
> says "NFS4ERR_DELAY"
>
>  tshark -r filename -t tcp.port==2049,rpc -Y nfs.nfsstat4==10008
>
> should report any reply with that error code.
>
> Hopefully something there will be interesting.
>
> NeilBrown
