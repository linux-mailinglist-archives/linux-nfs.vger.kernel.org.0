Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF034AEE1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 02:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfFSAGV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jun 2019 20:06:21 -0400
Received: from mail.prgmr.com ([71.19.149.6]:52534 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFSAGV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 18 Jun 2019 20:06:21 -0400
Received: from turtle.mx (96-92-68-116-static.hfc.comcastbusiness.net [96.92.68.116])
        (Authenticated sender: adp)
        by mail.prgmr.com (Postfix) with ESMTPSA id 087F628C002
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2019 01:03:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 087F628C002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1560920619;
        bh=Xjj9Zv4HD7Z7rMmQFxYm51gsQ2pNoJOwv55SviarFb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtVBNcPYYuzduIo0gbHv8N3qz2ALCVl4ASWGWULneygVZoSbnNOL5UfcDLlwz6z4O
         UwCY6RDpAkXGoYcf5zL6B7j1Iv27r8wtCd2d0uV9h1z2ovf9p7cEv7CMJy9zV48KIi
         3Z4Am1Rwy+6EVIunZC1A39hsEz1i0z2LWSxTvlds=
Received: (qmail 22267 invoked by uid 1353); 19 Jun 2019 00:07:46 -0000
Date:   Tue, 18 Jun 2019 18:07:46 -0600
From:   Alan Post <adp@prgmr.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang in wait_on_commit with kworker
Message-ID: <20190619000746.GT4158@turtle.email>
References: <20190618000613.GR4158@turtle.email>
 <6DE07E49-D450-4BF7-BC61-0973A14CD81B@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6DE07E49-D450-4BF7-BC61-0973A14CD81B@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 18, 2019 at 11:29:16AM -0400, Benjamin Coddington wrote:
> I think that your transport or NFS server is dropping the response to an
> RPC.  The NFS client will not retransmit on an established connection.
> 
> What server are you using?  Any middle boxes on the network that could be
> transparently dropping transmissions (less likely, but I have seen them)?
> 

I've found 8 separate NFS client hangs of the sort I reported here,
and in all cases the same NFS server was involved: an Ubuntu Trusty
system running 4.4.0.  I've been upgrading all of these NFS servers,
haven't done this one yet--the complicity of NFS hangs I've been
seeing have slowed me down.

Of the 8 NFS clients with a hang to this server, about half are in
the same computer room where packets only transit rack switches, with
the other half also going through a computer room router.

I see positive dropped and overrun packet counts on the NFS server
interface, along with a similar magnitude of pause counts on the
switch port for the NFS server.  Given the occurences of this issue
only this rack switch and a redundant pair of top-of-rack switches in
the rack with the NFS server are in-common between all 8 NFS clients
with write hangs.

-A
-- 
Alan Post | Xen VPS hosting for the technically adept
PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
email: adp@prgmr.com
