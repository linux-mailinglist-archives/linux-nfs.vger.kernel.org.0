Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3595D1E1
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2019 16:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGBOiQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Jul 2019 10:38:16 -0400
Received: from mout.web.de ([212.227.15.4]:60847 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBOiQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Jul 2019 10:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562078287;
        bh=VZgBdrPz7iyT2BI7dRTkIcU0vHIjrz18B/yA5Rx7YfE=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=F9KLW53I+BPFl6QK7cCXY1KQgbDBvMwD7sPsvKbDB2oCzKw/a4ZDBvahbyga35/Oz
         7e0c36dfLTlmFq3pSr38b5tp4G9sNdtJipgEwkuv9LywEWQoyhhyPd5wRE9TGHrSTX
         1M62VxOHfShBk+AMOIXSyvOLrFHN+ytpvhwIHsD4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.11.114]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LeLin-1iKeUE3AB3-00qCKg; Tue, 02
 Jul 2019 16:38:07 +0200
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] NFS: Less function calls in show_pnfs()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d2f73c3e-a55f-5fb7-a8f8-0dc3ce8ff8a5@web.de>
Date:   Tue, 2 Jul 2019 16:38:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qtYYpDbfNq00EDB2mdsGukdYUQlX9X6ssGB67C+Ss5cfgTBeDMA
 xC5s2kx2LQ/tbiOAo/igJX46CVvpWSRlO3+L7MtVirNsMiSeH4m98GpFpoLE5QITUC15GNA
 uESoNKu1w5ENu+QctOiFXMONeXvuOXf1FVlpQ+qgBm4tffnAWgK61Pw8xoo6Ei4CF7kKnvv
 9tJFxp4crNyLiwLgE/VvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kBwDXq2k16A=:rG0Mr+djguU9qMUriqyhNp
 24Q33yMZJeqpqxK2Y+aYU6nWwcA6TcH16N8U7lmGS7jdHHFckdjA+Jlt71MxQnmzxPhtuzj8h
 bkA+uKrh6XpuHYiG8L5vd+/JByQ0+YZicF3USypumfC5HbIIHxK2PyY6ETaFnuwxsPJh6R11P
 uJvJT/psgti8UDWWl18fTAZeuq3agmDx3wGPJSyAHsqtaKQeJNBf8ttZbchQ88gw2EjGzw+2l
 9Ku6zErKBrao6JAOs+4/MSDaJsxsx4pb4JXRPW8kjkry4ihRqfIiEGcPPSu6RxbpA0MupvRKg
 qUVLBSlY6hvdCyt4OmzswFwzFSdnMn0v1le642Ptvf9CYS88nKuh71rMZo4C2OGfnCS7ksPN0
 xgAb7JCmA2PJwXXnYyRmlMj3y9AnBqI97UbB8cjyW219epFO8qkgnDTQEU8QWRZ4GHupULGxP
 HhDW+HQN6wwRSfISlJP62bLQOcoHaGbETLLCoHZxS6GaxmrzMVpUFFGFuIclj1ezOEEy66JuD
 xazhtyGgPlqrziSe3RRS/3YNnRh5Q9uC1Az+g/IzBfxN1QcArjCT3aYTrAOe4yGChqWzVfdpz
 hO434ABsJOuPw7rfwXbHE8XM00U1/uywKvwXH6ZSp5u3KI2LlNwruVW+na7dydAoeEO/fs9CZ
 aQQRyd/EHgE4IzVmdZH/QQ3vU3j0tgx9lxmN4lXamCX7rJRnI6/RxB9O+9t936rWLCp+kH119
 9mWsQhCieSdf/09dXF52LJi7y2RtQ1KcYIZ/XBDQQiLe0mCw+aNAF4hU06QArpgMVxqytAoxE
 gmvQpoPZEt9HpzqS4ILHYcQ6i6sspNJz23BSrv+Na465LCDiq8php3nMTvsBtGbTB1xyR/ZVt
 ujMTLao2XGGbIpVzm4Y5vZeXQevhlMhqY8BOP5UePaGKvpJGPsZjlDZApzy24gyZtApreHLHx
 M6jvkkznWnyZSlI5IabhlIwj+aiBVmHx+h0eyy54Dy3oy/g4/Pm/H0cX2s7SuY+k0WUUYcOIU
 j3Q+VMMvhwTGzUB5fNHOvcsE5MxtagC2gIV9TzCOguAXPO5HEJkwsxseF0r4Iv2q/lSH1tqc2
 3XPCPuXZNuSf9I9uH95cRQ/MY46ut9Jh1kL
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jul 2019 16:30:53 +0200

Reduce function calls for data output into a sequence.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfs/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index f88ddac2dcdf..c301cd585b3b 100644
=2D-- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -749,11 +749,10 @@ static void show_sessions(struct seq_file *m, struct=
 nfs_server *server) {}
 #ifdef CONFIG_NFS_V4_1
 static void show_pnfs(struct seq_file *m, struct nfs_server *server)
 {
-	seq_printf(m, ",pnfs=3D");
-	if (server->pnfs_curr_ld)
-		seq_printf(m, "%s", server->pnfs_curr_ld->name);
-	else
-		seq_printf(m, "not configured");
+	seq_printf(m, ",pnfs=3D%s",
+		   server->pnfs_curr_ld
+		   ? server->pnfs_curr_ld->name
+		   : "not configured");
 }

 static void show_implementation_id(struct seq_file *m, struct nfs_server =
*nfss)
=2D-
2.22.0

