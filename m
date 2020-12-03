Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110C92CDB07
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 17:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389336AbgLCQT6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 11:19:58 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:4540 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389309AbgLCQT6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 11:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1607012399; x=1638548399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HPjgKDHY3QoU63i+MwIL4oZhDpdGSvAZexj423632cE=;
  b=QRzmg5C63r2bB8o1K/0zOn8xQ1VhbR7rvyyZO8JMxUdrqWbY+b60lufr
   ni0CKv5IGAotk0LffgOkA1DADwvOptOi6Et+FckU4Wt0BRbm5X42+tsdF
   BxWVl49neUM+5XKzLKWh9BbxlkZuWM6jJtmJFahujAnZtebML6OIaY/j6
   Y=;
X-IronPort-AV: E=Sophos;i="5.78,389,1599523200"; 
   d="scan'208";a="93254237"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Dec 2020 16:19:03 +0000
Received: from EX13MTAUEB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id E85A9A2167;
        Thu,  3 Dec 2020 16:19:00 +0000 (UTC)
Received: from EX13D01UEB004.ant.amazon.com (10.43.60.43) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 3 Dec 2020 16:18:59 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D01UEB004.ant.amazon.com (10.43.60.43) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 3 Dec 2020 16:18:59 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 3 Dec 2020 16:18:59 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 141A8C1321; Thu,  3 Dec 2020 16:18:58 +0000 (UTC)
Date:   Thu, 3 Dec 2020 16:18:58 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        trondmy <trondmy@hammerspace.com>
Subject: Re: Kernel OPS when using xattr
Message-ID: <20201203161858.GA27349@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de>
 <CAN-5tyEWYqXiqLdJE-DLH2b+LrVfPkviJDGQY=MyitS5aW4bJw@mail.gmail.com>
 <1296195278.2032485.1607010192169.JavaMail.zimbra@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1296195278.2032485.1607010192169.JavaMail.zimbra@desy.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 03, 2020 at 04:43:12PM +0100, Mkrtchyan, Tigran wrote:
> 
> Hi Olga,
> 
> Franks patches are not applied. I will check with Trond's patch and
> then will try those as well.
> 
> Regards,
>    Tigran.

Since my change no longer uses SPARSE_PAGES, it'll probably avoid the
oops, so give it a try.

Having said that, fixing SPARSE_PAGES seems like a better option.. My
ideal outcome would be to have a working SPARSE_PAGES for all transports.
That would allow GETXATTR and LISTXATTRS to just always specify a max
size array of pages, giving it maximum flexibility to cache the received
result no matter what, and avoiding allocations that are too large.

For now, though, I'm happy with the v2 patch I sent in.

- Frank
