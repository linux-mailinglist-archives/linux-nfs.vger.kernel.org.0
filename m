Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F8E6C6793
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Mar 2023 13:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCWMFB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Mar 2023 08:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWMEl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Mar 2023 08:04:41 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8222695
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 05:03:06 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n125so24405497ybg.7
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1679572985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv9J7sGh3jJ6LIRMxhTC78gSWpQDVGFaatqAAaepZf4=;
        b=GwLPNpxv/w9lo/Ff3nmjgYZC6gIHfqydrpsA2Is4rPpOzUwsKOLoomioLb+kFU6G3W
         G1KBLbzefPHlOuojR7YFbrUbUag98JI5qC2s1aEtcQiMTAHwLvhnHODnclAAhjWrhb8F
         ACEjV/wxT3JDLdfncXtaEuEFGdFsBVPa64zkUO5ZwZ/vgo7HqVYKs9Rr4NtEO/Qhxvvb
         riIXnCNRpBRURRjZjXYs1qlBiJZMf5QVsXTDYjcH0LipN8i8oumrJd9UfoSyrVdandZD
         rjzkl9X25GULU39VTyKdMGNOZBzLQjd+dVCOwZHYFheCTvfmc7uRnL1bfs+9Ajipz28D
         QpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679572985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv9J7sGh3jJ6LIRMxhTC78gSWpQDVGFaatqAAaepZf4=;
        b=r34o0+m7FaFjZUw3k7lLB6W12FkZpAsVHUzvwSWno8Gd+ART/xi01ASfUf4+B2P6uB
         Vo+jxcXGqj5J+2wJdfsxvFOwDmYreFVwyvrUreTwoy2MmxK+ey+MHhM5D1kTy93KkzHa
         BMjo1jG11lqnZwiokWZTS10yOq0acSJcCcwqjX422YqNuTIFjH3E3UbqylWBF5xtIuvG
         Fva8UvNfXpH2swYyecN/lkyizdsS+/wGOh1ucpq1jed/5hk9d1IREH+wLcsZrSu0cDXb
         qRlPDDl3Tsq4Wfxb153Y/Gxr9vtXoSODjPRO1cKCHuWwNd8RC4D8z+XrKO4krHKaLX46
         9+bA==
X-Gm-Message-State: AAQBX9fsqHIHF1EFgwdAHx7uDxjIrL9W/6/0c8TQ6JXRnHsMmUjYryio
        uVvKjjCXcp1f+7zqnrhXTmsl93tBv+HfMe73L2/lPRVAcF3g6s8ds+Y=
X-Google-Smtp-Source: AKy350ZgL77nTVqPFLco8RFUaEi3w0yetgVnJt+KXgLPS0w07Lcgs8R0+Lt49fpHFHVzUBcQ2zTU23F51yp5fmoI5eQ=
X-Received: by 2002:a25:1c1:0:b0:b6e:1ff3:e168 with SMTP id
 184-20020a2501c1000000b00b6e1ff3e168mr1663510ybb.4.1679572985226; Thu, 23 Mar
 2023 05:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPt2mGMgCCWYP-ZaHCovMuRZmHYYPhApNiUybKTw4pr5XwZkjw@mail.gmail.com>
 <2f2473a4-5fd2-a772-e1af-885e21700467@leemhuis.info> <0cfd6568-de03-9ea5-2778-42ab2e6515db@leemhuis.info>
 <7912bba8-7127-abb0-4366-1abbb88db504@leemhuis.info>
In-Reply-To: <7912bba8-7127-abb0-4366-1abbb88db504@leemhuis.info>
From:   Daire Byrne <daire@dneg.com>
Date:   Thu, 23 Mar 2023 12:02:28 +0000
Message-ID: <CAPt2mGNaNTD=a+UsDLDeRWqd+PVHk6Rh-OX0+0BxGc+xgovraA@mail.gmail.com>
Subject: Re: v6.2 client behaviour change (repeat access calls)?
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Yes, sorry, I did see that patch was posted not long after I reported
the excessive repeat ACCESS calls but I have not had a chance to test
it.

It certainly looks promising. I will try to get to it next week and
update my original email.

Cheers,

Daire

