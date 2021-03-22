Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EF434515D
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 22:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhCVVDJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 17:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231390AbhCVVCp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 17:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616446964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LcT+neX6hHDp3dxXEc+zJuiHWMlSgtoooqJLzcgrtF8=;
        b=e/X9YJ10mm3UejFZ51hELV2M8K8C6dBXJQUlXX11z1vE7FQEgJTP4M3KlDP2sbUSOwdr09
        iOs/Zszr5XapHTf4TmcCLofjl0++upbgSs1gRklAeBVBTjvr922I+3DHiRfTEMq4Nw64gU
        xtGokT+AbgJjrO7HDlsPGDZVJbOulzE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-1g79kc6lOrqt5KmTruAhxg-1; Mon, 22 Mar 2021 17:02:42 -0400
X-MC-Unique: 1g79kc6lOrqt5KmTruAhxg-1
Received: by mail-ej1-f72.google.com with SMTP id r26so12560eja.22
        for <linux-nfs@vger.kernel.org>; Mon, 22 Mar 2021 14:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LcT+neX6hHDp3dxXEc+zJuiHWMlSgtoooqJLzcgrtF8=;
        b=oPZL9RsiBBegnx+CDgbL2jVhIE9Qi7oVr7Fi+SU+zwPfq2iwBDu4GWQR/CCvYgC6ns
         EuX4Zx9scBcuERWJmNFYUWD57AXbSSvCRZYej2eTNok6llRiP0E6G42tzLW42Ru0D2IL
         kDDB/bk2XQ/GPKZXNso42ZMyDMkPFYjIq15B2XyR3uhXwDoX7mLZv2jiSoOSFdaBbGOC
         v9X1opNCARI1hpCjQ6EZmBHv3nPb6Py1m+As9+E5CDBPK/kABPotnl9XPMJaEGnjWTHD
         TNvn8Pr9FK2U+4AX0OQ6Cv+U9ymihQ5/5rxuhD1Dy9EE0DyyVbOQIHR9RK1I1iQv6m5n
         R9WQ==
X-Gm-Message-State: AOAM533huLANkbR5pDsHXcRp79F82uTv+HOwQ5oMwUCuD7xtm38TKYOE
        k9ZIDPEEFcTypr28GiCNWbvr1vcybDFOvv1PfTeSPVv2lUmQEUCQ59u/J9xy/woJSK1qTSB08Qi
        vIwsU/0EbiuE69tyXApDY
X-Received: by 2002:a17:907:3d8d:: with SMTP id he13mr1666863ejc.530.1616446960817;
        Mon, 22 Mar 2021 14:02:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1Vxhjj8JpZo/GEEvhf8EZdJ+pUfOQDOI7HvAM4DIEF+57uCU0EsGMdBZZWjTKhws1bcp1yg==
X-Received: by 2002:a17:907:3d8d:: with SMTP id he13mr1666850ejc.530.1616446960607;
        Mon, 22 Mar 2021 14:02:40 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id m14sm11764986edd.63.2021.03.22.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 14:02:40 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] exportfs: fix unexporting of '/'
Date:   Mon, 22 Mar 2021 22:02:38 +0100
Message-Id: <20210322210238.96915-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The code that has been added to strip trailing slashes from path in
unexportfs_parsed() forgot to account for the case of the root
directory, which is simply '/'. In that case it accesses path[-1] and
reduces the path to an empty string, which then fails to match any
export.

Fix it by stopping the stripping when the path is just a single
character - it doesn't matter if it's a '/' or not, we want to keep it
either way in that case.

Reproducer:

    exportfs localhost:/
    exportfs -u localhost:/

Without this patch, the unexport step fails with "exportfs: Could not
find 'localhost:/' to unexport."

Fixes: a9a7728d8743 ("exportfs: Deal with path's trailing "/" in unexportfs_parsed()")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1941171
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 utils/exportfs/exportfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 262dd19a..1aedd3d6 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -383,7 +383,7 @@ unexportfs_parsed(char *hname, char *path, int verbose)
 	 * so need to deal with it.
 	*/
 	size_t nlen = strlen(path);
-	while (path[nlen - 1] == '/')
+	while (nlen > 1 && path[nlen - 1] == '/')
 		nlen--;
 
 	for (exp = exportlist[htype].p_head; exp; exp = exp->m_next) {
-- 
2.30.2

