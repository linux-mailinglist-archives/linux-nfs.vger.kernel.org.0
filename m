Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401D84A3867
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jan 2022 20:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbiA3TGV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jan 2022 14:06:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230149AbiA3TGU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jan 2022 14:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643569580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YY6AdUpgKNGuMnlJqjLN5WNaNWMkL29vA6j90xZie5Q=;
        b=MSmNLbNw9NT77grN1DN6Lezh278Hk1T0kJ7eFIqIV4WMLvcyH6Tm+SgEoISrDOO1HhUP7v
        ARkVqzzZepeqUumvHgsdMLHn5sIKKUutjTrIQWaeIi9GdYHNntZO9cd17gmxN1x+FGTRj8
        pYIVqRY+17rmw5ZygmtgehNoamoX/2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-hu_8lN4YOQKvgyoQx_yR_w-1; Sun, 30 Jan 2022 14:06:16 -0500
X-MC-Unique: hu_8lN4YOQKvgyoQx_yR_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 211E31006AA4;
        Sun, 30 Jan 2022 19:06:15 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (unknown [10.2.16.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A98860854;
        Sun, 30 Jan 2022 19:06:14 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Bill Baker <webbaker@gmail.com>,
        Calum Mackay <calum.mackay@oracle.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 3/5] systemd: rename service file.
Date:   Sun, 30 Jan 2022 14:06:09 -0500
Message-Id: <20220130190611.12292-4-steved@redhat.com>
In-Reply-To: <20220130190611.12292-1-steved@redhat.com>
References: <20220130190611.12292-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The precedence has been set that most
systemd service files are named after
the daemon they start.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 buildrpm/1.3/fdr.spec       | 10 +++++-----
 fdrd.man                    |  2 +-
 fdr.service => fdrd.service |  0
 3 files changed, 6 insertions(+), 6 deletions(-)
 rename fdr.service => fdrd.service (100%)

diff --git a/buildrpm/1.3/fdr.spec b/buildrpm/1.3/fdr.spec
index 3484659..226db33 100644
--- a/buildrpm/1.3/fdr.spec
+++ b/buildrpm/1.3/fdr.spec
@@ -34,23 +34,23 @@ mkdir -p %{buildroot}%{_sysconfdir}/logrotate.d
 install -m 644 samples/nfs.logrotate %{buildroot}/%{_sysconfdir}/logrotate.d/nfs
 
 mkdir -p %{buildroot}/%{_unitdir}
-install -m 644 %{name}.service %{buildroot}/%{_unitdir}/%{name}.service
+install -m 644 %{name}d.service %{buildroot}/%{_unitdir}/%{name}d.service
 
 mkdir -p %{buildroot}/%{_mandir}/man8
 install -m 644 fdrd.man %{buildroot}/%{_mandir}/man8/fdrd.8
 
 %post
-%systemd_post %{name}.service
+%systemd_post %{name}d.service
 
 %preun
-%systemd_preun %{name}.service
+%systemd_preun %{name}d.service
 
 %postun
-%systemd_postun_with_restart %{name}.service
+%systemd_postun_with_restart %{name}d.service
 
 %files
 %{_sbindir}/fdrd
-%{_unitdir}/fdr.service
+%{_unitdir}/fdrd.service
 %{_datadir}/fdr/samples/nfs
 %{_sysconfdir}/logrotate.d/nfs
 %{_mandir}/man8/*
diff --git a/fdrd.man b/fdrd.man
index d5199f0..99f7f80 100644
--- a/fdrd.man
+++ b/fdrd.man
@@ -27,7 +27,7 @@ available.  Error messages from fdr can be viewed via systemctl,
 for example,
 .P
 .B
-systemctl status -l fdr
+systemctl status -l fdrd
 .SH Configuration File Syntax
 
 The following keywords and options are recognized
diff --git a/fdr.service b/fdrd.service
similarity index 100%
rename from fdr.service
rename to fdrd.service
-- 
2.34.1

