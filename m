Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3802C2A9122
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 09:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKFIVE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 03:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgKFIVD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 03:21:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A257FC0613CF
        for <linux-nfs@vger.kernel.org>; Fri,  6 Nov 2020 00:21:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y12so361508wrp.6
        for <linux-nfs@vger.kernel.org>; Fri, 06 Nov 2020 00:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2CmuI52VWnoWnMWaNE3ZxPISjglevqPTVi8K086aVQo=;
        b=P4pInoiz6mjZ1a6mblsaSzrlISl2yz2VVHsIeyAxZcRI8lmpJ5h2EEKNjB4JYnsYDQ
         HiyzVpIpQ6cCdoFctK5PDLWzGV8vKGg/g+Wc9jHjGsnCwzHVHb3C1bCV361GaIoC4nm9
         9oe0AZBWVlGilKU/4qXZ8Am93tIDj4ulBTdYW+uv0zFlp02k8FPktIUHWflV/RH82a4j
         h2x2XG6tEQ5DIajftyq6JQrrmFrHQQDNvaVu7mPVyas0BI+4mLc9ksxBjEXEkQFH31wQ
         b3f3+7gUruNFFwoGFFsaOSXwl/23SSa9hBU07IJyTPKFvrvHpii1OqlshpZsmlwLkTPd
         3H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2CmuI52VWnoWnMWaNE3ZxPISjglevqPTVi8K086aVQo=;
        b=G4IUUoKsamWQMq12vW8iDFUs82obUtXbxL5n9ZAgrKxE0lslWvw8DhmSTS+F4qXG38
         brA3tzJ8iyHZa2Sdehi4+lnj/qojleTplXO7PWGxKh9MBqrW9deOVRH4O+FKXywc3HWJ
         JqbpQeAHfHLXXIXCf+L++KgyuapklmsSQ75AZnwsFeJJ86k9Aj5eYePfKgQFLkihJj4G
         Ueuxvbzk4Lv4T3wu7k1BlmGYskj1By9YAtPCmjdlHNpH+sNGcYY3foFC35NwuS4ACufJ
         6Y3TiIwxUU9X6Qer0dVTGc2jgkmgOojSnoRiArSurx/zMSGznYCeLawqOXdu3B0BzaOx
         brgg==
X-Gm-Message-State: AOAM531lImMPeQXj4BMeH/lHiH73/pmTpGBi6C16ie1ww4TVeDJZE7Cc
        HbnBOcovO6tv74/2KRzTt3g9LXLlZrfIw7FJNMFnIKPYEDI=
X-Google-Smtp-Source: ABdhPJyeGEdHWb4CTXAe1BRFY9J9VuSwi62DEFQXh2UyO3WFokIXHf471V80LhgTVhK/VC0O/BhGvbXxJz2Xw5GXCts=
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr1279712wro.63.1604650861551;
 Fri, 06 Nov 2020 00:21:01 -0800 (PST)
MIME-Version: 1.0
From:   Prunk Dump <prunkdump@gmail.com>
Date:   Fri, 6 Nov 2020 09:20:50 +0100
Message-ID: <CALr0QzGJBsSQ8+BnUzefTYcTpvizf+=V4j6AbzsEjX=cPrpGXA@mail.gmail.com>
Subject: Rights and owner problem on NFSv4 referrals
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello !
I need some help with NFSv4 referrals.

Here my setup :

I have a NFSv4 server "myserverA" thats export some directory tree
that contain a referral like this :
/srv/nfs4    172.16.0.0/16(fsid=0,crossmnt,sec=krb5,rw,async,no_subtree_check)
/srv/nfs4/share/mydirA  172.16.0.0/16(sec=krb5,rw,async,no_subtree_check)
/srv/nfs4/share/mydirB
172.16.0.0/16(sec=krb5,rw,async,no_subtree_check,refer=/share/mydirB@myserverB)

The /srv/nfs4/share/mydirA directory is bind mounted to some place on
the same server.
The /srv/nfs4/share/mydirB is bind mounted to itself as it refers to
server "myserverB".

The server "myserverB" exports are similar :
/srv/nfs4    172.16.0.0/16(fsid=0,crossmnt,sec=krb5,rw,async,no_subtree_check)
/srv/nfs4/share/mydirA
172.16.0.0/16(sec=krb5,rw,async,no_subtree_check,refer=/share/mydirA@myserverA)
/srv/nfs4/share/mydirB  172.16.0.0/16(sec=krb5,rw,async,no_subtree_check)

If I don't use NFS referrals, everythings works fine on my setup. But
if I mount from a client the tree exported by myserverA, I get wrong
permissions. For example :

~# mount -t nfs4 myserverA:/ /mountdir
~# ls -al  /mountdir
drwxrwxr-x    root    myldapgroup    mydirA
dr-xr-xr-x    4294967294    4294967294 mydirB

Normally mydirA and mydirB have exactly the same permissions. Now if I
list the mydirB content from the client, it automatically mounts the
"myserverB" tree and the permission becomes OK.

~# ls /mountdir/mydirB
... some files/dirs
~# ls -al  /mountdir
drwxrwxr-x    root    myldapgroup    mydirA
drwxrwxr-x    root    myldapgroup    mydirB

So this is not an ID mapping problem.

You may say "Ok where is the problem ?". The problem is that some
applications check if they can write to a directory before listing its
content and don't check the rights again after. So here for example,
the members of "myldapgroup" can't write to "mydirB" with some
applications. They need to try to write two times :
-> The first time, the rights are badly read and the referral is
mounted by the kernel, but the application doesn't want to write as it
thinks that there is no write access.
-> The second time, the rights are correctly read because the referral
is mounted, so the application accepts to write inside the "mydirB"
folder.

It seems normal to me that the client doesn't mount the mydirB
referral only to list the parent directly content. Otherwize if the
directory contains many referrals, all the servers need to be
contacted just to list the directory content.

It seems also normal to me that the "myserverA" server doesn't contact
continuously all the servers for each referrals it exports to check
the permissions of the directories exported.

But it may be a way to set the right permission manually on the server
that exports the referral. I have tested. On the "myserverA" server,
changing the rights of the /srv/nfs4/share/mydirB directory (the one
bind mounted to itself) changes nothing on the client side (so change
nothing on the way the parent directory is exported by the server).

Is there a way to setup the "myserverA" server so that it gives the
wanted permission on referrals when a client lists the parent
directory ?

Thanks !

Baptiste.
