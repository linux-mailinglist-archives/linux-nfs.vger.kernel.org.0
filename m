Return-Path: <linux-nfs+bounces-12889-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB0DAF8933
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 09:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40736188AD67
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 07:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9001277818;
	Fri,  4 Jul 2025 07:24:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2462797BE
	for <linux-nfs@vger.kernel.org>; Fri,  4 Jul 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751613861; cv=none; b=Ht3oC++EvQStLiHqlsG5sX9dm9Ic4BYcrmen++qGKRb8zvPIRUDG51RhzoUQimyeEcMeU/JAyV1swMmHQZ1Ft7dAivgPnI1t7MNM0kfSuQO2iCi4wbLnvIRzC9ieuoDSIenl66WYUL30z+kLWBxG/NOYZXqFTE6yLBORA4GMA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751613861; c=relaxed/simple;
	bh=FTIF5pSuzlgLWBrqBSoMlsp1ZZTRtc7yKrVCAa742hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzQc9CaGr4kgecKX8UyDYIWiS9NSr9jK3bXXHiIxkID3l2pXkEkKwjS0GyZd2KiZ1I+0DG5FT5k9/hiCrlzP+016u9QzNtzdaFoqnhSFXCPGR9pLT040+h6DX7/r35v91IbaYcwYNRzhdLv7XHLlwy5YAIV3BEkFJinR/uXeHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uXalr-001jkG-N7;
	Fri, 04 Jul 2025 07:23:43 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 0/2] nfsd: provide locking for v4_end_grace
Date: Fri,  4 Jul 2025 17:20:16 +1000
Message-ID: <20250704072332.3278129-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing to v4_end_grace can race with server shutdown and result in UAF.
The first patch fixes the problem in a way that is suitable for
backport.  The second patch improves is slightly (in my opinion) but in
a way that cannot be backported very far.

Note that I've used a different Closes: link to the one Chuck suggested
in a recent email.

NeilBrown


 [PATCH 1/2] nfsd: provide locking for v4_end_grace
 [PATCH 2/2] nfsd: discard client_tracking_active and instead disable

