Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB2342088
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 16:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhCSPHj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhCSPHP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Mar 2021 11:07:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32F2C06174A
        for <linux-nfs@vger.kernel.org>; Fri, 19 Mar 2021 08:07:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id jy13so10232913ejc.2
        for <linux-nfs@vger.kernel.org>; Fri, 19 Mar 2021 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bGD6x0tPecnhinDKnHZu/CdzaVF9l2QBFMD0XEfM6uI=;
        b=aQIC3IO8ekz1FCCQkelvLZnY4qS+9jJQRg2pw4Io5Y0leEYvLhBVWmFmcxZ14TQVA6
         VRTgTB1QYMY5ix3RsYZ3r06KNWaWPDZNnFNLCyguhSJhNsqGGcTfdU+hbDfVnHf1LfJy
         T68fnAxtMO5Rj6VJr0/GHvPEw2DKVASe+9LHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bGD6x0tPecnhinDKnHZu/CdzaVF9l2QBFMD0XEfM6uI=;
        b=qUdwF8RWPiV373vSGzQgkUNf1w4+M/B6/zPGBKZjM7+RO3ErbFzefZSJMLUi84Dxaz
         lMrvBKjgl1ggJQaIeIWQk9RmhanyNX0c5zpJAD9pEqMxZAqxkp9S8DetRHhX/SzIcYzP
         3xuP9EWyO7R6IJaXnqVS6nEDSKG3PUUMXaJBusrTSr4J/MPnUs9ZEOgkzKVF7PNVxzMr
         GQO4RQ6Y5OANfX6a4XKItwyIZ1La+YLjb/TIm2daQk9JdjepXuU+0LM0jvzirEe9cjaJ
         dvLczB1jmZmwMfnf9pyGCRN2UWApIX782oNqrqE9nQc8MlWO/iENFFNcn+p7hMYvZScg
         S39A==
X-Gm-Message-State: AOAM531jkA3KtFvR8kPEFFn6etihit4WxIEPnuAGXlPPusY1yqoGXSmF
        0HCQLUDfkObwkxNZK8bK01vgwg==
X-Google-Smtp-Source: ABdhPJz+lP+srO1DUhiDPl6417LDuRyqXKPV5TLJWUSrcf8gzEjr5zExnXdLwd7rRxpWnazgrRW38Q==
X-Received: by 2002:a17:906:405b:: with SMTP id y27mr4954560ejj.332.1616166433503;
        Fri, 19 Mar 2021 08:07:13 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id e17sm3783613ejb.54.2021.03.19.08.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:07:13 -0700 (PDT)
Date:   Fri, 19 Mar 2021 15:07:12 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux-Net <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] SUNRPC: Output oversized frag reclen as ASCII if
 printable
Message-ID: <YFS+IFFRs5f1itQN@chrisdown.name>
References: <YFS7L4FIQBDtIY9d@chrisdown.name>
 <3844BF67-8820-4D6C-95BA-8BA0B0956BD0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3844BF67-8820-4D6C-95BA-8BA0B0956BD0@oracle.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Chuck,

Thanks for the (very) fast reply! :-)

Chuck Lever III writes:
>> This can be confusing for downstream users, who don't know what messages
>> like "fragment too large: 1195725856" actually mean, or that they
>> indicate some misconfigured infrastructure elsewhere.
>
>One wonders whether that error message is actually useful at all.
>We could, for example, turn this into a tracepoint, or just get
>rid of it.

Indeed, that's also a good outcome. Personally I've never seen these 
legitimately fire in production outside of cases like the one described, and we 
historically ran a pretty diverse set of use cases for NFS.

Maybe safer to convert to a tracepoint just in case? Either way sounds fine 
though -- let me know what you'd like for v2 and I'll send it over. :-)

Thanks!

Chris
