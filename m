Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616AC347F5D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 18:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhCXRat (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbhCXRaN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Mar 2021 13:30:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B87C061763
        for <linux-nfs@vger.kernel.org>; Wed, 24 Mar 2021 10:30:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u21so16253059ejo.13
        for <linux-nfs@vger.kernel.org>; Wed, 24 Mar 2021 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzloVD6BI47C/aIBi/IVO0ANOr9GGQH9RlcCRkBuN0g=;
        b=rO0S7X650d+9DuBA4pjNvCinEFDZ8JLR6sjcLxpCdZIWSHxIJvZ0XbhEQR/O4oPMaB
         UuxwqA8RCzArJF12xShM4iXJL/oZ0lhQQqccrkIhij9t4G/kYODlg7h8qQ4toEHYmF+m
         k4I0xmEqJVj3ufgIClyR5t9iKHvRtRbaGffdrqolbuuoc0ruIf0Hgl26nJilxCDIRvzM
         is1blqg5Q9RqAQUZpze29+nuTMzsQksznEbKdH8I+BclyLC/304ORID66V62tONs7YuD
         uZjISaduXQ4cgyshWApG5IfnIzJcRcqKihC0EtglfJ/hDfWRPcHM8E7MOfPWmH7CG/QY
         OhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzloVD6BI47C/aIBi/IVO0ANOr9GGQH9RlcCRkBuN0g=;
        b=bx70sq7BZHwKhO4lMZcVNadtV5wsuejdT3DFZ5cS0p8SfYrBZ+pH8AHg4nU57bmPZp
         awDLJXKzrpECguM9D2Hs9tshrtdZYns6TjS0PulNXyA0+3mWc0clK1v8CdZcBZo7nII9
         q6rXQYCEbCjMpNxoBehTCVxhNCW1pVwWuOstqbeO7S9IiN4hGvnQc1Xaw58GsJNaKVnl
         IE4ORZSHA6FNZeYfgnX9ZHcolUoyEGDtaYeTcOZM6bNFftanobSuwXow62CaWGGVkzQT
         CRdrC4jkE0ZLSB7/C8uuHY5ick6loUJGlT2ePUt2Qo3NI8ZQCCJN7gQ18KjHHYzeJ3Cj
         SdZg==
X-Gm-Message-State: AOAM531Xiwc+G8AeHtRN8IJcajb0TVKiLPXrZ7s/Cu6TRopIRinusjm/
        zJY14qHWL/oQiwoegRfVTNg9XYZjS6/XfNydeWA=
X-Google-Smtp-Source: ABdhPJxQSzl6OOzTWc/Wp2u1+s6P2neUtLg+PmTgVXR3vgmPNgRksWqmWJ189Z9RosfEh6HmsCouiRtutDm5/mbemH4=
X-Received: by 2002:a17:907:62a7:: with SMTP id nd39mr4926029ejc.510.1616607011254;
 Wed, 24 Mar 2021 10:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
In-Reply-To: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 24 Mar 2021 13:29:59 -0400
Message-ID: <CAN-5tyFvHN_OHr20cJpE6Y5OATxLkm=OVHLnUpZ3zDh_6yBXCw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] SUNRPC: Create sysfs files for changing IP address
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 12, 2021 at 4:19 PM <schumaker.anna@gmail.com> wrote:
>
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> It's possible for an NFS server to go down but come back up with a
> different IP address. These patches provide a way for administrators to
> handle this issue by providing a new IP address for xprt sockets to
> connect to.
>
> Chuck has suggested some ideas for future work that could also use this
> interface, such as:
> - srcaddr: To move between network devices on the client
> - type: "tcp", "rdma", "local"
> - bound: 0 for autobind, or the result of the most recent rpcbind query
> - connected: either true or false
> - last: read-only timestamp of the last operation to use the transport
> - device: A symlink to the physical network device
>
> Changes in v3:
> - Rename functions and objects to make future expansion easier
> - Put files under /sys/kernel/sunrpc/client/ instead of
>   /sys/kernel/sunrpc/net/, again for future expansions
> - Clean up use of WARN_ON_ONCE() in xs_connect()
> - Fix up locking, reference counting, and RCU usage
> - Unconditionally create files so userspace tools don't need to guess
>   what is supported (We return an error message now instead)
>
> Changes in v2:
> - Put files under /sys/kernel/sunrpc/ instead of /sys/net/sunrpc/
> - Rename file from "address" to "dstaddr"
>
> Thoughts?

Reviewed-by/Tested-by this version. Works OK for me.

I would like to note that the interface doesn't or rather perhaps
cannot do any error checking. So if the "user" were to echo a
nonsensical data into the sysfs (echo foobar > <sysfspath>), that
breaks the existing connection. However, if a proper IP were to be
entered to correct it, things will go back to normal.

> Anna
>
>
> Anna Schumaker (5):
>   sunrpc: Create a sunrpc directory under /sys/kernel/
>   sunrpc: Create a client/ subdirectory in the sunrpc sysfs
>   sunrpc: Create per-rpc_clnt sysfs kobjects
>   sunrpc: Prepare xs_connect() for taking NULL tasks
>   sunrpc: Create a per-rpc_clnt file for managing the destination IP
>     address
>
>  include/linux/sunrpc/clnt.h |   1 +
>  net/sunrpc/Makefile         |   2 +-
>  net/sunrpc/clnt.c           |   5 +
>  net/sunrpc/sunrpc_syms.c    |   8 ++
>  net/sunrpc/sysfs.c          | 191 ++++++++++++++++++++++++++++++++++++
>  net/sunrpc/sysfs.h          |  20 ++++
>  net/sunrpc/xprtsock.c       |   2 +-
>  7 files changed, 227 insertions(+), 2 deletions(-)
>  create mode 100644 net/sunrpc/sysfs.c
>  create mode 100644 net/sunrpc/sysfs.h
>
> --
> 2.29.2
>
