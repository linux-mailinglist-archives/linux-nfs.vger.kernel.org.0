Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A78B35233F
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 01:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhDAXNQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 19:13:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55052 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbhDAXNO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 19:13:14 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131N8uJl135133;
        Thu, 1 Apr 2021 23:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=cBjF5N5yXbH6S3vsiLx/EWjDheZxJt2AyjLo+M5b8Hk=;
 b=V3V2TWdgkS+Kr2NJXxYVM6adelzOLKu+rIQgB05yI1ri4CqWbg02+wjOyJULzfxDMBmx
 1ifk3CsS9Vi8YcyCQi1/hhNehAfbBRIRWFwCZALLFLJ9H+i5tthMbzidGcCI8dyPQy+3
 afH2mpkhlKS2NAwSGW2t3U0NzhdmQ7AtlstErALAlfs9HZsn1E4ZJgdKl6rLAy/LxBmB
 PTp8h8mOWZXp8wwcniQOpRUGSBWnA2QEB1Swiz+z0P9Nmv6K+L4lsOTuD4i9krZgYMhP
 IpIIEte/rj9QlKcz80yyxIbC/1fmUtTTKJrHXNeXa1U29I/Lk28Bs0dx7sAcMhtiAhjN lQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37n33dub49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 23:13:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131N9ccJ119346;
        Thu, 1 Apr 2021 23:13:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 37n2ate1ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 23:13:02 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 131ND15C130727;
        Thu, 1 Apr 2021 23:13:01 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 37n2ate1u4-1;
        Thu, 01 Apr 2021 23:13:01 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        bfields@fieldses.org, chuck.lever@oracle.com
Subject: [PATCH 0/2] enhance NFSv4.2 SSC to delay unmount source's export.
Date:   Thu,  1 Apr 2021 19:12:56 -0400
Message-Id: <20210401231258.63292-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FkUMdQn_XRStymlqbmom_MRy9S4lDNkA
X-Proofpoint-ORIG-GUID: FkUMdQn_XRStymlqbmom_MRy9S4lDNkA
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010149
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


