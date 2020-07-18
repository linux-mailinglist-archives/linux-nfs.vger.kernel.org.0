Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838FB224A32
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgGRJY4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jul 2020 05:24:56 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:38131 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgGRJYx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jul 2020 05:24:53 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5N-0000Qk-5y
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 04:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=z+HPSfxENqjWj6SB7mO0hFOIumOVGRel0ZvpHRyzJow=; b=YaYRvrGnUEVG68rMWKyca+wyzS
        B2XJPAzEjN/XODfLFyQFBBDC4VgaYlTLfmMlNlsdBr/kNjZNthmT3C8kUhYxUWX/xpfHTeK8/v9WR
        YoP/gCF/ga8Ax+D2wICI7Ru2OYHOWJJIXu2i7hYTWNeLc2hTmXqvUEaHJ5+kHnCVAtVZjzgqWofUP
        CCBEDM0DdS5FEBXUhbuv5eBcNxizMNg4JrjSLL8Wzm3osYK567MUR/gKAkJUYPV1HA/bYGE52h7fc
        Wkef1s3I9GfIKrdjyaXVOTLUoVdTaL+RrZj4cOnRdwe0OjUk4lPRWxr9y84TmHOYJ0QZg4wS7ouKK
        PftF0bEw==;
Received: from [174.119.114.224] (port=53842 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwj5M-0001He-UX
        for linux-nfs@vger.kernel.org; Sat, 18 Jul 2020 05:24:49 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/11] nfs-utils: Misc cleanups & fixes
Date:   Sat, 18 Jul 2020 05:24:10 -0400
Message-Id: <20200718092421.31691-1-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00709563563983)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVACkSt9vXYXXN
 AjFnRPdZmETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dJ764GsxMRSn1A6ng/U5hX3Ys0odn9a1rBN2YckUdzhMnXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhUjDYTvPAG4njbxcH1HH0kn9nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVNfl/yowmv/m59rLSnpj2Nzwgz9a4kwkWw7AW7m4bDIuZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Again, here are various cleanups and fixes. Nothing too major, although
a couple valgrind finds.

I've left out the printf patch for now, pending further discussion.

Thanks,
Doug


Doug Nazar (11):
  Add error handling to libevent allocations.
  gssd: Fix cccache buffer size
  gssd: Fix handling of failed allocations
  gssd: srchost should never be *
  xlog: Reorganize xlog_backend() to work around -Wmaybe-uninitialized
  nfsdcld: Add graceful exit handling and resource cleanup
  nfsdcld: Don't copy more data than exists in column
  svcgssd: Convert to using libevent
  nfsidmap: Add support to cleanup resources on exit
  svcgssd: Cleanup global resources on exit
  svcgssd: Wait for nullrpc channel if not available

 support/nfs/xlog.c                  |  41 ++++----
 support/nfsidmap/libnfsidmap.c      |  13 +++
 support/nfsidmap/nfsidmap.h         |   1 +
 support/nfsidmap/nfsidmap_common.c  |  11 ++-
 support/nfsidmap/nfsidmap_private.h |   1 +
 support/nfsidmap/nss.c              |   8 ++
 utils/gssd/Makefile.am              |   2 +-
 utils/gssd/gss_names.c              |   6 +-
 utils/gssd/gss_util.c               |   6 ++
 utils/gssd/gss_util.h               |   1 +
 utils/gssd/gssd.c                   |  37 +++++--
 utils/gssd/krb5_util.c              |  12 +--
 utils/gssd/svcgssd.c                | 143 ++++++++++++++++++++++++++--
 utils/gssd/svcgssd.h                |   3 +-
 utils/gssd/svcgssd_krb5.c           |  21 ++--
 utils/gssd/svcgssd_krb5.h           |   1 +
 utils/gssd/svcgssd_main_loop.c      |  94 ------------------
 utils/gssd/svcgssd_proc.c           |  15 +--
 utils/idmapd/idmapd.c               |  32 +++++++
 utils/nfsdcld/nfsdcld.c             |  50 +++++++++-
 utils/nfsdcld/sqlite.c              |  33 +++++--
 utils/nfsdcld/sqlite.h              |   1 +
 22 files changed, 358 insertions(+), 174 deletions(-)
 delete mode 100644 utils/gssd/svcgssd_main_loop.c

-- 
2.26.2

