Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183EC6F572C
	for <lists+linux-nfs@lfdr.de>; Wed,  3 May 2023 13:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjECLbe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 May 2023 07:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjECLbd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 May 2023 07:31:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C14C0D
        for <linux-nfs@vger.kernel.org>; Wed,  3 May 2023 04:31:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f315735514so19637605e9.1
        for <linux-nfs@vger.kernel.org>; Wed, 03 May 2023 04:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683113490; x=1685705490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04C66NkHpIaK36BKkWo1xIGCdVJ8d5XamKir7enWzFM=;
        b=nMGM9ezcPvHWMTCih9c2IuIeZ7MsFBKmLPFK+CzCwD55dEWkkJzP66TovjJI/l+BrR
         39ovfcvLDY3uD4RgUu9FaorOgkvKvZjzkA3vdTr/tvOjGKJonbwY8zmT5WysJc5/Q/AZ
         JhsFImt1GZCaqmLP6mFf4l28bvdbjbpFMc2cvOLciAFHqzPe0dNdvbHBOgdKfJpP5X09
         +yjcAdzaScFZ6FlY7fBgvK0xnjO4abirucsMMzk9XazOoHJ980ScVwXwEnOJUn7jOL1f
         7Hwo43sao5if75Q025fvUVttAVh8kFkUrYyQmFa339YIiGzGp0RJTM5P6RLuYIeaLMlt
         9bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683113490; x=1685705490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04C66NkHpIaK36BKkWo1xIGCdVJ8d5XamKir7enWzFM=;
        b=UHuV9fYzKN8siSOrvKwDX6/jnRpfEaWkIHiPIL7GKRMPhMUMsu0tK6qAJwIlnJEVQZ
         cCSx+TNJ4kZs9OzsFsvG4wdxZWo0TfiYDH9J/LSRqj7/0CXmxFLKouAxKLmEpf8N6QI6
         KqsFSqJYDJ3fz9oalP3NfSc8o0vnKcG2kLW4UKB04VAi9V+BtrviOMwa2foXmgxWP7qW
         r4ysE/K84WAA0t7EHDLDEHh122hXt7MEZ+qAtt+osY3PKQNIVciOqhEwEjuIDNUnxsFu
         vvdBhiwwbUext4TJE4H1onhHZ/sSX64NvhAzgfAeGBQ/dHLCUrIXWsQ8Lb21cmfd1win
         pcWA==
X-Gm-Message-State: AC+VfDyXHMwElhz6Uvr59XZxjQ5UF95cps+U41jaS/1K+SpHEQxA/Fi9
        gDOdHwputjH5Gd3u4lBoQ3jClA==
X-Google-Smtp-Source: ACHHUZ4X2/ZOx3+klYv8AU3Q5nlX2yjdJ8bVeSHGr36ddleN2DNOmIjLwdaoKe3AFpX47VN2y2GwUg==
X-Received: by 2002:a1c:7915:0:b0:3f1:6880:3308 with SMTP id l21-20020a1c7915000000b003f168803308mr1454645wme.1.1683113490319;
        Wed, 03 May 2023 04:31:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c290600b003f18992079dsm1588732wmd.42.2023.05.03.04.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 04:31:28 -0700 (PDT)
Date:   Wed, 3 May 2023 14:31:23 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] net: avoid double iput when sock_alloc_file fails
Message-ID: <95e36d70-7841-4e7d-960a-116b8595b820@kili.mountain>
References: <20230307173707.468744-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307173707.468744-1-cascardo@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I changed the CC list from netdev to linux-nfs.

On Tue, Mar 07, 2023 at 02:37:07PM -0300, Thadeu Lima de Souza Cascardo wrote:
> When sock_alloc_file fails to allocate a file, it will call sock_release.
> __sys_socket_file should then not call sock_release again, otherwise there
> will be a double free.
> 

It's just a one liner to make Smatch warn about these sorts of user
after free bugs.

	{ "sock_release", PARAM_FREED, 0, "$" },

Smatch found a related bug in nfs.

net/sunrpc/svcsock.c:938 svc_tcp_accept() warn: 'newsock' was already freed.
net/sunrpc/svcsock.c:1633 svc_create_socket() warn: 'sock' was already freed.
net/sunrpc/svcsock.c:1555 svc_addsock() error: dereferencing freed memory 'so'
net/sunrpc/svcsock.c:1633 svc_create_socket() warn: passing freed memory 'sock'
net/sunrpc/svcsock.c:938 svc_tcp_accept() warn: passing freed memory 'newsock'

I guess the svc_setup_socket() function should free sock on every error
path?  It seems kind of gnarly.

I fixed another sock_release() double free in xen that was simpler.

regards,
dan carpenter

