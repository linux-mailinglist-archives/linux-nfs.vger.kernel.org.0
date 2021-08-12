Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749B23EA9FE
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Aug 2021 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbhHLSN6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 14:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237510AbhHLSN6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 14:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628792012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/0n0I5NVe0nOUsA4hiX7etJRdh0G8SF+YX9GRQaal8=;
        b=WHaBNi2P9/BsM91b3Mo7yeeXQYTLCpAaU+p1hMjcx9fouZHMXtdDXl7OKBBNpoXN/haJoT
        BjftT81VvAVGzKabAmzu9SOghLVvMuvMBe8kWM6EC+Cw9bnMh/UlDlHImXcj5yl6Kwl3xY
        DEIjKM1w+5pGt/yiDRzn+mHpCZ6zDcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-jJJKsq1UOMy1XfY8_YLjbw-1; Thu, 12 Aug 2021 14:13:31 -0400
X-MC-Unique: jJJKsq1UOMy1XfY8_YLjbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 462F2801B3D
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 18:13:30 +0000 (UTC)
Received: from ajmitchell.com (unknown [10.39.192.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BBC960657;
        Thu, 12 Aug 2021 18:13:29 +0000 (UTC)
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Alice Mitchell <ajmitchell@redhat.com>
Subject: [PATCH 4/4 v2] nfs-utils: Fix mem leak in mountd
Date:   Thu, 12 Aug 2021 19:13:19 +0100
Message-Id: <20210812181319.3885781-5-ajmitchell@redhat.com>
In-Reply-To: <20210812181319.3885781-1-ajmitchell@redhat.com>
References: <20210812181319.3885781-1-ajmitchell@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

leak of mountlist struct and content on error

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
---
 utils/mountd/rmtab.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/utils/mountd/rmtab.c b/utils/mountd/rmtab.c
index 2da9761..752fdb6 100644
--- a/utils/mountd/rmtab.c
+++ b/utils/mountd/rmtab.c
@@ -233,6 +233,9 @@ mountlist_list(void)
 			m->ml_directory = strdup(rep->r_path);
 
 			if (m->ml_hostname == NULL || m->ml_directory == NULL) {
+				free(m->ml_hostname);
+				free(m->ml_directory);
+				free(m);
 				mountlist_freeall(mlist);
 				mlist = NULL;
 				xlog(L_ERROR, "%s: memory allocation failed",
-- 
2.27.0

