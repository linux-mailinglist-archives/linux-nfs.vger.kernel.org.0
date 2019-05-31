Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9201B305B7
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 02:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfEaAVD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 20:21:03 -0400
Received: from mail.prgmr.com ([71.19.149.6]:38410 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfEaAVD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 20:21:03 -0400
Received: from turtle.mx (96-92-68-116-static.hfc.comcastbusiness.net [96.92.68.116])
        (Authenticated sender: adp)
        by mail.prgmr.com (Postfix) with ESMTPSA id 2C39C28C001
        for <linux-nfs@vger.kernel.org>; Fri, 31 May 2019 01:18:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com 2C39C28C001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1559279926;
        bh=AdWDgeBb+FD8PnnjXoCPCj2zU/TS3BueQnRiVtgHldQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOuhLnNj/AoocfXCkZaIohX38tc6KUwjQVS0WMhxIhLC/jCOq4h6USUrt4jcELPS2
         Skn+caRYRmRJE9kVuMxhKvlaVtPuyQf4Xpq1WkfekWn1WUWPufpNsd9BiAVz2kgnql
         VPh4VsmBF9eZTXh+8v1lp+daORMmG95Jp0CY17lk=
Received: (qmail 2953 invoked by uid 1353); 31 May 2019 00:22:03 -0000
Date:   Thu, 30 May 2019 18:22:03 -0600
From:   Alan Post <adp@prgmr.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: User process NFS write hang followed by automount hang requiring
 reboot
Message-ID: <20190531002203.GW4158@turtle.email>
References: <20190520223324.GL4158@turtle.email>
 <c10084e889df77fc2b6a6c9a04b232faae3a80bc.camel@hammerspace.com>
 <20190521192254.GN4158@turtle.email>
 <20190530183958.GA23001@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530183958.GA23001@fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 30, 2019 at 02:39:58PM -0400, J. Bruce Fields wrote:
> > > By the way, the above stack trace with "nfs_lock_and_join_requests"
> > > usually means that you are using a very small rsize or wsize (less than
> > > 4k). Is that the case? If so, you might want to look into just
> > > increasing the I/O size.
> > > 
> > 
> > These exports have rsize and wsize set to 1048576.
> 
> Are you getting that from the mount commandline?  It could be negotiated
> down during mount.  I think you can get the negotiated values form the
> rsize= and wsize= values on the opts: line in /proc/self/mountstats.
> See also /proc/fs/nfsd/max_block_size.
> 

Great catch.  I was reporting configuration from the mount command-line.
I've spot checked /proc/self/mountstats and they report the same value,
rsize and wsize of 1048576.  I do have different values for here for
NFS servers that are administratively outside of this cluster, where
it is 65536, but in those cases we're not setting that option on the
mount command-line and I am not experiencing the hang I report here
to those servers.

-A
-- 
Alan Post | Xen VPS hosting for the technically adept
PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
email: adp@prgmr.com