On Thu, 23 Mar 2023 at 11:54, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 20.03.23 13:34, Thorsten Leemhuis wrote:
> > On 10.03.23 11:43, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> [CCing the regression list, as it should be in the loop for regression=
s:
> >> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> >>
> >> [also adding the author of the culprit (Trond) and the second NFS clie=
nt
> >> maintainer (Anna) to the list of recipients]
> >
> > Trond, sorry to bother you, but do you still have this regression repor=
t
> > on your radar? It looks a bit like it fall through the cracks, as I
> > don't see any reply since it was posted nearly two weeks ago. Or did
> > some progress to address this happen and I just missed it?
>
> Daire, it seems the NFS developers ignore my inquiries, sorry.
>
> But well, I noticed there is a patch that references the culprit you
> found in the bisection:
>
> https://lore.kernel.org/all/20230308080327.33906-1-chengen.du@canonical.c=
om/
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?h=3Dmaster&id=3D21fd9e8700de86d1169f6336e97d7a74916ed04a
>
> I wonder if you are aware of it or maybe even tested it already. To me
> it sounds like it could fix your problem, but this is not my area of
> expertise, so I might be totally wrong.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot ignore-activity
>
> >> [TLDR: I'm adding this report to the list of tracked Linux kernel
> >> regressions; the text you find below is based on a few templates
> >> paragraphs you might have encountered already in similar form.
> >> See link in footer if these mails annoy you.]
> >>
> >> On 07.03.23 18:38, Daire Byrne wrote:
> >>> I noticed a change in behaviour in the v6.2.x client versus v6.1.12 (=
and below).
> >>>
> >>> We have some servers that mount Netapps from different locations many
> >>> milliseconds away, and these contain apps and libs that get added to
> >>> the LD_LIBRARY_PATH and PATH on remote login.
> >>>
> >>> I then noticed that when I ssh'd into a remote server that had these
> >>> mounts and the shell was starting, the first login was normal and I
> >>> observed an expected flurry of lookups,getattrs and access calls for =
a
> >>> grand total of only ~120 packets to the Netapp.
> >>>
> >>> But when I disconnect and reconnect (ssh), now I see a flood of acces=
s
> >>> calls to the netapp for a handful of repeating filehandles which look
> >>> something like:
> >>>
> >>>  2700 85.942563180 10.23.112.10 =E2=86=92 10.23.21.11  NFS 254 V3 ACC=
ESS Call,
> >>> FH: 0x7f36addc, [Check: RD LU MD XT DL]
> >>>  2701 85.999838796  10.23.21.11 =E2=86=92 10.23.112.10 NFS 190 V3 ACC=
ESS Reply
> >>> (Call In 2700), [Allowed: RD LU MD XT DL]
> >>>  2702 85.999970825 10.23.112.10 =E2=86=92 10.23.21.11  NFS 254 V3 ACC=
ESS Call,
> >>> FH: 0x7f36addc, [Check: RD LU MD XT DL]
> >>>  2703 86.055340946  10.23.21.11 =E2=86=92 10.23.112.10 NFS 190 V3 ACC=
ESS Reply
> >>> (Call In 2702), [Allowed: RD LU MD XT DL]
> >>>  2704 86.056865308 10.23.112.10 =E2=86=92 10.23.21.11  NFS 254 V3 ACC=
ESS Call,
> >>> FH: 0x7f36addc, [Check: RD LU MD XT DL]
> >>>  2705 86.112233415  10.23.21.11 =E2=86=92 10.23.112.10 NFS 190 V3 ACC=
ESS Reply
> >>> (Call In 2704), [Allowed: RD LU MD XT DL]
> >>>
> >>> This time we total 5000+ packets for this login which becomes very
> >>> noticeable when the Netapp is 50ms away.
> >>>
> >>> I didn't understand why the first login was fine but the second goes
> >>> into this repeating access pattern. I set actimeo=3D3600 (long) but i=
t
> >>> does not seem to affect it.
> >>>
> >>> I do not see this prior to v6.2 where repeated logins are equally fas=
t
> >>> and we don't see the repeating access calls.
> >>>
> >>> So a bit of digging through the v6.2 changes and this looked like the
> >>> relevant change:
> >>>
> >>> commit 0eb43812c027 ("NFS: Clear the file access cache upon login=E2=
=80=9D)
> >>> [PATCH] NFS: Judge the file access cache's timestamp in rcu path?
> >>>
> >>> I reverted those and got the prior (v6.1) performance.
> >>>
> >>> What constitutes a login exactly? I also have services like "sysstat"
> >>> or pcp that cause a systemd-logind to trigger regularly on our
> >>> machines.... does that count and invalidate the cache?
> >>>
> >>> Do the repeated access calls on the same handful of filehandles make
> >>> sense? Even prior to those patches (or v6.1) there are only a couple
> >>> of ACCESS calls to the Netapp on login.
> >>>
> >>> We are a bit unique in that we run quite a few WAN high latency NFS
> >>> workflows so are happy to trade long lived caches (e.g. actimeo and
> >>> even nocto on occasion) for lower ops at the expense of total
> >>> correctness.
> >>
> >> Thanks for the report. To be sure the issue doesn't fall through the
> >> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regressio=
n
> >> tracking bot:
> >>
> >> #regzbot ^introduced 0eb43812c027
> >> #regzbot title nfs: flood of access on second log-in (first is fine)
> >> #regzbot ignore-activity
> >>
> >> This isn't a regression? This issue or a fix for it are already
> >> discussed somewhere else? It was fixed already? You want to clarify wh=
en
> >> the regression started to happen? Or point out I got the title or
> >> something else totally wrong? Then just reply and tell me -- ideally
> >> while also telling regzbot about it, as explained by the page listed i=
n
> >> the footer of this mail.
> >>
> >> Developers: When fixing the issue, remember to add 'Link:' tags pointi=
ng
> >> to the report (the parent of this mail). See page linked in footer for
> >> details.
> >>
> >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' ha=
t)
> >> --
> >> Everything you wanna know about Linux kernel regression tracking:
> >> https://linux-regtracking.leemhuis.info/about/#tldr
> >> That page also explains what to do if mails like this annoy you.
