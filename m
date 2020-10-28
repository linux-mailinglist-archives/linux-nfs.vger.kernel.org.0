Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF05129DECD
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 01:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391012AbgJ2A4W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Oct 2020 20:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731617AbgJ1WRg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:36 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75ADC22275;
        Wed, 28 Oct 2020 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603869365;
        bh=BSxR9G99QZZs9WQft0msIQGjwPYUjz+YA1ZtZ90swg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ztI4+WMUvZa0GWBnfKsmFMQgiwsXUHvSmBC0cGW2zG4/jBiYdYKeimxRCZUGVtSzY
         NKX8OJOH0OC8jpwXKQEE570YqQVdwcjy+bJhU5rpVWZKm+OySoGTEKtYOuCbmWyfR9
         X0M3K4XN+1qkqv+KA2ebktet80+pHQUHutl5NI5o=
Date:   Wed, 28 Oct 2020 09:16:01 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 00/20] NFSD support for multiple RPC/RDMA chunks
Message-ID: <20201028071601.GA114054@unreal>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
 <20201027060823.GF4821@unreal>
 <DAC657D8-D254-452C-9B21-3053F70C8C73@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAC657D8-D254-452C-9B21-3053F70C8C73@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 27, 2020 at 09:24:54AM -0400, Chuck Lever wrote:
> Hi Leon-
>
> > On Oct 27, 2020, at 2:08 AM, Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Oct 26, 2020 at 02:53:53PM -0400, Chuck Lever wrote:
> >> This series implements support for multiple RPC/RDMA chunks per RPC
> >> transaction. This is one of the few remaining generalities that the
> >> Linux NFS/RDMA server implementation lacks.
> >>
> >> There is currently one known NFS/RDMA client implementation that can
> >> send multiple chunks per RPC, and that is Solaris. Multiple chunks
> >> are rare enough that the Linux NFS/RDMA implementation has been
> >> successful without this support for many years.
> >
> > So why do we need it? Solaris is dead, and like you wrote Linux systems
> > work without this feature just fine, what are the benefits? Who will use it?
>
> The Linux NFS implementation is living. We can add the ability
> to provision multiple chunks per RPC to the Linux NFS client at
> any time.
>
> Likewise any actively developed NFS/RDMA implementation can add
> this feature. The RPC/RDMA version 1 protocol does not have the
> ability to communicate the maximum number of chunks the server
> will accept per RPC.
>
> Other server implementations do support multiple chunks per RPC.
> The Linux NFS/RDMA server implementation has always been incomplete
> in this regard.
>
> And the Linux NFS server implementation (the non-transport specific
> part) already supports multiple data payloads per NFSv4 COMPOUND.

Thanks, I just got different feeling then I read the cover letter.
You presented it like no one needs this feature.

Thanks
