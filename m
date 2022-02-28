Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22794C7AA1
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiB1Uip (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiB1Uip (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:38:45 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06A417A84
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:38:05 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qk11so27329450ejb.2
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5M8V0KERZPEW6xaYle0VvUaL3r5ey8kGhjKi2Y41Po=;
        b=U9ap8tmlc+kWywIYVjTH00IdTKM1pX5hewrFcqs9Q3mAOHlbVORPoULf16rGfuAKSJ
         rSBs+rFHUN4wGxCs1afv36saWcpUYhEi93D+BBydTz75s+/Xan1nzW8BRt+6jRkEY22I
         xlEgAnN91gpOg0NyyYrnB366/zcgvGLqJ2IxtyjLKo7obC/IEAUeBvKW9+Ok8EiVGzCm
         fNSS5hB12f9GmZoPVHDA7pgKKIW0vtwwDpG6HhgtE/xLrfBMv+NogHARcdajEEPaN2rk
         /mq8TIpWDf0sfojs0hTpUojD4x7fxwq16nRc1ZT9t2BGOHWrzfX4dnrspLHEE2d+BOFd
         WRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5M8V0KERZPEW6xaYle0VvUaL3r5ey8kGhjKi2Y41Po=;
        b=qVaKfiMTH2RBEECnl3KE5pfZKSOirw+/tRdLXpjUW9rvpe3sK5Zuzq6eSrmHgTreCq
         /T9sgRzyv3BOeGUEoswBTyQfsPzwyKqG+AwnLXwOKQ4IAXS9WCITAmZBmOyOETRJ8r0Y
         A15/Y0Qh49+ZVYRMjukPyLGkDzoAS4PYXK52j8MgRVqROiT1yAKC56G/iQtjO14cEcAi
         PlmP97lV9Nqz4MyjKFGXcIp7SHQeV/6fu/9HKm+hJ7JhHsEPj1W4bOd2Cb9BCID8rpM5
         TVOsLjIPHpMChW4YkuBc/eeTeXQ2KjSiNg8rnIQLd8VP2VzKEa6Lo3nE2QnxSrIXoYzO
         /KuQ==
X-Gm-Message-State: AOAM533hrsZDXypX+tDE9G4KIrezqrW/cqf7h2brVaFx13zpGziJqpQc
        /Zpcjh7Ys8PFhse1Kg1PXmNglVKPPTUZAc3Y7XlzZvQF
X-Google-Smtp-Source: ABdhPJx2amW86Q8Eeh+HhijRzmYXICj5u4STTpWCcb+CfVN0p47qis4PrJLk0KBUWIW3k6V1fDc4G3kxdFM4W5s0lbE=
X-Received: by 2002:a17:906:2bc1:b0:6cf:d009:7f6b with SMTP id
 n1-20020a1709062bc100b006cfd0097f6bmr16446486ejg.17.1646080683829; Mon, 28
 Feb 2022 12:38:03 -0800 (PST)
MIME-Version: 1.0
References: <CAN-5tyE4n2WgQhtuX_1JZsHnyXXZgwGJbRYjw5jrA+bfVcC3uw@mail.gmail.com>
 <3136254d57e8e17537ea0d21a195293f162e42b8.camel@hammerspace.com>
In-Reply-To: <3136254d57e8e17537ea0d21a195293f162e42b8.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 28 Feb 2022 15:37:52 -0500
Message-ID: <CAN-5tyHyC8w90GWmCzvfqR_KYVx6S5EO2Qoaon9-UN5-UO_i=Q@mail.gmail.com>
Subject: Re: managing trunking
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
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

On Mon, Feb 28, 2022 at 3:03 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2022-02-28 at 13:58 -0500, Olga Kornievskaia wrote:
> > Hello folks,
> >
> > I would like to ask for what would be an acceptable solution to deal
> > with created trunking connections when there is a change in trunking
> > membership, specifically when a connection (ie., its endpoint) no
> > longer is part of the same group. An inaction on the client's part
> > would lead to unusable client.
> >
> > Would a proposal to destroy trunking connections in as part of
> > DESTROY_SESSION be acceptable? The logic behind this solution is that
> > trunking membership was established as a part of a session, each
> > connection was tested to belong to trunkable server and added to that
> > session. Once the session is destroy and new created there is no
> > guarantee that the connections are to the same server that the new
> > session is created for. Trunking membership can be re-established at
> > a
> > later time. I have some code that implements this solution but still
> > needs some testing.
> >
> > Alternatively, if we keep connections past DESTROY_SESSION, then we
> > need a way to test that the same connections belong to the new
> > session
> > that has been created, meaning that a probe for each connection on
> > create_session to see if they still belong to the same server as the
> > new session is created. Is that preferred over simply destroying
> > connections? I'm going to work on implementing this too and posting
> > as
> > an alternative.
> >
> > It has been expressed several times that the ultimate goal is to do
> > transport management in userspace so does it mean the solution to
> > this
> > is also in userspace? Should there be upcalls to user land on
> > DESTROY_SESSION and CREATE_SESSION to destroy/create trunking
> > respectively but triggered via user land. But in this approach, while
> > this happens at user land speed,  will we be allowing the client to
> > get into a state where it's unusable (because its connections are
> > talking to servers that don't belong to the same trunking group)? Or
> > to prevent this, will we be allowing the userland to pause activities
> > in the kernel until the transports are squared away? I just don't see
> > how out-sourcing trunking membership changes to the user land is
> > better than handling it in the kernel when no operations can proceed
> > until trunking membership is corrected.
> >
> > Any feedback on the approaches or its alternatives would be much
> > appreciated.
> >
> > Thank you for the feedback.
> >
> > Thank you.
>
> Right now, we only call DESTROY_SESSION on the final unmount of the
> volumes on a given server, just before calling DESTROY_CLIENTID to
> destroy the lease. So the point is really moot within the current
> framework.
>
> Is it therefore your intention to change when we call DESTROY_SESSION?

No I do not propose to change the when we call destroy_session.
Destroy_session is triggered when the client receives a BAD_SESSION
error.

I'm not a fan of this approach. I think the 2nd approach that tests
the connections is a better one.


>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
