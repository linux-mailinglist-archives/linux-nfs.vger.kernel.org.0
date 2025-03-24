Return-Path: <linux-nfs+bounces-10774-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC372A6E1DA
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 18:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EE33B6414
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB9426461A;
	Mon, 24 Mar 2025 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6k6bi1t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C8263F45
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838480; cv=none; b=Fw5IZSWClGrHw/J7de0zy7bDzFkztvo4qaZn2YlUwYQZQ2ZAOXLw8gmlwEKzUNBEnkKHXw0+0r9vfwFJ2O5W0vKrkaREQi+yyZF+4M9V/Lr0Uxr8J1eYDu9uQbjRN887PhtUS/nEBzxTTc3ggeDGe7BuODPEbB0VCdJ7QiRzE48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838480; c=relaxed/simple;
	bh=buKpdynf1/DwCo2oug7h+lu4SLem4kWkXAoCuboyXgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SruxfCy6V6FhtkVPcyFYCX63PHNmWxI/XNFwPhpZ4DPRIIswodmI6LJ3aNOWWokH+VloxAbmAvyk9DVYuVBX3ugWqXIBC2tBMZ1jybEzi8g9NXC8W62p4ZJ+38Qx65RmrjKGDvg6AWkZdjhif4ldd8H+zNJzK5r1oQQyRa7td/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6k6bi1t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742838477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4bIXD8U2DLIQnZpxcvqKmPxn/giqfms7IeJzvgmL9LM=;
	b=E6k6bi1tRppYanDzzpdWBy1Xxh7leO9YSF7kooU1tNnfTqmeyOkBfgyk9t6RCP9jItPqD1
	VrbwCHvoj7IlFTxQv5QiKRoV3PPLjupGxy5F0wii6StazMA3d9SOYL7RufipPv4cfV+4ll
	z7e4bGFVVQq46hyrnI6K7rV4xiV+qFg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-XpIDJAYBPzWoNZLHyGfwog-1; Mon,
 24 Mar 2025 13:47:56 -0400
X-MC-Unique: XpIDJAYBPzWoNZLHyGfwog-1
X-Mimecast-MFC-AGG-ID: XpIDJAYBPzWoNZLHyGfwog_1742838475
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6564518EBE8A
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 17:47:55 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D934180A801;
	Mon, 24 Mar 2025 17:47:54 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs(5): Add new rdirplus functionality, clarify
Date: Mon, 24 Mar 2025 13:47:52 -0400
Message-ID: <A89FDC8D-114F-4D0E-B898-EC0FB4D747E1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The proposed kernel [patch][1] will modify the rdirplus mount option to
accept optional string values of "none" and "force".  Update the man page=

to reflect these changes and clarify the current client's behavior for th=
e
default.

[1]: https://lore.kernel.org/linux-nfs/8c33cd92be52255b0dd0a7489c9e5cc354=
34ec95.1741876784.git.bcodding@redhat.com/T/#u

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 utils/mount/nfs.man | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index eab4692a87de..91fc508de280 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -434,11 +434,16 @@ option may also be used by some pNFS drivers to dec=
ide how many
 connections to set up to the data servers.
 .TP 1.5i
 .BR rdirplus " / " nordirplus
-Selects whether to use NFS v3 or v4 READDIRPLUS requests.
-If this option is not specified, the NFS client uses READDIRPLUS request=
s
-on NFS v3 or v4 mounts to read small directories.
-Some applications perform better if the client uses only READDIR request=
s
-for all directories.
+Selects whether to use NFS v3 or v4 READDIRPLUS requests.  If this optio=
n is
+not specified, the NFS client uses a heuristic to optimize performance b=
y
+choosing READDIR vs READDIRPLUS based on how often the calling process u=
ses
+the additional attributes returned from READDIRPLUS.  Some applications
+perform better if the client uses only READDIR requests for all director=
ies.
+.TP 1.5i
+.BR rdirplus=3D{none|force}
+If set to "force", the NFS client always attempts to use READDIRPLUS
+requests.  If set to "none", the behavior is the same as
+.B nordirplus.
 .TP 1.5i
 .BI retry=3D n
 The number of minutes that the
-- =

2.47.0



