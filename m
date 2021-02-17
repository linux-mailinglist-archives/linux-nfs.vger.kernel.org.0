Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9857D31DF4D
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Feb 2021 20:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBQS7m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Feb 2021 13:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBQS7l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Feb 2021 13:59:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB55C061756
        for <linux-nfs@vger.kernel.org>; Wed, 17 Feb 2021 10:59:01 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jt13so24175823ejb.0
        for <linux-nfs@vger.kernel.org>; Wed, 17 Feb 2021 10:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lc1q8BQDuGZDEMZA6sjED4s1vrSqwOqFUR6nZqDvdbE=;
        b=dw1B1YmDDvDWZFOF7ZrDUljIYxdf72kTCVXt7UCzo+NNtOV5TquUDKM+bt5NrjAoRV
         r06+2u1T2EESz2siB7oYZmyARA79rz+lPeycO9gElPNKu9UYa/q6L6m4uODRkPfastmC
         X+TZUFWjyOjM/P4kiE2bLRxJW+L9cNT9kwNT0mxDN7cdGRhDyzN1wMhZ19RuOPw/mgOh
         j/gcFBFejI4Vom0KPxg5qYpplIJ/psA/pIQNXC4Msf9IqsKtDTYZrN9cJeqExeWOHv7Y
         8fnIyamEDxJE3XBatb+2sP8z/cCs+yrJE7X6mpj9ZHaHenu+pjy8ywdt17nQzRzscChJ
         oIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lc1q8BQDuGZDEMZA6sjED4s1vrSqwOqFUR6nZqDvdbE=;
        b=BYVFQwtm66qaO9DlBlQykWyBR1AHb7VysY/BJCugfIppAtB/IunpKQN6HC3ZOWpEhy
         dwcfP7EYPLj3lV1xy8jkTcN8f4bcP9k/GZhXqtOHuGVLoydDOWxT2226oeJhh0YLMWGV
         +OibY8keQnJxU9tHITv7khytyANX02KzutWqTc85ZNAHo1tFqlXhzO9tGWcMPPggDbaM
         GwS09FqkCbEccTjoFztMg3FZZtGMFQGxpqDAeaeWqcj7bFjFkDFmrs2hSzuSV5/De5A/
         WYlTPxRfiFVOhJ4RA6XvmXjF5H3O34yNdpc7MWZq3bC5VVEbxq7owAUShT4OCZP1F28e
         r25w==
X-Gm-Message-State: AOAM532feN4KMfSYVkCVBcXSeIN10n0aL1Si+kOkSCjG0HEp347pY6K6
        VUiSzLxZGs9v5CbMZX0xgRSoNg==
X-Google-Smtp-Source: ABdhPJxHwjuzHCdV5mV6usnESL1+iPEF93rWHcMrS03mOjDlwkNXcMbmMy8DCtwhb3XYkQS6uc8dBQ==
X-Received: by 2002:a17:906:4e0f:: with SMTP id z15mr365199eju.199.1613588340541;
        Wed, 17 Feb 2021 10:59:00 -0800 (PST)
Received: from gmail.com ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id b4sm1702010edh.40.2021.02.17.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 10:58:59 -0800 (PST)
Date:   Wed, 17 Feb 2021 20:58:56 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH v1 1/8] sunrpc: rename 'net' to 'client'
Message-ID: <20210217185856.guvws6rdakoqr46h@gmail.com>
References: <20210215174002.2376333-1-dan@kernelim.com>
 <20210215174002.2376333-2-dan@kernelim.com>
 <CAFX2JfkPRQ0o2BXgUhO+LEB6SBpUF5nivwAXQz5VAoH6iVTVXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2JfkPRQ0o2BXgUhO+LEB6SBpUF5nivwAXQz5VAoH6iVTVXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 16, 2021 at 04:24:41PM -0500, Anna Schumaker wrote:
> Hi Dan,
> 
> On Mon, Feb 15, 2021 at 12:42 PM Dan Aloni <dan@kernelim.com> wrote:
> >
> > This is in preparation to adding a second directory to keep track
> > of each transport.
> 
> I initially named the directory "net" to match how NFS's sysfs
> directories are created (/sys/fs/nfs/net). If naming it "client" makes
> more sense then I should probably introduce it that way in my patches.
> 
> Thoughts?

We can keep the "net" directory under "sunrpc" and have the three
directories under it, i.e:

     /sys/kernel/sunrpc/net/client
     /sys/kernel/sunrpc/net/transport
     /sys/kernel/sunrpc/net/multipath

It works for me too, but I no preference either way.

-- 
Dan Aloni
