Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAE145D1D
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 21:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgAVU1x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 15:27:53 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38417 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgAVU1x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 15:27:53 -0500
Received: by mail-vk1-f194.google.com with SMTP id d17so324603vke.5
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2020 12:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTgKz3Kzmekn9WvT22VUjbRSY6TIq5egaZrumexuFXM=;
        b=bj3fX+WpTdcqcaFsuddBKEwPYWXucCAwfaDDodzpztWlA55BfnPtNVg6A8wKMI+rKv
         hDXAN/U5b6suW00Dflg2gtPbjGYcCoQSs96xPOIvaKVT++0lzKsrtcF4iZoXMCY2lIGX
         BwoQiCcCpQIPZ0N38cajtQP8lxZ4wCDdYN+M27axcr16U2bj9zhcDOPeZ3KEyhmTvosW
         LwYRHspyZ7YYhC096tNJ3xi6nl7AIGf6AylxK7Nex3pEJftjD7D/34IxrhI1oAcwKMt0
         uHpptWyZwN3NNJubbkqWcX34WxIWEyCEtrwJyUGkbtLr5tuXPjGoi80KLuOc0znDjFNm
         8geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTgKz3Kzmekn9WvT22VUjbRSY6TIq5egaZrumexuFXM=;
        b=nP2+Q2QxFgoS8yjoMPzr7c7cfdfWajrrF3GXrxuIfx3t1pbjcbj6h9sOfCYxJwPMsd
         KdCgbP/HE6KwRXZcq3iWb0dKU3Uwr/nMLWww+Temfk29agAKWNRd9PiD/tg0zEFsl7y7
         4kBpKHMnrtDuF0aKBWeprjiV0Aa+yySswG8sWM8XyDytSj+OUfFOkVQYAgClnnDSXNTZ
         ocU/MUtEgSozQEt2Li8nF1gVv6ayknuy3nVLPDwxatUPnOOL86NJYfsJKM3S/owz039A
         DsOZY0ANBBdUQExoYgEBLTvC7NiAXVet0cNKWxeyHM2QOEy3ZRG8F3rsGFVBQPocBeOC
         CREg==
X-Gm-Message-State: APjAAAXO+vCqwHw5/IjpYOjv2xCR6oNFXuLKZXpHto1q9HWGekXXMiWR
        zCM3nnbmZXVgIS2YgMyBuSCDNDmuzUgj8A1QlMBuww==
X-Google-Smtp-Source: APXvYqyCO++SbkxppBuREBi2kLLc18idDq+TMoF2eWvZtXcmO8k5UFaSa+54fH+L2Y4nY/m+nfJRYTp++SWqezV3MgI=
X-Received: by 2002:ac5:cb0b:: with SMTP id r11mr7908292vkl.72.1579724871720;
 Wed, 22 Jan 2020 12:27:51 -0800 (PST)
MIME-Version: 1.0
References: <20200121221441.29521-1-olga.kornievskaia@gmail.com> <a4b08f6ae6cd6edd62a0d26448d6082c35dd5049.camel@netapp.com>
In-Reply-To: <a4b08f6ae6cd6edd62a0d26448d6082c35dd5049.camel@netapp.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 22 Jan 2020 15:27:40 -0500
Message-ID: <CAN-5tyH1KXWGRfgmAibVJ0kFpHX3FZpGDdhYBFVS7EBAXLu99w@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2 re-initialize cn_resp in case of a retry
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 22, 2020 at 1:40 PM Schumaker, Anna
<Anna.Schumaker@netapp.com> wrote:
>
> Hi Olga,
>
> On Tue, 2020-01-21 at 17:14 -0500, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > If nfs42_proc_copy returned a EAGAIN, we need to re-initialize the
> > memory in case memory allocation fails.
>
> I guess I'm not sure how we would hit this. Doesn't kzalloc() return NULL if the
> memory allocation fails?

You are right kzalloc would always return NULL so forget about this patch.

>
> >
> > Fixes: 66588abe2 ("NFSv4.2 fix kfree in __nfs42_copy_file_range")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfs/nfs4file.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> > index 620de90..9f72efe 100644
> > --- a/fs/nfs/nfs4file.c
> > +++ b/fs/nfs/nfs4file.c
> > @@ -177,8 +177,10 @@ static ssize_t __nfs4_copy_file_range(struct file
> > *file_in, loff_t pos_in,
> >       ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count,
> >                               nss, cnrs, sync);
> >  out:
> > -     if (!nfs42_files_from_same_server(file_in, file_out))
> > +     if (!nfs42_files_from_same_server(file_in, file_out)) {
> >               kfree(cn_resp);
> > +             cn_resp = NULL;
> > +     }
> >       if (ret == -EAGAIN)
> >               goto retry;
> >       return ret;
