Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B2611571
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 17:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiJ1PFW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJ1PFS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 11:05:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5461D5C95B
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 08:05:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA64262906
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 15:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9169C433D6;
        Fri, 28 Oct 2022 15:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666969510;
        bh=q6qbx9E39EZoCKWS4VIzviiamLW0NoH2CRzvecowd58=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B2qNITlYHfz8uIwSFqlTUq2YWTS+n5lZHdq5in22uWDlWG2G4h26IQOxssyDxUHt4
         1UHZVl+6C6qKHhZul1spse4qxXj2jHvnU3MZ1eFoby6nCIheodD5ryY9/hvP329Z30
         QDEFUnrOyDyv9PM8lT4eWIXAosBNi5EtRGIZq1kxI6hJD5G7ie18g51XmMLEAATSbK
         n4D5xwiTcA07yeKustTN8l/BZBTvi0+mxJVqNR0w48ddnTNh5C+r6EvT4klnIHR91/
         Y3OT47tbut6Ktgb+KjYU/lLGdf5kc3LcZ5vr7WaR6gi9R/qIA0rKD7t+MIGJIvNwGD
         Bi9nzkUydTbmg==
Message-ID: <ae07f54d107cf1848c0a36dd16e437185a0304c3.camel@kernel.org>
Subject: Re: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Fri, 28 Oct 2022 11:05:08 -0400
In-Reply-To: <D32F829C-434C-4BA4-9057-C9769C2F4655@oracle.com>
References: <20221027215213.138304-1-jlayton@kernel.org>
         <20221027215213.138304-4-jlayton@kernel.org>
         <D32F829C-434C-4BA4-9057-C9769C2F4655@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-10-28 at 13:16 +0000, Chuck Lever III wrote:
>=20
> > On Oct 27, 2022, at 5:52 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
> > so that we can be ready to close it out when the time comes.
>=20
> For a large file, a background flush still has to walk the file's
> pages to see if they are dirty, and that consumes time, CPU, and
> memory bandwidth. We're talking hundreds of microseconds for a
> large file.
>=20
> Then the final flush does all that again.
>=20
> Basically, two (or more!) passes through the file for exactly the
> same amount of work. Is there any measured improvement in latency
> or throughput?
>=20
> And then... for a GC file, no-one is waiting on data persistence
> during nfsd_file_put() so I'm not sure what is gained by taking
> control of the flushing process away from the underlying filesystem.
>=20
>=20
> Remind me why the filecache is flushing? Shouldn't NFSD rely on
> COMMIT operations for that? (It's not obvious reading the code,
> maybe there should be a documenting comment somewhere that
> explains this arrangement).
>=20


Fair point. I was trying to replicate the behaviors introduced in these
patches:

b6669305d35a nfsd: Reduce the number of calls to nfsd_file_gc()
6b8a94332ee4 nfsd: Fix a write performance regression

AFAICT, the fsync is there to catch writeback errors so that we can
reset the write verifiers (AFAICT). The rationale for that is described
here:

055b24a8f230 nfsd: Don't garbage collect files that might contain write err=
ors

The problem with not calling vfs_fsync is that we might miss writeback
errors. The nfsd_file could get reaped before a v3 COMMIT ever comes in.
nfsd would eventually reopen the file but it could miss seeing the error
if it got opened locally in the interim.

I'm not sure we need to worry about that so much for v4 though. Maybe we
should just do this for GC files?

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/filecache.c | 37 +++++++++++++++++++++++++++++++------
> > 1 file changed, 31 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index d2bbded805d4..491d3d9a1870 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -316,7 +316,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, u=
nsigned int may)
> > }
> >=20
> > static void
> > -nfsd_file_flush(struct nfsd_file *nf)
> > +nfsd_file_fsync(struct nfsd_file *nf)
> > {
> > 	struct file *file =3D nf->nf_file;
> >=20
> > @@ -327,6 +327,22 @@ nfsd_file_flush(struct nfsd_file *nf)
> > 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > }
> >=20
> > +static void
> > +nfsd_file_flush(struct nfsd_file *nf)
> > +{
> > +	struct file *file =3D nf->nf_file;
> > +	unsigned long nrpages;
> > +
> > +	if (!file || !(file->f_mode & FMODE_WRITE))
> > +		return;
> > +
> > +	nrpages =3D file->f_mapping->nrpages;
> > +	if (nrpages) {
> > +		this_cpu_add(nfsd_file_pages_flushed, nrpages);
> > +		filemap_flush(file->f_mapping);
> > +	}
> > +}
> > +
> > static void
> > nfsd_file_free(struct nfsd_file *nf)
> > {
> > @@ -337,7 +353,7 @@ nfsd_file_free(struct nfsd_file *nf)
> > 	this_cpu_inc(nfsd_file_releases);
> > 	this_cpu_add(nfsd_file_total_age, age);
> >=20
> > -	nfsd_file_flush(nf);
> > +	nfsd_file_fsync(nf);
> >=20
> > 	if (nf->nf_mark)
> > 		nfsd_file_mark_put(nf->nf_mark);
> > @@ -500,12 +516,21 @@ nfsd_file_put(struct nfsd_file *nf)
> >=20
> > 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> > 		/*
> > -		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> > -		 * it to the LRU. If the add to the LRU fails, just put it as
> > -		 * usual.
> > +		 * If this is the last reference (nf_ref =3D=3D 1), then try
> > +		 * to transfer it to the LRU.
> > +		 */
> > +		if (refcount_dec_not_one(&nf->nf_ref))
> > +			return;
> > +
> > +		/*
> > +		 * If the add to the list succeeds, try to kick off SYNC_NONE
> > +		 * writeback. If the add fails, then just fall through to
> > +		 * decrement as usual.
>=20
> These comments simply repeat what the code does, so they seem
> redundant to me. Could they instead explain why?
>=20
>=20
> > 		 */
> > -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> > +		if (nfsd_file_lru_add(nf)) {
> > +			nfsd_file_flush(nf);
> > 			return;
> > +		}
> > 	}
> > 	__nfsd_file_put(nf);
> > }
> > --=20
> > 2.37.3
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
