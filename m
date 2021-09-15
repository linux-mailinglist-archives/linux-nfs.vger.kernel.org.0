Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE440CEE3
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Sep 2021 23:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhIOVe0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Sep 2021 17:34:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19114 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232127AbhIOVeZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Sep 2021 17:34:25 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FJxVUi011520
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 21:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=kfR6AokimmN9t0DVDbNd2UM+0jhecUFZ5tIHBKvasYc=;
 b=DE/dszWBWzv8xDbMG1LSDA7BI7RoPUv0kzc+W5WT6lNabrR1rIgl/yd3i0UcRtgGlGha
 /ZTbnCfB/c2sX1laDqQqLjY1Ry/xmp1qYOPK9Jo9UJMSM92/3jEJ/W/HFgflF5hiXyHw
 n3PBP/yt9T8mSrlcalCzcsIcOdT1+zduh2kbInvSW/CruhhqqCJzOnMeBGxUgRjpkpvR
 UJJZZNh9e5Pm5JN9NqH+e5lJ/sw6DbEi9Mh4inrEeqmxPe64U/peFVsbKf/k77RqS4Ro
 I5o7icU6mIr96+xoSr2txL7EkncQdot9syW4nCPKz/LT9bsHMNZBNcfWnCv4VsxZD08K kQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=kfR6AokimmN9t0DVDbNd2UM+0jhecUFZ5tIHBKvasYc=;
 b=m+/yiooYVjRdzte//VsCy+ia3OsFSng7oLWTtyy/njt+9zk0Q7PHikH95EbFwH+pJk9C
 cjWG08l/Khq03CtLWj8tMwkJvIusakpE4Kguk5KLcGO2SslMem+6RL8MOBmpeh/m8QAS
 TbqL6dlZnbDTxB9CdONm/MsLRKBHcwAShDx6Xo5xEwwXGSs51Jphwgo5mdTaNSz5f/6G
 8Xtqh4mZLHUEAv4HPkNJalTW7DWkkA48oJLTzatZVyDofWYwJdtcQ6QZPQLawssRHoCY
 jZ4gADbctuZsbL3ObcZLClS0hz4l3hzJvmk091/OiQbvp+NjREhEa9QA97B51Tj3FKt5 dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2pyge4t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 21:33:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18FLLfXU167221
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 21:33:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3b167u8bp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 21:33:04 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 18FLX44F008153
        for <linux-nfs@vger.kernel.org>; Wed, 15 Sep 2021 21:33:04 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 3b167u8bnn-1;
        Wed, 15 Sep 2021 21:33:03 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] lockd: crashes in svcxdr_encode_owner
Date:   Wed, 15 Sep 2021 17:33:00 -0400
Message-Id: <20210915213300.25066-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: awGZVh0CeZXKlVpRSBnUsBk4JPuH1stb
X-Proofpoint-ORIG-GUID: awGZVh0CeZXKlVpRSBnUsBk4JPuH1stb
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svcxdr_encode_owner needs to handle case where no lock owner
info to pass back, obj->len == 0.

Fixes: a6a63ca5652e ("lockd: Common NLM XDR helpers")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/lockd/svcxdr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/lockd/svcxdr.h b/fs/lockd/svcxdr.h
index c69a0bb76c94..04fde20ea8c1 100644
--- a/fs/lockd/svcxdr.h
+++ b/fs/lockd/svcxdr.h
@@ -139,6 +139,8 @@ svcxdr_encode_owner(struct xdr_stream *xdr, const struct xdr_netobj *obj)
 
 	if (xdr_stream_encode_u32(xdr, obj->len) < 0)
 		return false;
+	if (obj->len == 0)
+		return true;
 	p = xdr_reserve_space(xdr, obj->len);
 	if (!p)
 		return false;
-- 
2.9.5

