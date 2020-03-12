Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A522A183B28
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 22:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCLVQB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 17:16:01 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:4464 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCLVQB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 17:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584047761; x=1615583761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZBMPMVMFpuP37u2UfUI5bADY2gVZ0Cn5j/haovyIyIg=;
  b=ehvuRBAPldrt3nVgnWgeSsR6QXwYJ3HVpnv0/98Ke99arLNDFrPCVSp+
   y7y41NQkqg2P8Z3IpDU99Wyr7Jc5Gpexx4Aa98Bato8M6/e1+RO8Wp0zp
   v1v357oRQtRI9L87apTQ9KZAvEvNYOpDhICyefXqdMDYINsMBXn8ePOUo
   s=;
IronPort-SDR: 492N0sbOk7JLtNFgvd3ONfk+npPEkJ5NbyhhgDiNVdqxyU814aqbmQcJORu+w5092cCBnG03yp
 jkd9FgoMhKCw==
X-IronPort-AV: E=Sophos;i="5.70,546,1574121600"; 
   d="scan'208";a="32302386"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Mar 2020 21:15:58 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id EDD1B240B8E;
        Thu, 12 Mar 2020 21:15:56 +0000 (UTC)
Received: from EX13D29UWA001.ant.amazon.com (10.43.160.187) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Mar 2020 21:15:56 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D29UWA001.ant.amazon.com (10.43.160.187) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Mar 2020 21:15:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Thu, 12 Mar 2020 21:15:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id C58A7C13B8; Thu, 12 Mar 2020 21:15:55 +0000 (UTC)
Date:   Thu, 12 Mar 2020 21:15:55 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 03/13] NFSv4.2: query the server for extended attribute
 support
Message-ID: <20200312211555.GA5974@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
 <20200311195613.26108-4-fllinden@amazon.com>
 <530167624.4533477.1584029710746.JavaMail.zimbra@desy.de>
 <20200312205139.GA32293@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200312205139.GA32293@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 12, 2020 at 08:51:39PM +0000, Frank van der Linden wrote:
> 1) The xattr_support attribute exists
> 2) The xattr support attribute exists *and* it's true for the root fh
> 
> Currently the code does 2) in one operation. That might not be 100%
> correct - the RFC does mention that (section 8.2):
> 
> "Before interrogating this attribute using GETATTR, a client should
>  determine whether it is a supported attribute by interrogating the
>  supported_attrs attribute."
> 
> That's a "should", not a "MUST", but it's still waving its finger
> at you not to do this.
> 
> Since 8.2.1 says:
> 
> "However, a client may reasonably assume that a server
>  (or file system) that does not support the xattr_support attribute
>  does not provide xattr support, and it acts on that basis."
> 
> ..I think you're right, and the code should just use the existence
> of the attribute as a signal that the server knows about xattrs -
> operations should still error out correctly if it doesn't.
> 
> I'll make that change, thanks.

..or, alternatively, only query xattr_support in nfs4_server_capabilities,
and then its actual value, if it exists, in nfs4_fs_info.

Any opinions on this?

- Frank
