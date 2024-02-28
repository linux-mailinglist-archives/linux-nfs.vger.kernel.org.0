Return-Path: <linux-nfs+bounces-2117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1328C86BAAC
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 23:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451DD1C241B0
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 22:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CB97004D;
	Wed, 28 Feb 2024 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVtQHTnT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59F1361DC
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158978; cv=none; b=ZF2ESMXKj6RX0NCew5wUwpvFrXcks7csOtVVgGlsf2RfjN7t/aTeWKzfO8lLH4yfOn68LGCIhr6japZv0T9PyuvcY78MhGVm9fIJZ221itfOTIg/Oocv5tTqOl9ToAgNgaUoY5vOgyDTMVQeRAV2/qnLk/hXGdzKg9EHXemlDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158978; c=relaxed/simple;
	bh=0nDhK1dwqnIzC5Q7+S0XiG6M27MMkFFRdeWvRVnGKfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bD8oRLHo9fSfE5Ae90kcq5+OhgJ/GtaZRnW/6c9NHdLCezvOHxTG0GkzETXEUWeIydbn4OhPQb6RB2pSdD2vRkmCFvzM2Rn355s9Mq4XYIMXgpkZUhBTmd3msQY+wqaxWMl+nsNnAzl/z/9F+Ph9UAJXlCs1uuOzTudoJ8kv284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVtQHTnT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709158976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jAFGzD22f1jZ9dcZlCofCnA1qW23JquBq1zcTbG9H84=;
	b=XVtQHTnTUIqA7p4ibExrsLb9TommIFis2CgKi+EZb9oORKG7F8mT3rFvuzSJiPunTCW9Xk
	BPGlzscCsVvG2t/qNdhtCVpV+9pr4yn1OaD/1771GMnmlC97Z+/DWkazlRuEmi/ZLWLuoD
	mx7wWvZr6+tciaeqW78H0REGfctthNA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-dUnM9kI5MhinigIy-IU_FA-1; Wed,
 28 Feb 2024 17:22:54 -0500
X-MC-Unique: dUnM9kI5MhinigIy-IU_FA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 742063C108C0
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 22:22:54 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.16.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 674432166B33;
	Wed, 28 Feb 2024 22:22:54 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id EBF0B12BBBA;
	Wed, 28 Feb 2024 17:22:53 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH 0/2] gssd: improve interoperability with NFS servers that don't have support for the newest encryption types
Date: Wed, 28 Feb 2024 17:22:51 -0500
Message-ID: <20240228222253.1080880-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

In order for an NFS client with support for the newer encryption types
(AES with SHA2 and Camellia) in its RPCSEC GSS kernel code to connect to
an NFS server without support for those encryption types in its RPCSEC
GSS kernel code, it is sometimes necessary for configuration changes on
the NFS server... particularly if the NFS server's userspace krb5 code
does have support for the newer encryption types and/or the NFS server's
keytab has "nfs" keys using the newer encryption types.  Rather than
rehashing the whole discussion here in the cover letter, see the
description in the first patch for the gory details.

These patches make it easier for a "newer" NFS client to work with an
"older" NFS server. 

The first patch adds support for an "allowed-enctypes" option in
nfs.conf, allowing the the client to restrict the permitted encryption
types to a subset of what is otherwise supported in its krb5 environment
so that it doesn't use an encryption type that the NFS server doesn't
support when negotiating a GSS context. 

The second patch builds on this by adding an automatic backoff feature,
where if the NFS client fails to negotiate a GSS context with the NFS
server using the newer encryption types, it will try again without using
the newer encryption types.

With these patches in place on the NFS client, the "newer" NFS client
will work with an "older" NFS server without requiring any configuration
changes.

Scott Mayhew (2):
  gssd: add support for an "allowed-enctypes" option in nfs.conf
  gssd: add a "backoff" feature to limit_krb5_enctypes()

 nfs.conf               |   1 +
 utils/gssd/gssd.c      |   6 ++
 utils/gssd/gssd.man    |   9 +++
 utils/gssd/gssd_proc.c |  15 ++++-
 utils/gssd/krb5_util.c | 135 ++++++++++++++++++++++++++++++++++++++---
 utils/gssd/krb5_util.h |   3 +-
 6 files changed, 159 insertions(+), 10 deletions(-)

-- 
2.43.0


