Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65334184C02
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 17:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCMQHS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 12:07:18 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:41672 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCMQHS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Mar 2020 12:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584115637; x=1615651637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m25YhMYW3RZdFa9q1emNmuxVz35IN08arD2+qE3PcXA=;
  b=Ir0MKY4APQ6DdDTLYLQBjNVP2//T8uaDxiZ6wGqilJ+MvmboacZtN2mY
   eA5+aSvXIvyFJISlIet+JOo4Atx5LHXVNxu6tnGetozTPSKcG4XsRJz/N
   N/SE2jEUZBkXkEhJpjLVKPjHqF4UO2SKsI1BfzkPIBMAUb2G6KSnVE58O
   M=;
IronPort-SDR: T3gqtetQ+iQ5XBsEvHJitUs9TfbZycOKnEuz2vGsFrgiE2QONkwf+h0yxc7zEpn7Dh8xM4RQlc
 /w0lfngeaSwA==
X-IronPort-AV: E=Sophos;i="5.70,549,1574121600"; 
   d="scan'208";a="21399371"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 13 Mar 2020 16:07:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 84B3EA2442;
        Fri, 13 Mar 2020 16:07:03 +0000 (UTC)
Received: from EX13D03UEA001.ant.amazon.com (10.43.61.200) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Fri, 13 Mar 2020 16:07:03 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D03UEA001.ant.amazon.com (10.43.61.200) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 13 Mar 2020 16:07:02 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1236.3 via Frontend Transport; Fri, 13 Mar 2020 16:07:03 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id A5BAAC13BB; Fri, 13 Mar 2020 16:07:02 +0000 (UTC)
Date:   Fri, 13 Mar 2020 16:07:02 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     <chuck.lever@oracle.com>, <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 02/14] xattr: modify vfs_{set, remove}xattr for NFS
 server use
Message-ID: <20200313160702.GA31307@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-3-fllinden@amazon.com>
 <20200313153549.GD12537@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200313153549.GD12537@fieldses.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 13, 2020 at 11:35:49AM -0400, J. Bruce Fields wrote:
> 
> 
> On Wed, Mar 11, 2020 at 07:59:42PM +0000, Frank van der Linden wrote:
> > Second, RFC 8276 (NFSv4 extended attribute support) specifies that
> > delegations should be recalled (8.4.2.4, 8.4.4.4) when a SETXATTR
> > or REMOVEXATTR operation is performed. So, like with other fs
> > operations, try to break the delegation. The _locked version of
> > these operations will not wait for the delegation to be successfully
> > broken, instead returning an error if it wasn't, so that the NFS
> > server code can return NFS4ERR_DELAY to the client (similar to
> > what e.g. vfs_link does).
> 
> Is there a preexisting bug here?  Even without NFS support for xattrs, a
> local setxattr on the filesystem should still revoke any delegations
> held by remote NFS clients.  I couldn't tell whether we're getting that
> right from a quick look at the current code.
> 
> --b.

I think there's currently a bug if that's the expected behavior, yes.
Attribute changes will call notify_change(), and other methods (unlink,
link, rename) call try_break_deleg(). But the xattr entry points
don't do that, which is why I added it.

- Frank
