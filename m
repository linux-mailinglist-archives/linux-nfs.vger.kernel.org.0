Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21C18509D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 22:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCMVGG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 17:06:06 -0400
Received: from fieldses.org ([173.255.197.46]:51526 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgCMVGG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:06:06 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 786F9C53; Fri, 13 Mar 2020 17:06:05 -0400 (EDT)
Date:   Fri, 13 Mar 2020 17:06:05 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 02/14] xattr: modify vfs_{set, remove}xattr for NFS
 server use
Message-ID: <20200313210605.GE12537@fieldses.org>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-3-fllinden@amazon.com>
 <20200313153549.GD12537@fieldses.org>
 <20200313160702.GA31307@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313160702.GA31307@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 13, 2020 at 04:07:02PM +0000, Frank van der Linden wrote:
> On Fri, Mar 13, 2020 at 11:35:49AM -0400, J. Bruce Fields wrote:
> > 
> > 
> > On Wed, Mar 11, 2020 at 07:59:42PM +0000, Frank van der Linden wrote:
> > > Second, RFC 8276 (NFSv4 extended attribute support) specifies that
> > > delegations should be recalled (8.4.2.4, 8.4.4.4) when a SETXATTR
> > > or REMOVEXATTR operation is performed. So, like with other fs
> > > operations, try to break the delegation. The _locked version of
> > > these operations will not wait for the delegation to be successfully
> > > broken, instead returning an error if it wasn't, so that the NFS
> > > server code can return NFS4ERR_DELAY to the client (similar to
> > > what e.g. vfs_link does).
> > 
> > Is there a preexisting bug here?  Even without NFS support for xattrs, a
> > local setxattr on the filesystem should still revoke any delegations
> > held by remote NFS clients.  I couldn't tell whether we're getting that
> > right from a quick look at the current code.
> > 
> > --b.
> 
> I think there's currently a bug if that's the expected behavior, yes.
> Attribute changes will call notify_change(), and other methods (unlink,
> link, rename) call try_break_deleg(). But the xattr entry points
> don't do that, which is why I added it.

Got it, thanks.  In that case I'd move this patch (or the part of it
required to fix that bug) to the front of the series and add a

	Cc: stable@vger.kernel.org

--b.
