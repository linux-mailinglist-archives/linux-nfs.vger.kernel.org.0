Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC365E778
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 17:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfGCPKG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Jul 2019 11:10:06 -0400
Received: from mout.web.de ([212.227.17.11]:39887 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGCPKG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Jul 2019 11:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562166595;
        bh=bJo7ecYfHBZx6XyeZOCJUAM2e2OjXfAvLYhz3OVKzNI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=iajFrtczQo47D3AeH6uo72TyaJO8kvQbWPUjPZwH3uMYNRfaTo7/uKjSqQliYd+Yj
         um5DSHuJm7ZVWa/5kHNNR8rSlhXNLGmiahh7By8LD72xn6iYWeoqc/nVXYWi/1ASnN
         vC4giEe3ZweOiTIoYDx6V2TGn0qM2UGpmDJpuJqw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.108]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lc8Xx-1iPkt40PDR-00ja8y; Wed, 03
 Jul 2019 17:09:55 +0200
Subject: [PATCH 2/3] NFS: Replace 16 seq_printf() calls by seq_puts()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     linux-nfs@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <cb79bcb1-0fd6-1b7f-c131-5883f09ad105@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <ae578dc9-9b5d-45e0-d616-546eb24ee084@web.de>
Date:   Wed, 3 Jul 2019 17:09:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cb79bcb1-0fd6-1b7f-c131-5883f09ad105@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xKJUu45GHRUmypWtRPFa6VdC0UJJ8HoG7MJXphaYcAN0ld9fyjl
 YOlqf3YqLpIXgPLxOk3rz5Bsnsw5FVMsgX7r9h7+x35rZjMT4nB+edheFrByihoyY2udYbh
 JCCh9qwmjBgdtqJ4igSDWWjOyj6eCdgZ9VME06GaS2eOkt/eak6vbFGfjxuWOc9LCXwU0C3
 97CgSe2xOgBdskw+YVZ/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mVyO1bLLTUc=:sEVGvAKTg+UBckLga1GPGu
 jw8V/pxNbqLRaWFkZWwnaoX+Lp1kMlqGl/RemmKntUkrP0dkk3jT78/6SS11TOkqh4AxCHS8k
 K+nHkSiJeAE77TVY6tLor1I46/yKMy2+i7D7ZhbLz7asPm+p7fOAtZm4yLSAP5wMjFde9uv8K
 GyodIIq0sIUdAJfPz5t8hbadxrk0RLvJHQTTJ5nyBoKXsCHrV0vLJeSpn01yvkejUiOAIcxJp
 IjptDDB+Qykk+DKlzrnTii3SaaH3HsAm5/e9QnIIGgmRu5f9SbwD3yXMuLoK9jOo++yz1GkF3
 yhzWg7CGw3sDZ/jT6V059PZo68rtRwsrzPReA6TtkJsxq5Me9g7IMwh1RzADgn0d4soBeKAmb
 dwIMxVcy9un7CqrrVo5ANcs2F5odSMv5DTQwsPj5+O0r7oTdQOj4REvNgaeZpf0O6b2R8xFiW
 ghWg8bzHo+Wdn9TuqiWnghHBrRz+I8HTDuyAmutHbLdTAciGzv5WM9rpD3103Y/j2d09wi+iJ
 G3gzCd/mHiYVc/pa6tbnj9T1SQv/fP7agj+UaDbj+g5iRcg817ml/GloKNfTjpsehoe47cKQi
 gt34WHnXL3Khoe/m1nt3jy7HwLsiGQmgVv9aX2n1noMNqC8ChOMl7pt3+z0Zbp27rh9puDu8k
 KXhn/N/qOr3ID58sq922uTZZawbpJcfs9apFY0YKeAo2ySUSl15tL40P3cswMwPrwA42r/UsP
 cDPX355LHAVJ85jPQVBZzl40LPR/igyoeegHskd6wqHXLw1UMM4volDEpJhhNB4P9cD1oDb7F
 LgzHPbICfa4rVPH/DFHGZiBY0gjH7qOcYMAwQR1xiu2QenVCOOiQ3GyLStDkvMyfYSOBo0XfB
 5p6GQBjwK0IXZPgWxTDrFY4PCOSCbUW5aNZ4sSiwO4nhHM5k60fHv46kdmmjRKrR/+43Vs4KT
 EVc5GyKld/Kb9UkY6ECe2/3nvY5Z9S4WOYW/kfQECuNjtNOI+OUamkheqQ6q6KGZQ3LGhPaQN
 c92JAjL7DKuvK7qPZByWwxKqfiCzAPxR9ObZXLZu8xZlIUmQR+ifU4kt1XUAgJRkxPVxyOGIY
 iyV1ibGdRYV7ZBXMwZjaOG8VuzlDzZJaPvE
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 3 Jul 2019 15:50:37 +0200

Some strings should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_puts=E2=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/nfs/super.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 0c229e877ba6..84dcde7f560b 100644
=2D-- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -582,7 +582,7 @@ static void nfs_show_mountd_options(struct seq_file *m=
, struct nfs_server *nfss,
 	}
 	default:
 		if (showdefaults)
