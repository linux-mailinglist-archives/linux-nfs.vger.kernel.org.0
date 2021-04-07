Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8066B35770B
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 23:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhDGVk5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 17:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhDGVkz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 17:40:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDD1C061760
        for <linux-nfs@vger.kernel.org>; Wed,  7 Apr 2021 14:40:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r22so10103001edq.9
        for <linux-nfs@vger.kernel.org>; Wed, 07 Apr 2021 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0za7HPHMQapSOta7k3LR80h1Lqw4hwZNV5xAFijwUJQ=;
        b=R2ofCnmahhI1fWUZ9TKI8DP4XkwoyYFHodBdMUYDZhhcTytt29M3Pi3kjqH9LPGqKe
         T1Lqc+dFPKsaxItU2p7MRCigRtCyGWsWKFY+RQwlV0fWrnyho+PTYoN+EMB6tB13Rny6
         T7km3qCCMmz+NFwh0jUKtNjZmDtCUJmMI/lqDh0YNTHJqDps9ifXCrSfe+Dtji/+lY9Y
         lNVZPJSmQ/8ANEQxMhVc78o2/fFTMs1SADs6o2soiLQ7jTifMkGEZKbVlzhoOmrA8oYM
         4wgydpmXw0NkQ2rnns6WEajOU23yRWuO1GGPeRlSHwT8QYjo6tOlUVdx/mB1nL3C3g8Z
         cNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0za7HPHMQapSOta7k3LR80h1Lqw4hwZNV5xAFijwUJQ=;
        b=SzOWcwmZZqXQWoEFmoCqYeLcyCEmBqo8OGYTcSD/8y7RhyjX4rNPq81xQyD488sZO0
         wHglg4RHOtHpPQB78iNv6sbY4Lz7HbvLmBTnltXdyzHHJOhdOfULAa4ZZRVitgq2z5B5
         AgUpmROf7Xx8YappfBlgngoGe+WPk4TmqbxuZhgjP8VtMb/rCtX8Oavg42Yzg4jfcXTw
         DMiMDUhiFYjFp1BrqpEch17QknB/fxF+dRPw51GWxFiWNUjKxJ6WOZESy2cd28BjiGa7
         YQeQI9G6axu8UEeZB/Br/o2Qfp0MyieLi2WtDRhxzkkTlo9o/MciJCkwcu2+etPvIssa
         htdg==
X-Gm-Message-State: AOAM5307yZ9o8VX/aEJh3q+pHkJVRaW08x6Vwp6h1cuxn+8bj0BBdtas
        pClKbd7/uaTUW4itWvV4RPcwXtlQCSijm92G8JDl2Uau
X-Google-Smtp-Source: ABdhPJzUma5fV5XDDxXjqhEesXsmAZh8w+JykON6CLXxPgh26Q7nXr6wUnepmC3pxsFgOLwNpeXuFaD9lR4eum4n9e8=
X-Received: by 2002:a05:6402:34c4:: with SMTP id w4mr7211305edc.367.1617831643546;
 Wed, 07 Apr 2021 14:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210402233031.36731-1-dai.ngo@oracle.com> <D85FBDD3-5397-4D47-932D-159AFE2A5E0F@oracle.com>
 <CAN-5tyHVOEr7zZM92PVS0GYJQ2M6rSs6_zqZwuioumQQm7zzUQ@mail.gmail.com>
 <7BED2160-1052-49EE-BB62-6ACF6F84C91C@oracle.com> <CAN-5tyEKqNHmwiMfCpkZrCVYeaO-FH69v5L4Tk_8EsoTfytpVA@mail.gmail.com>
 <01CD778D-57A0-442A-8D1D-5084F0FC2497@oracle.com> <CAN-5tyFEXBiWVbCq0Hgh01W=OVZkdYYAEujSug6biBaU=Ny8Og@mail.gmail.com>
 <99a1f327-ce69-e6eb-39fc-77991bec5b4c@oracle.com> <c16b4437-a554-be60-3c04-fd578b9f88ff@oracle.com>
 <CAN-5tyGS0ZO4PtTseLSmC4=fYQCUwMs6FB509g2PSCg1v+jySg@mail.gmail.com>
 <0b0c7c79-d593-c4ae-db9b-46600f2cea28@oracle.com> <CAN-5tyGw8_xOfMM4PNUCvo_wKEHs5NgLo3ZQf-sTGb6FHJ_r8Q@mail.gmail.com>
 <3b6e1b4f-4276-e503-9432-e15a339cac9f@oracle.com>
