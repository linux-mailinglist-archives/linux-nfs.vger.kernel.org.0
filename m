Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C2072C8BE
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbjFLOim (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjFLOil (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:38:41 -0400
Received: from mxout1.mail.janestreet.com (mxout1.mail.janestreet.com [38.105.200.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4009CC
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 07:38:37 -0700 (PDT)
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.96)
        id 1q8iWr-005kJK-1A
        for linux-nfs@vger.kernel.org;
        Mon, 12 Jun 2023 10:28:21 -0400
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5126fda879cso1019723a12.0
         for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1686580100; x=1689172100;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:from:to:cc:subject:date
          :message-id:reply-to;
         bh=l03efBZxPCp0qOKoCaPAQqoG1Yo6p6Kcu2s5Kl8/2Zg=;
         b=viRlhuExwnkBmj1c4RazwS3x+Pem39g/D9RUicTstslRZI49VJ11Q7pg+00HyKlGnA
          32N63CGetQsKOOmZ0rnArmO/N5IsTPSE4KRnsESEy+3yowG456TGbXOoCt8/BuE+Rf2Y
          6Rmq06bwNoBPMinlX7uWoaaNpYFvlymDSO6ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20221208; t=1686580100; x=1689172100;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
          :subject:date:message-id:reply-to;
         bh=l03efBZxPCp0qOKoCaPAQqoG1Yo6p6Kcu2s5Kl8/2Zg=;
         b=CqT6V9XudPx7O3WUFTFAVlGfqMfZAln1jXphse4gGxRcH6l0pOo7lCqB0WYrW5QQPM
          F5GTvFTKqvUJfwbn1yJu/uqh2WM8aSRvcUxeH0DlFQeyMpJYznRUQGDoDpf4g7UCGR8u
          ab6RUrTUFJ5/ZcxyPZhMYbVQjsuieHQjYE5QiJrGDqr8lKNhtTqpQd8vtYDzU5uC0qMy
          8F3Ut33GcVgXwO7IkH/ioU8vheWMlwlu837vqnBRKOwWLdvmNn47EAG2K3LjSMRMbmEj
          chRqHwL5exVkzzBG0pdCSNbvlG+o+NRU84OoyE10TvzzVklJP2qcpA3BwL4P4FVKY7mb
          5MUA==
X-Gm-Message-State: AC+VfDx4/Mlokf0cx7W98SaD2cxOoeWy5jpmT6lodiBuN0qyKeHhV1XK
        ErIqx67CIowMRdhgPp/Xpn2VlaeHOE7R8qYjy4qadD+xcdnw3g1y8krA+TFceQNd/2JefP3BcmD
        0GQM8whs5smAEuUXGijHRHTWH6Nudu9m7Pp0bObtvD3L0mw==
X-Received: by 2002:a05:6402:40d4:b0:514:ab8b:ee78 with SMTP id z20-20020a05640240d400b00514ab8bee78mr9166248edb.3.1686580100641;
         Mon, 12 Jun 2023 07:28:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6K0N7PNoErndza9SpRSAbonBnIi1rCtagBXzSV9T0OzMWlw/8r558AuRnzRoUvbayNrsux6SuLcCXdridAuL0=
X-Received: by 2002:a05:6402:40d4:b0:514:ab8b:ee78 with SMTP id
  z20-20020a05640240d400b00514ab8bee78mr9166236edb.3.1686580100270; Mon, 12 Jun
  2023 07:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
  <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
In-Reply-To: <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
From:   Chris Perl <cperl@janestreet.com>
Date:   Mon, 12 Jun 2023 10:27:44 -0400
Message-ID: <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
Subject: Re: Too many ENOSPC errors
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 8, 2023 at 4:50=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Thu, 2023-06-08 at 13:05 -0400, Chris Perl wrote:
> > Hi everyone,
> >
> > I'm working with several Red Hat derived systems and have noticed an
> > issue with ENOSPC and NFS that I'm looking for some guidance on.
> >
> > First let me describe the testing setup, and then I'll share my
> > results from an EL7 based system (kernel 3.10.0-1160.90.1.el7), an EL8
> > based system (kernel 4.18.0-425.19.2.el8_7), an EL8 based system
> > patched with commit e6005436f6cc9ed13288f936903f0151e5543485 (kernel
> > 4.18.0-425.19.2.el8_7 plus that commit), and finally an EL8 based
> > system but with an upstream 6.1 kernel.
> >
> > Assume I have a 20M quota on my current working directory which is an
> > NFS export from one of the major enterprise vendors.
> >
> > The testing looks like the following:
> >
> > # rm -f file1
> > # touch file1
> > # dd bs=3D1M count=3D20 if=3D/dev/zero of=3Dfile2 # this will use all t=
he quota
> > 20+0 records in
> > 20+0 records out
> > 20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
> > # tee -a file1 <<< abc
> > abc
> > tee: file1: No space left on device
> > # rm -f file2
> > # tee -a file1 <<< abc
> > abc
> >
> > On an EL7 based system, running the above works just as shown. I.e.
> > you create file1, then use all the quota with file2, attempt to write
> > to file1 which fails with ENOSPC (as expected), remove file2 (which
> > frees up the quota), and then attempt to write to file1 again which
> > succeeds.
> >
> > However, on a stock EL8 based system, I instead get the following
> > surprising behavior:
> >
> > # rm -f file1
> > # touch file1
> > # dd bs=3D1M count=3D20 if=3D/dev/zero of=3Dfile2 # this will use all t=
he quota
> > 20+0 records in
> > 20+0 records out
> > 20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
> > # tee -a file1 <<< abc
> > abc
> > tee: file1: No space left on device
> > # rm -f file2
> > # tee -a file1 <<< abc
> > abc
> > tee: file1: No space left on device
> > # tee -a file1 <<< abc
> > abc
> > tee: file1: No space left on device
> >
> > I.e. Even after freeing the space by removing file2, writing to file1
> > continues to fail with ENOSPC forever (I've only shown 2 iterations
> > above) [1]. No amount of waiting will cause it to go away. But, we've
> > found that running sync(1) on the file will fix it (the sync itself
> > will complain with ENOSPC, but then subsequent tee invocatinos
> > succeed).
> >
> > I thought that perhaps the issue was the fact that kernel
> > 4.18.0-425.19.2.el8_7 was missing commit
> > e6005436f6cc9ed13288f936903f0151e5543485 (which adds some ENOSPC
> > handling to `nfs_file_write'), so we patched the kernel with that
> > patch and tested again. It's worth saying that with this patch, the
> > behavior of our 4.18 kernel and the 6.1 kernel are consistent when
> > running this test, but I feel like there might still be a bug here.
> >
> > What I get now is:
> >
> > # rm -f file1
> > # touch file1
> > # dd bs=3D1M count=3D20 if=3D/dev/zero of=3Dfile2 # this will use all t=
he quota
> > 20+0 records in
> > 20+0 records out
> > 20971520 bytes (21 MB, 20 MiB) copied, 0.193018 s, 109 MB/s
> > # tee -a file1 <<< abc
> > abc
> > tee: file1: No space left on device
> > # rm -f file2
> > # tee -a file1 <<< abc
> > abc
> > tee: file1: No space left on device
> > # tee -a file1 <<< abc
> > abc
> >
> > I.e. The first attempt to write to the file after freeing the quota
> > fails with ENOSPC, but subsequent attempts succeed. Note that this is
> > different from the original behavior on our EL7 based system as shown
> > above where as soon as the quota is freed up, there are no more ENOSPC
> > errors.
> >
> > I'm no expert, but below I'm including some digging I did in case it's
> > helpful for understanding the situation more fully without needing to
> > reproduce yourselves. If it's not helpful and just distracting,
> > apologies in advance!
> >
> > From strace'ing and systemtap'ing I noticed that the first call to
> > `tee' (after the quota is used up by file2) returns the ENOSPC in
> > response to close(2) (i.e. via `nfs_file_flush') and the second call
>
> That is (unfortunately) expected behavior. I've argued (mostly
> unsuccessfully) for years that we shouldn't return writeback errors in
> the close() codepath.
>
> No program should rely on looking for those. The only "legit" error on
> close() is -EBADF.
>
> > to `tee' (after the quota has been freed) returns the ENOSPC in
> > response to the write(2) (i.e. via `nfs_file_write' , and then clears
> > the error via the changes we introduced with commit
> > e6005436f6cc9ed13288f936903f0151e5543485).
> >
>
> Looking at nfs_file_write, it's already tracking errors itself during
> the write. Does this patch fix that? Note that I've not tested this --
> YMMV!

Unfortunately that patch doesn't seem to help.

Since we applied commit e6005436f6cc9ed13288f936903f0151e5543485 and
it seemed to improve the situation (from an unbounded number of ENOSPC
errors to only one additional ENOSPC error), I believe that implies
the error we're seeing is coming from `filemap_check_wb_err', not
`generic_write_sync' in `nfs_file_write'.

I'll do some more tracing and see if I can narrow it down a bit more.

> ----------------------8------------------------
>
> [RFC PATCH] nfs: ignore the error from generic_write_sync
>
> In the write codepath, we're only interested in writeback errors that
> occur after the point where the write has started. It's possible though
> that there were previous errors stored in the mapping before the write
> ever began, in which case generic_write_sync will return error.
>
> We already track errors over the part we're interested in, so we can
> safely discard errors from generic_write_sync.
>
> Reported-by: Chris Perl <cperl@janestreet.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfs/file.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index f0edf5a36237..3ca1ffb1245e 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -673,10 +673,14 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct i=
ov_iter *from)
>                                         iocb->ki_pos - written,
>                                         iocb->ki_pos - 1);
>         }
> -       result =3D generic_write_sync(iocb, written);
> -       if (result < 0)
> -               return result;
>
> +       /*
> +        * For a write, we're only interested in errors that occur
> +        * after the point where we sample the wb_error. Ignore
> +        * errors from generic_write_sync, which may have occurred
> +        * before that point.
> +        */
> +       generic_write_sync(iocb, written);
>  out:
>         /* Return error values */
>         error =3D filemap_check_wb_err(file->f_mapping, since);
> --
> 2.40.1
>
>
