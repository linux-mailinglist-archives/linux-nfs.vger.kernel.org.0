Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354E7711E0
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2019 08:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfGWG1T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 02:27:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfGWG1T (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Jul 2019 02:27:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0027A308A9E2;
        Tue, 23 Jul 2019 06:27:19 +0000 (UTC)
Received: from localhost (dhcp-12-152.nay.redhat.com [10.66.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D2465D721;
        Tue, 23 Jul 2019 06:27:18 +0000 (UTC)
From:   Yongcheng Yang <yongcheng.yang@gmail.com>
To:     "J . Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Yongcheng Yang <yongcheng.yang@gmail.com>
Subject: [PATCH 1/2] nfs4_getfacl: return 1 for unknown option and won't use '-?' anymore
Date:   Tue, 23 Jul 2019 14:27:12 +0800
Message-Id: <20190723062713.20570-1-yongcheng.yang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 23 Jul 2019 06:27:19 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The getopt_long() function will return '?' if encounters an option
character that was not in optstring. So it's impossible to tell the
option '-?' from an unrecognized option. Don't mention it in Usage.

Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
---
 nfs4_getfacl/nfs4_getfacl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/nfs4_getfacl/nfs4_getfacl.c b/nfs4_getfacl/nfs4_getfacl.c
index 4df2b04..2f57866 100644
--- a/nfs4_getfacl/nfs4_getfacl.c
+++ b/nfs4_getfacl/nfs4_getfacl.c
@@ -88,10 +88,14 @@ int main(int argc, char **argv)
 			case 'c':
 				ignore_comment = 1;
 				break;
-			default:
+			case 'h':
 				usage(1);
 				res = 0;
 				goto out;
+			case '?':
+			default:
+				usage(0);
+				goto out;
 		}
 	}
 
@@ -131,7 +135,7 @@ static void usage(int label)
 {
 	if (label)
 		fprintf(stderr, "%s %s -- get NFSv4 file or directory access control lists.\n", execname, VERSION);
-	fprintf(stderr, "Usage: %s [-R] file ...\n  -H, --more-help\tdisplay ACL format information\n  -?, -h, --help\tdisplay this help text\n  -R --recursive\trecurse into subdirectories\n  -c, --omit-header\tDo not display the comment header (Do not print filename)\n", execname);
+	fprintf(stderr, "Usage: %s [-R] file ...\n  -H, --more-help\tdisplay ACL format information\n  -h, --help\tdisplay this help text\n  -R --recursive\trecurse into subdirectories\n  -c, --omit-header\tDo not display the comment header (Do not print filename)\n", execname);
 }
 
 static void more_help()
-- 
2.20.1

