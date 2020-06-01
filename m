Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660581E9B07
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2020 02:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgFAAqq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 May 2020 20:46:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:53316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFAAqq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 31 May 2020 20:46:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 26A09AC52;
        Mon,  1 Jun 2020 00:46:46 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 01 Jun 2020 10:46:35 +1000
Cc:     Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Writeback fixes for NFS
In-Reply-To: <20200515111043.GK9569@quack2.suse.cz>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name> <87ftdgw58w.fsf@notabene.neil.brown.name> <87wo6gs26e.fsf@notabene.neil.brown.name> <87tv1ks24t.fsf@notabene.neil.brown.name> <20200416151906.GQ23739@quack2.suse.cz> <87zhb5r30c.fsf@notabene.neil.brown.name> <20200422124600.GH8775@quack2.suse.cz> <871rnob8z3.fsf@notabene.neil.brown.name> <87y2pw9udb.fsf@notabene.neil.brown.name> <20200515111043.GK9569@quack2.suse.cz>
Message-ID: <87imgb7gus.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain


Hi Andrew,
 could you please queue these two patches (following).
 I think they have sufficient review and no remaining complaints.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl7UT+sACgkQOeye3VZi
gblYQBAAgv37f/xIZLXB2Z94M9cjmhD4YWjzfdu1CWVodFvvVReMxog9C2xdrplX
zsswwQo3GHJ29fJ5jYXIWP46M8t6bdMvqPGtGOdTWz5/50trZf2kDL6cjoM8oAXk
c7bfjuYpb07ccZYwfaro0EXTCWPI+BXOeMofKlmeAw0wbbq8n+YvUs+fQEdnpfvZ
3dx76LkxCKEu1YqHGbEl9dV2xO9CRnk25F0GIZBWELgXaOHyJIzTjA9cRCUaBZDY
rjz3I0sp2YVEEGBoA4fG0UBhU+7bTicC+YEsYCuXAKbsOU0zmPqLc4zZnc2NRr7b
Zhe8cMDKAE3YSlldJGFCastZAhROvCUu10iXDqG6esKJ1ebw7uh+Duu6B94Cx0NG
faOJcV61IGIhpzlyxqIzx8vkSKqlGu5N9KZWK/F3nWeMEy+PKCoWxirjkIc+HJb2
goOFQgrIwllUdzICUvTJD4aXhv36EclE6bh68wSTZC7lxRynw5p2ZqDvL6sG+Ehe
5ok+vFrC0gtLhYNmDdaqZDXkNRo4qmGUVOffQpSkt18uQsGaoapJ3a8fczaGjnqB
sUfPDr8LFvtsh6QxuiqXK+0HtJXM6W9N0SI+lgSTAimSlNEaA734PHBAdyRarQWy
7GMiZ4+egaUTLzx9JADZ5Vhgbuoowt26arv2Nl5kd1lYfKORUUE=
=PG+P
-----END PGP SIGNATURE-----
--=-=-=--
