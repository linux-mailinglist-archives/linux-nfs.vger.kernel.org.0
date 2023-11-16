Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB7D7EDAC8
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 05:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjKPEd7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Nov 2023 23:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjKPEdz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Nov 2023 23:33:55 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511F6D4D
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 20:33:51 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77ba6d5123fso136382185a.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 20:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109230; x=1700714030; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QkyYJfnzm1A7HGn47wCcQYDeiYTgoVSzUDXfMA9+Fmw=;
        b=OueZXl8NzyZo8bZgJea+dZmFlLJjO74Ra2CopP/Qgur/mLt0dhmZVdCDsqNeS4ip94
         UIBt6XDH7viAJ4m2+9I7XFVAWX7TJV/IWqS6Kd5F9txUgeL4Dekfo7BRAmjwdmgEE/s1
         +TmoXy5u4Kbk/gF02UeYMmMlYOkMluVfkbnmWz5e8TLWygyFBFKyJXaFRk+xPt1EcHdV
         MBdP6pJ3r5Vx4PWcLf3BWAzuYy4hQntcXLEpGxcW+78Rdho7TZ85xn06h6NAgk/8rWlq
         FueizRW4rNkDdsMjbmKAnMlt2K7cgjMZ+Bet58IGWy17Imr5Gm67PEfZB0eW9hN8snud
         utqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109230; x=1700714030;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QkyYJfnzm1A7HGn47wCcQYDeiYTgoVSzUDXfMA9+Fmw=;
        b=VlXLPBNTnHLx6qyh8LD6cxpv7m6kqOocVhBogovm3BezZq1FwxMbi5r+dG98H65KEL
         lFd6VFsTwClMPeXdBPp4aYcQeFdal62q7cP7TVwZ0CoZawc+J6TB8T2sXKdqowRBLg/X
         w8BWv1qhZDRYcbHewTH6gpi8bkIncV7xwBeMX5UXd8s9mDRmw/cq5vekiqu6ral7lLnG
         WcMsoUCx6PvJeRCU7VUrsV4nmiqbSOl9U+oR/3hYYobMBkbIiRRaAwCtliRrL9r6tOB9
         SsiG+TRe9LxPwXQFTCquEq5oW8NBy1tK9pvAW3w1qcr812Ql9rK4K1x188dhgOyax7SU
         eV3g==
X-Gm-Message-State: AOJu0YzJkhzC1Y+ugcFMKZd6oFUx8xFd4YABiHLu4e2q7qVuo18+ivYc
        Uq+A5zYFMVGzN/CB/Kn37Jrz
X-Google-Smtp-Source: AGHT+IGRS7nQEJCXY6T/nN7yC1vAx+U0DJtezCw7jd5lMHyaQY5xg8Dk8QLP0DAu6DJyxDh395lJwA==
X-Received: by 2002:a05:620a:19a8:b0:76f:1614:577a with SMTP id bm40-20020a05620a19a800b0076f1614577amr844860qkb.5.1700109230369;
        Wed, 15 Nov 2023 20:33:50 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bi33-20020a05620a31a100b0077703f31496sm4001433qkb.92.2023.11.15.20.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:49 -0800 (PST)
Date:   Wed, 15 Nov 2023 23:33:49 -0500
Message-ID: <add2fed4552b4cbc2919caf54e97646d.paul@paul-moore.com>
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
Subject: Re: [PATCH v5 16/23] security: Introduce inode_post_set_acl hook
References: <20231107134012.682009-17-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-17-roberto.sassu@huaweicloud.com>
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
> the inode_post_set_acl hook.
> 
> At inode_set_acl hook, EVM verifies the file's existing HMAC value. At
> inode_post_set_acl, EVM re-calculates the file's HMAC based on the modified
> POSIX ACL and other file metadata.
> 
> Other LSMs could similarly take some action after successful POSIX ACL
> change.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/posix_acl.c                |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 27 insertions(+)

...

> diff --git a/security/security.c b/security/security.c
> index ca650c285fd9..d2dbea54a63a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2350,6 +2350,23 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
>  	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
>  }
>  
> +/**
> + * security_inode_post_set_acl() - Update inode security from posix acls set
> + * @dentry: file
> + * @acl_name: acl name
> + * @kacl: acl struct
> + *
> + * Update inode security data after successfully setting posix acls on @dentry.
> + * The posix acls in @kacl are identified by @acl_name.
> + */
> +void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
> +				 struct posix_acl *kacl)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;

Another case where the existing evm_inode_post_set_acl() hook doesn't
check S_PRIVATE but this hook does.

> +	call_void_hook(inode_post_set_acl, dentry, acl_name, kacl);
> +}
> +
>  /**
>   * security_inode_get_acl() - Check if reading posix acls is allowed
>   * @idmap: idmap of the mount
> -- 
> 2.34.1

--
paul-moore.com
