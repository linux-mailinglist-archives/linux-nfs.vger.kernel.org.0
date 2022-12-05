Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E30642F74
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Dec 2022 18:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiLERuE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Dec 2022 12:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiLERtk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Dec 2022 12:49:40 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7814222B3B
        for <linux-nfs@vger.kernel.org>; Mon,  5 Dec 2022 09:47:26 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso7725225otb.2
        for <linux-nfs@vger.kernel.org>; Mon, 05 Dec 2022 09:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HmuN6v5cnjW/dwA0zMejYjif/CkFf5NU0/yqi7wH+Zk=;
        b=IVf8hp+wLMDjRrME0EjOFqs0hZ9WdxiL5VCMivZLpcYhrpKnyPM4oYJesOHtljoZOF
         vombcVF6V7hbwEn+VXXMlvTXZ5tMf8TzFoP4aVlh6c87s/c5AL67evdWT0o+TZ2vbWM3
         CqCYUxcremS8Mp5ccRVdGqtqn/kc8XIMeHqufsQIygZZMQKs+87Ait3uGcRqlsgFCeo1
         xu/9M5hA821fxtlZRgcgcieovTCbnUrTfXcoJsKwRXVRSDs6dZPXHF786T8lVjoYcxNg
         VsjZvH4K9coCZjMXvdU9Mmx3J0hmqEpTKsG12MCspt4ZviaKy8pf/z+1BHpWoFBjOEmh
         WM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmuN6v5cnjW/dwA0zMejYjif/CkFf5NU0/yqi7wH+Zk=;
        b=s1pRSNCF92LeorDCSWHbahtBVQoxwn2FxHuw7tS/NjMe+CNeH9jurm3eXNCQOelsTw
         kHdmtDLhxJZtVeaG3MKSBxYPMxhVCI7BK9munDrTC4Ff2FVATk7jRcz8IwYEBx6wYRM2
         fccjw5m1GzdiFhS/8wISA0NqpGJaVRYJ6uW3US1LHD+A/rTB3UL8aQ+uxIZ6Wq6gxIBo
         wdL1Wq27Lz+eSFqIOrnYvLdB9/vlPxTEXnjlWzILwzMJY17doyDpWRvEvx9jkV8Yz41p
         7YWSeeEhZyhUzxOjTOLuOKutTGoo+0QPdSjtqqbLKai/XUks2oMSX8EsoT1a7DZnXDPo
         4VIQ==
X-Gm-Message-State: ANoB5plJp2fFXIjxH7m+fC+uDkoLBv/7Eoh4l6sBRIzuyzfh8axahHyq
        r53kMdq51qJuafLl6rI8hemed8baSND+32v3bQ8=
X-Google-Smtp-Source: AA0mqf69YV/2De5D6RRSxQbw0cJiENCcxKGDtR66RSrcFEGfRRtspXOAJT5xYOa4jogN5ST+RZwH1hWfw2hyXX+Pajg=
X-Received: by 2002:a9d:65c3:0:b0:66c:e311:e6c with SMTP id
 z3-20020a9d65c3000000b0066ce3110e6cmr32143671oth.96.1670262445710; Mon, 05
 Dec 2022 09:47:25 -0800 (PST)
MIME-Version: 1.0
References: <CAG4AFWYGYtYOoi8BuFos__GSNrLVXBwcaDpVR0D6fRv3ibPkmA@mail.gmail.com>
 <60C55655-4A83-4B93-AEEB-89C69EBEE472@redhat.com>
In-Reply-To: <60C55655-4A83-4B93-AEEB-89C69EBEE472@redhat.com>
From:   Jidong Xiao <jidong.xiao@gmail.com>
Date:   Mon, 5 Dec 2022 10:47:14 -0700
Message-ID: <CAG4AFWaVZdDV=NkC-xcmP+kc2AhYHg26VOUKa8nKy03ptPiqgg@mail.gmail.com>
Subject: Re: Is Linux NFS block size 512 bytes or is this a bug?
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 5, 2022 at 10:38 AM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 5 Dec 2022, at 0:44, Jidong Xiao wrote:
>
> > Hi,
> >
> > I saw this line in fs/nfsd/nfs3xdr.c:
> >
> > /* used */
> > p = xdr_encode_hyper(p, ((u64)stat->blocks) << 9);
> >
> > It seems we are left-shifting the blocks 9 bits, to get the number of
> > bytes used. Is this a bug or we know the block size is always 512
> > bytes?
>
> By calling vfs_getattr(), which needs to behave for stat(2) syscall as
> returning the number of 512 byte blocks.  I think we're stuck with the
> traditional idea that blocks are always 512 bytes in linux, at least from
> the perspective of stat().
>
> The history of such is beyond my time, but I don't think this is a bug.
>
> Ben
>

I see. Thank you!

-Jidong
