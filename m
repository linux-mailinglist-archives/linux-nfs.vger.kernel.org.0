Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE860ECFD
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Oct 2022 02:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiJ0A1M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Oct 2022 20:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJ0A1L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Oct 2022 20:27:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B9BB40D2
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 17:27:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pb15so15703610pjb.5
        for <linux-nfs@vger.kernel.org>; Wed, 26 Oct 2022 17:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iU2i0PMrQVnQ4ps+4iiQB08KfiN0l0KhLG1V0BD4MR8=;
        b=KCih+xkAe4vXcs1RPlE/MAQ0fRxNKf7uYv1wRgmqATVL1Sai0cU8gTy3hnWBzXKED6
         q8znnfXEfw+K2vZzBUqTN2L3ReyNNk7Jf5nt1UhKidWXupCSRHWk5jGugt7L1XX+bNAR
         y8SYEeRYt6FK6R9ktnpaPQjgrJ4TbIlvMavtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iU2i0PMrQVnQ4ps+4iiQB08KfiN0l0KhLG1V0BD4MR8=;
        b=oRQBC+HR0rbikYv2CJiHI+mPxSl0S9ANTbyhmydkAU+Rst1G1qxCKX+B+5JApPz/Ys
         b/TzeFamOkYwp79opaC2b4CNCUkajAXAp9AJKGIHsvva7A0FsrKhN0FZClqKti3D90MC
         XZT/cUM3ew8UQTtv6KFPvSZ5N6vEaChUy18wu7KBqg2EGxXx/9wnqUUDztNN22V+ZsBF
         wxX1zgktDrI6WTimXXeYxDTb9d4Dw8dhPKjeECth+HAYC/VjKD0IjrFF1jUr+p6Mp985
         sR4CFdNM2NxVg22ZwDqcQflleayLE1FOPYeuoCAAaCtiQXh7/lKTUQgGsh4bY8dUUfod
         sycw==
X-Gm-Message-State: ACrzQf3vEbBjE3bepKYZpuTx/dVl455nzFbCue0fMAJ8qCstKmzua99K
        dJVBDcKc27lpUBxZpQdQXGtTnLKiAxF1zQ==
X-Google-Smtp-Source: AMsMyM7VsJD190gpaQTJ5WFpnQi4RBlK40obMsTRqlE685n13au3G2J0/Tl7P4D/ZJQ2KwEEllsXVQ==
X-Received: by 2002:a17:903:3293:b0:186:867b:e24 with SMTP id jh19-20020a170903329300b00186867b0e24mr27117567plb.127.1666830420450;
        Wed, 26 Oct 2022 17:27:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b001868ba9a867sm3437772plb.303.2022.10.26.17.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 17:26:59 -0700 (PDT)
Date:   Wed, 26 Oct 2022 17:26:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        kernel test robot <yujie.liu@intel.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Dave Jones <davej@codemonkey.org.uk>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] NFS: Avoid memcpy() run-time warning for struct
 sockaddr overflows
Message-ID: <202210261726.554CBDC55@keescook>
References: <20221017043107.never.457-kees@kernel.org>
 <202210261631.DE7E4761E@keescook>
 <35A4B422-29FF-4294-8596-D75FC60E55DE@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35A4B422-29FF-4294-8596-D75FC60E55DE@hammerspace.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 27, 2022 at 12:03:07AM +0000, Trond Myklebust wrote:
> 
> 
> > On Oct 26, 2022, at 19:32, Kees Cook <keescook@chromium.org> wrote:
> > 
> > On Sun, Oct 16, 2022 at 09:36:50PM -0700, Kees Cook wrote:
> >> The 'nfs_server' and 'mount_server' structures include a union of
> >> 'struct sockaddr' (with the older 16 bytes max address size) and
> >> 'struct sockaddr_storage' which is large enough to hold all the
> >> supported sa_family types (128 bytes max size). The runtime memcpy()
> >> buffer overflow checker is seeing attempts to write beyond the 16
> >> bytes as an overflow, but the actual expected size is that of 'struct
> >> sockaddr_storage'. Plumb the use of 'struct sockaddr_storage' more
> >> completely through-out NFS, which results in adjusting the memcpy()
> >> buffers to the correct union members. Avoids this false positive run-time
> >> warning under CONFIG_FORTIFY_SOURCE:
> >> 
> >>  memcpy: detected field-spanning write (size 28) of single field "&ctx->nfs_server.address" at fs/nfs/namespace.c:178 (size 16)
> >> 
> >> Reported-by: kernel test robot <yujie.liu@intel.com>
> >> Link: https://lore.kernel.org/all/202210110948.26b43120-yujie.liu@intel.com
> >> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> >> Cc: Anna Schumaker <anna@kernel.org>
> > 
> > Friendly ping -- this needs to land in v6.1 to avoid these warnings.
> > Should I carry this in the hardening tree instead?
> > 
> > Thanks!
> 
> Anna, this is your call since you’re the ‘6.1 nfs client maintainer’...

And just to remind, this came up in -rc1 as well:
https://lore.kernel.org/lkml/202210162144.76FBC7271@keescook/


-- 
Kees Cook
