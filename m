Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBA774F1C5
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 16:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjGKOVh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 10:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjGKOVg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 10:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEC91FD7
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689085205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdeN1Hp9W4wPLdDGA6IzqQ5pGaEglZA2vwjVFT47q58=;
        b=JwjmOikZrYX409U3X8Dj3sLtjxtJ9Vn86nnl0MN0WO8/Liz6mR+phXVlkudPsImmFxm2Va
        NdpxqoKFepakfJGMAH6K3GWhzC6PQQVzyBszhQxFSuzTk9GgbClL2tTWEHaIMrvXnBs8EJ
        hSbyozfacYnFzibqZRxHn9lEZp1x0jk=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-QBmsW1bZPfaL0BOFqI50FQ-1; Tue, 11 Jul 2023 10:20:04 -0400
X-MC-Unique: QBmsW1bZPfaL0BOFqI50FQ-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-78cdd5d1e02so780881241.2
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 07:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085203; x=1691677203;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdeN1Hp9W4wPLdDGA6IzqQ5pGaEglZA2vwjVFT47q58=;
        b=c5kR7ZuHdMTKMZ2wAxfR74E8D4C5IM9Os0hgaY590QKW+XUZyy/3c6Tj05yuK9vLCI
         ZVvMiLUnx0ZOkPp5/TqZ9P/+Ic5pUjv9qyfofGcyFqP+h0oCiag3zOInPfMbDjpyCFqx
         zZazgi5/NB2g2KbqnGfOnLTiJ0+DdLx9R4AQrE3+a/CynKSSFgcfEIWaqGr465AdoHxE
         MPTP7TpCu1hJQH0Oce+KE0D5oVMvIN4i8SYP/xBm6/LK7xtQuLpmwSGBdk+j2VDq+JVu
         t1rOOZ8I3FdpJe9AmQtSMceRBvq1gPbv2a0XvXcXez3gkoPOaW0Aq6Nxj5qk/MnI+NXW
         0SDg==
X-Gm-Message-State: ABy/qLaeTaS3IIpyeQVJr+DRd0nj8bQbtmUJZ+xhbtd80Gd4xSjuBIja
        XYzn+XXnW3b8LIcjMwrVBtOaS2YHm9c9cHx0BbDWVcTF/7CCHwo1criVUBE/3L4GEseMvZNMzoH
        GgMdmgy0o0B0ot4eTn5c6y5/PxNDZ
X-Received: by 2002:a05:620a:4052:b0:767:3cfa:dc0f with SMTP id i18-20020a05620a405200b007673cfadc0fmr17008540qko.25.1689084472061;
        Tue, 11 Jul 2023 07:07:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHqKkXrNet5txR8cTBZXgmvFMGumL40AXHGrvCoi2Iou639W5yaPpe5oO+lCq0w0njA/oVnww==
X-Received: by 2002:a05:620a:4052:b0:767:3cfa:dc0f with SMTP id i18-20020a05620a405200b007673cfadc0fmr17008508qko.25.1689084471612;
        Tue, 11 Jul 2023 07:07:51 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id b23-20020a05620a119700b00767e2668536sm513900qkk.17.2023.07.11.07.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:07:51 -0700 (PDT)
Message-ID: <b6dd961f8e4bb43a4a14876ace227d1e3f924463.camel@redhat.com>
Subject: Re: [PATCH v3 5/9] SUNRPC: Count pool threads that were awoken but
 found no work to do
From:   Jeff Layton <jlayton@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>
Date:   Tue, 11 Jul 2023 10:07:50 -0400
In-Reply-To: <168907783478.8939.2524484078705916909@noble.neil.brown.name>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
        , <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>
        , <168902815363.8939.4838920400288577480@noble.neil.brown.name>
        , <D20E4286-30D2-461D-B856-41D3C53C756C@oracle.com>
        , <168906929382.8939.6551236368797730920@noble.neil.brown.name>
        , <18061cab9338b08da691e8651e75f8fe8e88b830.camel@redhat.com>
         <168907783478.8939.2524484078705916909@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-11 at 22:17 +1000, NeilBrown wrote:
