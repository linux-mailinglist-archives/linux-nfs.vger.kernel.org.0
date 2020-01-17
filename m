Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 241A5140E5D
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 16:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgAQPzU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 10:55:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30729 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728739AbgAQPzT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 10:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579276518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YDF/Cwp5+/dLyQZcVzRTY0MuN6+ZElzaVy7SKb9ltJw=;
        b=DAshugRVZTABbNzDEVC+5OojbBxHMLIgAKs6+BEwo2pCYqa4hh1zZDByKiRNTHvFHLn2N1
        KJbDv/0317augEjO8EtGve/67aOHY1tvhWcm9eb4WRvonixLdqZxzfaCcZXLXXTD4xFO38
        ivczRzuW5TyFOVFw12sG4ZyiLqeGm7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-PDT3rNr4NG60KgD9i9Rz0g-1; Fri, 17 Jan 2020 10:55:15 -0500
X-MC-Unique: PDT3rNr4NG60KgD9i9Rz0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 846461800D4F;
        Fri, 17 Jan 2020 15:55:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC27019C7F;
        Fri, 17 Jan 2020 15:55:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <464519.1579276102@warthog.procyon.org.uk>
References: <464519.1579276102@warthog.procyon.org.uk> <20200117144055.GB3215@pi3> <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com> <433863.1579270803@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Scott Mayhew <smayhew@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] nfs: Return EINVAL rather than ERANGE for mount parse errors
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <465148.1579276509.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 17 Jan 2020 15:55:09 +0000
Message-ID: <465149.1579276509@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

commit b9423c912b770e5b9e4228d90da92b6a69693d8e
Author: David Howells <dhowells@redhat.com>
Date:   Fri Jan 17 15:37:46 2020 +0000

    nfs: Return EINVAL rather than ERANGE for mount parse errors
    =

    Return EINVAL rather than ERANGE for mount parse errors as the userspa=
ce
    mount command doesn't necessarily understand what to do with anything =
other
    than EINVAL.
    =

    The old code returned -ERANGE as an intermediate error that then get
    converted to -EINVAL, whereas the new code returns -ERANGE.
    =

    This was induced by passing minorversion=3D1 to a v4 mount where
    CONFIG_NFS_V4_1 was disabled in the kernel build.
    =

    Fixes: 68f65ef40e1e ("NFS: Convert mount option parsing to use functio=
nality from fs_parser.h")
    Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 429315c011ae..74508ed9aeec 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -769,8 +769,7 @@ static int nfs_fs_context_parse_param(struct fs_contex=
t *fc,
 out_invalid_address:
 	return nfs_invalf(fc, "NFS: Bad IP address specified");
 out_of_bounds:
-	nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
-	return -ERANGE;
+	return nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
 }
 =

 /*

