Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A7846A1D5
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Dec 2021 17:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbhLFQzN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Dec 2021 11:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241934AbhLFQzM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Dec 2021 11:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638809503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALfiGm92aK8PxZSE9ytTc2Xl6Q2oMvchNJ3nVc75rJE=;
        b=XXJQYJJQua8c16uu6adsZmrQ/5OPcDMS9/Z5FrX4JzxPIL1KNMZ3t2Vc3E5RVLX7hm2Jm1
        YXQwf6Z1XpF+L+BdpG38/fNoSRJ9gw9jG48M1GWR+I/V2r+32HMgH659XdgnvMme7s/gid
        Uz938u0ZnPNxZn3U+d2Q2v+ABeBdw+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-Pz7Cu2M7PyuCWH4f8SxkRw-1; Mon, 06 Dec 2021 11:51:40 -0500
X-MC-Unique: Pz7Cu2M7PyuCWH4f8SxkRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AF54101AFA8;
        Mon,  6 Dec 2021 16:51:39 +0000 (UTC)
Received: from plambri-desk (unknown [10.33.36.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 149C160BF1;
        Mon,  6 Dec 2021 16:51:37 +0000 (UTC)
Date:   Mon, 6 Dec 2021 16:51:35 +0000
From:   Pierguido Lambri <plambri@redhat.com>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH] SUNRPC: Add source address/port to rpc_socket* traces
Message-ID: <20211206165135.rgrnrurxtydnnqjy@plambri-desk>
References: <20211202181308.279592-1-plambri@redhat.com>
 <CALF+zOm32pbbnAVrVdWte1=MC_COEfUqjyDf++OqrcS0gc4dHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALF+zOm32pbbnAVrVdWte1=MC_COEfUqjyDf++OqrcS0gc4dHA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 06, 2021 at 09:54:30AM -0500, David Wysochanski wrote:
> >                 TP_printk(
> > -                       "socket:[%llu] dstaddr=%s/%s "
> > +                       "socket:[%llu] srcaddr=%pISpc dstaddr=%pISpcst "
> 
> Shouldn't the above scan code be the same as dstaddr below: "dstaddr=%pISpc "

Yes, not sure why the extra "st", but it should be "dstaddr=%pISpc"
indeed. I can resend it with the correct format.

Thanks,

Pier

