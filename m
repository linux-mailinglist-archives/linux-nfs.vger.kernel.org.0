Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436BB42D479
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 10:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhJNIFk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 04:05:40 -0400
Received: from verein.lst.de ([213.95.11.211]:49081 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230180AbhJNIFj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 14 Oct 2021 04:05:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BEB7968B05; Thu, 14 Oct 2021 10:03:32 +0200 (CEST)
Date:   Thu, 14 Oct 2021 10:03:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/7] sd: implement ->get_unique_id
Message-ID: <20211014080332.GA29337@lst.de>
References: <20211012120445.861860-1-hch@lst.de> <20211012120445.861860-3-hch@lst.de> <0a7d87ef-fff2-6a63-8edd-604ad8868dbd@suse.de> <20211014080134.GA28835@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014080134.GA28835@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 14, 2021 at 10:01:34AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 14, 2021 at 09:30:51AM +0200, Hannes Reinecke wrote:
> > What's wrong with scsi_vpd_lun_id() ?
> 
> It doesn't allow the caller to pick a specific ID type.

... and of course that it returns an ASCSII string instead of the binary
ID.
