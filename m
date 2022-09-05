Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61B5ACA85
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Sep 2022 08:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiIEGXO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Sep 2022 02:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiIEGXG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Sep 2022 02:23:06 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A403055D;
        Sun,  4 Sep 2022 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662358973; i=@fujitsu.com;
        bh=eedFYo6xGyTr6apElA9LfkQQDI6fKYFV5f6rr++cXJQ=;
        h=Message-ID:Date:MIME-Version:From:Subject:References:To:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=G8qnhG56xEyRlNBAddOObquQPySeh1yp88Y4LMPpoilHQ6M2oCJcuWyLZRmglyq8k
         GWxra4Zu04fPm6G5lUtvuSLJfYOKw8ZijBDBmaRPQRoZupsRYRxagtCioEflKrO3Vg
         eolVRi0BHVZsPh1sSlE2r+/ci1AX253nrPefcagt+/4du5azA+7/sicVRHBPPfpABq
         oXDcTzk6knFWoTSdR2Os00c2kphOCTuPDt+X7J7n9p2srEfI4qfsxXA2nMe6JUTWOK
         3UrQ+g6MaD8Zw06dOOu/ifPPHdyb0o4SMEFdtNLwN2H5xUN4uDHckWK29Ie4JqCLbV
         wK+YbiQefAfhg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRWlGSWpSXmKPExsViZ8MxSXfvVNF
  kgz8LJS1Ot+xlt7hw4DSrA5PH501yAYxRrJl5SfkVCawZM/7eYix4x1Xx4MF7tgbGNZxdjFwc
  QgJbGCVaJ35jg3CWM0msXfeVHcLZyigx/dhk1i5GTg5eATuJD1MPgNksAioSO972MEPEBSVOz
  nzCAmKLCiRL9JxoZgex2QRcJM5NuARWIyzgLvFt3hGgDRxAQ/kk5r/JAwmLCFhJbDnaCzaSU4
  Bf4vP1rWCtzAIWEovfHISy5SW2v50DNkZCQFHiz71DjBB2hUTj9ENMELaaxNVzm5gnMArOQnL
  RLCSjZiEZtYCReRWjTVJRZnpGSW5iZo6uoYGBrqGhKZA21DU01Uus0k3USy3VzcsvKsnQNdRL
  LC/WSy0u1iuuzE3OSdHLSy3ZxAgM9JTiVP4djDf2/dI7xCjJwaQkyutZLZosxJeUn1KZkVicE
  V9UmpNafIhRhoNDSYJXeQpQTrAoNT21Ii0zBxh1MGkJDh4lEd5ykDRvcUFibnFmOkTqFKMux8
  c/F/cyC7Hk5eelSonzOoIUCYAUZZTmwY2AJYBLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR
  5kycDTeHJzCuB2/QK6AgmoCPs+oRBjihJREhJNTCxC7448Cyu7pihruO6Z7K8O4PCN3kcWbdw
  mjfXzl/tnS90Fz+Y/+5iecjKtMVm791lhX+27p2s3LJhs3rWhA+L3dO3/0piTIwtvpqw+4Knc
  95ZRg/DnefXu6ZJ9Ca/XtO4t+ztzC/iTKXd9cICrtUbnjHPjn63yET59p9mWf6cZ75lk+4Xit
  1x4Q7VOPdfaFFlcJfwAqdwPq+6CpNUx52hU49U724TmO/e8vaC0uJHNfOfc9UW2bo0f1Y59vZ
  3yJZSH91lU7fdctrx22jGvIvuh69Zvq/7rPdhnSlPm6Bcb5Yb/4lJ/rIvsk6ybdu88uG7vptX
  q5xNOS2iOi2YLerrPkiKephJ/1vrWnnAf58SS3FGoqEWc1FxIgAAo6qsewMAAA==
X-Env-Sender: cuiyue-fnst@fujitsu.com
X-Msg-Ref: server-7.tower-728.messagelabs.com!1662358973!98737!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8787 invoked from network); 5 Sep 2022 06:22:53 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-7.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Sep 2022 06:22:53 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id CBD6E1000C1;
        Mon,  5 Sep 2022 07:22:52 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id BE062100078;
        Mon,  5 Sep 2022 07:22:52 +0100 (BST)
Received: from [10.167.225.61] (10.167.225.61) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 5 Sep 2022 07:22:51 +0100
Message-ID: <2a35a5a9-945a-e8ac-67e3-2fb312e41a46@fujitsu.com>
Date:   Mon, 5 Sep 2022 14:22:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
From:   =?UTF-8?B?Q3VpLCBZdWUv5bSUIOaCpg==?= <cuiyue-fnst@fujitsu.com>
Subject: [PATCH] generic: Ignore getcap and setcap cases when it is NFS
References: <>
To:     <fstests@vger.kernel.org>, <linux-nfs@vger.kernel.org>
In-Reply-To: <>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.225.61]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Signed-off-by: Cui Yue <cuiyue-fnst@fujitsu.com>
---
  tests/generic/513 | 2 ++
  tests/generic/675 | 2 ++
  tests/generic/688 | 2 ++
  3 files changed, 6 insertions(+)

diff --git a/tests/generic/513 b/tests/generic/513
index dc08278..d7201f5 100755
--- a/tests/generic/513
+++ b/tests/generic/513
@@ -19,6 +19,8 @@ _require_scratch_reflink
  _require_command "$GETCAP_PROG" getcap
  _require_command "$SETCAP_PROG" setcap
  +test $FSTYP == "nfs"  && _notrun "NFS can't support getcap and setcap"
+
  _scratch_mkfs >>$seqres.full 2>&1
  _scratch_mount
  diff --git a/tests/generic/675 b/tests/generic/675
index 189251f..0e9fd36 100755
--- a/tests/generic/675
+++ b/tests/generic/675
@@ -22,6 +22,8 @@ _require_command "$GETCAP_PROG" getcap
  _require_command "$SETCAP_PROG" setcap
  _require_scratch_reflink
  +test $FSTYP == "nfs"  && _notrun "NFS can't support getcap and setcap"
+
  _scratch_mkfs >> $seqres.full
  _scratch_mount
  _require_congruent_file_oplen $SCRATCH_MNT 1048576
diff --git a/tests/generic/688 b/tests/generic/688
index 426286b..54b9e3c 100755
--- a/tests/generic/688
+++ b/tests/generic/688
@@ -30,6 +30,8 @@ _require_xfs_io_command falloc
  _require_test
  _require_congruent_file_oplen $TEST_DIR 65536
  +test $FSTYP == "nfs"  && _notrun "NFS can't support getcap and setcap"
+
  junk_dir=$TEST_DIR/$seq
  junk_file=$junk_dir/a
  mkdir -p $junk_dir/
-- 
1.8.3.1