> On Tue, 11 Jul 2023, Jeff Layton wrote:
> > On Tue, 2023-07-11 at 19:54 +1000, NeilBrown wrote:
> > > On Tue, 11 Jul 2023, Chuck Lever III wrote:
> > > >=20
> > > > > On Jul 10, 2023, at 6:29 PM, NeilBrown <neilb@suse.de> wrote:
> > > > >=20
> > > > > On Tue, 11 Jul 2023, Chuck Lever wrote:
> > > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > > >=20
> > > > > > Measure a source of thread scheduling inefficiency -- count thr=
eads
> > > > > > that were awoken but found that the transport queue had already=
 been
> > > > > > emptied.
> > > > > >=20
> > > > > > An empty transport queue is possible when threads that run betw=
een
> > > > > > the wake_up_process() call and the woken thread returning from =
the
> > > > > > scheduler have pulled all remaining work off the transport queu=
e
> > > > > > using the first svc_xprt_dequeue() in svc_get_next_xprt().
> > > > >=20
> > > > > I'm in two minds about this.  The data being gathered here is
> > > > > potentially useful
> > > >=20
> > > > It's actually pretty shocking: I've measured more than
> > > > 15% of thread wake-ups find no work to do.
> > >=20
> > > That is a bigger number than I would have guessed!
> > >=20
> >=20
> > I'm guessing the idea is that the receiver is waking a thread to do the
> > work, and that races with one that's already running? I'm sure there ar=
e
> > ways we can fix that, but it really does seem like we're trying to
> > reinvent workqueues here.
>=20
> True.  But then workqueues seem to reinvent themselves every so often
> too.  Once gets the impression they are trying to meet an enormous
> variety of needs.
> I'm not against trying to see if nfsd could work well in a workqueue
> environment, but I'm not certain it is a good idea.  Maintaining control
> of our own thread pools might be safer.
>=20
> I have a vague memory of looking into this in more detail once and
> deciding that it wasn't a good fit, but I cannot recall or easily deduce
> the reason.  Obviously we would have to give up SIGKILL, but we want to
> do that anyway.
>=20
> Would we want unbound work queues - so they can be scheduled across
> different CPUs?  Are NFSD threads cpu-intensive or not?  I'm not sure.
>=20
> I would be happy to explore a credible attempt at a conversion.
>=20

I had some patches several years ago that did a conversion from nfsd
threads to workqueues.=A0

It worked reasonably well, but under heavy loads it didn't perform as
well as having a dedicated threadpool...which is not too surprising,
really. nfsd has been tuned for performance over years and it's fairly
"greedy" about squatting on system resources even when it's idle.

If we wanted to look again at doing this with workqueues, we'd need the
workqueue infrastructure to allow for long-running jobs that may block
for a long time. That means it might need to be more cavalier about
spinning up new workqueue threads and keeping them running when there
are a lot of concurrent, but sleeping workqueue jobs.

We probably would want unbound workqueues so we can have more jobs in
flight at any given time than cpus, given that a lot of them will end up
being blocked in some way or another.

CPU utilization is a good question. Mostly we just call down into the
filesystem to do things, and the encoding and decoding is not _that_ cpu
intensive. For most storage stacks, I suspect we don't use a lot of CPU
aside from normal copying of data.  There might be some exceptions
though, like when the underlying storage is using encryption, etc.

The main upside to switching to workqueues is that it would allow us to
get rid of a lot of fiddly, hand-tuned thread handling code. It might
also make it simpler to convert to a more asynchronous model.

For instance, it would be nice to be able to not have to put a thread to
sleep while waiting on writeback for a COMMIT. I think that'd be easier
to handle with a workqueue-like model.
--=20
Jeff Layton <jlayton@redhat.com>

