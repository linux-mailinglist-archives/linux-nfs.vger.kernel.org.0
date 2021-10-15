Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0957942F901
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbhJOQ4o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Oct 2021 12:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbhJOQ4n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Oct 2021 12:56:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0856C061768
        for <linux-nfs@vger.kernel.org>; Fri, 15 Oct 2021 09:54:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id g5so6774130plg.1
        for <linux-nfs@vger.kernel.org>; Fri, 15 Oct 2021 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=++j3EKFYagTjYpVDRmVtpilprtSSGPZNL/U6+y1BFYU=;
        b=PGVMrxoIP54zTy3fYRiGwM3tLAZD1Sg5qwTZ/1sUpFUKPeoK4gaEUh4gDn9vmINL5R
         K6Diz6OFYGVqe3eH+J4BPfR7/r8fI1+hdPS73Dcjh+YNC+lZ5T7DwLWnu9B82X3frAPd
         N9HCX5/hrMJFRwzEMhEqi5qndMOp+CdKnJFuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=++j3EKFYagTjYpVDRmVtpilprtSSGPZNL/U6+y1BFYU=;
        b=YNaYDbbQYt1U1cdTaYS4FODjtyIMjGkDVZn9Bc7uB7MDFVcqFHuIZcSWZAyq7j1s4E
         6j/sxUujRr64XyKdRumFibIC9McoG2zjj8VFD6YwZjV9gw1MI796kYwkCozPmFCDWb20
         fENVansY/PlAt+BN1bhfp4G0RFzHnIj8yPBKFi75hHwbxDrgwu4JWaalk2oT/tKe/xx8
         2gnt4YZwY7U0wLy9eMEWTBoSbzMsTuCHAbmQjhH0fgIp8O6QaVmbBMjDD2HbqJATlKry
         Lx5OD+XarSUawrYxCQKwxkCtCnopsZHM1lvxdEC1l+HJwtRvM33zotAdrUqcO3rfEc2g
         1a/A==
X-Gm-Message-State: AOAM532eqhkOlW/J12TzsuFi7w9TLoNZKrP4JbKZWFX1KuSj8pTOyg1T
        5pY091m3/RpR56h97mfLudy5AA==
X-Google-Smtp-Source: ABdhPJxiUcnkoooEgdTHhZSK5QlfnfikulhFK8mfbnmCN2PXzxc7k6fawv/6LA10hComZoogNKw4PQ==
X-Received: by 2002:a17:903:3092:b0:13f:663d:f008 with SMTP id u18-20020a170903309200b0013f663df008mr11973339plc.13.1634316876253;
        Fri, 15 Oct 2021 09:54:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t126sm5505715pfc.80.2021.10.15.09.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:54:35 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:54:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 19/30] nilfs2: use bdev_nr_bytes instead of open coding it
Message-ID: <202110150954.45A4DFA79@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-20-hch@lst.de>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 15, 2021 at 03:26:32PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
