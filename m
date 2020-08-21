Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185CF24D954
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Aug 2020 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgHUQDu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Aug 2020 12:03:50 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:59064 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgHUQDt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Aug 2020 12:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598025829; x=1629561829;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=5UldaKTyngQcxUp0JS2jhLGvIH8ek+w5BwOPPdt5G74=;
  b=CDHcGn8ubf/6T8AEd/vPZMgvdw+nLWo0ON3ypobx701UAGPfjUMDDjGa
   il96PgrycqhUz3m6jDa7jPiGrHE9NfiDuAiEhvWS4xcw3J/56CRzLvR4d
   ik24qH9Z3CJZMm0jibIwOwyG4Y3YN3R8fvIkzip0OPBPXquZ0CwXsrrKe
   E=;
X-IronPort-AV: E=Sophos;i="5.76,337,1592870400"; 
   d="scan'208";a="69904285"
Subject: Re: [PATCH v3 12/13] NFSv4.2: hook in the user extended attribute handlers
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 21 Aug 2020 16:03:41 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id ABD86A2999;
        Fri, 21 Aug 2020 16:03:39 +0000 (UTC)
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 21 Aug 2020 16:03:39 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Fri, 21 Aug 2020 16:03:39 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id E7CB4C14DA; Fri, 21 Aug 2020 16:03:38 +0000 (UTC)
Date:   Fri, 21 Aug 2020 16:03:38 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
CC:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Message-ID: <20200821160338.GA30541@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
 <20200623223904.31643-13-fllinden@amazon.com>
 <CADJHv_tVZ3KzO_RZ18V=e6QBYEFnX5SbyVU6yhh6yCqYMmvmRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CADJHv_tVZ3KzO_RZ18V=e6QBYEFnX5SbyVU6yhh6yCqYMmvmRQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 21, 2020 at 02:50:59PM +0800, Murphy Zhou wrote:
> Hi,
> 
> On Wed, Jun 24, 2020 at 6:51 AM Frank van der Linden
> <fllinden@amazon.com> wrote:
[...]
> >  static const struct inode_operations nfs4_dir_inode_operations = {
> > @@ -10146,10 +10254,21 @@ static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
> >         .set    = nfs4_xattr_set_nfs4_acl,
> >  };
> >
> > +#ifdef CONFIG_NFS_V4_2
> > +static const struct xattr_handler nfs4_xattr_nfs4_user_handler = {
> > +       .prefix = XATTR_USER_PREFIX,
> > +       .get    = nfs4_xattr_get_nfs4_user,
> > +       .set    = nfs4_xattr_set_nfs4_user,
> > +};
> > +#endif
> > +
> 
> Any plan to support XATTR_TRUSTED_PREFIX ?
> 
> Thanks.

This is an implementation of RFC 8276, which explicitly restricts itself
to the "user" namespace.

There is currently no portable way to implement the "trusted" namespace
within the boundaries of the NFS specification(s), so it's not
supported.

- Frank
