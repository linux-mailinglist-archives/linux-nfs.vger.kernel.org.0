Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38F23F9453
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 08:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbhH0GMS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 02:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhH0GMR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 02:12:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6983C061757
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 23:11:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so7345924pjb.1
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 23:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjZzbSc5I0xY1no9c2zIQ2WUAMd36IrJT6/O/M7NEvs=;
        b=swB6sdCSmM2LwXdoviXAPKtwJUrOBTd/10oJZmgA1qk6Jss8pDaa8vvygGk7YOnF48
         4Ns+ABIDVB/XqYBDre8bd4aRGtDEREamDLTk6rcKIZKJEB+ivAw33J/BlYFAvQd0eXwN
         n55Hv8qm57gkimPftfIjpx+OnbSAI5QvTtv3Ev1BOLXHfK2W9nRHtqS0TqLQs6Cv57oC
         k/CdiSqNfIRLxMFh/4B+ZpfsA62ixEPjwrA+Jpz7uwa1C6g4qOXPcwMv2mzlN+EIke4O
         W8ruWP2Y3tCSDQqSWE/BGkm0PMo8KuaMsb+6X1vegptbuQkB1khFeY9kKar2FlyF2l6m
         kN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjZzbSc5I0xY1no9c2zIQ2WUAMd36IrJT6/O/M7NEvs=;
        b=uioV9bHip3SkMOP7nGVEffAlX6hIxkI8jhCZLwkGZ2nyPuRXMtULYB9/VLDSMGfUXO
         mwTEswFFpzzLoUsjjPgSig3nB+3WfxcAfD4K4QCxxTaJntruvu9G7N00R2H0Gn/DGb75
         lFmUQG8LXcLt1LXijc2dhaEncJ8i+/IXeAD3DMbyCewjkFlE7QIJQKneuVRudMlD2wR8
         Y979r16fqPa+kfGE2TBoUUj8IGWOTyl1Ae21h25zfvGkbMDc7xzTSBXr439LJ7VyRZcn
         EaB7eL9czkY9FUavVj25dCMGL6ARNi090IbIyOAWwY8Gnb1fbUuJyKxSEGVEyCUx7RnQ
         Df9A==
X-Gm-Message-State: AOAM5319RyXhnzqXceP9qUpFgJyZIKYXNSY2rk6EzK/bsPPB2swNjq0r
        AN/aFjAzz+94i6Cx+K3Q9erZuMzlUzyFLNZIzYUlX1j83qWLeA==
X-Google-Smtp-Source: ABdhPJx39tIbYD46ipbydG4sOCO9AbaCfz8GRWgdxMdPyiF0+VoYqEb5tZog/QrwA9HbwB7pHSe9MegU5iPM9URXRds=
X-Received: by 2002:a17:90a:509:: with SMTP id h9mr21641534pjh.71.1630044683309;
 Thu, 26 Aug 2021 23:11:23 -0700 (PDT)
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
 <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com>
 <162966962721.9892.5962616727949224286@noble.neil.brown.name>
 <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com>
 <163001427749.7591.7281634750945934559@noble.neil.brown.name>
 <CAOv1SKC+3LXhM+L9MwU2D03bpeof55-g+i=r3SWEjVWcPVCi8Q@mail.gmail.com> <163004202961.7591.12633163545286005205@noble.neil.brown.name>
In-Reply-To: <163004202961.7591.12633163545286005205@noble.neil.brown.name>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Thu, 26 Aug 2021 23:11:12 -0700
Message-ID: <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     NeilBrown <neilb@suse.de>
Cc:     Mel Gorman <mgorman@suse.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Neil:

I am actually compiling a 5.13.13 kernel with the patch that Chuck
suggested earlier right now. I am doing the full compile matching the
distro compile as I don't have a targeted kernel config ready to go
(it's been years), and I want to test like for like anyway. It should
be ready to install in the AM, my time, so I will test with that first
tomorrow and see if it resolves the issue, if not, I will report back
and then try your revert suggestion. On the issue of memory though, my
server has 16GB of memory (and free currently shows ~1GB unused, and
~11GB in buffers/caches), so this really shouldn't be an available
memory issue, but I guess we'll find out.

Thanks for the info.

- mike

On Thu, Aug 26, 2021 at 10:27 PM NeilBrown <neilb@suse.de> wrote:
>
>
> [[Mel: if you read through to the end you'll see why I cc:ed you on this]]
>
> On Fri, 27 Aug 2021, Mike Javorski wrote:
> > I just tried the same mount with 4 different nfsvers values: 3, 4.0, 4.1 and 4.2
> >
> > At first I thought it might be "working" because I only got freezes
> > with 4.2 at first, but I went back and re-tested (to be sure) and got
> > freezes with all 4 versions. So the nfsvers setting doesn't seem to
> > have an impact. I did verify at each pass that the 'nfsvers=' value
> > was present and correct in the mount output.
> >
> > FYI: another user posted on the archlinux reddit with a similar issue,
> > I suggested they try with a 5.12 kernel and that "solved" the issue
> > for them as well.
>
> well... I have good news and I have bad news.
>
> First the good.
> I reviewed all the symptoms again, and browsed the commits between
> working and not-working, and the only pattern that made any sense was
> that there was some issue with memory allocation.  The pauses - I
> reasoned - were most likely pauses while allocating memory.
>
> So instead of testing in a VM with 2G of RAM, I tried 512MB, and
> suddenly the problem was trivial to reproduce.  Specifically I created a
> (sparse) 1GB file on the test VM, exported it over NFS, and ran "md5sum"
> on the file from an NFS client.  With 5.12 this reliably takes about 90 seconds
> (as it does with 2G RAM).  On 5.13 and 512MB RAM, it usually takes a lot
> longer.  5, 6, 7, 8 minutes (and assorted seconds).
>
> The most questionable nfsd/ memory related patch in 5.13 is
>
>  Commit f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page allocator")
>
> I reverted that and now the problem is no longer there.  Gone.  90seconds
> every time.
>
> Now the bad news: I don't know why.  That patch should be a good patch,
> with a small performance improvement, particularly at very high loads.
> (maybe even a big improvement at very high loads).
> The problem must be in alloc_pages_bulk_array(), which is a new
> interface, so not possible to bisect.
>
> So I might have a look at the code next week, but I've cc:ed Mel Gorman
> in case he comes up with some ideas sooner.
>
> For now, you can just revert that patch.
>
> Thanks for all the testing you did!!  It certainly helped.
>
> NeilBrown
>
