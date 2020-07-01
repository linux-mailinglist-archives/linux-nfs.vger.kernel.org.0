Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB52112AC
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbgGAS2L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:28:11 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:38523 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732857AbgGAS2L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:28:11 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSq-0007Wt-7n
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 13:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Je1kiQ3GnC79BI2+pS4uCo5979omWXR49AznfOXdH+k=; b=IIjAZlwP9sxgMfgBFewup35J1o
        yRrnSXh2OoOCNuMpoDqeoiLE0FJsVeJjk4yVydpUnwpT6aaOdu5Yd+e2xDbx4tpJl4uOOMmAkoDUj
        wa2Wq67ggR/t2wLj10E3wrIxl2xXlsdkFDl3GzVH6wWbbb5CZQbqOjshV0gazITm/t5Pg8uODCElv
        wk3Rl15Px2EELAI+cv/5mLMc7DlMIcl4XMXhP6SXdQ9GTNfesywBBb7sG1l/f8YmIi7F+Zanx0M7Z
        hJ0RMHiib1/XNg5Bmz7pEWD4Dlvw9PQK7Su7iW6ndkhNGUf9IMK3wvGSLYN05lBvnvpjrbmd0Cs1N
        3q3IJn/Q==;
Received: from [174.119.114.224] (port=43594 helo=wraith.dragoninc.ca)
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhSp-0003Oc-WA
        for linux-nfs@vger.kernel.org; Wed, 01 Jul 2020 14:28:08 -0400
From:   Doug Nazar <nazard@nazar.ca>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/10] Misc fixes & cleanups for nfs-utils
Date:   Wed,  1 Jul 2020 14:27:51 -0400
Message-Id: <20200701182803.14947-1-nazard@nazar.ca>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00182504244358)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVbEcEI7dFVb/N
 ELaBYD+hfkTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDoHt0IcOGwKCbMuu8Bh1PoO2W
 aaJF459Au8f7ARCz5dLSCZQ2Nr47RM+YSfrmzrVldMWAh8MxKGaVAWoKvmEDzHXpGCeulZALlD2V
 AvpAcEdNy48VCLWq/B04EaMIT1z9KJ9I7HJckiqd4uUgfyUDbi0mNlctu/ZLaOH13A3s9cVWgxmT
 epC+rmMtfXSN6UccbEYBdMHLz8fdZytxBPvQ/tfm/6ZhrBvMHqGRRS2yqrTz7IssKbNSm6Aylrz7
 vRRedYGRJ5j/qgI5gfjNk3Q1FcO1wjmeb9RCa+YI49T4kOuq00YljRCkN7s2SRETCBXfmpMlsQfU
 CJBMRaGGGXrzQwzEEJbreAQRsbSZZ9fXoUEifL76GD10kuo3nOZaoX+gsjENmEszkjZCjfYHwrdv
 NOzx52pqgFKULzmTh7lC+C1OB0fQQI8VICRbS6zGNgmk2+y1r/Jt2+QI0NYgZu+YDGDmnroh/8hH
 WR/Etfk4HCQTo4dLz8XEDoyijq2CEGKcGplHcpVCCoX989hgB8R+yHz6Wz8d/Pp/n7kUT3MNKWyV
 mI6ol8ojWV/XK6LQktrhK60vFF1FrACvJg00U50W739nMre3YEbkuALmW8gN9RXH3DI0NOgo6/Ab
 vYB8YDlEEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd4Lp6/mezP3/ta7RoBl7TSj8Cd1
 02D1/PxWBdanhqFXVGIDtlyyGhtxMdqa3CaFDS3LSvNePujb1BQrolcpWgVnZjEa/sNl+vcoDGoY
 k0DAXQsuA+ZOE6ZCLBhP3Kw7GhP6DxWSEoQUnaVSVuR240Ewmn4rjkt/ing/Kst6lT+FgU1vUJm2
 lwcjBA1nf30dydyo/g58MkufxisELuuE3bZK19QhM8um7L9VndMW7hyljAQWfxYdU0gXE07BZ9Ya
 Ke+gc5LamkkGaPkiMxmyjA0L/Ub/yrYgxwwQmd72Iri+RjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Most of this work centers around gssd, however a few items I did tree
wide. It's been compile tested with both gcc & clang on x86_64 & arm32
and runtime tested on x86_64.


Doug Nazar (10):
  gssd: Refcount struct clnt_info to protect multithread usage
  Update to libevent 2.x apis.
  gssd: Cleanup on exit to support valgrind.
  gssd: gssd_k5_err_msg() returns a strdup'd msg. Use free() to release.
  gssd: Fix locking for machine principal list
  gssd: Add a few debug statements to help track client_info lifetimes.
  gssd: Lookup local hostname when srchost is '*'
  gssd: We never use the nocache param of gssd_check_if_cc_exists()
  Cleanup printf format attribute handling and fix format strings
  Fix various clang warnings.

 aclocal/libevent.m4                |   6 +-
 configure.ac                       |   6 +-
 support/include/compiler.h         |  14 +
 support/include/xcommon.h          |  12 +-
 support/include/xlog.h             |  20 +-
 support/nfs/xcommon.c              |   2 +
 support/nfsidmap/gums.c            |   2 +
 support/nfsidmap/libnfsidmap.c     |   8 +-
 support/nfsidmap/nfsidmap.h        |  10 +-
 support/nfsidmap/nfsidmap_common.c |   1 +
 support/nfsidmap/nss.c             |   4 +-
 support/nfsidmap/regex.c           |   6 +-
 support/nfsidmap/static.c          |   1 +
 support/nfsidmap/umich_ldap.c      |  10 +-
 tools/locktest/testlk.c            |   6 +-
 utils/exportfs/exportfs.c          |   5 +-
 utils/gssd/err_util.h              |   4 +-
 utils/gssd/gss_names.c             |   9 +-
 utils/gssd/gss_util.c              |   2 +-
 utils/gssd/gssd.c                  | 165 ++++++++---
 utils/gssd/gssd.h                  |  10 +-
 utils/gssd/gssd_proc.c             |  14 +-
 utils/gssd/krb5_util.c             | 422 +++++++++++++++++------------
 utils/gssd/krb5_util.h             |  16 +-
 utils/gssd/svcgssd.c               |   4 +-
 utils/gssd/svcgssd_proc.c          |   9 +-
 utils/idmapd/idmapd.c              |  65 +++--
 utils/mount/network.c              |   4 +-
 utils/mount/stropts.c              |   2 -
 utils/mountd/cache.c               |   2 +-
 utils/nfsdcld/cld-internal.h       |   2 +-
 utils/nfsdcld/nfsdcld.c            |  29 +-
 utils/nfsdcld/sqlite.c             |   1 -
 utils/nfsdcltrack/sqlite.c         |   2 +-
 utils/nfsidmap/nfsidmap.c          |   3 +-
 35 files changed, 536 insertions(+), 342 deletions(-)
 create mode 100644 support/include/compiler.h

-- 
2.26.2

