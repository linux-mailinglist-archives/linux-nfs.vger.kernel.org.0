Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D91B184E0C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 18:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCMRzd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 13:55:33 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:52348 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMRzd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Mar 2020 13:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584122134; x=1615658134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+IAf3wqqqLRqK3NTbkIrhUY5+LJxFuN34aCWNO1M0Vs=;
  b=HyVxABY0oElm4ke0KfBd1T69irV3DQNmYWYO+4rb/9xskcQdUUdkEULU
   Q0uNE+SHdDUxvbZZZ3T4boMgwNaGT7jDKRUr7NSE/4Uqe8xe73vXrWHVz
   k2KacO9fSUYrKUD9YqgeXgJjkuO71k9w7973EDuhyMRyCOxtgOZpbSHBN
   A=;
IronPort-SDR: E98odBEbbxoB6CpZxbkA79UMyRomc6Ad5d454v/JN7aVoSVPu8apoYq+3uMYRrDAJ9FquK0cts
 WW41ZCnMeLJQ==
X-IronPort-AV: E=Sophos;i="5.70,549,1574121600"; 
   d="scan'208";a="31087707"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 13 Mar 2020 17:55:31 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 1C40CA2B12;
        Fri, 13 Mar 2020 17:55:30 +0000 (UTC)
Received: from EX13D37UWA003.ant.amazon.com (10.43.160.25) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Mar 2020 17:55:29 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D37UWA003.ant.amazon.com (10.43.160.25) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 13 Mar 2020 17:55:29 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 13 Mar 2020 17:55:29 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 91E22C13BA; Fri, 13 Mar 2020 17:55:29 +0000 (UTC)
Date:   Fri, 13 Mar 2020 17:55:29 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 03/13] NFSv4.2: query the server for extended attribute
 support
Message-ID: <20200313175529.GB31307@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
 <20200311195613.26108-4-fllinden@amazon.com>
 <530167624.4533477.1584029710746.JavaMail.zimbra@desy.de>
 <20200312205139.GA32293@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20200312211555.GA5974@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <948465413.4651196.1584097887947.JavaMail.zimbra@desy.de>
 <6792d6a6012a241b8bd1555eea8c592ff318a444.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6792d6a6012a241b8bd1555eea8c592ff318a444.camel@hammerspace.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Mar 13, 2020 at 01:50:38PM +0000, Trond Myklebust wrote:
> 'xattr_support' seems like a protocol hack to allow the client to
> determine whether or not the xattr operations are supported.
> 
> The reason why it is a hack is that 'supported_attrs' is also a per-
> filesystem attribute, and there is no value in advertising
> 'xattr_support' there unless your filesystem also supports xattrs.
> 
> IOW: the protocol forces you to do 2 round trips to the server in order
> to figure out something that really should be obvious with 1 round
> trip.

Right, that's the annoying part. I mean, theoretically, a server can
legally reject a GETATTR because you're asking for an unknown
attribute (e.g. xattr_support in this case). So then what I have
in my current patch (asking for both the supported_attrs and
xattr_support at once) might fail, and the mount would fail.

Which means I should split it up and have nfs4_do_fsinfo do
the 2nd part, just in case.

- Frank
