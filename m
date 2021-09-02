Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B573FE9ED
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Sep 2021 09:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbhIBHXI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Sep 2021 03:23:08 -0400
Received: from verein.lst.de ([213.95.11.211]:50219 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233163AbhIBHXI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Sep 2021 03:23:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C9A746736F; Thu,  2 Sep 2021 09:22:08 +0200 (CEST)
Date:   Thu, 2 Sep 2021 09:22:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3 v3] NFSD: drop support for ancient filehandles
Message-ID: <20210902072208.GB13773@lst.de>
References: <163054528774.24419.6639477440713170169@noble.neil.brown.name> <163054532947.24419.15934648756713210376@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163054532947.24419.15934648756713210376@noble.neil.brown.name>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 02, 2021 at 11:15:29AM +1000, NeilBrown wrote:
> 
> Filehandles not in the "new" or "version 1" format have not been handed
> out for new mounts since Linux 2.4 which was released 20 years ago.
> I think it is safe to say that no such file handles are still in use,
> and that we can drop support for them.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
