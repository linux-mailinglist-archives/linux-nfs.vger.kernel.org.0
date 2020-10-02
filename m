Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E153281C1D
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 21:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgJBTh3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 15:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgJBTh3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 15:37:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D77C0613D0
        for <linux-nfs@vger.kernel.org>; Fri,  2 Oct 2020 12:37:28 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u8so3504038ejg.1
        for <linux-nfs@vger.kernel.org>; Fri, 02 Oct 2020 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwpPls27wrQO1UfCcmnU9Wea99yS3enxM5WDyvaYlAI=;
        b=lHa6xq3KIP25AUxd/X4lY7JrEdjmIZ8Xjodn3fHle3i3+HSPnPT7ouM47TtdudGMYp
         AENrWjlOA4u6lQf/7b0wG4Gy7tDEv3FBw1MEDBve1guJ52Kg8h20FgUAv6mhE07EEjzF
         J+spA6c4wqkSLQtimHS+xe3Rjq70mRTIQFs8l9wxjlpTQ5+Z9Ppf7U1tnmlZJxmOeV5h
         CqRhT54MjFBNGmwXTNjOxQWJ9y+GKoF0weDUhYEI158MnKjKY6cGiHD+IEQOADo8HfMo
         ltZvkdtYzy9ZWizNhYNDkoZMtkOmiXpzTyfeSIGesfbtdKSOnh7O5a7T8FMYAHMNYU8Z
         5qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwpPls27wrQO1UfCcmnU9Wea99yS3enxM5WDyvaYlAI=;
        b=qkTTsDq/Yke4oBqTOrG7n3GSif5pEinKUKZ1/Rw3gMXHwahoUvtF/2q7dbd3jSvvFi
         93PYNxJajdt1rkdZYn4yU3nkWmc/ldlwhbZaWT4wCW7/powOJ7AkUojgqvW0YqXcjLQR
         eOx+XaCw9/kW/1Lds1fgNJdEzoDFahsYnxfBaqEUg0nd2a8S/LFwydO210G59BupwuzV
         8PaGjpysKj9KbqhAQmUzM2h4Fm3seS/z/JtEZ2UyqajBbxaFcgDYLjtB6q8wBARvcR+8
         dQw33sJgXG2ITN4kndGo2Xtw1OEDNjzdo+EJYfEEIhDyTizvRhtvvcdSfCX+niM4xqIo
         I37w==
X-Gm-Message-State: AOAM532o0FJxuThbfJs/NY1GbZ1CzgcQtwSpzMkhqSm95d+6psvrzwUy
        bxhyMj05QZEFe96l0fRZbN4jVMq8zi+FDJ42a1soT1C77lU=
X-Google-Smtp-Source: ABdhPJx8NEdNW9mHLxyzieXCbBwdGXcSk22uNkwH0AdiqMhCjy+mJ1XFQUp+FLcPkFEeGrOSZclHN5BRZGUrO9eIKMU=
X-Received: by 2002:a17:906:b1a:: with SMTP id u26mr3790305ejg.23.1601667446901;
 Fri, 02 Oct 2020 12:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200928170919.707641-1-Anna.Schumaker@Netapp.com>
 <20200928170919.707641-8-Anna.Schumaker@Netapp.com> <f0260b917ab4e0812a7e628e49847867059300ce.camel@hammerspace.com>
