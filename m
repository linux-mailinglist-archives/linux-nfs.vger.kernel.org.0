Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED803FD4B2
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Sep 2021 09:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbhIAHpI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Sep 2021 03:45:08 -0400
Received: from verein.lst.de ([213.95.11.211]:46575 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242765AbhIAHpF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Sep 2021 03:45:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9FC1F68AFE; Wed,  1 Sep 2021 09:44:07 +0200 (CEST)
Date:   Wed, 1 Sep 2021 09:44:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     NeilBrown <neilb@suse.de>
Cc:     "J.  Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] NFSD: drop support for ancient filehandles
Message-ID: <20210901074407.GB18673@lst.de>
References: <20210827151505.GA19199@lst.de> <163038488360.7591.7865010833762169362@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163038488360.7591.7865010833762169362@noble.neil.brown.name>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The content looks fine, but I still think moving the definition out of
the uapi and removing the ancient file handles are different things
that should be separate patches with separate commit logs explaining
the story.
