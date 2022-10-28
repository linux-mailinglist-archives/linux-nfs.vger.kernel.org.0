Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B5611989
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 19:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiJ1Rna (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJ1Rn0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 13:43:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DF122BAFD
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 10:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F6D2B82C0F
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 17:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4CBC433D7;
        Fri, 28 Oct 2022 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666979001;
        bh=KYsfsMT/Yop883/v5tvuG634k6XFJJXIrsAf9NVl0jM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Hy6e5GjCIZ7a996faSmQCMziOlkGdyIZ+DXc8oNrCPW2hWeomYGVDc0tWPsl3v16s
         nEredFX8/KprDEUu4I+vXiNHEhlAxUNa8dkrgrIdSD8ag5Zr7xcfERmZMEoMwXF4bE
         qt0trzohPHxSQdzE5reDC8EEljwpRJkHpKvm4HVSRZ1LBkMZRuvNNGZNri8aF2yUsd
         /uencxWHOae4vXHbASzVL0uyKfbN/lrzcy2hwN5BVfNJ1/sJsWIUHHamvzULbRf/Mo
         PngmNaHOFCnH1eAHyC5OlmrINN298U0Ku4iwDwBHZ6rZ3o8bN26LjrUz9A4PPG2XVU
         LzHH/jMR1Ynzw==
Message-ID: <098163d8067962f84a06af5d03379e2157974625.camel@kernel.org>
Subject: Re: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Fri, 28 Oct 2022 13:43:20 -0400
In-Reply-To: <A040CDCA-5E3F-470F-8D69-8FF9DA4325FE@oracle.com>
References: <20221027215213.138304-1-jlayton@kernel.org>
         <20221027215213.138304-4-jlayton@kernel.org>
         <D32F829C-434C-4BA4-9057-C9769C2F4655@oracle.com>
         <ae07f54d107cf1848c0a36dd16e437185a0304c3.camel@kernel.org>
         <65194BBE-F4C7-4CD6-A618-690D1CCE235C@oracle.com>
         <cc4bfa448efedd0017fc7b20b8b7475907acbc5e.camel@kernel.org>
         <A040CDCA-5E3F-470F-8D69-8FF9DA4325FE@oracle.com>
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

On Fri, 2022-10-28 at 17:21 +0000, Chuck Lever III wrote:
>=20
> > On Oct 28, 2022, at 11:51 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2022-10-28 at 15:29 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Oct 28, 2022, at 11:05 AM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > >=20
> > > > On Fri, 2022-10-28 at 13:16 +0000, Chuck Lever III wrote:
> > > > >=20
> > > > > > On Oct 27, 2022, at 5:52 PM, Jeff Layton <jlayton@kernel.org> w=
rote:
> > > > > >=20
> > > > > > When a GC entry gets added to the LRU, kick off SYNC_NONE write=
back
> > > > > > so that we can be ready to close it out when the time comes.
> > > > >=20
> > > > > For a large file, a background flush still has to walk the file's
> > > > > pages to see if they are dirty, and that consumes time, CPU, and
> > > > > memory bandwidth. We're talking hundreds of microseconds for a
> > > > > large file.
> > > > >=20
> > > > > Then the final flush does all that again.
> > > > >=20
> > > > > Basically, two (or more!) passes through the file for exactly the
> > > > > same amount of work. Is there any measured improvement in latency
> > > > > or throughput?
> > > > >=20
> > > > > And then... for a GC file, no-one is waiting on data persistence
> > > > > during nfsd_file_put() so I'm not sure what is gained by taking
> > > > > control of the flushing process away from the underlying filesyst=
em.
> > > > >=20
> > > > >=20
> > > > > Remind me why the filecache is flushing? Shouldn't NFSD rely on
> > > > > COMMIT operations for that? (It's not obvious reading the code,
> > > > > maybe there should be a documenting comment somewhere that
> > > > > explains this arrangement).
> > > > >=20
> > > >=20
> > > >=20
> > > > Fair point. I was trying to replicate the behaviors introduced in t=
hese
> > > > patches:
> > > >=20
> > > > b6669305d35a nfsd: Reduce the number of calls to nfsd_file_gc()
> > > > 6b8a94332ee4 nfsd: Fix a write performance regression
> > > >=20
> > > > AFAICT, the fsync is there to catch writeback errors so that we can
> > > > reset the write verifiers (AFAICT). The rationale for that is descr=
ibed
> > > > here:
> > > >=20
> > > > 055b24a8f230 nfsd: Don't garbage collect files that might contain w=
rite errors
> > >=20
> > > Yes, I've been confused about this since then :-)
> > >=20
> > > So, the patch description says:
> > >=20
> > >    If a file may contain unstable writes that can error out, then we =
want
> > >    to avoid garbage collecting the struct nfsd_file that may be
> > >    tracking those errors.
> > >=20
> > > That doesn't explain why that's a problem, it just says what we plan =
to
> > > do about it.
> > >=20
> > >=20
> > > > The problem with not calling vfs_fsync is that we might miss writeb=
ack
> > > > errors. The nfsd_file could get reaped before a v3 COMMIT ever come=
s in.
> > > > nfsd would eventually reopen the file but it could miss seeing the =
error
> > > > if it got opened locally in the interim.
> > >=20
> > > That helps. So we're surfacing writeback errors for local writers?
> > >=20
> >=20
> > Well for non-v3 writers anyway. I suppose you could hit the same
> > scenario with a mixed v3 and v4 workload if you were unlucky enough, or
> > mixed v3 and ksmbd workload, etc...
> >=20
> > > I guess I would like this flushing to interfere as little as possible
> > > with the server's happy zone, since it's not something clients need t=
o
> > > wait for, and an error is exceptionally rare.
> > >=20
> > > But also, we can't let writeback errors hold onto a bunch of memory
> > > indefinitely. How much nfsd_file and page cache memory might be be
> > > pinned by a writeback error, and for how long?
> > >=20
> >=20
> > You mean if we were to stop trying to fsync out when closing? We don't
> > keep files in the cache indefinitely, even if they have writeback
> > errors.
> >=20
> > In general, the kernel attempts to write things out, and if it fails it
> > sets a writeback error in the mapping and marks the pages clean. So if
> > we're talking about files that are no longer being used (since they're
> > being GC'ed), we only block reaping them for as long as writeback is in
> > progress.
> >=20
> > Once writeback ends and it's eligible for reaping, we'll call vfs_fsync
> > a final time, grab the error and reset the write verifier when it's
> > non-zero.
> >=20
> > If we stop doing fsyncs, then that model sort of breaks down. I'm not
> > clear on what you'd like to do instead.
>=20
> I'm not clear either. I think I just have some hand-wavy requirements.
>=20
> I think keeping the flushes in the nfsd threads and away from single-
> threaded garbage collection makes sense. Keep I/O in nfsd context, not
> in the filecache garbage collector. I'm not sure that's guaranteed
> if the garbage collection thread does an nfsd_file_put() that flushes.
>=20

The garbage collector doesn't call nfsd_file_put directly, though it
will call nfsd_file_free, which now does a vfs_fsync.

>=20

> And, we need to ensure that an nfsd_file isn't pinned forever -- the
> flush has to make forward progress so that the nfsd_file is eventually
> released. Otherwise, writeback errors become a DoS vector.
>=20

IDGI. An outright writeback _failure_ won't block anything. Stuck (hung)
writeback could cause a nfsd_file to be pinned indefinitely, but that's
really no different than the situation with stuck read requests.

> But, back to the topic of this patch: my own experiments with background
> syncing showed that it introduces significant overhead and it wasn't
> really worth the trouble. Basically, on intensive workloads, the garbage
> collector must not stall or live-lock because it's walking through
> millions of pages trying to figure out which ones are dirty.
>=20

If this is what you want, then kicking off SYNC_NONE writeback when we
put it on the LRU is the right thing to do.

We want to ensure that when the thing is reaped from the LRU, that the
final vfs_fsync has to write nothing back. The penultimate put that adds
it to the LRU is almost certainly going to come in the context of an
nfsd thread, so kicking off background writeback at that point seems
reasonable.

Only files that aren't touched again get reaped off the LRU eventually,
so there should be no danger of nfsd redirtying it again. By the time we
get to reaping it, everything should be written back and the inode will
be ready to close with little delay.

>=20
> > > > I'm not sure we need to worry about that so much for v4 though. May=
be we
> > > > should just do this for GC files?
> > >=20
> > > I'm not caffeinated yet. Why is it not a problem for v4? Is it becaus=
e
> > > an open or delegation stateid will prevent the nfsd_file from going
> > > away?
> > >=20
> >=20
> >=20
> > Yeah, more or less.
> >=20
> > I think that for a error to be lost with v4, it would require the clien=
t
> > to have an application access pattern that would expose it to that
> > possibility on a local filesystem as well. I don't think we have any
> > obligation to do more there.
> >=20
> > Maybe that's a false assumption though.
> >=20
> > > Sorry for the noise. It's all a little subtle.
> > >=20
> >=20
> > Very subtle. The more we can get this fleshed out into comments the
> > better, so I welcome the questions.
> >=20
> > >=20
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > > fs/nfsd/filecache.c | 37 +++++++++++++++++++++++++++++++------
> > > > > > 1 file changed, 31 insertions(+), 6 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > > index d2bbded805d4..491d3d9a1870 100644
> > > > > > --- a/fs/nfsd/filecache.c
> > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > @@ -316,7 +316,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key=
 *key, unsigned int may)
