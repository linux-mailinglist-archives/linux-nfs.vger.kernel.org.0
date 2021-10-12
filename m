Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1BA42A527
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbhJLNP5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 09:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233100AbhJLNP4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 12 Oct 2021 09:15:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9786E61078;
        Tue, 12 Oct 2021 13:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634044435;
        bh=4FGOLmNQJMmUgDWb+dTvwIIEaKS0/Q7X1H8P1XqrZOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gjMoE/l11PPKEax9JjFgpEL+X6KyXCfywTcNuAe9p6DtS2XxRRqwOeJJ3j1wk0kzN
         5cv5RVT6oiqfZV3kLahYIr5+yEC2H9688wGFTdM8pII3ZahmuDffx0Yviy+BatjNro
         ++u7aAm/n73SxakwvdH5j1YbQpJOBAa6f+l7lv+9/lMUcEub57i9wqLDuQYuJtQGTV
         VzXXU8WG23Ls1Yl5CW0TZDOe2nUImnbqtZDe3JlawJHebQRHOspqkn1/rZJQw9lNz/
         mNmcVBtmpfKqZB+teHpEIREPZfm+ZwxdmkmvWpnxTily83PTT0utXCavIEed5RvNXn
         8icOkAYUm27TA==
Date:   Tue, 12 Oct 2021 06:13:52 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/7] sd: implement ->get_unique_id
Message-ID: <20211012131352.GC635062@dhcp-10-100-145-180.wdc.com>
References: <20211012120445.861860-1-hch@lst.de>
 <20211012120445.861860-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012120445.861860-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 12, 2021 at 02:04:40PM +0200, Christoph Hellwig wrote:
> +static int sd_get_unique_id(struct gendisk *disk, u8 id[16], u8 type)
> +{
> +	struct scsi_device *sdev = scsi_disk(disk)->device;
> +	const struct scsi_vpd *vpd;
> +	const unsigned char *d;
> +	int len = -ENXIO;
> +
> +	rcu_read_lock();
> +	vpd = rcu_dereference(sdev->vpd_pg83);
> +	if (!vpd)
> +		goto out_unlock;
> +
> +	len = -EINVAL;
> +	for (d = vpd->data + 4; d < vpd->data + vpd->len; d += d[3] + 4) {
> +		/* we only care about designators with LU association */
> +		if (((d[1] >> 4) & 0x3) != 0x00)
> +			continue;
> +		if ((d[1] & 0xf) != type)
> +			continue;
> +
> +		/*
> +		 * Only exit early if a 16-byte descriptor was found.  Otherwise
> +		 * keep looking as one with more entropy might still show up.
> +		 */
> +		len = d[3];
> +		if (len != 8 && len != 12 && len != 16)
> +			continue;

I think you need a temporary variable instead of assigning directly to
'len' here. Otherwise, the 'len' returned will be whatever the last
iteration was, which may not be then len that was copied into the 'id'.

> +		memcpy(id, d + 4, len);
> +		if (len == 16)
> +			break;
> +	}
> +out_unlock:
> +	rcu_read_unlock();
> +	return len;
> +}
