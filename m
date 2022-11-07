Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7492461FF95
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 21:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiKGUcm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 15:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiKGUck (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 15:32:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBD92A71B
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 12:32:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09C42B81619
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 20:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C101C433D6;
        Mon,  7 Nov 2022 20:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667853153;
        bh=X1bZYKNKU1iDH7hg/puX1Nqip+dc5/WiJ83DYByrgRY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qufjXBN1SHRyrKMHCmw2CBftLdRJvuU9xmahimT/QSnv5LPjQwGIcg4874OFN3Y79
         h6pAZk0M8ocO4BgSfjUrrcBt6LHCGt9KLOtOnaqItB+hACimh6Pi7V/R0C6jlId445
         dveCzMgsjjuSRLk6QjDUBAFhvLPcB85CBaRhb+B2F/dmshKOGbR/HEO1jjGc4FNbKZ
         VZ8/wRwJjOMLXKCYS4nMb2zx6SWVqQLpMuM2SrXXi/JAw/EeVeRaIUvDjo/t9MOEo1
         FxyAFU7O1rZR13pPaJgoNQWHr1rkSQw2+SKGV05Jgo3t8vGK3Ko9Xvu72vG3B+M8F9
         CLWb82a0SRPHg==
Message-ID: <69d215a099a5c9bfab7cb9f8e1c30186c78a9b76.camel@kernel.org>
Subject: Re: [PATCH] nfsd: remove dedicated nfsd_filecache_wq
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Charles Edward Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 07 Nov 2022 15:32:31 -0500
In-Reply-To: <53271EA7-326E-427C-B9D4-3AB75924508C@hammerspace.com>
References: <20221107171056.64564-1-jlayton@kernel.org>
         <61876142ab0115a7bf39556e5caebfd1a635f945.camel@kernel.org>
         <CDEA2A36-B0EC-426B-8489-2BB524C6266A@oracle.com>
         <0dffb0a8508511229880545245948c3f512a374a.camel@kernel.org>
         <53271EA7-326E-427C-B9D4-3AB75924508C@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 2022-11-07 at 19:06 +0000, Trond Myklebust wrote:
>=20
> > On Nov 7, 2022, at 13:45, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Mon, 2022-11-07 at 18:16 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Nov 7, 2022, at 12:28 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > On Mon, 2022-11-07 at 12:10 -0500, Jeff Layton wrote:
> > > > > There's no clear benefit to allocating our own over just using th=
e
> > > > > system_wq. This also fixes a minor bug in nfsd_file_cache_init().=
 In the
> > > > > current code, if allocating the wq fails, then the nfsd_file_rhas=
h_tbl
> > > > > is leaked.
> > > > >=20
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > > fs/nfsd/filecache.c | 13 +------------
> > > > > 1 file changed, 1 insertion(+), 12 deletions(-)
> > > > >=20
> > > >=20
> > > > I'm playing with this and it seems to be ok, but reading further in=
to
> > > > the workqueue doc, it says this:
> > > >=20
> > > > * A wq serves as a domain for forward progress guarantee
> > > > (``WQ_MEM_RECLAIM``, flush and work item attributes.  Work items
> > > > which are not involved in memory reclaim and don't need to be
> > > > flushed as a part of a group of work items, and don't require any
> > > > special attribute, can use one of the system wq.  There is no
> > > > difference in execution characteristics between using a dedicated w=
q
> > > > and a system wq.
> > > >=20
> > > > These jobs are involved in mem reclaim however, due to the shrinker=
.
> > > > OTOH, the existing nfsd_filecache_wq doesn't set WQ_MEM_RECLAIM.
> > > >=20
> > > > In any case, we aren't flushing the work or anything as part of mem
> > > > reclaim, so maybe the above bullet point doesn't apply here?
> > >=20
> > > In the steady state, deferring writeback seems like the right
> > > thing to do, and I don't see the need for a special WQ for that
> > > case -- hence nfsd_file_schedule_laundrette() can use the
> > > system_wq.
> > >=20
> > > That might explain the dual WQ arrangement in the current code.
> > >=20
> >=20
> > True. Looking through the changelog, the dedicated workqueue was added
> > by Trond in 9542e6a643fc ("nfsd: Containerise filecache laundrette"). I
> > assume he was concerned about reclaim.
>=20
> It is about separation of concerns. The issue is to ensure that when you =
have multiple containers each running their own set of knfsd servers, then =
you won=E2=80=99t end up with one server bottlenecking the cleanup of all t=
he containers. It is of particular interest to do this if one of these cont=
ainers is actually re-exporting NFS.
>=20

I'm not sure that having a separate workqueue really prevents that these
days though, does it? They all use the same kthreads. We're not using
flush_workqueue. What scenario do we prevent by having a dedicated
workqueue?

> >=20
> > Trond, if we keep the dedicated workqueue for the laundrette, does it
> > also need WQ_MEM_RECLAIM?
>=20
> In theory, the files on that list are supposed to have already been flush=
ed, so I don=E2=80=99t think it is needed.
>=20

Ok.

--=20
Jeff Layton <jlayton@kernel.org>
