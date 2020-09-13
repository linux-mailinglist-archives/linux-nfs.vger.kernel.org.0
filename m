Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADAB268088
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Sep 2020 19:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgIMRWq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Sep 2020 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIMRWk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Sep 2020 13:22:40 -0400
Received: from chicago.messinet.com (chicago.messinet.com [IPv6:2603:300a:134:50e0::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAD6C06174A
        for <linux-nfs@vger.kernel.org>; Sun, 13 Sep 2020 10:22:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by chicago.messinet.com (Postfix) with ESMTP id A69E9D2567
        for <linux-nfs@vger.kernel.org>; Sun, 13 Sep 2020 12:22:31 -0500 (CDT)
X-Virus-Scanned: amavisd-new at messinet.com
Received: from chicago.messinet.com ([127.0.0.1])
        by localhost (chicago.messinet.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ypt7tN_8mFTt for <linux-nfs@vger.kernel.org>;
        Sun, 13 Sep 2020 12:22:30 -0500 (CDT)
Received: from linux-ws1.messinet.com (unknown [IPv6:2603:300a:134:50e0:a1d3:7883:f6d4:805a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by chicago.messinet.com (Postfix) with ESMTPSA id D25A6D2566
        for <linux-nfs@vger.kernel.org>; Sun, 13 Sep 2020 12:22:30 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 chicago.messinet.com D25A6D2566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=messinet.com;
        s=20170806; t=1600017750;
        bh=bYmAkuTcHNd6Uk/8O+jJZLs7GjwBFqsWkKT5KMdtZd4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EV/JxUVOjCOVUEOUU31/ZRNAloSfTfKu7R28jiFENlzgpz469lTGdHEwXpy7CDtgN
         RtO4voDC6EcL/60j7rVxNNg8B5yCvzOxiqfUlfm4qoHRy0rkBBivTyzUf4fFHHtmUy
         GEpXiLbHzYXihRRWk2V+mB+Kk/36b9CRQA/9KCSsCzSE1Pw2eV7XnAOeC6v29ZOUFD
         AR9K5JGuZa6j5NsyqXTg1em7hCQMpZLDhuDYs/Jt2ZooZLxL4ztijj+ZKnjOJ1lnnC
         AOo3KD1WM0hziv4ioBjoundVk7aflvXguEQj/7waw1byBACSY+IGEMHYCX37VxUJtd
         AHq3wqGjUxcng==
From:   Anthony Joseph Messina <amessina@messinet.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS client cannot "see" files or directories in /home/<username>
Date:   Sun, 13 Sep 2020 12:22:25 -0500
Message-ID: <5949391.lOV4Wx5bFT@linux-ws1.messinet.com>
In-Reply-To: <12603973.uLZWGnKmhe@linux-ws1.messinet.com>
References: <12603973.uLZWGnKmhe@linux-ws1.messinet.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4900104.31r3eYUQgx"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--nextPart4900104.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, August 29, 2020 5:52:19 PM CDT Anthony Joseph Messina wrote:
> I've reported this issue to Fedora:
> https://lists.fedoraproject.org/archives/list/users@lists.fedoraproject.org/
> thread/YECR5Q4LLTEQO3RNSXXKOCZUZF53UAST/
> https://bugzilla.redhat.com/show_bug.cgi?id=1873720
> 
> I've got an NFS client that mounts /home via NFSv4.2 with sec=krb5p.  Any
> kernel since 5.7.17 through 5.8.4 is unable to "see" files or directories in
> the mounted /home/<username> directory with the exception of the first
> "dot" directory.
> 
> While I cannot see /home/<username>/subdirectory, if I manually cd into
> /home/ <username>/subdirectory, I can list that subdirectory's contents as
> normal.
> 
> If I mv "/home/<username>/.dotdir" to "/home/<username>/.dotdir.old", I can
> no longer see it, and I can see "/home/<username>/.dotnextdir".
> 
> If I then mv "/home/<username>/.dotdir.old" back to "/home/
> <username>/.dotdir", I am not able to see it and can still only see "/home/
> <username>/.dotnextdir"
> 
> My last NFS client that can "see" /home/<username> directory contents
> (normal operation) is kernel-5.7.15 (I was unable to test 5.7.16)
> 
> NFS server upgrades from kernel-5.7.15 through kernel-5.8.4 didn't seem to
> have any affect.
> 
> I understand this list is for developers, but I'm wondering if any of the
> NFS experts can point me in the right direction...  Thank you.

The Fedora bugzilla provides additional information:

In https://bugzilla.redhat.com/show_bug.cgi?id=1873720#c7 a user reports the commit that creates the issue:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=b4487b93545214a9db8cbf32e86411677b0cca21

In https://bugzilla.redhat.com/show_bug.cgi?id=1873720#c12 another user reports the relationship with exports using the "security_label" option

-- 
Anthony - https://messinet.com
F9B6 560E 68EA 037D 8C3D  D1C9 FF31 3BDB D9D8 99B6

--nextPart4900104.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE+bZWDmjqA32MPdHJ/zE729nYmbYFAl9eVVEACgkQ/zE729nY
mbYEWBAAp/1JaeMUOx5sIuEbVv/xU/8aJS9bHBgDmoAKlyheuW/sEqHcBFlwUHAD
SsIuKzBCnbZRrYGD/+FT+panBzlHnG2R4TobEerX+p8XWUgHnxZspZT0T2v98Av6
3bvu0Te/PJifg3OWqEn408D/uIhrSS42gO+e7oWG9W1wpdybOf/VwkX5JmtRgSwh
ZQ++C64sFCkMhJeC54c1mqTZubtr0t7UvbEbb/PpLsH2owZ5fI0akWbq041jzr00
9g4mCHkYe6msvB9tgXudL7snXwPVWVlr09URYRaaUl4l46AwS6qAHqdc8DgdGYb1
Fn5hOVm9yuprufpJZlZShkBvzKmjvYMqHj8Hm4pOJce0IZNPHBTRfZ1aRMlekyPc
lRQyvyXz4swaUrwD5B8BnTtKWHPZkcO4Va0WGeQZZ72rngW0/UHolAZn/oaOCUf3
geiaHgsAadBn2uGmUtqY94+GzZjymfQ8kE9MWLRwciX17hs9xoikKiCCYlrSzhIl
rItBajLUY6rj0OyUm8dVDtCv50rUbIKI3lM+N7t7U4mPnAfC3pqt2pYlatMiYxyh
WLjSdahaY2x57IdQfRuMJjnxJ1ni7b5TY/rzyStBNNcDGF70hT9S5MIhhhcaZYp7
acg1bEWk8qLMpfMTlkqjx1iSldB09sarZqciNIK+viCUhwRKHPs=
=hXtG
-----END PGP SIGNATURE-----

--nextPart4900104.31r3eYUQgx--



