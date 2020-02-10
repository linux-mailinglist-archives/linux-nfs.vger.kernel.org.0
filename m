Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDBE15835B
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgBJTQG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:16:06 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35397 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgBJTQG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:16:06 -0500
Received: by mail-yw1-f67.google.com with SMTP id i190so3953266ywc.2
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUrbzVVPw2PlYbq6OFl5j4vhxCcf3oVP9BeBFQDIHLs=;
        b=BIIn33ePbWNlFjNi8hVcs6cR8/OGEx6sZudp2A1D73MfP8tVWGBpk1iVxDpTTIEddd
         /3cLrblPBXIkiklPIjf+RQOzlG0HFwj72Ed7rVAi81uKPlr4GzrswKOzOR1ZDf3o5+MT
         ZzSOKArJjdaR0N6wpG55dUq4hRYE2SGSIZAUpVSxUgC6lrp5dvFv6mbF6wa5Gw9M3UAt
         LrECL+DkcF/va0sJY4RibPQykA/qT8LMpRQxs7eWjbVkM7eC5/41EM3P5N73GckIT79A
         h4rfIGYWpqAzqVBtGvwNpN7fmi6RqkXYXSZeYCsr+hNA0dn4gocglAd61tX/Ws3D03/U
         Ez5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUrbzVVPw2PlYbq6OFl5j4vhxCcf3oVP9BeBFQDIHLs=;
        b=FoBRvVSui/PiquQObun3Ud2og3tlAb7K7qxOOK5WRmnBntT6dtl8HG5M1BQohun6KF
         OCVkqD8dOiF0rMPQp9GYafcAf1IBzdupVU2V10cabeVaqgWt4/oOn46Ghi2En8UagOXh
         ou1Jt1PSb1YIvq5bBIYvPvCeF+keo2j9CbBPfQpoICgwoH7prXlvr1KZlycCFSaFQ6D1
         OMlxWOvgGKkK1peiYbOH5nA3caH5VlpwsnyDmbYvUPVQgSP6IeBzfo7GZaz08TmZU/A2
         tjbnO9+a5tqhBxKBs7GDNJlJB/wb+fls7xan/IvgCihFr9aWayn66kc1XrdfrwBtqF87
         g9jg==
X-Gm-Message-State: APjAAAVd2FYM3rcReZOrolUXX/cooC2dPrKqafTUg7b7RCq8Y095vLoO
        Y+rdIKrITFYpSURGY8VumvhqiICxcQ==
X-Google-Smtp-Source: APXvYqwYwslFRIVaVo2elbmS0h9qd6f/uiJAg4AJYbQtiRrZpEGMA0KuxDtUlUuVvqNDqn6dr3pkyg==
X-Received: by 2002:a0d:e84d:: with SMTP id r74mr2365498ywe.147.1581362164840;
        Mon, 10 Feb 2020 11:16:04 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id o4sm660222ywd.5.2020.02.10.11.16.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:16:04 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/8] Reduce the refcount pressure of NFS on struct cred
Date:   Mon, 10 Feb 2020 14:13:37 -0500
Message-Id: <20200210191345.557460-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFS and RPC layer currently always takes a reference to the
credential passed by the user, even in the case where the RPC call
is synchronous, or the cred is also being pinned by file pointers
and open contexts.
In addition, the access cache will take a reference for each cache entry
on each file that we've looked up.

This patch set attempts to reduce the amount of references that the NFS
layer holds, by optimising away a few cases where we're taking the
refcount unnecessarily. It also sets a more stringent limit on the
number of access cache entries that the NFS layer holds.

Trond Myklebust (8):
  NFS: alloc_nfs_open_context() must use the file cred when available
  SUNRPC: Add a flag to avoid reference counts on credentials
  SUNRPC: Don't take a reference to the cred on synchronous tasks
  NFS: Assume cred is pinned by open context in I/O requests
  NFSv4: Avoid referencing the cred unnecessarily during NFSv4 I/O
  NFSv4: Avoid unnecessary credential references in layoutget
  NFS: Avoid referencing the cred twice in async rename/unlink
  NFS: Limit the size of the access cache by default

 fs/nfs/dir.c                 |  2 +-
 fs/nfs/inode.c               | 10 +++++-----
 fs/nfs/nfs4proc.c            | 12 ++++++------
 fs/nfs/pagelist.c            |  2 +-
 fs/nfs/pnfs.c                |  3 +--
 fs/nfs/unlink.c              |  4 ++--
 fs/nfs/write.c               |  2 +-
 include/linux/sunrpc/sched.h |  1 +
 net/sunrpc/clnt.c            |  8 ++++++--
 net/sunrpc/sched.c           |  3 ++-
 10 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.24.1

