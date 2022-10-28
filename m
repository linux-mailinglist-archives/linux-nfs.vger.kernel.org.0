Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C075B61165A
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJ1PwJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 11:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiJ1Pvy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 11:51:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89A81C43C
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 08:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E742B82996
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659ADC433D6;
        Fri, 28 Oct 2022 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666972265;
        bh=SORGXLJ3IgkMOk7lfcqTVd6Sl1D0olVpF/7sP++uNGI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oXPmAAbj0IQYhR6f/tfOnoixqfxAE3m8bASnRVR25RzjJ0RZiW3Rdzo8S7pa6Qhh6
         Uitc8br+r3IjtV+5fCq6d9toLqO+yBg0kNHrjTJmb5JoFvvOSezKt0Ehg57m4HZMQs
         rF95vaJoDVlhKhqidUv9jNnlh7rg8v5ltBBD6Asd+tnC8/nBI4DLS06IKok2iB5wCq
         esDoS10sZ2JzqAhsUYmypWdZwqGubVR1WPQvkuIyUfAvqsfvJ+GiTsywFDV/wBUSbL
         d4U524Hp0q3mP313Lfv2fX5YxsBL0voX40lyMzSQRqYk1sIOh8EqOUA6dw1it2fyv8
         vyxM+tykqfocQ==
Message-ID: <cc4bfa448efedd0017fc7b20b8b7475907acbc5e.camel@kernel.org>
Subject: Re: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Fri, 28 Oct 2022 11:51:04 -0400
In-Reply-To: <65194BBE-F4C7-4CD6-A618-690D1CCE235C@oracle.com>
References: <20221027215213.138304-1-jlayton@kernel.org>
         <20221027215213.138304-4-jlayton@kernel.org>
         <D32F829C-434C-4BA4-9057-C9769C2F4655@oracle.com>
         <ae07f54d107cf1848c0a36dd16e437185a0304c3.camel@kernel.org>
         <65194BBE-F4C7-4CD6-A618-690D1CCE235C@oracle.com>
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

On Fri, 2022-10-28 at 15:29 +0000, Chuck Lever III wrote:
>=20
> > On Oct 28, 2022, at 11:05 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2022-10-28 at 13:16 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Oct 27, 2022, at 5:52 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
> > > > so that we can be ready to close it out when the time comes.
> > >=20
> > > For a large file, a background flush still has to walk the file's
> > > pages to see if they are dirty, and that consumes time, CPU, and
> > > memory bandwidth. We're talking hundreds of microseconds for a
> > > large file.
> > >=20
> > > Then the final flush does all that again.
> > >=20
> > > Basically, two (or more!) passes through the file for exactly the
> > > same amount of work. Is there any measured improvement in latency
> > > or throughput?
> > >=20
> > > And then... for a GC file, no-one is waiting on data persistence
> > > during nfsd_file_put() so I'm not sure what is gained by taking
> > > control of the flushing process away from the underlying filesystem.
> > >=20
> > >=20
> > > Remind me why the filecache is flushing? Shouldn't NFSD rely on
> > > COMMIT operations for that? (It's not obvious reading the code,
> > > maybe there should be a documenting comment somewhere that
> > > explains this arrangement).
> > >=20
> >=20
> >=20
> > Fair point. I was trying to replicate the behaviors introduced in these
> > patches:
> >=20
> > b6669305d35a nfsd: Reduce the number of calls to nfsd_file_gc()
> > 6b8a94332ee4 nfsd: Fix a write performance regression
> >=20
> > AFAICT, the fsync is there to catch writeback errors so that we can
> > reset the write verifiers (AFAICT). The rationale for that is described
> > here:
> >=20
> > 055b24a8f230 nfsd: Don't garbage collect files that might contain write=
 errors
>=20
> Yes, I've been confused about this since then :-)
>=20
> So, the patch description says:
>=20
>     If a file may contain unstable writes that can error out, then we wan=
t
>     to avoid garbage collecting the struct nfsd_file that may be
>     tracking those errors.
>=20
> That doesn't explain why that's a problem, it just says what we plan to
> do about it.
>=20
>=20
> > The problem with not calling vfs_fsync is that we might miss writeback
> > errors. The nfsd_file could get reaped before a v3 COMMIT ever comes in=
.
> > nfsd would eventually reopen the file but it could miss seeing the erro=
r
> > if it got opened locally in the interim.
>=20
> That helps. So we're surfacing writeback errors for local writers?
>=20

Well for non-v3 writers anyway. I suppose you could hit the same
scenario with a mixed v3 and v4 workload if you were unlucky enough, or
mixed v3 and ksmbd workload, etc...

