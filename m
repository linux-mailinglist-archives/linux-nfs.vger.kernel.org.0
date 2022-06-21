Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E651553737
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jun 2022 18:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbiFUQEz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jun 2022 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiFUQEy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jun 2022 12:04:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F9A226
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 09:04:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eq6so12683739edb.6
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jun 2022 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gqku/UJsI0NaDuL2l9XuW6XJ7f0/QWNCt7p1nmJ5YF8=;
        b=nRq+VqjkTupMQVi8vrnzJGYeGrAtaR6MSTK460wDw+BozMNScXcxUGsDC9simdRi4i
         4K0SFIGQ2pshWvTtq/kCWoOTPv+AYqKUwrV1KeS9NL4YEHVO+yenVOTeal6KSlrpJW/9
         usfsNt0lZo47y+lI+oioOdKgUdYE0nn8BvOgd+NRcxN4nwKL8BC7vu2nLkSLpMJm+Ajt
         dNQUZf3Hoqc1q6t4TTI4EPzSL7c0ite+FB+w81lwAATVjl/KfFecgowcfdunHFV6C7iD
         llG9J+U0uiukwTxd7r1et+EkPH/7wv5I07I08EuO9w0YggLlCOCKcGZju1RW8+v6ZUNw
         TFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gqku/UJsI0NaDuL2l9XuW6XJ7f0/QWNCt7p1nmJ5YF8=;
        b=b9+W6VYLacLIvKUqKC9ruFmld7b0vuIW/Zhn98Im681zccTw8ABBU8cwnwWa927VPH
         6AynExDp62F9D+9ZRgbHSri804iTd3agy62FOolKOHn3Wc1CocE1tlkEiHEBCAQbUpKb
         m2AA7qzKXkRFKIB3lhobnCwGT4MYy1vLzk5aWMHOcCTyKtZLjbhwgAHK0Ipwxfp9un1E
         aTo+vRi2w7i3OzjbEKorKOgGudG0ELDN489E/VHqFtajsRF2MWN+taIRW1h0OZiAsTpQ
         LE4k6oUOBYuJVsU/F1CVPeM5NSYMUNF4J9TgIFwZljxjHFj0PXAZxUGd8R8cU72z1bjG
         GqXg==
X-Gm-Message-State: AJIora9y6p0ch0pu144h+/iZixL83mf3nQryEjtV56cnP5e3FHruceOW
        m/dUocQ5bKqOWjxPrDiNUCW8BH+vYUk4Ily2ruQ=
X-Google-Smtp-Source: AGRyM1tBPHQihsQ1hQT1PIedmXQaLb51Eexyo2pzBp/jnf8fu2cZUO+VwULQN8hhyYv1KoQAB81vPn5rtPTXUjNX/0c=
X-Received: by 2002:a50:ff0e:0:b0:433:5d15:eada with SMTP id
 a14-20020a50ff0e000000b004335d15eadamr35885685edu.102.1655827489757; Tue, 21
 Jun 2022 09:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com> <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
 <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com> <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
 <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
 <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
 <9D98FE64-80FB-43B7-9B1C-D177F32D2814@oracle.com> <1573dd90-2031-c9e9-8d62-b3055b053cd1@cornelisnetworks.com>
 <DA2DB426-6658-43CC-B331-C66B79BE8395@oracle.com> <1fa761b5-8083-793c-1249-d84c6ee21872@leemhuis.info>
 <C305FE22-345C-4D88-A03B-D01E326467C8@oracle.com> <540c0a10-e2eb-57e9-9a71-22cf64babd8e@leemhuis.info>
 <916910EC-4F57-4071-8A4E-FC21ED76839A@oracle.com> <0faa0fce-52ef-de28-7594-6e93bb47fec6@cornelisnetworks.com>
In-Reply-To: <0faa0fce-52ef-de28-7594-6e93bb47fec6@cornelisnetworks.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 21 Jun 2022 12:04:38 -0400
Message-ID: <CAN-5tyFWse4YP8dCGtQMDnqm5s+WsK8HqbitD2dAF5PayJMsEw@mail.gmail.com>
Subject: Re: NFS regression between 5.17 and 5.18
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dennis,

Can I ask some basic questions? Have you tried to get any kinds of
profiling done to see where the client is spending time (using perf
perhaps)?

real    4m11.835s
user    0m0.001s
sys     0m0.277s

sounds like 4ms are spent sleeping somewhere? Did it take 4mins to do
a network transfer (if we had a network trace we could see how long
network transfer were)? Do you have one (that goes along with
something that can tell us approximately when the request began from
the cp's perspective, like a date before hand)?

I see that there were no rdma changes that went into 5.18 kernel so
whatever changed either a generic nfs behaviour or perhaps something
in the rdma core code (is an mellonax card being used here?)

I wonder if the slowdown only happens on rdma or is it visible on the
tcp mount as well, have you tried?



On Mon, Jun 20, 2022 at 1:06 PM Dennis Dalessandro
<dennis.dalessandro@cornelisnetworks.com> wrote:
>
> On 6/20/22 10:40 AM, Chuck Lever III wrote:
> > Hi Thorsten-
> >
> >> On Jun 20, 2022, at 10:29 AM, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> >>
> >> On 20.06.22 16:11, Chuck Lever III wrote:
> >>>
> >>>
> >>>> On Jun 20, 2022, at 3:46 AM, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> >>>>
> >>>> Dennis, Chuck, I have below issue on the list of tracked regressions.
> >>>> What's the status? Has any progress been made? Or is this not really a
> >>>> regression and can be ignored?
> >>>>
> >>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> >>>>
> >>>> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> >>>> reports and sometimes miss something important when writing mails like
> >>>> this. If that's the case here, don't hesitate to tell me in a public
> >>>> reply, it's in everyone's interest to set the public record straight.
> >>>>
> >>>> #regzbot poke
> >>>> ##regzbot unlink: https://bugzilla.kernel.org/show_bug.cgi?id=215890
> >>>
> >>> The above link points to an Apple trackpad bug.
> >>
> >> Yeah, I know, sorry, should have mentioned: either I or my bot did
> >> something stupid and associated that report with this regression, that's
> >> why I deassociated it with the "unlink" command.
> >
> > Is there an open bugzilla for the original regression?
> >
> >
> >>> The bug described all the way at the bottom was the origin problem
> >>> report. I believe this is an NFS client issue. We are waiting for
> >>> a response from the NFS client maintainers to help Dennis track
> >>> this down.
> >>
> >> Many thx for the status update. Can anything be done to speed things up?
> >> This is taken quite a long time already -- way longer that outlined in
> >> "Prioritize work on fixing regressions" here:
> >> https://docs.kernel.org/process/handling-regressions.html
> >
> > ENOTMYMONKEYS ;-)
> >
> > I was involved to help with the ^C issue that happened while
> > Dennis was troubleshooting. It's not related to the original
> > regression, which needs to be pursued by the NFS client
> > maintainers.
> >
> > The correct people to poke are Trond, Olga (both cc'd) and
> > Anna Schumaker.
>
> Perhaps I should open a bugzilla for the regression. The Ctrl+C issue was a
> result of the test we were running taking too long. It times out after 10
> minutes or so and kills the process. So a downstream effect of the regression.
>
> The test is still continuing to fail as of 5.19-rc2. I'll double check that it's
> the same issue and open a bugzilla.
>
> Thanks for poking at this.
>
> -Denny
