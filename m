Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC1542B6E4
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 08:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbhJMGS5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbhJMGS4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Oct 2021 02:18:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF601C061768
        for <linux-nfs@vger.kernel.org>; Tue, 12 Oct 2021 23:16:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id np13so1363539pjb.4
        for <linux-nfs@vger.kernel.org>; Tue, 12 Oct 2021 23:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vr2Ti0XXPw/GzVjOiY0OfTomtbZYRULNYJUDEzmrzO4=;
        b=K4nvDpNl1g5m539wsQDBpCbf3zo170v/GW6ZnHLXNDrULUU4yYZgBZyGAb+wBnnkpe
         Kw4TilugsMOouo/bETIRMTNNbwFs2By6YycSQiwP6WhM+z5A0iE/rlwHD7YheTZVwxWg
         UujJ8p17bj864LNgI93in3n9RRNxotwxYx6iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vr2Ti0XXPw/GzVjOiY0OfTomtbZYRULNYJUDEzmrzO4=;
        b=4r3rId5P3LiBrZKaN01NxiZ4Ec5Znnkto5+fKrpq7muEfHEIT4dbTQlDwV1BsXbb17
         nk5b6buQDCG3y9NpGd3mnfZBjxR9l6D+sRZ8Alf048zn/5brNqaJaxfzmJ53FwF3sH63
         enf8wpuZh1x5+9cDGw40mbA/u52xLnDRTGSsRZIJzliu1Kp16kR95O8EDlTBckIGgt16
         3PPjit6Rr4Ft84ZzuD7QpJQzVT6laeKNMPw9rz7nFNBYl5/e2PGHqWUBECHYCuj3MyfK
         QRo58C99gI31XucZowXns0kdK46CCHQm71CDLwa7VH1m7y6cy6gTrQJFqtVRSnYyiw3C
         hxAg==
X-Gm-Message-State: AOAM533pfq7M3yqzIBI3FUMpdyDIA5o/TNa9t6Oa7u+1ezqV3PC5OBEQ
        tOm2IP45+9HTWjFs/fbQyo5mXg==
X-Google-Smtp-Source: ABdhPJyviIqYDhsPW2xustTPT0ttTkhiIBbQskiTA4bVnp1eNaDrTHxU5FKFz1farm1RVUHRoFmswQ==
X-Received: by 2002:a17:90b:1c8f:: with SMTP id oo15mr11110082pjb.169.1634105812260;
        Tue, 12 Oct 2021 23:16:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c64sm7486893pga.40.2021.10.12.23.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:16:51 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:16:51 -0700
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
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 15/29] hfsplus: use bdev_nr_sectors instead of open
 coding it
Message-ID: <202110122316.9C54C2F@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-16-hch@lst.de>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:28AM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
