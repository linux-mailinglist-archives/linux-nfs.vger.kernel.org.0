Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95E71DBC47
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 20:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgETSGG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 14:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETSGG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 May 2020 14:06:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADFCC061A0E
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 11:06:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h17so4087537wrc.8
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ICtwmoab4OqFkpnG50FIJtREz2iMBRqyrRyYfiGWmhE=;
        b=IebQLnuSdnIPSQC77mlZhUVk8TLOZqCKudST6sZnoEXeGRSMJNA3eOhDnOZPbawNHh
         BCkaVEkbolYQ3dk5aOSIZ95hrh+ZfTtnGmzeOM/wgsT23eHxw/9HuebwAd/rY2iSx1io
         fK9WobZekShxlymeDmuOIwLX8YUctaahRWSRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ICtwmoab4OqFkpnG50FIJtREz2iMBRqyrRyYfiGWmhE=;
        b=S2hInxFn0/snOhjoh02ibZHAIgLxgV2P7UB/CpDnOq4wUoXCkAyi8icFaeVTkm5D0f
         iTw7SWwvBeGrQ3IQMS/2gaRsoB4l6K33zPU970dyZ7Mwij0oHzrbUt091PXT8t/nXtPO
         U+YcLJHzHJiiP+Q0KUVKcGAjuDRR2K8CwlWobl8bgSOUL+QglCVwokSDj9T19DVgY7sp
         CF4HDR70XiXiC0hY56BMN+Wva0W9aEWrYPqplT4jmsCKvS6SR6B5ipOGRG0wAfLE008/
         KlfThD6RH63zDjxSZVPyYoraq7o0gosqfBkgEevcHId8LahYKvrOSirSoqSUSzw9Sgb3
         BUWA==
X-Gm-Message-State: AOAM530vMR5opromj69G9Ie4iV4WMD3ELmvyGnw3iAmfIvLkQwwkPK8n
        EKoo21Suh8xFnU/lrzq+cAKu0+wYvJA=
X-Google-Smtp-Source: ABdhPJysN53vq2tmQMWqei9SxgrQbCWsk9S/G93fjf3QzMEX4kOg6OwXYbMqbT8Q+OUFzmw+XpsbuQ==
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr5105206wrm.404.1589997964353;
        Wed, 20 May 2020 11:06:04 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id j190sm3934172wmb.33.2020.05.20.11.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:06:03 -0700 (PDT)
Message-ID: <34c2810e78b6053b23f4d40c981d5609977e262d.camel@linuxfoundation.org>
Subject: Re: TEST_STATEID issues with NFS4.1 and FreeNAS server
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc:     "mhalstead@linuxfoundation.org" <mhalstead@linuxfoundation.org>
Date:   Wed, 20 May 2020 19:06:02 +0100
In-Reply-To: <6e7c1125fb5533d1fad5d8b9130761df0fdf3516.camel@hammerspace.com>
References: <09ad6e031e64820f2efd7495d7467e2bb8b51fc5.camel@linuxfoundation.org>
         <6e7c1125fb5533d1fad5d8b9130761df0fdf3516.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2020-05-20 at 18:01 +0000, Trond Myklebust wrote:
> Hi Richard,
> 
> On Wed, 2020-05-20 at 18:47 +0100, Richard Purdie wrote:
> > Hi,
> > 
> > We have a cluster of machines where we're observing file accesses
> > hanging over NFS. The clients showing the problems are Fedora and
> > SUSE
> > distros with the 5.6.11 kernel, e.g.:
> > 
> > Linux version 5.6.11-1-default (geeko@buildhost) (gcc version 9.3.1
> > 20200406 
> > [revision 6db837a5288ee3ca5ec504fbd5a765817e556ac2] (SUSE Linux)) 
> > #1 SMP Wed May 6 10:42:09 UTC 2020 (91c024a)
> > 
> > In the example below we see a git clone hang, its having trouble
> > reading a .pack file off the NFS share, the git process is in D
> > state.
> > I've included part of dmesg below with sysrq-w output.
> > 
> > Mount options:
> > 
> > rw,relatime,vers=4.1,rsize=131072,wsize=131072,namlen=255,hard,proto=
> > tcp,timeo=600,retrans=2,sec=sys,local_lock=none
> > 
> > mountstats shows:
> >  
> > READ:
> > 	632014263 ops (62%) 	629809108 errors (99%) 
> > TEST_STATEID:
> >  	363257078 ops (36%) 	363257078 errors (100%)
> > 
> > which is a clue on what is happening. I grabbed some data with
> > tcpdump
> > and it shows the READ getting NFS4ERR_BAD_STATEID, there is then a
> > TEST_STATEID which gets NFS4ERR_NOTSUPP. This repeats infinitely in a
> > loop.
> > 
> > The server is FreeNAS11.3 which does not have:
> > https://github.com/HardenedBSD/hardenedBSD-stable/commit/63f6f19b0756b18f2e68d82cbe037f21f9a8c500
> > applied so it will return NFS4ERR_NOTSUPP to TEST_STATEID.
> > 
> > I think something may be needed to stop Linux getting into an
> > infinite
> > loop with this, regardless of whether the spec says TEST_STATEID can
> > get a NFS4ERR_NOTSUPP or not?
> > 
> > I freely admit I know little about much of this so I'm open to
> > pointers. If we did remount as 4.0 we probably wouldn't see the issue
> > as it would avoid the TEST_STATEID code.
> 
> TEST_STATEID is listed in RFC5661 Section 17 as REQUIRED to implement
> for NFSv4.1. We will not be able to support a server that violates that
> requirement.

Understood, I suspected as much.

Locking systems into an infinite loop doesn't seem like a good user
experience though. Is there a way to handle that more gracefully?

Cheers,

Richard


