Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF35380E57
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhENQna (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 12:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230431AbhENQna (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 12:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621010537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QCR/+DSFIFRfVgVp2YWZ3WevYpbkD77oMAXGoXvRyf4=;
        b=TRQnUCtHD8BdLCG5p/UPEDUAxwldCUL9Muh7Q6avX/SOgAe4aJ0fxYO/tilIzfg0sRq4Wp
        6JUVda9GGIAz8nT9xHuTmKupozxYkiKTAQ23VHzPif3UT01lk3rtvNaIbhsyy6BfIJGhTB
        Mif55oaOmTuYRVjKdymuZUii7kkY4IY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-fO6wu5A5NjqUQcgyPDMGKA-1; Fri, 14 May 2021 12:42:16 -0400
X-MC-Unique: fO6wu5A5NjqUQcgyPDMGKA-1
Received: by mail-yb1-f199.google.com with SMTP id g1-20020a25b1010000b02904f93e3a9c89so13917665ybj.23
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 09:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCR/+DSFIFRfVgVp2YWZ3WevYpbkD77oMAXGoXvRyf4=;
        b=a8ZM77JoOqBoo5FZOMe8Ulwy+eo23/Y9iCN+1E+Z+ssq5Rfq4unTOWOwJF1fF0Pwyi
         9OxAV58iQH2hyeun8U6QmLmDBB5K8FKSZcXRuNAC9gLzeEk+z7lDa41r3d1ckgPr9kOV
         KfXCFjTdzuCnzKG9zo39kkfWH7i7dOFzm+nbbvffhX1rFslNHIxxe7K6UoCqFWyyAUM+
         veqyWkJUQyd/t4ejmu0GYG2UAcDsQGKzvayog3I6wennJIH3akvErB/BtNkEHKDWXtRT
         gp4aae+S+o1/J/c+8tYwDcEgSLQljrTxO8QTgdLvHNkagcG8e+VYK/z8HIShur1ln2Og
         lPgQ==
X-Gm-Message-State: AOAM532fkjMkJaPTxDjaxxEsAIHKbNIYpzmWjmm4NYsur2Q+UR21jLIP
        Ih7zppdYhIAGc+z9geJlHEfbGqGBwa6gRAalgJMKEJu0Dh+2uRuodB/mh+5WZ3bkijG55PnIxM2
        awHCYzXsC1Vg0+ubl90oTqca1ezTLlGhvlaDy
X-Received: by 2002:a25:570b:: with SMTP id l11mr66021968ybb.335.1621010535848;
        Fri, 14 May 2021 09:42:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1hupI0uLxBkdAlJzbPOeS4GBJUd8OT/MSQpd8Y7ilI4ahl/Hn4cCWVhMuI5bS4Zstq4/40AOOM4x0B4Gysbs=
X-Received: by 2002:a25:570b:: with SMTP id l11mr66021957ybb.335.1621010535707;
 Fri, 14 May 2021 09:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <1620999041-9341-1-git-send-email-dwysocha@redhat.com> <20210514141512.GA9256@fieldses.org>
In-Reply-To: <20210514141512.GA9256@fieldses.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 14 May 2021 12:41:39 -0400
Message-ID: <CALF+zO=Umknvd8DoWJJ+NT1PT1ij9zTMD8OnFXNNgRkch978FQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Add callback address and state to nfsd client info
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 14, 2021 at 10:15 AM Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, May 14, 2021 at 09:30:40AM -0400, Dave Wysochanski wrote:
> > For troubleshooting, it is useful to show the callback address and state,
> > even though we do have this equivalent info inside Chuck's ftrace patches.
>
> Good idea.
>
> > Note there is a show_cb_state() inside fs/nfsd/trace.h and this code
> > has a similar function.  It may be better to consolidate these two
> > if these additions are ok for nfsd client info, but not sure where
> > a good header is to place it - do we need a new file, maybe
> > fs/nfsd/nfs4callback.h?
>
> nfs4state.c already includes trace.h, do we need anything more?
>

Probably not.  I am testing a renamed function (I find that
"<typename>2str" is more common in the kernel) "cb_state2str"
defined in fs/nfsd/trace.c and declaration in fs/nfsd/trace.h

If that makes sense I'll send a v2.




> I'll admit I've just been adding things wherever seems expedient for a
> while, so there may be some more logical way to organize nfsd headers.
>
> --b.
>
> >
> > Dave Wysochanski (1):
> >   nfsd4: Expose the callback address and state of each NFS4 client
> >
> >  fs/nfsd/nfs4state.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > --
> > 1.8.3.1
>

