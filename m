Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E657A62D26C
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 05:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiKQE6D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 23:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiKQE6B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 23:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311E92B180
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 20:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668661026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cRNgsje5v+iSsOtKxKODca+zMELkto4gAPpZd/JZ4Wo=;
        b=UWDu68h1PVK3ShlNTALbY4GMc4uIKbPm4lEOI5019Vxd6JSranyUHHyg45d2+jHR/cGw2K
        a78q3+A43mO2u/xjEoSNA0HHDcHfYepa1BYhF/J4iQezb5U1UHKzR7SxCfGdtvznH4jslg
        Oy+E2yeZFCUKBv/5BAZSJSZgoGh0rEg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-zIJJf7eDMxSPxbwJ8dbw_Q-1; Wed, 16 Nov 2022 23:57:04 -0500
X-MC-Unique: zIJJf7eDMxSPxbwJ8dbw_Q-1
Received: by mail-pg1-f199.google.com with SMTP id g193-20020a636bca000000b00476a2298bd1so629007pgc.12
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 20:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRNgsje5v+iSsOtKxKODca+zMELkto4gAPpZd/JZ4Wo=;
        b=2FXwyLheuedNNttgnHl+1Gnx/CkUd1RYlbUBSJqZv2urnLEOuJRhS4B70/U+udxSU1
         kztjbFpfM3Foe1enV/F9daYC6IDbsJHS6WJCnNHH7we7mhZvIIhe5GrJxPSSy9DxaHAe
         owBV8kJ+IFxNF61/12gh9Xii8CuIQLBnUQUaUJ7K/pFOeAi2Pj1KCj8BoMDmZwBnJT6r
         F3r6ey3FlzBrc0zi4fDQ7VLrszDT9ugpscPYHArbWlkYOCsGYHkqnIFrHtQUEdQrRqcD
         UDgn5UZdTpyXFuA8hzAqUQLMKZOYi6eQNwe0Wyr/bt/maIyp6n7WqGF8QBKBDE7I1K8W
         4t0Q==
X-Gm-Message-State: ANoB5pkXlHSMiptXn7iNPmJce4kWJev/sQ6zWR5U0eEBZDU+fo45lSAE
        pSQJkub67ff71gwsoimXHEdE4sxmx6famjdU0IyTiDiIJFtp2VwfDHGmy3N+I5kPggA28JPpXCP
        q98maykU9fKskxXi23FHp
X-Received: by 2002:a63:5f14:0:b0:43c:969f:18a7 with SMTP id t20-20020a635f14000000b0043c969f18a7mr635972pgb.12.1668661023832;
        Wed, 16 Nov 2022 20:57:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf63NoWprGlJIf07cPSVNjoTzWwiwPuTUjMvYVGNkdFlaO5oAfTME7Qg7XG1sR+f67MLmbpQ7Q==
X-Received: by 2002:a63:5f14:0:b0:43c:969f:18a7 with SMTP id t20-20020a635f14000000b0043c969f18a7mr635959pgb.12.1668661023555;
        Wed, 16 Nov 2022 20:57:03 -0800 (PST)
Received: from [10.72.12.148] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090a55c600b0021870b3e4casm438628pjm.47.2022.11.16.20.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 20:57:03 -0800 (PST)
Subject: Re: [PATCH 2/7] ceph: use locks_inode_context helper
To:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, chuck.lever@oracle.com,
        viro@zeniv.linux.org.uk, hch@lst.de
References: <20221116151726.129217-1-jlayton@kernel.org>
 <20221116151726.129217-3-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <589a0fcc-569f-e5b2-0877-c1639736ae5e@redhat.com>
Date:   Thu, 17 Nov 2022 12:56:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221116151726.129217-3-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 16/11/2022 23:17, Jeff Layton wrote:
> ceph currently doesn't access i_flctx safely. This requires a
> smp_load_acquire, as the pointer is set via cmpxchg (a release
> operation).
>
> Cc: Xiubo Li <xiubli@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/locks.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index 3e2843e86e27..f3b461c708a8 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -364,7 +364,7 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
>   	*fcntl_count = 0;
>   	*flock_count = 0;
>   
> -	ctx = inode->i_flctx;
> +	ctx = locks_inode_context(inode);
>   	if (ctx) {
>   		spin_lock(&ctx->flc_lock);
>   		list_for_each_entry(lock, &ctx->flc_posix, fl_list)
> @@ -418,7 +418,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
>   				int num_fcntl_locks, int num_flock_locks)
>   {
>   	struct file_lock *lock;
> -	struct file_lock_context *ctx = inode->i_flctx;
> +	struct file_lock_context *ctx = locks_inode_context(inode);
>   	int err = 0;
>   	int seen_fcntl = 0;
>   	int seen_flock = 0;

Thanks Jeff!

Reviewed-by: Xiubo Li <xiubli@redhat.com>


