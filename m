Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5DB183732
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 18:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgCLRQe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 13:16:34 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:17733 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLRQe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 13:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584033393; x=1615569393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XVuEf/QquA9QfGLq+JqWY7aqz+r8nYPO2skKJFVy2tA=;
  b=BS0pXLfpWswg5Pch0ymAkF5AVl6BxfSt9U9m/EdeSCD4DXPOSmRVq1t1
   sH/unr/fvTeKQMnSXl586vuJLrReA5bdGGHLXd2WUq+Vx0XzdUaoWtDiW
   as0ehnunp/oBNUWf+jVmdIPq0DPQO7kvAfXhnYlaykIPBuLyaIiys6/wy
   w=;
IronPort-SDR: DzQkP+ru0V8rfwg3D8dZLsQBdPpMIvA3Dk2aEzs3KP0o0g0pSpSz8iGofd4K+uNgsZB/JrCZj1
 L61eNFlkRIDQ==
X-IronPort-AV: E=Sophos;i="5.70,545,1574121600"; 
   d="scan'208";a="22498230"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 12 Mar 2020 17:16:31 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 1C4A3A07DD;
        Thu, 12 Mar 2020 17:16:31 +0000 (UTC)
Received: from EX13D23UWA002.ant.amazon.com (10.43.160.40) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Mar 2020 17:16:31 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D23UWA002.ant.amazon.com (10.43.160.40) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Mar 2020 17:16:30 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Thu, 12 Mar 2020 17:16:30 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 87A59C13B8; Thu, 12 Mar 2020 17:16:30 +0000 (UTC)
Date:   Thu, 12 Mar 2020 17:16:30 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 06/14] nfsd: define xattr functions to call in to their
 vfs counterparts
Message-ID: <20200312171630.GA11733@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-7-fllinden@amazon.com>
 <77A441AA-E880-4C74-B662-B315D6734ED2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <77A441AA-E880-4C74-B662-B315D6734ED2@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 12, 2020 at 12:23:57PM -0400, Chuck Lever wrote:
> > On Mar 11, 2020, at 3:59 PM, Frank van der Linden <fllinden@amazon.com> wrote:
> >
> > This adds the filehandle based functions for the xattr operations
> > that call in to the vfs layer to do the actual work.
> 
> Before posting again, use "make C=1" to clear up new sparse
> errors, and scripts/checkpatch.pl to find and correct whitespace
> damage introduced in this series.

Hi Chuck,

Thanks for this comment (and the other ones).

I forgot to run sparse - I have fixed the __be32/int type mismatches
it flagged in my tree.

I ran checkpath.pl before sending these in. Looks like I missed
one line that is too long. The warnings I didn't fix were:

==
WARNING: function definition argument 'struct dentry *' should also have an identifier name
#156: FILE: include/linux/xattr.h:54:
+int __vfs_setxattr_locked(struct dentry *, const char *, const void *, size_t, int, struct inode **);
==

..changing this would make the prototype declaration of that function not
match with the style of the ones around it (which also don't have argument
names in their declarations) - so I decided not to.

The other one is:

===
WARNING: please, no spaces at the start of a line
#46: FILE: fs/nfsd/vfs.c:616:
+    {^INFS4_ACCESS_XAREAD,^INFSD_MAY_READ^I^I^I},$
===

The warning is correct, but the array that is part of, and the surrounding
accessmap arrays, all have the same spacing. So to both silence checkpacth
and make the code look consistent, I'd have to change the spacing in
all those arrays (nfs3_regaccess, nfs3_diraccess, nfs3_anyaccess).

This didn't seem right, so I didn't do it.

I'll be happy to send a separate whitespace cleanup for that, not sure
if it should be part of this series, though.

Frank
