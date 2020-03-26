Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85F0194C0B
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 00:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCZXQS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 19:16:18 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:20649 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZXQS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 19:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585264577; x=1616800577;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=6AiyNYqRtKTK4AcYgbg/kzINgVDS2hv+9Q2+eYU3+uk=;
  b=ULzD1GlRDpPRmgWYAu6XOiLKotBPzX08H72dLeCwOKjXTQ4gvzTLGYq4
   EP/zwN+AM8EC/d07WNB2p8tumVuGRaTst2p+ww1KAZm27BRip4n+Xstq+
   0E0P9uXIRTn8y4c0Kx1qHCenBCDw3iK5U7dOmGQLA1ApTiCHmL6xkG9iS
   I=;
IronPort-SDR: Atb902mrZSWiH2A+mnNl62XXB9l0VV7wdwrC74HgPJL2BMBPW1SVmngMmkz55FT+XMUj2EeuI3
 LDjBDbyEIUUA==
X-IronPort-AV: E=Sophos;i="5.72,310,1580774400"; 
   d="scan'208";a="22920075"
Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 26 Mar 2020 23:16:04 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 4E358A1C2E;
        Thu, 26 Mar 2020 23:16:02 +0000 (UTC)
Received: from EX13D14UWC003.ant.amazon.com (10.43.162.19) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Mar 2020 23:16:02 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D14UWC003.ant.amazon.com (10.43.162.19) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Mar 2020 23:16:02 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Thu, 26 Mar 2020 23:16:02 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 53D31DEE07; Thu, 26 Mar 2020 23:16:02 +0000 (UTC)
Date:   Thu, 26 Mar 2020 23:16:02 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
CC:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Message-ID: <20200326231602.GA29187@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com>
 <1885904737.8217161.1585249393750.JavaMail.zimbra@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1885904737.8217161.1585249393750.JavaMail.zimbra@desy.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Mar 26, 2020 at 08:03:13PM +0100, Mkrtchyan, Tigran wrote:
> The new patchset looks broken to me.
> 
> Client quiryes for supported attributes and gets xattr_support bit set:
> 
> Mar 26 11:27:07 ani.desy.de kernel: decode_attr_supported: bitmask=fcffbfff:40fdbe3e:00040800
> 
> However, the attribute never queries, but client makes is decision:
> 
> Mar 26 11:27:07 ani.desy.de kernel: decode_attr_xattrsupport: XATTR support=false
> 
> The packets can be found here: https://sas.desy.de/index.php/s/GEPiBxPg3eR4aGA
> 
> Can you provide packets of your mount/umount round.

Hi Tigran,

I looked at your packet dump. It seems like your server only supports 4.1,
not 4.2. xattr support builds on 4.2 (within the rules laid out in
RFC 8178).

So, the fsinfo client call, which is just a GETATTR, masks out the 4.2
fattr bits from server->attr_mask, and just uses the 4.1 bits. Meaning that
xattr_support is not included, and defaults to false.

The packet dump also indicates that your server advertises the xattr_support
fattr as supported, even though it's in a 4.1 session, which would not
be correct.

- Frank
