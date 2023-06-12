Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B5C72CAD2
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjFLP6z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 11:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbjFLP6b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 11:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DF8BB
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 08:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73A456157E
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 15:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8615FC433EF;
        Mon, 12 Jun 2023 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686585507;
        bh=bK/N3A8aWR7S3LFzYtHENDaj4ulF7Q0QeplRphOVM/c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o0NtUmhx8p6h7+dludRjQ8hwhZuc7Nzh5SbSs7/+NNemD+V9rpCpB8W/ZgEuWVabo
         OP4K46I8S2qIQVgZuuZrcsJKJA0rrzgWC8UUPPMNwwqtsNZFWSFXMdLfI/kvUpHFgV
         JMmA1JVKoi31A0e5ptZ40lGd2xJKODXNM6rDGTfs1mjQJKg6JOdsFz2YCCrQjmgaAA
         TakofUIaxYOYnHDUhewU4Fqo2bgRlHi0YitDgPZseXi0MiYwNspQkDUs9aXRKgW6BJ
         3dQHVNTxGnAvhCUGBv4fn5DR6sWtvgzTO4M3AwnIdh3M0tOwv/yBewiMJXv2WOiEvK
         qRXFr0ys67jAg==
Message-ID: <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org>
Subject: Re: Too many ENOSPC errors
From:   Jeff Layton <jlayton@kernel.org>
To:     Chris Perl <cperl@janestreet.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 12 Jun 2023 11:58:26 -0400
In-Reply-To: <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
         <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
         <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-06-12 at 10:27 -0400, Chris Perl wrote:
> On Thu, Jun 8, 2023 at 4:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > On Thu, 2023-06-08 at 13:05 -0400, Chris Perl wrote:
> > > Hi everyone,
> > >=20
> > > I'm working with several Red Hat derived systems and have noticed an
> > > issue with ENOSPC and NFS that I'm looking for some guidance on.
> > >=20
> > > First let me describe the testing setup, and then I'll share my
> > > results from an EL7 based system (kernel 3.10.0-1160.90.1.el7), an EL=
8
> > > based system (kernel 4.18.0-425.19.2.el8_7), an EL8 based system
> > > patched with commit e6005436f6cc9ed13288f936903f0151e5543485 (kernel
> > > 4.18.0-425.19.2.el8_7 plus that commit), and finally an EL8 based
> > > system but with an upstream 6.1 kernel.
> > >=20
> > > Assume I have a 20M quota on my current working directory which is an
> > > NFS export from one of the major enterprise vendors.
> > >=20
> > > The testing looks like the following:
> > >=20
> > > # rm -f file1
> > > # touch file1
> > > # dd bs=3D1M count=3D20 if=3D/dev/zero of=3Dfile2 # this will use all=
 the quota
> > > 20+0 records in
> > > 20+0 records out
> > > 20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
> > > # tee -a file1 <<< abc
> > > abc
> > > tee: file1: No space left on device
> > > # rm -f file2
> > > # tee -a file1 <<< abc
> > > abc
> > >=20
> > > On an EL7 based system, running the above works just as shown. I.e.
> > > you create file1, then use all the quota with file2, attempt to write
> > > to file1 which fails with ENOSPC (as expected), remove file2 (which
> > > frees up the quota), and then attempt to write to file1 again which
> > > succeeds.
> > >=20
> > > However, on a stock EL8 based system, I instead get the following
> > > surprising behavior:
> > >=20
> > > # rm -f file1
> > > # touch file1
> > > # dd bs=3D1M count=3D20 if=3D/dev/zero of=3Dfile2 # this will use all=
 the quota
