Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94C411828
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Sep 2021 17:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhITP0q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Sep 2021 11:26:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44582 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhITP0q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Sep 2021 11:26:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D15122015;
        Mon, 20 Sep 2021 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632151519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+t1tctzQR47NQ9v0ltgV78hzmtN6kDQ5K09vPk4yyeI=;
        b=Kf0Wf+HaTkkVpmaSoXHu2gpMLIyQaQkvv9hoczKU1Hl9o/YKZq2cyk2VNnc9qP66udkUys
        YAG7+QLT7tVF8xJXhlAHLt0pR3rGK+OL6xfGTb/8+v2TVOgh2Cso5Poaq0CGrLOsdPuXkX
        BxXe90KHNxfq2vzHp63ONPl7bzw1pgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632151519;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+t1tctzQR47NQ9v0ltgV78hzmtN6kDQ5K09vPk4yyeI=;
        b=dhbOQTXbhgqrjCkuhz64OYwJR3JXTOShE/+/X7PMEkT+00F7boHXhFfdIYQUOJaRMSkxHL
        PBjT7SYybqdnRQCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C705913AED;
        Mon, 20 Sep 2021 15:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6rPlLd6nSGGrIgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 20 Sep 2021 15:25:18 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Steve Dickson <steved@redhat.com>,
        Jianhong Yin <yin-jianhong@163.com>
Subject: [PATCH 1/1] install-dep: Use command -v instead of which
Date:   Mon, 20 Sep 2021 17:25:05 +0200
Message-Id: <20210920152505.9423-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

`command -v' is shell builtin required by POSIX [1] and supported on all
common shells (bash, zsh, dash, busybox sh, mksh). `which' utility is not
presented on some containers (e.g. Fedora, openSUSE), also going to be
removed from future Debian versions.

Also remove stderr redirection to /dev/null as it's unnecessary when
using 'command': POSIX says "no output shall be written" if the command
isn't found.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html
[2] https://salsa.debian.org/debian/debianutils/-/commit/3a8dd10b4502f7bae8fc6973c13ce23fc9da7efb

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 install-dep | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/install-dep b/install-dep
index 621618fe..4698d44a 100755
--- a/install-dep
+++ b/install-dep
@@ -2,20 +2,20 @@
 #install dependencies for compiling from source code
 
 #RHEL/Fedora/CentOS-Stream/Rocky
-which dnf &>/dev/null || which yum &>/dev/null && {
+command -v dnf >/dev/null || command -v yum >/dev/null && {
 	yum install -y automake libtool make gcc rpcgen libtirpc-devel libevent-devel sqlite-devel device-mapper-devel \
 		libblkid-devel krb5-devel libuuid-devel
 }
 
 #Debian/ubuntu
-which apt &>/dev/null && {
+command -v apt >/dev/null && {
 	apt install -o APT::Install-Suggests=0 -o APT::Install-Recommends=0 --ignore-missing -y \
 		autotools-dev automake make libtool pkg-config libtirpc-dev libevent-dev libsqlite3-dev \
 		libdevmapper-dev libblkid-dev libkrb5-dev libkeyutils-dev uuid-dev
 }
 
 #openSUSE Leap
-which zypper &>/dev/null && {
+command -v zypper >/dev/null && {
 	zypper in --no-recommends -y automake libtool make gcc rpcgen libtirpc-devel libevent-devel sqlite-devel \
 		device-mapper-devel libblkid-devel krb5-devel libuuid-devel
 }
-- 
2.33.0

