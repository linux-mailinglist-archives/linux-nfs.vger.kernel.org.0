Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C543C30CA93
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 19:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbhBBSyL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 13:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbhBBSxJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 13:53:09 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FCDC06174A
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 10:52:28 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w1so31557767ejf.11
        for <linux-nfs@vger.kernel.org>; Tue, 02 Feb 2021 10:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQPbkej7XcLGbeGWq2tIkGYl9st7pwxv867zteDGzuA=;
        b=pDMXQonMauO0+k8LnLFafpO0z59c5nepQcISMRHPmJpImktnPIyg+j7TQIh7S+zOge
         48rm6XGPIFWrZt3jwzkL4TNrsALqd7NWcgXSQu7lsuv2EsecIIz8Q/FciuNvzHSI+ZvS
         pFAJSOT2YRIqZkaKtOzycD9w/N9onf1RTI/+pjtY1WbnOMA+dsf+QCp77+JqA+onJ7pe
         yfQCNomEKlhq7ta79qbcDCRXtt85somDOS4Gsz61OAt50V3NN1dR6/b3pzTYkJkMx7S1
         hkaQWbB+bGpFrvqrZYrPxphzfJ+MFwAN18X4Er/JdiQ7MyTUFqFgBMGhQQ77KE3hen9K
         rFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQPbkej7XcLGbeGWq2tIkGYl9st7pwxv867zteDGzuA=;
        b=kNJMWUuA1QK9R+2dexOooYcZzxi5fHO/e3c7pzgeeBvtCdq6P17xgLi8YcyK6uQLAA
         Q5WaLZ9NhSUsgAMoSDbxOwvCQ+88StKNcOLiwWbEZYs8R5kDWuIgeEbQfcU9kyIuofmw
         aOqXSV+uXfufKAs6+N1IQ00k80IGCPIFM8PSecfA7r6HoKreSANhNqm00sxe0bbhAE3I
         YSEEbHEDB75l5MvtJFo9N4hc3e9D5RvmlFBdjG1KnxuQS0rfopPK31/u4uopkWRg2Bx8
         /dlqsVHWZRXQav6k1ux3n9KtA/ftH2AUpuFXFLURYuKSJty+d7xfRSXDN7hGtyzL7pzY
         BfDQ==
X-Gm-Message-State: AOAM53164hDP7XEQr4/9I2cbOsVFHKoyDoWSQ8YL/SBp3NkcbrOaXoWr
        cFhaTCSNwXBfjcLbA1ifM0gYlWUj2Gjc2pgBp+E=
X-Google-Smtp-Source: ABdhPJxjamK1MrtISLcR7q2tuD2Pcyy9TreicFeN1wNYkesiC+JEp/CwJlDgzstevF6ojIxTRh/+beTxdfBvsBXJmAE=
X-Received: by 2002:a17:906:980b:: with SMTP id lm11mr725317ejb.46.1612291947109;
 Tue, 02 Feb 2021 10:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com> <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
In-Reply-To: <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 2 Feb 2021 13:52:10 -0500
Message-ID: <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dan Aloni <dan@kernelim.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

You're welcome! I'll try to remember to CC him on future versions

On Tue, Feb 2, 2021 at 1:51 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> I want to ensure Dan is aware of this work. Thanks for posting, Anna!
>
> > On Feb 2, 2021, at 1:42 PM, schumaker.anna@gmail.com wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > It's possible for an NFS server to go down but come back up with a
> > different IP address. These patches provide a way for administrators to
> > handle this issue by providing a new IP address for xprt sockets to
> > connect to.
> >
> > Chuck has suggested some ideas for future work that could also use this
> > interface, such as:
> > - srcaddr: To move between network devices on the client
> > - type: "tcp", "rdma", "local"
> > - bound: 0 for autobind, or the result of the most recent rpcbind query
> > - connected: either true or false
> > - last: read-only timestamp of the last operation to use the transport
> > - device: A symlink to the physical network device
> >
> > Changes in v2:
> > - Put files under /sys/kernel/sunrpc/ instead of /sys/net/sunrpc/
> > - Rename file from "address" to "dstaddr"
> >
> > Thoughts?
> > Anna
> >
> >
> > Anna Schumaker (5):
> >  sunrpc: Create a sunrpc directory under /sys/kernel/
> >  sunrpc: Create a net/ subdirectory in the sunrpc sysfs
> >  sunrpc: Create per-rpc_clnt sysfs kobjects
> >  sunrpc: Prepare xs_connect() for taking NULL tasks
> >  sunrpc: Create a per-rpc_clnt file for managing the destination IP
> >    address
> >
> > include/linux/sunrpc/clnt.h |   1 +
> > net/sunrpc/Makefile         |   2 +-
> > net/sunrpc/clnt.c           |   5 ++
> > net/sunrpc/sunrpc_syms.c    |   8 ++
> > net/sunrpc/sysfs.c          | 168 ++++++++++++++++++++++++++++++++++++
> > net/sunrpc/sysfs.h          |  22 +++++
> > net/sunrpc/xprtsock.c       |   3 +-
> > 7 files changed, 207 insertions(+), 2 deletions(-)
> > create mode 100644 net/sunrpc/sysfs.c
> > create mode 100644 net/sunrpc/sysfs.h
> >
> > --
> > 2.29.2
> >
>
> --
> Chuck Lever
>
>
>
