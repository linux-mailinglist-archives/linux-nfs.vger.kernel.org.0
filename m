Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B9220A5A7
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2020 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390764AbgFYTU7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 15:20:59 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:38372 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390697AbgFYTU7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 15:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1593112858; x=1624648858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dzwcS8aZr9FieWjiSx4InVOct6F2W6IwdXYQqBLKCqc=;
  b=ldUAmoWXBOkg5jmUEVog5Jj60wDwiruJnxFTHCBuGONrikPmaOCndT7e
   rYs3LyVAZytRulrfTy/1Yr7qgehbaqrHVAqekkVvNg0QaZlglLg0PLSPb
   bItTjLOV7pk4WkIdil8kivBkza4AKuEuI974XWpXkEXpTYftFf6GMpVzK
   M=;
IronPort-SDR: qmUCj455Zxau7Z9VFBULsSqg22FuoPz1iyWvjl7gKf7QvcN5MdgXJUjkIKC/Ls/MfJ/U6x2LaA
 xD+Rqz14VSBA==
X-IronPort-AV: E=Sophos;i="5.75,280,1589241600"; 
   d="scan'208";a="55270474"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Jun 2020 19:20:56 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 8D49BA23A2;
        Thu, 25 Jun 2020 19:20:55 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Jun 2020 19:20:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Jun 2020 19:20:54 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 25 Jun 2020 19:20:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 0AD27C3318; Thu, 25 Jun 2020 19:20:55 +0000 (UTC)
Date:   Thu, 25 Jun 2020 19:20:55 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
Subject: Re: nfsd filecache issues with v4
Message-ID: <20200625192054.GD29600@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200608192122.GA19171@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20200625171021.GC30655@fieldses.org>
 <20200625191205.GC29600@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200625191205.GC29600@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 25, 2020 at 07:12:05PM +0000, Frank van der Linden wrote:
> Some ideas to alleviate the pain short of doing the above:
> 
> * Count v4 references to nfsd_file (filecache) structures. If there
>   is a v4 reference, don't have the file on the LRU, as it's pointless.
>   Do include it in the hash table so that v2/v3 users can find it. This
>   avoids the worst offender (nfsd_file_lru), but does still blow up
>   nfsd_file_hashtbl.
> 
> * Use rhashtable for the hashtables, as it can automatically grow/shrink
>   the number of buckets. I don't know if the rhashtable code could handle
>   the load, but it might be worth a shot.

In fact, don't even put an nfsd_file on the LRU until the first time its
references drop to 1, e.g. when it's no longer being used. Because it
will never be removed if the refs are > 1, in any case.

Let me come up with a patch for that, shouldn't be too hard.

- Frank
