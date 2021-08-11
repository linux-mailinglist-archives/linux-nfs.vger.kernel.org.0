Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084CE3E992D
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Aug 2021 21:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhHKTqo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Aug 2021 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhHKTqo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Aug 2021 15:46:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7E4C061765
        for <linux-nfs@vger.kernel.org>; Wed, 11 Aug 2021 12:46:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cf5so5526074edb.2
        for <linux-nfs@vger.kernel.org>; Wed, 11 Aug 2021 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXg7AvsbQ8rLX0vvdyugGWsKUKTl2UP19qRLLjGbWrg=;
        b=SCsKr+Yy1Jii7mFXyfIBtZ0jdf3DIArVD6n7ccdoVoox04P4LZO7DCj+O06+daIGNN
         366Ic+Q/0q/g4WWp6fKYUrw9bdeSJ7jt4M61fEKIIQ55ELaJWx81Gh/Oq2glRlEU1QSx
         xFlmKJls0VCOXrj5zR+XMtzDyfLy6fR4azrQsQfXBzWfAjll8tWQB7Z6eF33swADq/Oq
         LIT74o1xMl25/55pvKrEbAIP9Bgy67EsQVyLCSP2M1u14YAIsHcFEKZuxrnXwOiR4uFM
         LaD08uMPvg6tSTUWlUIqhF4BBvqQPlHSwqtiL2W/Qa2wS1jyWMSIx6sn1QQw9L+IhdkR
         Ylxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXg7AvsbQ8rLX0vvdyugGWsKUKTl2UP19qRLLjGbWrg=;
        b=dlGHbxFTTttPwwW+j+zhRwJ2jhks8uDzZpj8sV3MI2lEk8Fpz5WJx2XYY6/QrFpn1T
         QAIE5ZgNo423xRU3bFWx9r6OXb/qDWcVQ9CJhf85dckAHIJKbctq7Y8YQ4d8jBanOkTr
         7HS7iHOoX8b8elgGFY0+o7naaFG8ml8sHfK3kV2OhKCIBn5osKPFlwy5zrEN9dDtxBEJ
         THcrbl6hH6MQDvsHJRQUdYD8s8FItYejaV/PDAsQp16DzD1z57KqG++D0efVETkJAPaz
         HbHjGyhLNVPizji8bV417hjH3Fg41JU/Uol9l/33GsyoFc1xeFi0QrSVbdN8/qfN1KH9
         g4vw==
X-Gm-Message-State: AOAM533l0NZRhznE5Qyr+hZ9Cgdg/qRUtwvSrT7fWnjtMb5hl9q4H+Nu
        iHYZJv04AaZvCmynec+g7guuLSTaDT6gWi3QoIc=
X-Google-Smtp-Source: ABdhPJyf+kQiTwgL60IPkwZdEbCrTNWjLJlCh7wat99Jm5kXo+ZCX70oJhB4WxtOwoQmDua6HvlywtRTwq3BkXBu5EI=
X-Received: by 2002:a05:6402:34c4:: with SMTP id w4mr668176edc.67.1628711178589;
 Wed, 11 Aug 2021 12:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <4da3b074-a6be-d83f-ccd4-b151557066aa@rothenpieler.org>
 <72ECF9E1-1F6E-44AF-850C-536BED898DDD@oracle.com> <e12c24fd-beaf-31ce-cb49-36ad32bd22b3@rothenpieler.org>
 <daae674a-84d4-de36-336d-693dc582e3ef@rothenpieler.org> <9355de20-921c-69e0-e5a4-733b64e125e1@rothenpieler.org>
 <a28b403e-42cf-3189-a4db-86d20da1b7aa@rothenpieler.org> <4BA2A532-9063-4893-AF53-E1DAB06095CC@oracle.com>
 <c8025457-7376-e1b7-bd6c-e5c6ee5d9ce7@rothenpieler.org> <141fdf51-2aa1-6614-fe4e-96f168cbe6cf@rothenpieler.org>
 <99DFF0B0-FE0F-4416-B3F6-1F9535884F39@oracle.com> <64F9A492-44B9-4057-ABA5-C8202828A8DD@oracle.com>
 <1b8a24a9-5dba-3faf-8b0a-16e728a6051c@rothenpieler.org> <5DD80ADC-0A4B-4D95-8CF7-29096439DE9D@oracle.com>
 <0444ca5c-e8b6-1d80-d8a5-8469daa74970@rothenpieler.org> <cc2f55cd-57d4-d7c3-ed83-8b81ea60d821@rothenpieler.org>
 <3AF4F6CA-8B17-4AE9-82E2-21A2B9AA0774@oracle.com> <CAN-5tyHNvYWd1M7sfZNV5q3Y_GZA2-DoTd=CxYvniZ1zkB5hyw@mail.gmail.com>
 <95DB2B47-F370-4787-96D9-07CE2F551AFD@oracle.com>
