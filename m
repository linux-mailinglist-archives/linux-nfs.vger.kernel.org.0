Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C553F171A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Aug 2021 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhHSKJR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Aug 2021 06:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238305AbhHSKJL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Aug 2021 06:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629367714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=q2K2cTYVy33zVtmhYGoAwNjBf9UfAFMwAF+Kp8WWFj0=;
        b=hGJ6NRRURHx3XDPRUntIsMzMC7C33a2ttAfcdZuNs4N/iEhifyGTnPTUHnVlYcA4Q2ya8D
        L2SwR+Z8yo6dVKA9PrvaIbmIGv5mJOLfMEqPzPNLQBRRsvLR3pLyeN8P/QmA9uxLKBotn9
        fsPh5tSYJNQF11PGVxKRRA2A0ipAkCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-aveKyE6AO2mDcW-vRl1Wng-1; Thu, 19 Aug 2021 06:08:33 -0400
X-MC-Unique: aveKyE6AO2mDcW-vRl1Wng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65FD4801AC5;
        Thu, 19 Aug 2021 10:08:32 +0000 (UTC)
Received: from localhost (ibm-x3250m4-06.rhts.eng.pek2.redhat.com [10.73.4.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAB2B18432;
        Thu, 19 Aug 2021 10:08:31 +0000 (UTC)
From:   Jianhong Yin <jiyin@redhat.com>
To:     linux-nfs@vger.kernel.org, steved@redhat.com
Cc:     Jianhong Yin <jiyin@redhat.com>,
        Jianhong Yin <yin-jianhong@163.com>
Subject: [PATCH] nfs-utils: add install-dep for installing all dependencies
Date:   Thu, 19 Aug 2021 18:08:29 +0800
Message-Id: <20210819100829.28647-1-jiyin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

whenever user want to compile and install from source code, they
have to constantly install dependencies based on error message.
I'm fed up

verified on RHEL-8/Fedora-34/debian-10/openSUSE-15.3

Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
---
 install-dep | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 install-dep

diff --git a/install-dep b/install-dep
new file mode 100755
index 00000000..621618fe
--- /dev/null
+++ b/install-dep
@@ -0,0 +1,21 @@
+#!/bin/bash
+#install dependencies for compiling from source code
+
+#RHEL/Fedora/CentOS-Stream/Rocky
+which dnf &>/dev/null || which yum &>/dev/null && {
+	yum install -y automake libtool make gcc rpcgen libtirpc-devel libevent-devel sqlite-devel device-mapper-devel \
+		libblkid-devel krb5-devel libuuid-devel
+}
+
+#Debian/ubuntu
+which apt &>/dev/null && {
+	apt install -o APT::Install-Suggests=0 -o APT::Install-Recommends=0 --ignore-missing -y \
+		autotools-dev automake make libtool pkg-config libtirpc-dev libevent-dev libsqlite3-dev \
+		libdevmapper-dev libblkid-dev libkrb5-dev libkeyutils-dev uuid-dev
+}
+
+#openSUSE Leap
+which zypper &>/dev/null && {
+	zypper in --no-recommends -y automake libtool make gcc rpcgen libtirpc-devel libevent-devel sqlite-devel \
+		device-mapper-devel libblkid-devel krb5-devel libuuid-devel
+}
-- 
2.18.1

