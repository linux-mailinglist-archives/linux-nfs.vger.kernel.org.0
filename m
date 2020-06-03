Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685BB1ED61B
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2020 20:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgFCS2o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jun 2020 14:28:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725821AbgFCS2n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Jun 2020 14:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591208923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Id64pKaMP5ClNJjsSWhFhV1iePFv4cJ0zkcBbdG824c=;
        b=VgIYNBE0M1O+ud9T9h4vlrUfBYbKRdMRym45CKml7m6/Ws/+yNYzj0Y+3skq0atXnIKEKm
        6hxGpOMvJDFXk0nMxAsdR6g3eRKFcD2DDPZJxzG/9Hz10d1a7yIiRXSyCyxIZDzy2KWyKt
        /wemwbS2On+/UXOtPIp/6CqXjAzri2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-LgUnD9xaOz6GDEa69ft8KQ-1; Wed, 03 Jun 2020 14:28:41 -0400
X-MC-Unique: LgUnD9xaOz6GDEa69ft8KQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55FA6461
        for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2020 18:28:40 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-114-183.rdu2.redhat.com [10.10.114.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D5365C296;
        Wed,  3 Jun 2020 18:28:40 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 580A71A00CC; Wed,  3 Jun 2020 14:28:39 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH] mountstats: add missing operations
Date:   Wed,  3 Jun 2020 14:28:39 -0400
Message-Id: <20200603182839.3282825-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 tools/mountstats/mountstats.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 3e2a3fe..f101ce5 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -225,7 +225,12 @@ Nfsv4ops = [
     'ALLOCATE',
     'DEALLOCATE',
     'LAYOUTSTATS',
-    'CLONE'
+    'CLONE',
+    'COPY',
+    'OFFLOAD_CANCEL',
+    'LOOKUPP',
+    'LAYOUTERROR',
+    'COPY_NOTIFY'
 ]
 
 def sec_conv(rem):
-- 
2.25.4

