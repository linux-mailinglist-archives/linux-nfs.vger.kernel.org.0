Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48C91EF27D
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2020 09:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFEHxj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Jun 2020 03:53:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgFEHxj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 5 Jun 2020 03:53:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0500EADBB;
        Fri,  5 Jun 2020 07:53:41 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Steve Dickson <SteveD@RedHat.com>
Subject: [rpcbind 1/1] man/rpcbind: Mention systemd socket in -h
Date:   Fri,  5 Jun 2020 09:53:32 +0200
Message-Id: <20200605075332.14564-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

and reformat doc a bit.

Based on Olaf Kirch's patch for openSUSE.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Steve,

original patch:
https://build.opensuse.org/package/view_file/openSUSE:Factory/rpcbind/0031-rpcbind-manpage.patch?expand=1

Olaf removed note about multi-homed host and about adding 127.0.0.1 an
::1. I kept them, but maybe multi-homed is not relevant any more or not
limited only to UDP. Feel free to modify the text to better accommodate
to current usage.

Kind regards,
Petr

 man/rpcbind.8 | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/man/rpcbind.8 b/man/rpcbind.8
index af6200f..fbf0ace 100644
--- a/man/rpcbind.8
+++ b/man/rpcbind.8
@@ -86,9 +86,16 @@ checks are shown in detail.
 Do not fork and become a background process.
 .It Fl h
 Specify specific IP addresses to bind to for UDP requests.
-This option
-may be specified multiple times and is typically necessary when running
-on a multi-homed host.
+This option may be specified multiple times and can be used to
+restrict the interfaces rpcbind will respond to.
+When specifying IP addresses with
+.Fl h ,
+.Nm
+will automatically add
+.Li 127.0.0.1
+and if IPv6 is enabled,
+.Li ::1
+to the list.
 If no
 .Fl h
 option is specified,
@@ -99,14 +106,19 @@ which could lead to problems on a multi-homed host due to
 .Nm
 returning a UDP packet from a different IP address than it was
 sent to.
-Note that when specifying IP addresses with
-.Fl h ,
+Note that when
 .Nm
-will automatically add
-.Li 127.0.0.1
-and if IPv6 is enabled,
-.Li ::1
-to the list.
+is controlled via systemd's socket activation,
+the
+.Fl h
+option is ignored. In this case, you need to edit
+the
+.Nm ListenStream
+and
+.Nm ListenDgram
+definitions in
+.Nm /usr/lib/systemd/system/rpcbind.socket
+instead.
 .It Fl i
 .Dq Insecure
 mode.
-- 
2.26.2

