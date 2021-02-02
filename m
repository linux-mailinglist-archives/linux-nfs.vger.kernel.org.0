Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31D430BE1F
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhBBMZy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 07:25:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbhBBMZw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 07:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612268666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2APPd6PT1dSsotaKlQpE6S+KKlhsHFzpOR7YBRtpJ+M=;
        b=NuZeI6z0SkUGkWup8P5BVKDpn76Jknv97sW+eINHNSUKUG/2LhWVc2pE/4C6uLpWAsn2WZ
        H14w5rFYkO70F07a7uDs2f/xbAIUoWnw6CGklwlWB8hoXT3qJCKvTfFy2FnFPNEdKxd38L
        1FzZeu3dm+SxAFMMXSQGc8RwW1704Xc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-JGhVpcasO2SMFKpHCfMMNg-1; Tue, 02 Feb 2021 07:24:24 -0500
X-MC-Unique: JGhVpcasO2SMFKpHCfMMNg-1
Received: by mail-ej1-f69.google.com with SMTP id f26so9884724ejy.9
        for <linux-nfs@vger.kernel.org>; Tue, 02 Feb 2021 04:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2APPd6PT1dSsotaKlQpE6S+KKlhsHFzpOR7YBRtpJ+M=;
        b=lUFf+NEeFvXk+utcvvIolMG1IxVIqGt9gCqwPEmpO+43GSXc2gSsJLgwFUXOw6NunV
         +kXSqZpIGEawQsXY9V02RXj68XAn3w22g6BtNRX0VE1Purw/W8WldDktFlnujDZpZ1bP
         AfTrhB/8NWAb8L9nDBVg+7JDB+lChDQs7FOml71Sd/WJY3sPcJmAJk+kOsApFg3l+H7E
         nniKCShEMBjSzkzBlopVl1ifbaXc5/+wCJau2tRND8XrVGXk6O4d6BqobyGRQoV0M+xN
         JhEZjrt5Y8FQTLnkTEhlxsenQ7hSEa9onUeM2OCAxOzcbryRab4KvgnO016KFRdz2nLZ
         Mtbg==
X-Gm-Message-State: AOAM531AKkxOJbnbOzkeGxUmEmQSDMPv1GGKp3q1JARS1L+zisjdlUpl
        hA3Cs2HCmp1UXbY7Y4nIIlK3Bmf3QjpXbMJEg6WLjM2DP1ssQm5SJlPx/V+cn5fk5SbA+53xiHI
        ecSzdzi8UN6AbNiM4zyAVg5MWdTgTqz67whQq
X-Received: by 2002:aa7:d15a:: with SMTP id r26mr12376469edo.29.1612268663492;
        Tue, 02 Feb 2021 04:24:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0q1gvorprfHpPTTeeKZv6UHzMriQobAfBnZ6uzTyXmDcpqloa+QqFVSEva/kkgIqv25thm9NhMbkYfWq40n0=
X-Received: by 2002:aa7:d15a:: with SMTP id r26mr12376461edo.29.1612268663371;
 Tue, 02 Feb 2021 04:24:23 -0800 (PST)
MIME-Version: 1.0
References: <YBjnktMpSchbnnJc@mwanda>
In-Reply-To: <YBjnktMpSchbnnJc@mwanda>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 2 Feb 2021 07:23:47 -0500
Message-ID: <CALF+zOniMjjSCzdh3nLxq9YSbB9Ji7GLA=qRVgVvm2cTRWnkaQ@mail.gmail.com>
Subject: Re: [bug report] NFS: Convert to the netfs API and nfs_readpage to
 use netfs_readpage
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 2, 2021 at 12:48 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Dave Wysochanski,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch bc6d7b12e4ea: "NFS: Convert to the netfs API and
> nfs_readpage to use netfs_readpage" from Nov 14, 2020, leads to the
> following Smatch complaint:
>
>     fs/nfs/read.c:365 nfs_readpage()
>     error: we previously assumed 'file' could be null (see line 356)
>
> fs/nfs/read.c
>    355
>    356          if (file == NULL) {
>                     ^^^^^^^^^^^^
> "file" is NULL here
>
>    357                  ret = -EBADF;
>    358                  desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
>    359                  if (desc.ctx == NULL)
>    360                          goto out_unlock;
>    361          } else
>    362                  desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
>    363
>    364          if (!IS_SYNC(inode)) {
>    365                  ret = nfs_readpage_from_fscache(file, page, &desc);
>                                                         ^^^^
> Unchecked dereference inside function call.
>

Thanks for flagging this.

I confess I don't understand why we could get file == NULL in
nfs_readpage() but I'm looking into it.


>    366                  if (ret == 0)
>    367                          goto out;
>
> regards,
> dan carpenter
>

