Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D2A3E4DF9
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhHIUh5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 16:37:57 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39570 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhHIUh4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 16:37:56 -0400
Received: by mail-ed1-f44.google.com with SMTP id t1so99574edd.6
        for <linux-nfs@vger.kernel.org>; Mon, 09 Aug 2021 13:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTYB3u5kizoIG6eLk8Z5TNp6x9mo8pJAvqo9sxu44ic=;
        b=uQTMRhjhCxXgvQyjwAnq/Xx50cPDJVHkfQTBR1ZHbkxSvC6A0979/fif9mUlgSCmgG
         AjLqFYXMgtKMGb7VKQ/l25Kk+D6UhgrX17hWetMJqwKe26pvKm5RrH8prn8pnBv2ZINh
         rxCnvGH3/ow451g1YfPRSnAuDwSX4QXprGzC+SeFakztIr4VU8gcgWi1ZARW3QZ/T8TL
         fTYk0SlcKVCgkl0KTCcWoHGtseo1nZ0o84wS/3hmqIwc3fIJrnQ3g+Jof8bbfQ59C+Un
         MhiuculTUnsRRExLULq7yIh41O7LsD7vGlIfZGqS2aFHAfDFr45QIo5g6Oe7tN3Jjsz/
         sFWw==
X-Gm-Message-State: AOAM5308m7Uux1YHqaUxXa2Cqv3gjy47K8cWhvKTrIC7+/oey47OQnNJ
        bW8ieDde6UJUYI0cab4+LnGcyuHYRY0Dh47o5Eg=
X-Google-Smtp-Source: ABdhPJw2h8pAN7ztBT6YLMnjyKRT2jWLsniZnjfVlrsq5HRFKjiH1aOGewtwPGuvuTUMgvaj6WupQelWLLlqh9hI7G0=
X-Received: by 2002:a05:6402:1206:: with SMTP id c6mr190639edw.264.1628541454989;
 Mon, 09 Aug 2021 13:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <162670594361.468132.16222376053830760696.stgit@manet.1015granger.net>
In-Reply-To: <162670594361.468132.16222376053830760696.stgit@manet.1015granger.net>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Mon, 9 Aug 2021 16:37:18 -0400
Message-ID: <CAFX2Jf=PvvsU8p+3i3OdLOwRCWDedBKhbhnNOe-RyaXx5LWUow@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Ensure RPC_TASK_NORTO is disabled for select operations
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Mon, Jul 19, 2021 at 10:55 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> This is a set of patches I've been toying with to get better
> responsiveness from a client when a transport remains connected but
> the server is not returning RPC replies.
>
> The approach I've taken is to disable RPC_TASK_NO_RETRANS_TIMEOUT
> for a few particular operations to enable them to time out even
> though the connection is still operational. It could be
> appropriate to take this approach for any idempotent operation
> that cannot be killed with a ^C.
>
> Changes since RFC:
> - Dropped changes to async lease renewal and DESTROY_SESSION|CLIENTID
> - Cleaned up some tracepoint issues I found along the way

Is this the latest version of these patches? If so I can include them
in my linux-next branch for 5.14.

Thanks,
Anna

>
> ---
>
> Chuck Lever (6):
>       SUNRPC: Refactor rpc_ping()
>       SUNRPC: Unset RPC_TASK_NO_RETRANS_TIMEOUT for NULL RPCs
>       SUNRPC: Remove unneeded TRACE_DEFINE_ENUMs
>       SUNRPC: Update trace flags
>       SUNRPC: xprt_retransmit() displays the the NULL procedure incorrectly
>       SUNRPC: Record timeout value in xprt_retransmit tracepoint
>
>
>  include/trace/events/sunrpc.h | 51 ++++++++---------------------------
>  net/sunrpc/clnt.c             | 33 ++++++++++++++++-------
>  2 files changed, 35 insertions(+), 49 deletions(-)
>
> --
> Chuck Lever
>
