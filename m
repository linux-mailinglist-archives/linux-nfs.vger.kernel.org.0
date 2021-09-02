Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B2D3FE9EC
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Sep 2021 09:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbhIBHW2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Sep 2021 03:22:28 -0400
Received: from verein.lst.de ([213.95.11.211]:50217 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242506AbhIBHW2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Sep 2021 03:22:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E30D06736F; Thu,  2 Sep 2021 09:21:26 +0200 (CEST)
Date:   Thu, 2 Sep 2021 09:21:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3 v3] NFSD: move filehandle format declarations out
 of "uapi".
Message-ID: <20210902072126.GA13773@lst.de>
References: <F517668C-DD79-4358-96AE-1566B956025A@oracle.com> <163054528774.24419.6639477440713170169@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163054528774.24419.6639477440713170169@noble.neil.brown.name>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
