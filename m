Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75158186F43
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2020 16:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbgCPPvT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Mar 2020 11:51:19 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:47481 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732112AbgCPPvS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Mar 2020 11:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584373878; x=1615909878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AmCD6GVkfHT8rCJnbXqVGTn1R1vze0WgfdXja/KZSFw=;
  b=U8l9B1+T1rBPIuFgXW04nLz3BDoJCE4Ytpv46+ZreI4K6PeUwyhqXGSC
   xn+hMOXpNcudVqeZ9XazHD4mV+Tj9gc8i9WoJ0r6XQcetT4lxtZCJC+Xn
   E7GHVUvwDhF781hfz8xTkWikKigZJVrMrBpCWd+iUQD1GOZvsesd9U+NO
   U=;
IronPort-SDR: YAj5FEhNNtSE+ggIrlVGErs8trFHfhzOgsi07IhgKuMgZhYuyUGD9FLHNoPDk4A8ZxP/RkQFwG
 LEf9AOJrXdCQ==
X-IronPort-AV: E=Sophos;i="5.70,560,1574121600"; 
   d="scan'208";a="21420330"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 16 Mar 2020 15:50:55 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id AC992A238A;
        Mon, 16 Mar 2020 15:50:53 +0000 (UTC)
Received: from EX13D26UEE002.ant.amazon.com (10.43.62.30) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Mar 2020 15:50:53 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D26UEE002.ant.amazon.com (10.43.62.30) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 16 Mar 2020 15:50:53 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Mon, 16 Mar 2020 15:50:53 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id CE672C130A; Mon, 16 Mar 2020 15:50:52 +0000 (UTC)
Date:   Mon, 16 Mar 2020 15:50:52 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>
CC:     <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 00/13] client side user xattr (RFC8276) support
Message-ID: <20200316155052.GA6212@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
 <CAFX2Jf=g2Pv62cnciB4VG6HTndJSrtfeSR_oVu9PmiBez8_Upw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFX2Jf=g2Pv62cnciB4VG6HTndJSrtfeSR_oVu9PmiBez8_Upw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna,

On Thu, Mar 12, 2020 at 04:09:51PM -0400, Anna Schumaker wrote:
> I'm curious if you've tried xfstests with your patches? There are a
> handful of tests using xattrs that might be good to check with, too:
> 
> anna@gouda % grep xattr -l tests/generic/[0-9][0-9][0-9]
> tests/generic/037
> tests/generic/062
> tests/generic/066
> tests/generic/093
> tests/generic/117
> tests/generic/337
> tests/generic/377
> tests/generic/403
> tests/generic/425
> tests/generic/454
> tests/generic/489
> tests/generic/523
> tests/generic/529
> tests/generic/556
> 
> Thanks,
> Anna

I did run xfstests, and it looks fine, meaning that the differences between
actual and expected output are expected. I can rerun the xattr
specific ones and post the report. Will do that with v2.

- Frank
