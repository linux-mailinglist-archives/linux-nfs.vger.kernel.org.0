Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5D37FB14
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhEMPzH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 11:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhEMPzH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 11:55:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB70DC061574
        for <linux-nfs@vger.kernel.org>; Thu, 13 May 2021 08:53:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g14so31543333edy.6
        for <linux-nfs@vger.kernel.org>; Thu, 13 May 2021 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2OqIHjGtm/MuFrvbcQprR00WCbj+k3KRo69L4HEcCo=;
        b=OYgK5z1uycEkr7E+lf86+gABZXS1nV7lmJSzstaWEXDkryjOc3eTsDINKOP/TWfgof
         1wnRpbl3vMBNpZROzNYEubP48JnxrdFH/XiZL6YtZGRRuSYpx4H/1I4VPuzG9IF1nNgt
         TL0GVX2p6VF8uOn7Md/rrApkkVTzb91rsydLj0Q29PlShvINfuCqAr01F773Ond4Yump
         8lvp/LcVRdaouk6D6WjMWcKl21yc3RmW1ULyQ/30yPdJegQicxSt9eFMIpd8A5bu6ONR
         HhxL9im6QifoatscJc2Hmy+EVkGe4hH6x1kSMhxghOaEcvSZUqH7CdJP5guYkAOYd1Ip
         bRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2OqIHjGtm/MuFrvbcQprR00WCbj+k3KRo69L4HEcCo=;
        b=Ya0rmDOh8I1fGbOMaVcahdGjM0mq51ECgio3QTF85bw/Zel6ri5ZFx+fudnflGliCc
         P0/Xz8X7sL5W7Dx8fc3v9FUj59H9ofX5E8VoshK68Issd9zP5PAdRJDnU7jRNWjtBooo
         5ezvybdP5Uh4wIiIYnV98WzI7lsidRHLuL8zIUTrjmWONMcJfMF5v0Z+pH5qp6PVEFVo
         ZnTT5fUmJsLua7slAU+ZadxwqvmKITuZWLr0HdZUeGT3Allxkay43ZkVFnxDsJdNMScW
         jYmJf7J8TJJh8slNyIQ1b43akguNFhEQbd9pbGgDQ3sHWccNS+Xut7D2JpWCxjrIAmjE
         4M2Q==
X-Gm-Message-State: AOAM532VZ+pj/rb5cGypRTamlV8HA/bpV6TMSpGyT3uLVw32W6uzFxel
        YMGeLdCOchq+pGqnB/vrp1QrU+eS5ri/u3Pvr6M=
X-Google-Smtp-Source: ABdhPJxEMEZ7T0M3MatwAZFpbesvP3C6z9jUnkPvTzzaNySnWeDtDqudF1cH07AM+16cJnUeFxvhlGtJqazrGE/NxLw=
X-Received: by 2002:a05:6402:199:: with SMTP id r25mr50718441edv.128.1620921227430;
 Thu, 13 May 2021 08:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
 <20210426171947.99233-10-olga.kornievskaia@gmail.com> <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
 <CAN-5tyHPHk891-NkHt=6o+OuxRB+0ZqQRKqJ=hFThE=oYM0V7Q@mail.gmail.com>
 <20210512104205.hblxgfiagbod6pis@gmail.com> <CAN-5tyEoaKseyjOLA+ni7rCXG7=MnDKPCC3YN68=SHm9NaC_4A@mail.gmail.com>
 <CAN-5tyHy8VR4apVCH0kFgmvceWynx5ZwngdT3_V6abDXZnmDgg@mail.gmail.com>
 <CAN-5tyG68pQwW_0+GqqF1w+CmCOUU8ncN6++jAA7i_wqibturw@mail.gmail.com>
 <20210512141623.qovczudkan5h6kjz@gmail.com> <c85066f64c19e751c1bdef9344a43037bb674712.camel@hammerspace.com>
 <6F49DAEE-F51F-40D5-866D-A7452126CF41@oracle.com>
