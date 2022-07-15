Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108EB576088
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiGOLcs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 07:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGOLcr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 07:32:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E46A4
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 04:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04DADB82B72
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 11:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE34C34115;
        Fri, 15 Jul 2022 11:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657884763;
        bh=LHPmWQ62iXbQiPgpExX1T08FYtMYyraCCHlUXyD/GNE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g1nHE6WEc8UMZKBatYJUksZdFidpK6mCEC2bRYMSa9nCa/dHMxsNqks+jKctsmXAx
         Asg0/4plp7mvl4f/FmdcvSRL6JJmRQ8Dcj107yXroJOMJrOMSnMGxO6bM0cPbkHS5N
         /6Ih6g2YIRHiWuSe668dTin3iEotool1V9rLD7KKjs0nW6RETduhU8qQzUUjMDxFpP
         4K++ylkJnEdMysk+avphvIcVWojxNb42ZyM9zPDolHlQi05IPDofpnasDxE9x5x4uM
         8Zy62qQQi8cHPQEOVGAKLQH3GJB8NFn88mKegu6l9vZG9QiW4Ql0x4eUD0cW8/QN9x
         cPrHRBSOUurYA==
Message-ID: <c10b61cd59a940dd93f6977300ab0d3c6742320f.camel@kernel.org>
Subject: Re: [PATCH 0/2] nfsd: close potential race between open and
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date:   Fri, 15 Jul 2022 07:32:41 -0400
In-Reply-To: <165784314214.25184.13511971308364755291@noble.neil.brown.name>
References: <20220714200434.161818-1-jlayton@kernel.org>
         <165784314214.25184.13511971308364755291@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-07-15 at 09:59 +1000, NeilBrown wrote:
> On Fri, 15 Jul 2022, Jeff Layton wrote:
> > This is a respin of the patchset that I sent earlier today. I hit a
> > deadlock with that one because of the ambiguous locking.
> >=20
> > This series is based on top of Neil's set entitled:
> >=20
> >     [PATCH 0/8] NFSD: clean up locking.
> >=20
> > His patchset makes the locking in the nfsd4_open codepath much more
> > consistent, and this becomes a lot simpler to fix. Without that set
> > however, the state of the parent's i_rwsem is unclear after nfsd_lookup
> > is called, and I don't see a way to determine it reliably.
>=20
> I haven't examined these patch very closely, but a few initial thoughts
> are:
>=20
> 1/ Before my series, you can unambiguously tell if i_rwsem is held by
>    checking fhp->fh_locked.  In fact, just call "fh_lock()", and you can
>    then be sure the fh is locked, whether or not it was locked before

Thanks, good to know. I wasn't sure how reliable that bool is. I guess
though that once you have a svc_fh, then you can more or less assume
that you have exclusive access to it for the life of the RPC being
processed.

> however...
> 2/ Do we really need to lock the parent?  If a rename or unlink happens
>    after the lease was taken, the lease will be broken. So
>     take lease.
>     repeat lookup (locklessly)
>     Check if lease has been broken
>    Should provide all you need.
>=20
>    You don't *need* to lock the directory to open an existing file and
>    with my pending parallel-updates patch set, you only need a shared
>    lock on the directory to create a file.  So I'd rather not be locking
>    the directory at all to get a delegation
>=20

Yeah, we probably don't need to lock the dir. That said, after your
patch series we already hold the i_rwsem on the parent at this point so
lookup_one_len is fine in this instance.

> 3/ When you vet the name you only do a lookup_one_len(), while
>    nfsd_lookup_dentry() also calls nfsd_cross_mnt() as it is possible
>    for a file to be mounted on.
>    That means that if I did bind mount one file over another and export
>    over NFSD, the file will never offer a delegation.
>    This is a minor point, but I think it would be best to be as correct
>    and consistent as possible.
>=20

Agreed, but that will take a bit more work. nfsd_lookup_dentry takes
several parameters that we don't currently have access to in
nfs4_set_delegation (e.g. the rqstp). Those will need to be plumbed
through several functions.

> Thanks for working on this!

...and thank you for the locking cleanup! Getting rid of fh_lock/_unlock
is a really nice cleanup that makes it a lot more clear how this should
work.
--=20
Jeff Layton <jlayton@kernel.org>
