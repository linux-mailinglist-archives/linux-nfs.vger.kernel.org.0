Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701E24F0022
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Apr 2022 11:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiDBJe7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 Apr 2022 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiDBJe6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 2 Apr 2022 05:34:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CB31C108;
        Sat,  2 Apr 2022 02:33:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id k14so4251550pga.0;
        Sat, 02 Apr 2022 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIRSTzpeogZQegTxy3HsXL8f2cTTP9W4dlr8OKiUWvM=;
        b=MmNDOwVEm9/LVOFVLRabwEeZP2ohnfVDJl4b6rWpmqY7ck/S6PpyIGOmyHKtqdnrB6
         MmfTPtCYh59zgoCCuotESVOzKCOJ20495cIfFbDPXFXedRy7EgZnpyR0z61XHHDKi7Mt
         gmO1GhLb9kfH1Lh1ZdRn7shLVz2Ep9pM2fKO/nUXKIyWd+toxIbk4mE8NamZjm/Fx7Ra
         C+KKcTcPRgmyi3AYRXyJ/9y1Gy43XNHxl4MDcMGP8V6Uokjsfi6ZyrJNHaDMuG3muHUr
         rCoAARHhh/CuKf93dFKNmSRFUR34oFcKJE/tyq+XjKnmAa3nBzkxqGDpM2BR18YAuaa3
         Xzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIRSTzpeogZQegTxy3HsXL8f2cTTP9W4dlr8OKiUWvM=;
        b=H3DLIo1QlE3AZyVElpOk3BX6nfiywbF9mp2uxtG4FMgA1C3RvlzDW+jIXeCnCzR9ax
         w/0mmAgjnVX9QF+E8ZLg91YuswjUX8zfWD5r6xA8k2w/AFrswEJ6jmxCI1LNryXkPVzy
         xzlPxKqCYI+5IpOUSH7kb/EbU8BzGu1GbaEPv+K+h7m7ZDt1EIepZnv/N5APq/HOVaij
         cgxY1zd0qez+N1VYx/+YQ/zOWrb+zMX4ysOlr9H2ypdXybxGWuMQClIoy919/37POVA4
         ztzoEvrzHQ612XYQYP7GK9/9LMRTnb4QnlXmGysEtd9PhJYON5N8U4e1vejznFVjpOv5
         /9HA==
X-Gm-Message-State: AOAM531W0IW3nkwPKUvpZePUeOheP8oTx+vNC7RpWZQ59CrtV3+Nb98R
        G4rz4utIoDN2jvd39siyNAEkm2/yFVAxgQ==
X-Google-Smtp-Source: ABdhPJwTBN78sVwN2HktnnEhYPi7sExtecHxxHkCS/Jzrfc7VDfZ0PtiiKIkHMUvO3GW0yIF9EAOsg==
X-Received: by 2002:aa7:8d47:0:b0:4f6:a7f9:1ead with SMTP id s7-20020aa78d47000000b004f6a7f91eadmr14749693pfe.42.1648891987038;
        Sat, 02 Apr 2022 02:33:07 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id f66-20020a62db45000000b004fa8a7b8ad3sm5593956pfg.77.2022.04.02.02.33.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Apr 2022 02:33:06 -0700 (PDT)
Date:   Sat, 2 Apr 2022 17:32:21 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     "Yue Hu" <huyue2@coolpad.com>
Cc:     <dhowells@redhat.com>, <sfrench@samba.org>,
        <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <linux-cachefs@redhat.com>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <linux-nfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zbestahu@163.com>,
        <zhangwen@coolpad.com>
Subject: Re: [PATCH] fscache: Expose fscache_end_operation() helper
Message-ID: <20220402173221.00002170.zbestahu@gmail.com>
In-Reply-To: <20220402021841.22285-1-huyue2@coolpad.com>
References: <20220402021841.22285-1-huyue2@coolpad.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 02 Apr 2022 10:18:55 +0800
"Yue Hu" <huyue2@coolpad.com> wrote:

> Currently, nfs and cifs have same fscache_end_operaion() as fscache.
> We may put the helper in linux/fscache.h so that fscache internal
> and client filesystem can all use it.

Sorry, please ignore the patch due to my earlier code base.

Thanks.

> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>  fs/cifs/fscache.c       |  8 --------
>  fs/fscache/internal.h   | 11 -----------
>  fs/nfs/fscache.c        |  8 --------
>  include/linux/fscache.h | 12 ++++++++++++
>  4 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
> index 33af72e0ac0c..b47c2011ce5b 100644
> --- a/fs/cifs/fscache.c
> +++ b/fs/cifs/fscache.c
> @@ -134,14 +134,6 @@ void cifs_fscache_release_inode_cookie(struct inode *inode)
>  	}
>  }
>  
> -static inline void fscache_end_operation(struct netfs_cache_resources *cres)
> -{
> -	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
> -
> -	if (ops)
> -		ops->end_operation(cres);
> -}
> -
>  /*
>   * Fallback page reading interface.
>   */
> diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
> index f121c21590dc..ed1c9ed737f2 100644
> --- a/fs/fscache/internal.h
> +++ b/fs/fscache/internal.h
> @@ -70,17 +70,6 @@ static inline void fscache_see_cookie(struct fscache_cookie *cookie,
>  			     where);
>  }
>  
> -/*
> - * io.c
> - */
> -static inline void fscache_end_operation(struct netfs_cache_resources *cres)
> -{
> -	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
> -
> -	if (ops)
> -		ops->end_operation(cres);
> -}
> -
>  /*
>   * main.c
>   */
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index cfe901650ab0..39654ca72d3d 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -249,14 +249,6 @@ void nfs_fscache_release_file(struct inode *inode, struct file *filp)
>  	}
>  }
>  
> -static inline void fscache_end_operation(struct netfs_cache_resources *cres)
> -{
> -	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
> -
> -	if (ops)
> -		ops->end_operation(cres);
> -}
> -
>  /*
>   * Fallback page reading interface.
>   */
> diff --git a/include/linux/fscache.h b/include/linux/fscache.h
> index 296c5f1d9f35..79bb40b92e0f 100644
> --- a/include/linux/fscache.h
> +++ b/include/linux/fscache.h
> @@ -557,6 +557,18 @@ int fscache_write(struct netfs_cache_resources *cres,
>  	return ops->write(cres, start_pos, iter, term_func, term_func_priv);
>  }
>  
> +/*
> + * Clean up at the end of an operation
> + */
> +static inline
> +void fscache_end_operation(struct netfs_cache_resources *cres)
> +{
> +	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
> +
> +	if (ops)
> +		ops->end_operation(cres);
> +}
> +
>  /**
>   * fscache_clear_page_bits - Clear the PG_fscache bits from a set of pages
>   * @cookie: The cookie representing the cache object

