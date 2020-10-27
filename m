Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9FA29A479
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 07:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506253AbgJ0GI2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 02:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506251AbgJ0GI2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Oct 2020 02:08:28 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3760A207BB;
        Tue, 27 Oct 2020 06:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603778907;
        bh=WP3q6woHndwr1etIplF7KIz1C0FwXTTk/4sAmpv1O30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjTbBz6G5ue2iFFybKYFxFGw6fpEQQamv/3kluzAUqpRpiiae68YC+/GV3Pq61WzE
         6pvFqHRqAm6ZNQpbeUc59J1QWWkxwYEIkkAHh8IdEdxDtBEV45pKibFKaYhkVTK0UI
         JpmaolwdnM7OQ8F3ZkB4xJpdwAp9eXjp9W9Ka0CI=
Date:   Tue, 27 Oct 2020 08:08:23 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 00/20] NFSD support for multiple RPC/RDMA chunks
Message-ID: <20201027060823.GF4821@unreal>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 26, 2020 at 02:53:53PM -0400, Chuck Lever wrote:
> This series implements support for multiple RPC/RDMA chunks per RPC
> transaction. This is one of the few remaining generalities that the
> Linux NFS/RDMA server implementation lacks.
>
> There is currently one known NFS/RDMA client implementation that can
> send multiple chunks per RPC, and that is Solaris. Multiple chunks
> are rare enough that the Linux NFS/RDMA implementation has been
> successful without this support for many years.

So why do we need it? Solaris is dead, and like you wrote Linux systems
work without this feature just fine, what are the benefits? Who will use it?

Thanks
