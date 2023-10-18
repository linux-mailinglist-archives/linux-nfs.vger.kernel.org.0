Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96F7CE123
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjJRP0V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 11:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjJRP0V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 11:26:21 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A5A98;
        Wed, 18 Oct 2023 08:26:19 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d2f3bb312so33913586d6.0;
        Wed, 18 Oct 2023 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697642778; x=1698247578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqR4hGhc1859l/BnMFSlg9BknGLMflshjjSUP4qtEr8=;
        b=KHNiYF2E00vbvUMzNgqdyxIFiPF6fmXOfVxpqqFCJ6Ye6HV2OulILEDorrvyY4cBjp
         0IEXy/e034O2d4oN0acAE4rooHOUDUq35tnpNDykQ/JNPEnFR1G+GPNKzBcBKmDwZWGt
         6tXha0aaaQTy0pR6ulMOOStqDAIG3tqcxgv2EsbnticvYNrjJYJfXBBRf9X3TPiZdYBP
         Z/uLbwGC8LXkX8RokoDZori8lZ6xbVAf1vGUROBWrcYh6WwTOt3Mum+jG6fcoHFqFnoE
         2ntYrOAfidJTdiJog3MqSdPZijGopKJvVaK4+9q5E2XBybHdbezX1CoJQBT/yfSsDSCw
         ThXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697642778; x=1698247578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqR4hGhc1859l/BnMFSlg9BknGLMflshjjSUP4qtEr8=;
        b=ibwSsr25u+GRLgBYFhKPO9N8vvp8AtBQb9Jgixsg0Vsj1fmt+g9kiihjqU1EGdmsEL
         GDOSvqn87CxWbh0QKVL5ktj6c4nZQrzEWZovmjdiS1UUgK40+dezR+MUaaq+g/UWb2Zr
         fQiVdDNZqN2oDV9qazWc+Cfx46rmdCHTIuCFqz5PcSg4b32pzXggXoO2YkSYsYBI5wr2
         5hYmH9py9hi9HRCyDDVv5ZCNG2YwZKOFMcM2s6zOZVzy+yklgy74zToMEiOR//kHs/2e
         +MhJrm/LVCRncXgaUYKQ5pT6diQskD8kJ7XKqDwgNzPdLSNnYsfB5tEyYKd46GtIGWE5
         lMGA==
X-Gm-Message-State: AOJu0YwGIIqJ/KtVsWztL0B9/frWyG5bhXi1EfTYkEG6b5cHEHEcDKQM
        mKTXQmOdmp82CT/m8Hgd01OCkKH5iPh0PIZWfZc=
X-Google-Smtp-Source: AGHT+IEH+E5XV632AKLP8jHOGvXaCHrz8scne96ToV2aiw1M+N1uzGIbgUmokOrkvimr875aHEYNx6Ac8+FMDknRXYY=
X-Received: by 2002:a05:6214:c6b:b0:66d:63f8:255f with SMTP id
 t11-20020a0562140c6b00b0066d63f8255fmr6962139qvj.56.1697642778154; Wed, 18
 Oct 2023 08:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231018100000.2453965-1-amir73il@gmail.com> <20231018100000.2453965-4-amir73il@gmail.com>
 <ZS/3UfX/+hH6xKMn@tissot.1015granger.net>
In-Reply-To: <ZS/3UfX/+hH6xKMn@tissot.1015granger.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 18 Oct 2023 18:26:07 +0300
Message-ID: <CAOQ4uxj4CQmVKvmLg0UdNJWZ14Dp6SjJUvwqFdO3u9--M4dH6g@mail.gmail.com>
Subject: Re: [PATCH 3/5] exportfs: make ->encode_fh() a mandatory method for
 NFS export
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Steve French <sfrench@samba.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Evgeniy Dushistov <dushistov@mail.ru>
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

On Wed, Oct 18, 2023 at 6:18=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Wed, Oct 18, 2023 at 12:59:58PM +0300, Amir Goldstein wrote:
> > export_operations ->encode_fh() no longer has a default implementation =
to
> > encode FILEID_INO32_GEN* file handles.
> >
> > Rename the default helper for encoding FILEID_INO32_GEN* file handles t=
o
> > generic_encode_ino32_fh() and convert the filesystems that used the
> > default implementation to use the generic helper explicitly.
> >
> > This is a step towards allowing filesystems to encode non-decodeable fi=
le
> > handles for fanotify without having to implement any export_operations.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
[...]

> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index 5b3c9f30b422..6b6e01321405 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -235,7 +235,7 @@ extern int exportfs_encode_fh(struct dentry *dentry=
, struct fid *fid,
> >
> >  static inline bool exportfs_can_encode_fid(const struct export_operati=
ons *nop)
> >  {
> > -     return nop;
> > +     return nop && nop->encode_fh;
>
> The ->encode_fh() method returns an integer type, not a boolean. It
> would be more clear if this were written
>
>         return nop && (nop->encode_fh !=3D FILEID_ROOT);
>
> (I'm just guessing at what you might have intended).
>

You must be pre-coffee ;)

This checks if the method exists, it doesn't invoke the method.

Thanks,
Amir.
