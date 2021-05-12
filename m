Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54B637BFB4
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhELORr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhELORl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 May 2021 10:17:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB56C061574
        for <linux-nfs@vger.kernel.org>; Wed, 12 May 2021 07:16:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x8so1509703wrq.9
        for <linux-nfs@vger.kernel.org>; Wed, 12 May 2021 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F3rpX9Jt+0c2pfcO0sYLiq9C/00ML5cCZbsc2U67NCE=;
        b=yfF3Z0oijcRATen36LGg5L+kwefBrkk820uGkdaNHiTzuekKpmkHVMX/TZKcSMo09D
         eWMNSlPcJGdJDs91xsBI7rSDf9b1ETz75o4qKjebdyzfo7ECpksUnNYgu6q1Vz1T/aZ0
         e58ZxRFYA0fiUgjaGp3+3xOrL9A9yF3twfxM1puT0ElmGMk/CCTUpk4lNtwcf5IqRfhg
         8WLYo9mDDG7Mvg2h+40iAcmzdiNpVfq5553h0fTJmNmkgkRfgHCNGvMy4dLWmK8G2g1i
         pdC97xBasvDHIVtXY5G+80QhnpXkfUVoZu/DVaBitfnlZL5zWp55/d8vcRIWmM2LyuSI
         BuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F3rpX9Jt+0c2pfcO0sYLiq9C/00ML5cCZbsc2U67NCE=;
        b=hn7oNgznQskeVrafwQmLzlhop2FyllSP7+MNjX9habGsPvZHmJM8hBBjItgodzJRaT
         5K1f0ov3OLbaApOWyJInBIhoQArTEis1n1nwjY31UkaCUBKGeNxRyOP6xRxUhCk+56Nd
         1tkmy2G6AdAollpeOKH6BXz0XQlfzBCFvdbsuslkRbGD/9ccOhILmSqspgdgHgWqe0BN
         bNLxseIk43ddYN3B97f3BpzdTSPDSNT7ep6QuRbJZggaTjYgKv4rbphEB+2H3b0GIx3L
         mH1IQkCaUnmzzxAPPFxXJZWwY6LjRFHAO1ASskgW9uLBQ+XQhzLZr37IuVi/BoP+DwLp
         Y11A==
X-Gm-Message-State: AOAM530v1HenbntFBW0+nFJky77fhpdmrVo2uJ/94jQ00mGq1lrRf7Y8
        01jgF7RijLOoxzK/6wKDCJ5tGNWZyW8QfQ==
X-Google-Smtp-Source: ABdhPJzSUaAP2mq9AhgDIbGTfDCVs/lkPgkGQzFSOwzJnwih169QT0SLAQl72o/Mc9uM0Zp03SE8Mw==
X-Received: by 2002:a5d:4ecb:: with SMTP id s11mr45391507wrv.385.1620828987753;
        Wed, 12 May 2021 07:16:27 -0700 (PDT)
Received: from gmail.com ([77.124.118.36])
        by smtp.gmail.com with ESMTPSA id m10sm1472171wrr.2.2021.05.12.07.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 07:16:27 -0700 (PDT)
Date:   Wed, 12 May 2021 17:16:23 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
Message-ID: <20210512141623.qovczudkan5h6kjz@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
 <20210426171947.99233-10-olga.kornievskaia@gmail.com>
 <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
 <CAN-5tyHPHk891-NkHt=6o+OuxRB+0ZqQRKqJ=hFThE=oYM0V7Q@mail.gmail.com>
 <20210512104205.hblxgfiagbod6pis@gmail.com>
 <CAN-5tyEoaKseyjOLA+ni7rCXG7=MnDKPCC3YN68=SHm9NaC_4A@mail.gmail.com>
 <CAN-5tyHy8VR4apVCH0kFgmvceWynx5ZwngdT3_V6abDXZnmDgg@mail.gmail.com>
 <CAN-5tyG68pQwW_0+GqqF1w+CmCOUU8ncN6++jAA7i_wqibturw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyG68pQwW_0+GqqF1w+CmCOUU8ncN6++jAA7i_wqibturw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 12, 2021 at 09:49:01AM -0400, Olga Kornievskaia wrote:
