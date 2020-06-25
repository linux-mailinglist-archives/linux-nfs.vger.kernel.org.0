Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E464520A42A
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2020 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405255AbgFYRjW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 13:39:22 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:20339 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405070AbgFYRjV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 13:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1593106762; x=1624642762;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=i0IL/e8lGPymL5P20XRGaHauygZudyPYZ2TbY1s2H38=;
  b=M7WTSvG/YpH2Gi+rUU4Qv63xDgDv0e5Tn8pO2J4n1/SH1l6n7N4MvoH8
   Qw7SiLTrsHD9+paD2xSx6J0M/z00oPczm33d8kIcUtl6suveO3n0qVNgq
   G/Pjj+h8wyIF6xqf4ph8Z9MPy78FLlSECBF/HRf5+8z8iFKctyW4ZDitQ
   0=;
IronPort-SDR: pminOWcjis4nRjrOu4V19+gSD9rciIH/3ITtqEG1rW8FjkMM1dYobKGV2iSw1HEjDBwMeIcdQt
 oy8I5aI50qdQ==
X-IronPort-AV: E=Sophos;i="5.75,280,1589241600"; 
   d="scan'208";a="53958709"
Subject: Re: [PATCH v3 00/10] server side user xattr support (RFC 8276)
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 25 Jun 2020 17:39:18 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 3D31AA2293;
        Thu, 25 Jun 2020 17:39:17 +0000 (UTC)
Received: from EX13D17UWB001.ant.amazon.com (10.43.161.252) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Jun 2020 17:39:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D17UWB001.ant.amazon.com (10.43.161.252) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Jun 2020 17:39:16 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 25 Jun 2020 17:39:16 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 9D5C3C3318; Thu, 25 Jun 2020 17:39:16 +0000 (UTC)
Date:   Thu, 25 Jun 2020 17:39:16 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     <chuck.lever@oracle.com>, <linux-nfs@vger.kernel.org>
Message-ID: <20200625173916.GB29600@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
 <20200625165347.GB30655@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200625165347.GB30655@fieldses.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 25, 2020 at 12:53:47PM -0400, J. Bruce Fields wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> By the way, I can't remember if I asked this before: is there a
> particular use case that motivates this xattr work?
> 
> --b.

There's one use case that I can't really talk about publicly at this point
(and it's not my code either, so I wouldn't have all the details). Nothing
super secret or anything - it's just something that is not mine,
so I won't try to speak for anyone. We wanted to get this upstreamed first,
as that's the right thing to do.

Since I posted my first RFC, I did get contacted off-list by several
readers of linux-nfs who wanted to use the feature in practice, too, so
there's definitely interest out there.

- Frank
