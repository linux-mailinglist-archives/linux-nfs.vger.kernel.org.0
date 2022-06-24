Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DA955A0C0
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jun 2022 20:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiFXSNH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jun 2022 14:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiFXSNG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jun 2022 14:13:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697EDF0A
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jun 2022 11:13:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDB08B82AD3
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jun 2022 18:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDBBC341C8
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jun 2022 18:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656094381;
        bh=VDCLIixVWOxc9MXXcbbzy7aCIXLOouCxo8AcTHoJ9OY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jExaLb7NchuRc5fI146r5yFGdjBTJQ8VM6UMqZ9eDrhi3zQQ6ClA+GIfbDCSoAHBZ
         JzIjroM8vbEDDBn5txxsgg50E8YUlDPavBMQ8lleR+AyDE6aoZjTSnuVY7dqwBbp+J
         Kb8JsTHHbEQn1OTfJlmd1KUIYA7Fb0oLxhO6G56blr/9pRcVK9fqaH5PqbW1s9J+HH
         /nLEu0bJKhOZaHEXoWh1Q0+juom3wMoxX1hxlH5JuGjF6WyxngN3FjNsBgHCk1riZ/
         xfUqe+VDxbOfWuZ/KpTR6ZYeUt5YpNg3QR4ICqGPYw+JGWdcYfq4Rgp8x5U4yud6yN
         GWsYSPX+3kw7Q==
Received: by mail-wm1-f47.google.com with SMTP id p6-20020a05600c1d8600b003a035657950so1955633wms.4
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jun 2022 11:13:01 -0700 (PDT)
X-Gm-Message-State: AJIora9qfdgde+FJ+Y/FRvn5UT4bqVP1CtKV8OyR9zj52oCVO9H/+ass
        lXfxHILD9tJbros7oYNyti/Lxf83gdzDC5f93pc=
X-Google-Smtp-Source: AGRyM1uoLn3MNhCUvG1Hplt2k2eX8yi/CXlc+CrEdXBaO3cOLG8RZDpMTw47eAuvcq65bO73Pm1UgndspFQC1zfTAfo=
X-Received: by 2002:a05:600c:2197:b0:39c:5e32:be2c with SMTP id
 e23-20020a05600c219700b0039c5e32be2cmr5421002wme.41.1656094380188; Fri, 24
 Jun 2022 11:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220624154737.1387850-1-anna@kernel.org> <B809231A-ACDE-4D97-B866-F969B08AA7EC@oracle.com>
In-Reply-To: <B809231A-ACDE-4D97-B866-F969B08AA7EC@oracle.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Fri, 24 Jun 2022 14:12:44 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfn5D5RDFPqRfvJZfCgV9bZ=3qfUKNpPzyow5xHBUrxo+w@mail.gmail.com>
Message-ID: <CAFX2Jfn5D5RDFPqRfvJZfCgV9bZ=3qfUKNpPzyow5xHBUrxo+w@mail.gmail.com>
Subject: Re: [PATCH] NFSD: Don't continue encoding if READ_PLUS gets confused
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jun 24, 2022 at 1:40 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Hi Anna!
>
> > On Jun 24, 2022, at 11:47 AM, Anna Schumaker <anna@kernel.org> wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > If we were in a HOLE segement, but vfs_llseek() claimed we were encoding
> > DATA then we would switch over to the DATA encoding function. This
> > conflicts with Chuck's latest xdr cleanup patches and can result in a
> > crash or silent hang. Let's just return nfserr_io if we find we are in
> > this situation, which will cause the encoder to return to the client
> > with the number of segments already encoded. The client can then try the
> > READ_PLUS call again.
> >
> > Fxes: 6c254bf3b637 (SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer())
>
> checkpatch complains about this tag.

Okay. I'll look into that.

>
> Also, Bruce said he wasn't able to reproduce the issue on
> 6c254bf3b637, only on the whole series. Were you able to hit
> it with just this commit applied?

I've been having trouble hitting it in general. I think I only got an
oops once, but most of the time it just silently hangs. I'll try a bit
longer to see if I can hit it again.

>
>
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> I find this somewhat problematic. I can't apply this patch in
> good conscience:
>
> * The usual guideline for applying a workaround upstream is
>   that there's been a demonstration that it will be impossible
>   to find and fix the real problem. I don't see that here.
>
> * We still don't understand the failure. The XDR code itself
>   might be broken? Therefore we don't understand if this
>   workaround is 100% effective
>
> * Usually with a workaround, there's a hint of a long-term
>   fix... is this the long-term fix?

No, the long term fix is my new READ_PLUS code. I'm hoping to have a
v2 ready soon, but I tested v1 and didn't have any problem (no oops or
silent hang)

>
> In other words, I might give this patch to a customer who
> needed to get back on her feet quickly. I'm hesitant to take
> it as an upstream change without further justification.
>
> IMHO a fix in an XDR consumer (like READ_PLUS) needs to
> demonstrate that the current XDR code is working as designed.
> Otherwise, the XDR code itself is what needs to be fixed.
>
>
> > ---
> > fs/nfsd/nfs4xdr.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 61b2aae81abb..dc97d7c7e595 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4792,7 +4792,7 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
> >       if (data_pos == -ENXIO)
> >               data_pos = f_size;
> >       else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
> > -             return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
> > +             return nfserr_io;
> >       count = data_pos - read->rd_offset;
> >
> >       /* Content type, offset, byte count */
> > --
> > 2.36.1
> >
>
> --
> Chuck Lever
>
>
>
