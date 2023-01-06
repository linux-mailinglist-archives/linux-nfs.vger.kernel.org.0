Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B6B66063A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 19:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjAFSPj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Jan 2023 13:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjAFSPi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Jan 2023 13:15:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4827CDF0
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 10:15:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EAB2B81E44
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 18:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D51FC433EF;
        Fri,  6 Jan 2023 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673028934;
        bh=OIStyPoAGWT4ksiO3e4F59sNCV1TuXnF93jaJVWkwN0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GbHGZgrI3c3pE5+GbrpFM6t6oTzZkb9DD7Ye+gf6El6dGhvX/IqetNZ6+rEEX2sVb
         nZDbWaqA6lcBEetA8qg9Lp/ze8Ll3xf37kxYPdqMndCVN6ON3K9KQPy11j+U9/3qjq
         Ic7NrIflkFlnfAlkQiohNiD55zdD4KusNEylRz4/ugrRJNLRjWVixR83vCLxGuNTrO
         k8VFSnb8Bxpk/0F6l8mgwfaWYPxeTxH+9B2do1sS5YWEhGJ2ZInUIMwxsOfnAALlJP
         9tWPXSCXO+V/UvL7Q3olAlMZIj1EsaUQQqLnJX95bmafhEFUR7tiB0oGwZNbviqlFl
         prbKds/koSqqA==
Message-ID: <ed66d0c4bd454e7a3f17038a735a99a00390833f.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix handling of cached open files in nfsd4_open
 codepath
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Stanislav Saner <ssaner@redhat.com>,
        Ruben Vestergaard <rubenv@drcmr.dk>,
        Torkil Svensgaard <torkil@drcmr.dk>
Date:   Fri, 06 Jan 2023 13:15:31 -0500
In-Reply-To: <BC8EF64C-3F08-4E10-B562-344FFD1D37B2@oracle.com>
References: <20230105195556.1557555-1-jlayton@kernel.org>
         <BC8EF64C-3F08-4E10-B562-344FFD1D37B2@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-01-06 at 17:56 +0000, Chuck Lever III wrote:
>=20
> > On Jan 5, 2023, at 2:55 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > Commit fb70bf124b05 ("NFSD: Instantiate a struct file when creating a
> > regular NFSv4 file") added the ability to cache an open fd over a
> > compound. There are a couple of problems with the way this currently
> > works:
> >=20
> > It's racy, as a newly-created nfsd_file can end up with its PENDING bit
> > cleared while the nf is hashed, and the nf_file pointer is still zeroed
> > out. Other tasks can find it in this state and they expect to see a
> > valid nf_file, and can oops if nf_file is NULL.
> >=20
> > Also, there is no guarantee that we'll end up creating a new nfsd_file
> > if one is already in the hash. If an extant entry is in the hash with a
> > valid nf_file, nfs4_get_vfs_file will clobber its nf_file pointer with
> > the value of op_file and the old nf_file will leak.
> >=20
> > Fix both issues by making a new nfsd_file_acquirei_opened variant that
> > takes an optional file pointer. If one is present when this is called,
> > we'll take a new reference to it instead of trying to open the file. If
> > the nfsd_file already has a valid nf_file, we'll just ignore the
> > optional file and pass the nfsd_file back as-is.
> >=20
> > Also rework the tracepoints a bit to allow for an "opened" variant and
> > don't try to avoid counting acquisitions in the case where we already
> > have a cached open file.
> >=20
> > Fixes: fb70bf124b05 ("NFSD: Instantiate a struct file when creating a r=
egular NFSv4 file")
> > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > Reported-by: Stanislav Saner <ssaner@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 40 ++++++++++++++++++----------------
> > fs/nfsd/filecache.h |  5 +++--
> > fs/nfsd/nfs4state.c | 16 ++++----------
> > fs/nfsd/trace.h     | 52 ++++++++++++---------------------------------
> > 4 files changed, 42 insertions(+), 71 deletions(-)
> >=20
> > v3: add new nfsd_file_acquire_opened variant instead of changing
> >    nfsd_file_acquire prototype
>=20
> Hi Jeff, v3 applied to nfsd's for-rc.
>=20

Can you also add:

    Reported-and-Tested-by: Ruben Vestergaard    rubenv@drcmr.dk
    Reported-and-Tested-by: Torkil Svensgaard    torkil@drcmr.dk

They've been helping test these patches (albeit backported versions on a
RHEL9 kernel), and reported the crash that helped me track this down.

Many thanks!
--=20
Jeff Layton <jlayton@kernel.org>