-			seq_printf(m, ",mountaddr=3Dunspecified");
+			seq_puts(m, ",mountaddr=3Dunspecified");
 	}

 	if (nfss->mountd_version || showdefaults)
@@ -690,29 +690,29 @@ static void nfs_show_mount_options(struct seq_file *=
m, struct nfs_server *nfss,
 		nfs_show_nfsv4_options(m, nfss, showdefaults);

 	if (nfss->options & NFS_OPTION_FSCACHE)
-		seq_printf(m, ",fsc");
+		seq_puts(m, ",fsc");

 	if (nfss->options & NFS_OPTION_MIGRATION)
-		seq_printf(m, ",migration");
+		seq_puts(m, ",migration");

 	if (nfss->flags & NFS_MOUNT_LOOKUP_CACHE_NONEG) {
 		if (nfss->flags & NFS_MOUNT_LOOKUP_CACHE_NONE)
-			seq_printf(m, ",lookupcache=3Dnone");
+			seq_puts(m, ",lookupcache=3Dnone");
 		else
-			seq_printf(m, ",lookupcache=3Dpos");
+			seq_puts(m, ",lookupcache=3Dpos");
 	}

 	local_flock =3D nfss->flags & NFS_MOUNT_LOCAL_FLOCK;
 	local_fcntl =3D nfss->flags & NFS_MOUNT_LOCAL_FCNTL;

 	if (!local_flock && !local_fcntl)
-		seq_printf(m, ",local_lock=3Dnone");
+		seq_puts(m, ",local_lock=3Dnone");
 	else if (local_flock && local_fcntl)
-		seq_printf(m, ",local_lock=3Dall");
+		seq_puts(m, ",local_lock=3Dall");
 	else if (local_flock)
-		seq_printf(m, ",local_lock=3Dflock");
+		seq_puts(m, ",local_lock=3Dflock");
 	else
-		seq_printf(m, ",local_lock=3Dposix");
+		seq_puts(m, ",local_lock=3Dposix");
 }

 /*
@@ -739,7 +739,7 @@ EXPORT_SYMBOL_GPL(nfs_show_options);
 static void show_sessions(struct seq_file *m, struct nfs_server *server)
 {
 	if (nfs4_has_session(server->nfs_client))
-		seq_printf(m, ",sessions");
+		seq_puts(m, ",sessions");
 }
 #else
 static void show_sessions(struct seq_file *m, struct nfs_server *server) =
{}
@@ -816,7 +816,7 @@ int nfs_show_stats(struct seq_file *m, struct dentry *=
root)
 	/*
 	 * Display all mount option settings
 	 */
-	seq_printf(m, "\n\topts:\t");
+	seq_puts(m, "\n\topts:\t");
 	seq_puts(m, sb_rdonly(root->d_sb) ? "ro" : "rw");
 	seq_puts(m, root->d_sb->s_flags & SB_SYNCHRONOUS ? ",sync" : "");
 	seq_puts(m, root->d_sb->s_flags & SB_NOATIME ? ",noatime" : "");
@@ -827,7 +827,7 @@ int nfs_show_stats(struct seq_file *m, struct dentry *=
root)

 	show_implementation_id(m, nfss);

-	seq_printf(m, "\n\tcaps:\t");
+	seq_puts(m, "\n\tcaps:\t");
 	seq_printf(m, "caps=3D0x%x", nfss->caps);
 	seq_printf(m, ",wtmult=3D%u", nfss->wtmult);
 	seq_printf(m, ",dtsize=3D%u", nfss->dtsize);
@@ -836,7 +836,7 @@ int nfs_show_stats(struct seq_file *m, struct dentry *=
root)

 #if IS_ENABLED(CONFIG_NFS_V4)
 	if (nfss->nfs_client->rpc_ops->version =3D=3D 4) {
-		seq_printf(m, "\n\tnfsv4:\t");
+		seq_puts(m, "\n\tnfsv4:\t");
 		seq_printf(m, "bm0=3D0x%x", nfss->attr_bitmask[0]);
 		seq_printf(m, ",bm1=3D0x%x", nfss->attr_bitmask[1]);
 		seq_printf(m, ",bm2=3D0x%x", nfss->attr_bitmask[2]);
@@ -874,15 +874,15 @@ int nfs_show_stats(struct seq_file *m, struct dentry=
 *root)
 		preempt_enable();
 	}

-	seq_printf(m, "\n\tevents:\t");
+	seq_puts(m, "\n\tevents:\t");
 	for (i =3D 0; i < __NFSIOS_COUNTSMAX; i++)
 		seq_printf(m, "%lu ", totals.events[i]);
-	seq_printf(m, "\n\tbytes:\t");
+	seq_puts(m, "\n\tbytes:\t");
 	for (i =3D 0; i < __NFSIOS_BYTESMAX; i++)
 		seq_printf(m, "%Lu ", totals.bytes[i]);
 #ifdef CONFIG_NFS_FSCACHE
 	if (nfss->options & NFS_OPTION_FSCACHE) {
-		seq_printf(m, "\n\tfsc:\t");
+		seq_puts(m, "\n\tfsc:\t");
 		for (i =3D 0; i < __NFSIOS_FSCACHEMAX; i++)
 			seq_printf(m, "%Lu ", totals.fscache[i]);
 	}
=2D-
2.22.0

