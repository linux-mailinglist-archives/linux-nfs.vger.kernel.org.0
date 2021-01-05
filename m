Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91B2EB3F5
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 21:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbhAEUN5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 15:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbhAEUN4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 15:13:56 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9676C061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 12:13:16 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id lb18so291716pjb.5
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 12:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2S1tYS5+NYjC8/TKNpyIz56a8edTS06KuqKN4g/GrI=;
        b=N1mK5oaSxNViB79C49abflHfH52FoH2TvZu7X12MduCz4WlG+lH59kyPPvMDJcvZ16
         EhgzbwGAU3LxOS07jE90ovypj40A/CmmpJbO3iG4l+GecNHMjltIxTWUj8iMoDsPEVC9
         vCuyw0AnZCMFt62l3BNPqwvGpUGvjxRbJDo9ZFeFKBSGNFE8u2JLn6s+RosfB7bF0IXo
         Yb+BnWs0QG8L57Ssx1KrfZZjXLtygXxLof5zFDxHufTVSmKVCD2ykqfTqYEu48oikkMN
         QQJL0tqKIsDdW87jNIDywzUD607d+OFB+9H4VLX+PCLyAiKN0dsuXskoFex33bQYAe93
         12UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2S1tYS5+NYjC8/TKNpyIz56a8edTS06KuqKN4g/GrI=;
        b=pKUpTj+7Qcaho2GKuYKvBC5zAsYvAohuQwMQPyfVJ05AvzTNlZXNJL/yC7dJFhltCf
         92qtTa5AWw5Wbe6TQzsFWit0FRueh2KFEGfZW0qWaJa+o8pEJyJL+9uvpXiSJiQiu/RV
         DgW8aIEPAPNeypaAsPqLmkSb181doQ7ZnujGMYkUv2tIV+ILWyPXZ2ZiyLf50qNYAIpG
         Vn7bU84Qjd2tQ35nTaW7A5Kg9gVpQ8WTnx4fyh6bKuIohr4KWXVezCRC8y84Z/dygQZR
         QbvbL+2F8ZgpFoB9GnXNbCMAUnehikiDPGurOcc1PpDryKoB4M2zA0sh8PsUbUQ8GGob
         Pp3Q==
X-Gm-Message-State: AOAM5310Xci/a15AT9EMv8vx1lhJ5vmHs7PY2/+y7klPpjewQSXKPweN
        bIwijEUk/2AnpqOLrmAGSA+DeICrkNJYlYoe75k=
X-Google-Smtp-Source: ABdhPJyYHuSgIkB9r+N4uYhjpBzSN1UMq/Zdw7yuMSmWxTioEOlA60fQ6FaFCw2fHEiT4fRev6W3graMdK/eQyFpOU0=
X-Received: by 2002:a17:902:7d84:b029:db:feae:425e with SMTP id
 a4-20020a1709027d84b02900dbfeae425emr901330plm.43.1609877596151; Tue, 05 Jan
 2021 12:13:16 -0800 (PST)
MIME-Version: 1.0
References: <85C06BBD-2861-4CDE-BCED-ACD974560D3A@redhat.com> <72FFA566-311D-4826-9F4A-29AE0F379327@oracle.com>
In-Reply-To: <72FFA566-311D-4826-9F4A-29AE0F379327@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 5 Jan 2021 15:13:03 -0500
Message-ID: <CAN-5tyHSs+Qu4pY+Vh+KsNrQzzVzziyYLAHxEMQE=eHtmrTgtA@mail.gmail.com>
Subject: Re: [nfsv4] virtual/permanent bakeathon infrastructure
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        NFSv4 <nfsv4@ietf.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 4, 2021 at 8:56 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 4, 2021, at 8:46 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
> >
> > How are folks feeling about throwing time at a virtual bakeathon?  I had
> > some ideas about how this might be possible by building out a virtual
> > network of OpenVPN clients, and hacked together some infrastructure to make
> > it happen:
> >
> > https://vpn.nfsv4.dev/
>
> My colleague Bill Baker has suggested we aren't going to get the
> rest of the way there until we have an actual event; ie, a moment
> in time where we drop our everyday tasks and focus on testing.
>
> So, I'm all for a virtual event.
>
> We could pick a week, say, the traditional week of Connectathon
> at the end of February.

Netapp is also saying that they will only allocate hardware for
testing for a given period of time and not indefinitely. Thus, having
an agreed upon date would be a good idea (even if it's a flexible
date).

> > That network exists today, and any systems that are able to join it can use
> > it to test.  There are a number of problems/complications:
> >    - the private network is ipv6-only by design to avoid conflicts with
> >      overused ipv4 private addresses.
> >    - it uses hacked-together PKI to protect the TLS certificates encrypting
> >      the connections
> >    - some implementations of NFS only run on systems that cannot run
> >      OpenVPN software, requiring complicated routing/transalations
> >    - it needs to be re-written from bash to something..  less bash.
> >    - network latencies restrict testing to function; testing performance
> >      doesn't make sense.
>
> And the only RDMA testing we can do is iWARP, which excludes some
> NFS/RDMA implementations.
>
>
> > With the ongoing work on NFS over TLS, my thought now is that if there is
> > interest in standing up permanent infrastructure for testing, then that's
> > probably sustainable way forward.  But until implementations mature, its not
> > going to help us host a successful testing event in the near future.
>
> The community does need to integrate TLS testing into these events.
> However at the moment, there are only a very few implementations. I
> don't feel comfortable relying on RPC-over-TLS for general testing
> yet.
>
>
> > So, the second question -- should we instead work towards implementations of
> > NFS over TLS as a way of creating a more permanent testing infrastructure?
>
> Yes, but given how far away that reality is, we shouldn't delay our
> regular testing with the infrastructure you've set up already.
>
>
> > I am aware that I am leaving out a lot of detail here in order to try to
> > start a conversation and perhaps coalesce momentum.
> >
> > Happy new year!
> > Ben
> >
> > _______________________________________________
> > nfsv4 mailing list
> > nfsv4@ietf.org
> > https://www.ietf.org/mailman/listinfo/nfsv4
>
> --
> Chuck Lever
>
>
>
> _______________________________________________
> nfsv4 mailing list
> nfsv4@ietf.org
> https://www.ietf.org/mailman/listinfo/nfsv4
