Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4382130CB80
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 20:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbhBBT0b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 14:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbhBBTYi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 14:24:38 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E1C06178A
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 11:24:23 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hs11so31766805ejc.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Feb 2021 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RJtHSeIHAk9UiRF5iKTeQMk8lt8UNWuE3qFDYKhSsAk=;
        b=E5GcXEkLSnfljcR6Q6/249FEp+hVrcCEo4O6hyU7JSrU6DMEPnRnnHDKjDKCOEE2ZQ
         kqN+Jt3+qXamCvjN1tZu9tuk02DIoRGmn9CS4WLeq99D0Bw48YUL1UdoT85SzxVWEZAR
         qlcOmRThYyhGOpe7oGjaOHdoR4LFBt0XzS6BMpZWBHkbHANW/uFiJUBbSIB52fKX1b+g
         yWI/igWg5LZU3EtsOsZamhQ6SjCAlTNt54kobohYVBgLiDBosMOPcyzOhEEMTyZgGza1
         McbelorBIr+0M9TdGA5GoC1Jymxx6+zkI+MJ9EdsO9qqH2+ksV8dQE+haGbd+Kq5Usxb
         QnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RJtHSeIHAk9UiRF5iKTeQMk8lt8UNWuE3qFDYKhSsAk=;
        b=myjVWL7TIKTdu5mavHnXJODAZP0/17UD0f6Lc2enuOmvvdiukoCphS0lA6Pedllfw7
         +P5BzAZSrbmUNYucIJMfB1uAtWg83tjlhYraPkAZ1T+b/y4ecTGoHDhe6GHKJ+R5cBi2
         7gxPr7ziKnA14zOLCaJ02dFlx1DcPm24lRc76/m0Vg24gmWhnSjW65h/SydsX9x67zcW
         8sgvOftAMDoGLdnGSFbeaZZUpIPMFDjtTlDMgwPWfpJYMFi6tlYWopQpDddsPmI5Ldv4
         D9WTFMIvYW1PpwDoiQccZVFzvKAzyLjxVOs/gUHJl5i4fo6dmVzbJmkDS+HjUOOUe4yi
         ykGQ==
X-Gm-Message-State: AOAM531sNDDocB13vhOgeYoj6iebHzqwG5RD63alpaTigvFukd/dx4y0
        1AWVtMwq7GqUQKG6xf//n/DNVQ==
X-Google-Smtp-Source: ABdhPJxZx1dVUQUL4SEqfiCOEgXhtmpF9o+sTm3PHHVWYwhFoDeh6BcXlUZn6cc044BBTo5PhNWUdA==
X-Received: by 2002:a17:906:d93:: with SMTP id m19mr10142709eji.212.1612293861944;
        Tue, 02 Feb 2021 11:24:21 -0800 (PST)
Received: from gmail.com ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id bn2sm2476334ejb.35.2021.02.02.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 11:24:20 -0800 (PST)
Date:   Tue, 2 Feb 2021 21:24:17 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Message-ID: <20210202192417.ug32gmuc2uciik54@gmail.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
 <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
 <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 02, 2021 at 01:52:10PM -0500, Anna Schumaker wrote:
> You're welcome! I'll try to remember to CC him on future versions
> On Tue, Feb 2, 2021 at 1:51 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > I want to ensure Dan is aware of this work. Thanks for posting, Anna!

Thanks Anna and Chuck. I'm accessing and monitoring the mailing list via
NNTP and I'm also on #linux-nfs for chatting (da-x).

I see srcaddr was already discussed, so the patches I'm planning to send
next will be based on the latest version of your patchset and concern
multipath.

What I'm going for is the following:

- Expose transports that are reachable from xprtmultipath. Each in its
  own sub-directory, with an interface and status representation similar
  to the top directory.
- A way to add/remove transports.
- Inspiration for coding this is various other things in the kernel that
  use configfs, perhaps it can be used here too.

Also, what do you think would be a straightforward way for a userspace
program to find what sunrpc client id serves a mountpoint? If we add an
ioctl for the mountdir AFAIK it would be the first one that the NFS
client supports, so I wonder if there's a better interface that can work
for that.

-- 
Dan Aloni
