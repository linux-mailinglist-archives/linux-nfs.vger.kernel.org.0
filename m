Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1B1624D8
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2020 11:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgBRKpp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Feb 2020 05:45:45 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:34585 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbgBRKpp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Feb 2020 05:45:45 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 386C54E1
        for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2020 05:45:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 18 Feb 2020 05:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm3;
         bh=19aWNDxVM1tWAGdsb0VwgBTCFbDC+CyB50R2aIV9ZA0=; b=ivZ58eTKiEvX
        RInaWkIr19BQY/KwbaPcPb0d17SPLKjWPVbjKJ4r9dm+XNDC0xlaU1bSBHPa6u7B
        Hoh5e7up2zs/lDExu+DvSbUfDf+mKObmVVjx0HQoJNRkDoXiIsNWNJiJO18qUJyJ
        ygrStWrSuOzhpdCYhSiQdE1mt/cXyPSKbfgY3tax0vy0Oh9Of/Cm71RmEONP+N4l
        o0T7xv/SHJXPij6oyV1ulEiKLctnLUjYay1g2B7ol5/9RziqGhoO0Fxd3nlceHS9
        ncw0XAcJacSLzJCGbO6zYr6m6T0hgzENdDH7+TaLr3L4/Nw3Ohv/NAsEy6eqkDfo
        yf2PKjcyPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=19aWNDxVM1tWAGdsb0VwgBTCFbDC+
        CyB50R2aIV9ZA0=; b=Hq43Eig9UvDUF8KAG800J4CXOM5T/H8bAzIt1lDJYT7Hd
        i8E045OIO11dSvwX9eq2VqRp95jvxkwNPE6i3pH3IU2ppbDtigdc+/xv/inP3qNM
        IVS+nByRRmrN2pwEM8/skRVrvO/XVIZM2OUQSrwXhlHynxLJU6aF+8ot4f/G3lU3
        y1EnMQ0x20pnB7zZtFhjG5llPXbW/ZTYm/n9u+HuWjKD68AU+h6nEwm8iVwJ2Y/x
        8SrUp50h2QKkhi11l/TM6DsfCcuwCKfPpZ+fkZLZS1FBAm90ir+mJSIkZDuktdNG
        Gog0RGOvlGjv2Ykfb9LXY40YkLi8fhoeSsEyqUoBA==
X-ME-Sender: <xms:V8BLXlYNw57AqtX8VJZs3oI6VO5eFflAP5UeIwqcZCtl6ET9bKfNbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeekgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucfkphepkeelrddugedrvddvkedruddttdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:V8BLXove-nd9r02YPdrEPyTZBz-vS4R1PNDJGtC9BWBWlBf3nTZqWg>
    <xmx:V8BLXqus5DrmNItFjN9HpDTKkGjvu0W-F_9elqfM7MXVkGGLp_XsLg>
    <xmx:V8BLXlfGttYsGUQ39nB7szSW90VTAXleWoPDFW9wxX-hcTswvKzaXA>
    <xmx:V8BLXmWDMg_BjJHgw_V8Bja6Wq31Iy01ruxy0XAE9dmTW8RCu9_Deg>
Received: from vm-mail (x590ee464.dyn.telefonica.de [89.14.228.100])
        by mail.messagingengine.com (Postfix) with ESMTPA id 057CA328006B
        for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2020 05:45:42 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id 012e9a3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-nfs@vger.kernel.org>;
        Tue, 18 Feb 2020 10:45:37 +0000 (UTC)
Date:   Tue, 18 Feb 2020 11:46:05 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-nfs@vger.kernel.org
Subject: Changed fstype for nfs4 mounts starting with 5.6-rc1 (bisected)
Message-ID: <20200218104605.GA281780@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

starting with v5.6-rc1, I've noticed that my shutdown scripts do not
work properly anymore in case there's any NFS4 mounts present. The issue
stems from an fstype change: while NFS4 mounts previously had fstype
"nfs4", they now have type "nfs". As a result, my "umount -at nfs4"
doesn't do anything, resulting in a hang later on.

While this can trivially be fixed on my side by doing "umount -at
nfs,nfs4", I guess that this was an involuntary change. A bisect points
to commit f2aedb713c28 (NFS: Add fs_context support., 2019-12-10).
Reproducer:

    $ mount.nfs4 host:/mnt /mnt
    $ findmnt -otarget,source,fstype /mnt
    TARGET SOURCE    FSTYPE
    /mnt   host:/mnt nfs

Patrick

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAl5LwGsACgkQEXxntp6r
8SzE7Q/+Ki92l3c4wqdfw4djuhZ479YK9wdQNUIjAYR9cuVJ17293JGtYQp16rd1
fxqRnnkYT8yLSXFVFIO+d185NpULdQZwQClGnpcISfZeY7sDzrXLDNhzIBEOKzPK
rV4CPlz59oPwvFpzAjl9iPkylffp6+FQ61v24cYbnah5botxpJ6XRXOsr1kBJAOf
Jvsu9l9U5xA05k0dUvnjCQ7J+rYst6wRerXpAJQUG23H5C6zlMEyuzsRNp4JFS6V
19ZtfMAiDHjGKdXxxP8LqVK2QBpRNeMlePmdLjzVztUq+pc2WFj5ZadEYQozwfP+
SWm67N3sbgLRzsIufc7Yl4Zg0GZsYQgXELtO7Hn1rF/3SDocoL/LsSUri+NWgV/N
5Zc0JevHuZmsYmS9i9JEhbfPL+NVyF88kVxW6e8rZrNLasJL423bQntit1WYrLuE
6ShTTdUZA/mx4a2jSRYFqtjsCT1a1T1230C4tXbXDxmOfN9Xpw7lcigUufzBCY+x
m9cRBJHm06ErcwNCKpr716tgWk578EyBEHMxzNkos/ja05Nwd/8F5PU2AM9jNZKQ
XrWqJRWk+VcgRjwvQqDyk5idQjHc3a3U/ApNGC5nwO9GcKz+MxAB0kdlp6XshVe2
/WPwtTUVP8CYSt8XZCmr4dfNKdHq434VKb1g8yEA9J8ffnF9fjA=
=+N7C
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
