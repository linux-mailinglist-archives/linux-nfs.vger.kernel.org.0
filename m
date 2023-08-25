Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABCA788D1C
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 18:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245225AbjHYQTk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 12:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343913AbjHYQTj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 12:19:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76481991;
        Fri, 25 Aug 2023 09:19:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDNud0008395;
        Fri, 25 Aug 2023 16:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=k+lGEfjvDQNbeDqoygZ6A/jyTybdDlL3h9HOWYjdVdE=;
 b=YLYYbIuJKxUFP+xN9x5cefDAIQxN1GBfIAST3sCjaoWClRciCvyOC52U0WDRVKpg/iUw
 uV/NKwVACUeNQIuh/6u0jBJOEk3AuCVHacMI+6rb/YsWzFyE5Y+LMZRzA3nZo5qt2Fzv
 mrxC0y+liftj4nmFj/kjocQ3A86tAHHkVS4Ny4ZPLVDxPZtxOiW2qhAnVO7bFcQdhdc4
 np2XfXud+XfEQP9cMoJja8kXZZDcCIdtUsks65h1/HMOJE/1Eou1Y3dbO6D2hcpifdm1
 X/C/nDjOIxEcFzM0Fn/CQW3w+EsMbof8XRnu7P236TQz45f+v2QCg+vqB2YiOuFHtku8 VA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yv6teg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 16:19:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PFgHMt006024;
        Fri, 25 Aug 2023 16:19:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yusfa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 16:19:23 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37PGJ4WQ004997;
        Fri, 25 Aug 2023 16:19:22 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sn1yusex6-3;
        Fri, 25 Aug 2023 16:19:22 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     brauner@kernel.org, chuck.lever@oracle.com, bfields@fieldses.org,
        stable@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, hch@lst.de, jlayton@kernel.org,
        vegard.nossum@oracle.com, naresh.kamboju@linaro.org,
        Sherry Yang <sherry.yang@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 2/2] nfsd: use vfs setgid helper
Date:   Fri, 25 Aug 2023 09:19:01 -0700
Message-ID: <20230825161901.371818-3-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825161901.371818-1-harshit.m.mogalapalli@oracle.com>
References: <20230825161901.371818-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_14,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=994 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250146
X-Proofpoint-GUID: 2bT3q9eice8IdOAQNogUkxPSoFIutdDc
X-Proofpoint-ORIG-GUID: 2bT3q9eice8IdOAQNogUkxPSoFIutdDc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

commit 2d8ae8c417db284f598dffb178cc01e7db0f1821 upstream.

We've aligned setgid behavior over multiple kernel releases. The details
can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
Consistent setgid stripping behavior is now encapsulated in the
setattr_should_drop_sgid() helper which is used by all filesystems that
strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
raised in e.g., chown_common() and is subject to the
setattr_should_drop_sgid() check to determine whether the setgid bit can
be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
will cause notify_change() to strip it even if the caller had the
necessary privileges to retain it. Ensure that nfsd only raises
ATR_KILL_SGID if the caller lacks the necessary privileges to retain the
setgid bit.

Without this patch the setgid stripping tests in LTP will fail:

> As you can see, the problem is S_ISGID (0002000) was dropped on a
> non-group-executable file while chown was invoked by super-user, while

[...]

> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700

[...]

> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700

With this patch all tests pass.

Reported-by: Sherry Yang <sherry.yang@oracle.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[Harshit: backport to 5.15.y:
Use init_user_ns instead of nop_mnt_idmap as we don't have
commit abf08576afe3 ("fs: port vfs_*() helpers to struct mnt_idmap")]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/nfsd/vfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d4adc599737d..15a86876e3d9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -322,7 +322,9 @@ nfsd_sanitize_attrs(struct inode *inode, struct iattr *iap)
 				iap->ia_mode &= ~S_ISGID;
 		} else {
 			/* set ATTR_KILL_* bits and let VFS handle it */
-			iap->ia_valid |= (ATTR_KILL_SUID | ATTR_KILL_SGID);
+			iap->ia_valid |= ATTR_KILL_SUID;
+			iap->ia_valid |=
+				setattr_should_drop_sgid(&init_user_ns, inode);
 		}
 	}
 }
-- 
2.34.1

