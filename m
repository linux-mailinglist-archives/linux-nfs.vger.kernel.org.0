Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8297D27D072
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Sep 2020 16:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgI2ODo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Sep 2020 10:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgI2ODl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Sep 2020 10:03:41 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A07C061755
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:03:40 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id v8so4893124iom.6
        for <linux-nfs@vger.kernel.org>; Tue, 29 Sep 2020 07:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pq6n0tNRmfKsH6AxS0q8F3zZTztUq9fbQ60d/U+pHAU=;
        b=ITGy9svH/mLAZNhTnepuYHHIJqq0a+oP7pQf5km7qcYKLka3IrlkVd4Gc3JgmPqB/a
         3KoG/GrjKVyGEGVhvvc9yLm4kDkBwzPZJk25hXp/t8M9+hec8uyt5i5MBveZyaMJVc9X
         jKnO0KP1MCooqMsQ0ljgXkj036RtX3b8hSTOCZrDQ/97V7tGJvG4JLReYt2RDM6O7w9m
         SgV5szGc2hfqQjLb/c3RqKTYOk27/aladZgapRShBUVEkJq9TNGdOi/wF6Zlyhqxz/lG
         yayjspZzDr4313Kh1eEaltDbfq4ccGigz2F1oR2zg2WaYKAuyOuK+816C69eDBQ1CgCM
         YMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pq6n0tNRmfKsH6AxS0q8F3zZTztUq9fbQ60d/U+pHAU=;
        b=W9e659HepMhQFKh5sFsW0Jos02eVst3b4pQv8dLGlY+wSNzHkJctn/mJl+LVDFtOj8
         FMb2+GQUAzzX4p7LZZfguqglZ1/O/+4wOCcbSJydbyP9YPSuG2R+HhTHcDLEKMGtNl0w
         TmcpN3Y0DMEyi6IB3m18skeDtSUmPgJjUy/ndf+k6ly1+wmnbf0YaKvhJwuv5hvDIC3+
         N7/pvkQplKZ8a7qNvK7Z0HQKbEXm0qZt4OE2iwvwY6V5QqwX3ls7FiWg9U17vgBQc3cT
         hA0sRfJlSF+i93aYNpD9r+C0j4hxneLk/fXSvXrdxyQ7OCUwIJT/hdKXoGzmMOFM/ITJ
         On7A==
X-Gm-Message-State: AOAM532MZC5yqpTAsfbL0v26yF0H/bMeTFt0hkX082LikEgJlIyIMrWI
        ymhDQh5RNa0fyg0+0DPEJxCMXDLtrmETrg==
X-Google-Smtp-Source: ABdhPJwuTp9myhs9kZD0reIAEmuKCVj5x5BSiF63tau+SFFbcDCYmjIS7jvmMDcb0sGo62okDp0BTw==
X-Received: by 2002:a5e:8d04:: with SMTP id m4mr2490803ioj.107.1601388219589;
        Tue, 29 Sep 2020 07:03:39 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o23sm2464173ili.62.2020.09.29.07.03.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:03:38 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08TE3afA026412;
        Tue, 29 Sep 2020 14:03:36 GMT
Subject: [PATCH v2 00/11] nfsd_dispatch() clean up
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 29 Sep 2020 10:03:36 -0400
Message-ID: <160138785101.2558.11821923574884893011.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

I've tested the latest version of your rq_lease_breaker patch plus
my nfsd_dispatch() clean ups and haven't found any new issues.

Changes since v1:
- Pulled in latest version of rq_lease_breaker cleanup
- Added patches to make NFSv2 error encoding similar to NFSv3
- Clarified nfsd_dispatch's new documenting comment
- Renamed a variable

---

Chuck Lever (10):
      lockd: Replace PROC() macro with open code
      NFSACL: Replace PROC() macro with open code
      NFSD: Encoder and decoder functions are always present
      NFSD: Clean up switch statement in nfsd_dispatch()
      NFSD: Clean up stale comments in nfsd_dispatch()
      NFSD: Clean up nfsd_dispatch() variables
      NFSD: Refactor nfsd_dispatch() error paths
      NFSD: Set *statp in success path
      NFSD: Fix .pc_release method for NFSv2
      NFSD: Call NFSv2 encoders on error returns

J. Bruce Fields (1):
      nfsd: rq_lease_breaker cleanup


 fs/lockd/svc4proc.c         | 242 +++++++++++++++++++++++++++--------
 fs/lockd/svcproc.c          | 244 ++++++++++++++++++++++++++++--------
 fs/nfsd/nfs2acl.c           |  87 +++++++++----
 fs/nfsd/nfs3acl.c           |  50 +++++---
 fs/nfsd/nfs3proc.c          |   1 +
 fs/nfsd/nfs3xdr.c           |   6 +
 fs/nfsd/nfs4proc.c          |   1 +
 fs/nfsd/nfs4xdr.c           |   6 +
 fs/nfsd/nfsproc.c           | 173 ++++++++++++-------------
 fs/nfsd/nfssvc.c            | 109 ++++++++--------
 fs/nfsd/nfsxdr.c            |  37 +++++-
 fs/nfsd/xdr.h               |  11 +-
 fs/nfsd/xdr3.h              |   1 +
 fs/nfsd/xdr4.h              |   1 +
 include/uapi/linux/nfsacl.h |   2 +
 15 files changed, 691 insertions(+), 280 deletions(-)

--
Chuck Lever

