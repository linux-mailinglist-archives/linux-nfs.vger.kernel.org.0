Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6831C0CB
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 18:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhBORkw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 12:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhBORkr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Feb 2021 12:40:47 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14627C061574
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:07 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jt13so12595745ejb.0
        for <linux-nfs@vger.kernel.org>; Mon, 15 Feb 2021 09:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Gsh9jQZ/D34raSPy2e4jnznNzwdnFH93ZX9BF6iTvk=;
        b=j170mb13tfhTlU/ynjAVkIUulHsXQn0F7KruVQlDuJcc5xFkTltiJBESu4gx1VD4k2
         907yisBSL0IsYvT7IcLIqNpi+4v5ahwv2F2B2ZIciTFeBHYv0w472QL2ym19ijf7zTR4
         OrfKma5FwLor2b44t1qmMS7EhzmG9P/4eTebT0ZD5OWFW0G2eOEk3uezdMe1K8eFgq9+
         kQH7QY+OSu3yEKl7BqIfFtpYALo+9Ebi1Z0CwMe1weNZGHzfuvO7JpWLoxT46fl7VCwm
         gM5GYE3wZWzeh/4NpKat2YpKYSRbpRCJf+zszi6x0P/fR4nU+bCrV1C61IzcXzfdf90M
         Vong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Gsh9jQZ/D34raSPy2e4jnznNzwdnFH93ZX9BF6iTvk=;
        b=nb10w0WrldHq+xgiG4PiUnYIWE5E0hMcv7a3Hl96MhthWy5DK6O2Xr5/oNcBTmMdji
         ruirN38x4kB9xLjWQHQSauano4aC9P3v4LeBEqKmLmIeh3AZGlA2RtoyBoKqe1Bc9EbV
         NomsmpXDsg62LKg//5dPhvxjaN/97+3XfBhYmF4vRRJdAFj7bDNbuagatEIf2lu3df4C
         sn2G3H+qXX+jQWhBqkpo3JHMta2u0RtWYdpqrVUkop8NcJaxa+OKKEKveDEd8Z/k+wow
         6BkJsv81lmiWN7oDdbXHQj7F87DnmWXkfvBFLxEZzWO8xFef8ri8qGrJa3friYskwy5c
         hHvA==
X-Gm-Message-State: AOAM533lpCEW6jW+ifnmcf8M15BFcVqjIQlwMCMWpitwt1plVNwU6UVi
        esb4mzDuXZbz7g7nkEuI9j8HiBQbhg5pKQ==
X-Google-Smtp-Source: ABdhPJxqlnZrP6iq1TtuTCUgCM5ctfUkOlN5ce6nYsvh0feuZx36SXyuQbtZZDGeUhobSmCFGjQ2Cg==
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr16938852ejd.374.1613410805348;
        Mon, 15 Feb 2021 09:40:05 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id e11sm11257485ejz.94.2021.02.15.09.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:40:04 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH v1 0/8] sysfs files for multipath transport control
Date:   Mon, 15 Feb 2021 19:39:54 +0200
Message-Id: <20210215174002.2376333-1-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna,

This patchset builds ontop v2 of your 'sysfs files for changing IP' changeset.

- The patchset adds two more sysfs objects, for one for transport and another
  for multipath.
- Also, `net` renamed to `client`, and `client` now has symlink to its principal
  transport. A client also has a symlink to its `multipath` object.
- The transport interface lets you change `dstaddr` of individual transports,
  when `nconnect` is used (or if it wasn't used and these were added with the
  new interface).
- The interface to add a transport is using a single string written to 'add',
  for example:

       echo 'dstaddr 192.168.40.8 kind rdma' \
               > /sys/kernel/sunrpc/client/0/multipath/add

These changes are independent of the method used to obtain a sunrpc ID for a
mountpoint. For that I've sent a concept patch showing an fspick-based
implementation: https://marc.info/?l=linux-nfs&m=161332454821849&w=4

Thanks

Dan Aloni (8):
  sunrpc: rename 'net' to 'client'
  sunrpc: add xprt id
  sunrpc: add a directory per sunrpc xprt
  sunrpc: have client directory a symlink to the root transport
  sunrpc: add IDs to multipath
  sunrpc: add multipath directory and symlink from client
  sunrpc: change rpc_clnt_add_xprt() to rpc_add_xprt()
  sunrpc: introduce an 'add' node to 'multipath' sysfs directory

 fs/nfs/pnfs_nfs.c                    |  12 +-
 include/linux/sunrpc/clnt.h          |  12 +-
 include/linux/sunrpc/xprt.h          |   3 +
 include/linux/sunrpc/xprtmultipath.h |   6 +
 net/sunrpc/clnt.c                    |  39 +--
 net/sunrpc/sunrpc_syms.c             |   2 +
 net/sunrpc/sysfs.c                   | 403 +++++++++++++++++++++++----
 net/sunrpc/sysfs.h                   |  21 +-
 net/sunrpc/xprt.c                    |  29 ++
 net/sunrpc/xprtmultipath.c           |  37 +++
 10 files changed, 487 insertions(+), 77 deletions(-)

-- 
2.26.2

