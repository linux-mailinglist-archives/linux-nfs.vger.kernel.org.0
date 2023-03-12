Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319076B6783
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Mar 2023 16:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjCLPdr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Mar 2023 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCLPdq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Mar 2023 11:33:46 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C077A2BEE6
        for <linux-nfs@vger.kernel.org>; Sun, 12 Mar 2023 08:33:44 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id o2so8930636vss.8
        for <linux-nfs@vger.kernel.org>; Sun, 12 Mar 2023 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678635224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmx34r/kJWuFTpfvAsMfiNZFWd7vcyDeY2B8C4au8eg=;
        b=B94UDW6VuGNeLSd2qNg2w1DwOcxEm0c8OJUwLzZkMmWzg3SnqoEz9AIkiaBQXeMMLX
         o+iE/o+rhMwgVszGRjK2faGi6qbm4vULHnjSBEE1NpzCCdutgypEj2beXO604pYkgMK0
         wQ5L6Fz1nqlS/MeVLcgM2Euf5VCvtk2KCAzD/wa3WfPTqUKqj8EaRZwRCT6ZoAS6tFNg
         teO6tZVCHZa1cUnMxE7YAxl/aifItAYd7mJvo9OZrU1mTceCRysvuegJ4K0qc9ysidnM
         QCdOkmEEnXrKxpVZRr78Mf+3j24ISsJWt9btshdM3BOom6+GSfcnCid3T0eVZtSPFfNP
         6CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678635224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmx34r/kJWuFTpfvAsMfiNZFWd7vcyDeY2B8C4au8eg=;
        b=19M71DdB8swxiR41CUIH322caeXGIEiQA+MRoeMfOAQdux+KMFw95ehTH+zrxl+o5I
         wG9a8FD8xLkn6p2oyJxF2lqB/h/1gka38WOoZ4+5HwCOrTd7VarwBJ8cdFIRCZYT4Mp1
         wtWhJGY2tdXa1ZfHGXHH3Hi6jIVweuWh1HuybIE4GEjgTsPYQ6hrUYAR3cT7a6zjB+/s
         7EPAbNzZHkjNY/Wrbo/78LPkwDmst/R33xHRyAPF/aKlnROurxxgSPC2JXuunMp3gs08
         PIQFlZ4FVx0fkkwk9UZuOciN8LmP3tZxJ7nA1A2nd4wRR++kQ0UtAoLoW/XvgayFkadV
         LLyw==
X-Gm-Message-State: AO0yUKVWimblWskppPfwfUv+4Wjz4L6BZFHkLnX0hV4zKD/bXC91xU+E
        iA5GEGF0ajk9Ivwx8OZdFlXpB68BLufo/TgAsJQ=
X-Google-Smtp-Source: AK7set9bJoD9KVcLRQBNaxfS9IXPnbSZmhpSGGzlxBDAP5GZAS5RbIek8K9w4xsRWjZB7sy9j5usSay4ZTWkIwQoDUs=
X-Received: by 2002:a67:f498:0:b0:424:7dde:ebc3 with SMTP id
 o24-20020a67f498000000b004247ddeebc3mr595403vsn.6.1678635223820; Sun, 12 Mar
 2023 08:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230303121603.132103-1-jlayton@kernel.org> <0FC66364-4F59-4590-9211-EB54E918C97D@oracle.com>
In-Reply-To: <0FC66364-4F59-4590-9211-EB54E918C97D@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 12 Mar 2023 17:33:32 +0200
Message-ID: <CAOQ4uxhwN9Lgzn0_YB33Jfzy1idRene2=tBrr4s9T5PYefJm_Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] lockd: fix races that can result in stuck filelocks
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "yoyang@redhat.com" <yoyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 3, 2023 at 4:54=E2=80=AFPM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
>
>
> > On Mar 3, 2023, at 7:15 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > I sent the first patch in this series the other day, but didn't get any
> > responses.
>
> We'll have to work out who will take which patches in this set.
> Once fully reviewed, I can take the set if the client maintainers
> send Acks for 2-4 and 6-7.
>
> nfsd-next for v6.4 is not yet open. I can work on setting that up
> today.
>
>
> > Since then I've had time to follow up on the client-side part
> > of this problem, which eventually also pointed out yet another bug on
> > the server side. There are also a couple of cleanup patches in here too=
,
> > and a patch to add some tracepoints that I found useful while diagnosin=
g
> > this.
> >
> > With this set on both client and server, I'm now able to run Yongcheng'=
s
> > test for an hour straight with no stuck locks.

My nfstest_lock test occasionally gets into an endless wait loop for the lo=
ck in
one of the optests.

AFAIK, this started happening after I upgraded my client machine to v5.15.8=
8.
Does this seem related to the client bug fixes in this patch set?

If so, is this bug a regression? and why are the fixes aimed for v6.4?

Thanks,
Amir.
