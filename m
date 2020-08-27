Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AD22551B3
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Aug 2020 01:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0Xmy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Aug 2020 19:42:54 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:40356 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgH0Xmy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Aug 2020 19:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598571774; x=1630107774;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=bcpp4GHnysCVW/exjI6Jc3g8ewMNBUmYoZ7jEFLNy3A=;
  b=eOKva6+BBbO/Etk20cEzmbL/Q2kEbMBySL7GddnObeMV8nxfGNiS8nLQ
   eAlFGEeb29iCt1h3czBgOzJyNnRmLk6rlmyBI0cx4nTFpIE9eNaV2jsXc
   XWqFtTIjiGboakJ9ofa71Zt220wwcjtoIMWKQnWHo4WWX880PEZptWeaB
   s=;
X-IronPort-AV: E=Sophos;i="5.76,361,1592870400"; 
   d="scan'208";a="50444622"
Subject: Re: [PATCH] NFSD: Correct type annotations in user xattr helpers
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 27 Aug 2020 23:42:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id 1C95D120EB9;
        Thu, 27 Aug 2020 23:42:43 +0000 (UTC)
Received: from EX13D25UEA002.ant.amazon.com (10.43.61.122) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 23:42:42 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D25UEA002.ant.amazon.com (10.43.61.122) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 23:42:41 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 27 Aug 2020 23:42:41 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 74932C153F; Thu, 27 Aug 2020 23:42:41 +0000 (UTC)
Date:   Thu, 27 Aug 2020 23:42:41 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     <linux-nfs@vger.kernel.org>
Message-ID: <20200827234223.GA19819@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <159857138796.5733.7512487939045729999.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <159857138796.5733.7512487939045729999.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 27, 2020 at 07:37:01PM -0400, Chuck Lever wrote:
> 
> 
> Squelch some sparse warnings:
> 
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2264:13: warning: incorrect type in assignment (different base types)
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2264:13:    expected int err
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2264:13:    got restricted __be32
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2266:24: warning: incorrect type in return expression (different base types)
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2266:24:    expected restricted __be32
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2266:24:    got int err
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2288:13: warning: incorrect type in assignment (different base types)
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2288:13:    expected int err
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2288:13:    got restricted __be32
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2290:24: warning: incorrect type in return expression (different base types)
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2290:24:    expected restricted __be32
> /home/cel/src/linux/linux/fs/nfsd/vfs.c:2290:24:    got int err
> 
> Fixes: 32119446bb65 ("nfsd: define xattr functions to call into their vfs counterparts")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---

Thanks.. sorry about that, one of those "I could have sworn I took care of
those" cases.

- Frank
