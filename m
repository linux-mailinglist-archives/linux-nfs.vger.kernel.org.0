Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FA24A3863
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jan 2022 20:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiA3TGS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jan 2022 14:06:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230314AbiA3TGR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jan 2022 14:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643569577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wXhWNf7j+L6/IxO+gWcXJ96c2y1FtcmScAaju6ghXU=;
        b=X/KmQbDaAiZg+vhxz9Qy3cs1KfH0LMMq7/eS2gzkEFYP6HvZMQmNZKiBS9d2rP/wobZHFd
        iAlENlF9JCevnTfMgBQKvXV1mH2MmmwCRDvD32uxjfN7jIopujAz7n0eEOS3n9/COlJX1c
        QSuD2/q7rWGmF/J/2acDbBYwCsSFBVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-vliZBTTZNzywjjfbYGKTkg-1; Sun, 30 Jan 2022 14:06:15 -0500
X-MC-Unique: vliZBTTZNzywjjfbYGKTkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F7EC801B04;
        Sun, 30 Jan 2022 19:06:14 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (unknown [10.2.16.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E84EA60854;
        Sun, 30 Jan 2022 19:06:13 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Bill Baker <webbaker@gmail.com>,
        Calum Mackay <calum.mackay@oracle.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/5] fdr.spec: logrotate clean up
Date:   Sun, 30 Jan 2022 14:06:08 -0500
Message-Id: <20220130190611.12292-3-steved@redhat.com>
In-Reply-To: <20220130190611.12292-1-steved@redhat.com>
References: <20220130190611.12292-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add an requirement for logrotate to be
install and put the nfs.logrotate into
its proper place.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 buildrpm/1.3/fdr.spec | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/buildrpm/1.3/fdr.spec b/buildrpm/1.3/fdr.spec
index 40dedc9..3484659 100644
--- a/buildrpm/1.3/fdr.spec
+++ b/buildrpm/1.3/fdr.spec
@@ -2,7 +2,7 @@ Summary:	A daemon which enables ftrace probes and harvests the data
 Name:		fdr
 URL:		https://github.com/oracle/fdr.git
 Version:	1.3
-Release:	2%{?dist}
+Release:	3%{?dist}
 License:	UPL
 Source0:	http://people.redhat.com/steved/fdr/%{name}-%{version}.tar.xz
 
@@ -10,7 +10,7 @@ BuildRequires:	gcc
 BuildRequires:	make
 BuildRequires:	sed
 BuildRequires:	systemd-rpm-macros
-Requires:	systemd
+Requires:	systemd logrotate
 
 %description
 The flight data recorder, a daemon which enables ftrace probes
@@ -30,7 +30,8 @@ install -m 755 fdrd %{buildroot}/%{_sbindir}
 
 mkdir -p %{buildroot}%{_datadir}/fdr/samples
 install -m 644 samples/nfs %{buildroot}/%{_datadir}/fdr/samples
-install -m 644 samples/nfs.logrotate %{buildroot}/%{_datadir}/fdr/samples
+mkdir -p %{buildroot}%{_sysconfdir}/logrotate.d
+install -m 644 samples/nfs.logrotate %{buildroot}/%{_sysconfdir}/logrotate.d/nfs
 
 mkdir -p %{buildroot}/%{_unitdir}
 install -m 644 %{name}.service %{buildroot}/%{_unitdir}/%{name}.service
@@ -51,7 +52,7 @@ install -m 644 fdrd.man %{buildroot}/%{_mandir}/man8/fdrd.8
 %{_sbindir}/fdrd
 %{_unitdir}/fdr.service
 %{_datadir}/fdr/samples/nfs
-%{_datadir}/fdr/samples/nfs.logrotate
+%{_sysconfdir}/logrotate.d/nfs
 %{_mandir}/man8/*
 %doc README.md
 %license LICENSE
-- 
2.34.1

