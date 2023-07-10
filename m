Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6A74DD5A
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 20:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGJSa3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 14:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjGJSa1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 14:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEE7AB
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689013784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f3y6mVNpE1bg5ezhjzrHAL9l+yUxshywg5Q3oSpoRVQ=;
        b=D1c7ZvKIAqJVsMpwnwkUlWEqlxTqeoIg3NfqQwrhahBu5Ggj/oW/8QKHoq0TpC+1fEz9UD
        +TQqrRbyxp5vrLbCL5VDvpG+aedFh91cth21uyJiP8GpAc8Woqcc3JzjJTwnjloUXIZRTN
        BgWA0zPKYzSfhoK/qb1vxAUnVbQTtx0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-fQi0giIpMECZEUMRn8gx8Q-1; Mon, 10 Jul 2023 14:29:43 -0400
X-MC-Unique: fQi0giIpMECZEUMRn8gx8Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635dd236b63so37053476d6.0
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 11:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689013783; x=1691605783;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3y6mVNpE1bg5ezhjzrHAL9l+yUxshywg5Q3oSpoRVQ=;
        b=TgBZq75rKQw+izKnxiGeDCtZysc8nYtgD5v/ZSx73QGPH3XxjBaxRuHCgl5RtmzHpy
         mP3holX8cJEl48NuyWm+4/pep1umOFyEHzAVzhP8QeLIBjzcoyU7GKySeAHfkRqEcD9m
         XuZv7Q904RW1Ah5TA/du1vzBIHqTds2NqnY9NR7K1WLJthljYnbWbGcdpIP9UguPzleI
         5DVV8MR80AQ5MkA3QAmlI2HrJm9nN/9uCrxmG8lccFyaNlCpZdK4SGKK1bFE5Abdphh9
         TffvFacRxtNoMB39j7kM7NFcAweZ9qQ7eXAZrF82LaqgZ6PFNPqJlJZWLfXAXm6bw+Ei
         3PAA==
X-Gm-Message-State: ABy/qLan2KItVXPznKjcNjdZY5n4G1PpqL025ozItR+ZmfnYyfkJGGvB
        n5ghvivN8xN4ponZB6QA2XfXkwdS7K5JP9Uzfw9MlthCLzC78kA3xaSAagRuz5ix4KeTjC3Zsk4
        3CTz77MBAd8XfrVyg2LWe
X-Received: by 2002:a0c:8cc7:0:b0:635:9cf4:fb0 with SMTP id q7-20020a0c8cc7000000b006359cf40fb0mr16417289qvb.27.1689013783295;
        Mon, 10 Jul 2023 11:29:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQXGaahEn/JhdMn/3VPWg2rFvSjNlrtgHNKWN8ka/TuGhV4Pytq9edn6p5Y20NikJbwEB1SA==
X-Received: by 2002:a0c:8cc7:0:b0:635:9cf4:fb0 with SMTP id q7-20020a0c8cc7000000b006359cf40fb0mr16417272qvb.27.1689013783036;
        Mon, 10 Jul 2023 11:29:43 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id h23-20020a05620a10b700b0076227222e49sm128596qkk.6.2023.07.10.11.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:29:42 -0700 (PDT)
Message-ID: <132490dda81e93b2f5145ee210167b4c3d0d2cd1.camel@redhat.com>
Subject: Re: [PATCH v3 0/9] SUNRPC service thread scheduler optimizations
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, david@fromorbit.com
Date:   Mon, 10 Jul 2023 14:29:41 -0400
In-Reply-To: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
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

On Mon, 2023-07-10 at 12:41 -0400, Chuck Lever wrote:
> Walking a linked list to find an idle thread is not CPU cache-
> friendly, and in fact I've noted palpable per-request latency
> impacts as the number of nfsd threads on the server increases.
>=20
> After discussing some possible improvements with Jeff at LSF/MM,
> I've been experimenting with the following series. I've measured an
> order of magnitude latency improvement in the thread lookup time,
> and have managed to keep the whole thing lockless.
>=20
> This version of the series addresses Neil's earlier comments and=20
> is robust under load. The first 7 patches in this series seem
> uncontroversial, so I'll push them to the=20
> "topic-sunrpc-thread-scheduling" branch of:=20
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> The last two are still under discussion. They are posted as part
> of this series for comparison to other proposals, but are not yet=20
> included in the topic branch. But they are tested and working.
>=20
>=20
> Changes since v2:=20
> * Dropped the patch that converts sp_lock to a simple spinlock
> * Replaced explicit memory barriers in svc_get_next_xprt()
> * Select thread victims from the other end of the bitmap
> * Added a metric for wake-ups that find nothing on the transport queue
>=20
> Changes since RFC:
> * Add a counter for ingress RPC messages
> * Add a few documenting comments
> * Move the more controversial patches to the end of the series
> * Clarify the refactoring of svc_wake_up()=20
> * Increase the value of RPCSVC_MAXPOOLTHREADS to 4096 (and tested with th=
at many threads)
> * Optimize the loop in svc_pool_wake_idle_thread()
> * Optimize marking a thread "idle" in svc_get_next_xprt()
>=20
> ---
>=20
> Chuck Lever (9):
>       SUNRPC: Deduplicate thread wake-up code
>       SUNRPC: Report when no service thread is available.
>       SUNRPC: Split the svc_xprt_dequeue tracepoint
>       SUNRPC: Count ingress RPC messages per svc_pool
>       SUNRPC: Count pool threads that were awoken but found no work to do
>       SUNRPC: Clean up svc_set_num_threads
>       SUNRPC: Replace dprintk() call site in __svc_create()
>       SUNRPC: Replace sp_threads_all with an xarray
>       SUNRPC: Convert RQ_BUSY into a per-pool bitmap
>=20
>=20
>  fs/nfsd/nfssvc.c              |   3 +-
>  include/linux/sunrpc/svc.h    |  19 ++--
>  include/trace/events/sunrpc.h | 159 ++++++++++++++++++++++++++----
>  net/sunrpc/svc.c              | 177 ++++++++++++++++++++++------------
>  net/sunrpc/svc_xprt.c         |  99 ++++++++++---------
>  5 files changed, 323 insertions(+), 134 deletions(-)
>=20
> --
> Chuck Lever
>=20

You can add my Reviewed-by to the first 7 patches. The last two are not
quite there yet, I think, but I like how they're looking so far.

Cheers,
--=20
Jeff Layton <jlayton@redhat.com>

