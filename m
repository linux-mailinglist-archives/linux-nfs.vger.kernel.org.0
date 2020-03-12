Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD80183AE2
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 21:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgCLUvp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 16:51:45 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:7810 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLUvp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 16:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584046305; x=1615582305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C+p2pNJnFkPfToLtvxUpfsaaGeQeKgcQfW/hF107O5c=;
  b=v9ZUgbnvCnv0nu49Yz0gnFoXq0Ez+fTwqXZvST9QwSILQy+c7lUNua0Q
   CG+elJhSrY8NzpjiITF6pjbHts/AxzDVsIqpFHIj8MWf6K43zMn5FFMlv
   u/TBJl8yXi1xtzDZVce5cfT7Vk3PBtWFFf2WJXrPWJ8slZ2yXBa1rv+Sz
   A=;
IronPort-SDR: vWJBAWirJ4KF7BjXQAftYG0Hn8i6kWFPUj3NejJiQT+YdHlgTloX3IfvDNfeDWuliQDFrME0Y5
 qJCl/wouB/BQ==
X-IronPort-AV: E=Sophos;i="5.70,545,1574121600"; 
   d="scan'208";a="22543996"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 12 Mar 2020 20:51:43 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 910DD241E9F;
        Thu, 12 Mar 2020 20:51:40 +0000 (UTC)
Received: from EX13D25UEA004.ant.amazon.com (10.43.61.126) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 12 Mar 2020 20:51:40 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D25UEA004.ant.amazon.com (10.43.61.126) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Mar 2020 20:51:39 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1236.3 via Frontend Transport; Thu, 12 Mar 2020 20:51:39 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 4E45BC13B8; Thu, 12 Mar 2020 20:51:39 +0000 (UTC)
Date:   Thu, 12 Mar 2020 20:51:39 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 03/13] NFSv4.2: query the server for extended attribute
 support
Message-ID: <20200312205139.GA32293@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
 <20200311195613.26108-4-fllinden@amazon.com>
 <530167624.4533477.1584029710746.JavaMail.zimbra@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <530167624.4533477.1584029710746.JavaMail.zimbra@desy.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 12, 2020 at 05:15:10PM +0100, Mkrtchyan, Tigran wrote:
> > +     fattr4_word2_nfs42_mask = FATTR4_WORD2_NFS42_MASK;
> > +
> > +     if (minorversion >= 2) {
> 
> I am not sure you need this extra check as by querying for  FATTR4_WORD0_SUPPORTED_ATTRS
> server already will return FATTR4_WORD2_XATTR_SUPPORT if supported.

There used to be a mount option check here, which I later removed. That
means that fattr4_word2_nfs42_mask is no longer needed, so I'll remove
that.

As for the attribute itself: I suppose the question here is what the client
should use to assume the server has RFC 8276 support:

1) The xattr_support attribute exists
2) The xattr support attribute exists *and* it's true for the root fh

Currently the code does 2) in one operation. That might not be 100%
correct - the RFC does mention that (section 8.2):

"Before interrogating this attribute using GETATTR, a client should
 determine whether it is a supported attribute by interrogating the
 supported_attrs attribute."

That's a "should", not a "MUST", but it's still waving its finger
at you not to do this.

Since 8.2.1 says:

"However, a client may reasonably assume that a server
 (or file system) that does not support the xattr_support attribute
 does not provide xattr support, and it acts on that basis."

..I think you're right, and the code should just use the existence
of the attribute as a signal that the server knows about xattrs -
operations should still error out correctly if it doesn't.

I'll make that change, thanks.

Frank
