Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1B123B7DB
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgHDJgn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 05:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgHDJgm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Aug 2020 05:36:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B0922B45;
        Tue,  4 Aug 2020 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596533802;
        bh=tLkmAKfM39iELVhtLgdrORtpCbCIiL/zT4iG08JlLu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2naIBEYV2FDAqu+ODACQkrhSFTQCOnbX1zyWdOdDTQGg1B+QtC8ygnY+PRTehjDQ
         RGiSVr6fFwuWzSDQCqpfG5uiSTS3QONGqPVzjqEu4EgiUyDv3W7jFDrK/VyX6UvLWe
         BRzV1cnwyDleLEVkp3pnS3VJQaQT8z9Rxz05Vf3M=
Date:   Tue, 4 Aug 2020 12:36:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: NFS over RDMA issues on Linux 5.4
Message-ID: <20200804093635.GA4432@unreal>
References: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
 <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 03, 2020 at 12:24:21PM -0400, Chuck Lever wrote:
> Hi Timo-
>
> > On Aug 3, 2020, at 11:05 AM, Timo Rothenpieler <timo@rothenpieler.org> wrote:
> >
> > Hello,
> >
> > I have just deployed a new system with Mellanox ConnectX-4 VPI EDR IB cards and wanted to setup NFS over RDMA on it.
> >
> > However, while mounting the FS over RDMA works fine, actually using it results in the following messages absolutely hammering dmesg on both client and server:
> >
> >> https://gist.github.com/BtbN/9582e597b6581f552fa15982b0285b80#file-server-log
> >
> > The spam only stops once I forcibly reboot the client. The filesystem gets nowhere during all this. The retrans counter in nfsstat just keeps going up, nothing actually gets done.
> >
> > This is on Linux 5.4.54, using nfs-utils 2.4.3.
> > The mlx5 driver had enhanced-mode disabled in order to enable IPoIB connected mode with an MTU of 65520.
> >
> > Normal NFS 4.2 over tcp works perfectly fine on this setup, it's only when I mount via rdma that things go wrong.
> >
> > Is this an issue on my end, or did I run into a bug somewhere here?
> > Any pointers, patches and solutions to test are welcome.
>
> I haven't seen that failure mode here, so best I can recommend is
> keep investigating. I've copied linux-rdma in case they have any
> advice.

The mentioning of IPoIB is a slightly confusing in the context of NFS-over-RDMA.
Are you running NFS over IPoIB?

From brief look on CQE error syndrome (local length error), the client sends wrong WQE.

Thanks

>
> --
> Chuck Lever
>
>
>
