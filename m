Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D7F7289AB
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jun 2023 22:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjFHUua (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Jun 2023 16:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjFHUu3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Jun 2023 16:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FFB2D7E
        for <linux-nfs@vger.kernel.org>; Thu,  8 Jun 2023 13:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6254661771
        for <linux-nfs@vger.kernel.org>; Thu,  8 Jun 2023 20:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87809C433EF;
        Thu,  8 Jun 2023 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686257423;
        bh=ZhWUoqiOrQNyqTHmipi2+VpsRdWOE/cx2hZMGtKOFjY=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=gW51dslWUJDgeD4stsXjrZiSIxWjUJzY+HfMDaz3HOwt3lNhB5nOz5M/SyVl74PLU
         6PiBWICbWFPCpDDDGVyK1KFZed6ps0luJOVLypv7yZD2rMiTNqMr29j6DnSS/nsQlH
         RgpUHSsGuhHRb19cHQz9y5AI6hyitVtD7lFmFB/layBXKyTWgb6E6EBtRwdwerCz8g
         7xnrA/Qe7IyNHrDz85mr56Lzp0FYesHypha/zGG6+xqELk1V/GqChsybcqxxxwAGOb
         eKaH4xpezMBfLsM3tMOmAWRG42Tm5nIJiMFKDjNTlV2SBC1ezh0qfkyTwswtvyMW8y
         Q3ra6RD+afK9A==
Message-ID: <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
Subject: Re: Too many ENOSPC errors
From:   Jeff Layton <jlayton@kernel.org>
To:     Chris Perl <cperl@janestreet.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 08 Jun 2023 16:50:22 -0400
In-Reply-To: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
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

On Thu, 2023-06-08 at 13:05 -0400, Chris Perl wrote:
> Hi everyone,
>=20
> I'm working with several Red Hat derived systems and have noticed an
> issue with ENOSPC and NFS that I'm looking for some guidance on.
>=20
> First let me describe the testing setup, and then I'll share my
> results from an EL7 based system (kernel 3.10.0-1160.90.1.el7), an EL8
> based system (kernel 4.18.0-425.19.2.el8_7), an EL8 based system
> patched with commit e6005436f6cc9ed13288f936903f0151e5543485 (kernel
> 4.18.0-425.19.2.el8_7 plus that commit), and finally an EL8 based
> system but with an upstream 6.1 kernel.
>=20
> Assume I have a 20M quota on my current working directory which is an
> NFS export from one of the major enterprise vendors.
>=20
> The testing looks like the following:
>=20
> # rm -f file1
> # touch file1
> # dd bs=3D1M count=3D20 if=3D/dev/zero of=3Dfile2 # this will use all the=
 quota
> 20+0 records in
> 20+0 records out
> 20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
> # tee -a file1 <<< abc
> abc
> tee: file1: No space left on device
> # rm -f file2
> # tee -a file1 <<< abc
> abc
>=20
> On an EL7 based system, running the above works just as shown. I.e.
> you create file1, then use all the quota with file2, attempt to write
> to file1 which fails with ENOSPC (as expected), remove file2 (which
> frees up the quota), and then attempt to write to file1 again which
> succeeds.
>=20
> However, on a stock EL8 based system, I instead get the following
> surprising behavior:
>=20
> # rm -f file1
> # touch file1
> # dd bs=3D1M count=3D20 if=3D/dev/zero of=3Dfile2 # this will use all the=
 quota
> 20+0 records in
> 20+0 records out
> 20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
> # tee -a file1 <<< abc
> abc
> tee: file1: No space left on device
> # rm -f file2
> # tee -a file1 <<< abc
> abc
> tee: file1: No space left on device
> # tee -a file1 <<< abc
> abc
> tee: file1: No space left on device
>=20
> I.e. Even after freeing the space by removing file2, writing to file1
> continues to fail with ENOSPC forever (I've only shown 2 iterations
> above) [1]. No amount of waiting will cause it to go away. But, we've
> found that running sync(1) on the file will fix it (the sync itself
> will complain with ENOSPC, but then subsequent tee invocatinos
> succeed).
>=20
> I thought that perhaps the issue was the fact that kernel
> 4.18.0-425.19.2.el8_7 was missing commit
> e6005436f6cc9ed13288f936903f0151e5543485 (which adds some ENOSPC
> handling to `nfs_file_write'), so we patched the kernel with that
> patch and tested again. It's worth saying that with this patch, the
> behavior of our 4.18 kernel and the 6.1 kernel are consistent when
> running this test, but I feel like there might still be a bug here.
>=20
> What I get now is:
>=20
> # rm -f file1
> # touch file1
> # dd bs=3D1M count=3D20 if=3D/dev/zero of=3Dfile2 # this will use all the=
 quota
> 20+0 records in
> 20+0 records out
> 20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
> # tee -a file1 <<< abc
> abc
> tee: file1: No space left on device
> # rm -f file2
> # tee -a file1 <<< abc
> abc
> tee: file1: No space left on device
> # tee -a file1 <<< abc
> abc
>=20
> I.e. The first attempt to write to the file after freeing the quota
> fails with ENOSPC, but subsequent attempts succeed. Note that this is
> different from the original behavior on our EL7 based system as shown
> above where as soon as the quota is freed up, there are no more ENOSPC
> errors.
>=20
> I'm no expert, but below I'm including some digging I did in case it's
> helpful for understanding the situation more fully without needing to
> reproduce yourselves. If it's not helpful and just distracting,
> apologies in advance!
>=20
> From strace'ing and systemtap'ing I noticed that the first call to
> `tee' (after the quota is used up by file2) returns the ENOSPC in
> response to close(2) (i.e. via `nfs_file_flush') and the second call

That is (unfortunately) expected behavior. I've argued (mostly
unsuccessfully) for years that we shouldn't return writeback errors in
the close() codepath.

No program should rely on looking for those. The only "legit" error on
close() is -EBADF.

> to `tee' (after the quota has been freed) returns the ENOSPC in
> response to the write(2) (i.e. via `nfs_file_write' , and then clears
> the error via the changes we introduced with commit
> e6005436f6cc9ed13288f936903f0151e5543485).
>=20

Looking at nfs_file_write, it's already tracking errors itself during
the write. Does this patch fix that? Note that I've not tested this --
YMMV!

----------------------8------------------------

[RFC PATCH] nfs: ignore the error from generic_write_sync

In the write codepath, we're only interested in writeback errors that
occur after the point where the write has started. It's possible though
that there were previous errors stored in the mapping before the write
ever began, in which case generic_write_sync will return error.

We already track errors over the part we're interested in, so we can
safely discard errors from generic_write_sync.

Reported-by: Chris Perl <cperl@janestreet.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index f0edf5a36237..3ca1ffb1245e 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -673,10 +673,14 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov=
_iter *from)
 					iocb->ki_pos - written,
 					iocb->ki_pos - 1);
 	}
-	result =3D generic_write_sync(iocb, written);
-	if (result < 0)
-		return result;
=20
+	/*
+	 * For a write, we're only interested in errors that occur
+	 * after the point where we sample the wb_error. Ignore
+	 * errors from generic_write_sync, which may have occurred
+	 * before that point.
+	 */
+	generic_write_sync(iocb, written);
 out:
 	/* Return error values */
 	error =3D filemap_check_wb_err(file->f_mapping, since);
--=20
2.40.1


