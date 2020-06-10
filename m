Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB86E1F542A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2020 14:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgFJMEr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jun 2020 08:04:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48906 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728848AbgFJMEr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Jun 2020 08:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591790686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dli/3hq+oxVrrFkpBpeVzvhrqlnrr59g+y5Wu6G6QAE=;
        b=StcAhYmbcyP6b0Mt659c0QkRRJZBilV8l985N8MNtuyW6IWWuTfZvNVVF8iLw8noekkoN2
        V3ad3mhNNCImd6a2KNd5ZQsgAvUihFnYL+9ZGKchKE1kzpF0PPpQUo6UIcWnNwIpjLc0eU
        x45GlEwrMh4R4o5SyspVP7y4pmwPeUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-WKmdH7m0NmaTo-z03QSK4A-1; Wed, 10 Jun 2020 08:04:44 -0400
X-MC-Unique: WKmdH7m0NmaTo-z03QSK4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B092118FE860
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jun 2020 12:04:43 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.74.9.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D47F600F7;
        Wed, 10 Jun 2020 12:04:41 +0000 (UTC)
From:   Kenneth D'souza <kdsouza@redhat.com>
To:     SteveD@redhat.com, linux-nfs@vger.kernel.org
Cc:     kdsouza@redhat.com
Subject: [PATCH] nfsdclnts: Change shebang to /usr/bin/python3
Date:   Wed, 10 Jun 2020 17:34:37 +0530
Message-Id: <20200610120437.17482-1-kdsouza@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Change shebang to /usr/bin/python3 which is widely accepted.

Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
---
 tools/nfsdclnts/nfsdclnts.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/nfsdclnts/nfsdclnts.py b/tools/nfsdclnts/nfsdclnts.py
index e5f636a2..5e7e03c2 100755
--- a/tools/nfsdclnts/nfsdclnts.py
+++ b/tools/nfsdclnts/nfsdclnts.py
@@ -1,4 +1,4 @@
-#!/bin/python3
+#!/usr/bin/python3
 # -*- python-mode -*-
 '''
     Copyright (C) 2020
-- 
2.21.1

