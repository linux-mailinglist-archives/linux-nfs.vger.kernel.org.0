Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A237AF711
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 02:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjI0AND (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Sep 2023 20:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjI0ALC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Sep 2023 20:11:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F864558D
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 14:53:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c00b877379so35694901fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1695765189; x=1696369989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWUew9pGHgcnr39nzpTNIYjkYcPJKDLbmaOxhgsohaE=;
        b=m5skwI8qdJbKq1OmFsHZSG0bJfzPpJa4xu7I7rNudeiKvW56EyZuNqv/xy5FhRfJTk
         iZwF9C+O7BZXQsEIhvgysPBc5pZ/iKwtnGUgi6x5haVI91FBHiH0p3XYTJweurjCr0W3
         egK+SYx3o0VeUUY55Bks4VwkAAq0Svw2buAMHbqcRBvHkwXadtLUroX5Rf0EIS8bcvmV
         UxtE+pvnTxg2G0OKUWFOWvkrKUrfhmxrLyxrNnvEZZkWel+z7STV+cGOl+FYhu/33Wme
         CicpoM44A68eWi7xt2hvhAsAfB0zoVxEeygHh7mNbVy2g1g5Vd/I26iDJtanHoi1BSa/
         z3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695765189; x=1696369989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWUew9pGHgcnr39nzpTNIYjkYcPJKDLbmaOxhgsohaE=;
        b=d36KqF4sBZjrRgr+4BbZsCh4cxiZ2B6B4oJGTVh3MXYkA0hHC/yQGn+Ja7k1KHUEQK
         tHDzhqi2STOYgKMvxliWIEHn/WqtQfkUCqpo2xg1eF1iz6Wmxs+4TeJb5IdVyvK61fzP
         IpA5Mw87gZi3i4wqeYaZRCD6zabO3drMpx0eikhjb+8Ka7qglTgpTAx5uDnfzR1kr5IV
         yLruaJVo+KWDQj8YDB0ittwfIGAJUvQlscyiFs5XWdJuWILzfAhbHc/Aps4T2flCLd7O
         4ukY3F2pAdWOzzMCqo9RuFar68N+JobFOQK3PkqGmM/dold9p/CZh4vl57xzYzzKLLfK
         nCuw==
X-Gm-Message-State: AOJu0YxS4q98+iDj4wwh/QK0V3ZT4zU+12XqaA25EjkHdaYAdPXFANDQ
        Inzynvx7Yj2KJqviveVbCpK/Ggd+aTWfGgzlDH8tJ+CK
X-Google-Smtp-Source: AGHT+IFSfdwM6yZr0XGh9O8kBpNAr/0YrZQTsUETvwwdz0Quis23YQ0ibPGHgfTqksMELn/hapS+jEKbAAdJjwnNf28=
X-Received: by 2002:a2e:a992:0:b0:2bf:7908:ae7c with SMTP id
 x18-20020a2ea992000000b002bf7908ae7cmr282958ljq.2.1695765188473; Tue, 26 Sep
 2023 14:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <f1d0b234-e650-0f6e-0f5d-126b3d51d1eb@gmail.com>
 <6E4B8EB9-FA7E-4ABD-81AB-6FB0EF07EA46@oracle.com> <f90866e3-8c54-8a9c-c100-f5550c31b664@gmail.com>
 <9691788F-2B62-4EB5-8879-CEDABD1B9D4B@oracle.com> <78c81a97-4324-c2df-27c0-917436ddee07@gmail.com>
 <6908E735-6912-4AEC-8AD7-995F2F8A144A@oracle.com> <CA1D7203-72FB-4681-AD60-F1D80A57C154@oracle.com>
 <8cb19861-7fd2-4d12-bd76-78bbb8fcee7c@gmail.com> <2660F09A-5823-4581-8977-4F41153724D6@oracle.com>
In-Reply-To: <2660F09A-5823-4581-8977-4F41153724D6@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 26 Sep 2023 17:52:57 -0400
Message-ID: <CAN-5tyHHibZbJh-A=0n3d=Z7GVL1xuYz8H2ygu8HbnsrtUTUxQ@mail.gmail.com>
Subject: Re: Data corruption with 5.10.x client -> 6.5.x server
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 26, 2023 at 10:08=E2=80=AFAM Chuck Lever III <chuck.lever@oracl=
e.com> wrote:
>
>
>
> > On Sep 26, 2023, at 12:41 AM, Mantas Mikul=C4=97nas <grawity@gmail.com>=
 wrote:
> >
> > On 25/09/2023 22.22, Chuck Lever III wrote:
> >>> On Sep 24, 2023, at 2:24 PM, Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
> >>>
> >>>> On Sep 24, 2023, at 12:51 PM, Mantas Mikul=C4=97nas <grawity@gmail.c=
om> wrote:
> >>>>
> >>>> Right, whereas on the server, the first file is filled with "Hello W=
orld (4092 bytes)" as I originally tried to narrow down the issue.
> >>>>
> >>>> Meanwhile, 6.4.x (Arch) clients don't seem to be having any problems=
 with the same server, and with seemingly the same mount options.
> >>>>
> >>>> Thanks for looking into it!<nfs_krb5i_working_6.4client.pcap>
> >>> I found /a/ problem with the nfsd-fixes branch and krb5i, but
> >>> maybe not /your/ problem, and it's with a recent client. Scrounging
> >>> a v5.10-vintage client is a little more work, we'll see if that's
> >>> needed for confirming an eventual fix.
> >> The issue I reproduced appears to be unrelated.
> >>
> >> I'm wondering if I can get you to bisect the server kernel using
> >> your v5.10 client to test? good =3D v6.4, bad =3D v6.5 should do it.
> >
> > Yeah, I will try to bisect but it'll probably take a day or two.
>
> That's great, thank you!
>
> I'm looking into setting up a virtual guest with v5.10 just in case.
> Turns out v5.10 does not build on Fedora latest.
>

I can reproduce this with upstream client do dd if=3D/mnt/4092byteslen
of=3D/dev/null bs=3D4092 count=3D1 iflag=3Ddirect

> --
> Chuck Lever
>
>
