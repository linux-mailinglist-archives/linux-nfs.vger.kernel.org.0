Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53F82501DE
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Aug 2020 18:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHXQRF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Aug 2020 12:17:05 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:16703 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHXQRC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Aug 2020 12:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598285822; x=1629821822;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=89vyoYBrFOa9NtETNVgENA5g+YgsSPWrwx3Sucvbg+4=;
  b=Hhg1uITDeHKZC+jwTWDmedy8lWeHjb5p1Bgd1go3EUA1NaKmcW3BnyYg
   DtySF+iwNSEkfVM+0Q7MQ1XCIVVEaAdDLb5Iq19zUQ0S3CsYBe5YnWFvS
   nAvo1M2lXHc8bWxR+zMJ/2E1wG7A1l9pSWSlRiyEImFAxohQ4zcnLvIJw
   c=;
X-IronPort-AV: E=Sophos;i="5.76,349,1592870400"; 
   d="scan'208";a="69232907"
Subject: Re: [PATCH v3 12/13] NFSv4.2: hook in the user extended attribute handlers
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 24 Aug 2020 16:17:00 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 62D51A15CB;
        Mon, 24 Aug 2020 16:16:58 +0000 (UTC)
Received: from EX13D30UEA004.ant.amazon.com (10.43.61.103) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 24 Aug 2020 16:16:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D30UEA004.ant.amazon.com (10.43.61.103) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 24 Aug 2020 16:16:57 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 24 Aug 2020 16:16:57 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 3DB7AC1424; Mon, 24 Aug 2020 16:16:57 +0000 (UTC)
Date:   Mon, 24 Aug 2020 16:16:57 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Message-ID: <20200824161657.GA25229@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
 <20200623223904.31643-13-fllinden@amazon.com>
 <CADJHv_tVZ3KzO_RZ18V=e6QBYEFnX5SbyVU6yhh6yCqYMmvmRQ@mail.gmail.com>
 <20200821160338.GA30541@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <62aa76de0ea316c029b7f9c22cf36c92b8cba2d9.camel@hammerspace.com>
 <20200824001345.nszimqfcsumd4xil@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200824001345.nszimqfcsumd4xil@xzhoux.usersys.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 24, 2020 at 08:13:45AM +0800, Murphy Zhou wrote:
> Thank you guys explanation!
> 
> I'm asking because after NFSv4.2 xattr update, there are some xfstests
> new failures about 'trusted' xattr. Now they can be surely marked as
> expected.

I have some patches to xfstests that, amongst other things, split 
the xfstests xattr requirement checks in to individual namespace
checks, so that tests that use "user" xattrs will be run on NFS, but
others, e.g. "trusted" do not.

I should clean them off and send them in.

- Frank