In-Reply-To: <f0260b917ab4e0812a7e628e49847867059300ce.camel@hammerspace.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Fri, 2 Oct 2020 15:37:10 -0400
Message-ID: <CAFX2Jf=8-8A1dcharq0Exj3-XvTKWznmNU1FiQu-nAej25iFAw@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] SUNRPC: Add the ability to expand holes in data pages
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Thu, Oct 1, 2020 at 1:39 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2020-09-28 at 13:09 -0400, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > This patch adds the ability to "read a hole" into a set of XDR data
> > pages by taking the following steps:
> >
> > 1) Shift all data after the current xdr->p to the right, possibly
> > into
> >    the tail,
> > 2) Zero the specified range, and
> > 3) Update xdr->p to point beyond the hole.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  include/linux/sunrpc/xdr.h |  1 +
> >  net/sunrpc/xdr.c           | 73
> > ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 74 insertions(+)
> >
> > diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> > index 026edbd041d5..36a81c29542e 100644
> > --- a/include/linux/sunrpc/xdr.h
> > +++ b/include/linux/sunrpc/xdr.h
> > @@ -252,6 +252,7 @@ extern __be32 *xdr_inline_decode(struct
> > xdr_stream *xdr, size_t nbytes);
> >  extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned
> > int len);
> >  extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int
> > len);
> >  extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset,
> > unsigned int len, int (*actor)(struct scatterlist *, void *), void
> > *data);
> > +extern uint64_t xdr_expand_hole(struct xdr_stream *, uint64_t,
> > uint64_t);
> >
> >  /**
> >   * xdr_stream_remaining - Return the number of bytes remaining in
> > the stream
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index d8c9555c6f2b..24baf052e6e6 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -390,6 +390,42 @@ _copy_from_pages(char *p, struct page **pages,
> > size_t pgbase, size_t len)
> >  }
> >  EXPORT_SYMBOL_GPL(_copy_from_pages);
> >
> > +/**
> > + * _zero_pages
> > + * @pages: array of pages
> > + * @pgbase: beginning page vector address
> > + * @len: length
> > + */
> > +static void
> > +_zero_pages(struct page **pages, size_t pgbase, size_t len)
> > +{
> > +     struct page **page;
> > +     char *vpage;
> > +     size_t zero;
> > +
> > +     page = pages + (pgbase >> PAGE_SHIFT);
> > +     pgbase &= ~PAGE_MASK;
> > +
> > +     do {
> > +             zero = PAGE_SIZE - pgbase;
> > +             if (zero > len)
> > +                     zero = len;
> > +
> > +             vpage = kmap_atomic(*page);
> > +             memset(vpage + pgbase, 0, zero);
> > +             kunmap_atomic(vpage);
> > +
> > +             pgbase += zero;
> > +             if (pgbase == PAGE_SIZE) {
>
> Hmm.... Do we need to make this conditional? After all, if pgbase !=
> PAGE_SIZE in this case, then zero == len, in which case we still want
> to flush_dcache_page(*page) and then exit.

I removed the condition, and everything works just the same. So I
guess it's not necessary. Good catch!
>
> > +                     flush_dcache_page(*page);
> > +                     pgbase = 0;
> > +                     page++;
> > +             }
> > +
> > +     } while ((len -= zero) != 0);
> > +     flush_dcache_page(*page);
> > +}
> > +
> >  /**
> >   * xdr_shrink_bufhead
> >   * @buf: xdr_buf
> > @@ -1141,6 +1177,43 @@ unsigned int xdr_read_pages(struct xdr_stream
> > *xdr, unsigned int len)
> >  }
> >  EXPORT_SYMBOL_GPL(xdr_read_pages);
> >
> > +uint64_t xdr_expand_hole(struct xdr_stream *xdr, uint64_t offset,
> > uint64_t length)
> > +{
> > +     struct xdr_buf *buf = xdr->buf;
> > +     unsigned int bytes;
> > +     unsigned int from;
> > +     unsigned int truncated = 0;
> > +
> > +     if ((offset + length) < offset ||
> > +         (offset + length) > buf->page_len)
> > +             length = buf->page_len - offset;
> > +
> > +     xdr_realign_pages(xdr);
> > +     from = xdr_page_pos(xdr);
> > +     bytes = xdr->nwords << 2;
>
> Hmm... Won't this mean that we also include the padding at the end of
> the read buffer in 'bytes'?

I guess it would, assuming the server adds padding to the end of the
buffer. Should the server be adding padding here? Because it doesn't
the way I have it coded now (and RFC 7862 doesn't say anything about
padding at the end of a READ_PLUS reply).

Anna

>
> > +
> > +     if (offset + length + bytes > buf->page_len) {
> > +             unsigned int shift = (offset + length + bytes) - buf-
> > >page_len;
> > +             unsigned int res = _shift_data_right_tail(buf, from +
> > bytes - shift, shift);
> > +             truncated = shift - res;
> > +             xdr->nwords -= XDR_QUADLEN(truncated);
> > +             bytes -= shift;
> > +     }
> > +
> > +     /* Now move the page data over and zero pages */
> > +     if (bytes > 0)
> > +             _shift_data_right_pages(buf->pages,
> > +                                     buf->page_base + offset +
> > length,
> > +                                     buf->page_base + from,
> > +                                     bytes);
> > +     _zero_pages(buf->pages, buf->page_base + offset, length);
> > +
> > +     buf->len += length - (from - offset) - truncated;
> > +     xdr_set_page(xdr, offset + length, PAGE_SIZE);
> > +     return length;
> > +}
> > +EXPORT_SYMBOL_GPL(xdr_expand_hole);
> > +
> >  /**
> >   * xdr_enter_page - decode data from the XDR page
> >   * @xdr: pointer to xdr_stream struct
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
