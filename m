Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFBC39FD7B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhFHRWL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 13:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhFHRWK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 13:22:10 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162ABC061574
        for <linux-nfs@vger.kernel.org>; Tue,  8 Jun 2021 10:20:16 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9C36D685B; Tue,  8 Jun 2021 13:20:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9C36D685B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1623172815;
        bh=2hQ+IhZOkW/0IERB/C1JhYCR/JFt50N0MUYyTTPmzUk=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=Sk830VBRLQT7h0r/ezL5Ysrt6IqvmmTjGHEcbYCQaelenfkxspK/qiqwCmAasaA5G
         QDlwX+2vwCytqt3rzgdB65EPhRsA0U8wk+f9xWOOToW3cO75Aqdlh9VD0BmfSSCflH
         G3Gj3RgkhOgAMK8sdpCRaWt1QQoLZB6tcIMONC3Q=
Date:   Tue, 8 Jun 2021 13:20:15 -0400
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, linux-nfs@vger.kernel.org
Subject: Re: nfsd dead loop when xfstests generic/531
Message-ID: <20210608172015.GB22685@fieldses.org>
References: <20210531125948.2D37.409509F4@e16-tech.com>
 <20210601165535.GA3102@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601165535.GA3102@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 01, 2021 at 04:55:35PM +0000, Frank van der Linden wrote:
> On Mon, May 31, 2021 at 12:59:51PM +0800, Wang Yugui wrote:
> > 
> > 
> > Hi,
> > 
> > nfsd dead loop when xfstests generic/531
> > 
> > linux kernel of nfs server: 5.10.41
> > linux kernel of nfs client: 5.10.41
> > 
> > 
> > nfsd dead loop when xfstests generic/531
> > 
> > linux kernel of nfs server: 5.10.41
> > linux kernel of nfs client: 5.10.41
> 
> This is a known issue. generic/531 opens a large number of files, causing
> the nfsd file cache code to walk a very long LRU list of open files. For
> v4, there will be a lot of long term opens (because of the OPEN call),
> and they all end up on that list.
> 
> So, the basic issue is, that the nfsd file cache is a good match for
> v3 semantics, but less so for v4 semantics.
> 
> I posted an experimental patch to work around the issue:
> 
> https://lore.kernel.org/linux-nfs/20201020183718.14618-4-trondmy@kernel.org/T/#m869aa427f125afee2af9a89d569c6b98e12e516f
> 
> The rhashtable patch has issues, so disregard that one, but the other one
> is a basic fix for this issue. It has one other issue that I noticed (refcount
> error), but that is easily fixed.
> 
> I should update the patch and formally post it..

That would be great.

--b.
