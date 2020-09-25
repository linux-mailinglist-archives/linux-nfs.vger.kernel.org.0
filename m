Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E492278F39
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Sep 2020 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgIYQ74 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Sep 2020 12:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgIYQ74 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Sep 2020 12:59:56 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD19C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 09:59:56 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z13so3509519iom.8
        for <linux-nfs@vger.kernel.org>; Fri, 25 Sep 2020 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YAyeEeYUN54Xro9IMOcmSGXspdRJdj/2abOnh7lbmF0=;
        b=i3ueF/6mwbGK7xkXyPYReUx3cIjUbz9Sc+ff8gLdsnR6rsW+lHR38ZRuZ6mVDjMdD7
         SGJi55MyRISk9azd6kMEefayTk4Ys5UZ60GyoTiDOkE8veDArKG3t7YV47yM4ojkKg8v
         6S7bgB8rrIFI6r8fRx4HXvNQ39HKhMFwkJ+BR4MnbZh+2snktSDkYhtI6K8GtaZyk9vm
         h0XMzA/PvGWCx4/cyoR5/aQNGMkNykPzoQbkNX/RzTQjfEmMmxChetyRp97Eosap8GQZ
         +XqP2ugQ9Ayf5PhbhNwB0Zb9udCjpgdzPr5ZBW4xMuC6ptCdFyVWHL+LmVTAIFDpSMcJ
         YzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YAyeEeYUN54Xro9IMOcmSGXspdRJdj/2abOnh7lbmF0=;
        b=kT2/dsuIZVI1JLrSaoDylFXhQWYDJ9dSo+JipnYwwE/mcaZ2DMNGir4CI0mns1ToHc
         YP9AZEleet1YjEmmmof6Z1RQBr4wyFgk7CIShAWT9R1ruhRHtsr9zXcvKaW25i7IW3a7
         eN/STHugJxUmBdUco0ZLjzE6xVLX+MulS/jjq6+KlR+uFmh6Uw6w+eW5mukt8b4cN+1s
         4rWiMlZ83U0MqWq1FWWOvmUwVZRZlKurqqsZ3YYyg6W0/1aMOdE6WGnltYNkSIYwBPJN
         TEWoTr+9t7PeE6MSdks/N0Mfqc4S7NJzPPPdLCA9RqbwTSWNgGSVaDNvpDFgxIBOL2y/
         f3lQ==
X-Gm-Message-State: AOAM533bivYHFth4rB35+QRA6SgRpYBEFwCI6yx+sA5/JMoYDMPRQZdN
        AGCxRXRtmns922AkrBdnIWKnq8uzzrEmlw==
X-Google-Smtp-Source: ABdhPJzg5gS5iLzEWqqkylUviTmiFrG9GXp4oG+no4QANuVzbLFoWJMeKYfVHhQPnsGZ+rCuZhwsEQ==
X-Received: by 2002:a5e:9911:: with SMTP id t17mr973586ioj.58.1601053195594;
        Fri, 25 Sep 2020 09:59:55 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 2sm1373122iow.4.2020.09.25.09.59.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 09:59:54 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08PGxqH7014508;
        Fri, 25 Sep 2020 16:59:52 GMT
Subject: [PATCH 0/9] nfsd_dispatch() clean up
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 25 Sep 2020 12:59:52 -0400
Message-ID: <160105295313.19706.13224584458290743895.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce, these don't seem too controversial, and could be merged
in v5.10 if you agree they are ready.

---

Chuck Lever (8):
      lockd: Replace PROC() macro with open code
      NFSACL: Replace PROC() macro with open code
      NFSD: Encoder and decoder functions are always present
      NFSD: Clean up switch statement in nfsd_dispatch()
      NFSD: Clean up stale comments in nfsd_dispatch()
      NFSD: Clean up nfsd_dispatch() variables
      NFSD: Refactor nfsd_dispatch() error paths
      NFSD: Set *statp in success path

J. Bruce Fields (1):
      nfsd: rq_lease_breaker cleanup


 fs/lockd/svc4proc.c         | 242 +++++++++++++++++++++++++++--------
 fs/lockd/svcproc.c          | 244 ++++++++++++++++++++++++++++--------
 fs/nfsd/nfs2acl.c           |  78 ++++++++----
 fs/nfsd/nfs3acl.c           |  50 +++++---
 fs/nfsd/nfs3proc.c          |   1 +
 fs/nfsd/nfs3xdr.c           |   6 +
 fs/nfsd/nfs4proc.c          |   1 +
 fs/nfsd/nfs4xdr.c           |   6 +
 fs/nfsd/nfssvc.c            | 105 +++++++++-------
 fs/nfsd/xdr3.h              |   1 +
 fs/nfsd/xdr4.h              |   1 +
 include/uapi/linux/nfsacl.h |   2 +
 12 files changed, 548 insertions(+), 189 deletions(-)

--
Chuck Lever

