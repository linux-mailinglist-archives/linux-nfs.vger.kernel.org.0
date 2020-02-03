Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9350150994
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgBCPPY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Feb 2020 10:15:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43069 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbgBCPPX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Feb 2020 10:15:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id z9so6454443wrs.10
        for <linux-nfs@vger.kernel.org>; Mon, 03 Feb 2020 07:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36rXG7V8JSpusYt9ntSiPwI5KHRd+Srbx9nxQhGiU2M=;
        b=jKqJA4lX3TJj1xK0Zm6Fz+WEd9URlk+4rY6E2RhHvEc0fqUBtEF7kltqsFTUTa/D06
         O/GPZfz4VJku2XODjJobfiqYjmWhrV8AmnwnWOO3wmD02K72pP9AsBJ21bkmaY8uh6SX
         xV+zP8moPvM/5eQq4q1I7HLTsRyunW78xh8ym/xmprDF18FMdYUYisM5MbL+c1Rqjvni
         VmkHjuSK2PthDKe7UC3m9TitmgXutsK1y05N5QuENoPeyINGEkfgLmNfS7uL0vqVafGK
         MWSiaeJ7BSzNgV/mbK/qBjW8EO7GpODcuL4+dEEgVn7PMTSh6pdfhftA8iPOG5X7vjI8
         jPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36rXG7V8JSpusYt9ntSiPwI5KHRd+Srbx9nxQhGiU2M=;
        b=ApZjznnhyLS3ARffn7v5uGmjH3APJi/e1lDVnhupsdTymNANZ4wx5wgEJWiQ5ntKGo
         thYt22uqhIaJSgeOmtlCly6l3ykkY+9LLE0OCJrPyxKMNAgQzW+CKSV64tX/sWAAHl+I
         eV6zHaHf7cDGzFglYB3owBvJQU/jQ2OMCyk3jBvfsL6pBSXKYt9fZlhE+9LHPUB0deCN
         RNXnPhPmzTEnfYwCgBqfEYPXtkYKFQMqTJaKG/oVKAS5mUvzLzUsCAqZ09xmo+lngx38
         gJpAYP4oSYfAhRLW2NNXoGCdggNeWDyPu+JDBvU62luN0nagu0JeFpkqwv/z2cbuFYNN
         M8lA==
X-Gm-Message-State: APjAAAUBKAStVrDcx/WKvLVC5MDuCWXDSPDQpOMDn3MOwvvypHA4UBkv
        GHDhj3bNQj6WTkxSxFf9mR3j/8OpPDO6vBFO804=
X-Google-Smtp-Source: APXvYqwof0iLrWMR3fGbgpdq2/G13iMUceluAk7O7GCShEwlcO3OFHyj+t4NtfHl5mZZNypQzu/Tk4bYFcOt7Ju6XVk=
X-Received: by 2002:adf:c54e:: with SMTP id s14mr15573493wrf.385.1580742922054;
 Mon, 03 Feb 2020 07:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20200129154703.6204-1-steved@redhat.com>
In-Reply-To: <20200129154703.6204-1-steved@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 3 Feb 2020 10:15:11 -0500
Message-ID: <CAN-5tyF1NUt2emuPGYF+-3s9cJPwox1uoh0uVzxArRJtzPXMTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] manpage: Add a description of the 'nconnect' mount option
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks good but can we add clarification that nconnect is supported for
3.0 and 4.1+?

On Wed, Jan 29, 2020 at 10:47 AM Steve Dickson <steved@redhat.com> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Add a description of the 'nconnect' mount option on the 'nfs' generic
> manpage.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>  utils/mount/nfs.man | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index 6ba9cef..84462cd 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -369,6 +369,23 @@ using an automounter (refer to
>  .BR automount (8)
>  for details).
>  .TP 1.5i
> +.BR nconnect= n
> +When using a connection oriented protocol such as TCP, it may
> +sometimes be advantageous to set up multiple connections between
> +the client and server. For instance, if your clients and/or servers
> +are equipped with multiple network interface cards (NICs), using multiple
> +connections to spread the load may improve overall performance.
> +In such cases, the
> +.BR nconnect
> +option allows the user to specify the number of connections
> +that should be established between the client and server up to
> +a limit of 16.
> +.IP
> +Note that the
> +.BR nconnect
> +option may also be used by some pNFS drivers to decide how many
> +connections to set up to the data servers.
> +.TP 1.5i
>  .BR rdirplus " / " nordirplus
>  Selects whether to use NFS v3 or v4 READDIRPLUS requests.
>  If this option is not specified, the NFS client uses READDIRPLUS requests
> --
> 2.21.1
>