In-Reply-To: <95DB2B47-F370-4787-96D9-07CE2F551AFD@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 11 Aug 2021 15:46:07 -0400
Message-ID: <CAN-5tyGXycM1MKa=Sydoo4pP85PGLuh8yjJYsoAM3U+M1NVyCw@mail.gmail.com>
Subject: Re: Spurious instability with NFSoRDMA under moderate load
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 11, 2021 at 2:52 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Aug 11, 2021, at 2:38 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Wed, Aug 11, 2021 at 1:30 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Aug 11, 2021, at 12:20 PM, Timo Rothenpieler <timo@rothenpieler.org> wrote:
> >>>
> >>> resulting dmesg and trace logs of both client and server are attached.
> >>>
> >>> Test procedure:
> >>>
> >>> - start tracing on client and server
> >>> - mount NFS on client
> >>> - immediately run 'xfs_io -fc "copy_range testfile" testfile.copy' (which succeeds)
> >>> - wait 10~15 minutes for the backchannel to time out (still running 5.12.19 with the fix for that reverted)
> >>> - run xfs_io command again, getting stuck now
> >>> - let it sit there stuck for a minute, then cancel it
> >>> - run the command again
> >>> - while it's still stuck, finished recording the logs and traces
> >>
> >> The server tries to send CB_OFFLOAD when the offloaded copy
> >> completes, but finds the backchannel transport is not connected.
> >>
> >> The server can't report the problem until the client sends a
> >> SEQUENCE operation, but there's really no other traffic going
> >> on, so it just waits.
> >>
> >> The client eventually sends a singleton SEQUENCE to renew its
> >> lease. The server replies with the SEQ4_STATUS_BACKCHANNEL_FAULT
> >> flag set at that point. Client's recovery is to destroy that
> >> session and create a new one. That appears to be successful.
> >>
> >> But the server doesn't send another CB_OFFLOAD to let the client
> >> know the copy is complete, so the client hangs.
> >>
> >> This seems to be peculiar to COPY_OFFLOAD, but I wonder if the
> >> other CB operations suffer from the same "failed to retransmit
> >> after the CB path is restored" issue. It might not matter for
> >> some of them, but for others like CB_RECALL, that could be
> >> important.
> >
> > Thank you for the analysis Chuck (btw I haven't seen any attachments
> > with Timo's posts so I'm assuming some offline communication must have
> > happened).
> > ?
> > I'm looking at the code and wouldn't the mentioned flags be set on the
> > CB_SEQUENCE operation?
>
> CB_SEQUENCE is sent from server to client, and that can't work if
> the callback channel is down.
>
> So the server waits for the client to send a SEQUENCE and it sets
> the SEQ4_STATUS_BACKCHANNEL_FAULT in its reply.

yes scratch that, this is for when CB_SEQUENCE has it in its reply.

> > nfsd4_cb_done() has code to mark the channel
> > and retry (or another way of saying this, this code should generically
> > handle retrying whatever operation it is be it CB_OFFLOAD or
> > CB_RECALL)?
>
> cb_done() marks the callback fault, but as far as I can tell the
> RPC is terminated at that point and there is no subsequent retry.
> The RPC_TASK flags on the CB_OFFLOAD operation cause that RPC to
> fail immediately if there's no connection.
>
> And in the BACKCHANNEL_FAULT case, the bc_xprt is destroyed as
> part of recovery. I think that would kill all pending RPC tasks.
>
>
> > Is that not working (not sure if this is  a question or a
> > statement).... I would think that would be the place to handle this
> > problem.
>
> IMHO the OFFLOAD code needs to note that the CB_OFFLOAD RPC
> failed and then try the call again once the new backchannel is
> available.

I still argue that this needs to be done generically not per operation
as CB_RECALL has the same problem. If CB_RECALL call is never
answered, rpc would fail with ETIMEOUT. nfsd4_cb_recall_done() returns
1 back to the nfsd4_cb_done() which then based on the rpc task status
would set the callback path down but will do nothing else.
nfsd4_cb_offload_one() just always returns 1.

Now given that you say during the backchannel fault case, we'll have
to destroy that backchannel and create a new one. Are we losing all
those RPCs that flagged it as faulty? At this point, nothing obvious
comes to mind how to engineer the recovery but it should be done.

>
>
> --
> Chuck Lever
>
>
>
