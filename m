Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0043FD4B3
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Sep 2021 09:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242640AbhIAHp1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Sep 2021 03:45:27 -0400
Received: from verein.lst.de ([213.95.11.211]:46577 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242654AbhIAHpZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Sep 2021 03:45:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8E30F68AFE; Wed,  1 Sep 2021 09:44:27 +0200 (CEST)
Date:   Wed, 1 Sep 2021 09:44:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     NeilBrown <neilb@suse.de>
Cc:     "J.  Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: simplify struct nfsfh
Message-ID: <20210901074427.GC18673@lst.de>
References: <163038488360.7591.7865010833762169362@noble.neil.brown.name> <163038495873.7591.9260775605693695494@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163038495873.7591.9260775605693695494@noble.neil.brown.name>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
