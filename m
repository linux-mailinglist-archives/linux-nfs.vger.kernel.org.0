Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11860453BB8
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 22:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhKPVi1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 16:38:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59526 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhKPVi1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 16:38:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D388218B5;
        Tue, 16 Nov 2021 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637098529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnpSPGK1pOxtwUMg/iQOy5Bf5dvDM+Ppm671IC1Ri+4=;
        b=HFxhIJAm4BYWSB52oxER+nilF5GwDZUi1+W+vXmb+WoCbQZ2Qll4Ku+AbVXNg3X2V//t6v
        mAff4VJlFxRNE2gHpcPolsojeaaT7lkKoY3RrdTgpl7HGpFlFma+cFi/T7uF9xuneRCUKq
        g/2rxV8LRcnxVg0/vOPvz8MOzZrsczY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637098529;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnpSPGK1pOxtwUMg/iQOy5Bf5dvDM+Ppm671IC1Ri+4=;
        b=Djt4ObpCCm3nYJD2EM8ryL4za7I91XlYNPLYK2bTE7SRF+EM2U13RNGjosw/0EB9HD5KJm
        5E0a+4vLcKpCMgDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7675713C62;
        Tue, 16 Nov 2021 21:35:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3qtlDR4klGFbHQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 21:35:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] MM: reclaim mustn't enter FS for swap-over-NFS
In-reply-to: <YZNss/ujX3yovr/k@infradead.org>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>,
 <163703064452.25805.16932817889703270242.stgit@noble.brown>,
 <YZNss/ujX3yovr/k@infradead.org>
Date:   Wed, 17 Nov 2021 08:35:23 +1100
Message-id: <163709852340.13692.16362531894844686350@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 16 Nov 2021, Christoph Hellwig wrote:
> On Tue, Nov 16, 2021 at 01:44:04PM +1100, NeilBrown wrote:
> > +		/* ->flags can be updated non-atomicially (scan_swap_map_slots),
> > +		 * but that will never affect SWP_FS_OPS, so the data_race
> > +		 * is safe.
> > +		 */
> >  		may_enter_fs =3D (sc->gfp_mask & __GFP_FS) ||
> > +			(PageSwapCache(page) &&
> > +			 !data_race(page_swap_info(page)->flags & SWP_FS_OPS) &&
> > +			 (sc->gfp_mask & __GFP_IO));
>=20
> You might want to move the comment and SWP_FS_OPS into a little
> inline helper.  That makes it a lot more readable and also avoids the
> overly long line in the second hunk.

Yes, that's a good idea.  Something like this....

Thanks,
NeilBrown

From a85d09cc3d671c45e32d782454afeeaaaece96c7 Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Fri, 29 Oct 2021 13:35:56 +1100
Subject: [PATCH] MM: reclaim mustn't enter FS for swap-over-NFS

If swap-out is using filesystem operations (SWP_FS_OPS), then it is not
safe to enter the FS for reclaim.
So only down-grade the requirement for swap pages to __GFP_IO after
checking that SWP_FS_OPS are not being used.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 mm/vmscan.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..e672fcc14bac 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1464,6 +1464,21 @@ static unsigned int demote_page_list(struct list_head =
*demote_pages,
 	return nr_succeeded;
 }
=20
+static bool test_may_enter_fs(struct page *page, gfp_t gfp_mask)
+{
+	if (gfp_mask & __GFP_FS)
+		return true;
+	if (!PageSwapCache(page) || !(gfp_mask & __GFP_IO))
+		return false;
+	/* We can "enter_fs" for swap-cache with only __GFP_IO
+	 * providing this isn't SWP_FS_OPS.
+	 * ->flags can be updated non-atomicially (scan_swap_map_slots),
+	 * but that will never affect SWP_FS_OPS, so the data_race
+	 * is safe.
+	 */
+	return !data_race(page_swap_info(page)->flags & SWP_FS_OPS);
+}
+
 /*
  * shrink_page_list() returns the number of reclaimed pages
  */
@@ -1513,8 +1528,7 @@ static unsigned int shrink_page_list(struct list_head *=
page_list,
 		if (!sc->may_unmap && page_mapped(page))
 			goto keep_locked;
=20
-		may_enter_fs =3D (sc->gfp_mask & __GFP_FS) ||
-			(PageSwapCache(page) && (sc->gfp_mask & __GFP_IO));
+		may_enter_fs =3D test_may_enter_fs(page, sc->gfp_mask);
=20
 		/*
 		 * The number of dirty pages determines if a node is marked
@@ -1682,7 +1696,8 @@ static unsigned int shrink_page_list(struct list_head *=
page_list,
 						goto activate_locked_split;
 				}
=20
-				may_enter_fs =3D true;
+				may_enter_fs =3D test_may_enter_fs(page,
+								 sc->gfp_mask);
=20
 				/* Adding to swap updated mapping */
 				mapping =3D page_mapping(page);
--=20
2.33.1

