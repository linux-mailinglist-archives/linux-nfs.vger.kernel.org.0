Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A909D2CC63B
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Dec 2020 20:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbgLBTIs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Dec 2020 14:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLBTIs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Dec 2020 14:08:48 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D69C0613D4
        for <linux-nfs@vger.kernel.org>; Wed,  2 Dec 2020 11:08:08 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id n132so2333588qke.1
        for <linux-nfs@vger.kernel.org>; Wed, 02 Dec 2020 11:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YlUELotyCvnMxSnq1o+EsKxU0fx3VVmwvrBHZRhJ5bw=;
        b=KHfm9OnZHE7dgn18Z1ESocwAOFgemT0Ql5UqrMevwBXMJTSjxWnSW5t6YrAl29ay6k
         kwbfewxQbTOHrUCfkq4g1r6xRnpChItuLgbC4e5IsHGlo/GPuJcQemEapAmK6tnppjcQ
         F7rCKHTBBsIHC8UlhXripuO8deo68FRT+hpn/ERy3WFCUg5pzrkQI2PdT3mHS6h9uRy0
         E1svU5S6LDe4s1FOabWd2hMzW+V6AMtkTRDFH1b3tCTw2vjZxrtt4/Tjqv9J7J7PEczZ
         GLZJXt6T8CjY1nDHF8ppWIhesiKmC2Arahbf64iCaD/6JEOfSsdKR/s8N3+Xqdp5DWSt
         Gf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YlUELotyCvnMxSnq1o+EsKxU0fx3VVmwvrBHZRhJ5bw=;
        b=QiRw5V03O4eVXR3kjEzuenZn/LXcZXlUlrOu/WyznLFIOiNYtx8yqLPbgm59f+VXvR
         f5F4UCe+kRmDQ/XIMizZijNOJ0l6B1Gb/vsAu/uFpAJPXg0AO2XjRshMB5NsfRsmXSjP
         n1lLJrRlBBad7pHFprTPybW+B+e3CbXEhrO8ToG1Y5dEKWyILEwW1B5tX9N2KzU7Ua9O
         3X1Ym4PR8U4uQDwOAjGPB4k5o1UPgt/U18XP8gR2538oeJwu2JBeE5oq7L1JcKN2/0Ce
         Yhz1NZcY0/5lu94uCqBi11lLYjtVQDHgcw4+4W7KHLwssdJgZtNUuPgspNkbe/RGcara
         axtA==
X-Gm-Message-State: AOAM533+GuaQ+xAR38Y6Ygui1Pop6P440t8ZB0SIFDZsEr8EOBbNC9+r
        COLEQXrdU9cDOjTl9p0d4BM=
X-Google-Smtp-Source: ABdhPJwlYs3Mcr/Mqd5tiNcpttl4es5XbFS0Hzl5dsvNHcRMpjEi7Yo0TiXgaQATHHzMq75AJK7IHg==
X-Received: by 2002:a05:620a:148c:: with SMTP id w12mr3985986qkj.311.1606936087252;
        Wed, 02 Dec 2020 11:08:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id m54sm2885051qtc.29.2020.12.02.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:08:06 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 14:07:37 -0500
From:   TJ <tj@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: switch nfsiod to be an UNBOUND workqueue.
Message-ID: <X8fl+cW4n0wlGkIn@mtj.duckdns.org>
References: <87sg9or794.fsf@notabene.neil.brown.name>
 <37ec02047951a5d61cf9f9f5b4dc7151cd877772.camel@hammerspace.com>
 <87k0uzqqn7.fsf@notabene.neil.brown.name>
 <87pn3zlk8u.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn3zlk8u.fsf@notabene.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 27, 2020 at 11:24:33AM +1100, NeilBrown wrote:
> 
> nfsiod is currently a concurrency-managed workqueue (CMWQ).
> This means that workitems scheduled to nfsiod on a given CPU are queued
> behind all other work items queued on any CMWQ on the same CPU.  This
> can introduce unexpected latency.
> 
> Occaionally nfsiod can even cause excessive latency.  If the work item
> to complete a CLOSE request calls the final iput() on an inode, the
> address_space of that inode will be dismantled.  This takes time
> proportional to the number of in-memory pages, which on a large host
> working on large files (e.g..  5TB), can be a large number of pages
> resulting in a noticable number of seconds.
> 
> We can avoid these latency problems by switching nfsiod to WQ_UNBOUND.
> This causes each concurrent work item to gets a dedicated thread which
> can be scheduled to an idle CPU.
> 
> There is precedent for this as several other filesystems use WQ_UNBOUND
> workqueue for handling various async events.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
