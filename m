Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7027936A87D
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Apr 2021 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhDYRBV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 25 Apr 2021 13:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhDYRBU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 25 Apr 2021 13:01:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87484C061574
        for <linux-nfs@vger.kernel.org>; Sun, 25 Apr 2021 10:00:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a4so53367747wrr.2
        for <linux-nfs@vger.kernel.org>; Sun, 25 Apr 2021 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HFVx53OhxGghADzfa8tb3cHpkVWY85mpCkjOxCikYvQ=;
        b=eC9h8uES+pVRByWOOEppkkvIktqdQex7g5ryuLfhMS3vIVJyttK3U7H6sS1W6b8Z1A
         SO8wRgnJlDscOjkyT51BpncsNgKq827tWpnjwGLq3LuGtxSR+OHFi+ub3FF1vJzdklyX
         Kf/dQv3yx7U++6QX86n4TVwQf84Rvlo2RIPKmgHOw4HaevdE9yO4S9v4uoMBizuJ2BTn
         yrZUXqpYLuvYSHzKmULXwlanP3WSDZ5uPHmhT+zhAb78vafMDbXlVCiGRLJcuaimrG3i
         MuksJ/Rrft9QtxL1vJbyL5RBOMG7jZtTXkxIuS5N16i+6tKOlptB9g28Vtf4dsL5fBLH
         zc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HFVx53OhxGghADzfa8tb3cHpkVWY85mpCkjOxCikYvQ=;
        b=HobWpG4VkucUayrcjiHP1lq492E7whmuJo7qR1EbiX6WN95Dm67+nw2jJ9TywtdSzi
         G5iJo2f0ObH326NUjIQSZw3dP9j7rDqbgVyZ+JhOgBNhEE+BmNONB7BBDC4XcCoALZ+U
         /NvZjFObth6ShUCwalEWt38jqGkYaAN8C80PSovUFxJkjRYIc9zo42m7+iGA+pDq1M5i
         TNOu5fo3j9+FtseWaOAeJ/D1EcI3L9zjGPmqwHmS7Zfqj+hv2GypMjJJJqyVHT6u1jMF
         slmK7IadILx4LK2NX16k99mknDh/Dstlfkp/oF1MqigCuNwCnehVM3jP/wlMgfA9CU5b
         hkQg==
X-Gm-Message-State: AOAM530iYBSUA08JBniIoQ40SAWodiEovK9q433LW5OOmbY7Q+W3bW0Z
        Zy1nRQpTmS/RodQk+gqElMn3DQ==
X-Google-Smtp-Source: ABdhPJwTdkDk1cXVt1sTdRtN+I9ExjrYDzzC7ubZ76hbJL/tj6Igq6YMonxMqsYjdpszBV8VuX1YSQ==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr17566014wrt.120.1619370039104;
        Sun, 25 Apr 2021 10:00:39 -0700 (PDT)
Received: from gmail.com ([77.126.186.5])
        by smtp.gmail.com with ESMTPSA id p13sm19032781wrt.0.2021.04.25.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 10:00:38 -0700 (PDT)
Date:   Sun, 25 Apr 2021 20:00:34 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 15/26] xprtrdma: Do not recycle MR after
 FastReg/LocalInv flushes
Message-ID: <20210425170034.pxukfflpqtsvu2dq@gmail.com>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
 <161885539285.38598.13978652738422395833.stgit@manet.1015granger.net>
 <20210425141914.6govk2lm2hfosdie@gmail.com>
 <53AD14DC-65A2-4E93-A467-1DE43894DC03@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53AD14DC-65A2-4E93-A467-1DE43894DC03@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Apr 25, 2021 at 04:21:03PM +0000, Chuck Lever III wrote:
> 
> 
> > On Apr 25, 2021, at 10:19 AM, Dan Aloni <dan@kernelim.com> wrote:
> > 
> > On Mon, Apr 19, 2021 at 02:03:12PM -0400, Chuck Lever wrote:
> >> Better not to touch MRs involved in a flush or post error until the
> >> Send and Receive Queues are drained and the transport is fully
> >> quiescent. Simply don't insert such MRs back onto the free list.
> >> They remain on mr_all and will be released when the connection is
> >> torn down.
> >> 
> >> I had thought that recycling would prevent hardware resources from
> >> being tied up for a long time. However, since v5.7, a transport
> >> disconnect destroys the QP and other hardware-owned resources. The
> >> MRs get cleaned up nicely at that point.
> >> 
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Is this a fix for the crash below?
> 
> Yes, it is plausible. That is a familiar backtrace.
> 
> However, it's usually because the provider called the LocalInv
> completion handler twice for the same CQE. Which provider is this?

It's mlx5 driver, ConnectX-4 (MT27700).

-- 
Dan Aloni
