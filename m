Return-Path: <linux-nfs+bounces-13663-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F16B280B7
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 15:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07ACA1CE0E8E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2918428724D;
	Fri, 15 Aug 2025 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQMYZaGN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203C30275D
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265077; cv=none; b=bi+21PI1uM0hAxhNTFuCqwkPDLemmyhEgSSTSDUkWQ91jKnNSHKVbWzl0xibgXbDMB46Ru2zpjTS/eILxwKwDjtCc7v4HQnpWeGemJkuAYWfFdPhN/H5OmPrta+uJm9iq9BvV1o/lsT+1FB9AgQA5rPmOhga9jDRgT7WJ6H28Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265077; c=relaxed/simple;
	bh=zohQStUtasR74FoPPexlk29/16mtENQ7si36wqkEW7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2vNufNg6+LZ39Mjma5aSHijd2y2RHPiCPQN7bsDgaErgvBVvriYWU/Z8iPoZ1doEPP0nXOpi8VPIn8DKOfjAVHArSTkWY0p5eAXoEsNqXUfX4YosKyus74g4xoe209zWuozs7SjXeQdVXh3Mmj2kezz2k+hm2kbnaVbb9upIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQMYZaGN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755265074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E7fadAPMRgdi9iNHL+KE0F+VcFjkUrMEdBg4YPpUQks=;
	b=LQMYZaGNqjbYbBVleyQYZO/Frcp2k6F1Kd+GvBwt0MjhTJfCFZi1uCtkxjwKs1TZ9lVbUe
	nw8I34sG/aO9XUcE3mpV40xgdFXlUtltcULXG/6A9e4PhgJH6ZYFE/CCDG/CeWieSvs3k+
	wP3Su6epeNiYRYlstbY3cUfZKlM1fzs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-icr0oH6mP7St_ayQRmmmSg-1; Fri,
 15 Aug 2025 09:37:52 -0400
X-MC-Unique: icr0oH6mP7St_ayQRmmmSg-1
X-Mimecast-MFC-AGG-ID: icr0oH6mP7St_ayQRmmmSg_1755265072
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D989A195605A;
	Fri, 15 Aug 2025 13:37:51 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.89.202])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 275581954B06;
	Fri, 15 Aug 2025 13:37:50 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] rpc.statd: fails to create RPC listeners when restarting nfs-server
Date: Fri, 15 Aug 2025 09:37:48 -0400
Message-ID: <20250815133748.671243-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Yongcheng Yang <yoyang@redhat.com>

When rpcbind is stopped and the nfs-server is restarted
rpc.statd failes to create RPC listeners.

Changed rpc-statd-service to Require rpcbind.service

Fixes: https://issues.redhat.com/browse/RHEL-96937
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 systemd/rpc-statd.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/systemd/rpc-statd.service b/systemd/rpc-statd.service
index 660ed861..f5c2e486 100644
--- a/systemd/rpc-statd.service
+++ b/systemd/rpc-statd.service
@@ -3,7 +3,7 @@ Description=NFS status monitor for NFSv2/3 locking.
 Documentation=man:rpc.statd(8)
 DefaultDependencies=no
 Conflicts=umount.target
-Requires=nss-lookup.target rpcbind.socket
+Requires=nss-lookup.target rpcbind.service
 Wants=network-online.target
 Wants=rpc-statd-notify.service
 After=network-online.target nss-lookup.target rpcbind.service
-- 
2.50.1


