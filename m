Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0690A423488
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 01:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhJEXna (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 19:43:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54906 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233540AbhJEXn2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 19:43:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195MhlUN013976;
        Tue, 5 Oct 2021 23:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=h47bh+yl/IWbYQ1S1dhyDBio46Dov2vxPT7KqqsOzjo=;
 b=ZrL8dqgfQVwzk48HRbIKx70PgBStoCNI4O7Zoo9H/iQMADfYAPGcNVvj/U7zvf27rVRk
 PLGIIy4Y4cAobc8Ry2b+HIGId6KeSz1MJYaANqTOjAfS+h/CxYH/WuyXYFHzhVAGxZY6
 ODmIaA0XbaTVccxYTeHxYoXzrSngXddOYQBM1JVuOZJaEgJ7RMNwN6q942Q2Mf98rKqv
 9sbtDiF4kU8viyJ1aSjLGiBkD4yfYhZtPv3iT/VyxLBXU6eddzWzMBRb3CPxZcfAWz1Q
 MOPoF+7k1R2QItoAKWkSxCyASkpR9kxbKu+fznApaxLQXDD+2L+Jxhzt0KewNX5yj7Yb MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3uq4cdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 23:41:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195NeK39048219;
        Tue, 5 Oct 2021 23:41:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3bev8xgyxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 23:41:26 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 195NfQfa052035;
        Tue, 5 Oct 2021 23:41:26 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 3bev8xgyx7-1;
        Tue, 05 Oct 2021 23:41:25 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] st_courtesy.py: fix bug in COUR2 and add more tests for Courteous Server
Date:   Tue,  5 Oct 2021 19:41:21 -0400
Message-Id: <20211005234123.41053-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZZ0rVG55FYkIHpfzqZOUVFNMm946i7Iv
X-Proofpoint-GUID: ZZ0rVG55FYkIHpfzqZOUVFNMm946i7Iv
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

This patch series fixes a bug in COUR2 test and also adds more tests
for Courteous Server.

V2: Create bug fix as separate patch
    Replace new_client and create_session with new_client_session.

-Dai


