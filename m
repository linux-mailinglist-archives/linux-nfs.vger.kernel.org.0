Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AACF5791CF
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2019 19:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfG2RKV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 13:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfG2RKV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Jul 2019 13:10:21 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B6E5206BA;
        Mon, 29 Jul 2019 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564420220;
        bh=WXZfFhxm/6xNh9hebjHvhoHEDNNIu4jbigvgxOw6uS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zvZgYkvRo/Nb/7BSWXUMu0NQiOxf4sINcdgMyDAoJDJyx/tmQGJp4kU0S/f3N3Vdh
         NwuAILNrQQkHQihcUkoxpRQlpHK71vKe9Jc6IwOAEMorn2rDirM1gNoqBfcV+P11+W
         Fjlv9Tcv+1bTPpsceZ7XBAnLG6xE4MAC4uKbF8W8=
Date:   Mon, 29 Jul 2019 20:10:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
Message-ID: <20190729171016.GN4674@mtr-leonro.mtl.com>
References: <20190728163027.3637.70740.stgit@manet.1015granger.net>
 <20190729054933.GK4674@mtr-leonro.mtl.com>
 <20190729141945.GF17990@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729141945.GF17990@ziepe.ca>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 29, 2019 at 11:19:45AM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 29, 2019 at 08:49:33AM +0300, Leon Romanovsky wrote:
> > > +/**
> > > + * ib_alloc_cq_any: Allocate kernel CQ
> > > + * @dev: The IB device
> > > + * @private: Private data attached to the CQE
> > > + * @nr_cqe: Number of CQEs in the CQ
> > > + * @poll_ctx: Context used for polling the CQ
> > > + */
> > > +static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
> > > +					    void *private, int nr_cqe,
> > > +					    enum ib_poll_context poll_ctx)
> > > +{
> > > +	return __ib_alloc_cq_any(dev, private, nr_cqe, poll_ctx,
> > > +				 KBUILD_MODNAME);
> > > +}
> >
> > This should be macro and not inline function, because compiler can be
> > instructed do not inline functions (there is kconfig option for that)
> > and it will cause that wrong KBUILD_MODNAME will be inserted (ib_core
> > instead of ulp).
>
> No, it can't, a static inline can only be de-inlined within the same
> compilation unit, so KBUILD_MODNAME can never be mixed up.
>
> You only need to use macros of the value changes within the
> compilation unit.

Thanks, good to know.

>
> Jason
