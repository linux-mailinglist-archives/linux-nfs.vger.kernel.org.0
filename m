Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99411405DE3
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 22:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhIIUOp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 16:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhIIUOj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 16:14:39 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83416C061574
        for <linux-nfs@vger.kernel.org>; Thu,  9 Sep 2021 13:13:29 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f22so3257025qkm.5
        for <linux-nfs@vger.kernel.org>; Thu, 09 Sep 2021 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=efHqcsBL4sVa1msFfnOS4VOaY+qJ1iXd+E0q0Mpvubw=;
        b=IpJkEtN8pkJLYhqykVyRDIGc7k55VvhUgvy5Syu4uaPTUG9KHyCpcFDyYx+GZs+Ux1
         k4HqCwud6nNEWhwL3LffhNXjqaZBMoijQuSWDT57hXw62zFLYN6wBF4zEjfEI+/hjrNC
         nUuuqRic/uo+cti073xkE002GtCdBCu+3QnK3vrQMDhKur/klYoR/NpWSsmZ3lNvmHBj
         XTq+3P+KgiAGpPteMdn8bzalGinGBawgnqKNLufxSTKwICVMRAv16FaKvFwV6Sb0NAI1
         zMZ/H1AOHf+3sTacwKqNwhX4xsFKkxiGqnZxViFrt55K4RbTaOEqNe3XbIP/BG/9J9r2
         hegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=efHqcsBL4sVa1msFfnOS4VOaY+qJ1iXd+E0q0Mpvubw=;
        b=sQ3jN3C6TMxpZWDeJMKvVQI6uFU/nIXRHoKJghHnSMR/powaioICUXOfEu859mG16p
         TYQmJQ2iIO14Usnr6P8nbwwoqKjsi8PAb88KRfWFGVUE+QxyLPoqXYDmt/GFev62VZ0j
         7rqwsD03/7PHN0tD56tWDgyzrmU+A6HSJwlJbXl6JA+tI+OFCNc1ggZ5N70IxGsjQ4/f
         ACtZO5b9mK6arqIwYxBi4WP7XIyWUa9bB6a+kpmujF0adi4Vq/BEp9+kG83/FunxRyol
         arkdJAEZhq5usQXhFzmSG/q8ly0wAU5CWdI5moJS+TXN62QLEKmsf7XbZVqAmUMkOhFm
         qEHw==
X-Gm-Message-State: AOAM530n1xfJ7waHfe8ieqYtreSJ0K7F4UaEDwAe+8+SZWTjLnaIA6b6
        vpKIPqEX7an4JePiHrpw4bP3Eu1g+Hs=
X-Google-Smtp-Source: ABdhPJy/l1qdVQao/A5JVjSxKvKa0Ni+flpVlz5uzRZAMMGvV2qAIUw6aFP3nAIeK9E+13iJ5GPXLg==
X-Received: by 2002:a37:f716:: with SMTP id q22mr4605628qkj.510.1631218408444;
        Thu, 09 Sep 2021 13:13:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id l13sm2104020qkp.97.2021.09.09.13.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:13:28 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 00/14] Clean up nfs4_label allocation
Date:   Thu,  9 Sep 2021 16:13:13 -0400
Message-Id: <20210909201327.108759-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

In the functions where we want a label we also tend to allocate a
struct fattr, which happens to have a field for labels that goes unused
in most cases. Let's just allocate the label at the same time as the
fattr if we know we'll want one. This lets us pass fattrs around by
themselves, and also remove the struct nfs4_label argument from
functions like nfs3_proc_getattr().

Thoughts?
Anna

Anna Schumaker (14):
  NFS: Create a new nfs_alloc_fattr_with_label() function
  NFS: Remove the nfs4_label from the nfs_entry struct
  NFS: Remove the nfs4_label from the nfs4_create_res struct
  NFS: Remove the nfs4_label from the nfs4_link_res struct
  NFS: Remove the label from the nfs4_lookup_res struct
  NFS: Remove the nfs4_label from the nfs4_lookupp_res struct
  NFS: Remove the f_label from the nfs4_opendata and nfs_openres
  NFS: Remove the nfs4_label from the nfs4_getattr_res
  NFS: Remove the nfs4_label from the nfs_setattrres
  NFS: Remove the nfs4_label argument from nfs_instantiate()
  NFS: Remove the nfs4_label argument from nfs_add_or_obtain()
  NFS: Remove the nfs4_label argument from nfs_fhget()
  NFS: Remove the nfs4_label argument from nfs_setsecurity
  NFS: Remove the nfs4_label argument from decode_getattr_*() functions

 fs/nfs/client.c         |   2 +-
 fs/nfs/dir.c            |  66 ++++++----------
 fs/nfs/export.c         |  44 +++--------
 fs/nfs/getroot.c        |  21 ++---
 fs/nfs/inode.c          |  59 +++++++-------
 fs/nfs/internal.h       |   9 ---
 fs/nfs/namespace.c      |   3 +-
 fs/nfs/nfs3proc.c       |  10 +--
 fs/nfs/nfs4_fs.h        |   4 +-
 fs/nfs/nfs4file.c       |   5 +-
 fs/nfs/nfs4proc.c       | 165 +++++++++++++---------------------------
 fs/nfs/nfs4xdr.c        |  43 +++++------
 fs/nfs/proc.c           |  14 ++--
 include/linux/nfs_fs.h  |  23 ++++--
 include/linux/nfs_xdr.h |  16 +---
 15 files changed, 180 insertions(+), 304 deletions(-)

-- 
2.33.0

