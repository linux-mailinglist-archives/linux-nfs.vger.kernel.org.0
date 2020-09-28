Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D022A27B12E
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgI1Puu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 11:50:50 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:11026 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgI1Put (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Sep 2020 11:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601308249; x=1632844249;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=ckEZD2oJkSbE06Sox9DVaU/0VWyIOtd9QpByFCgfpOk=;
  b=gvza15HFRpiPf0T0MvQIGU+/a8f02Pha0MT0OGQJwtQ8+vhgFkekbuhQ
   FOwCK/KFQqoqVu04G5Wkoc/YH5L6SSwWRBd+KHfQTiQqsd+9uP+b6Vd+e
   CjZ00QfxmjRS1po3rMRJeF/DFdDCQzY2nrpuyxRBJ0FIfztb6DNcCBREF
   A=;
X-IronPort-AV: E=Sophos;i="5.77,313,1596499200"; 
   d="scan'208";a="56504845"
Subject: Re: Adventures in NFS re-exporting
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 28 Sep 2020 15:49:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id 6391AC05DE;
        Mon, 28 Sep 2020 15:49:52 +0000 (UTC)
Received: from EX13D21UEA002.ant.amazon.com (10.43.61.179) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 28 Sep 2020 15:49:50 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D21UEA002.ant.amazon.com (10.43.61.179) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 28 Sep 2020 15:49:50 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Mon, 28 Sep 2020 15:49:49 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 9F9F4C13F0; Mon, 28 Sep 2020 15:49:49 +0000 (UTC)
Date:   Mon, 28 Sep 2020 15:49:49 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Daire Byrne <daire@dneg.com>
CC:     Chuck Lever <chuck.lever@oracle.com>,
        bfields <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Message-ID: <20200928154949.GA14702@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <20200915172140.GA32632@fieldses.org>
 <2001715792.39705019.1600358470997.JavaMail.zimbra@dneg.com>
 <20200917190931.GA6858@fieldses.org>
 <20200917202303.GA29892@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <76A4DC7D-D4F7-4A17-A67D-282E8522132A@oracle.com>
 <1790619463.44171163.1600892707423.JavaMail.zimbra@dneg.com>
 <20200923210157.GA1650@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <108670779.52656705.1601110822013.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <108670779.52656705.1601110822013.JavaMail.zimbra@dneg.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Sep 26, 2020 at 10:00:22AM +0100, Daire Byrne wrote:
> 
> 
> ----- On 23 Sep, 2020, at 22:01, Frank van der Linden fllinden@amazon.com wrote:
> > It's entirely possible that my patch introduces a refcounting error - it was
> > intended as a proof-of-concept on how to fix the LRU locking issue for v4
> > open file caching (while keeping it enabled) - which is why I didn't
> > "formally" send it in.
> >
> > Having said that, I don't immediately see the problem.
> >
> > Maybe try it without the rhashtable patch, that is much less of an
> > optimization.
> >
> > The problem would have to be nf_ref as part of nfsd_file, or fi_ref as part
> > of nfs4_file. If it's the latter, it's probably the rhashtable change.
> 
> Thanks Frank; I think you are right in that it seems to be a problem with the rhashtable patch. Another 48 hours using the same workload with just the main patch and I have not seen the same issue again so far.
> 
> Also, it still has the effect of reducing the CPU usage dramatically such that there are plenty of cores still left idle. This is actually helping us buy some more time while we fix our obviously broken software so that it doesn't open/close so crazily.
> 
> So, many thanks for that.

Cool. I'm glad the "don't put v4 files on the LRU list" works as intended for
you. The rhashtable patch was more of an afterthought, and obviously has an
issue. It did provide some extra gains, so I'll see if I can find the problem
if I get some time.

Bruce - if you want me to 'formally' submit a version of the patch, let me
know. Just disabling the cache for v4, which comes down to reverting a few
commits, is probably simpler - I'd be able to test that too.

- Frank
