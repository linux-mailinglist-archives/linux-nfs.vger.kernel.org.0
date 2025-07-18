Return-Path: <linux-nfs+bounces-13147-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91989B09D87
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 10:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56CFC7BD305
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D734C9D;
	Fri, 18 Jul 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RGz+ik5S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00171FBCA1
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826518; cv=none; b=NuftDTFIp1v+H79FFPjklWlF4J8hCXkE5l18v6GEHxzjF2L/8EWOGdzcZXtlAK801Y9eNcJNwHepC9VLrpZwtyVguI/QeGs5JB038Fo1ps1khcTNXfCooSVwFd6p8rX3ptWrFhRCALYLRcWl5tEBqCmU0lAH9506whxjJLptkAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826518; c=relaxed/simple;
	bh=+txq4r6E788XiOSzoptwb51kKfkT4FGnRKjYdm1YSWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFJZS8TmlEfc35ODzpCkfwogPJifWx+1tBZ4cGQkfeAjxd16rXRB+Lor6AWPzBKRG6stxGeAW5X1NqxJ0SdqhUkRgE9WfWSojt+A/bxRL/FVOJHeqtE+rgzTjsasNSt40P7Qwf6CEKRK6ywA3jmOY9b14A4jFtAA9Mhtcx59FIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RGz+ik5S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GI+fqoKc34XxbYKLNADoFcrRG5P+fGFwcx9k6OZ6w8A=; b=RGz+ik5S8YKs07p61Wa9N6+2zy
	eV3q6d1mgU6N+STWdF3hL4VhWE6O44OD7+Yx78ds28btO7AChSv83/7iTRS5g1oQPrGcr1pfwVvRb
	n7zajBCKY0xeChv4thtDXxSwjveDZMKrw3njohWYN+/5yZtC8Tn7XiSB01UEfTT/YAPoXBdFLavT9
	gHYMU1YWHCKGo5N/cOstsfdaY0VLfZll/6I1BcpVJKlVEv/yO5ebFM0BV+ZEU2o5XBsFI+OCNz6kE
	617d4rqTEFQJFr0usflAXB7BgvF3Vf6uYzlcSkgy5zEE0YrY26yiBloP0MR23Zhg9BmpxaGsu4lHG
	sqKSHNiQ==;
Received: from [2001:4bb8:2dd:a44:6557:72e7:fc8:56bc] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucgFP-0000000Bzt2-12m6;
	Fri, 18 Jul 2025 08:15:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] NFS: cleanup error handling in nfs4_server_common_setup
Date: Fri, 18 Jul 2025 10:14:46 +0200
Message-ID: <20250718081509.2607553-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718081509.2607553-1-hch@lst.de>
References: <20250718081509.2607553-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Return error directly instead of using a goto label for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/nfs4client.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 2e623da1a787..5943a192f36b 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1103,14 +1103,14 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	/* We must ensure the session is initialised first */
 	error = nfs4_init_session(server->nfs_client);
 	if (error < 0)
-		goto out;
+		return error;
 
 	nfs4_server_set_init_caps(server);
 
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
 	if (error < 0)
-		goto out;
+		return error;
 
 	dprintk("Server FSID: %llx:%llx\n",
 			(unsigned long long) server->fsid.major,
@@ -1119,7 +1119,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 
 	error = nfs_probe_server(server, mntfh);
 	if (error < 0)
-		goto out;
+		return error;
 
 	nfs4_session_limit_rwsize(server);
 	nfs4_session_limit_xasize(server);
@@ -1130,8 +1130,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	nfs_server_insert_lists(server);
 	server->mount_time = jiffies;
 	server->destroy = nfs4_destroy_server;
-out:
-	return error;
+	return 0;
 }
 
 /*
-- 
2.47.2


