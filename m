Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE461F802
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 16:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiKGPzI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 10:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiKGPzI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 10:55:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A634E1CB1E
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 07:55:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 428A360E01
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 15:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7BCC433C1;
        Mon,  7 Nov 2022 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667836506;
        bh=738pepuAEd/RxTIsbxif7MZnm+vj8E8P57FV9QxLO+g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X02MKRGknvu5JWXFVSnYgfpD5C7v6aw5RO/MW1dk1Y+ac5GLmd47XlZ0NdhJbhBk0
         x4vvSXPT4HhpNvyPLKYG+mblV0XiKT8CctlLMA3QNbsK1Nvwlaqyw3pU8vqIbZZ8oD
         LKDFLP17RhX6i+QNcWU9j4GoT8PHZ7VrM3FbwDSqadD8RaR1wWwu71fSnO1BeI6aGO
         v59V3+QskENgIZLT02pBre2gCFzBheTnm47rl2TodNMQo2eRf6tF/Lu7t0ovbbWqfm
         bJIA61CmeHyL0715xIlrZj2FLDK017fUvj7YxKrMHLQkZ7QR4PvF0t79XqSWdy3MJ6
         DbIOJbH3u6Qbw==
Message-ID: <561afeb91cee368db445ac74561bc6189a24fdef.camel@kernel.org>
Subject: Re: [PATCH] nfsd: queue laundrette to filecache_wq instead of
 system_wq
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 07 Nov 2022 10:55:04 -0500
In-Reply-To: <2FC9BEB2-189B-4EF6-AC61-40263BC47737@oracle.com>
References: <20221107150128.46951-1-jlayton@kernel.org>
         <2FC9BEB2-189B-4EF6-AC61-40263BC47737@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-11-07 at 15:11 +0000, Chuck Lever III wrote:
> Hi Jeff -
>=20
> > On Nov 7, 2022, at 10:01 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > nfsd has grown a dedicated workqueue for the filecache, but this job is
> > still queued to the system_wq. Change it to use the filecache_wq.
>=20
> Actually... there doesn't seem to be anything special about
> nfsd_filecache_wq. 9542e6a643fc ("nfsd: Containerise filecache
> laundrette") does not make clear why it was added.
>=20
> Playing devil's advocate: why not make the converse change and
> replace it with system_wq?
>=20

Good question.

At one time, allocating a workqueue gave you a dedicated pool of
threads, but that's no longer the case.

Documentation/core-api/workqueue.rst says: "A wq no longer manages
execution resources but serves as a domain for forward progress
guarantee, flush and work item attributes."

Given that we're allocating this workqueue exactly the same way we
allocate the system_wq, I don't think we need our own workqueue at all.
I'd be fine with changing this to be the reverse if you prefer.

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 1e76b0d3b83a..018fd1565193 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -212,7 +212,7 @@ static void
> > nfsd_file_schedule_laundrette(void)
> > {
> > 	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
> > -		queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
> > +		queue_delayed_work(nfsd_filecache_wq, &nfsd_filecache_laundrette,
> > 				   NFSD_LAUNDRETTE_DELAY);
> > }
> >=20
> > --=20
> > 2.38.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
