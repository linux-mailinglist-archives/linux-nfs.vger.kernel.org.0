Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2508646F223
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 18:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhLIRjB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 12:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbhLIRjB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 12:39:01 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FD5C061746
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 09:35:27 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so22412427edv.1
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 09:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Ief/4lrcrFC9yHQblzF1a8RET0HNi3QQm3divo4aI0=;
        b=AdnCyXT6TPlVVq0JLA/VEVV0O33H285eATNlyLPRaIFmtxnqr6S23nXl2J32guXc1O
         plkuA6YLaLfLkkkWTPqQOSOG7bZY0JEwSmKNFIrfpMXr3oq7FfmHctvECgg0O0gJcn+c
         hrPmI2kNvz5VH+5qzZSG7wTmayKDH0Ub3btDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Ief/4lrcrFC9yHQblzF1a8RET0HNi3QQm3divo4aI0=;
        b=qbMbUNsq3xUuL6NIjAdfEzrxr0gbzqMcy+6UqKh9IknuIcIxjL50CdfsGjjeZhGSlA
         aUzpt11DQNm6IG9YYdvublc6hqIUFONPvYuSP9N5uOsjlPnX4C6jBQPV0Zr2fNsLIHnc
         YLKZT8FwkJRRzr2ry5DZMTWY5g/jSTByPYALDAuPmHgy4op2l5lEU2XVSCaAos8qlJCE
         VLx36vclAz2TJnCJVtXU1vh9NFtcCHZ12M6c4e4mlNIEIeOvcHKdwtC/RTOIGhoAbmQl
         ibfDg6+fp1ZAS/XXszHXqRSKzqHEM+qT+QqMU65ZsmjlhRhH/BQN530EU0ZxpzMX1EkU
         RTZw==
X-Gm-Message-State: AOAM530SHWQ2pl6rcQmGGaVQvQ43v7PG/9GAm5TEWXN1s8rtvrRg6STV
        4UV69WAmXRAP4DY5lGJ/GMctSpDJta8fM0sZ
X-Google-Smtp-Source: ABdhPJwDzAiJf59Wvkq65JUQzzkTkerTdzjB5mb5SXLvKIGq2gHQoxT3mU6dGUs2Wk+vLZtY7KCv5w==
X-Received: by 2002:a17:906:d108:: with SMTP id b8mr17311145ejz.531.1639071174512;
        Thu, 09 Dec 2021 09:32:54 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id s2sm253483ejn.96.2021.12.09.09.32.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 09:32:52 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id c4so10940506wrd.9
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 09:32:51 -0800 (PST)
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr7703596wrx.378.1639071170949;
 Thu, 09 Dec 2021 09:32:50 -0800 (PST)
MIME-Version: 1.0
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
 <163906890630.143852.13972180614535611154.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906890630.143852.13972180614535611154.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Dec 2021 09:32:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg35xyf-HgOLcKdWVxm11vNomLVe44b1FsxvV6jDqw2CA@mail.gmail.com>
Message-ID: <CAHk-=wg35xyf-HgOLcKdWVxm11vNomLVe44b1FsxvV6jDqw2CA@mail.gmail.com>
Subject: Re: [PATCH v2 09/67] fscache: Implement volume registration
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 9, 2021 at 8:55 AM David Howells <dhowells@redhat.com> wrote:
>
> +static long fscache_compare_volume(const struct fscache_volume *a,
> +                                  const struct fscache_volume *b)
> +{
> +       size_t klen;
> +
> +       if (a->key_hash != b->key_hash)
> +               return (long)a->key_hash - (long)b->key_hash;
> +       if (a->cache != b->cache)
> +               return (long)a->cache    - (long)b->cache;
> +       if (a->key[0] != b->key[0])
> +               return (long)a->key[0]   - (long)b->key[0];
> +
> +       klen = round_up(a->key[0] + 1, sizeof(unsigned int));
> +       return memcmp(a->key, b->key, klen);

None of this is endianness-independent except for the final memcmp()
(and that one assumes the data is just a "stream of bytes")

In fact, even if everybody is little-endian, the above gives different
results on 32-bit and 64-bit architectures, since you're doing math in
(possibly) 64 bits but using a 32-bit "key_hash". So sign bits will
differ, afaik.

And once again, that key_hash isn't actually endianness-independent anyway:

> +       volume->key_hash = fscache_hash(0, (unsigned int *)key,
> +                                       hlen / sizeof(unsigned int));

Yeah, for the same key data, this will give entirely different results
on LE vs BE, unless you've made sure to always convert whatever keys
from soem on-disk fixed-32-bit-endianness format to a in-memory host
endianness.

Which is a fundamental design mistake in itself. That kind of "one
endianness on disk, another in memory" is garbage.

I'm not sure any of these matter - maybe all these hashes are entirely
for in-memory stuff and never haev any longer lifetimes, so the fact
that they get calculated and compared differently depending on
endianness and depending on word size may not matter at all. You may
only care about "stable on the native architecture".

But then you shouldn't have your own hash function that you claim is
somehow endianness-safe.

If you really want to be endianness safe, *ALL* the data you work on
needs to be a proper fixed endianness format. All throught the code.
Make all key pointers always be "__le32 *", and never randomly cast
the pointer from some other data like I see in every use I actually
looked at.

                  Linus
