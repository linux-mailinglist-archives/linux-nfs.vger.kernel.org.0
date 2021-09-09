Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA97C404520
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Sep 2021 07:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350863AbhIIFoV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Sep 2021 01:44:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34396 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350838AbhIIFoT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Sep 2021 01:44:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 06E58201A7;
        Thu,  9 Sep 2021 05:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631166190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reJRJoTtGBrdy2xrV5Q3+NziIUzCA4EQboTh9IQRFao=;
        b=gAaviq446DiFinmIuK9IyirCkK6mc/28d6FOGzFvEj5KI44bMyJvBhoa2989Aix9Nq6w4P
        rE4WP5UiprUvkRSrpfodfquqA0Pg1g342GIwo++SRNxX5OzAkfTjmfBT7GBl+ciivNngeM
        XyBzzoPfTdHWiaH+5USMpUKKZx15TnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631166190;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reJRJoTtGBrdy2xrV5Q3+NziIUzCA4EQboTh9IQRFao=;
        b=+HfnsZyDd7PREgnBLrif6AEfoPA5tAK8Y83g965wkDzds22SRWLE0x1H7FpceIA4s90qNJ
        BQlRatWoW/SJRHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD3D913A60;
        Thu,  9 Sep 2021 05:43:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xuJ/HeyeOWH9cwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 09 Sep 2021 05:43:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Steve Dickson" <steved@redhat.com>
Cc:     "Linux NFS Mailing list" <linux-nfs@vger.kernel.org>
Subject: [PATCH] gssd: fix crash in debug message.
In-reply-to: <627209c3-21dd-312e-c2dc-cc810108f7d1@redhat.com>
References: <20210610150825.396565-1-steved@redhat.com>,
 <627209c3-21dd-312e-c2dc-cc810108f7d1@redhat.com>
Date:   Thu, 09 Sep 2021 15:43:05 +1000
Message-id: <163116618506.12570.5744024691858636230@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


A recent cleanup of debug messages added func and tid format specifiers
to a debug message (when full hostname was different), but the func name
and tid were NOT added as arguments.

Consequently there weren't enough args, random bytes of the stack were
interpreted as a pointer, and rpc.gssd crashed (when -v was specified).

Fixes: b538862a5135 ("gssd: Cleaned up debug messages")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/gssd/krb5_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/gssd/krb5_util.c b/utils/gssd/krb5_util.c
index 6d059f332881..e3f270e948ac 100644
--- a/utils/gssd/krb5_util.c
+++ b/utils/gssd/krb5_util.c
@@ -673,8 +673,8 @@ get_full_hostname(const char *inhost, char *outhost, int =
outhostlen)
 	    *c =3D tolower(*c);
=20
 	if (get_verbosity() && strcmp(inhost, outhost))
-		printerr(1, "%s(0x%0lx): inhost '%s' different than outhost'%s'\n",=20
-			inhost, outhost);
+		printerr(1, "%s(0x%0lx): inhost '%s' different than outhost '%s'\n",=20
+			 __func__, tid, inhost, outhost);
=20
 	retval =3D 0;
 out:
--=20
2.33.0

