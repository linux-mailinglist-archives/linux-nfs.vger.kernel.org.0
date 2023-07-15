Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0481B75487F
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Jul 2023 14:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjGOMGn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Jul 2023 08:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGOMGm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Jul 2023 08:06:42 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9EA3585
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jul 2023 05:06:40 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-579dd20b1c8so25870477b3.1
        for <linux-nfs@vger.kernel.org>; Sat, 15 Jul 2023 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689422800; x=1692014800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At/GQBgX7TVGQ3sGDbdWS7ospyO5dsvWNAD/T12Jgp0=;
        b=iPxt9oXLwr7sLGNpbC/jqgVV4HPY2NcebdIP7mm/vRy8r4XUDwDqWUdBCtEiAmaxnP
         kFVuC6T4DBoAVHOQn61d5UNIs4/WpKyD42OboAkbMmDlzAKJgWBpA7yLqBkrmafTS4Cy
         /O7wliygyACK1LHTcL9P1v0CfEXthHIwak/lSRXWNUX0bms4l9DjqIWwTd59u+LdJXEm
         iD21F5AwRTNs8x6uCUVTIIzQAPskqgHfRDBOZx2KWZuT9VdRpKhKacp7/neXuF5XHX25
         8yQHb2Esrw6/PJ+M+WXpfOrqjLm52ln5PT5lUa+6sCKGSxc4f1uPchG+kh0HCiO7f/9e
         wJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689422800; x=1692014800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At/GQBgX7TVGQ3sGDbdWS7ospyO5dsvWNAD/T12Jgp0=;
        b=YflRp6FdBMMLBVfYWJcDAhcxd0HKNZFUbeSvwrIKH68fSyBZbfhqi1pgqYnA/r5meK
         +P9qxY462hgWzVSmGYQtlr8nEJik4oEiYIoooOCQJcblVSA2y3KvqrZfrwPTmEznFXSm
         eIobVTOVzt+9X9QZlygbaO29qlA4L3X8eG77nCk3D9YnRPAtvMgc9bYSI0yGY7sy/CvP
         PEsplerqdsE/XULFeuYN4ZdGOz59HiGQEPJ8rVLtpfAC0CuoM4QTKcrW9GJw3RQitBMQ
         6rv9B+ehbrxKea8sqjfgUvN7+z7CYSDiw6DaEx7S2qFIJqssXqFpdShHcLz4nPVJ0nFr
         mpEA==
X-Gm-Message-State: ABy/qLY9fQ6Y6aukuP42DmASYODFeD5MAy8gM5QM0YkKTAgleDD5AZat
        rcQCjT70bH9dKhaEzRfN21/qSZlMxdk85pqrj3s=
X-Google-Smtp-Source: APBJJlEfDp5Uj6BbkqsXIcIiqZXSd6cw679GN+wSz4V2EH75GYUIEGZU+MRl4MoE6IZBhBX+bhGxD6VQs0Tt50TDl34=
X-Received: by 2002:a81:4991:0:b0:56c:ed71:a4ca with SMTP id
 w139-20020a814991000000b0056ced71a4camr6742583ywa.1.1689422800034; Sat, 15
 Jul 2023 05:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <8d6d9329-f5f1-2f15-f578-e4f8010b9b02@gmail.com>
 <5E28252D-6EA1-4DD9-A5B3-957E13589982@redhat.com> <CAB6yy359Gvdu=v1ZvTLXPoY2EMtER3_cBVDKc4MQYhaMOjcUSw@mail.gmail.com>
 <70B9A332-FDA0-418E-81CF-962229E93AC5@redhat.com>
In-Reply-To: <70B9A332-FDA0-418E-81CF-962229E93AC5@redhat.com>
From:   Kinglong Mee <kinglongmee@gmail.com>
Date:   Sat, 15 Jul 2023 20:06:28 +0800
Message-ID: <CAB6yy36uWjnay8OTbZCvHGNih8mjCASc7yDnNeDp2KqxfA8Dzw@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix redundant readdir request after get eof
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
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

On Fri, Jul 14, 2023 at 11:19=E2=80=AFPM Benjamin Coddington
<bcodding@redhat.com> wrote:
>
> On 13 Jul 2023, at 23:07, Kinglong Mee wrote:
>
> > Hi Ben,
> >
> ...
> > Comparing with the above one, this seems work.
>
> This fixes it for me and keeps the optimization.  Its quite a subtle bit =
of
> logic - maybe a comment is appropriate?

Thanks for your testing.
I will send a new patch with a comment.

>
> One non-intuitive thing here is
> that array->size =3D=3D 19 for a directory with 18 entries, since we coun=
t the
> "eof" entry as a blank entry instead of the last real entry.

No.
This is not a blank entry, every entry is a real one.
For the first emit, only returns 18 entries to the caller,
the next emit will return the 19th one.

thanks,
Kinglong Mee
