Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81246F44F
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 20:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhLIT5M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 14:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhLIT5M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 14:57:12 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C27C061746
        for <linux-nfs@vger.kernel.org>; Thu,  9 Dec 2021 11:53:38 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id d14so4037459ila.1
        for <linux-nfs@vger.kernel.org>; Thu, 09 Dec 2021 11:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0EBZbmoiFte/zbkRN1Hn9jfWyFGMv2O/ESwYrqibjk=;
        b=ah7d0RR5/hyd2r11ux89rlVmxJixT0NIA2YCjcQwpYvu3HVv7dZ4r6KtjKY7eRNDKk
         snJWqbM+aReRvbIIVsTAUJRUMrcnq8oEKhitNvb93/a0sbW3ZVQ31+UxFjwRsfSaDtQ7
         X/OHPCRMnyrp345bQ3HJx5IiQAg7W9/HZxY3I8AMuPRIdri4soJ61wh3GYbrVgagmr1o
         ahoIW0BBsv2PsHT9xHDCRfBfxFP5GiC8IvFHm2e+58RITbPCzNqXv1+2T/98vUkAMiwT
         EaquGa2UOjpjZdAUBT6CrVeyoROHHE06HJ8teGsoRQe3oRmGRhL5t6xU/PotZmdEkNb+
         DYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0EBZbmoiFte/zbkRN1Hn9jfWyFGMv2O/ESwYrqibjk=;
        b=RmOKUtFtJWoyEBeqEA9mQ/u70PO8N2N1FIZaSebXVUAJr/vwEYa3MzC31JjXPWliN7
         iKaec0DsR/T7WFiPBMVytmknS9wolBcdJf0buVkQxECXvPpM9OYXb9WGHpjfIBTByWYE
         Kyejj3NzL2etCQGCUiz3JGvKYi65xRq2lEmadNrh8CZdV88Lxn+UbomSz93qe4mJkH6C
         RRHLflr7X6uYH4hJPVBHW2cDBYeljnyWf3RH8KXFn4FMGjDUqBPSppRF1JoDQCsMYMb+
         FaVu1N8PnPnFEmEEd4JLM6deQpZNQnzKJV/Nnq9/aH76ILmD+9Q8ejKftGA4FVTJ7Mjm
         /Y8A==
X-Gm-Message-State: AOAM533fv7yy1Gaoqsoo8CtG8yoIJGUZnuwJvYQSwCbuqu5QFPD8KLFP
        C8tRhwWgiLaXdmWKKhWQQdA=
X-Google-Smtp-Source: ABdhPJxVlvqwqGgam0ttxRqfXwNXlu7PCcIImRRTEmNU9AkTbCJhQqm9l4HNXNYYnsrSTC4hMzhrww==
X-Received: by 2002:a05:6e02:1c46:: with SMTP id d6mr19317310ilg.213.1639079618152;
        Thu, 09 Dec 2021 11:53:38 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:554d:272f:69a0:1745])
        by smtp.gmail.com with ESMTPSA id k9sm383541ilv.61.2021.12.09.11.53.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:53:37 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/7] NFSv4.1+ support for session trunking discovery
Date:   Thu,  9 Dec 2021 14:53:28 -0500
Message-Id: <20211209195335.32404-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This patch series adds session trunking discovery and setup. When a
client discovers a new file system in addition to probing for
existing attributes, it also sends a GETATTR asking for an fs_location
attribute. If it receives a non-zero length reply, it will iterate
thru the response and, for each server location, it will establish a
connection (of the same type as the existing RPC transport), send
an EXCHANGE_ID, and test for session trunking. If the trunking test
succeeds, the transport is added to an existing set of transports
for this server. 

Olga Kornievskaia (7):
  NFSv4 remove zero number of fs_locations entries error check
  NFSv4 store server support for fs_location attribute
  NFSv4.1 query for fs_location attr on a new file system
  NFSv4 expose nfs_parse_server_name function
  NFSv4 handle port presence in fs_location server string
  SUNRPC allow for unspecified transport time in rpc_clnt_add_xprt
  NFSv4.1 test and add 4.1 trunking transport

 fs/nfs/client.c           |   7 ++
 fs/nfs/nfs4_fs.h          |  12 ++--
 fs/nfs/nfs4namespace.c    |  19 ++++--
 fs/nfs/nfs4proc.c         | 131 +++++++++++++++++++++++++++++++++++---
 fs/nfs/nfs4state.c        |   6 +-
 fs/nfs/nfs4xdr.c          |   2 -
 include/linux/nfs_fs_sb.h |   2 +-
 include/linux/nfs_xdr.h   |   1 +
 net/sunrpc/clnt.c         |   5 +-
 9 files changed, 158 insertions(+), 27 deletions(-)

-- 
2.27.0

