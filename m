Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9D758DA20
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Aug 2022 16:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbiHIOOy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 10:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243764AbiHIOOx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 10:14:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA8C13D04
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 07:14:51 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t1so17192258lft.8
        for <linux-nfs@vger.kernel.org>; Tue, 09 Aug 2022 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gn19XJwjcVgz5GWvNPVnBUChVQvw4jMlV4PREKAvxwo=;
        b=E6Y9sWXlr6YZXt1L2TpHq/HmihRpO0basn/ay687uNI7KsFEnsAjPhIqyiy9rApaA1
         TyrDIF+wEcK/+9u0DdoFJ0BlAzrFbJozXupZq38UHSkifvH4S+t/LSMsrKULie5+7JUh
         IWz1unYHoHHpOgYR/SpxQ8qBxxj9blCgzuaRYk69kGw3cSf2njF3N5SxBO5C2urfqvo/
         TNp8nRIKxUp9W2lBxV+7xm3z879MwqA8MglG1DyHaXZ01TO8qxKtMzF383cHosFHI1CV
         ylLF5BP4ck6hIWE/gvs/R2fCGTvqTH30It3SJ0Yj7weVx4ss7VzBAOQ/Q3E94FgLIdGJ
         pKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gn19XJwjcVgz5GWvNPVnBUChVQvw4jMlV4PREKAvxwo=;
        b=NYUX6C3KqV42vL/m+GYZWSA7sNP33T2k9Jn8oFj0dQXX3kQkCUoz6ZJF7lu/UGZm9j
         7ULGFjF9EssZmKOkm5m2C6BwlmS+1Ddb8c9JN2HK8WE/Im4dcR8XpNE1cvAkuf6Y+mxZ
         IiQ+I+5vCgzQ9QrQdDssBdi/Ran50kJe5hJSmZVDeXfEvj0sM/evzMD5zdbd1ILBFkSc
         5m2SnCla5te2NrAmEBBD1P9YQhooNqqo7hyuwC/malexDxE0J+m6PUq1/Ag+VXeNcMgs
         FEMEvhqZQh/vILaz2iswfGpnYuNdrNOerw8QCtDXMM1QEHL2S/GId9L7i4NKDUp8Abn9
         CGbQ==
X-Gm-Message-State: ACgBeo3IwLB0McAW9Nf/gFqeFGQzf1g0DXUbb2gd/viikvdM0chEQWF7
        SCRnOODo70Mtt9lBvN54VfzBfieGW/7POXNLiqwgKwhj
X-Google-Smtp-Source: AA6agR76BfAUzChZVn3Occic3qSloXs3TW+fT7DhVK7zPNgjdi9izUXA5IQpbjxkXXBRbjCch4Z8bwjOToykIrZsUdo=
X-Received: by 2002:a05:6512:1287:b0:48c:ef98:4105 with SMTP id
 u7-20020a056512128700b0048cef984105mr3202554lfs.210.1660054489135; Tue, 09
 Aug 2022 07:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAD15GZf0FtU81hwQ+brhnt+sv895=TpAuz-YrMtjfx__FJ28Gg@mail.gmail.com>
 <8ae13798a15c69cf16272579f49768ec92484584.camel@hammerspace.com>
 <CAD15GZfmpdzMhXquciebs5M4e2kewu+yTUcTx9c-jeSXgZS+XQ@mail.gmail.com>
 <668b5de2f3951f0d64aa10e910a8aa3d626bec91.camel@hammerspace.com> <ec225634-44cd-aeeb-4919-956e68b249f0@talpey.com>
In-Reply-To: <ec225634-44cd-aeeb-4919-956e68b249f0@talpey.com>
From:   Jan Kasiak <j.kasiak@gmail.com>
Date:   Tue, 9 Aug 2022 10:14:37 -0400
Message-ID: <CAD15GZdsPtLuhRSWYkLgfVzwhp8QEDN2VQ89AeyUwjJRTshT7g@mail.gmail.com>
Subject: Re: Question about nlmclnt_lock
To:     Tom Talpey <tom@talpey.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for all of the resources!

