Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C43152E5BC
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 22:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfE2UH3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 16:07:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38050 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfE2UH2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 May 2019 16:07:28 -0400
Received: by mail-io1-f68.google.com with SMTP id x24so2994167ion.5
        for <linux-nfs@vger.kernel.org>; Wed, 29 May 2019 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7q0Sakd1TMkC1/w4DpfOGtUEuXYbC69ZIx84jI1pQE=;
        b=DOIjodoKBpVvicd8iDtrrwhif6Fib/sukeSD0x56bYmuIi1beWgtXwdytda7dWQgMd
         gJ2U5BibWYNUP2VaPQxUld1xky26JJBe0Ywg6g4AGWVI57ApfHMaGaai7ThzOR2KE0b7
         mrt1w7wiTb22NSefuJS1fE0oNa2zhUNQ4XBSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7q0Sakd1TMkC1/w4DpfOGtUEuXYbC69ZIx84jI1pQE=;
        b=P/8H61GhB4h6eM7aL4oPJFjKGTQGXhxJ3fkJbsLR5rahla1mSknfIWmXq34hy04hxU
         NMZOU+GdlkevKRBF7oAR8K5HDpwj0WmRl3UXWeTmG8BFobYqg2MxJrPixeGQ5WUymC9g
         /C5XP0YyO70j5I9xcYINbmJr3IE54QfJbkW3OCkGDJ+XwQjjWNfGT/TvYgufePk0WKct
         20XtOMxa5nm7Pe5on/NyTahFOtGeKaEVQfl9Cx/r2CjCLZiIeBGIjLeLj7CqunmoyINd
         PKF8LGOhVDvv1gex77zbReC+fZscx3khpfH1zZQEWVr92OlvtHjxzWvf3bYPGjLZE5rY
         ASIA==
X-Gm-Message-State: APjAAAXgY0CtI/6kdmUSPunMuT95ksjZHp+34YNwuDr/EYte1OidHuJA
        fKlH5wBE9s3OtmslNSeivbJYJzhNSt+5LpkVV+cDow==
X-Google-Smtp-Source: APXvYqwLZb/ME4zrVxF6lxBEvoSyJfBdg+7QPeUl990G3Qs2vdNuL/EBUo+uiDuS9u57oCFZKxBV641QCIayNm/fiJ0=
X-Received: by 2002:a5d:9f11:: with SMTP id q17mr20213351iot.212.1559160448108;
 Wed, 29 May 2019 13:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-12-amir73il@gmail.com>
 <CAOQ4uxiAa5jCCqkRbq7cn8Mmnb0rX7piMOfy9W4qk7g=7ziJnA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiAa5jCCqkRbq7cn8Mmnb0rX7piMOfy9W4qk7g=7ziJnA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 29 May 2019 22:07:17 +0200
Message-ID: <CAJfpegsft_1TZ-OjaAdmGE--a8+deCQwFjbcAYJsEdbp2YWQSw@mail.gmail.com>
Subject: Re: [PATCH v3 11/13] fuse: copy_file_range needs to strip setuid bits
 and update timestamps
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        ceph-devel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 29, 2019 at 9:38 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Hi Miklos,
>
> Could we get an ACK on this patch.
> It is a prerequisite for merging the cross-device copy_file_range work.
>
> It depends on a new helper introduced here:
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxjbcSWX1hUcuXbn8hFH3QYB+5bAC9Z1yCwJdR=T-GGtCg@mail.gmail.com/T/#m1569878c41f39fac3aadb3832a30659c323b582a

That likely is actually an unlikely.

Otherwise ACK.

Thanks,
Miklos
