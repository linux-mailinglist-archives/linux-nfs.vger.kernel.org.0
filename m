Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223073F913A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 02:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243766AbhH0AIu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 20:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhH0AIu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 20:08:50 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428C8C061757
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 17:08:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1so3324140pjv.3
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 17:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DO4uj42x6iwK8Wfj6i+vE2rGHAkZVFplnUc40xAqcn4=;
        b=BaJuPg91wPDmyxQ0SqGyNJKxHo/sLqivt20W5mo2ORbuBLUGq8UVPGxTl05oeUydKI
         9sab9iN15EdT7bxhtleIVQHwaQgL8RbSqqrbha95wkQ5A54OsqH7xJKNUQbelMEdYaTx
         LIfT/Gk2AIK+g7J3RbDrE4hyf74kWv3bPp9ov98AeaKCn2etUj6MMBvzHMsfAhMfmi3U
         Kfekxc/60a9GZikk81o79DH2v34EG65unlINgOpTDWDDm3GjMkTLxbhaXHH6T+IHSDgS
         1THxGmIP4VB1BbIhtwbfWmeeR8ZGibtaZRcX0BXKBp+Qw1/4ub97wD69WHwv/PC4v8HL
         1eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DO4uj42x6iwK8Wfj6i+vE2rGHAkZVFplnUc40xAqcn4=;
        b=LW5WLYHrahGYpJLPK3rWNNEq0p5WxNAQmYPYX7rz8SAtjGFU5YfOmOsyE5AnrGjFLG
         14HeevyZw4Sj1qHVvhQKKGFbIs2LvAbvcIS/temvSKgILrqM21H4GA9kGb2IBXZZBB4H
         hguvRtpT4b05Lm1avZC6UjgBlrSoDc7E8BjVRxAQNXS5SIFmbP5uttAQt0I//4Hs8d8x
         UEgq9XQOFmlhvqY1UnA1zz3XBRmHOrUZ+4Bik9AGxblYl44sSuwodBolZQgMa6/QPAQK
         Ix31ZUmlB7zW0fwMjX5gkEYKQMq2BuNh/mjGAi/2pqEvNNUKkfDHam1QDs3jCpJNZIzF
         cpCw==
X-Gm-Message-State: AOAM533jilmE75eLks1Cp3pIzWS5i6SyyYERiL5oYjiRwm8ZJYJPs3pH
        11/RYxtJB/ycQi46KtRx/B2BeZw/bKthBh7aLsMDwZmNOBE=
X-Google-Smtp-Source: ABdhPJzERfkDxu2/dtOkuo4SaCDclX/2i9Wp8k25UK5IJfW6JEhb35HDigwBf1gTvt4BJC9N3xlmMDfk+3UBOIEnuA0=
X-Received: by 2002:a17:902:724b:b0:131:ab33:1e4e with SMTP id
 c11-20020a170902724b00b00131ab331e4emr5877316pll.12.1630022881573; Thu, 26
 Aug 2021 17:08:01 -0700 (PDT)
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
 <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com> <163001427749.7591.7281634750945934559@noble.neil.brown.name>
In-Reply-To: <163001427749.7591.7281634750945934559@noble.neil.brown.name>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Thu, 26 Aug 2021 17:07:50 -0700
Message-ID: <CAOv1SKC+3LXhM+L9MwU2D03bpeof55-g+i=r3SWEjVWcPVCi8Q@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I just tried the same mount with 4 different nfsvers values: 3, 4.0, 4.1 and 4.2

At first I thought it might be "working" because I only got freezes
with 4.2 at first, but I went back and re-tested (to be sure) and got
freezes with all 4 versions. So the nfsvers setting doesn't seem to
have an impact. I did verify at each pass that the 'nfsvers=' value
was present and correct in the mount output.

FYI: another user posted on the archlinux reddit with a similar issue,
I suggested they try with a 5.12 kernel and that "solved" the issue
for them as well.

- mike

On Thu, Aug 26, 2021 at 2:44 PM NeilBrown <neilb@suse.de> wrote:
>
> On Fri, 27 Aug 2021, Mike Javorski wrote:
> > I finally had the chance to test with the offloading disabled on the
> > server. Unfortunately, the issues remain, may even be more frequent,
> > but I can't rule out confirmation bias on that one.
> >
> > Not sure where to go from here.
>
> Have you tried NFSv3?  Or 4.0?
> I am (or was) leaning away from thinking it was an nfsd problem, but we
> cannot rule anything out until we know that is happening.
>
> I plan to have another dig through the code changes today.
>
> NeilBrown
