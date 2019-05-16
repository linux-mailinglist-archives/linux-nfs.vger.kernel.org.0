Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FAC2062C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 May 2019 13:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfEPLrw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 May 2019 07:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbfEPLrn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 May 2019 07:47:43 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01C2720833;
        Thu, 16 May 2019 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558007262;
        bh=VW00qVMkH0BrcwLaK5rd5q5/U8a46jUS1Ogh6nAn2LI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lBJ39AJK4xaO3H8xzpewZJqPYTA9PuYs/bCgj2RR2HmectLkkKl5sZ2QrfuPC4FUy
         kzqpycVM3v4Arp/UzuUFepwfya/sms2l+iPmf8TA+CPx3L9EUk+6nKwT7DrmhSnvib
         b8o4ELb2lVUnwNmq6bmRzBu7b+8YFDPsOMilUrxA=
Message-ID: <ac596623e5e68063e8866d9bf7cfd07eafcaf695.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] Fix two bugs CB_NOTIFY_LOCK failing to wake a
 water
From:   Jeff Layton <jlayton@kernel.org>
To:     Yihao Wu <wuyihao@linux.alibaba.com>, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, caspar@linux.alibaba.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Date:   Thu, 16 May 2019 07:47:40 -0400
In-Reply-To: <1a3d5e35-50bc-d757-5d30-15b1c8cff9ad@linux.alibaba.com>
References: <346806ac-2018-b780-4939-87f29648017c@linux.alibaba.com>
         <0d422bbcce15e44a4608cced0a569585c75ccd9a.camel@kernel.org>
         <1a3d5e35-50bc-d757-5d30-15b1c8cff9ad@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2019-05-16 at 16:01 +0800, Yihao Wu wrote:
> On 2019/5/13 9:36 PM, Jeff Layton wrote:
> > On Mon, 2019-05-13 at 14:49 +0800, Yihao Wu wrote:
> > > This patch set fix bugs related to CB_NOTIFY_LOCK. These bugs cause
> > > poor performance in locking operation. And this patchset should also fix
> > > the failure when running xfstests generic/089 on a NFSv4.1 filesystem.
> > > 
> > > Yihao Wu (2):
> > >   NFSv4.1: Again fix a race where CB_NOTIFY_LOCK fails to wake a waiter
> > >   NFSv4.1: Fix bug only first CB_NOTIFY_LOCK is handled
> > > 
> > >  fs/nfs/nfs4proc.c | 31 ++++++++++++-------------------
> > >  1 file changed, 12 insertions(+), 19 deletions(-)
> > > 
> > 
> > Looks good to me. Nice catch, btw!
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > 
> 
> Thank you for your reviewing, Jeff!
> 
> And it seems I forgot to CC maintainers of fs/nfs. So I added you to the CC
> list, Trond and Anna. Does this patchset need further reviewing?
> 
> Sorry to bother you.
> 

This should probably go through Anna's tree, and I assume she'll pick it
up once she and/or Trond have had a chance to review it.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

