Return-Path: <linux-nfs+bounces-9121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C8A0A155
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jan 2025 07:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC32188DFEE
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jan 2025 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936E115383D;
	Sat, 11 Jan 2025 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaldon.com header.i=@kaldon.com header.b="sS86REDG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx1.lenistech.com (dsl-209-55-111-169.centex.net [209.55.111.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24BBA4A
	for <linux-nfs@vger.kernel.org>; Sat, 11 Jan 2025 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.55.111.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736577641; cv=none; b=F94jFkl6eyt/XOq/qn/fL+YxZ1yWbFIkUX+SeKseLRDgrDY5lQE0WvGvmyraIq71A2z8GDPQ1p6b8z8EMJgE0L1aSCmatswWGUb3HjMth1d4bssi3jmpclsVep7oR4liI3D6CddDveisObXOgDA0FPG8G2rwBupilK6d5PdsFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736577641; c=relaxed/simple;
	bh=pwhDF5RxiX26ZXjoP2anjxWU0/0UGmkVGDJVLJolrb4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ECRzdhyU7P8Ud9n/eAl/teNPFo7B7m6qQaKbT5wwXd1D/2PJTkTUGbCwA9+9+VkkISv8AETjSqx5I4EonY//tmQ4sM0wuC7hw6LgRGarEVVwc9sLe8OGoJloExLzcYeuqjGE8DIMMRgv10QMVF8ZXgr/qZVgHgFIWNAxXlhWydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaldon.com; spf=pass smtp.mailfrom=kaldon.com; dkim=pass (2048-bit key) header.d=kaldon.com header.i=@kaldon.com header.b=sS86REDG; arc=none smtp.client-ip=209.55.111.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaldon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaldon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaldon.com; s=mail;
	t=1736577062; bh=ngtrH4IbVqfuUM+0kgZQ34rvqpu/YMiewVn0INFBD+g=;
	h=From:To:Subject:Date:From;
	b=sS86REDGNgFcBR5gzvBtpdcsWncT4W6WYxglgW01rSRdW/MyhgxKFjXGkneQuYGRF
	 hBcaD3fp4eDjlM7bP72KRGjQxYtiI5SMiTiPZjMC7o9m9h/aQG7+iWZ9v5rpNQhuxN
	 5EzLICWK8ZlDAFf5Gfxzmbh586hupwrIxq6ImgRzYWnXUMBB4Ni9vDFhY+Sy3GIKEW
	 mMsudzWauD6OJFQRPZqT91pDKYn4TONXVhfWTjGZjG21/Zu0HzIleFOP0G5SbouG1k
	 tbmR+VWdgNF0hJD+bYdNxpJeBS6qFph018GQuUSxOpoi503ot3P7mSK0HAIvPBRu7P
	 +R74c379n27Vg==
Received: from k6-kdc1.. (_gateway [192.168.1.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.lenistech.com (Postfix) with ESMTPSA id 0D8FC4D00033
	for <linux-nfs@vger.kernel.org>; Sat, 11 Jan 2025 00:31:01 -0600 (CST)
From: Joshua Kaldon <joshua@kaldon.com>
To: linux-nfs@vger.kernel.org
Subject: Patch for broken libnfsimapd static and regex plugins. It appears that the makefile does not add nfsidmap_common.c in the sources. . nfs-utils (1:2.8.2-1.1~0.1) UNRELEASED; urgency=medium . * Non-maintainer upload. * Fix issue with static and regex plugins missing symbol get_grnam_buflen.
Date: Sat, 11 Jan 2025 00:30:59 -0600
Message-ID: <20250111063059.69381-1-joshua@kaldon.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Description: Fix static and regex libnfsimapd plugins referencing symbol get_grnam_buflen.
Author: Joshua Kaldon <joshua@kaldon.com>
Content-Transfer-Encoding: 8bit

---
The information above should follow the Patch Tagging Guidelines, please
checkout https://dep.debian.net/deps/dep3/ to learn about the format. Here
are templates for supplementary fields that you might want to add:

Origin: (upstream|backport|vendor|other), (<patch-url>|commit:<commit-id>)
Bug: <upstream-bugtracker-url>
Bug-Debian: https://bugs.debian.org/<bugnumber>
Bug-Ubuntu: https://launchpad.net/bugs/<bugnumber>
Forwarded: (no|not-needed|<patch-forwarded-url>)
Applied-Upstream: <version>, (<commit-url>|commit:<commid-id>)
Reviewed-By: <name and email of someone who approved/reviewed the patch>
Last-Update: 2025-01-11

--- nfs-utils-2.8.2.orig/support/nfsidmap/Makefile.am
+++ nfs-utils-2.8.2/support/nfsidmap/Makefile.am
@@ -40,15 +40,15 @@ nsswitch_la_SOURCES = nss.c nfsidmap_com
 nsswitch_la_LDFLAGS = -module -avoid-version
 nsswitch_la_LIBADD = ../../support/nfs/libnfsconf.la
 
-static_la_SOURCES = static.c
+static_la_SOURCES = static.c nfsidmap_common.c
 static_la_LDFLAGS = -module -avoid-version
 static_la_LIBADD = ../../support/nfs/libnfsconf.la
 
-regex_la_SOURCES = regex.c
+regex_la_SOURCES = regex.c nfsidmap_common.c
 regex_la_LDFLAGS = -module -avoid-version
 regex_la_LIBADD = ../../support/nfs/libnfsconf.la
 
-umich_ldap_la_SOURCES = umich_ldap.c
+umich_ldap_la_SOURCES = umich_ldap.c nfsidmap_common.c
 umich_ldap_la_LDFLAGS = -module -avoid-version
 umich_ldap_la_LIBADD = -lldap $(KRB5_GSS_LIB) ../../support/nfs/libnfsconf.la
 

