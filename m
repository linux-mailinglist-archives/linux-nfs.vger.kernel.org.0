Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A20397885
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jun 2021 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFAQ5U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Jun 2021 12:57:20 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:31859 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhFAQ5U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Jun 2021 12:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1622566539; x=1654102539;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=DHCntmXNQlloxzepoZVyEjDxQR1bIWSej9YQK2bRYlg=;
  b=Q9fmZob4c3XdtU4PN/2B8JTemL1dvirDrsIRMv+OiAVpOfHc+duwhu5o
   d3IJMHN2Cekq59VOwIMeaQUdk3mREZkJjzYmPpddcmVVDzhOjYAqUm2lq
   GjLzziCNZ4a2nv7enFPcfvy1qjEd/4ucd2AleCTaAFOfVCpnSvE0exrsW
   I=;
X-IronPort-AV: E=Sophos;i="5.83,240,1616457600"; 
   d="scan'208";a="117312908"
Subject: Re: nfsd dead loop when xfstests generic/531
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-e69428c4.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 01 Jun 2021 16:55:38 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-e69428c4.us-east-1.amazon.com (Postfix) with ESMTPS id 9C992CA578;
        Tue,  1 Jun 2021 16:55:37 +0000 (UTC)
Received: from EX13D02UWC004.ant.amazon.com (10.43.162.236) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 1 Jun 2021 16:55:37 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D02UWC004.ant.amazon.com (10.43.162.236) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Tue, 1 Jun 2021 16:55:36 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.18 via Frontend Transport; Tue, 1 Jun 2021 16:55:36 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 782AD79; Tue,  1 Jun 2021 16:55:35 +0000 (UTC)
Date:   Tue, 1 Jun 2021 16:55:35 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
CC:     <linux-nfs@vger.kernel.org>
Message-ID: <20210601165535.GA3102@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <20210531125948.2D37.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210531125948.2D37.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, May 31, 2021 at 12:59:51PM +0800, Wang Yugui wrote:
> 
> 
> Hi,
> 
> nfsd dead loop when xfstests generic/531
> 
> linux kernel of nfs server: 5.10.41
> linux kernel of nfs client: 5.10.41
> 
> 
> nfsd dead loop when xfstests generic/531
> 
> linux kernel of nfs server: 5.10.41
> linux kernel of nfs client: 5.10.41

This is a known issue. generic/531 opens a large number of files, causing
the nfsd file cache code to walk a very long LRU list of open files. For
v4, there will be a lot of long term opens (because of the OPEN call),
and they all end up on that list.

So, the basic issue is, that the nfsd file cache is a good match for
v3 semantics, but less so for v4 semantics.

I posted an experimental patch to work around the issue:

https://lore.kernel.org/linux-nfs/20201020183718.14618-4-trondmy@kernel.org/T/#m869aa427f125afee2af9a89d569c6b98e12e516f

The rhashtable patch has issues, so disregard that one, but the other one
is a basic fix for this issue. It has one other issue that I noticed (refcount
error), but that is easily fixed.

I should update the patch and formally post it..

- Frank
