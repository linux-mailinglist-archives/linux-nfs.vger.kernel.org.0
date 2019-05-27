Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCBD2B746
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2019 16:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfE0OJZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 May 2019 10:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfE0OJY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 May 2019 10:09:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEA32205ED;
        Mon, 27 May 2019 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558966164;
        bh=gQ1P5ZYDjSIagUaavAIvJRBf/cNBRCRL3jw2f07583Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFXt2i+KmO9X8HVMBvlyNZ3Xe7GUSMY8N8WvQVg8fs7nx9DItEQZsYdOiPtTQ9wa3
         UWQAKIieYUnzW/afKH6st0B1QFV9Li+Vuyxrd175Tk6duP6IluA7F1p1nWfmLeLVkA
         N/g5tqXbfwj5HIbbV1TGM1gE9xK3KGNRPHvmKzHA=
Date:   Mon, 27 May 2019 16:09:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Xu <xuyu@linux.alibaba.com>
Cc:     kolga@netapp.com, linux-nfs@vger.kernel.org,
        joseph.qi@linux.alibaba.com, caspar@linux.alibaba.com
Subject: Re: [backport request][stable] NFSv4.x: fix incorrect return value
 in copy_file_range
Message-ID: <20190527140921.GD7659@kroah.com>
References: <0f0e59bd-2520-e265-265e-4a29bf776c60@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f0e59bd-2520-e265-265e-4a29bf776c60@linux.alibaba.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 23, 2019 at 11:59:30PM +0800, Yu Xu wrote:
> Hi,
> 
> I'm using kernel v4.19.y and find that v4.19.y fails in the latest xfstests
> generic/075, 091, 112, 127 and 263, which can be simply reproduced as
> follows:
> 
> # kernel 4.19.y
> $ xfs_io -fc "copy_range -s 0 -d 1 -l 1 /mnt/nfs/file" /mnt/nfs/file
> copy_range: Invalid argument
> 
> # kernel 5.1.0
> $ xfs_io -fc "copy_range -s 0 -d 1 -l 1 /mnt/nfs/file" /mnt/nfs/file
> # success
> 
> I notice that upstream (v5.1+) has already fixed this issue with:
> 1) commit 45ac486ecf2dc998e25cf32f0cabf2deaad875be
> 2) commit 0769663b4f580566ef6cdf366f3073dbe8022c39
> 
> But these patches do not cc stable@vger.kernel.org (why? forgotten?). And
> will v4.19.y consider to backport these patches?

I will be glad to queue them up now, thanks for letting me know.

greg k-h
