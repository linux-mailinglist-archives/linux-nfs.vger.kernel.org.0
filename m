Return-Path: <linux-nfs+bounces-1303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D199183AA8B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 14:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704F01F212CA
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 13:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43537A718;
	Wed, 24 Jan 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CaHkdaDg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC77CF24;
	Wed, 24 Jan 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101254; cv=none; b=UJgu2jE4+gfM8BwjO4wJ0vNiQdz/IlyzTsyua9jgA4xJ7cQdv8lafFJK4X+IwBirTHWKDrd2tR6KulEMKiaTyb5YMLiporUR+nvAhM4kSkTMtrLgMMk2HZBAgEKkKvsgCsL0pdI0fZohtgh1/tAnpm2Kilhgnfr7JUoZA8ibfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101254; c=relaxed/simple;
	bh=/XQF/5j8eOYpqaWQuiehGOMbFnkWRw5XgZUgUXshY+Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eWKwdTgWEoAYIDMjP0lVz9OHMYfPfRD9YDg36kMKBsn9VCZU/vAz9Rp/WsJvwPf2/FFL4ZcAyAZVFTMvRI8fSLLshw27XHNQ1YAOp2wV9RxPuuIAhuLz/PyUBYSs+wu8uFDv014QdKOCb77UKeJtk9tUc/25Fq/jsdVhh4SZ+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CaHkdaDg; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706101254; x=1737637254;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/XQF/5j8eOYpqaWQuiehGOMbFnkWRw5XgZUgUXshY+Q=;
  b=CaHkdaDgOUIHLgsduvhq8ZHzc8FO97oIfI9txcYaryESIA65tHi/snbY
   EhLEiJaWaUHz3TLoMhNQIbPW0VOMzSDuMdfec1vLVaVEoKgqiYqqAWMxY
   8TAqOhzCuiIdT/2RxG04Cyx6fF+DnU2HvTphDW3D5ptvclbLgfoeTukn9
   c=;
X-IronPort-AV: E=Sophos;i="6.05,216,1701129600"; 
   d="scan'208";a="629682277"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 13:00:49 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com (Postfix) with ESMTPS id C171540D7F;
	Wed, 24 Jan 2024 13:00:47 +0000 (UTC)
Received: from EX19MTAUEB002.ant.amazon.com [10.0.29.78:7827]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.88.120:2525] with esmtp (Farcaster)
 id f30129dc-2917-48ce-a7ae-61a82e83ff9a; Wed, 24 Jan 2024 13:00:47 +0000 (UTC)
X-Farcaster-Flow-ID: f30129dc-2917-48ce-a7ae-61a82e83ff9a
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 13:00:44 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 13:00:43 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id A9C0FCB9; Wed, 24 Jan 2024 14:00:43 +0100 (CET)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <viro@zeniv.linux.org.uk>, <xuyang2018.jy@fujitsu.com>,
	<stable@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<--suppress-cc=body@amazon.com>
Subject: [PATCH 5.4 0/2] backport add and use mode_strip_sgid in vfs_*() helpers
Date: Wed, 24 Jan 2024 14:00:24 +0100
Message-ID: <20240124130025.2292-1-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

These patches are a follow up fixes for CVE-2021-4037 &
CVE-2018-13405, LTP test creat09.c & openat04.c reproduces the
privilege escalation in v5.4, the two patches solves this and they are
already backported to the other stable kernels.




