Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC282353183
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Apr 2021 01:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhDBXan (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Apr 2021 19:30:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:32900 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbhDBXan (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Apr 2021 19:30:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NUPBE080069;
        Fri, 2 Apr 2021 23:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=arfIrr6AAAkr1dB4SR8g5udBHquqkAbQc1XW3+wusxA=;
 b=OwV86ksJqd+ePMi6gNxsNBYd8aRKVx7VArKHCyho9PyAVKtVxkWdsUG73m36cgWnn8Ji
 /qCm5LAd337+uu+BvdAyOHyXFOe/WQIk+ukgoertBQcExGxRfYrSmyste5f1wNu30z3v
 VsXEfoXYDmO6ZKKIv9zRnBJ6sraxZvMMO8oUhdO5IX6Z92//y7CKjt3J8MkPDs379W7z
 t3+VoXcqKIsvsDiBASjKZy0MuiIK973LaaVmLyk8/1uqvXqDg5XgL6nqGrFBekQRBoB6
 8d54zwho7cuBPMszVVqkG6jLWTXNdAeNdnrshIIUR8veQzCVl//LmTPyaqwj40vrQXkq mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37n33dwny2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:30:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NP2bW033411;
        Fri, 2 Apr 2021 23:30:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 37n2acxbst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:30:34 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 132NPvWI035088;
        Fri, 2 Apr 2021 23:30:34 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 37n2acxbsh-1;
        Fri, 02 Apr 2021 23:30:34 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        bfields@fieldses.org, chuck.lever@oracle.com
Subject: [PATCH v2 0/2] enhance NFSv4.2 SSC to delay unmount source's export. 
Date:   Fri,  2 Apr 2021 19:30:29 -0400
Message-Id: <20210402233031.36731-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GssPPNOhxwhe8od3bXhe5kSHF0nVtXZh
X-Proofpoint-ORIG-GUID: GssPPNOhxwhe8od3bXhe5kSHF0nVtXZh
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020158
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Currently the source's export is mounted and unmounted on every
inter-server copy operation. This causes unnecessary overhead
for each copy.

This patch series is an enhancement to allow the export to remain
mounted for a configurable period (default to 15 minutes). If the 
export is not being used for the configured time it will be unmounted
by a delayed task. If it's used again then its expiration time is
extended for another period.

Since mount and unmount are no longer done on each copy request,
this overhead is no longer used to decide whether the copy should
be done with inter-server copy or generic copy. The threshold used
to determine sync or async copy is now used for this decision.

-Dai

v2: fix compiler warning of missing prototype.


