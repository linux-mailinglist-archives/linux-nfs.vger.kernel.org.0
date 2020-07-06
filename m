Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15675216048
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2020 22:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGFU1N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jul 2020 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgGFU1M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jul 2020 16:27:12 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D48C061755
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2020 13:27:12 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2CFA7957; Mon,  6 Jul 2020 16:27:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2CFA7957
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1594067232;
        bh=aWqkgdP1UxjTweJm5VFTpA5GHrgHRx4y3DcbAeje6cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yPUpBNOATey51uuZN9aSjEBbgUMIbEpOxmQLVS5Pa+RGy+cpMh9QDlYJzaYFSMaqw
         W3mgqTVytJolYaU3T3XlNx8gf9LyeguAAG6YbUGNZWZ+rwiEJPyx6if4Jb97PEqqvf
         dxB07/XQ5+n7Se2Nr9oT5riVkOPOR7xW+u3FrQ10=
Date:   Mon, 6 Jul 2020 16:27:12 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
Message-ID: <20200706202712.GA32161@fieldses.org>
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <9e25861022acb796c35d3adb392bf4c4@kngnt.org>
 <c058f370-9f7c-146d-e7e6-a3f88b62cbc4@oracle.com>
 <4097833.BOCuNxM56l@polaris>
 <20200706171804.GA31789@fieldses.org>
 <4fe2af1f-917e-c1e4-f5e6-05eb0c121511@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fe2af1f-917e-c1e4-f5e6-05eb0c121511@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 06, 2020 at 02:57:52PM -0500, Patrick Goetz wrote:
> On 7/6/20 12:18 PM, J. Bruce Fields wrote:
> >
> >Note, by the way, that fsid=0 thing was required for nfsv4 exports years
> >ago, but no longer is.  It's usually better not to bother with that.
> 
> Are we ever going to get some solid up-to-date NFSv4/pNFS
> documentation?  I'm sufficiently frustrated to write it myself, but
> am not 100% sure where to start.

I guess the places I'd start would be the man pages (original source is
nfs-utils, git://linux-nfs.org/~steved/nfs-utils) or wiki.linux-nfs.org.

But, I don't know, you may be in a better place to position to know what
gaps you want filled--where are you looking for documentation, and what
are you not finding?

--b.
