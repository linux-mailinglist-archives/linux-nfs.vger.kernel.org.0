Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C0268035A
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jan 2023 01:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjA3AqH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 Jan 2023 19:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3AqG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 Jan 2023 19:46:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D744D18B38;
        Sun, 29 Jan 2023 16:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E0dI9WJbm3E3fwl13sasNvX+4Pysw9wMqt9GlJqOFU0=; b=a3xkCMyPLYE+IVud3xNXU0BaP8
        P23nG4IrmemJyqGFY5buUCa9b4cXSXOwBCumy1GB4KKreoZf9lV1dXuC70YoEdFJFFjFx+Rp3dOiS
        MnMHypx1+fRcQAgTref2TIU7sbWq2EURD/wOOkIpIhoXQtc631uu7+dqta7QRtDhOSbum+bN+o5UH
        tuFvGG/KpL39PUncGWs3kDSnIC/F1ZQWMwtoQRIOQCF8hfukeGz6dhFbGi9YOZ2zf421d2OhOwTGz
        ySGY1mHr24PQywAa0Lh+5mPLeMGBrft1IYTnmk+gH+usFRRY2tikY9H7yKD8sMUPPouvEZVE0SLPB
        jjp4Z2NA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMIIw-0025l3-I5; Mon, 30 Jan 2023 00:45:51 +0000
Date:   Sun, 29 Jan 2023 16:45:50 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] fs/nfs: Replace kmap_atomic() with kmap_local_page() in
 dir.c
Message-ID: <Y9cTPu4PAbtjaeaR@bombadil.infradead.org>
References: <20230127215452.6399-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127215452.6399-1-fmdefrancesco@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 27, 2023 at 10:54:52PM +0100, Fabio M. De Francesco wrote:
> kmap_atomic() is deprecated in favor of kmap_local_page().
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page-faults, and can be called from any context (including interrupts).
> Furthermore, the tasks can be preempted and, when they are scheduled to
> run again, the kernel virtual addresses are restored and still valid.
> 
> kmap_atomic() is implemented like a kmap_local_page() which also disables
> page-faults and preemption (the latter only for !PREEMPT_RT kernels,
> otherwise it only disables migration).
> 
> The code within the mappings/un-mappings in the functions of dir.c don't
> depend on the above-mentioned side effects of kmap_atomic(), so that mere
> replacements of the old API with the new one is all that is required
> (i.e., there is no need to explicitly add calls to pagefault_disable()
> and/or preempt_disable()).
> 
> Therefore, replace kmap_atomic() with kmap_local_page() in fs/nfs/dir.c.
> 
> Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
