Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF661694E4F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjBMRpn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 12:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBMRpm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 12:45:42 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A6A1C312
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 09:45:33 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v23so14282414plo.1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 09:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3ekqa2dGsRSrS2GfSyiqs2OH4ZbeuhOqxOfx/N9/U4=;
        b=NmR786cKXIQnUFpNSjyGDLzpmp24VtBRyFzBGQMlRu4pY2xnCSS6oiisQyhTpgdY/x
         HOWBn2g8IBiXz3Keqn0msIaY7huNxGT9Z3Ug74x1W+e8Rzu9QCuZ0AqAg8hatrSAuPa3
         SE97vXBerDHDD5FXwRoC1uADRtvP2zO3vPeHni5mHjqqB/vujmOLvLjYvbpMU5Zz2Vjx
         niQ7yTHbHVI7IC52STRVuIRLryJb+DH51eQqPDjswW1CKTcwwcWlWVkb0HvFEkukezSi
         H8sSMiRKEBTeBdxJMaZXuTx9W0x+52Q3rvk9F2Phk6vypS80lMAI6L/XFgDJT8nwOO8B
         Mwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3ekqa2dGsRSrS2GfSyiqs2OH4ZbeuhOqxOfx/N9/U4=;
        b=AFjT/gFpV3YubAxiYSx+ZvVjyGYf8qli+2x4KycddMoEOzuEaijh6IJY2os4cS4RbS
         7DSmQG0gL0Muhvv030bjY0qArV75ln3uRxkwudy/5XRConGAqBmJfVJnnKknlkC17ykH
         MKBgLxC3FnqSp7Mz/AKiyXtcFGManmzh0dHUnefHzGYc4vlcbZKA+kc+9U46va2b4qhu
         4x6aYoxhs/Z8KvXhNd7KZTplFdbxBk8ofAFKnx0LRw+tUs++lpihX1MQhmEg7zj7o1mE
         ybQ7azBpoCp3bjIg2tVuT5e6VYJU0YvCzOrLMqQdegJGhIVz5WtqyXAb4t1/GergLA4U
         w8vw==
X-Gm-Message-State: AO0yUKW282qUD7H8ai1Mf3ZwSAxMwOGAUFGw0yjuXZqJRA50cAqJnC1n
        Sa7fl4+JXjmPtJpIxlMfNKH+g/FcPDVVbwAPvc8=
X-Google-Smtp-Source: AK7set/4CRBZzTqf1ODmhVQWhryFQ0kP+vQooZenVQZn/d7qQV646SPHXXu0Wd3kScDbJb/XXNJpYfiTWWHmPwSoti8=
X-Received: by 2002:a17:90a:db42:b0:233:e236:d54e with SMTP id
 u2-20020a17090adb4200b00233e236d54emr1229258pjx.123.1676310332794; Mon, 13
 Feb 2023 09:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20230212140148.4F0D.409509F4@e16-tech.com> <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
 <CAN-5tyE-DfbJOZCLzpgfEt+2u=UogLKn_gKs6mDbYpRUq+WXsA@mail.gmail.com> <8EBEDCF0-BB9E-4F18-9D67-F5CC47F51A96@hammerspace.com>
