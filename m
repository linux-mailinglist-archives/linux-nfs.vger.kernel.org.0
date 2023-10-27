Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF47D8EE2
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 08:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJ0GnQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 02:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GnO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 02:43:14 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E172121;
        Thu, 26 Oct 2023 23:43:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d36b2a247so11689706d6.1;
        Thu, 26 Oct 2023 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698388992; x=1698993792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5uG6VL22c1tEm5EQWvWRaIRE/SGFemhnIPLZLh3Gcw=;
        b=lvDZLjX6IkaMjRarHpvjYl5GeCXWwT5mSX5fdhLLMGMaHRtGB+Ra6p+Q0GNr1Pz2q0
         u8e2nXw2LfpnFN9fIE+KJSyl93acOhR9P3/l266tdzEKa1MdDsbm8Dc5fSXcIOMmbBM8
         bIoxT4Lp4ZRomZcLfi5icB9wMflRpf+GgbdKCgpSaKmKvxKiPliUpMQ1DnZI8A9HOXZF
         fMnQd1+QrUovYIZSmhO+hbHldO3Ln4lnH+oTZRkBi8M9gRayHa6lPFXC2Jn7pYALvYeu
         aaNCIVmPF3qUQbXlyRPdGcJlL8g7ce68nxDR+RzqfW7qelsZQDJ+RHLu07QYlUCfE8fz
         XXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698388992; x=1698993792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5uG6VL22c1tEm5EQWvWRaIRE/SGFemhnIPLZLh3Gcw=;
        b=uYL6Uqo5bgQzn6315du6UYJEvfDAcDCxsd2MqCaSlppvGvs/7eVG64Abpj5KovZk54
         SRwV1zGL9g/aYwSd5yy0rjbDpyAOnChqZxAi7hOhA5+8KiLReYpsdTKIiThbIhOJUFH0
         AoRcDuEwPK5NrqBoirgwqU0nBDvWVUkIdsDHZ1vv9U+BPTNZfXzbU4e9zNMi0ekDKgkg
         hUmn0aeTiP1iCvnYnMGBg9yHeCsUuzxTuKjCuGloNzvvl4/BZl+Rf25O7Ymn/z4MPq6Y
         ap0pbaA6inFmC25XkdWbX1Ir8MayrXsSjsUMH6e9gclT2T+HKBOtfsqdClb8GknBZrBA
         jkHg==
X-Gm-Message-State: AOJu0YwOVAtXsVbAyBKhDiFUS2RPiqmU75WHSZL5JGwfKb+KCUPXLP6Q
        LVotiejUxTYAxhBxUCbXjUJ34DeNveBzTsQ8JTs=
X-Google-Smtp-Source: AGHT+IGI9+jlBzvWTQSmXsRyASadZs15hk2tJyadDNdA9kqRqnQ2/A6wN8DCFC/4jghnDUmO35TaLX525p3PeQXVEnU=
X-Received: by 2002:a05:6214:e4e:b0:655:d6af:1c32 with SMTP id
 o14-20020a0562140e4e00b00655d6af1c32mr1976846qvc.15.1698388992107; Thu, 26
 Oct 2023 23:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231023180801.2953446-1-amir73il@gmail.com> <20231023180801.2953446-4-amir73il@gmail.com>
 <ZTtTEw0VMJxoJFyA@infradead.org>
In-Reply-To: <ZTtTEw0VMJxoJFyA@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 27 Oct 2023 09:43:01 +0300
Message-ID: <CAOQ4uxj_R1KyYJqBXykCDUYZUEdXC3x0j1vZdOXsRcSb6dKaRg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] exportfs: define FILEID_INO64_GEN* file handle types
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
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

On Fri, Oct 27, 2023 at 9:05=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Oct 23, 2023 at 09:08:00PM +0300, Amir Goldstein wrote:
> > Similar to the common FILEID_INO32* file handle types, define common
> > FILEID_INO64* file handle types.
> >
> > The type values of FILEID_INO64_GEN and FILEID_INO64_GEN_PARENT are the
> > values returned by fuse and xfs for 64bit ino encoded file handle types=
.
>
> Please actually switch xfs to fully use the helpers instead of
> duplicating the logic.

I will follow up with another patch.

> Presumable the same for fuse, but for that
> I'd need to look at how it works for fuse right now and if there's not
> some subtle differences.
>

There are subtle differences:
1. fuse encodes an internal nodeid - not i_ino
2. fuse encodes the inode number as [low32,high32]

It cannot use the generic helper.

Thanks,
Amir.
