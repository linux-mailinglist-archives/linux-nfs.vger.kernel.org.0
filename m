Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB1D1947AF
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 20:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgCZTnX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 15:43:23 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:43175 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTnX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 15:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585251803; x=1616787803;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=kkMAo9tlALypU50SmLIoNgIeRamMDYFBFxphReA70RQ=;
  b=lg0e8UwxaQ71I7iN8uf1OI4RE0qUY1v6r86a4eepk7Uo+AxmfdrIBJDC
   6R+rLGIKHRfPX6r7faiMV2sGimtFpv2RkGpXr6kbRMCsyn8nApcZg4OEK
   Rth9qMFhz0yyoCurUkQEhT2li39vZkUGgtqq58OMnMmTvP/5GuP5GDLR4
   w=;
IronPort-SDR: Wq6+MP2377wZj7q4xMEyB/mwh8AAKn/fxyGz9+qchUYScaFOWFEhhHCu2Felrj8CI8OWGijB9i
 mO9L7IvU4SzQ==
X-IronPort-AV: E=Sophos;i="5.72,309,1580774400"; 
   d="scan'208";a="25296185"
Subject: Re: [PATCH v2 00/13] NFS client user xattr (RFC8276) support
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 26 Mar 2020 19:43:21 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 3A48CA1FFA;
        Thu, 26 Mar 2020 19:43:20 +0000 (UTC)
Received: from EX13D34UWC001.ant.amazon.com (10.43.162.112) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Mar 2020 19:43:19 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D34UWC001.ant.amazon.com (10.43.162.112) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Mar 2020 19:43:19 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Thu, 26 Mar 2020 19:43:19 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id BDF42D92A4; Thu, 26 Mar 2020 19:43:19 +0000 (UTC)
Date:   Thu, 26 Mar 2020 19:43:19 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
CC:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Message-ID: <20200326194319.GA3398@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
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
> Hi Frank.
> 
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
> 
> Regards,
>    Tigran.

Hi Tigran,

This patchset works against the server side patches, and also works against
a FreeBSD-current server.

Is this failure happening with your Java server?

Let me look at your packet dump and compare it with a working scenario.

- Frank
