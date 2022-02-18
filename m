Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16BD4BC012
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 20:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiBRTFQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 14:05:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbiBRTFO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 14:05:14 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9D341620
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 11:04:57 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p9so17132691ejd.6
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 11:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PZvBUc68OOtGhm1HofBSIyDB6EgKNKMjpjL8U4/HWdA=;
        b=AYmlrxi/7wE2QWpy2UoLTNoCpPPl1+wWbRYeY1OIxdSdukmq2vZGktd9YJfTmxrbNY
         SkX1X5mYjswX6n5dJ1vlrAfGMCdCSBGMihbItjWqq3mRnuMXa0ZVwms+MF3qe8+9i708
         PxFJ9E8G7iqh8gacf7pa4faVWlDl2RJ7hZEAemfDnlipHZdKkwFfJ7WOKUmjOERvgZPp
         zGkD+ES1Wv/J54vA8lb+dxQEeMBd6+N/YK9zfUXDVLWFOjxfSoV/D6LD5Kqufr3k9sDt
         M2yPluNlJ+o/OK6E7w4jfM+w3yfKd70+CBEmLtywLtCVVMlypqL2Js60GfHxg6NzMfSx
         VOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PZvBUc68OOtGhm1HofBSIyDB6EgKNKMjpjL8U4/HWdA=;
        b=OW8zDP3oiYqUlS5p+/NF2t/bHRznwDrc1DN2hn4qptQ6ccKAVV2cnMqD0Pmh4cFPLb
         RemfBlPNdY7oV5JR0fdPxE1M2Iw0kFs0Nb0VWvVyCEF0okyLFjKyZz3mq4ylvknSHb8t
         ll3alVcDCMgbAUZCYKVnQRbvRy/zkgylMJ5On2DsbY9SnXq1vdkBXzy/4CQmAQey2/fd
         IAT84YFZlooQ+zwdnLh/+myKRPQWUJHAHCs7hHBpumIfPvqyw8gPBnGvuamjIeO8MHOj
         bnmN05jSac6AyRktJHjJe8Q2+6DlJgFA+G8KA9f/I+j1/4JhcnW/XAmy5GuumhEmz9mu
         n2AQ==
X-Gm-Message-State: AOAM533D+hOUK3yhaGf5J0j2ZQYY0HCLO6mbMi4TWYIubfBto6lchgZ+
        EQMxN8NSVrUu0Folc79Su8/JU1Z12+0Bdso9Kmg0JkXMHAF6MQ==
X-Google-Smtp-Source: ABdhPJxDJaK/R7niiFSL3G4n2kn/AtYSoXLUwMpKq1a4H1DBL1YrDf5emJAzZx5xA2JOFVY73NsVjaovobLX7R/c1F8=
X-Received: by 2002:a17:906:7d83:b0:6ce:fee:9256 with SMTP id
 v3-20020a1709067d8300b006ce0fee9256mr7598232ejo.647.1645211095636; Fri, 18
 Feb 2022 11:04:55 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGMZh9=Vwcqjh0J4XoTu3stOnKwswdzApL4wCA_usOFV_g@mail.gmail.com>
 <6b528d29-1a9c-d16e-f649-5d994d6222b8@talpey.com>
