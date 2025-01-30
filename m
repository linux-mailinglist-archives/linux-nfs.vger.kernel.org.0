Return-Path: <linux-nfs+bounces-9780-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3835A22C8A
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 12:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0482D1888937
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 11:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28511DEFF8;
	Thu, 30 Jan 2025 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=andrej.kozemcak@siemens.com header.b="ST+KoKUO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA651A8F60
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738236804; cv=none; b=raW07YgOY+gij/YTQH5fNwFdIbbBjkA5ksRftXCHnm4GjVoOAwpZ14xE8v8yVj5i3qEhjyruxMc6TxUPemeDiPJF7IuY5zWuOE3rq+zWtIj2AZyWylBpuEFq/nD2Vo79KZkvgYHvCwtIwX9JoTXHERKYD4ignYWICxI88BjYp9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738236804; c=relaxed/simple;
	bh=pWVccBLf3gWqHO20uJVcGO9c7co2LQjC5zKpo0V5rbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oa+V/uTYVaa1z/Xce693gYGY9aRJJ4N/LOWCKfcq/86bzXQg3peSOrSOe+6ZHvyr1Bswm0cZG9ezk8uR7XlB1knRWiaOld2KQ1EL88p3OLhhptsN/0/8BWJu68LBQdA22zkRZUTmrecm9C4Zsmvjgyh0euMyzsLxF14ma+YzWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=andrej.kozemcak@siemens.com header.b=ST+KoKUO; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025013011331516c3039f547c77d21e
        for <linux-nfs@vger.kernel.org>;
        Thu, 30 Jan 2025 12:33:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=andrej.kozemcak@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=q2s58ipvCgIOOBt2bahLRIzFuNewfiUnAi5BlGQI6zI=;
 b=ST+KoKUOks47nzGOxiFQVdXFxuv8+vFhkLd4ebXhScfMod3kO15+ua2c6J4PNeiYjvM3Vl
 BYW/Cf7TfsP5BXcOVtGQq+1AU0lcKkFAM7zyT9HTReIrqU3wXI5L8OfR8v+SGclSMKy99lAT
 7XF9BOkTeJ7Mk/6BcvtCShTrS75V6BXkLu6aexzuofaDplNnjBYsnabUrvSuS7tiL4t+UQDr
 kQmww0pMLi9yD1B7mYJ8QQ88dJkTXGL76JXj18zsQyOYS+GJILT+kz0Nlu+4eorMjp4Ci8YN
 nd67v7L61fYi8kSVeqJkaneNwHy4XC6j3cB3j7xWzM+o2X6ng1N2KR6g==;
From: Andrej Kozemcak <andrej.kozemcak@siemens.com>
To: linux-nfs@vger.kernel.org
Cc: Andrej Kozemcak <andrej.kozemcak@siemens.com>
Subject: [PATCH] systemd: mount nfsd after load kernel module
Date: Thu, 30 Jan 2025 12:32:34 +0100
Message-Id: <20250130113234.885998-1-andrej.kozemcak@siemens.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328795:519-21489:flowmailer

Systemd should load nfs kernel module before it try mount nfsd file systemd.
In some systems systemd try mount nfsd file system before the nfs
kernel module was loaded, which end with error.

Signed-off-by: Andrej Kozemcak <andrej.kozemcak@siemens.com>
---
 systemd/proc-fs-nfsd.mount | 1 +
 1 file changed, 1 insertion(+)

diff --git a/systemd/proc-fs-nfsd.mount b/systemd/proc-fs-nfsd.mount
index 931a5cee..630801b3 100644
--- a/systemd/proc-fs-nfsd.mount
+++ b/systemd/proc-fs-nfsd.mount
@@ -1,5 +1,6 @@
 [Unit]
 Description=NFSD configuration filesystem
+After=systemd-modules-load.service
 
 [Mount]
 What=nfsd
-- 
2.39.5


