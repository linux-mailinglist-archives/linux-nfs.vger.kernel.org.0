Return-Path: <linux-nfs+bounces-18928-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHGJGlWoj2lgSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18928-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:40:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DE0139D34
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 23:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C147300616E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 22:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC22A27FD49;
	Fri, 13 Feb 2026 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuOAysCk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DF2F9985
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 22:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771022419; cv=none; b=aiNwFbOfDFI01k4rY6nFFmK8F6MKyjyw5PTMxFM/9Rg/5lv6KIZEX6WlOUVm1V/qN/sj3sq45w4J0US6za9cwa2LCIH5mwoJyjp4xAKCwkpsVT0tZaPjIdpPcr7GnO/xz1SKbGlYPE4uOccSLi3Zjup01lxvM9iJNcGCzRb7xGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771022419; c=relaxed/simple;
	bh=XScfONYxJDpqY5GllmqEOA3i4iOWryrbt6nufQeeM/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJFjvvsbh5nVjvH9MBBepsk2eo4JewWUO5E3YqRqZ29b6YDiq3M5u18uds0GaJ69Xi4/zoaQgj+2BHskdgI5QR9WaFgzP0uYZfw4TWFPnZgx4rSbaU7tSU4fwEHRkqIspRbdUvT/LN1AHoNy5nBAGvJoWw6cltioksEWxshtLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuOAysCk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771022417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=65ftfOnm3VZa0JD7E0nDXP5u6B3J1SOsLsH1+yAEbz8=;
	b=KuOAysCkQWcBsZbmmgx5B9heEhp92YtMyT3eXw3jbDUo0/b4n5MVVXiDDXHPgpGf6DSQoz
	uAEPAYEtEdNdTFhixHq5x+OuIwBPOpg4nFeO8Lw93i3LDSsZapECYZPbm/2M3J6rSokVqI
	b9y256mOoCdM9dT13rxEQnY+SNpjzMY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-wflSEJ2lOOqI-gZWQ91t1Q-1; Fri,
 13 Feb 2026 17:40:14 -0500
X-MC-Unique: wflSEJ2lOOqI-gZWQ91t1Q-1
X-Mimecast-MFC-AGG-ID: wflSEJ2lOOqI-gZWQ91t1Q_1771022413
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 810D6180025A;
	Fri, 13 Feb 2026 22:40:13 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.127])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CFBC1955D85;
	Fri, 13 Feb 2026 22:40:13 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 310966B69FA;
	Fri, 13 Feb 2026 17:40:12 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: =carnil@debian.org,
	linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH RFC 0/4] Rework the handling of encryption types in rpc.gssd
Date: Fri, 13 Feb 2026 17:40:08 -0500
Message-ID: <20260213224012.2608126-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18928-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 11DE0139D34
X-Rspamd-Action: no action

These patches address the issue described in "nfs: ls input/output error
("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2"
(https://bugs.debian.org/1120598).

The core issue is that when the krb5 library does a TGS request, it
initially does so with referrals enabled, disregarding the enctypes list
supplied by the requesting application.  It still checks the resulting
ticket to ensure that it's using one of the requested enctypes, but it
may not the highest priority enctype from our list.  See 
make_request_for_service(), step_referrals(), and wrong_enctype() in the
krb5 code.

The problem arises if it does this when setting up the machine
credential, but it doesn't do it when setting up a user's credential
(which can happen in the case of constrained-delegation via gssproxy).

That can lead to the machine credential and the user credentials using
different enctypes, leading to XDR decoding failures described in the
above bug.

These patches aim to address that issue by making sure that the list we
pass to limit_krb5_enctypes is in the same order as the default list
in the krb5 library.

Scott Mayhew (4):
  gssd: remove the limit-to-legacy-enctypes option
  gssd: add enctypes_list_to_string()
  gssd: get the permitted enctypes from the krb5 library on startup
  gssd: add a helper to determine the set of encryption types to pass to
    limit_krb5_enctypes()

 nfs.conf               |   1 -
 systemd/nfs.conf.man   |   2 +-
 utils/gssd/gssd.c      |  16 +--
 utils/gssd/gssd.man    |  30 +---
 utils/gssd/gssd_proc.c |  15 ++
 utils/gssd/krb5_util.c | 311 +++++++++++++++++++++++++++++++++--------
 utils/gssd/krb5_util.h |   5 +-
 7 files changed, 284 insertions(+), 96 deletions(-)

-- 
2.52.0


