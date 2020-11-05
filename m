Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE902A885C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 21:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbgKEUwI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 15:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgKEUwH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 15:52:07 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E278C0613D2
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 12:52:07 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7A2461509; Thu,  5 Nov 2020 15:52:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7A2461509
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1604609525;
        bh=tZbdz25Jh3tUk79L85NkD6dh3U0qvw857r06NkSeLec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVn1aKXdsSR6/jIxbA1A0L3nhf2dscXPl9gGGBoHGpkO+Hkv9LLrbUzCxnOBDTegL
         8qlpVVSUoJDPvEuTFXG3BvpPh26SBcEUJre5j2TqJqkIg89K0T5bBuzySK/G67CZd1
         4V4epvytl6xE/r4afm61d7VdgzAFJa+azmd1uRIY=
Date:   Thu, 5 Nov 2020 15:52:05 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Anna Schumaker <schumakeranna@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: xfstests generic/263
Message-ID: <20201105205205.GC25512@fieldses.org>
References: <20201027174945.GC1644@fieldses.org>
 <CAFX2Jf=-Y905+cMtLike2ddpthCV=K6CM8iS4EPeAz1RYzF-pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2Jf=-Y905+cMtLike2ddpthCV=K6CM8iS4EPeAz1RYzF-pA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 27, 2020 at 03:59:56PM -0400, Anna Schumaker wrote:
> On Tue, Oct 27, 2020 at 1:49 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > Generic/263 is failing whenever client and server both supports
> > READ_PLUS.
> >
> > I'm not even sure the failure is wrong.  The NFS FALLOC operation doesn't
> > support those other other fallocate modes, are they implemented elsewhere in
> > the kernel or libc somehow?  Anyway, odd that it would have anything to do with
> > READ_PLUS.
> 
> I just ran xfstests, and I'm seeing this too. The test passes using
> basic READ on v4.2, so there might be something farther down the log
> that diff is cutting off. I'll see if anything sticks out to me this
> week.

I think 091 is failing from the same cause, by the way.  I haven't
investigated any more though.

--b.
