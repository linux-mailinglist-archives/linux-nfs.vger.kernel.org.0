Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39D87CE48B
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 19:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjJRR3s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjJRR3J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 13:29:09 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0D73273;
        Wed, 18 Oct 2023 10:19:57 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7dafb659cso86416707b3.0;
        Wed, 18 Oct 2023 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697649596; x=1698254396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEhYXwKlNRKuJG2R6Sj8ITboKE4QxjoJsQDvPN3BEP4=;
        b=AhDYq/j+T35q4IEIhHwPURM4QIxDpKxRxFWZ7LlEjMa5AHU1zdAwuItfn7wte0lXn7
         BVSIx6bbH4l5rPcivyP5Nxg06MMvn+gXtBxTXLoQwT0ew+sVc6ctZufE8NCe4d8zv/Pg
         1EGjTvApUSNs3YsxWIoX4WFQ0qte5R2OMBIGEaHfZqGjUVd6v9/qU/vvbCGky3VaRKsw
         ZR1W/iHHH25Mi0gSGjfo01soqJEDfWSmAF6lJ1Say2F7+EDScdnwgRU1tRcwm00B8F3m
         KbFq8+bs/TrHT1U1nyQ80Lco6tTnLcMdEGQUYSRptgM+UekSyh5kFeaKx/fRqaarF1rB
         xYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697649596; x=1698254396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEhYXwKlNRKuJG2R6Sj8ITboKE4QxjoJsQDvPN3BEP4=;
        b=vU9x9nfozOUK56s3SkbWbdejyc7h+X1Y90ncsDJKgtg5O39nSteVCHkwDTxGkoR8KQ
         D31mcPXhXSWoOX1f4PeuApZtpL9AEcvlUDt7uyPhvr1Rw9ssjdhcCfMcXtCTiRoCEjWR
         tVQof9DjdEmQS1gC79kn0XXqjvDGwGkWXRVPOVLJk5hpsL1Ou+fiMyVQDtvDGT+vifQo
         ezhqHTJ6MNuRITC+Uz7cXYHiVxe1znaI/oy91YPq09ZqJ6Ilm9XtFAzh8SawuI2oSs8Y
         IfRoho7t/eTK3sVtm4gbe9I6xZWRekkCFbRPILG+/pTaLa6D1ow5T+r3MaMMdSVBAIvW
         k4rg==
X-Gm-Message-State: AOJu0YyWk32mk0utloWizYfvvM/37gm1VSJnjnIgYqUybcUfRIj1mQsT
        w2stnueAfQ3Bjzv3YoyBMZg3yT3rRLUWDeSJSV1PQcLe
X-Google-Smtp-Source: AGHT+IF10FRb/5w3eMY+ixdibeePFD8DKC4yRtWqEmPPJwmX0wfE2re6wpOMo5JAKPbZarPPNgMFf3mSxGwQ1aDfLlI=
X-Received: by 2002:a81:b40f:0:b0:583:f5fe:d73e with SMTP id
 h15-20020a81b40f000000b00583f5fed73emr5903683ywi.30.1697649595953; Wed, 18
 Oct 2023 10:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231018100000.2453965-1-amir73il@gmail.com> <20231018100000.2453965-6-amir73il@gmail.com>
 <ZS/5fp4XL4D49q9T@tissot.1015granger.net>
In-Reply-To: <ZS/5fp4XL4D49q9T@tissot.1015granger.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 18 Oct 2023 20:19:44 +0300
Message-ID: <CAOQ4uxhaoup7OCTCcbV-uqZF8SaLWppqN8tM3svZsfAf022Jsw@mail.gmail.com>
Subject: Re: [PATCH 5/5] exportfs: support encoding non-decodeable file
 handles by default
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 18, 2023 at 6:28=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Wed, Oct 18, 2023 at 01:00:00PM +0300, Amir Goldstein wrote:
> > AT_HANDLE_FID was added as an API for name_to_handle_at() that request
> > the encoding of a file id, which is not intended to be decoded.
> >
> > This file id is used by fanotify to describe objects in events.
> >
> > So far, overlayfs is the only filesystem that supports encoding
> > non-decodeable file ids, by providing export_operations with an
> > ->encode_fh() method and without a ->decode_fh() method.
> >
> > Add support for encoding non-decodeable file ids to all the filesystems
> > that do not provide export_operations, by encoding a file id of type
> > FILEID_INO64_GEN from { i_ino, i_generation }.
> >
> > A filesystem may that does not support NFS export, can opt-out of
> > encoding non-decodeable file ids for fanotify by defining an empty
> > export_operations struct (i.e. with a NULL ->encode_fh() method).
> >
> > This allows the use of fanotify events with file ids on filesystems
> > like 9p which do not support NFS export to bring fanotify in feature
> > parity with inotify on those filesystems.
> >
> > Note that fanotify also requires that the filesystems report a non-null
> > fsid.  Currently, many simple filesystems that have support for inotify
> > (e.g. debugfs, tracefs, sysfs) report a null fsid, so can still not be
> > used with fanotify in file id reporting mode.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/exportfs/expfs.c      | 30 +++++++++++++++++++++++++++---
> >  include/linux/exportfs.h | 10 +++++++---
> >  2 files changed, 34 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> > index 30da4539e257..34e7d835d4ef 100644
> > --- a/fs/exportfs/expfs.c
> > +++ b/fs/exportfs/expfs.c
> > @@ -383,6 +383,30 @@ int generic_encode_ino32_fh(struct inode *inode, _=
_u32 *fh, int *max_len,
> >  }
> >  EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
> >
> > +/**
> > + * exportfs_encode_ino64_fid - encode non-decodeable 64bit ino file id
> > + * @inode:   the object to encode
> > + * @fid:     where to store the file handle fragment
> > + * @max_len: maximum length to store there
>
> Length in what units? Is the 3 below in units of bytes or
> sizeof(__be32) ? I'm guessing it's the latter; if so, it should
> be mentioned here. (We have XDR_UNIT for this purpose, btw).
>
> export_encode_fh() isn't exactly clear about that either, sadly.
>
>

Yeh, it's the same all over the place including in filesystem
implementations.

> > + *
> > + * This generic function is used to encode a non-decodeable file id fo=
r
> > + * fanotify for filesystems that do not support NFS export.
> > + */
> > +static int exportfs_encode_ino64_fid(struct inode *inode, struct fid *=
fid,
> > +                                  int *max_len)
> > +{
> > +     if (*max_len < 3) {
> > +             *max_len =3D 3;
>
> Let's make this a symbolic constant rather than a naked integer.
>

Sure, no problem.

Thanks for the review.
Amir.
