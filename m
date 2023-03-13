Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5935B6B7478
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 11:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCMKpb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCMKpa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 06:45:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F914BEBE
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 03:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D10DBB80FF1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 10:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00245C433D2;
        Mon, 13 Mar 2023 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678704326;
        bh=0UGtiT1MfU2bJ81TSMFYGF4FUkSmU+Elb13qkZt1Uk4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FNX3aZ7HGcEoAeBvLt+ikhC0CbUBJ0nVyEXya96WkwYdZBQnVK03tfvwNcqOx4sAS
         fsZGHlxN9p7sPpcSyuxVM86B+tD/p2gLViLYwhp2wcCYIZL3DHiBTUCeRFtQy6hVkM
         x6A3R52/STP0THyMAxVY9Z/bZsfkSE822V0lS7r22Pm8AhBTYOVmvBwIBQF0nQRCdU
         flzCrnBFAo05jw48Knvp/eXbLpoojI6SR4sd74pKqcjmjAXbss3C7yYKkxz56F74Yi
         gDMIqDxjsr4fKslRyf+3YBu8O4a33fl37WR7k4TpDi2FyO1z13+TgfN724btIxs9vW
         3EhBaJ7AQhR4w==
Message-ID: <7b70e66ec03fecd9f0d93f77c737393fa4ab7fb5.camel@kernel.org>
Subject: Re: [PATCH 0/7] lockd: fix races that can result in stuck filelocks
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "yoyang@redhat.com" <yoyang@redhat.com>
Date:   Mon, 13 Mar 2023 06:45:24 -0400
In-Reply-To: <CAOQ4uxhwN9Lgzn0_YB33Jfzy1idRene2=tBrr4s9T5PYefJm_Q@mail.gmail.com>
References: <20230303121603.132103-1-jlayton@kernel.org>
         <0FC66364-4F59-4590-9211-EB54E918C97D@oracle.com>
         <CAOQ4uxhwN9Lgzn0_YB33Jfzy1idRene2=tBrr4s9T5PYefJm_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-03-12 at 17:33 +0200, Amir Goldstein wrote:
> On Fri, Mar 3, 2023 at 4:54=E2=80=AFPM Chuck Lever III <chuck.lever@oracl=
e.com> wrote:
> >=20
> >=20
> >=20
> > > On Mar 3, 2023, at 7:15 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > I sent the first patch in this series the other day, but didn't get a=
ny
> > > responses.
> >=20
> > We'll have to work out who will take which patches in this set.
> > Once fully reviewed, I can take the set if the client maintainers
> > send Acks for 2-4 and 6-7.
> >=20
> > nfsd-next for v6.4 is not yet open. I can work on setting that up
> > today.
> >=20
> >=20
> > > Since then I've had time to follow up on the client-side part
> > > of this problem, which eventually also pointed out yet another bug on
> > > the server side. There are also a couple of cleanup patches in here t=
oo,
> > > and a patch to add some tracepoints that I found useful while diagnos=
ing
> > > this.
> > >=20
> > > With this set on both client and server, I'm now able to run Yongchen=
g's
> > > test for an hour straight with no stuck locks.
>=20
> My nfstest_lock test occasionally gets into an endless wait loop for the =
lock in
> one of the optests.
>=20
> AFAIK, this started happening after I upgraded my client machine to v5.15=
.88.
> Does this seem related to the client bug fixes in this patch set?
>=20
> If so, is this bug a regression? and why are the fixes aimed for v6.4?
>=20

Most of this (lockd) code hasn't changed in well over a decade, so if
this is a regression then it's a very old one. I suppose it's possible
that this regressed after the BKL was removed from this code, but that
was a long time ago now and I'm not sure I can identify a commit that
this fixes.

I'm fine with this going in sooner than v6.4, but given that this has
been broken so long, I didn't see the need to rush.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
