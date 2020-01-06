Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC111131951
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAFU10 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:26 -0500
Received: from mail-yw1-f51.google.com ([209.85.161.51]:33659 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFU10 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:26 -0500
Received: by mail-yw1-f51.google.com with SMTP id 192so22446797ywy.0
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02ASjcBsIlvXZcj+X4z24+E69kQfAFZvA5mQ/tKsyV8=;
        b=YAR9PxbdpIIxFVHFy0RaNzL9lWdN41QZpz/fZiZKq1JxxkHiGCyRiVOpg3wFLIVsmf
         vraq0APDskbfesa8xWSluJoiGCZ1q0v2j11EEWiW8invL5kacmaPNEALv+DseLbZGIRG
         IxFi3IkpWcdn9nePAeXhsVB8pwxunIWcsNH02VDw2Jwj/4w9k+fok/30Z+RIQpbvdUm7
         LuVnI25MZqFG1nANnJtVA+BiXLcLkvYQJ4y+97glzFyyNVn6By20anFL7NNt1LRuEcZW
         rDq0mIhV8v2I5pBnsp4WB2/xsGrRYxtzQLtUMWzEhgi5u6ZfLWUnADFO86Z6A4tbs6pT
         wdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=02ASjcBsIlvXZcj+X4z24+E69kQfAFZvA5mQ/tKsyV8=;
        b=VpAGbCGwJG2SBj4ZfZTV7OGpkx9c8zwkRlo2pLBoS/F6gIyCdUc0DTqbaqsKkzI/0a
         mRIgED2IK8UQrftiz61OhulP7JF0Zbc9QZRJPc0JdcSwLRkurAV7pGNdUR5zJgEyPnO5
         oOOLQHxoQOcU6PrCXZQkbipTda4wLXNI8eBMG3yVco2kzbevoczBsLJEMFTclXGZcXkP
         CsA9cB8TJBpFjlhLtyVLeyCgG/EdwnvkolgRU8gfCus4pTDpyv1FKd9AzInGp/8o7bFg
         mLq0S2w3HnVfToJ8EGXLj1YRvxTmIJ0/BZNtiMUHoclK8UYXzS5ofCyDnOSl83eaeZAv
         ABsQ==
X-Gm-Message-State: APjAAAUIx4TyFoQw7IO1K9gvIGCuANhcKZfhxXxfk5ONjOx9rek9ImZC
        JnT5hGr8fETSssnL6Te/KA==
X-Google-Smtp-Source: APXvYqwiPlRbI04dgkt7nvdymeVv2pldaiirEfgQK1s3JVgYb8Ht4F/uua9TLj/1bvvOHni0DUcMZA==
X-Received: by 2002:a81:1292:: with SMTP id 140mr76589529yws.108.1578342445076;
        Mon, 06 Jan 2020 12:27:25 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:24 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/15] Various writeback related fixes
Date:   Mon,  6 Jan 2020 15:24:59 -0500
Message-Id: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

A combination of writeback fixes for both regular NFS and pNFS.

Trond Myklebust (15):
  NFS: Revalidate the file size on a fatal write error
  NFS: Revalidate the file mapping on all fatal writeback errors
  SUNRPC: Remove broken gss_mech_list_pseudoflavors()
  NFS: Fix up fsync() when the server rebooted
  NFS/pnfs: Fix pnfs_generic_prepare_to_resend_writes()
  NFSv4: Improve read/write/commit tracing
  NFS: Fix fix of show_nfs_errors
  pNFS/flexfiles: Record resend attempts on I/O failure
  NFS: Clean up generic file read tracepoints
  NFS: Clean up generic writeback tracepoints
  NFS: Clean up generic file commit tracepoint
  pNFS/flexfiles: Add tracing for layout errors
  NFS: Improve tracing of permission calls
  NFS: When resending after a short write, reset the reply count to zero
  NFS: Fix nfs_direct_write_reschedule_io()

 fs/nfs/dir.c                           |   4 +-
 fs/nfs/direct.c                        |   7 +-
 fs/nfs/file.c                          |  37 ++--
 fs/nfs/flexfilelayout/flexfilelayout.c |  34 ++--
 fs/nfs/nfs3xdr.c                       |   5 +-
 fs/nfs/nfs4trace.c                     |   4 +
 fs/nfs/nfs4trace.h                     | 202 +++++++++++++++++----
 fs/nfs/nfs4xdr.c                       |   5 +-
 fs/nfs/nfstrace.h                      | 234 +++++++++++++++++--------
 fs/nfs/pnfs.h                          |   8 +-
 fs/nfs/pnfs_nfs.c                      |   7 +-
 fs/nfs/read.c                          |   7 +-
 fs/nfs/write.c                         |  29 ++-
 include/linux/sunrpc/auth.h            |   2 -
 include/linux/sunrpc/gss_api.h         |   3 -
 net/sunrpc/auth.c                      |  49 ------
 net/sunrpc/auth_gss/auth_gss.c         |   1 -
 net/sunrpc/auth_gss/gss_mech_switch.c  |  29 ---
 18 files changed, 415 insertions(+), 252 deletions(-)

-- 
2.24.1

