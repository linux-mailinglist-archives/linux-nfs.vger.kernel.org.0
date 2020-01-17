Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A920140E3E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 16:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgAQPsb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 10:48:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26876 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727043AbgAQPsb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 10:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579276110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdBL2slNDE/rtW+Xz9P92Zb9qLwhk6nZyC6cAzxgr5o=;
        b=Y8YR04hg2FUmh0mqjYstEsAciQoVoVmuL0MACefVXKxFdte8A56zf75Ji+5sXeSUR9hOVx
        km3YwX0iQ6fl+hOGMwHuLcWj3ay8gau+elEU/pZR0vlgwG6P6sMO+MIx1oTwzh3eQjLP9Y
        NAB9ywFxlKY9Bd6k5qFSo1C9vjd9xro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-IabzsO5JOFearTadoPmb8Q-1; Fri, 17 Jan 2020 10:48:27 -0500
X-MC-Unique: IabzsO5JOFearTadoPmb8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37B94107BAAB;
        Fri, 17 Jan 2020 15:48:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AFC3101F942;
        Fri, 17 Jan 2020 15:48:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200117144055.GB3215@pi3>
References: <20200117144055.GB3215@pi3> <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com> <433863.1579270803@warthog.procyon.org.uk>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Scott Mayhew <smayhew@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] nfs: Return EINVAL rather than ERANGE for mount parse errors
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <464518.1579276102.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 17 Jan 2020 15:48:22 +0000
Message-ID: <464519.1579276102@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Krzysztof,

Does this patch fix the problem?

David
---
commit 3021f58ee1e2c9659e629d0ccf06d3e0876e805a
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
index 429315c011ae..07cbd655dafb 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -770,7 +770,7 @@ static int nfs_fs_context_parse_param(struct fs_contex=
t *fc,
 	return nfs_invalf(fc, "NFS: Bad IP address specified");
 out_of_bounds:
 	nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
-	return -ERANGE;
+	return -EINVAL;
 }
 =

 /*

