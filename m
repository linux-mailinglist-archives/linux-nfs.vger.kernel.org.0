Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760603BE983
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jul 2021 16:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhGGOQn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 10:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhGGOQk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jul 2021 10:16:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DADBC061574
        for <linux-nfs@vger.kernel.org>; Wed,  7 Jul 2021 07:14:00 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BA37B6851; Wed,  7 Jul 2021 10:13:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BA37B6851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625667239;
        bh=lCH1sGASKeBLyLMdDljgO14aY9g7xQEgKx+FMCvpPhI=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=QBanJakVeLsVWvhFqHWmP25oFGoinubbnl1AJE0+j3/DS+7ncASgg+omEhArrpu+z
         TAbbDQVWphoumTo4D9LulfzFWuXVXNZCzrVtoQrxvvg+38TmlJMxPYOQLXu3/IEi1c
         MVylqboRKWzVFshSs2gnf8zDHgQ7m7pq7QCROpAo=
Date:   Wed, 7 Jul 2021 10:13:59 -0400
To:     "Becker, Jeffrey C. (ARC-TN)[InuTeq, LLC]" 
        <jeffrey.c.becker@nasa.gov>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: FW: [EXTERNAL] Re: NFS server question
Message-ID: <20210707141359.GB9446@fieldses.org>
References: <0C9D9022-8E61-4B03-8225-D829E22B4137@ndc.nasa.gov>
 <E168219A-8120-4154-80E7-DC03F70D69D1@oracle.com>
 <C88E1CD2-4156-4E45-AC27-F19D4E4C9FC7@ndc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C88E1CD2-4156-4E45-AC27-F19D4E4C9FC7@ndc.nasa.gov>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 02, 2021 at 03:11:11PM +0000, Becker, Jeffrey C. (ARC-TN)[InuTeq, LLC] wrote:
> Is there a limit on the number of exports for an NFS server? Thanks.

I don't have a better answer than Chuck's.

I can't think of any hard-coded limits, it's just a matter of resources.

You could try giving more specifics about your plan and see if anyone
has experience with a similar setup.

--b.

> 
> Jeff Becker
> 
> ﻿On 7/2/21, 7:21 AM, "Chuck Lever III" <chuck.lever@oracle.com> wrote:
> 
>     Hi Jeff-
> 
>     > On Jul 1, 2021, at 7:54 PM, Becker, Jeffrey C. (ARC-TN)[InuTeq, LLC] <jeffrey.c.becker@nasa.gov> wrote:
>     > 
>     > Hi Chuck,
>     >  
>     > I have an NFS server that currently has about 20 directories it’s exporting over NFSv4. I was wondering what the maximum number of exports is. Thanks.
> 
>     I'm not aware of any intrinsic limit on the number of exports.
>     There is probably a per-export resource cost that acts as a
>     practical limit.
> 
>     Might be a good idea to ask on linux-nfs@vger.kernel.org.
> 
> 
>     --
>     Chuck Lever
> 
> 
> 
> 
