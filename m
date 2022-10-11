Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5F85FB854
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 18:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJKQiT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 12:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJKQiS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 12:38:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA2362A8E
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 09:38:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d24so13727278pls.4
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pJIEIqUm9cUj1SmYNhJXGpR39cH9SzoM6WilMBeHUU=;
        b=RI4IIQSaXvRAb3D7QnzzQgHHdlPdXjhRr76L6bS2fFS2B2K0X0E2GmmJxgwx/qLV3l
         yAYEdEGcpr+zjx1++mP03jsZr9PabHIvXRlMg7Bq5mh0PEqRzXt+hxsXKh6bH7ySHKEU
         GW5JFVv57eZRspJ2mU2BPpnuIaaEEy3NZsLp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pJIEIqUm9cUj1SmYNhJXGpR39cH9SzoM6WilMBeHUU=;
        b=YvWYozYLM5sGUVvWEV4Elfjvcmt9Vr/XmKTzWYgGH6oWrHm6rliTBXRd2n9p/79LwG
         wdG4w54P66UJd1bEBID5M1SiXnjfZ5s2fakMBNRJ8W0iAA1PpRiwyYkJPoQAEOwvy1NV
         OLrPUbi3DyKeVNcRO9jW4WF+pWo2DKtuMVOpaUSjadDOCGn8MisfKnPQyvrXOSYIGrfZ
         qf2y8WJBRyhRPwMoLm5Yzo+Lw306wCVwYz9STeLgVWQskmy+Y+QxDOvy8SMk9HG0JoTl
         D88O9yqzM5TVslvPg04SZ5kYjQlvZJXjera2S0xdtZCBNAqU0dfer3N3LgvXkGiJHX5V
         OUkg==
X-Gm-Message-State: ACrzQf1QYebKRA9c7qMx5r2axETOJh5/2S/krhoKFgffdGDeuJcbbRhC
        TCBJ49a3A4XCAAqNBRvD7zp2XA==
X-Google-Smtp-Source: AMsMyM6B0D0fQ6NLX5y+52iwlwAK3HZGC+HhYAnBPVJ76NqrBUDrJeJIbYTwa3ClTfrHZ7hH8lrL/Q==
X-Received: by 2002:a17:902:b94c:b0:178:336f:13d6 with SMTP id h12-20020a170902b94c00b00178336f13d6mr26369645pls.64.1665506296312;
        Tue, 11 Oct 2022 09:38:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b0016d72804664sm8881631plg.205.2022.10.11.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:38:15 -0700 (PDT)
Date:   Tue, 11 Oct 2022 09:38:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] NFS: Avoid memcpy() run-time warning for struct sockaddr
 overflows
Message-ID: <202210110934.AA4F52C77@keescook>
References: <20221011065243.583650-1-keescook@chromium.org>
 <Y0WK3MZvxpoXS24n@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0WK3MZvxpoXS24n@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 11, 2022 at 10:25:16AM -0500, Gustavo A. R. Silva wrote:
> On Mon, Oct 10, 2022 at 11:52:43PM -0700, Kees Cook wrote:
> > The 'nfs_server' and 'mount_server' structures include a union of
> > 'struct sockaddr' (with the older 16 bytes max address size) and
> > 'struct sockaddr_storage' which is large enough to hold all the supported
> > sa_family types (128 bytes max size). The runtime memcpy() buffer overflow
> > checker is seeing attempts to write beyond the 16 bytes as an overflow,
> > but the actual expected size is that of 'struct sockaddr_storage'. Adjust
> > the pointers to the correct union member. Avoids this false positive
> > run-time warning under CONFIG_FORTIFY_SOURCE:
> > 
> >   memcpy: detected field-spanning write (size 28) of single field "&ctx->nfs_server.address" at fs/nfs/namespace.c:178 (size 16)
> > 
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> > Link: https://lore.kernel.org/all/202210110948.26b43120-yujie.liu@intel.com
> > Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Cc: Anna Schumaker <anna@kernel.org>
> > Cc: linux-nfs@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!

> > ---
> >  fs/nfs/fs_context.c | 2 +-
> >  fs/nfs/namespace.c  | 2 +-
> >  fs/nfs/super.c      | 4 ++--
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > index 4da701fd1424..bffa31bb35b9 100644
> > --- a/fs/nfs/fs_context.c
> > +++ b/fs/nfs/fs_context.c
> > @@ -1540,7 +1540,7 @@ static int nfs_init_fs_context(struct fs_context *fc)
> >  		ctx->version		= nfss->nfs_client->rpc_ops->version;
> >  		ctx->minorversion	= nfss->nfs_client->cl_minorversion;
> >  
> > -		memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
> > +		memcpy(&ctx->nfs_server._address, &nfss->nfs_client->cl_addr,
> >  			ctx->nfs_server.addrlen);

So, I spent a bunch more time looking at the plumbing of struct sockaddr
vs struct sockaddr_storage. In NFS, everything I could find is actually
already backed by a full sockaddr_storage, so I think a more complete
fix here would actually be to update all the internals to pass
sockaddr_storage instead of sockaddr. The interfaces to other things
(e.g. rpc) can cast back to sockaddr for now. It is a pretty reasonable
cleanup, IMO.

I'll send a follow-up that makes this change on top of this patch,
though they could be squashed if that was desired.

-- 
Kees Cook
