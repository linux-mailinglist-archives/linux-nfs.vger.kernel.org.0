Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC4C7E803C
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 19:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344205AbjKJSIA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 13:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345891AbjKJSG7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 13:06:59 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620BE8A47
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 00:05:23 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1ea82246069so925091fac.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 00:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699603522; x=1700208322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KACfZePjnncAukJPtAsF1x2wMAGLzYez3QYk9P8Ccgc=;
        b=CT6X6Vb63jtcCt6zteHR1E/dv6kSCu/FBZXott44XXHLpo4orwZcMk1HeUhK/eV0nU
         Q6JWDmlLcRb3ts5H7Mi1fLxKSDP78eup+hsxqe39Ad0qeNX9WjctqQMgh0VabMQVXyB/
         x6JpEgzCfxbBbEZjqPainee/FDZaJrHqpP0JNTFY8C3w1exxxaTv2ThKj/zjXrJ1hp2w
         Ewb9JNR38VnwcRyC8cL5qhtGMXprZsa1vi2xUGemPSb+O1KXskCYRgmdNnRMMYFTrTCG
         wup/rw03MyF2qHORtSF7hcD7lmjThWaXEB/R9tDuhh/Dv9A1KWA/rDUZJpajNckBYBSJ
         2mPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699603522; x=1700208322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KACfZePjnncAukJPtAsF1x2wMAGLzYez3QYk9P8Ccgc=;
        b=rj7xy/LXbwOv7nOfFgFPC97YdVdq7Dtfie7m+JlfmXv9fc35LOWi0m82l1cxFp/wPl
         ogfJqusvk5gGRNTa+a2nyhZ7EnuraMrhNXZfzsgn7vBYQLafyNh2skFt3iWv96k6+fwz
         62tVaKHSuth1P0JmLWTRLjZoLYGdwI8Cllj4D524/mrj1uz4+ADXpZLQlzPewXur3aiZ
         ZLF4xQQAwNx/ttZV2SQbwxX4qBocLot3K9w0ZxN/5QSXOJfnfEI8PaC8OHE51pMPwskN
         2dsOveqyWHNO29XL1ZkZ7GaZrBazWP6ec2uiPFfRSLBgBHAYRpde00Oto2LsGMkAOh7w
         6XxQ==
X-Gm-Message-State: AOJu0Yz4Eh/PblFzd4RgOsDmyQjVKiFxLZtntc43rE2bWkocBt4hPirQ
        1wXKQedZSw29hr4l1ZimsVDio5ePnd7Y7B417uhvOgOE
X-Google-Smtp-Source: AGHT+IGop/lWPqJor1gpQqchc6cH32uuZ3QJABdYqD5FBakjco7xp2bfWI3iXWvRSBhZv27ucAldfKWaaDazT0p8ZUk=
X-Received: by 2002:a05:6870:10cb:b0:1f0:36ab:2886 with SMTP id
 11-20020a05687010cb00b001f036ab2886mr7223502oar.41.1699603522698; Fri, 10 Nov
 2023 00:05:22 -0800 (PST)
MIME-Version: 1.0
References: <CANH4o6MYtA60MJ6=4Gg3ApzpZ42TzQiD13g1EE9OXkyM+8_Ssg@mail.gmail.com>
 <45F5C27D-4D6A-4879-9A69-C38C70896DD1@redhat.com>
In-Reply-To: <45F5C27D-4D6A-4879-9A69-C38C70896DD1@redhat.com>
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Fri, 10 Nov 2023 09:04:00 +0100
Message-ID: <CANH4o6Pnsq28Kxu86BJ77q--=ouWTM3oy=_tm_qV4rqSSxYfXw@mail.gmail.com>
Subject: Re: Linux NFSv4 client maintainer?
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 1, 2023 at 3:49=E2=80=AFPM Benjamin Coddington <bcodding@redhat=
.com> wrote:
>
> On 1 Nov 2023, at 5:40, Martin Wege wrote:
>
> > Good morning!
> >
> > Who is the NFSv4 client maintainer these days?
>
> Linux kernel maintainers are listed in MAINTAINERS.  You can use
> ./scripts/get_maintainer.pl to lookup maintainers by path:
>
> $ ./scripts/get_maintainer.pl  -f fs/nfs/super.c
> trond.myklebust@hammerspace.com,anna@kernel.org
>
> Documentation/process/howto.rst is a nice light read that would have
> answered this question for you.

Thanks, but it is HARD to always find the relevant information when
you are not 100% familiar with a project. Thats why I asked... ;-)

Thanks,
Martin
