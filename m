Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA65270961
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Sep 2020 02:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgISAOw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Sep 2020 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgISAOw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Sep 2020 20:14:52 -0400
Received: from chicago.messinet.com (chicago.messinet.com [IPv6:2603:300a:134:50e0::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E302C0613CE
        for <linux-nfs@vger.kernel.org>; Fri, 18 Sep 2020 17:14:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by chicago.messinet.com (Postfix) with ESMTP id 609ABE147D
        for <linux-nfs@vger.kernel.org>; Fri, 18 Sep 2020 19:14:50 -0500 (CDT)
X-Virus-Scanned: amavisd-new at messinet.com
Received: from chicago.messinet.com ([127.0.0.1])
        by localhost (chicago.messinet.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ZxQrjvV_fKO9 for <linux-nfs@vger.kernel.org>;
        Fri, 18 Sep 2020 19:14:47 -0500 (CDT)
Received: from linux-ws1.messinet.com (linux-ws1.messinet.com [IPv6:2603:300a:134:50e0:2919:56d7:b5c5:da82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by chicago.messinet.com (Postfix) with ESMTPSA id BFFD7E147C
        for <linux-nfs@vger.kernel.org>; Fri, 18 Sep 2020 19:14:47 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 chicago.messinet.com BFFD7E147C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=messinet.com;
        s=20170806; t=1600474487;
        bh=WLNEaG4HANv1HjqLj7DfeS41yl1yOEgr6dk5GJ7xYj8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JBGh4TeG6C3vL3NgC70nYEF8aR+eaWZQqmc8QPWmMeWQ8k5yG1qred7rOT2FVEN6n
         wGtBSqkgEdP6t0qu549vx/WxEctxlqOrNFBU7hBDbPG3wDO6GxBks2InRhp8IJ8xWF
         stWa6oy9ZMvIq0NU4dBXvy1YUI0sPTkIQZRJYZo5DnAB5xLzPVnvZGcmaDtWzZ+XSE
         H4swtwzF26o1zDBZRoj5c4XdevWPv4MQJvgtA+BPRJWbDmLL0eMWAqB1H+9hNuzaC4
         VbkizUPmnU0ApLAIWuUNTglbOCBPGg5OjvkyxQVf0w3m54y1zFCoNbm/MkvR6j1rfG
         hr7MN7SO1HrKQ==
From:   Anthony Joseph Messina <amessina@messinet.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS client cannot "see" files or directories in /home/<username>
Date:   Fri, 18 Sep 2020 19:14:41 -0500
Message-ID: <5391825.DvuYhMxLoT@linux-ws1.messinet.com>
In-Reply-To: <5949391.lOV4Wx5bFT@linux-ws1.messinet.com>
References: <12603973.uLZWGnKmhe@linux-ws1.messinet.com> <5949391.lOV4Wx5bFT@linux-ws1.messinet.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5638496.lOV4Wx5bFT"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--nextPart5638496.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, September 13, 2020 12:22:25 PM CDT Anthony Joseph Messina wrote:
> On Saturday, August 29, 2020 5:52:19 PM CDT Anthony Joseph Messina wrote:
> > I've reported this issue to Fedora:
> > https://lists.fedoraproject.org/archives/list/users@lists.fedoraproject.or
> > g/ thread/YECR5Q4LLTEQO3RNSXXKOCZUZF53UAST/
> > https://bugzilla.redhat.com/show_bug.cgi?id=1873720
> > 
> > I've got an NFS client that mounts /home via NFSv4.2 with sec=krb5p.  Any
> > kernel since 5.7.17 through 5.8.4 is unable to "see" files or directories
> > in the mounted /home/<username> directory with the exception of the first
> > "dot" directory.
> > 
> > While I cannot see /home/<username>/subdirectory, if I manually cd into
> > /home/ <username>/subdirectory, I can list that subdirectory's contents as
> > normal.
> > 
> > If I mv "/home/<username>/.dotdir" to "/home/<username>/.dotdir.old", I
> > can
> > no longer see it, and I can see "/home/<username>/.dotnextdir".
> > 
> > If I then mv "/home/<username>/.dotdir.old" back to "/home/
> > <username>/.dotdir", I am not able to see it and can still only see
> > "/home/
> > <username>/.dotnextdir"
> > 
> > My last NFS client that can "see" /home/<username> directory contents
> > (normal operation) is kernel-5.7.15 (I was unable to test 5.7.16)
> > 
> > NFS server upgrades from kernel-5.7.15 through kernel-5.8.4 didn't seem to
> > have any affect.
> > 
> > I understand this list is for developers, but I'm wondering if any of the
> > NFS experts can point me in the right direction...  Thank you.
> 
> The Fedora bugzilla provides additional information:
> 
> In https://bugzilla.redhat.com/show_bug.cgi?id=1873720#c7 a user reports the
> commit that creates the issue:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id
> =b4487b93545214a9db8cbf32e86411677b0cca21
> 
> In https://bugzilla.redhat.com/show_bug.cgi?id=1873720#c12 another user
> reports the relationship with exports using the "security_label" option

This has been resolved with the patch in:
https://marc.info/?l=linux-nfs&m=160020628625265&w=2

-- 
Anthony - https://messinet.com
F9B6 560E 68EA 037D 8C3D  D1C9 FF31 3BDB D9D8 99B6

--nextPart5638496.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE+bZWDmjqA32MPdHJ/zE729nYmbYFAl9lTXIACgkQ/zE729nY
mbbL7hAAtVuMrVULPycoVRL+EKCiliict12OyO+uV8vRGfFdfymbg4VTw1wXpes6
M7eESRjAORB7t0hJLLBZIt0IaxSEhZZgzUNRfljEFu3t9Jd2oeKLLndz1WPUqN2K
vgSVBLZMBlXBMoQDBSs1Rlfwqdi09WoXu67QLXXynA1Jl9U9Kt6rdM6oUbAn2Hrv
Uf6tuwoMrhCgqB9pehElwClz4SmGop8lRnbEoqAds5r08efP9gPL6aeF+Kt7W1FA
jzcWrDZhM6LX58vnw4aUOlWmbSSRpEVid7AEMLfHuz8dUEHaZmdVGKmXnyLkmptv
ezU9KwAwD6LQzIUjke4JDaMpmLL6IQhjjIkLc+8/T2Q9PPn0kgR4nOm3HdYicXUR
Rm/7S4zuqV8qcjJeGofwLE2uRtEIO87z1XiIhieVo2Jz7rCaMAgzVfHDBkCfrvFZ
/apftg1LFLyGxpsmxJ+86t3uJ64DxxVwPyb89JSSOfS1GD5OMEhTF/FUJg2eL62f
wHtsnXuXBVM2memkMHBc0MZhtN6VVx0+R7gMF7yw2/nB7x5ctX9d0EGpYm9NuMve
sRAbWBvRHhRuyotQNVXWEempi6Kaw7spbE45ftnibREA/eQf8h5KmAYyY/Lj8USN
CC3yiwYKBtoqlWWVMQaJp0QA6WaIsXDIhVyUwELNbKBFJ5capRc=
=UDv2
-----END PGP SIGNATURE-----

--nextPart5638496.lOV4Wx5bFT--



