Return-Path: <linux-nfs+bounces-9883-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2F9A29515
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 16:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81038165BCE
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0DC18952C;
	Wed,  5 Feb 2025 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGJsmkl2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944C1494DF
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770222; cv=none; b=Wxh6mN3uil7rdLAbJo4oUawfQzFiOdq+VfNtY9X+rGGT8/abR/ln2cVyPbelvFf7WTw640vuU1tL376Ir2fw4M1cGwnxI/PdKRM718BPdXCrMD73f6pnfsCpvyYtvAfpAOANcoLc90RqFXUIPXBIV5te9cAt4s3/jfIdxWd+ICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770222; c=relaxed/simple;
	bh=daOdK6PdqTAyMILTQECi1PotXKJ/PEu5rSMB/5qcNPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j6IiYWsA6sdQjtiURapT7D1wOY4ZfAjMeDf39zVb941p7WJ7dSct987J2pphDn56k3oyJVoTMpCXv43dx7K7lXIlsv6X8TUn8AEOhx0NzMoN/zTKDZPrZURYLDVz0LGwk1PcpCPqUy3r/Fos0eSEPKzx2jB1QBuGMZHKPDU5ftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGJsmkl2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738770219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jUBbtQOXgRkP/x8rp5liD+Udiz1YLZ+6W3DoI4sgqpU=;
	b=iGJsmkl2ispFcnDBaQ4iJcJ+c5eimeUqELMXpXAsbtGh15aqCT7aadTmdmodyp1/vgCJ1X
	pNhksGdTzXgR519PeLUT6F9JZTykxWJ/ock4LC5aOxrPHQeDl4EMjAdHaNncsqD3xx2oco
	NED62gQw+NRiWnOCy1HBJKwxQ1hKpNA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-Rjojfsl2MHSEXxI1YeDdVw-1; Wed,
 05 Feb 2025 10:43:37 -0500
X-MC-Unique: Rjojfsl2MHSEXxI1YeDdVw-1
X-Mimecast-MFC-AGG-ID: Rjojfsl2MHSEXxI1YeDdVw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB7191956086
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 15:43:36 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2B4B195608D;
	Wed,  5 Feb 2025 15:43:35 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 0/4] nfs-utils: nfsdctl fixups 
Date: Wed,  5 Feb 2025 10:43:29 -0500
Message-Id: <20250205154333.58646-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Static memory allocations in the path of creating knfsd listeners
has lead to either buffer over flow errors or failure to start
the listener when really long hostname are being used.

Furthermore, when listeners were failed to be created knfsd
threads were still started (with no working listeners). Also,
when threads were not started but we still had already added
they were not cleaned up. 

This patch series attempts to address the said issues.

(note first patch was set as standalone previous and included
here without change).

Olga Kornievskaia (4):
  nfs-utils: nfsdctl: fix update_listeners
  nfs-utils: nfsdctl: fix autostart
  nfs-utils: nfsdctl: cleanup listeners if some failed
  nfs-utils: nfsdctl: fix host-limited add listener

 utils/nfsdctl/nfsdctl.c | 68 +++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 23 deletions(-)

-- 
2.47.1


