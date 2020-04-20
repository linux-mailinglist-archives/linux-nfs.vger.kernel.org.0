Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5ECD1AFFC1
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 04:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDTCRl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 22:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTCRl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 22:17:41 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F5CC061A0C
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2020 19:17:39 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w24so7286688qts.11
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2020 19:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tAAVQRgSHg/fwpS0DmY/JvdkERUfdb4Sm0K5lL3bD4E=;
        b=WtMMzDFuB5MmmEwRyn5behyX11P4/53M167chvsnJm155FIkAWadn3+AFImweA+0YB
         thsXvNHtXgrZeStjz0vbHJwhVyPKeUk2E18ndDsY0NznFKxD3c9dTJS+m+++Jq5LzAZh
         31rjJC5qM8+LNJ+ph7XEc4utOVsLzPKL9r6p67nwHAOTDkCJRZB+Bpi3j9P/qPanrEEC
         GKLjh0k3BLscO/QN+5os0ONHPmnUbmZQo+RxO9/NInBRGAYvyAMVtTU6pOoBZBMJ6tVV
         +WF2ABFjKkLhYbIOgXeekKjXoYIEyYyoWsEaStzytUc68EzH7yK9PGfhrqpz2uVtT6W6
         1YxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tAAVQRgSHg/fwpS0DmY/JvdkERUfdb4Sm0K5lL3bD4E=;
        b=C5C8RY6jUrHXfzZcWu2Qkj+/peNsGrJz1LntCg4lHW3aSbFe02/mrj3tAZBx62Bp4W
         LmCtwPYtYOAzfAZVC1fr9/ClxOO9MlcL6JdrwqD9gcJai3V3XBVo4ehhqAm6fz1COtok
         mE7f581bjpB+oPIqkJB3GU1acxv4VKD4zoP9O/46s4qS9gJk4nBunjXpfcy4BDyZ8ZyR
         h+JVBucDeY/6cX6fB+UHsOXrr0OWNoUfuPIOk+otXAat2BnUTRnyFfFcOYZgEZO7YEsB
         j4WyonFGZtYfnAUgNL830TigMeualj3S1B3/LO6bdP6K/DOh2wPli3Jbi7uG7JvvWxZ3
         uV/Q==
X-Gm-Message-State: AGi0PuZVbuY5n4AGbR4rwX9X3+9pqLPZcLOIax+VBcigf1EW0cURPhTV
        XpbkRrXtDWrGz40+d6FpczCdS8kJ
X-Google-Smtp-Source: APiQypLBG/Hu8dwSsUjKctlew4IZhcsNoiYRaq2g9I0Tr5fA0fXHSLoyc0j/sV9sBx4YoTyWUJzrbA==
X-Received: by 2002:aed:33a4:: with SMTP id v33mr13453631qtd.289.1587349057619;
        Sun, 19 Apr 2020 19:17:37 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y17sm18213474qky.33.2020.04.19.19.17.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 19:17:37 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03K2HZar016998
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 02:17:35 GMT
Subject: [PATCH v1 0/3] Potential krb5p fix for 5.7-rc
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 19 Apr 2020 22:17:35 -0400
Message-ID: <20200420000639.3416.43270.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-8-g198f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For review:

The purpose of this series is to get the Linux NFS server's
duplicate reply cache working again when the server is mounted via
krb5p. Thus I would like to send these three commits via an
nfsd-5.7-rc pull request in a couple of weeks, depending on review
comments.

The second patch is strictly a client-side fix, but it is necessary
because the third patch causes problems on the client unless the
first and second patches are applied first. Being a client-side
change, the second patch needs an Acked-by from Trond or Anna so I
can send a PR via the NFSD tree.

I've tested this series by running "make -j12 test" in a freshly-
built git source tree on an NFS mount. The test was run on a
sequence of mounts using every combination of:

- TCP and RDMA
- NFSv3, NFSv4.0, NFSv4.1, and NFSv4.1
- krb5p with a kerberos_v1 and kerberos_v2 encryption type

For RDMA in particular, frequent GSS sequence number window overruns
make the transport connection unstable -- typically over 3,000
disconnects for a test run that takes about 30 minutes. A
successful test run on an NFSv3 or NFSv4.0 mount point is therefore
enough to demonstrate that the server's DRC is working properly.

NFSv4.1+ is also tested to show that krb5p continues to work
correctly for NFS minor versions that do not happen to use the
server's DRC.

---

Chuck Lever (3):
      SUNRPC: Add "@len" parameter to gss_unwrap()
      SUNRPC: Fix GSS privacy computation of auth->au_ralign
      SUNRPC: Revert 241b1f419f0e ("SUNRPC: Remove xdr_buf_trim()")


 include/linux/sunrpc/gss_api.h      |  1 +
 include/linux/sunrpc/xdr.h          |  1 +
 net/sunrpc/auth_gss/auth_gss.c      |  8 +++-----
 net/sunrpc/auth_gss/gss_krb5_wrap.c | 26 +++++++++++++++--------
 net/sunrpc/auth_gss/svcauth_gss.c   |  2 +-
 net/sunrpc/xdr.c                    | 41 +++++++++++++++++++++++++++++++++++++
 6 files changed, 65 insertions(+), 14 deletions(-)

--
Chuck Lever
