Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9419A345462
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 02:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhCWBB3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 21:01:29 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:12449 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhCWBBA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 21:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1616461260; x=1647997260;
  h=date:from:to:subject:message-id:mime-version;
  bh=4Ivdx/d+hB+n3G6dvXqqW4p2PsE6/U7qnL5uBk0w9kg=;
  b=soOto8lrMhmvr6t+h4+j5m7zgp22ZSoGaKXOHnNhKoYVe/RDJyHTP/+D
   3D3WBS03aIVBt5hbsKCr4e/3Z1sKOn9FOSKIyQVrwEbxmYEjRLLSm1aUh
   CZqae+de+fWi5rN+IZ9w5TdpegwE8GWI095GxvoGCNaMhYfXQhKnnEx6q
   g=;
X-IronPort-AV: E=Sophos;i="5.81,269,1610409600"; 
   d="scan'208";a="96920125"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 23 Mar 2021 01:00:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id D4C99C02A3
        for <linux-nfs@vger.kernel.org>; Tue, 23 Mar 2021 01:00:58 +0000 (UTC)
Received: from EX13D36UWA002.ant.amazon.com (10.43.160.24) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Mar 2021 01:00:58 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D36UWA002.ant.amazon.com (10.43.160.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Mar 2021 01:00:58 +0000
Received: from dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com
 (10.200.231.78) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Mar 2021 01:00:58 +0000
Received: by dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com (Postfix, from userid 5408343)
        id EBA171F2D; Tue, 23 Mar 2021 01:00:57 +0000 (UTC)
Date:   Tue, 23 Mar 2021 01:00:57 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     <linux-nfs@vger.kernel.org>
Subject: RFC: return d_type for non-plus READDIR
Message-ID: <20210323010057.GA129497@dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

recursively listing a directory tree requires that you know which entries are
directories so that you can recurse into them. The getdents() API can provide
this information through the d_type field.

Today, d_type is available if we use READDIRPLUS. A non-plus READDIR requests
only the "rdattr_error" and "mounted_on_fileid" attributes, but not "type", and
consequently sets d_type to DT_UNKNOWN.

Requesting the "type" attribute for regular, non-plus READDIR would allow us to
always return d_type, even for large directories where we switch to a non-plus
READDIR. It would allow the user to recursively list directories of any size
without the need for GETATTRs, and, if the server supports this, without any
stat() or equivalent calls on the server. For some use cases, you could also
mount with '-o nordirplus' to scan an entire file system efficiently.

Since not all file servers may be able to produce the directory entry type
efficiently, this could be implemented as a mount option that defaults off.

Some local file systems offer a similar choice. For example, both ext4 and xfs
have an (in this case mkfs-time) option to store the inode type in the
directory. If this option is set, then getdents() always returns d_type.

Would a patch that adds such a mount option be acceptable?