In-Reply-To: <8EBEDCF0-BB9E-4F18-9D67-F5CC47F51A96@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 13 Feb 2023 12:45:19 -0500
Message-ID: <CAN-5tyHSJ5zcT9Q5NMuWSZWRmMSu2Qnp9PfH0sjDgYRDWPrQgw@mail.gmail.com>
Subject: Re: question about the performance impact of sec=krb5
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Charles Edward Lever <chuck.lever@oracle.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 13, 2023 at 10:38 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
>
>
> > On Feb 13, 2023, at 09:55, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Sun, Feb 12, 2023 at 1:08 PM Chuck Lever III <chuck.lever@oracle.com=
> wrote:
> >>
> >>
> >>
> >>> On Feb 12, 2023, at 1:01 AM, Wang Yugui <wangyugui@e16-tech.com> wrot=
e:
> >>>
> >>> Hi,
> >>>
> >>> question about the performance of sec=3Dkrb5.
> >>>
> >>> https://learn.microsoft.com/en-us/azure/azure-netapp-files/performanc=
e-impact-kerberos
> >>> Performance impact of krb5:
> >>>      Average IOPS decreased by 53%
> >>>      Average throughput decreased by 53%
> >>>      Average latency increased by 3.2 ms
> >>
> >> Looking at the numbers in this article... they don't
> >> seem quite right. Here are the others:
> >>
> >>> Performance impact of krb5i:
> >>>      =E2=80=A2 Average IOPS decreased by 55%
> >>>      =E2=80=A2 Average throughput decreased by 55%
> >>>      =E2=80=A2 Average latency increased by 0.6 ms
> >>> Performance impact of krb5p:
> >>>      =E2=80=A2 Average IOPS decreased by 77%
> >>>      =E2=80=A2 Average throughput decreased by 77%
> >>>      =E2=80=A2 Average latency increased by 1.6 ms
> >>
> >> I would expect krb5p to be the worst in terms of
> >> latency. And I would like to see round-trip numbers
> >> reported: what part of the increase in latency is
> >> due to server versus client processing?
> >>
> >> This is also remarkable:
> >>
> >>> When nconnect is used in Linux, the GSS security context is shared be=
tween all the nconnect connections to a particular server. TCP is a reliabl=
e transport that supports out-of-order packet delivery to deal with out-of-=
order packets in a GSS stream, using a sliding window of sequence numbers.=
=E2=80=AFWhen packets not in the sequence window are received, the security=
 context is discarded, and=E2=80=AFa new security context is negotiated. Al=
l messages sent with in the now-discarded context are no longer valid, thus=
 requiring the messages to be sent again. Larger number of packets in an nc=
onnect setup cause frequent out-of-window packets, triggering the described=
 behavior. No specific degradation percentages can be stated with this beha=
vior.
> >>
> >>
> >> So, does this mean that nconnect makes the GSS sequence
> >> window problem worse, or that when a window underrun
> >> occurs it has broader impact because multiple connections
> >> are affected?
> >
> > Yes nconnect makes the GSS sequence window problem worse (very typical
> > to generate more than gss window size number of rpcs and have no
> > ability to control in what order they would be sent) and yes all
> > connections are affected. ONTAP as linux uses 128 gss window size but
> > we've experimented with increasing it to larger values and it would
> > still cause issues.
> >
> >> Seems like maybe nconnect should set up a unique GSS
> >> context for each xprt. It would be helpful to file a bug.
> >
> > At the time when I saw the issue and asked about it (though can't find
> > a reference now) I got the impression that having multiple contexts
> > for the same rpc client was not going to be acceptable.
> >
>
> We have discussed this earlier on this mailing list. To me, the two issue=
s are separate.
> - It would be nice to enforce the GSS window on the client, and to thrott=
le further RPC calls from using a context once the window is full.
> - It might also be nice to allow for multiple contexts on the client and =
to have them assigned on a per-xprt basis so that the number of slots scale=
s with the number of connections.
>
> Note though, that window issues do tend to be mitigated by the NFSv4.x (x=
>0) sessions. It would make sense for server vendors to ensure that they ma=
tch the GSS window size to the max number of session slots.

Matching max session slots to gss window size doesn't help but perhaps
my understanding of the flow is wrong. Typically all these runs are
done with the client's default session slot # which is only 64slots
(server's session slot size is higher). The session slot assignment
happens after the gss sequence assignment. So we have a bunch of
requests that have gotten gss sequence numbers that exceed the window
slot and then they go wait for the slot assignment but when they are
sent they are already out of sequence window.

>
> _________________________________
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
