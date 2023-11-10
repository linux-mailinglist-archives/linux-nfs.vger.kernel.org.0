Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013697E80CC
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjKJSRd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 13:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345579AbjKJSLN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 13:11:13 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746298264
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 23:11:51 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6cd09f51fe0so1022152a34.1
        for <linux-nfs@vger.kernel.org>; Thu, 09 Nov 2023 23:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699600309; x=1700205109; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8PLYYQU/ZsiFXPjIfAHHMrGvLUTeOkR8y11Y+6ib0Q=;
        b=WxAoaPJRtiLYW5Tqj3qxteItpySA8tsdm7sgFT0AyBCIUHoz1CZBM1exC7asq1epgx
         MkmpUVTGFGgb/JFtXIUQRWAep01P0sx8sKPfciPofb2oV4zOGlL7EyQyWwkdNJUOUOQu
         bv4zNZYG03sY3s5HTGLRlxKmnk+CBRaI4zdcnRYQ4f7PaITRRoipXHWlgfnj2UXmJPwi
         v8Ub76Z+HOXpHcQRKSmH+eB8Ldxia6I9xCijE2YxIk4cJiJeHRqBZBumzh8pHyeb4gmL
         x3N5L7TjTyYwdsIQmU8hbp1cKlICJQex3piCX/uYABAYL8O3F2jlLyEDFST6gppzNLh7
         SbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600309; x=1700205109;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8PLYYQU/ZsiFXPjIfAHHMrGvLUTeOkR8y11Y+6ib0Q=;
        b=L/l7IZNYuYyKMJ9G95SKgSuIYIwRude7Mzg+Sowbih/46zPQQfByISh1diBMKOMPJW
         e+W9tGJBmmg8SBWGCo0/SqjPhnHNd4GMDxZHCOGrirIh6WZB7eOk3j2IlgKB/LT3Q89+
         EcrnpnD3GtNRFuSmDabJJ4zeGIOeVc+KunQpDvkZFMNSUTc+ueLw4eqEfrwob9UPAXtw
         1ljo9ikpLlgq+oK3kdf+s4DwHUrUl1B/iMCoa8UickXq8hcfB6WXsTzkSi9e7jRYGAHP
         LZwQTeZkjBzMtoKGwHX131H3pEC/XaBIq2TW08bygVKli/akP9iMjhr1KocyiWzjJCxo
         XMvg==
X-Gm-Message-State: AOJu0YxnyRHJGK7QnpXHHJN+ZE83VBwBrPL2fJqPF8+cQ8SyALpj++tM
        u2xAmvmaNrC9/v0ypMxLO/r0tIXmA9JZkPVgWvxxXcGu
X-Google-Smtp-Source: AGHT+IELnsixC5FQw9pT0IndeeF7EomBGoMq3DaAUakyEbJ7ZwMh4w7J936WeUc/cHx7MAVVdUvRQ4GXcv2kU1CDvkU=
X-Received: by 2002:a05:6870:c90c:b0:1f0:3259:3ebd with SMTP id
 hj12-20020a056870c90c00b001f032593ebdmr8131227oab.59.1699600309597; Thu, 09
 Nov 2023 23:11:49 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com> <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
In-Reply-To: <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Fri, 10 Nov 2023 08:11:00 +0100
Message-ID: <CANH4o6M9jvVsq1jtGcfVd+BN=Mb9yZ+SxqGeb0wzkFVu+8U9bw@mail.gmail.com>
Subject: Re: BUG in exports(5), no example for refer= Re: Examples for refer=
 in /etc/exports?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

On Fri, Nov 10, 2023 at 1:37=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmail.com>=
 wrote:
> >
> > On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gmail.com=
> wrote:
> >>
> >> Good morning!
> >>
> >> Does anyone have examples of how to use the refer=3D option in /etc/ex=
ports?
> >
> > Short answer:
> > To redirect an NFS mount from local machine /ref/baguette to
> > /export/home/baguette on host 134.49.22.111 add this to Linux
> > /etc/exports:
> >
> > /ref *(no_root_squash,refer=3D/export/home@134.49.22.111)
> >
> > This is basically an exports(5) manpage bug, which does not provide
> > ANY examples.
>
> That's because setting up a referral this way is deprecated.

Then its time to un-depreciate it. We're actively using it, for four
sites with 2000+ active accounts each.

> The
> preferred way to do it is to use nfsref(8).

which -a nfsref
File not found.

This is on Debian SID. Same on Suse. Same on Mandriva.

Thanks,
Martin
