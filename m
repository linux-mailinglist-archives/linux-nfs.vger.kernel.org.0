Return-Path: <linux-nfs+bounces-13734-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C9CB2AC3C
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 17:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860771745F1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1FB24A078;
	Mon, 18 Aug 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJ/cUm8M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B224C669
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529731; cv=none; b=LSBNo+4SIBKSSaFBhV1JVgoJic8WwWvhectNAx+4uSja3WDtCWmpjaZLZ0exczgWUZmvLY5EFByirYIQBtjGAjhs2GHHt+EB0kbPm8srj88RNCtS391XpDOz/mhWDs+8+qyTZghatmXdkpaBZgeauByjybi/0+9gEiDbX6p9KxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529731; c=relaxed/simple;
	bh=O1YAWCufhvLsd1kKEhBu4ul/+DBsqtVet1qk1D/mGUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdY1b8fVccQ2yYp5hd9nvgpkRt4CLjh1TVLeo6Tpwjd3zGFonbFSdvPQK+0+FFqprJJ3Exj1ipPpyMQR+s/upQ1zJ9yFSwZucSHjBK80Dc65HcYmxtcWOmUloZDg9KlaeFklgmuv8ZH9OgHXtp0UKlPJ9N8X/MKfY5TgeLfZ6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJ/cUm8M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755529729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeAn+9dsAskv/ByqKxP9oUsqrPEtN3XawiNrbtKaNHs=;
	b=WJ/cUm8MR9MvyVTDAkJ0OWxbPe7bnopH25po0zDuaS5BeWTLALfeOMBOISj++aHXKyFmqX
	dBUaWkNbWE4ooxqcaT9xF6iLG304pcGqx0SFNzHrGyt/eq4aGCMnC5EQMM42PlnkaG9rM3
	bux7R8jD/plfcWSKiUpXOcsYry2J1p0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-zGONRgKYNIuVnWCFev-wEA-1; Mon,
 18 Aug 2025 11:08:45 -0400
X-MC-Unique: zGONRgKYNIuVnWCFev-wEA-1
X-Mimecast-MFC-AGG-ID: zGONRgKYNIuVnWCFev-wEA_1755529724
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5A9F19775AD;
	Mon, 18 Aug 2025 15:08:44 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.64.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D21030001A8;
	Mon, 18 Aug 2025 15:08:43 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 11/12] Convert old-style function definitions into modern-style definitions
Date: Mon, 18 Aug 2025 11:08:28 -0400
Message-ID: <20250818150829.1044948-12-steved@redhat.com>
In-Reply-To: <20250818150829.1044948-1-steved@redhat.com>
References: <20250818150829.1044948-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

With newer compilers (gcc 15.1.1) -Wold-style-definition
flag is set by default which causes warnings for
most of the functions in these files.

    warning: old-style function definition [-Wold-style-definition]

The warnings are remove by converting the old-style
function definitions into modern-style definitions

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 src/bindresvport.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/bindresvport.c b/src/bindresvport.c
index efeb1cc..7b2056d 100644
--- a/src/bindresvport.c
+++ b/src/bindresvport.c
@@ -147,9 +147,7 @@ load_blacklist (void)
 }
 
 int
-bindresvport_sa(sd, sa)
-        int sd;
-        struct sockaddr *sa;
+bindresvport_sa(int sd, struct sockaddr *sa)
 {
         int res, af;
         struct sockaddr_storage myaddr;
-- 
2.50.1


