Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4562D240B3B
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Aug 2020 18:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgHJQgf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Aug 2020 12:36:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25290 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727833AbgHJQgd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Aug 2020 12:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597077392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E7cstcAHVFGfhscj0UF342G+MM1KSXqD/P1R9pHujqc=;
        b=YV9tEoXXLoSBTdBZfXyA4yI1CoocsTaPyuKoLd5zCJ0+APuQJlyDbVBinKQLjQOHIsgaCy
        YwVjaGHPW0pAJTzPozfHWeeJqNQTgHxss/MW0KgigVlofmtWgVKU0IrmCQDvwxSzmO2weR
        kfF5B3rFnRRY7GQF5XnvvZNabRkZfmU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-xDURFU1uNju7tJRYeiawDQ-1; Mon, 10 Aug 2020 12:36:30 -0400
X-MC-Unique: xDURFU1uNju7tJRYeiawDQ-1
Received: by mail-ej1-f69.google.com with SMTP id m18so4101078ejl.5
        for <linux-nfs@vger.kernel.org>; Mon, 10 Aug 2020 09:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7cstcAHVFGfhscj0UF342G+MM1KSXqD/P1R9pHujqc=;
        b=pzb1N7bVEMuVdan5OFCeKlsvqRigM2jaILJPe2ycppzrvljY8cYMlqygU1slzSNiPE
         6CKYHgcQ1xH6ycLjArypZonB6yEH+v/jodnMJv4CvBXsKL/p2UZp2WjWT2F46hGihsQA
         hpFhkmixnGkfSJd7YZGjog5mWUogj7ziQFxkzYz6Yf7I+OARH4IV2zwZ+b1xNNqOgFj+
         QFxjAjS0CrWtPrMEgA4r4eShwA/wl4ONYkmCzK4QZ8mLkqBVi2h9iO8giH97gF7oSu9V
         2hjpkpDJQvNaLepiYUM3wMMEgo4nrw5m6bVmPbT0LTqUlOHtng0fJSbtHpvfbZfbCBmt
         tYSA==
X-Gm-Message-State: AOAM5314KDgPr4SMYkWxI91XKtY3tNDGembas2dfZ+XxRzllLWtrUfwl
        mBhQKVLTucAfshdt44kSDdL5pM2wzSyxeH8KIvWIxyXnutbIqrKzhW+2AU0915vvUg21xKYq9AE
        9CpbWCrTLGGquxdM705DTHya6n6AAMXbxgoA1
X-Received: by 2002:a17:906:a4b:: with SMTP id x11mr23475872ejf.83.1597077389406;
        Mon, 10 Aug 2020 09:36:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxf3SVX6ZuISdp8oMWj+mkcjWbaPxLFNRh9thEVecTra/0s+AaKG5bkamyJTprqlXgn7eVTDeevbLYmrbh9t0=
X-Received: by 2002:a17:906:a4b:: with SMTP id x11mr23475853ejf.83.1597077389176;
 Mon, 10 Aug 2020 09:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <447452.1596109876@warthog.procyon.org.uk> <1851200.1596472222@warthog.procyon.org.uk>
 <667820.1597072619@warthog.procyon.org.uk> <CAH2r5msKipj1exNUDaSUN7h0pjanOenhSg2=EWYMv_h15yKtxg@mail.gmail.com>
 <672169.1597074488@warthog.procyon.org.uk>
In-Reply-To: <672169.1597074488@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 10 Aug 2020 12:35:53 -0400
Message-ID: <CALF+zO=DkGmNDrrr-WxU6L1Xw8MA4+NrqVbvNMctwSKjy0Yh_w@mail.gmail.com>
Subject: Re: [GIT PULL] fscache rewrite -- please drop for now
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 10, 2020 at 11:48 AM David Howells <dhowells@redhat.com> wrote:
>
> Steve French <smfrench@gmail.com> wrote:
>
> > cifs.ko also can set rsize quite small (even 1K for example, although
> > that will be more than 10x slower than the default 4MB so hopefully no
> > one is crazy enough to do that).
>
> You can set rsize < PAGE_SIZE?
>
> > I can't imagine an SMB3 server negotiating an rsize or wsize smaller than
> > 64K in today's world (and typical is 1MB to 8MB) but the user can specify a
> > much smaller rsize on mount.  If 64K is an adequate minimum, we could change
> > the cifs mount option parsing to require a certain minimum rsize if fscache
> > is selected.
>
> I've borrowed the 256K granule size used by various AFS implementations for
> the moment.  A 512-byte xattr can thus hold a bitmap covering 1G of file
> space.
>
>

Is it possible to make the granule size configurable, then reject a
registration if the size is too small or not a power of 2?  Then a
netfs using the API could try to set equal to rsize, and then error
out with a message if the registration was rejected.

