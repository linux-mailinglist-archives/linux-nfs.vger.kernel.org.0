Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D154905D1
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jan 2022 11:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbiAQKT7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 05:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiAQKT6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 05:19:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD72C06161C
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jan 2022 02:19:57 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b13so63666054edn.0
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jan 2022 02:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/B8S0T6l/cNTFCwbllAbkeryrIurv7WGfpD2SElg7M=;
        b=dv+17V5MOPEzuLfM1Cm4a6q4iFsZiMxvmb+0viRdfYd80RUx9gSegypMRnWQrTQsgq
         ELfJeQS4rdN44RZDM7QPPQ+LhOWupRIi2hAcGelXeM8j3ZRa1Ovn58l4OFMKbb0SCu+G
         sDzPWHuK7OWM2HO8kcdaLHy+dfHG+z9C+iDOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/B8S0T6l/cNTFCwbllAbkeryrIurv7WGfpD2SElg7M=;
        b=WMPut2bq294Aw0YHaZjIkymY2LIuo5R4ySFnL886uLoooyOm6/MGYZJwtNrMxGTcoe
         hXkbr66bAchAv34q0MwUoyUoHAkgGL9XQYxmGVwSwtZ3BigtVDE/k4+DpipcP6vYE0FS
         JsftEnNxQYGje5UMl9kdCY1ZKpffWSIVbflHJg1Xk9FhxrXYuQQoUx9J29jLE+a3ixit
         6hNReMRp8cLKmwUwZf+b+P9FwIIUs2nVDzWPaMGgIi1jL4LeOA/uk6juXpV3ASzPZJuO
         1UNc9DauucVgJxfcxJzOb9PnRWsiR5YmQd1VQEc5zMUTFf6cDiVDM0R0rWTicgoYoye8
         dChg==
X-Gm-Message-State: AOAM531BVBhkLnRG+VFB0rF59R05sEng436fPp2O2BR0FmvsQ6h7Fl4e
        uBZnGVC682awVN3nPJ+wR2UilEfcqEiXQMAX
X-Google-Smtp-Source: ABdhPJx4nNwPnEtTzWH1k4bO3kevoDVSTQi/UCFMIKNYE6U2HSYtxYdYDPqXRbgk1L93beT6zXos9g==
X-Received: by 2002:a17:907:7247:: with SMTP id ds7mr16978711ejc.401.1642414796252;
        Mon, 17 Jan 2022 02:19:56 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id w22sm2511849eji.87.2022.01.17.02.19.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 02:19:56 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so7650069wmb.1
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jan 2022 02:19:56 -0800 (PST)
X-Received: by 2002:a05:600c:3482:: with SMTP id a2mr3476469wmq.152.1642414785683;
 Mon, 17 Jan 2022 02:19:45 -0800 (PST)
MIME-Version: 1.0
References: <2752208.1642413437@warthog.procyon.org.uk>
In-Reply-To: <2752208.1642413437@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jan 2022 12:19:29 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjQG5HnwQD98z8de1EvRzDnebZxh=gQUVTKCn0DOp7PQw@mail.gmail.com>
Message-ID: <CAHk-=wjQG5HnwQD98z8de1EvRzDnebZxh=gQUVTKCn0DOp7PQw@mail.gmail.com>
Subject: Re: Out of order read() completion and buffer filling beyond returned amount
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        Matthew Wilcox <willy@infradead.org>,
        Omar Sandoval <osandov@osandov.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Peter Zijlstra <peterz@infradead.org>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 17, 2022 at 11:57 AM David Howells <dhowells@redhat.com> wrote:
>
> Do you have an opinion on whether it's permissible for a filesystem to write
> into the read() buffer beyond the amount it claims to return, though still
> within the specified size of the buffer?

I'm pretty sure that would seriously violate POSIX in the general
case, and maybe even break some programs that do fancy buffer
management (ie I could imagine some circular buffer thing that expects
any "unwritten" ('unread'?) parts to stay with the old contents)

That said, that's for generic 'read()' cases for things like tty's or
pipes etc that can return partial reads in the first place.

If it's a regular file, then any partial read *already* violates
POSIX, and nobody sane would do any such buffer management because
it's supposed to be a 'can't happen' thing.

And since you mention DIO, that's doubly true, and is already outside
basic POSIX, and has already violated things like "all or nothing"
rules for visibility of writes-vs-reads (which admittedly most Linux
filesystems have violated even outside of DIO, since the strictest
reading of the rules are incredibly nasty anyway). But filesystems
like XFS which took some of the strict rules more seriously already
ignored them for DIO, afaik.

So I suspect you're fine. Buffered reads might care more, but even
there the whole "you can't really validly have partial reads anyway"
thing is a bigger violation to begin with.

With DIO, I suspect nobody cares about _those_ kinds of semantic
details. People who use DIO tend to care primarily about performance -
it's why they use it, after all - and are probably more than happy to
be lax about other rules.

But maybe somebody would prefer to have a mount option to specify just
how out-of-spec things can be (ie like the traditional old nfs 'intr'
thing). If only for testing, and for 'in case some odd app breaks'

                Linus