I was trying to implement an NFS server, and v3 sounded like an easier
place to start :-)

I think I'll move on to v4.

If we're revisiting the past, maybe just one last historical question:

Do either of you know why the Linux Kernel only uses the IP
address/svid to identify the caller?

FreeBSD uses the owner field as well.

Jan

On Sun, Aug 7, 2022 at 8:01 AM Tom Talpey <tom@talpey.com> wrote:
>
> On 8/6/2022 3:49 PM, Trond Myklebust wrote:
> > On Sat, 2022-08-06 at 11:03 -0400, Jan Kasiak wrote:
> >> Hi Trond,
> >>
> >> The v4 RFCs do mention protocol design flaws, but don't go into more
> >> detail.
> >>
> >> I was trying to understand those flaws in order to understand how and
> >> why v3 was problematic.
> >>
> >>
> >
> > The main issues derive from the fact that NLM is a side band protocol,
> > meaning that it has no ability to influence the NFS protocol
> > operations. In particular, there is no way to ensure safe ordering of
> > locks and I/O. e.g. if your readahead code kicks in while you are
> > unlocking the file, then there is nothing that guarantees the page
> > reads happened while the lock was in place on the server.
> > The same weakness also causes problems for reboots: if your client
> > doesn't notice that the server rebooted (and lost your locks) because
> > the statd callback mechanism failed, then you're SOL. Your I/O may
> > succeed, but can end up causing problems for another client that has
> > since grabbed the lock and assumes it now has exclusive access to the
> > file.
> >
> > NLM also suffers from intrinsic problems of its own such as lack of
> > only-once semantics. If you send a blocking LOCK request, and
> > subsequently send a CANCEL operation, then who knows whether or not the
> > lock or the cancel get processed first by the server? Many servers will
> > reply LCK_GRANTED to the CANCEL even if they did not find the lock
> > request. Sending an UNLOCK can also cause issues if the lock was
> > granted via a blocking lock callback (NLM_GRANTED) since there is no
> > ordering between the reply to the NLM_GRANTED and the UNLOCK.
> >
> > Finally, as already mentioned, there are multiple issues associated
> > with client or server reboot. The NLM mechanism is pretty dependent on
> > yet another side band mechanism (STATD) to tell you when this occurs,
> > but that mechanism does not work to release the locks held by a client
> > if it fails to come back after reboot. Even if the client does come
> > back, it might forget to invoke the statd process, or it might use a
> > different identifier than it did during the last boot instance (e.g.
> > because DHCP allocated a different IP address, or the IP address it not
> > unique due to use of NAT, or a hostname was used that is non-unique,
> > ...).
> > If the server reboots, then it may fail to notify the client of that
> > reboot through the callback mechanism. Reasons may include the
> > existence of a NAT, failure of the rpcbind/portmapper process on the
> > client, firewalls,...
>
> That brought back memories.
>
> http://www.nfsv4bat.org/Documents/ConnectAThon/2006/talpey-cthon06-nsm.pdf
>
> Here's an even older issues list for nlm on Solaris circa 1996.
> The portrait-mode slides are in reverse order. :)
>
> http://www.nfsv4bat.org/Documents/ConnectAThon/1996/lockmgr.pdf
>
> The NLM protocol is an antique and hasn't been looked at in well
> over a decade (or two!). NLMv4 (circa 1995) widened offsets to
> 64-bit, which was the last innovation it got. None of the RPC
> sideband protocols were ever standardized, btw.
>
> Jan, what are you planning to use it for? Personally I'd advise
> against pretty much anything.
>
> Tom.
>
> >
> >> -Jan
> >>
> >>
> >> On Fri, Aug 5, 2022 at 10:27 PM Trond Myklebust
> >> <trondmy@hammerspace.com> wrote:
> >>>
> >>> On Fri, 2022-08-05 at 19:17 -0400, Jan Kasiak wrote:
> >>>> Hi,
> >>>>
> >>>> I was looking at the code for nlmclnt_lock and wanted to ask a
> >>>> question about how the Linux kernel client and the NLM 4 protocol
> >>>> handle some errors around certain edge cases.
> >>>>
> >>>> Specifically, I think there is a race condition around two
> >>>> threads of
> >>>> the same program acquiring a lock, one of the threads being
> >>>> interrupted, and the NFS client sending an unlock when none of
> >>>> the
> >>>> program threads called unlock.
> >>>>
> >>>> On NFS server machine S:
> >>>> there exists an unlocked file F
> >>>>
> >>>> On NFS client machine C:
> >>>> in program P:
> >>>> thread 1 tries to lock(F) with fd A
> >>>> thread 2 tries to lock(F) with fd B
> >>>>
> >>>> The Linux client will issue two NLM_LOCK calls with the same svid
> >>>> and
> >>>> same range, because it uses the program id to map to an svid.
> >>>>
> >>>> For whatever reason, assume the connection is broken (cable gets
> >>>> pulled etc...)
> >>>> and `status = nlmclnt_call(cred, req, NLMPROC_LOCK);` fails.
> >>>>
> >>>> The Linux client will retry the request, but at some point thread
> >>>> 1
> >>>> receives a signal and nlmclnt_lock breaks out of its loop.
> >>>> Because
> >>>> the
> >>>> Linux client request failed, it will fall through and go to the
> >>>> out_unlock label, where it will want to send an unlock request.
> >>>>
> >>>> Assume that at some point the connection is reestablished.
> >>>>
> >>>> The Linux kernel client now has two outstanding lock requests to
> >>>> send
> >>>> to the remote server: one for a lock that thread 2 is still
> >>>> trying to
> >>>> acquire, and one for an unlock of thread 1 that failed and was
> >>>> interrupted.
> >>>>
> >>>> I'm worried that the Linux client may first send the lock
> >>>> request,
> >>>> and
> >>>> tell thread 2 that it acquired the lock, and then send an unlock
> >>>> request from the cancelled thread 1 request.
> >>>>
> >>>> The server will successfully process both requests, because the
> >>>> svid
> >>>> is the same for both, and the true server side state will be that
> >>>> the
> >>>> file is unlocked.
> >>>>
> >>>> One can talk about the wisdom of using multiple threads to
> >>>> acquire
> >>>> the
> >>>> same file lock, but this behavior is weird, because none of the
> >>>> threads called unlock.
> >>>>
> >>>> I have experimented with reproducing this, but have not been
> >>>> successful in triggering this ordering of events.
> >>>>
> >>>> I've also looked at the code of in clntproc.c and I don't see a
> >>>> spot
> >>>> where outstanding failed lock/unlock requests are checked while
> >>>> processing lock requests?
> >>>>
> >>>> Thanks,
> >>>> -Jan
> >>>
> >>> Nobody here is likely to want to waste much time trying to 'fix'
> >>> the
> >>> NLM locking protocol. The protocol itself is known to be extremely
> >>> fragile, and the endemic problems constitute some of the main
> >>> motivations for the development of the NFSv4 protocol
> >>> (See https://datatracker.ietf.org/doc/html/rfc2624#section-8
> >>> and https://datatracker.ietf.org/doc/html/rfc7530#section-9).
> >>>
> >>> If you need more reliable support for POSIX locks beyond what
> >>> exists
> >>> today for NLM, then please consider NFSv4.
> >>>
> >>> --
> >>> Trond Myklebust
> >>> Linux NFS client maintainer, Hammerspace
> >>> trond.myklebust@hammerspace.com
> >>>
> >>>
> >
