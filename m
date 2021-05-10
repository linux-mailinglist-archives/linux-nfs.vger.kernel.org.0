Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2541379576
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 19:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhEJRZ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 13:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232771AbhEJRZz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 May 2021 13:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620667487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ch3E95QzqfGBseXjr5TUz9rCrEJ5hPyWYlAlr5DAKAE=;
        b=PPeHvQcMyfSshdD6nEPjb8w/y3ljr1XSy7HZQSZxhAWRds2lE/tSZIPnxtfi7D5OPYfI7G
        wumyJ3Sb9xNrlRwzkvBaLrGMf6wlM7uaI84th54Jw6XVtsNx66j60EHjwbxtP7hLPnyLgD
        wVz/C9HMoIbBRs9SloC7LJ2dFqf1GZ0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-kvPtwmqNPwi73O71G6kikg-1; Mon, 10 May 2021 13:24:45 -0400
X-MC-Unique: kvPtwmqNPwi73O71G6kikg-1
Received: by mail-yb1-f199.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so20429755ybp.0
        for <linux-nfs@vger.kernel.org>; Mon, 10 May 2021 10:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ch3E95QzqfGBseXjr5TUz9rCrEJ5hPyWYlAlr5DAKAE=;
        b=KscQWEiJOKlA80PaNSOxfisyRfIbJyhy51Bbpbk6yxtkk1DU8OcRIWnPwnTHTOJGmg
         xFL5KfLakJvkYCochAgRK7dqa3UwFLW82fhqQK5e+p/VWVLWF7dDeDrssuO7cCldUw8a
         eF2R4S9QDzzsKZxehJtaoa3xKGECPETGLzAhaqUhnUaxePnv1kmeM2J/7Au2VPGJXkeK
         mivQdn9IhwlB9Vz4/re4S06VgQQvRq43iX4oDwUbsIWSg8yhPZIelYMJ8xdvom5QfOeg
         J+RSF0/g8R+YrV1FzdZksNMD1XiJIHUnhjy7CF8bQV6NGW9bE0GVNANnwpZwngcRVMKE
         24vg==
X-Gm-Message-State: AOAM53364yMzn395T7VZAwNd01R+hFwZ3PGTFE1NLKzkwxL7RUpvo3za
        TQYFjfKs1XHW2x0J7TebulNLr9DphY+q8mZqGNy/UrzNTZ/Lx9l9FRWvKlGztUXZwex9L1KU+zP
        /ciiwEefoqpELzY4+ZVXk15g0d+jXHa50b8+p
X-Received: by 2002:a05:6902:565:: with SMTP id a5mr33022507ybt.423.1620667485014;
        Mon, 10 May 2021 10:24:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2+/Fe8RZXa+WZR3tl4ynlWFPlskNcrPIgaIbn7chtFGLPK6zK/bPb6ZD+pMdcwRdctn0FWZC++rWHHe+91cs=
X-Received: by 2002:a05:6902:565:: with SMTP id a5mr33022484ybt.423.1620667484757;
 Mon, 10 May 2021 10:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 10 May 2021 13:24:08 -0400
Message-ID: <CALF+zOkyPOr+mXu+N-GKvusremTDZ53zTF_YiqFXgTRc2JC58g@mail.gmail.com>
Subject: Re: [PATCH RFC 00/21] NFSD callback and lease management observability
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 10, 2021 at 11:51 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Happy Monday.
>
> I've hacked together some improvements to the tracepoints that record
> server callback and lease management activity. I'm interested in
> review comments and testing. I'm sure I've missed your favorite edge
> case, so please let me know what it is!
>

I will take a look at these, especially with an eye towards some of
the recent discussions about duplicate client ids.
Building now (against 5.13-rc1).

Thanks Chuck!

> ---
>
> Chuck Lever (21):
>       NFSD: Constify @fh argument of knfsd_fh_hash()
>       NFSD: Capture every CB state transition
>       NFSD: Drop TRACE_DEFINE_ENUM for NFSD4_CB_<state> macros
>       NFSD: Add cb_lost tracepoint
>       NFSD: Adjust cb_shutdown tracepoint
>       NFSD: Remove spurious cb_setup_err tracepoint
>       NFSD: Enhance the nfsd_cb_setup tracepoint
>       NFSD: Add an nfsd_cb_lm_notify tracepoint
>       NFSD: Add an nfsd_cb_offload tracepoint
>       NFSD: Replace the nfsd_deleg_break tracepoint
>       NFSD: Add an nfsd_cb_probe tracepoint
>       NFSD: Remove the nfsd_cb_work and nfsd_cb_done tracepoints
>       NFSD: Update nfsd_cb_args tracepoint
>       NFSD: Add nfsd_clid_cred_mismatch tracepoint
>       NFSD: Add nfsd_clid_verf_mismatch tracepoint
>       NFSD: Remove nfsd_clid_inuse_err
>       NFSD: Add nfsd_clid_confirmed tracepoint
>       NFSD: Add nfsd_clid_destroyed tracepoint
>       NFSD: Add a couple more nfsd_clid_expired call sites
>       NFSD: Rename nfsd_clid_class
>       NFSD: Add tracepoints to observe clientID activity
>
>
>  fs/nfsd/nfs4callback.c |  45 ++++----
>  fs/nfsd/nfs4proc.c     |   1 +
>  fs/nfsd/nfs4state.c    |  56 +++++++---
>  fs/nfsd/nfsfh.h        |   7 +-
>  fs/nfsd/trace.h        | 227 ++++++++++++++++++++++++++++++++++-------
>  5 files changed, 254 insertions(+), 82 deletions(-)
>
> --
> Chuck Lever
>

