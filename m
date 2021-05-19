Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7429738982E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 22:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhESUpv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 16:45:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33678 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhESUpu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 May 2021 16:45:50 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JKfAX2005125;
        Wed, 19 May 2021 20:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=ajnwiA6MbOl9sQ6VjWAKpt+KmL7izO4+XcmEYHvSUmk=;
 b=U9hYXiFAVLoWGj0kxZ2H8SWbD/qz/W8ko2Ec9dqnp3PlXUasLQAN0bV8upHLMAU+l3Iv
 A7CLmlSxRz4bycFb3G/B+PfyT1zE8ReqtSwUkLkrEw2yrvt/tKyR1I+m+P/6mtgL9CLU
 QCmhuKKzmKba4haQSIv81/X4TtgswrAJZYptExCqosGUA03NV8zM0/NUgGYJqsdgdYgE
 Wl4pEsWm16THxx2pCQZgidOpsjZKRqkzFEls5lQlwCIyXe56xEfG860CnSkt4YM/LNeZ
 g9RuRpKy46QiIHaMD9h5iIkIVMXrAJ/dPL4N0Wt6YaoqwFjsTK7dhDVHqnbw4FuobTZV xg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n4ukr54k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 20:44:27 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14JKiQrR050470;
        Wed, 19 May 2021 20:44:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38meegdf5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 20:44:26 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14JKiPM4050452;
        Wed, 19 May 2021 20:44:25 GMT
Received: from userp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3030.oracle.com with ESMTP id 38meegdf5s-1;
        Wed, 19 May 2021 20:44:25 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        chuck.lever@oracle.com
Subject: [PATCH v6 0/2] NFSD: delay unmount source's export after inter-server copy completed.
Date:   Wed, 19 May 2021 16:44:19 -0400
Message-Id: <20210519204421.22869-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aAcBDjT0snkK4Gcarr3fLMDKPE5UZ4qa
X-Proofpoint-ORIG-GUID: aAcBDjT0snkK4Gcarr3fLMDKPE5UZ4qa
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga, Bruce,

Currently the source's export is mounted and unmounted on every
inter-server copy operation. This causes unnecessary overhead
for each copy.

This patch series is an enhancement to allow the export to remain
mounted for a configurable period (default to 15 minutes). If the 
export is not being used for the configured time it will be unmounted
by a delayed task. If it's used again then its expiration time is
extended for another period.

Since mount and unmount are no longer done on every copy request,
the restriction of copy size (14*rsize), in __nfs4_copy_file_range,
is removed.

-Dai

v2: fix compiler warning of missing prototype.
v3: remove the used of semaphore.
    eliminated all RPC calls for subsequence mount by allowing
       all exports from one server to share one vfsmount.
    make inter-server threshold a module configuration parameter.
v4: convert nsui_refcnt to use refcount_t.
    add note about 20secs wait in nfsd4_interssc_connect.
    removed (14*rsize) restriction from __nfs4_copy_file_range.
v5: make use of the laundomat thread to service delayed unmount list.
    destroy delayed unmount list when nfsd is shutdown.
    make delayed unmount list per nfsd_net to support container.
v6: move content of nfsd4_ssc_umount in to nfsd_net.
    move code that manages the delayed unmount list
         from nfsd/nfs4proc.c to nfsd/nfs4state.c
    cleanup left over from previous versions.


