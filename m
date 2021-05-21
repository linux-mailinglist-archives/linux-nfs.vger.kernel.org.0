Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63638CDFD
	for <lists+linux-nfs@lfdr.de>; Fri, 21 May 2021 21:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhEUTLK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 May 2021 15:11:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29628 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234847AbhEUTLJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 May 2021 15:11:09 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LJ6SFB021438;
        Fri, 21 May 2021 19:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=cwVWN+qazcUe68jTydskrBWJnTJakpkgwy5tu48WA94=;
 b=tmMo154dJpzS3ERzRbXP3DninJdkMq11/+1VOP66/O1IzrVk5L4OWxE1d05oszPPwAKx
 u5n0bOnJJVwsmHjU4gRyW+MGF2VkVmbtfwp9QKah+58V1ZtmbZZ/f0UNasOCIsWAMxzL
 x+ksUpVeKZKVwHmD6y1/RZ1RGTqudDyBdHT26ELSHHUYQKCpGBc4Tz39nyQYXhfa27i9
 g88P7DZF2YUOXZw8V0xE+Dg4aJp2cVnAOS/5wI49EPgJD54Hp/f4Md5TDSKWUI3NExOC
 U+CKkxVEodzqtdKFPcy9RNZbqtYIMxS8FqYYr2Emcm1BTnrNxP+mSNXJTuvKyDXdEgJp dQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n4uks18w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 19:09:42 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14LJ9f7Y162290;
        Fri, 21 May 2021 19:09:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38n4931ykd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 19:09:41 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14LJ9fEx162279;
        Fri, 21 May 2021 19:09:41 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 38n4931yjw-1;
        Fri, 21 May 2021 19:09:41 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        chuck.lever@oracle.com
Subject: [PATCH v7 0/2] NFSD: delay unmount source's export after inter-server copy completed.
Date:   Fri, 21 May 2021 15:09:36 -0400
Message-Id: <20210521190938.24820-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: l9phdKvm3GqxNxTMTDGwW2XgTuPf372N
X-Proofpoint-ORIG-GUID: l9phdKvm3GqxNxTMTDGwW2XgTuPf372N
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
    rebase to 5.13-rc2
v7: simplify nfsd4_interssc_connect by moving changes into
          functions.



