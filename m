Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2380A1934B9
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 00:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCYXpB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 19:45:01 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:55704 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgCYXpB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 19:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585179901; x=1616715901;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=7JI0zNZnqBVSTnkujz+99I77yvFGg4iqfKnGSolIdEg=;
  b=GkF64XYyLxR+Kj63FzR7Vod7jC6fE6ylKn/x33sIE8Qy72KjrWATYQtc
   ZdNvgMgw28YUlGPlQ95vDmsCprFgoaTzennJHdvq44KX3PJUsoyEh6sQ/
   FQZ9OnGimIB7PTzPco8mIyOLxuctMTY+7r578EUGejpwob/HyF3k8fU54
   I=;
IronPort-SDR: L0zWidj/zRgOxSCqHGxQMkMw+j7htn8KudrSjG/XFuuv83t+Lk1tAoiIVik60k0RLxy1ZRADyp
 T2VxBElayaRA==
X-IronPort-AV: E=Sophos;i="5.72,306,1580774400"; 
   d="scan'208";a="33472389"
Subject: Re: [PATCH 11/14] nfsd: add user xattr RPC XDR encoding/decoding logic
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Mar 2020 23:44:59 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id D84BCA0495;
        Wed, 25 Mar 2020 23:44:57 +0000 (UTC)
Received: from EX13D15UEE004.ant.amazon.com (10.43.62.241) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 23:44:56 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D15UEE004.ant.amazon.com (10.43.62.241) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 23:44:56 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 25 Mar 2020 23:44:56 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 08745C1350; Wed, 25 Mar 2020 23:44:56 +0000 (UTC)
Date:   Wed, 25 Mar 2020 23:44:56 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <20200325234455.GA742@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-12-fllinden@amazon.com>
 <17D7709F-2FE0-4B84-A9AF-4D6C2B36A4E7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <17D7709F-2FE0-4B84-A9AF-4D6C2B36A4E7@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 12, 2020 at 12:24:18PM -0400, Chuck Lever wrote:
> > On Mar 11, 2020, at 3:59 PM, Frank van der Linden <fllinden@amazon.com> wrote:
> > +     /*
> > +      * Unfortunately, there is no interface to only list xattrs for
> > +      * one prefix. So there is no good way to convert maxcount to
> > +      * a maximum value to pass to vfs_listxattr, as we don't know
> > +      * how many of the returned attributes will be user attributes.
> > +      *
> > +      * So, always ask vfs_listxattr for the maximum size, and encode
> > +      * as many as possible.
> > +      */
> 
> Well, this approach worries me a little bit. Wouldn't it be better if the
> VFS provided the APIs? Review by linux-fsdevel might help here.

I missed this comment initially, sorry about the slow reply.

I'll copy this one to -fsdevel for v2.

It would require a modified or new entry point to all filesystems to
support this properly, so I didn't touch it. It's not a complex
task, it just would lead to quite a bit of code churn.

- Frank
