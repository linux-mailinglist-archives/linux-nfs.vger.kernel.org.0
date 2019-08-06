Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9E1839EE
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 21:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfHFT6C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 15:58:02 -0400
Received: from fieldses.org ([173.255.197.46]:50574 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfHFT6C (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 6 Aug 2019 15:58:02 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 1D3C32012; Tue,  6 Aug 2019 15:58:02 -0400 (EDT)
Date:   Tue, 6 Aug 2019 15:58:02 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] NFS/RDMA-related NFSD patches for -next
Message-ID: <20190806195802.GA15721@fieldses.org>
References: <156390950940.6811.3316103129070572088.stgit@seurat29.1015granger.net>
 <BFF3E871-D4B1-4692-A39B-B693BFE85899@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFF3E871-D4B1-4692-A39B-B693BFE85899@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 06, 2019 at 11:55:29AM -0400, Chuck Lever wrote:
> Would you consider these for v5.4?

Yes, definitely.

I have an intermittent failure in my regression tests that it looks like
I introduced in the most recent merge window.  I'd like to track that
down before pushing out a 5.4 tree.  Hopefully in the next day or so....

--b.
