Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F6232A94A
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574998AbhCBSTc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575616AbhCBD5Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 22:57:16 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF0C061756
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 19:56:35 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b13so14350425edx.1
        for <linux-nfs@vger.kernel.org>; Mon, 01 Mar 2021 19:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ogtEITfPsgDYDIa1aMvZZ9jIbFzpIK4PGkCCwyGrmk=;
        b=B8CtsPZBCfOxLejVMoG9QP/JrwrPYcFuWvrs8cEOw05DRHoK1w7QJikoYUQ0TvpWkh
         D/n0GI58nL7xF+5GGrEmpiVUTMAfsIs/76V9mPV6q+igyW9E1xJjvdtj3ckMB2Sun/tl
         x4XNGy0jaMFy8s+SOPQpGN9sFXHORahWx11ZbNUsyq5fcSkVdLQ+9PiONtrJQAqkuatZ
         B+72k8cQu1KS7/LTzpg/TS63vBMgQ+3GN5Nn/YjWphaeRw/xOqZljQuxlt3rpIs/bma0
         nVMV7hPQSDQyYw7uavGuGFpjJv9AcbnYm/KfKFtdRWQ5pyrfc90t6a8k9YGR264UCz5p
         X/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ogtEITfPsgDYDIa1aMvZZ9jIbFzpIK4PGkCCwyGrmk=;
        b=ShniVgKO+Ney0YHMZGEpovtunmJrYYE4ZtQ/IANTJWfiEh6pr4QNqCVJgjpEpxLrT3
         tEnfOiFKPi9t4iDmduIG6JPgkVYoy0WkvDb8cZP3bPDGmFK3oG8H6TwUCJxNurfnXt+d
         Ay40ELy6JVEEZNjtphfa2JPKPuQ4+nLgneFlxOgIKK5Ex9NhCUk6tH2R0jY83+WckSj9
         rXWcWmjGK/2rpFUSNYfxYSirW37NAh+Sssg8aIEyUOwbPHDoDczG5qlp/3MKoHztbs5D
         nLGOyYcYmNDgwf4aECC3+VRtCh8kJVqclNQAYg5fRuiNNSBHa8x34r8k0OdRrQaDJm5C
         6wig==
X-Gm-Message-State: AOAM533k41cODd+lQ6vieGhLvFZCjojwfy2kzvZcW/x5/9Py8awfmyOl
        r44AntUfFPLKPw0nI2hCHwHE5J/0YEeY9c337Og3ou0I
X-Google-Smtp-Source: ABdhPJxS8efEKc068hmotGruOgj1y1lO+RjqRUDIDlrP/b5E+5ji/elM8OO76U1nwdPLayx1RI+S2gUc7m3/MnDMHYk=
X-Received: by 2002:a05:6402:34c4:: with SMTP id w4mr2943948edc.367.1614657394044;
 Mon, 01 Mar 2021 19:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20210215174002.2376333-1-dan@kernelim.com>
In-Reply-To: <20210215174002.2376333-1-dan@kernelim.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 1 Mar 2021 22:56:22 -0500
Message-ID: <CAN-5tyGw3D-+emeQhu31agom9yuZ9=PL6YUVyEKiR-n2q9uE3A@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] sysfs files for multipath transport control
To:     Dan Aloni <dan@kernelim.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan,

On Mon, Feb 15, 2021 at 12:43 PM Dan Aloni <dan@kernelim.com> wrote:
>
> Hi Anna,
>
> This patchset builds ontop v2 of your 'sysfs files for changing IP' changeset.
>
> - The patchset adds two more sysfs objects, for one for transport and another
>   for multipath.
> - Also, `net` renamed to `client`, and `client` now has symlink to its principal
>   transport. A client also has a symlink to its `multipath` object.
> - The transport interface lets you change `dstaddr` of individual transports,
>   when `nconnect` is used (or if it wasn't used and these were added with the
>   new interface).
> - The interface to add a transport is using a single string written to 'add',
>   for example:
>
>        echo 'dstaddr 192.168.40.8 kind rdma' \
>                > /sys/kernel/sunrpc/client/0/multipath/add
>
> These changes are independent of the method used to obtain a sunrpc ID for a
> mountpoint. For that I've sent a concept patch showing an fspick-based
> implementation: https://marc.info/?l=linux-nfs&m=161332454821849&w=4

I'm confused: does this allow adding arbitrary connections between a
client and some server IP to an existing RPC client? Given the above
description, that's how it reads to me, can you clarify please. I
thought it was something specifically for v3 (because it has no
concept of trunking). As for NFSv4 there is a notion of getting server
locations via FS_LOCATION and doing trunking (ie multipathing)? I
don't see how this code restricts the addition of transports to v3.

>
> Thanks
>
> Dan Aloni (8):
>   sunrpc: rename 'net' to 'client'
>   sunrpc: add xprt id
>   sunrpc: add a directory per sunrpc xprt
>   sunrpc: have client directory a symlink to the root transport
>   sunrpc: add IDs to multipath
>   sunrpc: add multipath directory and symlink from client
>   sunrpc: change rpc_clnt_add_xprt() to rpc_add_xprt()
>   sunrpc: introduce an 'add' node to 'multipath' sysfs directory
>
>  fs/nfs/pnfs_nfs.c                    |  12 +-
>  include/linux/sunrpc/clnt.h          |  12 +-
>  include/linux/sunrpc/xprt.h          |   3 +
>  include/linux/sunrpc/xprtmultipath.h |   6 +
>  net/sunrpc/clnt.c                    |  39 +--
>  net/sunrpc/sunrpc_syms.c             |   2 +
>  net/sunrpc/sysfs.c                   | 403 +++++++++++++++++++++++----
>  net/sunrpc/sysfs.h                   |  21 +-
>  net/sunrpc/xprt.c                    |  29 ++
>  net/sunrpc/xprtmultipath.c           |  37 +++
>  10 files changed, 487 insertions(+), 77 deletions(-)
>
> --
> 2.26.2
>
