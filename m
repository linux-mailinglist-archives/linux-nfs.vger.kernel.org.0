Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B357EDAC2
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 05:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjKPEdy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Nov 2023 23:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPEdw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Nov 2023 23:33:52 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550031A8
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 20:33:47 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-778999c5ecfso20332185a.2
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 20:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109226; x=1700714026; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HOfDZdWy3FlMMU3byFQ5fyH9fZQUeVFWx7pZHVOBZ9I=;
        b=cUShdtqX6NpRR3sTAX0J50EPelbnHmQNFwtWvwzNOaB5PsWSbAaumzdhhDAezZ/KVs
         4uAi6bZhs7kWxiaREbmBkx5XOlv0YLLmHnOuaHpkfianch+ql9QBTSLz8ULbt4MoRQhP
         HS49Y2z6QZAsdUpvur/XvuVba1Prftyd00XHMiGESmfqTkMiO89y110AJ5j6llyg0rd4
         YD7CtJVPc4kiEp6m1LVvXvZuFGfh6vW8fiOQfNuQXj/6O7yuLxQdstH2aL6JGF64QybS
         i3RTojbP3mpDQJCYFP1Xh4eVjB/pRvLS5ma7lWrP4rC9H6MczSvb/71xmqO9qtnNDdKN
         yiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109226; x=1700714026;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOfDZdWy3FlMMU3byFQ5fyH9fZQUeVFWx7pZHVOBZ9I=;
        b=OiA+Ylmenm4LbydeFJICKC2ejn6De7BncPA1WzyTLMwOWsAgKQu6mSuz7FBfyq+dCU
         dMUsIm7DONyUuDgDFMBvDF1wIXg12vcjJuzRAqtjzkJ64iIRZ+r+SHLtTpmvdsKuIq04
         HuOVPyBg5xi4CFymzfsPCRtqbKjB/Zq7GSxmFx7RYBKMH495uLLzG66XkkiVIyvhWpmq
         I6F+Ba0Ryn/VbgJ0WrHAo36AC5dBOlBrfF3uKoXGFU+v0zzspWZTDrgDvRBqYkCGG7qL
         y0Xhnt+K4j4b0OXbbuq0oshENpKAaKJlZullomympyZczIBSaeoakxknRUIHej/e7PKh
         bXeQ==
X-Gm-Message-State: AOJu0YytTcVV1UlMxm0yf5GBgFjyxVLrNjbJBVHXeu7mUEl/PiNQDXcv
        v2ZCuZg8kgOo2RMM/Ne/CSTv
X-Google-Smtp-Source: AGHT+IER1laoQSGviRJQuTFe6S8/gip4gdebLlsXd5eO0S7LgScOwZM8Bh3pBl2l/YUS5yGMypAquA==
X-Received: by 2002:a05:620a:201c:b0:778:920a:7a70 with SMTP id c28-20020a05620a201c00b00778920a7a70mr8484989qka.66.1700109226313;
        Wed, 15 Nov 2023 20:33:46 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id qc3-20020a05620a654300b0076d25b11b62sm4033067qkn.38.2023.11.15.20.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:45 -0800 (PST)
Date:   Wed, 15 Nov 2023 23:33:45 -0500
Message-ID: <231ff26ec85f437261753faf03b384e6.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 10/23] security: Introduce inode_post_setattr hook
References: <20231107134012.682009-11-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-11-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_setattr hook.
> 
> At inode_setattr hook, EVM verifies the file's existing HMAC value. At
> inode_post_setattr, EVM re-calculates the file's HMAC based on the modified
> file attributes and other file metadata.
> 
> Other LSMs could similarly take some action after successful file attribute
> change.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/attr.c                     |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 26 insertions(+)

...

> diff --git a/security/security.c b/security/security.c
> index 7935d11d58b5..ce3bc7642e18 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2222,6 +2222,22 @@ int security_inode_setattr(struct mnt_idmap *idmap,
>  }
>  EXPORT_SYMBOL_GPL(security_inode_setattr);
>  
> +/**
> + * security_inode_post_setattr() - Update the inode after a setattr operation
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @ia_valid: file attributes set
> + *
> + * Update inode security field after successful setting file attributes.
> + */
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 int ia_valid)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;

I may be missing it, but I don't see the S_PRIVATE flag check in the
existing IMA or EVM hooks so I'm curious as to why it is added here?
Please don't misunderstand me, I think it makes sense to return early
on private dentrys/inodes, but why aren't we doing that now?

> +	call_void_hook(inode_post_setattr, idmap, dentry, ia_valid);
> +}
> +
>  /**
>   * security_inode_getattr() - Check if getting file attributes is allowed
>   * @path: file
> -- 
> 2.34.1

--
paul-moore.com
