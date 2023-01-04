Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29B665D6CF
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 16:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjADPEJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 10:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbjADPDv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 10:03:51 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C33126
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 07:03:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b2so36115444pld.7
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jan 2023 07:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nfo4LMICYo7VE27iJTdU/qWYe+gy7FEaB05CsUm+884=;
        b=WVv+7KUioL8Ud4s1SgmVM7AyB2CW6B/dBWWdJEQqHUDJdwe75UAR+wfnsJNl3+FGdN
         jwKxfF9xMXNWVcFZAe9S2b6dzXy3qTgqS68XM1suo8Zrq3KqOlrtbbUdpjv7f9NUJ0mx
         AsAlVXUksoHcNFcXKK4a5neR5+ViT2F/UDtIYVC1+fa7TFSzXpQNF4myFtBvm6pxXtED
         o3l0wgo+VOHWTo3a3ZLn1rncXro5IZrWvfAJOF2Cg7OHBpmzKOO44H3DseFkBxIa+UpC
         aLNDlis7oMwS6e+4oPGHH9gwnQbdIQyjflcbUzxSjQGuSl7LZEbZZNYTPfYHW7ovayWX
         oxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfo4LMICYo7VE27iJTdU/qWYe+gy7FEaB05CsUm+884=;
        b=iDfjomiEBMbVMZqislvkdg+dB8tUvLQBCwljIJsjkzPXfehjQGK46Uj2K6DHqam9rp
         fuwRk8x7UVxppd3ooTCS02p1RqSvqCp8R+v1ylCT2Atn5HkV0sSqcfeI1Y9Ch+ucWsFH
         7N/GFwKo73yV1gKvpjcdiu7gJBI3meqenVZQoUcdYXepNjBDrgD9KRTDEZlompyabiEN
         VVRzVx9GGCCoQQEkVU4AZEXOAI1APGEAdAGwqzLUsCJXoaLVw1rugCWH4sNEf2m/iydC
         sukCmZemDBDhPc9uCwRP7LCBlT5Tx8EACNANthGrvJkQTQwmnMJzEubstk9SwL8zIFXi
         m/UQ==
X-Gm-Message-State: AFqh2kr6O8eM3ZCI5N0+MKrdQ5/38rcjj3+3zeDROJPuGU79jaypBNWW
        tihQa6IRScBFP8tz2/wp04lpUyiwmkUKVg0XCOU=
X-Google-Smtp-Source: AMrXdXsEZ2BT4MMJTU/gsXyy6zJ9FHsK+ckzw6XeyjQmicgxGTcHMN4shAIru80rbgloCuEr/Jp2hrqONBCMmGmo9Sw=
X-Received: by 2002:a17:90a:ab89:b0:213:9df5:43b2 with SMTP id
 n9-20020a17090aab8900b002139df543b2mr3681251pjq.86.1672844629689; Wed, 04 Jan
 2023 07:03:49 -0800 (PST)
MIME-Version: 1.0
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>
 <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
 <CAN-5tyEBce3ZcXt9fxN9qPStRSSb=H-3v2ZFUovJRCs3CZXgXw@mail.gmail.com>
 <167279876729.13974.1765446738043285170@noble.neil.brown.name> <167279964139.13974.11763637507027085853@noble.neil.brown.name>
In-Reply-To: <167279964139.13974.11763637507027085853@noble.neil.brown.name>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 4 Jan 2023 10:03:38 -0500
Message-ID: <CAN-5tyH72SBP=9LQFzxUOQKVzbaiPgSOV4efTCMPYywbCwrGYw@mail.gmail.com>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 3, 2023 at 9:34 PM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 04 Jan 2023, NeilBrown wrote:
> > On Wed, 04 Jan 2023, Olga Kornievskaia wrote:
> > > On Tue, Jan 3, 2023 at 7:46 PM Trond Myklebust <trondmy@kernel.org> wrote:
> > > >
> > > >
> > > > If the server starts to reply NFS4ERR_STALE to GETATTR requests, why do
> > > > we care about stateid values?
> > >
> > > It is acceptable for the server to return ESTALE to the GETATTR after
> > > the processing the open (due to a REMOVE that comes in) and that open
> > > generating a valid stateid which client should care about when there
> > > are pre-existing opens. The server will keep the state of an existing
> > > opens valid even if the file is removed. Which is what's happening,
> > > the previous open is being used for IO but the stateid is updated on
> > > the server but not on the client.
> >
> > I agree that it is acceptable to return ESTALE to the GETATTR, but
> > having done that I don't think it is acceptable for a PUTFH of the same
> > filehandle to succeed.  Certainly any attempt to again use the
> > filehandle after the PUTFH should fail with NFS4ERR_STALE.
> >
> > RFC7530 says
> >
> > 13.1.2.7.  NFS4ERR_STALE (Error Code 70)
> >
> >    The current or saved filehandle value designating an argument to the
> >    current operation is invalid.  The file system object referred to by
> >    that filehandle no longer exists, or access to it has been revoked.
> >
> > So the file doesn't exist or access has been revoked.  So any writes
> > should fail.  Failing with OLD_STATEID is weird - and having writes
> > succeed if we use the correct stateid is also odd.  Failing with STALE
> > would be perfectly sensible and I suspect the Linux client would handle
> > that just fine.
>
> I checked a recent tcpdump (with patched SLE kernel talking to Netapp)
> and I see that the writes don't succeed after the first NFS4ERR_STALE.
>
> If the "correct" stateid is given to WRITE, it returns NFS4ERR_STALE.
> If the older stateid is given to WRITE, it returns NFS4ERR_OLD_STATEID.
>
> So it seems that it just has these two checks in the wrong order.

Does Netapp return ERR_STALE on the PUTFH if the stateid is correct?
If it's the WRITE operation that returns an error and if the server
has multiple errors (ie bad statid and bad file handle)` then I don't
think the spec says which error is more important. In this case, I
think the server should fail PUTFH with ERR_STALE.

>
> NeilBrown
