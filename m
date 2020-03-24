Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2719162C
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2020 17:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgCXQVX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 12:21:23 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:51503 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgCXQVW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Mar 2020 12:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585066882; x=1616602882;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=lHOS/dh88z3U2qZioVP96n0RoORSEsBhqjVDzYTZ3cg=;
  b=JR3ZJmUmwpeJcod5SRDOuZ8L/NdEPH47VG6/MG57GQ5jQh3lWfgVdjna
   HL5xKFw177k5LgfpgR92/5hmrIydaWvrDqhoiKp3JbT4VtWJe4O14TGE5
   JHgqcTlZ8kuiSxw+UiYigk0eGliGxyhXGd675CQWtz7P8k94NRqEK25cv
   k=;
IronPort-SDR: 3bQUevArD9VSq70qRf1G8ZT9dQ1AT496/0nDkyETwBsRt6jxKjrjxlyVcAivYnr65IpfvHBa4U
 UDzDUN1r9vuw==
X-IronPort-AV: E=Sophos;i="5.72,301,1580774400"; 
   d="scan'208";a="22698173"
Subject: Re: [nfs] c5654df66d: stress-ng.msg.ops_per_sec 15.5% improvement
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 24 Mar 2020 16:21:09 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 82F4DA2967;
        Tue, 24 Mar 2020 16:21:08 +0000 (UTC)
Received: from EX13D03UWC004.ant.amazon.com (10.43.162.49) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 24 Mar 2020 16:21:08 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D03UWC004.ant.amazon.com (10.43.162.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Mar 2020 16:21:07 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Tue, 24 Mar 2020 16:21:07 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id E8E23C1350; Tue, 24 Mar 2020 16:21:07 +0000 (UTC)
Date:   Tue, 24 Mar 2020 16:21:07 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     kernel test robot <rong.a.chen@intel.com>
CC:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>, <lkp@lists.01.org>
Message-ID: <20200324162107.GA8591@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200311195613.26108-10-fllinden@amazon.com>
 <20200324060215.GD11705@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200324060215.GD11705@shao2-debian>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 24, 2020 at 02:02:15PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a 15.5% improvement of stress-ng.msg.ops_per_sec due to commit:
> 
> 
> commit: c5654df66d65f6b5f8967f15a0b61f89acb5941e ("[PATCH 09/13] nfs: define and use the NFS_INO_INVALID_XATTR flag")
> url: https://github.com/0day-ci/linux/commits/Frank-van-der-Linden/client-side-user-xattr-RFC8276-support/20200312-064740
> base: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next

Hm, I think I have doubts about the validity of a test that sees a 15%
improvement in SysV msg ops after a change in the NFS client code :-)

- Frank
