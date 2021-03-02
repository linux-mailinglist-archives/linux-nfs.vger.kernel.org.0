Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3187032A93C
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352152AbhCBSQF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:16:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:52788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1445803AbhCBDCW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 22:02:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4C4EAD21;
        Tue,  2 Mar 2021 03:01:40 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Tue, 02 Mar 2021 14:01:36 +1100
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
In-Reply-To: <20210301185037.GB14881@fieldses.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
Message-ID: <874khui7hr.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, Mar 01 2021, J. Bruce Fields wrote:

> I've gotten requests for similar functionality, and intended to
> implement it using directory notifications on /proc/fs/nfsd/clients.

I've been exploring this a bit.
When I mount a filesystem, 2 clients get created.
With NFSv4.0, the second client is immediately deleted, and the first
client is deleted one grace period after the filesystem is unmounted.
With NFSv4.1 and 4.2, the first client is immediately deleted, and the
second client is deleted immediately after the unmount.

Do you know why two clients are created?  I could dig through the code
... but maybe you already know.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmA9qpAOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmTLQ/+PivXd/sPlNEungFMeZV+eKxMRuRONZLp5v7p
M6ovh0CpwBRTNjusbNoXWFmlrSlld4DjVdOy/OmAtID4LoX3H0g0EQz91cYVvnoo
59/CrnHBjcqvdr0QDQ112cqFIXTX0C3vrLlrMASRIhsICShlWW/ViWVB5upRdpUK
1h0fvQDzHlKBrh/bZN0JgDdjIvfmSuBBSVgSoJRNO+gFde9aaKpD4e73ZZm31qWz
BrNhsDYX43cJp+AH5hLfDOjDqGzuLwj0lIzPJctCOcwefmGLZCBn/K/CVrs6MW62
bFriVlS+RUFgEagCkw1ZxYmqe3X4NJObqvB2NBYj41Ax2hr58/h+BSMwb6wA1nuP
TVTa/SclWSZ+zuXgLtq/UL3tl47iIcnZpdoFWx/6kmpoWcz5tnwB5h8aVXmOOaxo
5HvgDLuY3ikY3MOlxKnP/4ZaFZSrVCHcYKCkBIUb02aMfupyyDFcpi4EsEHRqnxQ
z94w3iERsZHJVminQf4ZIE4cKSp8GNd6RHPhhJi9SA8APlDeStU8DOsDoLS0CuRG
wfIr5lG3m2RPFc1+fpsV4IfW/esb1ANk2EJtkc5SCXQMI+PEX90EeuV+ELvg9okp
ihJQTLpKKfixOvkYeuR9udaiwgpxYdioWKOBmbuCLf9z6tJKKIP/IoWPlzqKI+jJ
FFVY7qE=
=8qXR
-----END PGP SIGNATURE-----
--=-=-=--
