Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F990350D49
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 05:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhDADww (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 23:52:52 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47269 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhDADwi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 23:52:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UU1.3pw_1617249156;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UU1.3pw_1617249156)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 01 Apr 2021 11:52:36 +0800
Date:   Thu, 1 Apr 2021 11:52:36 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: kernel ops from commit 6869c46bd960
Message-ID: <20210401035236.GQ95214@e18g06458.et15sqa>
References: <CAN-5tyHxeLknSxbRb92shQv3hsf146N9wsvEUQ4VEJRGhEXD_g@mail.gmail.com>
 <463e945f7dbe9730283d4f3b6850cc3e4326f0b9.camel@hammerspace.com>
 <20210330090136.GM95214@e18g06458.et15sqa>
 <fc9ccf2b35d602674ddaefd5a99dc20b6c09645b.camel@hammerspace.com>
 <20210330123521.GN95214@e18g06458.et15sqa>
 <8302361ec9bab9a15fe90ae0f333f24f4b70c7c8.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8302361ec9bab9a15fe90ae0f333f24f4b70c7c8.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 30, 2021 at 01:01:03PM +0000, Trond Myklebust wrote:
[snip]
> > > 
> > > That BUG() was originally there to catch parsing errors, which is
> > > not
> > > the case here. We should just undo that #ifdef in
> > > nfs_init_timeout_values().
> > 
> > Just want to make sure I understand it correctly, so it's allowed to
> > just mount v3 via UDP, but data goes via TCP, even if UDP support is
> > disabled?
> > 
> 
> My understanding of Olga's patch was that it disabled the UDP protocol
> for NFS and NLM, but not necessarily for other protocols. You can still
> use mountproto=udp.

Thanks for the clarification, that makes sense.

Thanks,
Eryu