In-Reply-To: <6b528d29-1a9c-d16e-f649-5d994d6222b8@talpey.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Fri, 18 Feb 2022 19:04:19 +0000
Message-ID: <CAPt2mGOnbN=N5TqCWzVtX7CYoptpknCbnSXGfoX8X87DsvhoKw@mail.gmail.com>
Subject: Re: NFSv4 versus NFSv3 parallel client op/s
To:     Tom Talpey <tom@talpey.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 9 Feb 2022 at 17:38, Tom Talpey <tom@talpey.com> wrote:
>
> On 2/7/2022 1:57 PM, Daire Byrne wrote:
> > Hi,
> >
> > As part of my ongoing investigations into high latency WAN NFS
> > performance with only a single client (for the purposes of then
> > re-exporting), I have been looking at the metadata performance
> > differences between NFSv3 and NFSv4.2.
> >
> > High latency seems to be a particularly good way of highlighting the
> > parallel/concurrency performance limitations with a single NFS client.
> > So I took a client 200ms away from the server and ran things like
> > open() and stat() calls to many files & directories using simultaneous
> > threads (200+) to see how many requests and operations we could keep
> > in flight simultaneously.
> >
> > The executive summary is that NFSv4 is around 10x worse than NFSv3 and
> > an NFSv4 client clearly flatlines at around 180 ops/s with 200ms. By
> > comparison, an NFSv3 client can do around 1,500 ops/s (access+lookup)
> > with the same test.
> >
> > On paper, NFSv4 is more compelling over the WAN as it should reduce
> > round trips with things like compound operations and delegations, but
> > that's only good if it can do lots of them simultaneously too.
> >
> > Comparing the slot table/xport stats between the two protocols while
> > running the benchmark highlights the difference:
> >
> > NFSv3
> > opts: rw,vers=3D3,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acregmin=
=3D3600,acregmax=3D3600,acdirmin=3D3600,acdirmax=3D3600,hard,nocto,noresvpo=
rt,proto=3Dtcp,nconnect=3D4,timeo=3D600,retrans=3D10,sec=3Dsys,mountaddr=3D=
10.25.22.17,mountvers=3D3,mountport=3D20048,mountproto=3Dudp,fsc,local_lock=
=3Dnone
> > xprt: tcp 0 1 2 0 0 85480 85380 0 6549783 0 102 166291 6296122
> > xprt: tcp 0 1 2 0 0 85827 85727 0 6575842 0 102 149914 6322130
> > xprt: tcp 0 1 2 0 0 85674 85574 0 6577487 0 102 131288 6320278
> > xprt: tcp 0 1 2 0 0 84943 84843 0 6505613 0 102 182313 6251396
> >
> > NFSv4.2
> > opts: rw,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,acregm=
in=3D3600,acregmax=3D3600,acdirmin=3D3600,acdirmax=3D3600,hard,nocto,noresv=
port,proto=3Dtcp,nconnect=3D4,timeo=3D600,retrans=3D10,sec=3Dsys,clientaddr=
=3D10.25.112.8,fsc,local_lock=3Dnone
> > xprt: tcp 0 0 2 0 0 301 301 0 1439 0 9 80 1058
> > xprt: tcp 0 0 2 0 0 294 294 0 1452 0 10 79 1085
> > xprt: tcp 0 0 2 0 0 292 292 0 1443 0 10 102 1055
> > xprt: tcp 0 0 2 0 0 287 286 0 1407 0 9 64 1067
> >
> > So either we aren't putting things into the slot table quickly enough
> > for it to scale up, or it just isn't scaling for some other reason.
> >
> > The max slots of 101 for NFSv3 and 10 for NFSv4.2 probably accounts
> > for the aggregate difference of 10x I see in benchmarking?
> >
> > I tried increasing the /sys/module/nfs/parameters/max_session_slots
> > from 64 to 128 on the client (modprobe.conf & reboot) but it didn't
> > seem to make much difference. Maybe it's a server side limit then and
> > the lowest is being used:
> >
> > fs/nfsd/stat.h:
> > #define NFSD_SLOT_CACHE_SIZE            2048
> > /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
> > #define NFSD_CACHE_SIZE_SLOTS_PER_SESSION       32
> >
> > I'm sure there are probably good reasons for these values (like
> > stopping a client from hogging the queue) but is this the reason I see
> > such a big difference in the performance of concurrency for a single
> > client over high latencies?
>
> Daire, I'm interested in your results if you increase the server slot
> limits. Remember that the "slot" is an NFSv4.1+ protocol element. In
> NFSv3 and v4.0, there is no protocol-based flow control, so the max
> outstanding RPC counts are effectively the smaller of the client's and
> server's RPC task and/or thread limits, and of course the wire itself.
>
> With a 200msec RTT and a single-threaded workload, you'll get 5 ops/sec,
> times 32 slots that's pretty much the 180 you see. So I'd expect it to
> rise linearly as you scale both ends' slot numbers.

I finally got around to testing this again. I recompiled a server kernel wi=
th:

NFSD_CACHE_SIZE_SLOTS_PER_SESSION=3D256

I ran some more tests and as predicted this helps a lot. Because the
client default for the client's max_sessions_slots=3D64 (where the
server is 32), I saw double the concurrency straightaway.

And then as I increased the client's max_sessions_slots (up to 256) it
kept on improving. I guess I would need to set the server and client
slots to be around 512 to see the same concurrency performance as for
NFSv3 with 200ms.

Which I guess leads on to some questions:
1) Why is NFSD_CACHE_SIZE_SLOTS_PER_SESSION not a tunable? We don't
really want to maintain our own kernel compiles on our RHEL8 servers.
2) Why is the default linux client slot count 64 and the server's is
32? You can tune the linux client down and not up (if using a Linux
server).
3) What would be the recommended and safest way to have a few high
latency clients with increased slots and concurrency?

I'm thinking it would be better to have the server default be higher
and the linux client default be 32 instead to replicate the current
situation. But no doubt there are other storage filers that already
rely on the fact that the Linux client uses 64 (e.g. cloud Netapps and
the like).

It's probably just a lot less hassle to stick with NFSv3 for this kind
of high latency multi process concurrency use case.

Daire
