Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1D6CB45C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Mar 2023 04:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjC1CxI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Mar 2023 22:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjC1CxH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Mar 2023 22:53:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7D51FF0
        for <linux-nfs@vger.kernel.org>; Mon, 27 Mar 2023 19:53:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1721C1FD6A;
        Tue, 28 Mar 2023 02:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679971985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1eNZOzjtx2l9dFrbZ6TzlJEzuvxBpdSKMOkg8I/uaqE=;
        b=VhFiiUi3LJJ7Ep7ZZvQYQCTMCBip0yXlRxtcNggTP1+LhqlDnyBALlXRqMrM7SLsaryaGp
        hXeMXYXBWbym1b/A2ad/zOXtZJlc5RajP79ipzpJS/5DfbTBDmmB2RrsA8u2sTMuYJxSKy
        MKa2kPxU9doK2L9UZAA0oyY8ZuM7YT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679971985;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1eNZOzjtx2l9dFrbZ6TzlJEzuvxBpdSKMOkg8I/uaqE=;
        b=tCvMbdV3ytE9wdp4Ng5pCQe3MSNtZla5E/malr584wEywRg2nHfHkr2VO6WCR9kmfN1Bfw
        Jor0sB2Q7mlOvNCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFF22133B6;
        Tue, 28 Mar 2023 02:53:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nF9lJY9WImSHJgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 28 Mar 2023 02:53:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH nfs-utils] mount.nfs: always include mountpoint or spec if
 error messages.
Date:   Tue, 28 Mar 2023 13:53:00 +1100
Message-id: <167997198028.8106.1574926503489095936@noble.neil.brown.name>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


If you try to mount from a server that is inaccessible you might get an
error like:
    mount.nfs: No route to host

This is OK when running "mount" interactively, but hardly useful when
found in system logs.

This patch changes mount_error() to always included at least one of
mount_point and spec in any error message.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/mount/error.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/utils/mount/error.c b/utils/mount/error.c
index 73295bf0567c..9ddbcc096f72 100644
--- a/utils/mount/error.c
+++ b/utils/mount/error.c
@@ -207,16 +207,17 @@ void mount_error(const char *spec, const char *mount_po=
int, int error)
 				progname, spec);
 		break;
 	case EINVAL:
-		nfs_error(_("%s: an incorrect mount option was specified"), progname);
+		nfs_error(_("%s: an incorrect mount option was specified for %s"),
+				progname, mount_point);
 		break;
 	case EOPNOTSUPP:
-		nfs_error(_("%s: requested NFS version or transport protocol is not suppor=
ted"),
-				progname);
+		nfs_error(_("%s: requested NFS version or transport protocol is not suppor=
ted for %s"),
+				progname, mount_point);
 		break;
 	case ENOTDIR:
 		if (spec)
-			nfs_error(_("%s: mount spec %s or point %s is not a "
-				  "directory"),	progname, spec, mount_point);
+			nfs_error(_("%s: mount spec %s or point %s is not a directory"),
+				  progname, spec, mount_point);
 		else
 			nfs_error(_("%s: mount point %s is not a directory"),
 				  progname, mount_point);
@@ -227,31 +228,31 @@ void mount_error(const char *spec, const char *mount_po=
int, int error)
 		break;
 	case ENOENT:
 		if (spec)
-			nfs_error(_("%s: mounting %s failed, "
-				"reason given by server: %s"),
-				progname, spec, strerror(error));
+			nfs_error(_("%s: mounting %s failed, reason given by server: %s"),
+				  progname, spec, strerror(error));
 		else
 			nfs_error(_("%s: mount point %s does not exist"),
-				progname, mount_point);
+				  progname, mount_point);
 		break;
 	case ESPIPE:
 		rpc_mount_errors((char *)spec, 0, 0);
 		break;
 	case EIO:
-		nfs_error(_("%s: mount system call failed"), progname);
+		nfs_error(_("%s: mount system call failed for %s"),
+			  progname, mount_point);
 		break;
 	case EFAULT:
-		nfs_error(_("%s: encountered unexpected error condition."),
-				progname);
+		nfs_error(_("%s: encountered unexpected error condition for %s."),
+			  progname, mount_point);
 		nfs_error(_("%s: please report the error to" PACKAGE_BUGREPORT),
-				progname);
+			  progname);
 		break;
 	case EALREADY:
 		/* Error message has already been provided */
 		break;
 	default:
-		nfs_error(_("%s: %s"),
-			progname, strerror(error));
+		nfs_error(_("%s: %s for %s on %s"),
+			  progname, strerror(error), spec, mount_point);
 	}
 }
=20
--=20
2.40.0

