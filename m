Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789AA125465
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 22:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfLRVMy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 16:12:54 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:37107 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfLRVMy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 16:12:54 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5E7933A1D7C;
        Thu, 19 Dec 2019 08:12:52 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ihgcl-0005AG-RG; Thu, 19 Dec 2019 08:12:51 +1100
Date:   Thu, 19 Dec 2019 08:12:51 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: Clone should commit src file metadata too
Message-ID: <20191218211251.GX19213@dread.disaster.area>
References: <20191218195723.395277-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218195723.395277-1-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=SEtKQCMJAAAA:8 a=20KFwNOVAAAA:8 a=Xh8avrndfoJmA_VlOoUA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22 a=kyTSok1ft720jgMXX5-3:22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Dec 18, 2019 at 02:57:23PM -0500, Trond Myklebust wrote:
> vfs_clone_file_range() can modify the metadata on the source file too,
> so we need to commit that to stable storage as well.
> 
> Reported-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Looks ok to me now.

Acked-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