> On Wed, May 12, 2021 at 9:40 AM Olga Kornievskaia <
> olga.kornievskaia@gmail.com> wrote:
> 
> > On Wed, May 12, 2021 at 9:37 AM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > > On Wed, May 12, 2021 at 6:42 AM Dan Aloni <dan@kernelim.com> wrote:
> > >> On Tue, Apr 27, 2021 at 08:12:53AM -0400, Olga Kornievskaia wrote:
> > >> > On Tue, Apr 27, 2021 at 12:42 AM Dan Aloni <dan@kernelim.com> wrote:
> > >> > > On Mon, Apr 26, 2021 at 01:19:43PM -0400, Olga Kornievskaia wrote:
> > >> > > > From: Olga Kornievskaia <kolga@netapp.com>
> > >> > > >
> > >> > > > An rpc client uses a transport switch and one ore more transports
> > >> > > > associated with that switch. Since transports are shared among
> > >> > > > rpc clients, create a symlink into the xprt_switch directory
> > >> > > > instead of duplicating entries under each rpc client.
> > >> > > >
> > >> > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > >> > > >
> > >> > > >..
> > >> > > > @@ -188,6 +204,11 @@ void rpc_sysfs_client_destroy(struct
> > rpc_clnt *clnt)
> > >> > > >       struct rpc_sysfs_client *rpc_client = clnt->cl_sysfs;
> > >> > > >
> > >> > > >       if (rpc_client) {
> > >> > > > +             char name[23];
> > >> > > > +
> > >> > > > +             snprintf(name, sizeof(name), "switch-%d",
> > >> > > > +                      rpc_client->xprt_switch->xps_id);
> > >> > > > +             sysfs_remove_link(&rpc_client->kobject, name);
> > >> > >
> > >> > > Hi Olga,
> > >> > >
> > >> > > If a client can use a single switch, shouldn't the name of the
> > symlink
> > >> > > be just "switch"? This is to be consistent with other symlinks in
> > >> > > `sysfs` such as the ones in block layer, for example in my
> > >> > > `/sys/block/sda`:
> > >> > >
> > >> > >     bdi -> ../../../../../../../../../../../virtual/bdi/8:0
> > >> > >     device -> ../../../5:0:0:0
> > >> >
> > >> > I think the client is written so that in the future it might have more
> > >> > than one switch?
> > >>
> > >> I wonder what would be the use for that, as a switch is already
> > collection of
> > >> xprts. Which would determine the switch to use per a new task IO?
> > >
> > >
> > > I thought the switch is a collection of xprts of the same type. And if
> > you wanted to have an RDMA connection and a TCP connection to the same
> > server, then it would be stored under different switches? For instance we
> > round-robin thru the transports but I don't see why we would be doing so
> > between a TCP and an RDMA transport. But I see how a client can totally
> > switch from an TCP based transport to an RDMA one (or a set of transports
> > and round-robin among that set). But perhaps I'm wrong in how I'm thinking
> > about xprt_switch and multipathing.
> >
> > <looks like my reply bounced so trying to resend>
> >
> 
> And more to answer your question, we don't have a method to switch between
> different xprt switches. But we don't have a way to specify how to mount
> with multiple types of transports. Perhaps sysfs could be/would be a way to
> switch between the two. Perhaps during session trunking discovery, the
> server can return back a list of IPs and types of transports. Say all IPs
> would be available via TCP and RDMA, then the client can create a switch
> with RDMA transports and another with TCP transports, then perhaps there
> will be a policy engine that would decide which one to choose to use to
> begin with. And then with sysfs interface would be a way to switch between
> the two if there are problems.

You raise a good point, also relevant to the ability to dynamically add
new transports on the fly with the sysfs interface - their protocol type
may be different.

Returning to the topic of multiple switches per client, I recall that a
few times it was hinted that there is an intention to have the
implementation details of xprtswitch be modified to be loadable and
pluggable with custom algorithms.  And if we are going in that
direction, I'd expect the advanced transport management and request
routing can be below the RPC client level, where we have example uses:

1) Optimizations in request routing that I've previously written about
(based on request data memory).

2) If we lift the restriction of multiple protocol types on the same
xprtswitch on one switch, then we can also allow for the implementation
'RDMA-by-default with TCP failover on standby' similar to what you
suggest, but with one switch maintaining two lists behind the scenes.

-- 
Dan Aloni
