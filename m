Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E63F7EDABD
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 05:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjKPEdz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Nov 2023 23:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjKPEdx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Nov 2023 23:33:53 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821BC1B2
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 20:33:48 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so356998276.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 20:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109227; x=1700714027; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6JnX6LhDVyRia5AIt4T5fsWFKT3oTlNbS/+dMYZ6fZQ=;
        b=Dv+KWzBQX+5o5++l8yO+HpDSfefpsTNkBvdbl2blus3gc1/iv25pulROvWqYEZsLAS
         mosbscQfoRuSsRGdBdLqwUu/0jxO7bFEHasVVbvlJTPNKM1hWVRE6D+PFzSa7U75WsgZ
         r4iw3Eev5Nii51+0Y8t5QyPJupT0TDMvXN2U6S+0QBVSh6a2pB6EpQUF7bUb3TAkI+nD
         dfK9pFLFwO2glDh+b/NF2VYHmy9IZQ61ZbS4iskaLp31yzpAc0xv3iFyeXtWOzhb701s
         +A8uibPrCCP+sG+Fd7nOorXrU1gtryXvylSrrLsGly3uwlSBiafBYkb+XLlwP5dhr5FM
         xvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109227; x=1700714027;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JnX6LhDVyRia5AIt4T5fsWFKT3oTlNbS/+dMYZ6fZQ=;
        b=NR14jfLpnvzpaxwkSLgMUz5bOCNzluldLDU/irba/I2zDiL3npVV7olpR+wCWO9Rkj
         gHV6tCL3gB+86snGrBdXeZI4mu/4zusCZpsuzqA2ErGf83QcZbYiOvpUGtj+j6r6+wfV
         6TGVOLPrqBbJp6Y4R3tDe7AK1CKFvKrD0VBd9LrYSCZh+jrG7K+oBVvm98bredKlodN4
         +zQCUcFjQVnlRsS4C6m+p/Wm0a3Byncu2AS0wnGHfiQusEiTPHkom7kAwpalAr3aWAZ9
         +cKr7MuSDn1coOrlu4q7e8VTfAYQ191nflV3erLMyLb2Kfjiu6KcxRMl4ODY+fMnFaBj
         hBvw==
X-Gm-Message-State: AOJu0Yz5mZE7s1DBZSDxtlAQfc88hor4aYOhQf7iGMVcjg4pirS/GSG+
        qa67ZMfNR1v6LjdfeoPlLjbJ
X-Google-Smtp-Source: AGHT+IHfo74mq9awQWwORNNl/SJsz0tMju17DF0SkQPXgHULIEfdwSZtzepXS9fSQ+d8wK7ugySoKw==
X-Received: by 2002:a25:b4b:0:b0:d9a:be79:c902 with SMTP id 72-20020a250b4b000000b00d9abe79c902mr14846966ybl.53.1700109227402;
        Wed, 15 Nov 2023 20:33:47 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s20-20020a05621412d400b00647386a3234sm1081913qvv.85.2023.11.15.20.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:46 -0800 (PST)
Date:   Wed, 15 Nov 2023 23:33:46 -0500
Message-ID: <3d5492a66547c78a888b4256ec0a73f4.paul@paul-moore.com>
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
Subject: Re: [PATCH v5 11/23] security: Introduce inode_post_removexattr hook
References: <20231107134012.682009-12-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-12-roberto.sassu@huaweicloud.com>
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
> the inode_post_removexattr hook.
> 
> At inode_removexattr hook, EVM verifies the file's existing HMAC value. At
> inode_post_removexattr, EVM re-calculates the file's HMAC with the passed
> xattr removed and other file metadata.
> 
> Other LSMs could similarly take some action after successful xattr removal.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/xattr.c                    |  9 +++++----
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  5 +++++
>  security/security.c           | 14 ++++++++++++++
>  4 files changed, 26 insertions(+), 4 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index ce3bc7642e18..8aa6e9f316dd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2452,6 +2452,20 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>  	return evm_inode_removexattr(idmap, dentry, name);
>  }
>  
> +/**
> + * security_inode_post_removexattr() - Update the inode after a removexattr op
> + * @dentry: file
> + * @name: xattr name
> + *
> + * Update the inode after a successful removexattr operation.
> + */
> +void security_inode_post_removexattr(struct dentry *dentry, const char *name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;

Similar comment about the S_PRIVATE check as was in patch 10/23.

> +	call_void_hook(inode_post_removexattr, dentry, name);
> +}
> +
>  /**
>   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
>   * @dentry: associated dentry
> -- 
> 2.34.1

--
paul-moore.com
