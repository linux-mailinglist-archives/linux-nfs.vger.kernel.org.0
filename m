Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AE6256AAE
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Aug 2020 00:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgH2W6I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Aug 2020 18:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgH2W6I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 Aug 2020 18:58:08 -0400
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Aug 2020 15:58:08 PDT
Received: from chicago.messinet.com (chicago.messinet.com [IPv6:2603:300a:134:50e0::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A16C061573
        for <linux-nfs@vger.kernel.org>; Sat, 29 Aug 2020 15:58:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by chicago.messinet.com (Postfix) with ESMTP id B535CD2567
        for <linux-nfs@vger.kernel.org>; Sat, 29 Aug 2020 17:52:26 -0500 (CDT)
X-Virus-Scanned: amavisd-new at messinet.com
Received: from chicago.messinet.com ([127.0.0.1])
        by localhost (chicago.messinet.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id VxEZqmssK2or for <linux-nfs@vger.kernel.org>;
        Sat, 29 Aug 2020 17:52:25 -0500 (CDT)
Received: from linux-ws1.messinet.com (linux-ws1.messinet.com [IPv6:2603:300a:134:50e0:48c7:47e6:1bca:4abe])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by chicago.messinet.com (Postfix) with ESMTPSA id 10897D2566
        for <linux-nfs@vger.kernel.org>; Sat, 29 Aug 2020 17:52:25 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 chicago.messinet.com 10897D2566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=messinet.com;
        s=20170806; t=1598741545;
        bh=V/iVKlJf19i4pTUgBmwLSWun9IiOmu3IVwmI92mfdNI=;
        h=From:To:Subject:Date:From;
        b=xRVNWAscMesxn32W6m5RUIi2Gvg4g+WFEv5Jdkb0CynXWfJCEixC1vGMPCjuB+OeT
         /1R0534efAgf4T3PO9pZkz+vvhc2df07+eeQoKRJ3REEbeyHFS9eLzfeaspqLvyYOH
         4el1q27BN2C3mmaFLN5/ugsDo2Ahgm+xcDev+3oAZ3enMPbeL84ezzARccmCODQkw4
         XqoBS71tLZmb7HI7S7///0YYDjp1lGTxx42PepfbjKM//cfPQYWPCsBiGB7fZqmQkC
         WhCCNwJX8ZFT/sI3M9KJ8XqlvlGnZkSliGSSNhoLeybvRvvbuJe0mKlaQQKNEZy5/+
         BgdXLE0otuMmA==
From:   Anthony Joseph Messina <amessina@messinet.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: NFS client cannot "see" files or directories in /home/<username>
Date:   Sat, 29 Aug 2020 17:52:19 -0500
Message-ID: <12603973.uLZWGnKmhe@linux-ws1.messinet.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2748348.e9J7NaK4W3"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--nextPart2748348.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I've reported this issue to Fedora:
https://lists.fedoraproject.org/archives/list/users@lists.fedoraproject.org/
thread/YECR5Q4LLTEQO3RNSXXKOCZUZF53UAST/
https://bugzilla.redhat.com/show_bug.cgi?id=1873720

I've got an NFS client that mounts /home via NFSv4.2 with sec=krb5p.  Any 
kernel since 5.7.17 through 5.8.4 is unable to "see" files or directories in 
the mounted /home/<username> directory with the exception of the first "dot" 
directory.

While I cannot see /home/<username>/subdirectory, if I manually cd into /home/
<username>/subdirectory, I can list that subdirectory's contents as normal.

If I mv "/home/<username>/.dotdir" to "/home/<username>/.dotdir.old", I can no 
longer see it, and I can see "/home/<username>/.dotnextdir".  

If I then mv "/home/<username>/.dotdir.old" back to "/home/
<username>/.dotdir", I am not able to see it and can still only see "/home/
<username>/.dotnextdir"

My last NFS client that can "see" /home/<username> directory contents (normal 
operation) is kernel-5.7.15 (I was unable to test 5.7.16)

NFS server upgrades from kernel-5.7.15 through kernel-5.8.4 didn't seem to 
have any affect.

I understand this list is for developers, but I'm wondering if any of the NFS 
experts can point me in the right direction...  Thank you.

-- 
Anthony - https://messinet.com
F9B6 560E 68EA 037D 8C3D  D1C9 FF31 3BDB D9D8 99B6

--nextPart2748348.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE+bZWDmjqA32MPdHJ/zE729nYmbYFAl9K3CMACgkQ/zE729nY
mbadfQ/9G28S5VgDs/03oXTMSynQXNin0RlXZod44bqXCvre9g0O05hRlD+KomZQ
96+2Mfiq9xTo+rTHjCjiid31UKIjRcns9tiPoI33CFB45gJR5ERE7NrenAz0v31j
KpWK00xhtdiKjYXRt0ku+UN+xUGjabKUB2AnXUY3WlEVfGd2Zn3GesmN+Kp0wk7z
aCVXKBZpwytuCam1Y7mqJTBHkwtvH7v7gC5f0QT7mpL1Fhigpx1cZcKBCQrA4uhA
+cA+2A4FIaGfyNcxOohfmRueKLgfY77wXn7zXZHXSJQzMoIXaokD2TI+e9CSlDG4
YpJ/mBxfeoTi3eIl8AN0KrTjV7GhQoEznchoOr2Iq/aAtE44hL+n70QLt7lCdgCT
eS487JLpox8j1Ajq5Q75wEVw99NreElCSW0mbjjci6ws5uwiz5um6ahMLuwvEVYO
pid6Wu2k5d9flvwYGOBidVIg1vAvnID8VG2hNje2i9MTVOkX0rFbQc8PrGNSsjrw
aVCNIp8w6ZhvYnhaCEKfT33B/h8Mzg6Bh7Th5eY30CCpEweDZ8vZGZYmGaLRDR4S
z7C2fTb1ZVmb7gtcpzpzYlw0bNgZZoOmdMwp8kBwB0L8g51fncvI4glBLIkfw5/E
+KfiiT5YbnvD4FCUKgHjcQEJ57dVFGZylVEFnXjgc9tBWqKpSMo=
=SXvf
-----END PGP SIGNATURE-----

--nextPart2748348.e9J7NaK4W3--



