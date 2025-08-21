Return-Path: <linux-nfs+bounces-13826-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D82B2F64E
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 13:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3B616EB1F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 11:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D330EF90;
	Thu, 21 Aug 2025 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7oJ9a1Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0C30EF8B
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774945; cv=none; b=OO/4W9RcZe7o5y+rotVT3slqdLz2oeqxOGoKH8tyj2XWgW/Nz6OdqoWEldH4vRBpgHd9aETA+c8WgNJZBaM/OMNMWY0jPDXTCCNxe5uv1fBNe9EtngFRIZq1rj3MXZA3FjPHQM2Ha7sQb176DaXPLFj95blKY0BdpjZeJaHBdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774945; c=relaxed/simple;
	bh=O1YAWCufhvLsd1kKEhBu4ul/+DBsqtVet1qk1D/mGUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyBc2hy93kDVrEZ/D+hjpHltcLBhwQkkXWlojPLCh+gsaRlqX2W00BR4i02FPPMOZln4NzV82s+VykiGZoXHh7GcJ2uDZpSZJ7Xgl3PGTh2KAnc7BL11p+iTjCdhSVUyOvL1w/YPAwNDwYpEJOJU4P15WIWK4VAyGBG//E2tLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7oJ9a1Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755774943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeAn+9dsAskv/ByqKxP9oUsqrPEtN3XawiNrbtKaNHs=;
	b=N7oJ9a1ZjIsY+ufA/xgys7cpYRH4Q4yvGcCuHXuoDarsd1FPIwS8ye7S+Sv0tB6ASNfg4A
	s67elSh/gWHDOS6i3lujNf7jB63OpLM54Hb4XKAAq2TAq/X20LsGI+/xWF7kOnSHA+vKXz
	po73rFSIt+hWiNzhui6hy/M4GfIn8uA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-oW646dOUOKCp75rNLng3Sg-1; Thu,
 21 Aug 2025 07:15:40 -0400
X-MC-Unique: oW646dOUOKCp75rNLng3Sg-1
X-Mimecast-MFC-AGG-ID: oW646dOUOKCp75rNLng3Sg_1755774939
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 172B419541AF;
	Thu, 21 Aug 2025 11:15:39 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.22.80.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DAD61955F24;
	Thu, 21 Aug 2025 11:15:38 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Libtirpc-devel Mailing List <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 11/12] Convert old-style function definitions into modern-style definitions
Date: Thu, 21 Aug 2025 07:15:22 -0400
Message-ID: <20250821111524.1379577-12-steved@redhat.com>
In-Reply-To: <20250821111524.1379577-1-steved@redhat.com>
References: <20250821111524.1379577-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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


