Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1522C2D47F5
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 18:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgLIRaC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 12:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbgLIR35 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Dec 2020 12:29:57 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D34C0613CF
        for <linux-nfs@vger.kernel.org>; Wed,  9 Dec 2020 09:29:17 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id p22so2425388edu.11
        for <linux-nfs@vger.kernel.org>; Wed, 09 Dec 2020 09:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qo96z2PMGjvF8djCYm7m/8j6pBWfq/xwiy//wfFcxrQ=;
        b=V4lXtJK/HIZnup9oOfL0tB7AqN38hpEETOYgjz+ggbkZV4hPpbb7FNRYwY2RqEIYpQ
         RkOxcGfvkMidJ2JwFsUzH5DZeA+xJTkqFXPSC44lSryYa7xfhjkrQW5QDImbrxdbLyEq
         K1VIgyXVRAWp+FvUPjYb+OAoFgashW1hjgosratxk6ZykX0Lbz80D+w5IPX9BPd4tBuH
         Yin8xZJyt+ZCKq90wr0psdbbMIvE8rOxV/cTfses+R7P1/YtnMYlqnKT0klY3CN+Wzaw
         LU5wb8Jsp8T4B9CFdIc3fqOFlJkUAbor6jx6D688JgHNRXF2G5XULuwO89L5afmLy3k7
         LqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qo96z2PMGjvF8djCYm7m/8j6pBWfq/xwiy//wfFcxrQ=;
        b=Bd+rIqGY6M9GVDKzwXyl48+Wpn6eJbHodJvIOmgDkdwcNEFX2QljZqLbiG6Mw8LR+9
         IQPErmGEGXpJfr0duRf7qWfwCybXJR7lOh+PvZUw4l41vEp9As94f3mOFmAtHSHRpKyO
         4tOmHyPp8wCOjzwIrM1lzTU454lQw+nxnXgDDv9iWeX6yVSIBoUpqXhQF8UFPovDurHn
         m/on9MZAYDimXE+m5P1yCdrZ4lrDcWPWdvNqqQ0uERNdWVMHR8aIlruZhDKsA43bRCkn
         Ds+NDikbpj2NXwyrmvdivIhGjHQwNpvO8ziXfg38aEX1SGBFmqJRX6EMlgZWVZuglMbg
         2S5g==
X-Gm-Message-State: AOAM531dyFH1c/yo3WYNL6zWb6nApj8nW2CRDzmt84iBlw3LNACC3qnh
        qSvFufS97+ilTY5gbKqmrgMgyIQM4ZWHnIWtY8I=
X-Google-Smtp-Source: ABdhPJyDBxCQEb0s7esifzapV4E8/O4F0/zFDLRlTiKT+2LQ4RphyuVLN4Th8FVXmOERh+5bKLWsVIFAI1uxDrwT9+g=
X-Received: by 2002:aa7:c856:: with SMTP id g22mr2975776edt.85.1607534956174;
 Wed, 09 Dec 2020 09:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
 <852166252.2305208.1607096860375.JavaMail.zimbra@desy.de> <CAN-5tyFJeLRyDUdtGkheGkmDE=i-FJprLFiav_mEPA35QeKLQA@mail.gmail.com>
 <14eac8ec352c76206c811f75b130957bb75ff590.camel@hammerspace.com>
 <CAN-5tyFwgWTBsCOBJ=7ELS4md4SBgiMQ4EPAS7LCxzCK74X13g@mail.gmail.com>
 <a70034b9506c650aa10480727f9f5e00cc71e25a.camel@hammerspace.com> <CAN-5tyFUmQQeQQjHtmetvTN2rcJpf3KwPbhm+6TB_N33auirag@mail.gmail.com>
In-Reply-To: <CAN-5tyFUmQQeQQjHtmetvTN2rcJpf3KwPbhm+6TB_N33auirag@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 9 Dec 2020 12:28:59 -0500
Message-ID: <CAFX2JfnMpEfqZFUYWQD9rV0VCvyYAejNWbNMUvW44fvhBeGhBw@mail.gmail.com>
Subject: Re: [PATCH 0/3] NFS: Disable READ_PLUS by default
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 9, 2020 at 12:22 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Wed, Dec 9, 2020 at 12:12 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Wed, 2020-12-09 at 12:07 -0500, Olga Kornievskaia wrote:
> > > On Wed, Dec 9, 2020 at 11:59 AM Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > >
> > > > On Fri, 2020-12-04 at 15:00 -0500, Olga Kornievskaia wrote:
> > > > > I object to putting the disable patch in, I think we need to fix
> > > > > the
> > > > > problem.
> > > >
> > > > I can't see the problem is fixable in 5.10. There are way too many
> > > > changes required, and we're in the middle of the week of the last -
> > > > rc
> > > > for 5.10. Furthermore, there are no regressions introduced by just
> > > > disabling the functionality, because READ_PLUS has only just been
> > > > merged in this release cycle.
> > > >
> > > > I therefore strongly suggest we just send [PATCH 1/3] NFS: Disable
> > > > READ_PLUS by default and then fix the rest in 5.11.
> > >
> > > Sure, but shouldn't there be more ifdefs inside of the xdr code to
> > > turn it off completely?
> >
> > AFAICT, those functions are not called by anything else, so as long as
> > the READ_PLUS client functionality is disabled, they should be
> > harmless.
>
> Is it benign that in the normal read path sunrpc will be calling a new
> function of xdr_realign_pages()? Non readplus code didn't have it.

It should be. All I did was pull out some code from xdr_align_pages()
and put it into a new function. `git show --diff-algorithm=histogram`
says this is what I did:

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 909920fab93b..d93bcad5ba9f 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -997,10 +997,25 @@ __be32 * xdr_inline_decode(struct xdr_stream
*xdr, size_t nbytes)
 }
 EXPORT_SYMBOL_GPL(xdr_inline_decode);

+static void xdr_realign_pages(struct xdr_stream *xdr)
+{
+       struct xdr_buf *buf = xdr->buf;
+       struct kvec *iov = buf->head;
+       unsigned int cur = xdr_stream_pos(xdr);
+       unsigned int copied, offset;
+
+       /* Realign pages to current pointer position */
+       if (iov->iov_len > cur) {
+               offset = iov->iov_len - cur;
+               copied = xdr_shrink_bufhead(buf, offset);
+               trace_rpc_xdr_alignment(xdr, offset, copied);
+               xdr->nwords = XDR_QUADLEN(buf->len - cur);
+       }
+}
+
 static unsigned int xdr_align_pages(struct xdr_stream *xdr, unsigned int len)
 {
        struct xdr_buf *buf = xdr->buf;
-       struct kvec *iov;
        unsigned int nwords = XDR_QUADLEN(len);
        unsigned int cur = xdr_stream_pos(xdr);
        unsigned int copied, offset;
@@ -1008,15 +1023,7 @@ static unsigned int xdr_align_pages(struct
xdr_stream *xdr, unsigned int len)
        if (xdr->nwords == 0)
                return 0;

-       /* Realign pages to current pointer position */
-       iov = buf->head;
-       if (iov->iov_len > cur) {
-               offset = iov->iov_len - cur;
-               copied = xdr_shrink_bufhead(buf, offset);
-               trace_rpc_xdr_alignment(xdr, offset, copied);
-               xdr->nwords = XDR_QUADLEN(buf->len - cur);
-       }
-
+       xdr_realign_pages(xdr);
        if (nwords > xdr->nwords) {
                nwords = xdr->nwords;
                len = nwords << 2;


>
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
