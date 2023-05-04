Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614506F6F44
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 17:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjEDPnr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 11:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEDPnr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 11:43:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0867C44A1
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 08:43:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2f95231618aso470866f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 04 May 2023 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683215024; x=1685807024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ys3HtQxQg3s6FBzigb4tPL7ILd+VnjCAEgVMPEQGw8=;
        b=SV2GLk2EpijETPr1buxB8oJjc42j4UbsuyYhHS4Sj//tXwdlqnUKBnY9QWDLGDXmEq
         zxztPnyDyDgevvO3w+NWzWNcTaqrU84YxL6rIvHMLVRLOdi6J3rn7hN9GPNkvSlj5a98
         R7i/+9OpxqlVJiI6qosNpNaBaY3K64WE1EPYyb4uz3lZ+lRbXsdzRXHmrcA80EuHTZsD
         oPeoskmN2RD5NneppCXZ6daTixKyDHPZhfRpaxYt9l6Y27DJgyjZe7GREaO/g05VCuLt
         +2DlNUe6mJneCT+tJAiuR4uDqpily9wzQL02MF6nMo8fpSU6YP/k4c31uQfinN+G1cB7
         A44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683215024; x=1685807024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ys3HtQxQg3s6FBzigb4tPL7ILd+VnjCAEgVMPEQGw8=;
        b=NCJE48dyIRWIpA+F+KumE80BS/qjFCWVfbY/TvKD3PKgbzs5fSyscyPKJlu6H5/Nu5
         0GKceHdFHjcGjF4ABK1pv2oLSbQ1n6PLT3DLEbXMMfMMqbZDr6nGVlObrVdihrwfByqK
         d0iTNGkw3vadVqQbkh/792OViN7vhUmQeLq1Nd49++O6sZtafPTtnstKbv2L3U2yZuRW
         pbXaPyHBcqchcUqlClOSuVW/Irm7mrKqTGXG+DDEk0rbyXb7bfqTUidZTJWTLfQmRTiV
         ykuf1ck33G3d2BpdchhucdHjwQbBgV2DUfwxt6EeDcdfVt6KNnxxyJ1B3WqujXGd+wNs
         Iq0Q==
X-Gm-Message-State: AC+VfDwah37Ss+9bbfj0SBHYgYfvdJ9/MvIwewoSgXCKRtQD8CuRXGiz
        PRXFtZXLDp7+nwJkMDan+u0ZXg==
X-Google-Smtp-Source: ACHHUZ6CNvUO6S0ulMBEEak5cNfxd+MK9Qavm2+HZiWUpYdYonpmYNytI/LaUB1NwQMWEH9u/3z1/Q==
X-Received: by 2002:a5d:4e43:0:b0:306:3c04:e4df with SMTP id r3-20020a5d4e43000000b003063c04e4dfmr2989270wrt.58.1683215024532;
        Thu, 04 May 2023 08:43:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5712000000b003062675d4c9sm14240980wrv.39.2023.05.04.08.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 08:43:42 -0700 (PDT)
Date:   Thu, 4 May 2023 18:43:38 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] net: avoid double iput when sock_alloc_file fails
Message-ID: <16116c13-5f45-4d9c-ada8-480e570397f0@kili.mountain>
References: <20230307173707.468744-1-cascardo@canonical.com>
 <95e36d70-7841-4e7d-960a-116b8595b820@kili.mountain>
 <53A81159-DD6C-4A5E-994F-49A536F7BD31@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53A81159-DD6C-4A5E-994F-49A536F7BD31@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 04, 2023 at 03:40:15PM +0000, Chuck Lever III wrote:
> 
> 
> > On May 3, 2023, at 7:31 AM, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > 
> > I changed the CC list from netdev to linux-nfs.
> > 
> > On Tue, Mar 07, 2023 at 02:37:07PM -0300, Thadeu Lima de Souza Cascardo wrote:
> >> When sock_alloc_file fails to allocate a file, it will call sock_release.
> >> __sys_socket_file should then not call sock_release again, otherwise there
> >> will be a double free.
> >> 
> > 
> > It's just a one liner to make Smatch warn about these sorts of user
> > after free bugs.
> > 
> > { "sock_release", PARAM_FREED, 0, "$" },
> > 
> > Smatch found a related bug in nfs.
> > 
> > net/sunrpc/svcsock.c:938 svc_tcp_accept() warn: 'newsock' was already freed.
> > net/sunrpc/svcsock.c:1633 svc_create_socket() warn: 'sock' was already freed.
> > net/sunrpc/svcsock.c:1555 svc_addsock() error: dereferencing freed memory 'so'
> > net/sunrpc/svcsock.c:1633 svc_create_socket() warn: passing freed memory 'sock'
> > net/sunrpc/svcsock.c:938 svc_tcp_accept() warn: passing freed memory 'newsock'
> > 
> > I guess the svc_setup_socket() function should free sock on every error
> > path?  It seems kind of gnarly.
> 
> I'm looking at current upstream, and I don't see svc_setup_socket()
> releasing @sock on any return path. What am I missing?

The sock_alloc_file() function releases it on error...

> 
> Does your tree have "SUNRPC: Ensure server-side sockets have a sock->file" ?

Ah, that's the commit that introduces the call sock_alloc_file().

regards,
dan carpenter

