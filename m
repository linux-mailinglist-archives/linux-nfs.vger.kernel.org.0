Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188B6D29D2
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbfJJMqZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:46:25 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:38863 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733051AbfJJMqZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:46:25 -0400
Received: by mail-io1-f44.google.com with SMTP id u8so13324564iom.5
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oz/EZxT6rob45IyEm8j8kJGCnq3nH/sp+hzOKJePxzA=;
        b=JSMHmZzm8RzPwUD6K7VYVX+yNpoFfP7PwJxPxSSUS+WWXykjxd6GqolrHQNRaUB8y9
         Tq/6yrlNQZK2wNnuy/sHNa0gAno3UoCeuMSvknEMh9G8YhNoZjZVfwFGNo4RIZk2ymrq
         5BCAMPKAp39p/N8RhnLrCgcMTDlS3KCXZTl+gTp9XZZ8Bx9Vr9A0sc0jSNVa8E8TVACj
         4U8/0pt6nX1dViTWA7FRQybqKgwHz3wTzq5D19J+0JivwfiJgzq5tXonkAmpAb2HWlK7
         kpUxTjkaQRJNzs59q2TuJ9ZH2gg3A2ijJ+zdpmJjqTiRtd4dRyki77RxuEt1a8yZbG43
         eqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oz/EZxT6rob45IyEm8j8kJGCnq3nH/sp+hzOKJePxzA=;
        b=ZatUBEmXyH+ybDx2BQgonyWqq+6AbBCjAZhRGDLoZMZhwx7LiT56u8NAPfrme8vBYs
         4gJR7o5/CBz4On1ONq+K0VVer3itVxMS4txTzfFVztiGuS6lB9xBf5BHQpj6H6in6Edj
         ppfyJ8JNxydji3Xk8G67gwtUY1ZpKUhlxAzF+/xXXuFT22pzzhShgKNQjOR+D5NwVZE1
         G98kHydU6OQmCTLkEkZQWDzQ46zdiAKuAiQ65UjaxE9RzuPIoBkFp2aUvRXVhhfRL/bz
         4YepSngEoqNTpEYlRYCHv+7pZsccYOIaXuK6X7G49OKhJookZm4r8o8jmrpBFcNEDJ6I
         v/hA==
X-Gm-Message-State: APjAAAUXX+6Uy58gdcyT2l2DECjvmnkHSpzc+NHm8KxVsW6Y844RqWN0
        O0Laeye6jHgPuU+jzhRwn3c=
X-Google-Smtp-Source: APXvYqzU1jVJQ/qQ7e5NH6YLhVlsLYPJ6pgfqQBy+7RVsK/CVvnUFiBbgCVp/TBvVKwFPf+qk+2SVw==
X-Received: by 2002:a5d:9052:: with SMTP id v18mr1160190ioq.13.1570711584621;
        Thu, 10 Oct 2019 05:46:24 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.46.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:46:23 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 00/20] client and server support for "inter" SSC copy
Date:   Thu, 10 Oct 2019 08:46:02 -0400
Message-Id: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-- forgot to cc linux-nfs

--client patches
-- no code changes but I want to note that in my previous client-server
submission (as oppose to the last just client side submission), i have 
forgotten to include one of the patches. this submission corrects that
and is the same submission from client-only submission from July8th.
That patch is: "NFS based on file size issue sync copy or fallback to
generic copy offload"

-- server patches
-- removed the check for copy_notify state on clientid destruction
-- removed the code with unused arg to nfsd4_verify_copy()
-- changed the check_if_stalefh_allowed as per Bruce suggestion to
no return status and set op->status if 2nd putfh is missing in the
compound

patch series is available from git branch "linux-ssc-for-5-5" (forced
update):
git://linux-nfs.org/projects/aglo/linux.git

Olga Kornievskaia (20):
  NFS NFSD: defining nl4_servers structure needed by both
  NFS: add COPY_NOTIFY operation
  NFS: add ca_source_server<> to COPY
  NFS: inter ssc open
  NFS: skip recovery of copy open on dest server
  NFS: for "inter" copy treat ESTALE as ENOTSUPP
  NFS: COPY handle ERR_OFFLOAD_DENIED
  NFS: also send OFFLOAD_CANCEL to source server
  NFS handle NFS4ERR_PARTNER_NO_AUTH error
  NFS: handle source server reboot
  NFS based on file size issue sync copy or fallback to generic copy
    offload
  NFS: replace cross device check in copy_file_range
  NFSD fill-in netloc4 structure
  NFSD add ca_source_server<> to COPY
  NFSD COPY_NOTIFY xdr
  NFSD add COPY_NOTIFY operation
  NFSD check stateids against copy stateids
  NFSD generalize nfsd4_compound_state flag names
  NFSD: allow inter server COPY to have a STALE source server fh
  NFSD add nfs4 inter ssc to nfsd4_copy

 fs/nfs/nfs42.h            |  15 +-
 fs/nfs/nfs42proc.c        | 199 +++++++++++++++++----
 fs/nfs/nfs42xdr.c         | 190 +++++++++++++++++++-
 fs/nfs/nfs4_fs.h          |  11 ++
 fs/nfs/nfs4client.c       |   2 +-
 fs/nfs/nfs4file.c         | 139 ++++++++++++++-
 fs/nfs/nfs4proc.c         |   7 +-
 fs/nfs/nfs4state.c        |  40 ++++-
 fs/nfs/nfs4xdr.c          |   1 +
 fs/nfsd/Kconfig           |  10 ++
 fs/nfsd/nfs4proc.c        | 438 ++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4state.c       | 192 +++++++++++++++++---
 fs/nfsd/nfs4xdr.c         | 155 +++++++++++++++-
 fs/nfsd/nfsd.h            |  32 ++++
 fs/nfsd/nfsfh.h           |   5 +-
 fs/nfsd/nfssvc.c          |   6 +
 fs/nfsd/state.h           |  34 +++-
 fs/nfsd/xdr4.h            |  39 ++++-
 include/linux/nfs4.h      |  25 +++
 include/linux/nfs_fs.h    |   4 +-
 include/linux/nfs_fs_sb.h |   1 +
 include/linux/nfs_xdr.h   |  17 ++
 22 files changed, 1441 insertions(+), 121 deletions(-)

-- 
1.8.3.1

