Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD042F8C4
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbhJOQyG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Oct 2021 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241689AbhJOQyE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Oct 2021 12:54:04 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB762C061766
        for <linux-nfs@vger.kernel.org>; Fri, 15 Oct 2021 09:51:57 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f11so4967009pfc.12
        for <linux-nfs@vger.kernel.org>; Fri, 15 Oct 2021 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8gI6mB0v8/bvGUktJ4Ms64SCq44VzGlslt0/tVmUcu0=;
        b=QdjfyqDFD4soQMEMSOicdhBdVamKBaYeLFRjv2+GeJkhkobBQ1wXcffRbrMri+SgXS
         ho2ZSrthIeYBE7Wx2MPp5VyuPKs5uKhB2/hHDVUacoeny7NW+A6nzAebO0KCgT+nfajN
         4woprmqITLxBlJcOq6oS9FryrMRcuTjaoqcfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8gI6mB0v8/bvGUktJ4Ms64SCq44VzGlslt0/tVmUcu0=;
        b=YPgeJ5F2Tv0GiaAb3ysFjRfDijGlZUSOnIptie8lXWtmSSR4RCMcHCTxjmRsYlw0Kt
         dUNYJMS1rffs4yoD4dGwLZKaOypP5cOG5BVyFPeby89udU/XXoySQbFK59L9VfZ+Zi8v
         /rlkUSMqWDbT6EhHYz1hGLAMEgqpU173FjqIj4svuMRPp7gIBS7N0PC3+sAPh5u63Z0v
         4nF9ld+px6tqLlDnr8NoMe/3V1UVOjNuuUzdDnqU8ngmx0qrNl9a9IyXB/SegoOJCjgq
         0YUkgIWVToYWlR70hTbCkW/D560P9a7L2E0dSGHdvNbbxYbcf2QfDa4zXPEaD63TGvaG
         ooaQ==
X-Gm-Message-State: AOAM530phwEKnHfvUaB2DO7SY09j5jH9SJoJNZGFZlKYv5dxwzyh2wBq
        c1qyxdLaAIqBmMsro2+oBc3aPA==
X-Google-Smtp-Source: ABdhPJzqeoukQXK8ExXBqth3GcTvhtURMxE+sN7W7wsB5KXgmz+OQ2/XE0rohu9GSzNW6fPwLJfBIw==
X-Received: by 2002:a05:6a00:1a15:b0:44d:a80:a194 with SMTP id g21-20020a056a001a1500b0044d0a80a194mr12521866pfv.78.1634316717195;
        Fri, 15 Oct 2021 09:51:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w18sm5617464pfj.170.2021.10.15.09.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:51:56 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:51:56 -0700
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
Subject: Re: [PATCH 13/30] cramfs: use bdev_nr_bytes instead of open coding it
Message-ID: <202110150951.94FEBC4C@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-14-hch@lst.de>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 15, 2021 at 03:26:26PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
