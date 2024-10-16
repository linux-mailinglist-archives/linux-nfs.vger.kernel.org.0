Return-Path: <linux-nfs+bounces-7198-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2690E9A0AB1
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 14:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C1C1F24D80
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B3207A1E;
	Wed, 16 Oct 2024 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEAYFxPv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F31494DA
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082964; cv=none; b=s0pI1GDeXRsTHn14psUMgeE8LRqckY/WyznqUn684rjDiTzu+D77JBPr0LL6wtxZcPnLxkWhUE+cyEGruhqM7PBV/KCao152zrJIMibS9MVTrcnXWQcvt23BhbCvcLwdDKXGmW5jxRRWeeqvxF/UGnV3c6C1PMNNYOWOXqD29ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082964; c=relaxed/simple;
	bh=HwiRrLovhi8LSfvXKaIbyTd2a0RDbYHEaljrRHXbSN8=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=aNfMwNOVTHzcFo2c6cYINvHe7qTW5tnzpjGKffAhgv4sYri0Tcz7SsKr96Rjtlm6EniLt+FMecvOvznRG+D2yUW4bGrXmC8MsB5CC0jzKubZs8Mcvc2AnPwtMITCI3dBKG/6LXopdsb8chTfzfxktFgyzd3XwHpDB07mI6sSnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEAYFxPv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F2GwOhZduJ+ppO9KA2LHBNxiV3yxP7zUCAL35HJly9U=;
	b=XEAYFxPv58d/5p8zYFt/5wMgIbfkVCxWFRu0WSf331pOybW0foIKd7keHwofhYn+mvXrp4
	kLHZZRlNV6yHukobBjvVy4QenJaOoQZ2SZPKApLe2hagnbq91P3zkbL/mAT2qQ2Ace8WLO
	IE7Shb7gpEmsB6LkLnud0uQ8aThfW3I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-drk9t9IAP-qSCjjXgzBeQw-1; Wed,
 16 Oct 2024 08:49:18 -0400
X-MC-Unique: drk9t9IAP-qSCjjXgzBeQw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CBD61955EAC;
	Wed, 16 Oct 2024 12:49:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.218])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB32C3000198;
	Wed, 16 Oct 2024 12:49:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Masahiro Yamada <masahiroy@kernel.org>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] kheaders: Ignore silly-rename files
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1113846.1729082954.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Oct 2024 13:49:14 +0100
Message-ID: <1113847.1729082954@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Tell tar to ignore silly-rename files (".__afs*" and ".nfs*") when buildin=
g
the header archive.  These occur when a file that is open is unlinked
locally, but hasn't yet been closed.  Such files are visible to the user
via the getdents() syscall and so programs may want to do things with them=
.

During the kernel build, such files may be made during the processing of
header files and the cleanup may get deferred by fput() which may result i=
n
tar seeing these files when it reads the directory, but they may have
disappeared by the time it tries to open them, causing tar to fail with an
error.  Further, we don't want to include them in the tarball if they stil=
l
exist.

With CONFIG_HEADERS_INSTALL=3Dy, something like the following may be seen:

   find: './kernel/.tmp_cpio_dir/include/dt-bindings/reset/.__afs2080': No=
 such file or directory
   tar: ./include/linux/greybus/.__afs3C95: File removed before we read it

The find warning doesn't seem to cause a problem.

Fix this by telling tar when called from in gen_kheaders.sh to exclude suc=
h
files.  This only affects afs and nfs; cifs uses the Windows Hidden
attribute to prevent the file from being seen.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Masahiro Yamada <masahiroy@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 kernel/gen_kheaders.sh |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 383fd43ac612..7e1340da5aca 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -89,6 +89,7 @@ find $cpio_dir -type f -print0 |
 =

 # Create archive and try to normalize metadata for reproducibility.
 tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
+    --exclude=3D".__afs*" --exclude=3D".nfs*" \
     --owner=3D0 --group=3D0 --sort=3Dname --numeric-owner --mode=3Du=3Drw=
,go=3Dr,a+X \
     -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
 =


