Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16043516A2F
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 06:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383278AbiEBFBW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 01:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346303AbiEBFBV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 01:01:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F9F58E4E;
        Sun,  1 May 2022 21:57:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8691210E1;
        Mon,  2 May 2022 04:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651467472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VjyD08gDOYWy1q/rpusK4veIP/i1qsv19rrIqO0F3Hk=;
        b=M3vMTpud8eW0VE2Pb9OVoKUtuCEZn5Pnz49HmvxriDhkcSpbjykyFK4QW+hXwBXWRIolbz
        IZjKeERyf3ueLNWiGD5S5/xNaTBdVBzMEiB5D6D8znjEtC28TfRbq6+q49KtfA3DNh12Tz
        QqW6wbyJkvTJmXqG3D04Q2GXYrQiLVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651467472;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VjyD08gDOYWy1q/rpusK4veIP/i1qsv19rrIqO0F3Hk=;
        b=tKXvdWdITEUp4ffkEbhK+3ZplXSemTpcgCIjcPJVxpaHLuvcBOlm4NCy5ePfJ3NDr9Jgvd
        PLvTlLLjAyEGzWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38EB713491;
        Mon,  2 May 2022 04:57:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yT96Nc1kb2JZRAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 02 May 2022 04:57:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Miaohe Lin" <linmiaohe@huawei.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Christoph Hellwig" <hch@lst.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MM: handle THP in swap_*page_fs() - count_vm_events()
Date:   Mon, 02 May 2022 14:57:46 +1000
Message-id: <165146746627.24404.2324091720943354711@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


We need to use count_swpout_vm_event() for sio_write_complete() and
sio_read_complete(), to get correct counting.

This patch should be squased into
    MM: handle THP in swap_*page_fs()

Reported-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/page_io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index d636a3531cad..3e2e9029ce50 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -280,8 +280,10 @@ static void sio_write_complete(struct kiocb *iocb, long =
ret)
 			set_page_dirty(page);
 			ClearPageReclaim(page);
 		}
-	} else
-		count_vm_events(PSWPOUT, sio->pages);
+	} else {
+		for (p =3D 0; p < sio->pages; p++)
+			count_swpout_vm_event(sio->bvec[p].bv_page);
+	}
=20
 	for (p =3D 0; p < sio->pages; p++)
 		end_page_writeback(sio->bvec[p].bv_page);
@@ -390,9 +392,9 @@ static void sio_read_complete(struct kiocb *iocb, long re=
t)
 			struct page *page =3D sio->bvec[p].bv_page;
=20
 			SetPageUptodate(page);
+			count_swpout_vm_event(page);
 			unlock_page(page);
 		}
-		count_vm_events(PSWPIN, sio->pages);
 	} else {
 		for (p =3D 0; p < sio->pages; p++) {
 			struct page *page =3D sio->bvec[p].bv_page;
--=20
2.36.0

