Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87552A354E
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 21:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgKBUm2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 15:42:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbgKBUld (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 15:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604349691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxBulsYZNis0tH9PhjqOsIS5txkFYroyjOExPVCZg68=;
        b=J76enmJte13f3t+cT7/PJJkUKItIoSuSS3K5W8S2o5vBkt/Ni/RMcu1gZ/TX2J1LaVifSj
        APAiUmcLPN+Si1cBAwz7V91zspTpAtBwpSJOh2SDVIKYgzcXv/F4m08+KiNklXWLokrx0N
        pejiHOqwQbVzszZKIBIpnq33FcggXSo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-J6dHEaDsOFeD7To0c3aGAw-1; Mon, 02 Nov 2020 15:41:30 -0500
X-MC-Unique: J6dHEaDsOFeD7To0c3aGAw-1
Received: by mail-ej1-f69.google.com with SMTP id nt22so1708429ejb.17
        for <linux-nfs@vger.kernel.org>; Mon, 02 Nov 2020 12:41:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxBulsYZNis0tH9PhjqOsIS5txkFYroyjOExPVCZg68=;
        b=fCB5PRo3PtSnJ3lwESAQ0tvr0oNxgZ5q2gG6/6RN+IK1KU6pTBv5WXkNvKDTNh+Xbi
         iPFvUTUdWt85Rg0EaiMCQo/02F+9amMqcLkOVIDq163HNdHD/MmAC2oPYPvj+2MV6AEz
         gF5ZCvNi/i0E4iTDAE846WuBKLeQ+J0RcyrOn2aM+4bsvofHEBYm+jDTQVxqpdTORaYW
         O/vseElRHIQx/pxMIZWZLwVTlNcXMPfLyG06NgyqWKPz21+pzRr4azE3vtnLbu2HdJhB
         0h+b2UQBjH5seFIrvERme5d1zEuPtcQeSe1B9t9wQIllcFMQxMKHdzfx6w2M6hRl0pvE
         d32A==
X-Gm-Message-State: AOAM533WeLV1VLIMqKvprpTFSd1Ru2xRvsfn632mWYk3kwXHGW4kQTpB
        87MrNwue6r1aYwN42ddLZbd7JXjpMRmcTAXOeBowh5ob0zK7dPvJHVd/4igWRfB79EPyhkt9E05
        4NTY+hQ3dP7QJSooaM7LKTR/SVyAyKfSBJ9Wd
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr16776279eji.320.1604349688644;
        Mon, 02 Nov 2020 12:41:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy88ClboVgkzN9UT2vPTkKRGfJQGNq83AGpsJSjouPWJCUCgBwDAkZC7jMonuvdhoxZOaXq6tW6ZV9Z7X+b1o=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr16776264eji.320.1604349688421;
 Mon, 02 Nov 2020 12:41:28 -0800 (PST)
MIME-Version: 1.0
References: <20201102180658.6218-1-trondmy@kernel.org>
In-Reply-To: <20201102180658.6218-1-trondmy@kernel.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 2 Nov 2020 15:40:52 -0500
Message-ID: <CALF+zOm4LwsgBBcA8AoHA2NMZddkRdCXRM8UNqBSxd6gj1ci9g@mail.gmail.com>
Subject: Re: [PATCH 00/12] Readdir enhancements
To:     trondmy@kernel.org
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 2, 2020 at 1:17 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> The following patch series performs a number of cleanups on the readdir
> code.
> It also adds support for 1MB readdir RPC calls on-the-wire, and modifies
> the caching code to ensure that we cache the entire contents of that
> 1MB call (instead of discarding the data that doesn't fit into a single
> page).
>
> Trond Myklebust (12):
>   NFS: Ensure contents of struct nfs_open_dir_context are consistent
>   NFS: Clean up readdir struct nfs_cache_array
>   NFS: Clean up nfs_readdir_page_filler()
>   NFS: Clean up directory array handling
>   NFS: Don't discard readdir results
>   NFS: Remove unnecessary kmap in nfs_readdir_xdr_to_array()
>   NFS: Replace kmap() with kmap_atomic() in nfs_readdir_search_array()
>   NFS: Simplify struct nfs_cache_array_entry
>   NFS: Support larger readdir buffers
>   NFS: More readdir cleanups
>   NFS: nfs_do_filldir() does not return a value
>   NFS: Reduce readdir stack usage
>
>  fs/nfs/client.c        |   4 +-
>  fs/nfs/dir.c           | 555 ++++++++++++++++++++++++-----------------
>  fs/nfs/internal.h      |   6 -
>  include/linux/nfs_fs.h |   1 -
>  4 files changed, 325 insertions(+), 241 deletions(-)
>
> --
> 2.28.0
>

Nice to see these, especially
[PATCH 05/12] NFS: Don't discard readdir results

Are you testing these on top of 5.10-rc2 or something else?

