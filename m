Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C87F1961D4
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 00:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC0X1V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 19:27:21 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:12188 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgC0X1V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 19:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585351640; x=1616887640;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=r79HtRwjmlXKWRRlfbCVnqNyKeM8soF7T5baOX5aW4w=;
  b=V3twmtpDCpdZIvPlTYVbnKhBEYAooTeZ9uAJG28QXzxzrK3kNItkYst8
   lh+kNQjPFF2Hjs6j/A7MvxtNwDDzxDPw1TmrRfSWOEiJiKN7Xol0p1uFj
   I2H5E44vU0h3jwfJFbWfLOuqq+uTMYxcqPsHWC99bdMZIyBE4nc61sIlK
   w=;
IronPort-SDR: tLO0y1qmqiHdlB12kwTxZYiRFi12/V/UO3DeagHPlYSB+RIqxg04xB4sjweZJkyLic8saB88gE
 f7m3XIa/PGtA==
X-IronPort-AV: E=Sophos;i="5.72,314,1580774400"; 
   d="scan'208";a="33900227"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Mar 2020 23:27:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id DE60CA2612;
        Fri, 27 Mar 2020 23:27:18 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Mar 2020 23:27:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Mar 2020 23:27:18 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 27 Mar 2020 23:27:17 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 2D577D92A4; Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 00/11] NFS server user xattr support (RFC8276)
Date:   Fri, 27 Mar 2020 23:27:06 +0000
Message-ID: <20200327232717.15331-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

v1 is here: https://www.spinics.net/lists/linux-nfs/msg76740.html

v2:

* Moved the xattr changes upfront, and Cc-ed them to the appropriate
  recipients.
* Added doxygen comments to the new exported functions (xattr)
* Squashed a number of patches together to avoid unused function
  warnings.
* Renamed nfs4_vbuf_from_stream to nfs4_vbuf_from_vector

 fs/nfsd/nfs4proc.c        | 140 +++++++++-
 fs/nfsd/nfs4xdr.c         | 535 +++++++++++++++++++++++++++++++++++---
 fs/nfsd/nfsd.h            |   5 +-
 fs/nfsd/vfs.c             | 142 ++++++++++
 fs/nfsd/vfs.h             |  10 +
 fs/nfsd/xdr4.h            |  31 +++
 fs/xattr.c                | 111 +++++++-
 include/linux/nfs4.h      |  22 +-
 include/linux/xattr.h     |   4 +
 include/uapi/linux/nfs4.h |   3 +
 10 files changed, 961 insertions(+), 42 deletions(-)

-- 
2.17.2

