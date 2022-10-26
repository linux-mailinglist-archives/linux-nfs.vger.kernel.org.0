Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D760ECA6
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 01:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiJZXco (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 19:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiJZXcn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 19:32:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820D883F33
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 16:32:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9so5548969pll.7
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASNvt3YZA5URmImi9I7VajS1ONgiR7V+0imqEJ2tB40=;
        b=XXryU3Ajq0S/F4oMRkJQBOKdhp1zaWHobjAl9lt0O36OllcL/sZ9ErbE53FngsRRTI
         sPyH1gT2vnTcZQdDu5/XuNbKZFEQj3GHT59S/kjkcRGr2Ulo5fFfFwjGKJn8cF3QTGZr
         xK8TB+5QI28xW+uIaA80GBIA/O2GkzVcHJxsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASNvt3YZA5URmImi9I7VajS1ONgiR7V+0imqEJ2tB40=;
        b=TBthc3Aekk0sHCkO03rK6s3Yz9lTkSAgEh7YErimE6+wMep/ZpmegfMQCk/anEVV+V
         1+G5GiQMgIAiJKCpK3qc5hF25Xs13I1G3LWhf3AQNOhl3aluNOWsfR3DkrvZBNT0WmWb
         xH+56gW4Q1n+QjMv/v98qF5gWT+z8TIdS72WdlwpXCVkjIdEPoLtqJEeZo4q/rWIu4yE
         YImnzo6UKAsv8HiQrF3LFjSP2c2917GMK8vgWmuhBVjDJutoFJxPV8rnwL82/bBhp3qa
         waw+0EPTZR8mka9v0LqeQCCrj0C7t8Z3sN7FTQVfIwc5OblR2XeToquz0p0nn/0csxhO
         4D+w==
X-Gm-Message-State: ACrzQf0aABT/DJ61Dm2wCdTRruqbWg875Ffygaf5k3FDxWSuOVufEF/R
        7Vk+xEAIicc+sOCl29pItRv3FA==
X-Google-Smtp-Source: AMsMyM5qsJkhUxULmVA6vqhL3AmD4D9tOiA7Gqkmft5jpW1wq0i2LYxDuO2aVrBlPHgOLrKj94F8vA==
X-Received: by 2002:a17:902:b101:b0:186:7067:3ea3 with SMTP id q1-20020a170902b10100b0018670673ea3mr33618100plr.59.1666827161964;
        Wed, 26 Oct 2022 16:32:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y76-20020a62644f000000b0056bc1a41209sm3514145pfb.33.2022.10.26.16.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 16:32:41 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:32:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        Dave Jones <davej@codemonkey.org.uk>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] NFS: Avoid memcpy() run-time warning for struct
 sockaddr overflows
Message-ID: <202210261631.DE7E4761E@keescook>
References: <20221017043107.never.457-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017043107.never.457-kees@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Oct 16, 2022 at 09:36:50PM -0700, Kees Cook wrote:
> The 'nfs_server' and 'mount_server' structures include a union of
> 'struct sockaddr' (with the older 16 bytes max address size) and
> 'struct sockaddr_storage' which is large enough to hold all the
> supported sa_family types (128 bytes max size). The runtime memcpy()
> buffer overflow checker is seeing attempts to write beyond the 16
> bytes as an overflow, but the actual expected size is that of 'struct
> sockaddr_storage'. Plumb the use of 'struct sockaddr_storage' more
> completely through-out NFS, which results in adjusting the memcpy()
> buffers to the correct union members. Avoids this false positive run-time
> warning under CONFIG_FORTIFY_SOURCE:
> 
>   memcpy: detected field-spanning write (size 28) of single field "&ctx->nfs_server.address" at fs/nfs/namespace.c:178 (size 16)
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/all/202210110948.26b43120-yujie.liu@intel.com
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna@kernel.org>

Friendly ping -- this needs to land in v6.1 to avoid these warnings.
Should I carry this in the hardening tree instead?

Thanks!

-Kees

-- 
Kees Cook
