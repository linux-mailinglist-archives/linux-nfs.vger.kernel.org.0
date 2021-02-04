Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A27330FD3B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Feb 2021 20:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbhBDTth (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Feb 2021 14:49:37 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34407 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbhBDTt0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Feb 2021 14:49:26 -0500
Received: by mail-ed1-f41.google.com with SMTP id df22so5792128edb.1;
        Thu, 04 Feb 2021 11:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/GO9sI7Vf7IL7jv4bfvAUUPsx9bL8ZXpsUusT8QVMc=;
        b=M58dsmEmAWN/lbGs0ATWXikRs2Q+KYp821NysBowJADD4W7usIgui3p4keWqMMyUl+
         kIM3HeKwzB68EV73T92GGMCIGtUaxDYdPbDgzQEZVlmCymAjGI3Z4fNljawgbxvuxKOA
         dFFMhxw2eUxpNZCf+TCC4UpPGgwSc13qBEoAqoimZ6TjQMVFT65b0jY/mzYreL0jiYLZ
         lobVFH3mf0JyCv9WXST7C1PdUuZi+LUqyO7QLqvgD0+xI8n067maNVADGmVaFWj2gtzJ
         B0u8j0rNA1tSxSqcnZd0RB07zZSzrZL5M7FdQVBl2eKk5wIQd7jhBfH7tTe4fN7b3ok3
         OmOw==
X-Gm-Message-State: AOAM530z0Ju4Kr/DTEdZjtOYO7gyjJ9zECRQY9YWPa4axfEIOSr06w2e
        HJ8jHQ6MMxo5FCm1kslOCXcA6Nwz277wjBp4vNY=
X-Google-Smtp-Source: ABdhPJxeCtZELHzh/eN+r1H8OvIWuyLlMYRmxN5E7i/PxhJA32jDX9ifKeJvKLA+9S4vUgJyfr3YqD6iuxcdMuevacM=
X-Received: by 2002:a05:6402:26d5:: with SMTP id x21mr244262edd.50.1612468124243;
 Thu, 04 Feb 2021 11:48:44 -0800 (PST)
MIME-Version: 1.0
References: <161245786674.737759.8361822825753388908.stgit@manet.1015granger.net>
In-Reply-To: <161245786674.737759.8361822825753388908.stgit@manet.1015granger.net>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Thu, 4 Feb 2021 14:48:28 -0500
Message-ID: <CAFX2Jfkovdfj9+OcVkHcUn8v4FP50CYRcyQ=qQiFqD4O+eTrJg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] RPC/RDMA client fixes
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        List Linux RDMA Mailing <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 4, 2021 at 2:29 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Anna-
>
> I think these are ready for you.

Sounds good! I'll take a look at this version soon, and add it to my
linux-next for the next merge window.

Anna

>
> Changes since v3:
> - One minor source code clean up
>
> Changes since v2:
> - Another minor optimization in rpcrdma_convert_kvec()
> - Some patch description clarifications
> - Add Reviewed-by (thanks Tom!)
>
> Changes since v1:
> - Respond to review comments
> - Split "Remove FMR support" into three patches for clarity
> - Fix implicit chunk roundup
> - Improve Receive completion tracepoints
>
> ---
>
> Chuck Lever (6):
>       xprtrdma: Remove FMR support in rpcrdma_convert_iovs()
>       xprtrdma: Simplify rpcrdma_convert_kvec() and frwr_map()
>       xprtrdma: Refactor invocations of offset_in_page()
>       rpcrdma: Fix comments about reverse-direction operation
>       xprtrdma: Pad optimization, revisited
>       rpcrdma: Capture bytes received in Receive completion tracepoints
>
>
>  include/trace/events/rpcrdma.h             | 50 +++++++++++++++++++++-
>  net/sunrpc/xprtrdma/backchannel.c          |  4 +-
>  net/sunrpc/xprtrdma/frwr_ops.c             | 12 ++----
>  net/sunrpc/xprtrdma/rpc_rdma.c             | 17 +++-----
>  net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  4 +-
>  net/sunrpc/xprtrdma/xprt_rdma.h            | 15 ++++---
>  6 files changed, 68 insertions(+), 34 deletions(-)
>
> --
> Chuck Lever
>
