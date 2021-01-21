Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2EE2FF15A
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 18:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbhAURGg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 12:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388405AbhAURGK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 12:06:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E41C06178B;
        Thu, 21 Jan 2021 09:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WXp9P2+4ttOF7WOJ6N6+oYIjL/n1xFJfDmqOtrJBLpU=; b=gd4BKa4iFPPuT/lD2l4BSb7o3D
        CcZwhIeTFXpXFqJD7zm1KvhSW779Tw+VeuicSpzqOYgmQKe4y9bE4q0XwrV2FsRd0k3PdBFb+bpW/
        /RQs1TEqLYPidsbGr4wAwL0sHpKJEn9FCbbWRyhRHuoVk0i8QSB3Imxpsokzc9D3i8gabl7lj5xpS
        le/fJd0Q0THs9DBKuCcPcXJ4dZYELr7B/+V5dHjXnOgJjAHd+4JqUCv/DNHbG0Ng2PVhcxqxNrhGg
        e1ahOjpwMV0H6IKQqoBM0no7vfgQSDJsKHdBSL6kx7XXLhD8nhdOpQ3cL9dT1JDTT5SYOU8uSpxtx
        fdX0PhQg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2dNh-00HIE9-Vn; Thu, 21 Jan 2021 17:04:26 +0000
Date:   Thu, 21 Jan 2021 17:04:25 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove unnecessary argument from
 blk_execute_rq
Message-ID: <20210121170425.GB4120717@infradead.org>
References: <20210121142905.13089-1-guoqing.jiang@cloud.ionos.com>
 <20210121142905.13089-3-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121142905.13089-3-guoqing.jiang@cloud.ionos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 21, 2021 at 03:29:05PM +0100, Guoqing Jiang wrote:
> We can remove 'q' from blk_execute_rq as well after the previous change
> in blk_execute_rq_nowait.

Same trivial nits as for the other one.

Otherwise this looks good to me.
