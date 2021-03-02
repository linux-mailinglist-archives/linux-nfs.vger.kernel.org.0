Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E2332A93F
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443547AbhCBSSP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:18:15 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:13191 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243024AbhCBDpK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Mar 2021 22:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614656753; x=1646192753;
  h=date:from:to:subject:message-id:mime-version;
  bh=h7FdbR/XINx+jRNsTGstOKAfTQIAJ5P/wwbwJhKYUKQ=;
  b=CKkBgYTQkaKDXtyKOOLijocUAvbAwfE0R47WTXoOkZlCMYQXvP93NmJi
   BNLFaJAzM4Wz24yZr7Mrd2UzuNSpzHgZz/L04BphJ3yYWREZoiq3WvBAT
   wxy1DRy3L1qRw5BPofEOmgWxnzOvUb51RNQDY/k9qfb81S+jaoQRCsKBc
   I=;
X-IronPort-AV: E=Sophos;i="5.81,216,1610409600"; 
   d="scan'208";a="89962955"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 02 Mar 2021 03:45:12 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id CCD86A1F8F
        for <linux-nfs@vger.kernel.org>; Tue,  2 Mar 2021 03:45:11 +0000 (UTC)
Received: from EX13D06UEA003.ant.amazon.com (10.43.61.20) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Mar 2021 03:45:10 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D06UEA003.ant.amazon.com (10.43.61.20) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Mar 2021 03:45:10 +0000
Received: from dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com
 (10.200.231.78) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 2 Mar 2021 03:45:10 +0000
Received: by dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com (Postfix, from userid 5408343)
        id E1C0E56B; Tue,  2 Mar 2021 03:45:10 +0000 (UTC)
Date:   Tue, 2 Mar 2021 03:45:10 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     <linux-nfs@vger.kernel.org>
Subject: Access cache and lookupcache=pos
Message-ID: <20210302034510.GA61130@dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

some of our customers run applications that require the lookupcache=pos
mount option. One example of such an application is Gitlab [1]. Recently we
profiled a Gitlab workload and noticed that 38% of compound operations and
27% of EFS server time were spent on an ACCESS compound (SEQUENCE, PUTFH,
ACCESS, GETATTR) that we weren't sure is necessary.

To reproduce:

1. Mount an NFS file system with -o lookupcache=pos.
2. $ mkdir /mnt/a
3. $ for i in `seq 1 10`; do ls /mnt/a/nonex.txt; done

There are two compounds that are emitted for every iteration in step 3:

1. SEQUENCE, PUTFH, ACCESS, GETATTR
2. SEQUENCE, PUTFH, LOOKUP, GETFH, GETATTR

In the first compound, ACCESS has FH=</mnt/a> and access=0x1f. The result is
NFS4_OK with supported=0x1f and access=1f. In the second compound, LOOKUP
has FH=</mnt/a> and objname="nonex.txt". The result is NFS4ERR_NOENT.

If I understand lookupcache=pos correctly, it causes the result of LOOKUP
not to be cached because of the ENOENT, which is what's happening. Is there
a reason that the succesful ACCESS is not cached in the parent directory's
access_cache? Caching it would reduce the runtime of this application by
about 27% which would be a nice speedup.

[1] https://docs.gitlab.com/ee/administration/nfs.html
