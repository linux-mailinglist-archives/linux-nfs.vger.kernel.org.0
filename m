Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3D3F3D67
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Aug 2021 06:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhHVEGm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Aug 2021 00:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHVEGl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Aug 2021 00:06:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5725FC061575
        for <linux-nfs@vger.kernel.org>; Sat, 21 Aug 2021 21:06:01 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 18so12315084pfh.9
        for <linux-nfs@vger.kernel.org>; Sat, 21 Aug 2021 21:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynnUJVnDOgOUYxbX2QuOPzSIuIDB0BPSV5utZU4Rqmc=;
        b=KtbeapSzzpuyhQWfVtEkIqQgY1UEOc9uHXo/YrWVHL1vxWP3EEDNL6oKFTzRdQOxem
         NOEumaoSf8rGKNg3IQu0QKVvonDwGe6uSSmfQVPjTNpl6SdN2OB99Ju717PrYweETi5W
         pBJduNRjV6IQXWVB+DFUlxlpsCaDGHgzDF0eUfuNubJqVPE6H3oOLMhv/ksTffw7I+/5
         l6k9CU0eh0av1oAwune0ZhVVvEwJyj4EKeXw86b1BB3Pw4KfbWMDgu3bk9qF1i9s+Jps
         B4xnGxjKUrv6Hz+mWmD+kpqtuTwvxHM9lcrjmfY1SgcPXbhlR+4JAYwhh8w3PzJKfpli
         uCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynnUJVnDOgOUYxbX2QuOPzSIuIDB0BPSV5utZU4Rqmc=;
        b=fjNlDCS/mlG/hOpURtpzBFBQBLc3AoXMP4l7FGduK6tBin+3kswBHn6x6LfG/yt6tC
         7Swjm9Lf4Im3W5hDGhjW1lAn+keO+0+Gy7vbVYT7TFIjhune5wLtVP/SFbMWGUMCLIsb
         vbNReVE20GRSRAkUNGPYhKEUL72u0ECy0FntEq6qZwCpglE1u+QxQrDI0gPzJhc1qdur
         XYU5w07ZDUnBEDyNur6VoBcDbNsY8WC9j/rZnHaT3qcnnzgkRWtNdmmOmWiz7rU/yeQ+
         G6lIg2uAxNVTTd9DntV9g7xJBNwD0UPotMWBhVUVqksi/fv6MyMiD960uJrxejcX8+d7
         amOg==
X-Gm-Message-State: AOAM533O71cpYxTkMberV8rq+DV6DEOpJWd8pU/zyV1LixYfK4DwBYbn
        MAATJtdB+HRak/b2cle6r/r5jAxNBPqItqyKQRY=
X-Google-Smtp-Source: ABdhPJwawrw9Ypuql9CJmG+catoXApUPDzKo5bVXW4ZyCB9+QiaWFQBel/fCkgdvhP/L3eWGZuQzjVYe8lWdeNXCKWc=
X-Received: by 2002:a65:4486:: with SMTP id l6mr25719213pgq.145.1629605160674;
 Sat, 21 Aug 2021 21:06:00 -0700 (PDT)
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
 <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com> <162960371884.9892.13803244995043191094@noble.neil.brown.name>
In-Reply-To: <162960371884.9892.13803244995043191094@noble.neil.brown.name>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Sat, 21 Aug 2021 21:05:49 -0700
Message-ID: <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

5.12.15-arch1:
===============
14723 137 0.00921938

5.13.12-arch1: (no freezes)
===============
15333 206 0.013257

5.13.12-arch1: (with freezes)
===============
9230 299 0.0313779

So a decent bump w/ 5.13, and even more with the freezes.
This machine is an older Opteron server w/ nforce networking. Not sure
how much offloading it actually does.

- mike

On Sat, Aug 21, 2021 at 8:42 PM NeilBrown <neilb@suse.de> wrote:
>
> On Sun, 22 Aug 2021, Mike Javorski wrote:
> > OK, so new/fresh captures, reading the same set of files via NFS in
> > roughly the same timing/sequence (client unchanged between runs)
> >
> > 5.12.15-arch1:
> > ===============
> > 0.042320 124082
> > 0.042594 45837
> > 0.043176 19598
> > 0.044092 63667
> > 0.044613 28192
> > 0.045045 131268
> > 0.045982 116572
> > 0.058507 162444
> > 0.369620 153520
> > 0.825167 164682
> >
> > 5.13.12-arch1: (no freezes)
> > ===============
> > 0.040766 12679
> > 0.041565 64532
> > 0.041799 55440
> > 0.042091 159640
> > 0.042105 75075
> > 0.042134 177776
> > 0.042706 40
> > 0.043334 35322
> > 0.045480 183618
> > 0.204246 83997
> >
> > Since I didn't get any freezes, I waited a bit, tried again and got a
> > capture with several freezes...
> >
> > 5.13.12-arch1: (with freezes)
> > ===============
> > 0.042143 55425
> > 0.042252 64787
> > 0.042411 57362
> > 0.042441 34461
> > 0.042503 67041
> > 0.042553 64812
> > 0.042592 55179
> > 0.042715 67002
> > 0.042835 66977
> > 0.043308 64849
> >
> > Not sure what to make of this, but to my (admittedly untrainted) eye,
> > the two 5.13.12 sets are very similar to each other as well as to the
> > 5.12.15 sample, I am not sure if this is giving any indication to what
> > is causing the freezes.
>
> In the trace that I have, most times (242 of 245) were 0.000360 or less.
> Only 3 were greater.
> As your traces are much bigger you naturally have more that are great -
> all of the last 10 and probably more.
>
> I has hoping that 5.12 wouldn't show any large delays, but clearly it
> does.  However it is still possible that there are substantially fewer.
>
> Rather than using tail, please pipe the list of times into
>
>  awk '$1 < 0.001 { fast +=1 } $1 >= 0.001 {slow += 1} END { print fast, slow, slow / (fast + slow) }'
>
> and report the results.  If the final number (the fraction) is reliably
> significantly smaller for 5.12 than for 5.13 (whether it freezes or
> not), then this metric may still be useful.
>
> By the way, disabling the various offload options didn't appear to make
> a different for the other person who has reported this problem.
>
> Thanks,
> NeilBrown
