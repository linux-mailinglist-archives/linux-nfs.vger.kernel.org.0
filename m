Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADF174ED1A
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 13:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGKLnw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 07:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGKLnt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 07:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC30171F
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689075776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQkMEVJiyHwnoXu2GXNfGkCF7kNPY2avIDBSiikWIVs=;
        b=bwJYhbpgQcwaa2ByjeRBofnXA7W90ePl0QPV5I++W5hexgtGbuHxP2dwtIcV+Rflnl+cM/
        MoylUdhZscazCDAs8DomfTbBZ9137SNwoNVkG3LlBnWsoeFrlQ3ZII0lLLs60uSqHGYd2e
        6o+QDMN3+h2cTa6kjmXZ75eN0vKnHv4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-xIcnVvjoPhy9Y8p1EfpStA-1; Tue, 11 Jul 2023 07:42:52 -0400
X-MC-Unique: xIcnVvjoPhy9Y8p1EfpStA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635f12395b5so51566836d6.3
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 04:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689075771; x=1691667771;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQkMEVJiyHwnoXu2GXNfGkCF7kNPY2avIDBSiikWIVs=;
        b=bTxyXfPEzGTuqKwFHX244qX+tMDn3bigvLF5NBj9itv21SywT1PR+arDfam8ro3yMc
         c5xJNPpYjwWhNZIDboSCnj7PRflg8R/gSiLOxBE8KX/HI2kRCqTSlwWHBGd7xUZhB0Vh
         FfT1dNt3G1LnD1bjF4kfiLNJquaKQaodIAWOYWomvOkxTJtb+A5DRG2kgawqdPHf1SBh
         fKp9uc+2evCkgIMlyyJPJqIO0d5NeL0vEd5RqQMqOD/E1sET66yY0AyiLMV5WbakQSPd
         Yx8ERx8ThIwNQZYOg2Uehb8lJg/iE5Y0ZQC7UKzF9FRJU3Fpl6kBdRPiuDvuY6N8Xpp6
         RsvQ==
X-Gm-Message-State: ABy/qLZI3jAgASXZRGbiEKso3+xKaSVSYVEBBwWwxhBGV3zYdyrPuAAE
        N9lo5wPT+zkTpZWrC8TF3MUe19yN8nfpzn77xgL0LFsQ9SJz+W9m7rivhDVs3yjCwFhUsJYgi32
        e9ePsCZYweiqUwrp4hceR
X-Received: by 2002:a0c:dd92:0:b0:62f:f071:65fc with SMTP id v18-20020a0cdd92000000b0062ff07165fcmr12955947qvk.1.1689075771724;
        Tue, 11 Jul 2023 04:42:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGYeVqzrW38VHhyVRkXetA4WDVKvHa+sYPIAETihDgff1C59fo6vN23Lkuimo/17cOjkM/K8w==
X-Received: by 2002:a0c:dd92:0:b0:62f:f071:65fc with SMTP id v18-20020a0cdd92000000b0062ff07165fcmr12955937qvk.1.1689075771457;
        Tue, 11 Jul 2023 04:42:51 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id d22-20020a0cb2d6000000b00631fea4d5bcsm966115qvf.95.2023.07.11.04.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 04:42:51 -0700 (PDT)
Message-ID: <18061cab9338b08da691e8651e75f8fe8e88b830.camel@redhat.com>
Subject: Re: [PATCH v3 5/9] SUNRPC: Count pool threads that were awoken but
 found no work to do
From:   Jeff Layton <jlayton@redhat.com>
To:     NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>
Date:   Tue, 11 Jul 2023 07:42:49 -0400
In-Reply-To: <168906929382.8939.6551236368797730920@noble.neil.brown.name>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
        , <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>
        , <168902815363.8939.4838920400288577480@noble.neil.brown.name>
        , <D20E4286-30D2-461D-B856-41D3C53C756C@oracle.com>
         <168906929382.8939.6551236368797730920@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-11 at 19:54 +1000, NeilBrown wrote:
> On Tue, 11 Jul 2023, Chuck Lever III wrote:
> >=20
> > > On Jul 10, 2023, at 6:29 PM, NeilBrown <neilb@suse.de> wrote:
> > >=20
> > > On Tue, 11 Jul 2023, Chuck Lever wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > >=20
> > > > Measure a source of thread scheduling inefficiency -- count threads
> > > > that were awoken but found that the transport queue had already bee=
n
> > > > emptied.
> > > >=20
> > > > An empty transport queue is possible when threads that run between
> > > > the wake_up_process() call and the woken thread returning from the
> > > > scheduler have pulled all remaining work off the transport queue
> > > > using the first svc_xprt_dequeue() in svc_get_next_xprt().
> > >=20
> > > I'm in two minds about this.  The data being gathered here is
> > > potentially useful
> >=20
> > It's actually pretty shocking: I've measured more than
> > 15% of thread wake-ups find no work to do.
>=20
> That is a bigger number than I would have guessed!
>=20

I'm guessing the idea is that the receiver is waking a thread to do the
work, and that races with one that's already running? I'm sure there are
ways we can fix that, but it really does seem like we're trying to
reinvent workqueues here.

> >=20
> >=20
> > > - but who it is useful to?
> > > I think it is primarily useful for us - to understand the behaviour o=
f
> > > the implementation so we can know what needs to be optimised.
> > > It isn't really of any use to a sysadmin who wants to understand how
> > > their system is performing.
> > >=20
> > > But then .. who are tracepoints for?  Developers or admins?
> > > I guess that fact that we feel free to modify them whenever we need
> > > means they are primarily for developers?  In which case this is a goo=
d
> > > patch, and maybe we'll revert the functionality one day if it turns o=
ut
> > > that we can change the implementation so that a thread is never woken
> > > when there is no work to do ....
> >=20
> > A reasonable question to ask. The new "starved" metric
> > is similar: possibly useful while we are developing the
> > code, but not particularly valuable for system
> > administrators.
> >=20
> > How are the pool_stats used by administrators?
>=20
> That is a fair question.  Probably not much.
> Once upon a time we had stats which could show a histogram how thread
> usage.  I used that to decided if the load justified more threads.
> But we removed it because it was somewhat expensive and it was argued it
> may not be all that useful...
> I haven't really looked at any other stats in my work.  Almost always it
> is a packet capture that helps me see what is happening when I have an
> issue to address.
>=20
> Maybe I should just accept that stats are primarily for developers and
> they can be incredible useful for that purpose, and not worry if admins
> might ever need them.
>=20
> >=20
> > (And, why are they in /proc/fs/nfsd/ rather than under
> > something RPC-related?)
>=20
> Maybe because we "owned" /proc/fs/nfsd/, but the RPC-related stuff is
> under "net" and we didn't feel so comfortable sticking new stuff there.
> Or maybe not.
>=20

--=20
Jeff Layton <jlayton@redhat.com>

