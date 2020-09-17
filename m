Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEE126D2B0
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 06:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIQEf0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Sep 2020 00:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQEfZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Sep 2020 00:35:25 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5949C06174A;
        Wed, 16 Sep 2020 21:35:24 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p65so916306qtd.2;
        Wed, 16 Sep 2020 21:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Zpj6VNYB1ijfsr3LbH3mcMe7G5qplkFLWfuclz0cxc=;
        b=VmK4WCobellFuhyIrcbPQIcR010JSu/T6FWoLObSAlKIMNCI4F+701ka2to1Q0FNeH
         CVdAGvwMUdGLbe++OsvqNPYRQyZ/5BOkkXJp1RWquC1rW08NZfye4UK0dpX3c/teJQxn
         tqftQgLVUjDswDau3e9yc6xtArTRAMZ7fNtD3qe/5yw8Ljn9ujupFNYMIXSA4JDxvI/p
         22TBlpTLXspeNL9lkEVQE2S0AJuE3VftZY94vUOPWnpIZa/NnFcTcqLia40djdMK1yHQ
         1grKazy1MjwuMVUEDLuIPwTX2OZOJyVuW72AAk12ux8JAr1xg09n0OQjh6hNqUaFXTnw
         qYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Zpj6VNYB1ijfsr3LbH3mcMe7G5qplkFLWfuclz0cxc=;
        b=RNbEYYgs21zCijEtyhPYWgOrVcnja6FhJi+mjreNnOeFToBhX/HAANZywMdOM6KLb3
         7UAb/VaV9vP35fxQQUnAY175ravDufk4NGZDJLdW2F4pDUsCAnANjU8dX9VNjJDOAfdH
         v2BCgewqcBOFOX34haFeqZrrhoNApaIFWso5IMfoBC8r0gYk87aidO2QmwT4IMQQXo7g
         UQDOVU6w8SJ8FW6z3JIR9s6u7dfJAxgI8x6lXiBYdEUMdYCnsvoEoRBCDRIDUIZHxqu2
         Ubye+VCDLRktfbvnuIuGEm34TV28NYdujvCr0nD8xR8C1T5Bja2neR5IFCGozOjWp0y7
         j2Bw==
X-Gm-Message-State: AOAM530qpogbA25gMG3Rc0rXCYnncw4k3KH/g8LtO0ew5O6/dhdvZxo1
        rBgpJ3qJKmnNzudWVoVzw7A=
X-Google-Smtp-Source: ABdhPJw+GVhv2RdCY2tcZg+MQREljzpzBgFDmXhaOeohJBw31zX7qee7qh2F76HewU8pFXupCLwprg==
X-Received: by 2002:ac8:319d:: with SMTP id h29mr24991731qte.32.1600317323724;
        Wed, 16 Sep 2020 21:35:23 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id 192sm21437979qkn.9.2020.09.16.21.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 21:35:22 -0700 (PDT)
Date:   Wed, 16 Sep 2020 21:35:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        Hongxiang Lou <louhongxiang@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] nfs: remove incorrect fallthrough label
Message-ID: <20200917043521.GA3355283@ubuntu-n2-xlarge-x86>
References: <9441ed0f247d0cac6e85f3847e1b4c32a199dd8f.camel@perches.com>
 <20200916200255.1382086-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916200255.1382086-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 16, 2020 at 01:02:55PM -0700, Nick Desaulniers wrote:
> There is no case after the default from which to fallthrough to. Clang
> will error in this case (unhelpfully without context, see link below)
> and GCC will with -Wswitch-unreachable.
> 
> The previous commit should have just replaced the comment with a break
> statement.
> 
> If we consider implicit fallthrough to be a design mistake of C, then
> all case statements should be terminated with one of the following
> statements:
> * break
> * continue
> * return
> * __attribute__(__fallthrough__)
> * goto (plz no)
> * (call of function with __attribute__(__noreturn__))
> 
> Fixes: 2a1390c95a69 ("nfs: Convert to use the preferred fallthrough macro")
> Link: https://bugs.llvm.org/show_bug.cgi?id=47539
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> Changes v2:
> * add break rather than no terminating statement as per Joe.
> * add Joe's suggested by tag.
> * add blurb about acceptable terminal statements.
> 
>  fs/nfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index d20326ee0475..eb2401079b04 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -889,7 +889,7 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
>  		default:
>  			if (rpcauth_get_gssinfo(flavor, &info) != 0)
>  				continue;
> -			fallthrough;
> +			break;
>  		}
>  		dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", flavor);
>  		ctx->selected_flavor = flavor;
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 
