Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B67516A4E
	for <lists+linux-nfs@lfdr.de>; Mon,  2 May 2022 07:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiEBFfH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 May 2022 01:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350277AbiEBFfG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 May 2022 01:35:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3592D1DF;
        Sun,  1 May 2022 22:31:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C0A1C210DC;
        Mon,  2 May 2022 05:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651469497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RF5hphk24deK65AGu5WyqI/YJJF5CbaXHTx2KyZd5nY=;
        b=V7xwBv2HyXRXQPhmPO6zT68fBGpr3WRX7lzuSafd054enRFqTzedm72CDEO6cuOKeOTu+a
        26P4BYmBSeMRkyV8T4E4foWG5gVqL1+Ms//uYa29SnQwySxRwmkFW5WUgAHyKB0mZulSEp
        bcafF+UAE1v5tE279o4yFyRszqXFau4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651469497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RF5hphk24deK65AGu5WyqI/YJJF5CbaXHTx2KyZd5nY=;
        b=Jt66QJgQIwodUNF/OYO4SNN2N1mbLESh2AagPEZ51DVAQrU7oe4/OH0AF1iAH5aqMVPrxh
        y+fDyrls7K3oc4Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A43D613491;
        Mon,  2 May 2022 05:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TxKDE7Zsb2KUTQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 02 May 2022 05:31:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Miaohe Lin" <linmiaohe@huawei.com>
Cc:     "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Christoph Hellwig" <hch@lst.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] MM: handle THP in swap_*page_fs() - count_vm_events()
In-reply-to: <165146746627.24404.2324091720943354711@noble.neil.brown.name>
References: <165146746627.24404.2324091720943354711@noble.neil.brown.name>
Date:   Mon, 02 May 2022 15:31:29 +1000
Message-id: <165146948934.24404.5909750610552745025@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


We need to use count_swpout_vm_event() for sio_write_complete() to get
correct counting.

Note that THP swap in (if it ever happens) is current accounted 1 for
each page, whether HUGE or normal.  This is different from swap-out
accounting.

This patch should be squashed into
    MM: handle THP in swap_*page_fs()

Reported-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/page_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index d636a3531cad..1b8075ef3418 100644
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
--=20
2.36.0

