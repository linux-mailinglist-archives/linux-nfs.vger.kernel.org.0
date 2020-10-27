Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD029C9F4
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 21:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831038AbgJ0UOU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 16:14:20 -0400
Received: from fieldses.org ([173.255.197.46]:45836 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1831037AbgJ0UOU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Oct 2020 16:14:20 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id AF3C66814; Tue, 27 Oct 2020 16:14:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org AF3C66814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603829658;
        bh=XKAmuWAomsHuxCe6jxb1Y6KJlsHZhPncX9Q9Ej+Af/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yTg1DRFyty7YSSrBkTfvZ/sJO80gr53pe9XikVh0huXOR3H5nUOJK9zbAaafR78Rh
         DSbn7/vC/pPsVaoNO1ex1NAE/tjBlwPdNzYr86SZoaLhcojd5RjMhewSlw5YOKpRgd
         Pgjk/XKCg4J9zk/wz7nf94aJ8NR7N0TsVULCVyJE=
Date:   Tue, 27 Oct 2020 16:14:18 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Anna Schumaker <schumakeranna@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Jorge Mora <jmora1300@gmail.com>
Subject: Re: xfstests generic/263
Message-ID: <20201027201418.GA4564@fieldses.org>
References: <20201027174945.GC1644@fieldses.org>
 <CAFX2Jf=-Y905+cMtLike2ddpthCV=K6CM8iS4EPeAz1RYzF-pA@mail.gmail.com>
 <20201027200507.GD1644@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027200507.GD1644@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 27, 2020 at 04:05:07PM -0400, J. Bruce Fields wrote:
> On Tue, Oct 27, 2020 at 03:59:56PM -0400, Anna Schumaker wrote:
> > On Tue, Oct 27, 2020 at 1:49 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > Generic/263 is failing whenever client and server both supports
> > > READ_PLUS.
> > >
> > > I'm not even sure the failure is wrong.  The NFS FALLOC operation doesn't
> > > support those other other fallocate modes, are they implemented elsewhere in
> > > the kernel or libc somehow?  Anyway, odd that it would have anything to do with
> > > READ_PLUS.
> > 
> > I just ran xfstests, and I'm seeing this too. The test passes using
> > basic READ on v4.2, so there might be something farther down the log
> > that diff is cutting off. I'll see if anything sticks out to me this
> > week.
> 
> Thanks!
> 
> Also, wireshark doesn't seem to be parsing READ_PLUS replies correctly.
> Cc'ing Jorge since he seems to have been the last to touch that code.

Oops, ignore me!

I was actually just running the wrong version of wireshark, with a
version built with Jorge's patch it's fine.

--b.