> > > 20+0 records in
> > > 20+0 records out
> > > 20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
> > > # tee -a file1 <<< abc
> > > abc
> > > tee: file1: No space left on device
> > > # rm -f file2
> > > # tee -a file1 <<< abc
> > > abc
> > > tee: file1: No space left on device
> > > # tee -a file1 <<< abc
> > > abc
> > > tee: file1: No space left on device
> > >=20
> > > I.e. Even after freeing the space by removing file2, writing to file1
> > > continues to fail with ENOSPC forever (I've only shown 2 iterations
> > > above) [1]. No amount of waiting will cause it to go away. But, we've
> > > found that running sync(1) on the file will fix it (the sync itself
> > > will complain with ENOSPC, but then subsequent tee invocatinos
> > > succeed).
> > >=20
> > > I thought that perhaps the issue was the fact that kernel
> > > 4.18.0-425.19.2.el8_7 was missing commit
> > > e6005436f6cc9ed13288f936903f0151e5543485 (which adds some ENOSPC
> > > handling to `nfs_file_write'), so we patched the kernel with that
> > > patch and tested again. It's worth saying that with this patch, the
> > > behavior of our 4.18 kernel and the 6.1 kernel are consistent when
> > > running this test, but I feel like there might still be a bug here.
> > >=20
> > > What I get now is:
> > >=20
> > > # rm -f file1
> > > # touch file1
> > > # dd bs=3D1M count=3D20 if=3D/dev/zero of=3Dfile2 # this will use all=
 the quota
> > > 20+0 records in
> > > 20+0 records out
> > > 20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
> > > # tee -a file1 <<< abc
> > > abc
> > > tee: file1: No space left on device
> > > # rm -f file2
> > > # tee -a file1 <<< abc
> > > abc
> > > tee: file1: No space left on device
> > > # tee -a file1 <<< abc
> > > abc
> > >=20
> > > I.e. The first attempt to write to the file after freeing the quota
> > > fails with ENOSPC, but subsequent attempts succeed. Note that this is
> > > different from the original behavior on our EL7 based system as shown
> > > above where as soon as the quota is freed up, there are no more ENOSP=
C
> > > errors.
> > >=20
> > > I'm no expert, but below I'm including some digging I did in case it'=
s
> > > helpful for understanding the situation more fully without needing to
> > > reproduce yourselves. If it's not helpful and just distracting,
> > > apologies in advance!
> > >=20
> > > From strace'ing and systemtap'ing I noticed that the first call to
> > > `tee' (after the quota is used up by file2) returns the ENOSPC in
> > > response to close(2) (i.e. via `nfs_file_flush') and the second call
> >=20
> > That is (unfortunately) expected behavior. I've argued (mostly
> > unsuccessfully) for years that we shouldn't return writeback errors in
> > the close() codepath.
> >=20
> > No program should rely on looking for those. The only "legit" error on
> > close() is -EBADF.
> >=20
> > > to `tee' (after the quota has been freed) returns the ENOSPC in
> > > response to the write(2) (i.e. via `nfs_file_write' , and then clears
> > > the error via the changes we introduced with commit
> > > e6005436f6cc9ed13288f936903f0151e5543485).
> > >=20
> >=20
> > Looking at nfs_file_write, it's already tracking errors itself during
> > the write. Does this patch fix that? Note that I've not tested this --
> > YMMV!
>=20
> Unfortunately that patch doesn't seem to help.
>=20
> Since we applied commit e6005436f6cc9ed13288f936903f0151e5543485 and
> it seemed to improve the situation (from an unbounded number of ENOSPC
> errors to only one additional ENOSPC error), I believe that implies
> the error we're seeing is coming from `filemap_check_wb_err', not
> `generic_write_sync' in `nfs_file_write'.
>=20
> I'll do some more tracing and see if I can narrow it down a bit more.


Got it: I think I see what's happening. filemap_sample_wb_err just calls
errseq_sample, which does this:

errseq_t errseq_sample(errseq_t *eseq)                                     =
                        =20
{                                                                          =
                        =20
        errseq_t old =3D READ_ONCE(*eseq);                                 =
                          =20
                                                                           =
                        =20
        /* If nobody has seen this error yet, then we can be the first. */ =
                        =20
        if (!(old & ERRSEQ_SEEN))                                          =
                        =20
                old =3D 0;                                                 =
                          =20
        return old;                                                        =
                        =20
}                                                         =20

Because no one has seen that error yet (ERRSEQ_SEEN is clear), the write
ends up being the first to see it and it gets back a 0, even though the
error happened before the sample.

The above behavior is what we want for the sample that we do at open()
time, but not what's needed for this use-case. We need a new helper that
samples the value regardless of whether it has already been seen:

errseq_t errseq_peek(errseq_t *eseq)
{
	return READ_ONCE(*eseq);
}

...but we'll also need to fix up errseq_check to handle differences
between the SEEN bit.

I'll see if I can spin up a patch for that. Stay tuned.
--=20
Jeff Layton <jlayton@kernel.org>
