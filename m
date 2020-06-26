Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C757320ACDE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 09:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgFZHRO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 03:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgFZHRN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 03:17:13 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899B8C08C5DB
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 00:17:13 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d15so6106573edm.10
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j2FC27MBBGa0/xsyI8Up7exypmUEz8tF6/l3prA2KqQ=;
        b=lx5NuSPv6MNsQp3ZHF9kln+kfUIuHEIMMG4ywIOOT2yzmHIkjAV1WrW45vbOmz8U//
         twaL4xtau+CNzk6GZEBD58GC6r814qC2JrWEja0hhqxOpHlhSDEiUJrNLGI/n8cucurH
         0LWJwIAOxGDYnWB3izLPWPN7KxMHKRUEVVZ3dFox4sFgtkHTFbLnkBRvGf0VQg08Gsin
         2eouwZ9YoblwUYdiO7T7QT4sqV++fnEDHKOX7Y8tO84N1v5t7OLirGJo3VUS9KZg21pf
         +tEYe/fzno/NIbGJesrZqI3JttkI0kG01ftpph8iIZUsXFBhcX/gjFRgpFFUcwPeH3oI
         vVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j2FC27MBBGa0/xsyI8Up7exypmUEz8tF6/l3prA2KqQ=;
        b=PsqreEkf4799olBJZCw557IE80Ld1S7PJDIlkgFBFb4k+9T3JLu6FV6LqYrjoARk3y
         0yN0+Qs+uqeAaU0ED+SrIVgMMIF+4VZvUE0jrBq5FspgIfMrbvTdooDzhNh3XACiTUpt
         rxObpRfCQv+4e9wGmM8GC1LwXfdU3F5XwdUdNtckJOdZq88zsrtmr5Jnh0aw6CJh+TDQ
         BQ3WVeqMiNAy33jUeEpPThTkMW8as3sA8Wc4HfPdalg2sUcrCtoAMYjZTwQkasRkn2UX
         XfUZ96cEguD+aENd21ZYXfEvypQnsSllRu1D9sc+6dH2Ti0kiNvI4qiQwt0d5/e9rRfK
         892w==
X-Gm-Message-State: AOAM532r4itVWLhfqE7BhoXfmxvj0szz5JCY0SRFotm4nY3CK9+KT4Id
        FUy++d92gaMnt3Uk143qyMJKTA==
X-Google-Smtp-Source: ABdhPJwglpoPiZfP1P4R4TPz3WwcXatVfOyQ0a034zt3lXitShVmRi1a93cCzAcRh7cJMjTYeNLINg==
X-Received: by 2002:aa7:d692:: with SMTP id d18mr151293edr.73.1593155832148;
        Fri, 26 Jun 2020 00:17:12 -0700 (PDT)
Received: from gmail.com ([141.226.169.176])
        by smtp.gmail.com with ESMTPSA id r6sm20485966edx.83.2020.06.26.00.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:17:11 -0700 (PDT)
Date:   Fri, 26 Jun 2020 10:17:08 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] xprtrdma: Ensure connect worker is awoken after connect
 error
Message-ID: <20200626071708.ppfgasctnfqrlglx@gmail.com>
References: <20200621145934.4069.31886.stgit@manet.1015granger.net>
 <0E2AA9D9-2503-462C-952D-FC0DD5111BD1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E2AA9D9-2503-462C-952D-FC0DD5111BD1@oracle.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 25, 2020 at 03:19:39PM -0400, Chuck Lever wrote:
> Anna, please drop this one. It appears to trigger a particularly nasty
> use-after-free. I'll follow up with a more complete fix soon.
> 
> (Yes, a wake-up on connect errors is indeed necessary... but the connect
> worker needs to be re-organized to deal properly with it).

After sending that patch I also noticed more issues with the management
of the EP context. The decref inside the CM handler caused freeing of
the EP while connect path still held a reference to it. A KASAN-enabled
kernel revealed this easily. I've sent just now a more comprehensive
patch to deal with this.

-- 
Dan Aloni
