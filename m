Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4206447794A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Dec 2021 17:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhLPQga (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 11:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhLPQga (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 11:36:30 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65A9C061574
        for <linux-nfs@vger.kernel.org>; Thu, 16 Dec 2021 08:36:29 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z7so27344840edc.11
        for <linux-nfs@vger.kernel.org>; Thu, 16 Dec 2021 08:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkh9SA21WJAwLXrex3D5hDMvc6XDF8J0dz4irJ+Ae9Y=;
        b=TZ91WtmX33bYGxQ28DYuwMlA4L/Ykfses9BBTD3iJ52Q9qh/2tU+S4awSqTTbNIEfO
         NIVIGXtvrTssU7E/Ib+EszfgqaQI3Ug/c2E/ITq3PkTvuJKpkp8KHKAP+FyMLrxxfyHm
         7LDKJiXUmfROJo2atlx1zLIBfA58BXXUjM6Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkh9SA21WJAwLXrex3D5hDMvc6XDF8J0dz4irJ+Ae9Y=;
        b=p6LK4HCAC1Q5Ay23AhEO7yi2usbelJ7MwPYwVhmI+MiF1hJs0UYjNLsJoLOUFJS0eI
         5CZ2v2/GxjkDXCS8osWXZvFTrGiUrt75PKsawHOvRzPnduSem6R00lIMuIdMEK4tJbr/
         MvLnjtilw2KSzuRb4hcXLy2dWYy6+sEaO8q+0I/6LkUr7F90SuJ9zCF43pB7OI+jFgbm
         oBbyAPuihWMSX6nDqUS59wnLDJAtpFkUiB7c+Zrv486R3g11jBAD7bjNoYY+W7odvHlB
         GEO0WT80dvbOSWHciRS8aNGnPVxAFi/XXv82NHOnLg1ZxDilc/zdXfyui2bapwTWMkEi
         /2qA==
X-Gm-Message-State: AOAM533P6sZrc4vCTm3kdu0Z1XvFxanHCdPe2lDtk62w1487ep30nVi8
        fVwUjQm7jj+olWRRlsMbSU+f5cJhCctkyavgA1A=
X-Google-Smtp-Source: ABdhPJyJ+O4jT0nlfqNW54EZZR/mHLNMDFTqQRk2nP4JH6w67pl1qX7ey5Ev33VEeepaVYMDwlgheg==
X-Received: by 2002:a17:906:58d5:: with SMTP id e21mr17110529ejs.540.1639672573086;
        Thu, 16 Dec 2021 08:36:13 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id n8sm2620011edy.4.2021.12.16.08.36.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 08:36:12 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id j9so13120632wrc.0
        for <linux-nfs@vger.kernel.org>; Thu, 16 Dec 2021 08:36:12 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr9727999wru.97.1639672086343;
 Thu, 16 Dec 2021 08:28:06 -0800 (PST)
MIME-Version: 1.0
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
 <163967172373.1823006.6118195970180365070.stgit@warthog.procyon.org.uk>
In-Reply-To: <163967172373.1823006.6118195970180365070.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Dec 2021 08:27:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjiba2VRKKjOYAiCZn1Tk9H1tiXcOvjekdo3wPHHmedyQ@mail.gmail.com>
Message-ID: <CAHk-=wjiba2VRKKjOYAiCZn1Tk9H1tiXcOvjekdo3wPHHmedyQ@mail.gmail.com>
Subject: Re: [PATCH v3 57/68] afs: Fix afs_write_end() to handle len > page size
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-afs@lists.infradead.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 16, 2021 at 8:22 AM David Howells <dhowells@redhat.com> wrote:
>
> It is possible for the len argument to afs_write_end() to overrun the end
> of the page (len is used to key the size of the page in afs_write_start()
> when compound pages become a regular thing).

This smells like a bug in the caller.

It's just insane to call "write_end()" with a range that doesn't
actually fit in the page provided.

Exactly how does that happen, and why should AFS deal with it, not
whoever called write_end()?

              Linus