> > > > > > }
> > > > > >=20
> > > > > > static void
> > > > > > -nfsd_file_flush(struct nfsd_file *nf)
> > > > > > +nfsd_file_fsync(struct nfsd_file *nf)
> > > > > > {
> > > > > > 	struct file *file =3D nf->nf_file;
> > > > > >=20
> > > > > > @@ -327,6 +327,22 @@ nfsd_file_flush(struct nfsd_file *nf)
> > > > > > 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id=
));
> > > > > > }
> > > > > >=20
> > > > > > +static void
> > > > > > +nfsd_file_flush(struct nfsd_file *nf)
> > > > > > +{
> > > > > > +	struct file *file =3D nf->nf_file;
> > > > > > +	unsigned long nrpages;
> > > > > > +
> > > > > > +	if (!file || !(file->f_mode & FMODE_WRITE))
> > > > > > +		return;
> > > > > > +
> > > > > > +	nrpages =3D file->f_mapping->nrpages;
> > > > > > +	if (nrpages) {
> > > > > > +		this_cpu_add(nfsd_file_pages_flushed, nrpages);
> > > > > > +		filemap_flush(file->f_mapping);
> > > > > > +	}
> > > > > > +}
> > > > > > +
> > > > > > static void
> > > > > > nfsd_file_free(struct nfsd_file *nf)
> > > > > > {
> > > > > > @@ -337,7 +353,7 @@ nfsd_file_free(struct nfsd_file *nf)
> > > > > > 	this_cpu_inc(nfsd_file_releases);
> > > > > > 	this_cpu_add(nfsd_file_total_age, age);
> > > > > >=20
> > > > > > -	nfsd_file_flush(nf);
> > > > > > +	nfsd_file_fsync(nf);
> > > > > >=20
> > > > > > 	if (nf->nf_mark)
> > > > > > 		nfsd_file_mark_put(nf->nf_mark);
> > > > > > @@ -500,12 +516,21 @@ nfsd_file_put(struct nfsd_file *nf)
> > > > > >=20
> > > > > > 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> > > > > > 		/*
> > > > > > -		 * If this is the last reference (nf_ref =3D=3D 1), then tra=
nsfer
> > > > > > -		 * it to the LRU. If the add to the LRU fails, just put it a=
s
> > > > > > -		 * usual.
> > > > > > +		 * If this is the last reference (nf_ref =3D=3D 1), then try
> > > > > > +		 * to transfer it to the LRU.
> > > > > > +		 */
> > > > > > +		if (refcount_dec_not_one(&nf->nf_ref))
> > > > > > +			return;
> > > > > > +
> > > > > > +		/*
> > > > > > +		 * If the add to the list succeeds, try to kick off SYNC_NON=
E
> > > > > > +		 * writeback. If the add fails, then just fall through to
> > > > > > +		 * decrement as usual.
> > > > >=20
> > > > > These comments simply repeat what the code does, so they seem
> > > > > redundant to me. Could they instead explain why?
> > > > >=20
> > > > >=20
> > > > > > 		 */
> > > > > > -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(n=
f))
> > > > > > +		if (nfsd_file_lru_add(nf)) {
> > > > > > +			nfsd_file_flush(nf);
> > > > > > 			return;
> > > > > > +		}
> > > > > > 	}
> > > > > > 	__nfsd_file_put(nf);
> > > > > > }
> > > > > > --=20
> > > > > > 2.37.3
> > > > > >=20
> > > > >=20
> > > > > --
> > > > > Chuck Lever
> > > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > > > --=20
> > > > Jeff Layton <jlayton@kernel.org>
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