In-Reply-To: <6F49DAEE-F51F-40D5-866D-A7452126CF41@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 13 May 2021 11:53:36 -0400
Message-ID: <CAN-5tyGu53inEh7p=DmxVzRoN6gbqOj8jfD8VqGQqk5ahnxZxw@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "dan@kernelim.com" <dan@kernelim.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 13, 2021 at 11:18 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On May 13, 2021, at 11:13 AM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Wed, 2021-05-12 at 17:16 +0300, Dan Aloni wrote:
> >> On Wed, May 12, 2021 at 09:49:01AM -0400, Olga Kornievskaia wrote:
> >>> On Wed, May 12, 2021 at 9:40 AM Olga Kornievskaia <
> >>> olga.kornievskaia@gmail.com> wrote:
> >>>
> >>>> On Wed, May 12, 2021 at 9:37 AM Olga Kornievskaia
> >>>> <olga.kornievskaia@gmail.com> wrote:
> >>>>> On Wed, May 12, 2021 at 6:42 AM Dan Aloni <dan@kernelim.com>
> >>>>> wrote:
> >>>>>> On Tue, Apr 27, 2021 at 08:12:53AM -0400, Olga Kornievskaia
> >>>>>> wrote:
> >>>>>>> On Tue, Apr 27, 2021 at 12:42 AM Dan Aloni <
> >>>>>>> dan@kernelim.com> wrote:
> >>>>>>>> On Mon, Apr 26, 2021 at 01:19:43PM -0400, Olga
> >>>>>>>> Kornievskaia wrote:
> >>>>>>>>> From: Olga Kornievskaia <kolga@netapp.com>
> >>>>>>>>>
> >>>>>>>>> An rpc client uses a transport switch and one ore more
> >>>>>>>>> transports
> >>>>>>>>> associated with that switch. Since transports are
> >>>>>>>>> shared among
> >>>>>>>>> rpc clients, create a symlink into the xprt_switch
> >>>>>>>>> directory
> >>>>>>>>> instead of duplicating entries under each rpc client.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> >>>>>>>>>
> >>>>>>>>> ..
> >>>>>>>>> @@ -188,6 +204,11 @@ void
> >>>>>>>>> rpc_sysfs_client_destroy(struct
> >>>> rpc_clnt *clnt)
> >>>>>>>>>       struct rpc_sysfs_client *rpc_client = clnt-
> >>>>>>>>>> cl_sysfs;
> >>>>>>>>>
> >>>>>>>>>       if (rpc_client) {
> >>>>>>>>> +             char name[23];
> >>>>>>>>> +
> >>>>>>>>> +             snprintf(name, sizeof(name), "switch-%d",
> >>>>>>>>> +                      rpc_client->xprt_switch-
> >>>>>>>>>> xps_id);
> >>>>>>>>> +             sysfs_remove_link(&rpc_client->kobject,
> >>>>>>>>> name);
> >>>>>>>>
> >>>>>>>> Hi Olga,
> >>>>>>>>
> >>>>>>>> If a client can use a single switch, shouldn't the name
> >>>>>>>> of the
> >>>> symlink
> >>>>>>>> be just "switch"? This is to be consistent with other
> >>>>>>>> symlinks in
> >>>>>>>> `sysfs` such as the ones in block layer, for example in
> >>>>>>>> my
> >>>>>>>> `/sys/block/sda`:
> >>>>>>>>
> >>>>>>>>     bdi ->
> >>>>>>>> ../../../../../../../../../../../virtual/bdi/8:0
> >>>>>>>>     device -> ../../../5:0:0:0
> >>>>>>>
> >>>>>>> I think the client is written so that in the future it
> >>>>>>> might have more
> >>>>>>> than one switch?
> >>>>>>
> >>>>>> I wonder what would be the use for that, as a switch is
> >>>>>> already
> >>>> collection of
> >>>>>> xprts. Which would determine the switch to use per a new task
> >>>>>> IO?
> >>>>>
> >>>>>
> >>>>> I thought the switch is a collection of xprts of the same type.
> >>>>> And if
> >>>> you wanted to have an RDMA connection and a TCP connection to the
> >>>> same
> >>>> server, then it would be stored under different switches? For
> >>>> instance we
> >>>> round-robin thru the transports but I don't see why we would be
> >>>> doing so
> >>>> between a TCP and an RDMA transport. But I see how a client can
> >>>> totally
> >>>> switch from an TCP based transport to an RDMA one (or a set of
> >>>> transports
> >>>> and round-robin among that set). But perhaps I'm wrong in how I'm
> >>>> thinking
> >>>> about xprt_switch and multipathing.
> >>>>
> >>>> <looks like my reply bounced so trying to resend>
> >>>>
> >>>
> >>> And more to answer your question, we don't have a method to switch
> >>> between
> >>> different xprt switches. But we don't have a way to specify how to
> >>> mount
> >>> with multiple types of transports. Perhaps sysfs could be/would be
> >>> a way to
> >>> switch between the two. Perhaps during session trunking discovery,
> >>> the
> >>> server can return back a list of IPs and types of transports. Say
> >>> all IPs
> >>> would be available via TCP and RDMA, then the client can create a
> >>> switch
> >>> with RDMA transports and another with TCP transports, then perhaps
> >>> there
> >>> will be a policy engine that would decide which one to choose to
> >>> use to
> >>> begin with. And then with sysfs interface would be a way to switch
> >>> between
> >>> the two if there are problems.
> >>
> >> You raise a good point, also relevant to the ability to dynamically
> >> add
> >> new transports on the fly with the sysfs interface - their protocol
> >> type
> >> may be different.
> >>
> >> Returning to the topic of multiple switches per client, I recall that
> >> a
> >> few times it was hinted that there is an intention to have the
> >> implementation details of xprtswitch be modified to be loadable and
> >> pluggable with custom algorithms.  And if we are going in that
> >> direction, I'd expect the advanced transport management and request
> >> routing can be below the RPC client level, where we have example
> >> uses:
> >>
> >> 1) Optimizations in request routing that I've previously written
> >> about
> >> (based on request data memory).
> >>
> >> 2) If we lift the restriction of multiple protocol types on the same
> >> xprtswitch on one switch, then we can also allow for the
> >> implementation
> >> 'RDMA-by-default with TCP failover on standby' similar to what you
> >> suggest, but with one switch maintaining two lists behind the scenes.
> >>
> >
> > I'm not that interested in supporting multiple switches per client, or
> > any setup that is asymmetric w.r.t. transport characteristics at this
> > time.
> >
> > Any such setup is going to need a policy engine in order to decide
> > which RPC calls can be placed on which set of transports. That again
> > will end up adding a lot of complexity in the kernel itself. I've yet
> > to see any compelling justification for doing so.
>
> I agree -- SMB multi-channel allows TCP+RDMA configurations, and its
> tough to decide how to distribute work across connections and NICs
> that have such vastly different performance characteristics.
>
> I would like to see us crawling and walking before trying to run.

Sounds good folks. I'll remove the multiple switches from the sysfs
infrastructure. v7 coming up.

>
>
> --
> Chuck Lever
>
>
>