In-Reply-To: <3b6e1b4f-4276-e503-9432-e15a339cac9f@oracle.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 7 Apr 2021 17:40:32 -0400
Message-ID: <CAN-5tyG7HPQxAK-o-q8=_-wtewBcymian2AQV__p=HgL+jJPcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's export.
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 7, 2021 at 4:16 PM <dai.ngo@oracle.com> wrote:
>
>
> On 4/7/21 12:01 PM, Olga Kornievskaia wrote:
> > On Wed, Apr 7, 2021 at 1:13 PM <dai.ngo@oracle.com> wrote:
> >>
> >> On 4/7/21 9:30 AM, Olga Kornievskaia wrote:
> >>> On Tue, Apr 6, 2021 at 9:23 PM <dai.ngo@oracle.com> wrote:
> >>>> On 4/6/21 6:12 PM, dai.ngo@oracle.com wrote:
> >>>>> On 4/6/21 1:43 PM, Olga Kornievskaia wrote:
> >>>>>> On Tue, Apr 6, 2021 at 3:58 PM Chuck Lever III
> >>>>>> <chuck.lever@oracle.com> wrote:
> >>>>>>>> On Apr 6, 2021, at 3:57 PM, Olga Kornievskaia
> >>>>>>>> <olga.kornievskaia@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> On Tue, Apr 6, 2021 at 3:43 PM Chuck Lever III
> >>>>>>>> <chuck.lever@oracle.com> wrote:
> >>>>>>>>>> On Apr 6, 2021, at 3:41 PM, Olga Kornievskaia
> >>>>>>>>>> <olga.kornievskaia@gmail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Tue, Apr 6, 2021 at 12:33 PM Chuck Lever III
> >>>>>>>>>> <chuck.lever@oracle.com> wrote:
> >>>>>>>>>>>> On Apr 2, 2021, at 7:30 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> Hi,
> >>>>>>>>>>>>
> >>>>>>>>>>>> Currently the source's export is mounted and unmounted on every
> >>>>>>>>>>>> inter-server copy operation. This causes unnecessary overhead
> >>>>>>>>>>>> for each copy.
> >>>>>>>>>>>>
> >>>>>>>>>>>> This patch series is an enhancement to allow the export to remain
> >>>>>>>>>>>> mounted for a configurable period (default to 15 minutes). If the
> >>>>>>>>>>>> export is not being used for the configured time it will be
> >>>>>>>>>>>> unmounted
> >>>>>>>>>>>> by a delayed task. If it's used again then its expiration time is
> >>>>>>>>>>>> extended for another period.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Since mount and unmount are no longer done on each copy request,
> >>>>>>>>>>>> this overhead is no longer used to decide whether the copy should
> >>>>>>>>>>>> be done with inter-server copy or generic copy. The threshold used
> >>>>>>>>>>>> to determine sync or async copy is now used for this decision.
> >>>>>>>>>>>>
> >>>>>>>>>>>> -Dai
> >>>>>>>>>>>>
> >>>>>>>>>>>> v2: fix compiler warning of missing prototype.
> >>>>>>>>>>> Hi Olga-
> >>>>>>>>>>>
> >>>>>>>>>>> I'm getting ready to shrink-wrap the initial NFSD v5.13 pull
> >>>>>>>>>>> request.
> >>>>>>>>>>> Have you had a chance to review Dai's patches?
> >>>>>>>>>> Hi Chuck,
> >>>>>>>>>>
> >>>>>>>>>> I apologize I haven't had the chance to review/test it yet. Can I
> >>>>>>>>>> have
> >>>>>>>>>> until tomorrow evening to do so?
> >>>>>>>>> Next couple of days will be fine. Thanks!
> >>>>>>>>>
> >>>>>>>> I also assumed there would be a v2 given that kbot complained about
> >>>>>>>> the NFSD patch.
> >>>>>>> This is the v2 (see Subject: )
> >>>>>> Sigh. Thank you. I somehow missed v2 patches themselves and only saw
> >>>>>> the originals. Again I'll test/review the v2 by the end of the day
> >>>>>> tomorrow!
> >>>>>>
> >>>>>> Actually a question for Dai: have you done performance tests with your
> >>>>>> patches and can show that small copies still perform? Can you please
> >>>>>> post your numbers with the patch series? When we posted the original
> >>>>>> patch set we did provide performance numbers to support the choices we
> >>>>>> made (ie, not hurting performance of small copies).
> >>>>> Currently the source and destination export was mounted with default
> >>>>> rsize of 524288 and the patch uses threshold of (rsize * 2 = 1048576)
> >>>>> to decide whether to do inter-server copy or generic copy.
> >>>>>
> >>>>> I ran performance tests on my test VMs, with and without the patch,
> >>>>> using 4 file sizes 1048576, 1049490, 2048000 and 7341056 bytes. I ran
> >>>>> each test 5 times and took the average. I include the results of 'cp'
> >>>>> for reference:
> >>>>>
> >>>>> size            cp          with patch                  without patch
> >>>>> ----------------------------------------------------------------
> >>>>> 1048576  0.031    0.032 (generic)             0.029 (generic)
> >>>>> 1049490  0.032    0.042 (inter-server)      0.037 (generic)
> >>>>> 2048000  0.051    0.047 (inter-server)      0.053 (generic)
> >>>>> 7341056  0.157    0.074 (inter-server)      0.185 (inter-server)
> >>>>> ----------------------------------------------------------------
> >>>> Sorry, times are in seconds.
> >>> Thank you for the numbers. #2 case is what I'm worried about.
> >> Regarding performance numbers, the patch does better than the original
> >> code in #3 and #4 and worse then original code in #1 and #2. #4 run
> >> shows the benefit of the patch when doing inter-copy. The #2 case can
> >> be mitigated by using a configurable threshold. In general, I think it's
> >> more important to have good performance on large files than small files
> >> when using inter-server copy.  Note that the original code does not
> >> do well with small files either as shown above.
> > I think the current approach tries to be very conservative to achieve
> > the goal of never being worse than the cp. I'm not sure what you mean
> > that current code doesn't do well with small files. For small files it
> > falls back to the generic copy.
>
> In this table, the only advantage the current code has over 'cp' is
> run 1 which I don't know why. The rest is slower than 'cp'. I don't
> have the size of the copy where the inter-copy in the current code
> starts showing better performance yet, but even at ~7MB it is still
> slower than 'cp'. So for any size that is smaller than 7MB+, the
> inter-server copy will be slower than 'cp'. Compare that with the
> patch, the benefit of inter-server copy starts at ~2MB.

