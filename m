Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2A77EDAE0
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 05:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbjKPEeP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Nov 2023 23:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjKPEd5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Nov 2023 23:33:57 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F14C1A3
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 20:33:53 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41ccd38eaa5so3533121cf.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Nov 2023 20:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109232; x=1700714032; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pTk7a67S1QtD8sba7dPNc/tDHo+LguzreZvYAY1S4fY=;
        b=QNxLd/OQnTNMmenq2+mNq4v5DLEMf5UVSLWa4Rr0TGvf7arRBJRWB8tkqk1zXmO6jS
         G6NBVvrLQNtS5Wg/KyqNcLQBGZvNNzwaIOLKjZTIrnlVwo4btxdIv8Xm7ZXO0EqKAJX3
         qZ8Kq5FAoV+Y3Ccnp3Cl9l4dIV2jfSHghxFeJo9XBlmBFQ+/AtTJ4kT6a1MOMsVKJbw3
         xBhJnJZL4D9VQl+w9Dn/Up7hfA7UGEm4Z2LtMQleLvCb0ncc2rfz47vOIBGtcQhdB1zW
         8ae9RaG3KxtmP2T/k4mJsi8uIKnNHpPh4s3dFQ7EvPs7SR1gOvldrQ/2Q2BMrJ7Nwr1G
         Kp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109232; x=1700714032;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTk7a67S1QtD8sba7dPNc/tDHo+LguzreZvYAY1S4fY=;
        b=fAtAYWzQon5TN7Csz7aWdqdyWYn0MWnfyKLLpMu8y6cUStTo1bZLJDhScqsdvAXfiY
         TXtUOSA+lJySpw2PmF2NaUPhK04wQR+5s1jfrcoVza3DX3LdqhUN76ipXh829ElwAIEv
         kHYCwG6FVu5buPnT4c2Ax5rIFrybBfb/j/aDC+nCtnk3iy2ukIJSIUWE+8Yy3vnPGF4E
         BB2zwiO7BqVHEzhH3wepsX63kJjiYPm0fRusPqW9xz1BCg/Z9ktBAFkQoGPApgEaZQ9F
         FLjRiHUnrNwrNG8Xas7XLc1XzBEd3YPDk/EMFvPCD+wLdJl5DmJ5v39kiU5RtwbgyLnA
         7z8w==
X-Gm-Message-State: AOJu0YyMRr+LsYMUM675+kHsLTA1jf71h1lL0SQsmWZervyx7NG3JIr3
        jZMrlM57Piko3DdPz3Y2N+rK
X-Google-Smtp-Source: AGHT+IE6tK6IBkeFsEiWjCzdnINS6WA30ZUhupFJIZkUjsjh41YBZxyWDozBggH4FWZCSzCDyuP/4g==
X-Received: by 2002:ac8:5706:0:b0:41c:c27e:f8f6 with SMTP id 6-20020ac85706000000b0041cc27ef8f6mr676761qtw.23.1700109232335;
        Wed, 15 Nov 2023 20:33:52 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id y2-20020ac85242000000b004198f67acbesm4045202qtn.63.2023.11.15.20.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:51 -0800 (PST)
Date:   Wed, 15 Nov 2023 23:33:51 -0500
Message-ID: <f529266a02533411e72d706b908924e8.paul@paul-moore.com>
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
Subject: Re: [PATCH v5 22/23] integrity: Move integrity functions to the LSM  infrastructure
References: <20231107134012.682009-23-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-23-roberto.sassu@huaweicloud.com>
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
> Remove hardcoded calls to integrity functions from the LSM infrastructure
> and, instead, register them in integrity_lsm_init() with the IMA or EVM
> LSM ID (the first non-NULL returned by ima_get_lsm_id() and
> evm_get_lsm_id()).
> 
> Also move the global declaration of integrity_inode_get() to
> security/integrity/integrity.h, so that the function can be still called by
> IMA.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  include/linux/integrity.h      | 26 --------------------------
>  security/integrity/iint.c      | 30 +++++++++++++++++++++++++++++-
>  security/integrity/integrity.h |  7 +++++++
>  security/security.c            |  9 +--------
>  4 files changed, 37 insertions(+), 35 deletions(-)

...

> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 0b0ac71142e8..882fde2a2607 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -171,7 +171,7 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>   *
>   * Free the integrity information(iint) associated with an inode.
>   */
> -void integrity_inode_free(struct inode *inode)
> +static void integrity_inode_free(struct inode *inode)
>  {
>  	struct integrity_iint_cache *iint;
>  
> @@ -193,11 +193,39 @@ static void iint_init_once(void *foo)
>  	memset(iint, 0, sizeof(*iint));
>  }
>  
> +static struct security_hook_list integrity_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(inode_free_security, integrity_inode_free),
> +#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> +	LSM_HOOK_INIT(kernel_module_request, integrity_kernel_module_request),
> +#endif
> +};
> +
> +/*
> + * Perform the initialization of the 'integrity', 'ima' and 'evm' LSMs to
> + * ensure that the management of integrity metadata is working at the time
> + * IMA and EVM hooks are registered to the LSM infrastructure, and to keep
> + * the original ordering of IMA and EVM functions as when they were hardcoded.
> + */
>  static int __init integrity_lsm_init(void)
>  {
> +	const struct lsm_id *lsmid;
> +
>  	iint_cache =
>  	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>  			      0, SLAB_PANIC, iint_init_once);
> +	/*
> +	 * Obtain either the IMA or EVM LSM ID to register integrity-specific
> +	 * hooks under that LSM, since there is no LSM ID assigned to the
> +	 * 'integrity' LSM.
> +	 */
> +	lsmid = ima_get_lsm_id();
> +	if (!lsmid)
> +		lsmid = evm_get_lsm_id();
> +	/* No point in continuing, since both IMA and EVM are disabled. */
> +	if (!lsmid)
> +		return 0;
> +
> +	security_add_hooks(integrity_hooks, ARRAY_SIZE(integrity_hooks), lsmid);

Ooof.  I understand, or at least I think I understand, why the above
hack is needed, but I really don't like the idea of @integrity_hooks
jumping between IMA and EVM depending on how the kernel is configured.

Just to make sure I'm understanding things correctly, the "integrity"
LSM exists to ensure the proper hook ordering between IMA/EVM, shared
metadata management for IMA/EVM, and a little bit of a hack to solve
some kernel module loading issues with signatures.  Is that correct?

I see that patch 23/23 makes some nice improvements to the metadata
management, moving them into LSM security blobs, but it appears that
they are still shared, and thus the requirement is still there for
an "integrity" LSM to manage the shared blobs.

I'd like to hear everyone's honest opinion on this next question: do
we have any hope of separating IMA and EVM so they are independent
(ignore the ordering issues for a moment), or are we always going to
need to have the "integrity" LSM to manage shared resources, hooks,
etc.?

>  	init_ima_lsm();
>  	init_evm_lsm();
>  	return 0;

--
paul-moore.com