> I guess I would like this flushing to interfere as little as possible
> with the server's happy zone, since it's not something clients need to
> wait for, and an error is exceptionally rare.
>=20
> But also, we can't let writeback errors hold onto a bunch of memory
> indefinitely. How much nfsd_file and page cache memory might be be
> pinned by a writeback error, and for how long?
>=20

You mean if we were to stop trying to fsync out when closing? We don't
keep files in the cache indefinitely, even if they have writeback
errors.

In general, the kernel attempts to write things out, and if it fails it
sets a writeback error in the mapping and marks the pages clean. So if
we're talking about files that are no longer being used (since they're
being GC'ed), we only block reaping them for as long as writeback is in
progress.

Once writeback ends and it's eligible for reaping, we'll call vfs_fsync
a final time, grab the error and reset the write verifier when it's
non-zero.

If we stop doing fsyncs, then that model sort of breaks down. I'm not
clear on what you'd like to do instead.

>=20
> > I'm not sure we need to worry about that so much for v4 though. Maybe w=
e
> > should just do this for GC files?
>=20
> I'm not caffeinated yet. Why is it not a problem for v4? Is it because
> an open or delegation stateid will prevent the nfsd_file from going
> away?
>=20


Yeah, more or less.

I think that for a error to be lost with v4, it would require the client
to have an application access pattern that would expose it to that
possibility on a local filesystem as well. I don't think we have any
obligation to do more there.

Maybe that's a false assumption though.

> Sorry for the noise. It's all a little subtle.
>=20

Very subtle. The more we can get this fleshed out into comments the
better, so I welcome the questions.

>=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > fs/nfsd/filecache.c | 37 +++++++++++++++++++++++++++++++------
> > > > 1 file changed, 31 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index d2bbded805d4..491d3d9a1870 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -316,7 +316,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *ke=
y, unsigned int may)
> > > > }
> > > >=20
> > > > static void
> > > > -nfsd_file_flush(struct nfsd_file *nf)
> > > > +nfsd_file_fsync(struct nfsd_file *nf)
> > > > {
> > > > 	struct file *file =3D nf->nf_file;
> > > >=20
> > > > @@ -327,6 +327,22 @@ nfsd_file_flush(struct nfsd_file *nf)
> > > > 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> > > > }
> > > >=20
> > > > +static void
> > > > +nfsd_file_flush(struct nfsd_file *nf)
> > > > +{
> > > > +	struct file *file =3D nf->nf_file;
> > > > +	unsigned long nrpages;
> > > > +
> > > > +	if (!file || !(file->f_mode & FMODE_WRITE))
> > > > +		return;
> > > > +
> > > > +	nrpages =3D file->f_mapping->nrpages;
> > > > +	if (nrpages) {
> > > > +		this_cpu_add(nfsd_file_pages_flushed, nrpages);
> > > > +		filemap_flush(file->f_mapping);
> > > > +	}
> > > > +}
> > > > +
> > > > static void
> > > > nfsd_file_free(struct nfsd_file *nf)
> > > > {
> > > > @@ -337,7 +353,7 @@ nfsd_file_free(struct nfsd_file *nf)
> > > > 	this_cpu_inc(nfsd_file_releases);
> > > > 	this_cpu_add(nfsd_file_total_age, age);
> > > >=20
> > > > -	nfsd_file_flush(nf);
> > > > +	nfsd_file_fsync(nf);
> > > >=20
> > > > 	if (nf->nf_mark)
> > > > 		nfsd_file_mark_put(nf->nf_mark);
> > > > @@ -500,12 +516,21 @@ nfsd_file_put(struct nfsd_file *nf)
> > > >=20
> > > > 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> > > > 		/*
> > > > -		 * If this is the last reference (nf_ref =3D=3D 1), then transfe=
r
> > > > -		 * it to the LRU. If the add to the LRU fails, just put it as
> > > > -		 * usual.
> > > > +		 * If this is the last reference (nf_ref =3D=3D 1), then try
> > > > +		 * to transfer it to the LRU.
> > > > +		 */
> > > > +		if (refcount_dec_not_one(&nf->nf_ref))
> > > > +			return;
> > > > +
> > > > +		/*
> > > > +		 * If the add to the list succeeds, try to kick off SYNC_NONE
> > > > +		 * writeback. If the add fails, then just fall through to
> > > > +		 * decrement as usual.
> > >=20
> > > These comments simply repeat what the code does, so they seem
> > > redundant to me. Could they instead explain why?
> > >=20
> > >=20
> > > > 		 */
> > > > -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> > > > +		if (nfsd_file_lru_add(nf)) {
> > > > +			nfsd_file_flush(nf);
> > > > 			return;
> > > > +		}
> > > > 	}
> > > > 	__nfsd_file_put(nf);
> > > > }
> > > > --=20
> > > > 2.37.3
> > > >=20
> > >=20
> > > --
> > > Chuck Lever
> > >=20
> > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
