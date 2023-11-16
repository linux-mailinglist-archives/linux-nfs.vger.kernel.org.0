Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B28F7EDAC3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 05:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344454AbjKPEd6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Nov 2023 23:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjKPEdy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Nov 2023 23:33:54 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E20193
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 20:33:50 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6707401e22eso2197796d6.2
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 20:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109229; x=1700714029; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PiCZavu6LdpgpM7KuxDInwsa5hKVtQaIjvj5PjS4lZk=;
        b=ArJDfkxJVTmtJZSuQe1mYkq9tdPwQI1OqbLQvmGxM2kb4rbr6ELI9wtIh8g/55oh03
         x+RTp0tFaDMUjWsgcYM/hGKF0OJohxJjKwWG2wp4+2haoCyNxHPZ5+AFwaa78tlha+SZ
         /HOuxo/C5016LJOTgLl6yL06ft+aE7Q1Z7MH8MxX+5/2Ts3BN951h/gdtQVVru/ONRHG
         SrI/WvJNDd04gv1G9r1pmLdCeNVdaM8ddYIO+Gg869bSD2m2Y8ewQq44b/cccFRLv3Bb
         cpviVnjhNs2PakukycYJzfuobRKEhuNCeqVjnAyqd7DLLhCs8py3bOA4m7FcSpjJzlUe
         4S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109229; x=1700714029;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiCZavu6LdpgpM7KuxDInwsa5hKVtQaIjvj5PjS4lZk=;
        b=CTp5SvEaI43eVhB+3J1uIZsw3DQqMejWtRAiWJqjHh0x8gpobnbKmOlvpQm4dyf2tg
         dsfp4kv9SK3liu9DQPRx0B6rh3p7OTCLLIqhWA/8T97boAVp44yW0LCtEQT/GNiRUdhI
         1WKCqgts+A6cAokMOF44wa7PbvCaWnnfK6FOjJ3zdLHWDzvqGsI/apBI92/lyG7bo5SR
         c647rRWDUwuCZRXMuJj0iyZ7wV17iPohaiCbiUj434/NtrRZeUpiUXCjLUV8DB3WFFRf
         hrVaisQhDVAgjmfZ1rSX2PfhKLR0x7TtPTs6f4IqCz//+/Cp8kn8ymPPAkTxvqxHwkMM
         a2AA==
X-Gm-Message-State: AOJu0YyDRRDWCE+eYioK9SB6uXQUt/b+uqzn0kqE67n4gYPhSXM2vspK
        HJohmGFz2cjRsTgr1iH4XWlv
X-Google-Smtp-Source: AGHT+IHFUYiKsS0jS8t0pJXCpW7lmlBdYw6GTVsA7PTusM9p7OTowW12ngLkrVF8XwrOUQ8Pi+Gx1A==
X-Received: by 2002:a05:6214:32f:b0:66f:bcc2:8724 with SMTP id j15-20020a056214032f00b0066fbcc28724mr7722038qvu.40.1700109229406;
        Wed, 15 Nov 2023 20:33:49 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id cx15-20020a056214188f00b0066cfbe4e0f4sm1092632qvb.26.2023.11.15.20.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:48 -0800 (PST)
Date:   Wed, 15 Nov 2023 23:33:48 -0500
Message-ID: <9239b0744e5c9a006dd4fe88c8cdc41b.paul@paul-moore.com>
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
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 15/23] security: Introduce inode_post_create_tmpfile  hook
References: <20231107134012.682009-16-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-16-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_create_tmpfile hook.
> 
> As temp files can be made persistent, treat new temp files like other new
> files, so that the file hash is calculated and stored in the security
> xattr.
> 
> LSMs could also take some action after temp files have been created.
> 
> The new hook cannot return an error and cannot cause the operation to be
> canceled.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/namei.c                    |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 15 +++++++++++++++
>  4 files changed, 24 insertions(+)

...

> diff --git a/security/security.c b/security/security.c
> index 5eaf5f2aa5ea..ca650c285fd9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2013,6 +2013,21 @@ int security_inode_create(struct inode *dir, struct dentry *dentry,
>  }
>  EXPORT_SYMBOL_GPL(security_inode_create);
>  
> +/**
> + * security_inode_post_create_tmpfile() - Update inode security of new tmpfile
> + * @idmap: idmap of the mount
> + * @inode: inode of the new tmpfile
> + *
> + * Update inode security data after a tmpfile has been created.
> + */
> +void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
> +					struct inode *inode)
> +{
> +	if (unlikely(IS_PRIVATE(inode)))
> +		return;

See my previous comments/questions about checking for S_PRIVATE here.

> +	call_void_hook(inode_post_create_tmpfile, idmap, inode);
> +}
> +
>  /**
>   * security_inode_link() - Check if creating a hard link is allowed
>   * @old_dentry: existing file
> -- 
> 2.34.1

--
paul-moore.com