I went back to Jorge Mora's perf numbers we posted. You are right, we
did report perf degradation for any copies smaller than 16MB for when
we didn't cap the copy size to be at least 14*rsize (I think the
assumption was that rsize=1M and making it 14M). I'm just uneasy to
open it to even smaller sizes. I think we should explicitly change it
to 16MB instead of removing the restriction. Again I think the policy
we want it to do no worse than cp.

> >>> I don't believe the code works. In my 1st test doing "nfstest_ssc
> >>> --runtest inter01" and then doing it again. What I see from inspecting
> >>> the traces is that indeed unmount doesn't happen but for the 2nd copy
> >>> the mount happens again.
> >>>
> >>> I'm attaching the trace. my servers are .114 (dest), .110 (src). my
> >>> client .68. The first run of "inter01" places a copy in frame 364.
> >>> frame 367 has the beginning of the "mount" between .114 and .110. then
> >>> read happens. then a copy offload callback happens. No unmount happens
> >>> as expected. inter01 continues with its verification and clean up. By
> >>> frame 768 the test is done. I'm waiting a bit. So there is a heatbeat
> >>> between the .114 and .110 in frame 769. Then the next run of the
> >>> "inter01", COPY is placed in frame 1110. The next thing that happens
> >>> are PUTROOTFH+bunch of GETATTRs that are part of the mount. So what is
> >>> the saving here? a single EXCHANGE_ID? Either the code doesn't work or
> >>> however it works provides no savings.
> >> The saving are EXCHANGE_ID, CREATE_SESSION, RECLAIM COMPLETE,
> >> DESTROY_SESSION and DESTROY_CLIENTID for *every* inter-copy request.
> >> The saving is reflected in the number of #4 test run above.
> > Can't we do better than that? Since you are keeping a list of umounts,
> > can't they be searched before doing the vfs_mount() and instead get
> > the mount structure from the list (and not call the vfs_mount at all)
> > and remove it from the umount list (wouldn't that save all the calls)?
>
> I thought about this. My problem here is that we don't have much to key
> on to search the list. The only thing in the COPY argument can be used
> for this purpose is the list of IP addresses of the source server.
> I think that is not enough, there can be multiple exports from the
> same server, how do we find the right one? it can get complicated.
> I'm happy to consider any suggestion you have for this.

I believe an IP address is exactly what's needed for keying. Each of
those "mounts" to the same server is shared (that's normal behaviour
for the client) -- meaning there is just   1 "mount" for a given IP
(there is a single nfs4_client structure).

> I think the patch is an improvement, in performance for copying large
> files (if you consider 2MB file is large) and for removing the bug
> of computing overhead in __nfs4_copy_file_range. Note that we can
> always improve it and not necessary doing it all at once.

I don't think saving 3 RPCs out of 14 is a good enough improvement
when it can be made to save them all (unless you can convince me that
we can't save all 14).

>
> -Dai
>
> >
> >> Note that the overhead of the copy in the current code includes mount
> >> *and* unmount. However the threshold computed in __nfs4_copy_file_range
> >> includes only the guesstimated mount overhead and not the unmount
> >> overhead so it not correct.
> >>
> >> -Dai
> >>
> >>
> >>> Honestly I don't understand the whole need of a semaphore and all.
> >> The semaphore is to prevent the export to be unmounted while it's
> >> being used.
> >>
> >> -Dai
> >>
> >>> My
> >>> approach that I tried before was to create a delayed work item but I
> >>> don't recall why I dropped it.
> >>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-nfs/patch/20170711164416.1982-43-kolga@netapp.com/__;!!GqivPVa7Brio!Jl5Wq7nrFUsaUQjgLJoSuV-cDlvbPaav3x8nXQcRhAdxjVEoWvK24sNgoE82Zg$
> >>>
> >>>
> >>>> -Dai
> >>>>
> >>>>> Note that without the patch, the threshold to do inter-server
> >>>>> copy is (524288 * 14 = 7340032) bytes. With the patch, the threshold
> >>>>> to do inter-server is (524288 * 2 = 1048576) bytes, same as
> >>>>> threshold to decide to sync/async for intra-copy.
> >>>>>
> >>>>>> While I agree that delaying the unmount on the server is beneficial
> >>>>>> I'm not so sure that dropping the client restriction is wise because
> >>>>>> the small (singular) copy would suffer the setup cost of the initial
> >>>>>> mount.
> >>>>> Right, but only the 1st copy. The export remains to be mounted for
> >>>>> 15 mins so subsequent small copies do not incur the mount and unmount
> >>>>> overhead.
> >>>>>
> >>>>> I think ideally we want the server to do inter-copy only if it's faster
> >>>>> than the generic copy. We can probably come up with a number after some
> >>>>> testing and that number can not be based on the rsize as it is now since
> >>>>> the rsize can be changed by mount option. This can be a fixed number,
> >>>>> 1M/2M/etc, and it should be configurable. What do you think? I'm open
> >>>>> to any other options.
> >>>>>
> >>>>>>     Just my initial thoughts...
> >>>>> Thanks,
> >>>>> -Dai
> >>>>>
> >>>>>>> --
> >>>>>>> Chuck Lever
> >>>>>>>
> >>>>>>>
> >>>>>>>
