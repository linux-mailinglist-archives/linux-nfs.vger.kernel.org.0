Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC21A01C4
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2020 01:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDFXmt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Apr 2020 19:42:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgDFXmt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 Apr 2020 19:42:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CDCD8ADD7;
        Mon,  6 Apr 2020 23:42:46 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@Netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>
Date:   Tue, 07 Apr 2020 09:42:39 +1000
Cc:     linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Writeback fixes for NFS - V2
In-Reply-To: <87v9miydai.fsf@notabene.neil.brown.name>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name>
Message-ID: <87ftdgw58w.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain


This is a second version of my patches to improve writeback over NFS.
This was prompted by a customer report of very slow throughput to a
server running Ganesha NFS server which was taking about 200ms to handle
COMMIT requests.  While slow COMMIT requests do exacerbate the
problem, there are still problems when COMMIT is comparatively fast.
Latest test results from customer are that these changes provide
substantial improvements.

Changes over first version include improvements to the explanation in
the commit message, and preservation of "NFS Unstable" counts in various
statistics files, despite that fact that the internal accounting is
completely gone (merged with writeback accounting).

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6LvnAACgkQOeye3VZi
gbnpchAAs6Rn9ODgpd2j4JYoTGGJPUCyxj5jebMTzK6o7OhjDYVu139Oup/Q3yKo
TtK111MO0k8XRtMAc0syVjma6kePW4UxDyNnrqUhid3QBu6q76DqpsceqaiK055t
zZ9OUZ97ndOcL2ikmEIcmCDOF+9UU5tW+eI9CXrYjPU33X0420Vhhdi53bUfaXy+
Vnd5iIPFECE/fBk7R3lVs5v1vh+ozpCUFNogJwFVz6UqIXauWgl6KSnPT4lEPERc
9rqQaObolGctvzMkpiBXGxk275asvKWcy9mTxDHf7IGEGd6N1Oo9DQXQqhxpElfy
4HaISHx8D98RotYX/q8QEXQZjD3b85e5ExsmJlrlZXimsK3AC/2RdvqJVV8lKmvV
s7G6q3rSL3LtSLTKcXtBPrcYk1JohfHOTN1zw6fV1jG8j0svJYgyKSHntVv2ugb6
VwJ8K3EUULu/LeU3hJUMNLZqK0cTxMgnZQdlnG6dUuo6KyFuwZcnmBCXvP8u+O+y
wqS8zaw83XgMnoNBCm+DH4FOIE2b9tkzeu4HAgjKJ/8PGiNhP1vpZn1+HbrpBQSM
1AISumJWxzV1EM3rIPOpQ6kxnTRHhWv3V4rYG5CHF3GffnPQAAVa8U4yU01ZEIJr
an6pZ1iMlLaC7Nk0H2LQur8G1Lxcv/7uydppPiWhQywPjXZpmZ4=
=y3d/
-----END PGP SIGNATURE-----
--=-=-=--
