Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BB33A1F72
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 23:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhFIV4R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 17:56:17 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:44895 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhFIV4R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 17:56:17 -0400
Received: by mail-io1-f48.google.com with SMTP id q3so1225736iop.11
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jun 2021 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DHOUhoK9DaSv7411lsyUVQ3HvujB/d6Tvp8txpkzBU=;
        b=H0Fzdx7GQpnxCIUChVEHd9js0wb8Ft+LQmqJ/k7FdQcCV3EFDhP0ux6XOyMM1LRFzk
         ap+Np4cVfMV9YOrI3r5RwWrjqIIynTiWz2FkSzgSQXC8afcxFm6YhGmv/jH6lAdAWCrG
         /QAu9yKXGA/0kivYJY/Cbfz97Qi/J9tTf//WLGubBgv1rIvzsMg3v/gqg403ldoKy7sS
         GGyQiUe2L8V/n1KBYfVV7STNzofGaf/cLK/TWJeTWfYL7xsVYIBuLqUCKxVSMyjwhslC
         avu9oTPkglIiDhPYXPXrIVr43kBa2DRbmcCu07wigUxRsnPhMkaWaW+QqCqq08Ui+0O0
         rt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DHOUhoK9DaSv7411lsyUVQ3HvujB/d6Tvp8txpkzBU=;
        b=PV5KilwwLKxfROzNH0vM4UypUQCid+dm9NyQ/oQjqaHT3W0jyWEEgYZ0N4W/5j4rNH
         aW9XG7J/bgYRgLGL4zCgBl9A3QiOn9sBDjUNnKiGTctBkmCxHL+403eJPL/wKBXa6Kwj
         eOm3PbsI0+Gl2BdRvD8q3dZ9CggvL3mYVBq9T3/zbyuG6SWsOH2BXXZaYowFQ8qzXCre
         VBRssqm2nfKTU6IgsJSN/muIfa/7ihRZqgTJu0vvxDCm95IedEK+8r18U6XUx6q4f+7t
         T79cAKvhk+oAArmnHGpsbkVEAPTxKyqjJNpa424eKEVPWZ+kHz19nyRMg682pX/a8nfT
         rMgg==
X-Gm-Message-State: AOAM533JOaSG8dqu2ZStTD0bGchdz7lBBArWae8ECpv92b7loavTc79R
        jL7T8NMksRNOwDWg3NMKpII3gWo0QFJK2A==
X-Google-Smtp-Source: ABdhPJzwf/oH1qZwAnkPzmUE4h8FigKRQa7J7fLtVh2w1zqKkTIwl0Etvg1ltb3bJdioeXVlkCRKtA==
X-Received: by 2002:a02:9621:: with SMTP id c30mr1466432jai.113.1623275602219;
        Wed, 09 Jun 2021 14:53:22 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id w25sm619743iox.18.2021.06.09.14.53.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:53:21 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/3] don't collapse transports for the trunkable
Date:   Wed,  9 Jun 2021 17:53:16 -0400
Message-Id: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This patch series attempts to allow for new mounts that are to the
same server (ie nfsv4.1+ session trunkable servers) but different
network addresses to use connections associated with those mounts
but still use the same client structure.

A new mount options, "max_connect", controls how many extra transports
can be added to an existing client, with maximum of 128 transports in
total for either nconnect transports (which are multiple connections
but to the same IP) or transports that are going to different network
addresses.

Olga Kornievskaia (3):
  SUNRPC query xprt switch for number of active transports
  NFSv4 introduce max_connect mount options
  NFSv4.1+ add trunking when server trunking detected

 fs/nfs/client.c             |  1 +
 fs/nfs/fs_context.c         |  8 +++++++
 fs/nfs/internal.h           |  2 ++
 fs/nfs/nfs4client.c         | 43 +++++++++++++++++++++++++++++++++++--
 fs/nfs/super.c              |  2 ++
 include/linux/nfs_fs_sb.h   |  1 +
 include/linux/sunrpc/clnt.h |  2 ++
 net/sunrpc/clnt.c           | 13 +++++++++++
 8 files changed, 70 insertions(+), 2 deletions(-)

-- 
2.27.0

