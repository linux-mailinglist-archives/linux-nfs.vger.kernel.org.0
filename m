Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07786351755
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 19:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhDARl7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 13:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDARky (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 13:40:54 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F54C03116E;
        Thu,  1 Apr 2021 09:56:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u4so2983841ljo.6;
        Thu, 01 Apr 2021 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wO8Dojv7wME+ubk+Yh3ZKiafoFd7I1oLkJMSO3Y31sI=;
        b=F3O2zCAbbReZgeHKtbw0aXK2qQlf7F/t03hUelxOfQugiFwprHSLhgAmndLRyhp1eu
         xD+huyb1UwBnI2IhJFwFLD6bC3DFEp/nV2VqnXwz4Z+UQ9gPjcwRk/qHtnBWHLf/mAMU
         27lOxowYfM7hfYr4eaYwmbJFgQXm+U9xHJAhoHR0YQpG46pKHL86lxLTvIRkQHbyP68r
         E+GCoG8AHmtjN5znoQ1bqMrOapzAotTU4Ieze/dDFVTUmF9lXtwLP0DdTEKHBpgWLksF
         UDQGQ4y7zcArnQk5FyBtctEj/9vPtSB9cmWmtVjWGRr9hKsl17dWe7xH0XvSuTV5nGs4
         uE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wO8Dojv7wME+ubk+Yh3ZKiafoFd7I1oLkJMSO3Y31sI=;
        b=cteK/QAZMNsuYjC5c5iw6fUc43fgZlIEFFKwQuLbvWdYK9MZBzRR379AJL9Be+K6ZE
         3WUyuYoNxpiaJu8V/iHxUygJdAkRTS3FSRo4ubUBNMk3ns5iQt1PsLDKyo3F9+WK/UBo
         Sl6ENjP1BOVAy4qbZtddvH41PeYvoWsBLFllr6LOccBYioUHDXIUBCO1AH0H19N3mfTd
         6wlGnb4w5lHPePzXSRvBVUyGFat9RElfGfU6SgE9qOCPBRD7UCQUyxFV+sMMnOe9rtCE
         +fMX2z0+v+IlEY/0yois0tKVgJCuXLIhka+KLN9luiqFXRkuexbmLe8Yo6GqLVOwyNCo
         mjKQ==
X-Gm-Message-State: AOAM5329jokitcDXaqKBSuVThIyjb3wuT0T9sec5bJHVluEKrB6Sx7yO
        VpVBYTIuh8qhJE6Gb8sALkTrco4HnjwSTbtB1V0=
X-Google-Smtp-Source: ABdhPJzQOEEhimvWy6pd+h2jmQJE81piAskC48n/tc82P3AeVvjS9zpEJwTHf4VvbdGu+F2ZVrpUh6DxCyq/L8TTpnI=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr6281590ljm.29.1617296188589;
 Thu, 01 Apr 2021 09:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
 <161721937122.515226.14731175629421422152.stgit@manet.1015granger.net>
 <4004f56f-3603-f56c-aea9-651230b3181e@talpey.com> <CAFMMQGvortADqgmAzskZKcnyHDzsTEW0FtR501wpP+deUM57FA@mail.gmail.com>
 <b5286b3f-439a-ef7c-cd7c-6cebfbccb02d@talpey.com>
In-Reply-To: <b5286b3f-439a-ef7c-cd7c-6cebfbccb02d@talpey.com>
From:   Chuck Lever <chucklever@gmail.com>
Date:   Thu, 1 Apr 2021 12:56:17 -0400
Message-ID: <CAFMMQGuo6=Leymd++YBtAwQzptzp+rcynM6EXosu20vG67jrMw@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] xprtrdma: Do not post Receives after disconnect
To:     Tom Talpey <tom@talpey.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 31, 2021 at 5:22 PM Tom Talpey <tom@talpey.com> wrote:
>
> On 3/31/2021 4:31 PM, Chuck Lever wrote:
> > On Wed, Mar 31, 2021 at 4:01 PM Tom Talpey <tom@talpey.com> wrote:
> >>
> >> On 3/31/2021 3:36 PM, Chuck Lever wrote:
> >>> Currently the Receive completion handler refreshes the Receive Queue
> >>> whenever a successful Receive completion occurs.
> >>>
> >>> On disconnect, xprtrdma drains the Receive Queue. The first few
> >>> Receive completions after a disconnect are typically successful,
> >>> until the first flushed Receive.
> snip
> >> Is it not possible to mark the WRs as
> >> being part of a batch, and allowing them to flush? You could borrow a
> >> bit in the completion cookie, and check it when the CQE pops out. Maybe.
> >
> > It's not an issue with batching, it's an issue with posting Receives from the
> > Receive completion handler. I'd think that any of the ULPs that post Receives
> > in their completion handler would have the same issue.
> >
> > The purpose of the QP drain in rpcrdma_xprt_disconnect() is to ensure there
> > are no more WRs in flight so that the hardware resources can be safely
> > destroyed. If the Receive completion handler continues to post Receive WRs
> > after the drain sentinel has been posted, leaks and crashes become possible.

> Well, why not do an atomic_set() of a flag just before posting the
> sentinel, and check it with atomic_get() before any other RQ post?

After a couple of private exchanges, Tom and I agree that doing an
ib_query_qp() in rpcrdma_post_recvs() has some drawbacks and
does not fully close the race window.

There is nothing that prevents rpcrdma_xprt_disconnect() from starting
the RQ drain while rpcrdma_post_recvs is still running. There needs to
be serialization between ib_drain_rq() and rpcrdma_post_recvs() so
that the drain sentinel is guaranteed to be the final Receive WR posted
on the RQ.

It would be great if the core ib_drain_rq() API itself could handle the
exclusion.


-- 
"We cannot take our next breath without the exhale."
 -- Ellen Scott Grable
