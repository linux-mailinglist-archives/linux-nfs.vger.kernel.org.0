Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8862902A0
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Oct 2020 12:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406601AbgJPKNK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Oct 2020 06:13:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:60501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406596AbgJPKNJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 16 Oct 2020 06:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602843182;
        bh=9nssCMMBv7tzELS+fUZMBow//rn3xu+MNXAU4tgsZ6A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=lgYUm/ICOsAa06h00t0wQfL0ZaUune5jpNkiul8SqOcy1PMkbttWpcYoel1VsZOxI
         2lAJ3DQXdKRRh2+FOQdug1VxRl7D4zNIP9Mx1uodr/zY+kX4L9kyTDjqJxPK7O9n1R
         Uh1kfYi/4pt0lN2XnOXf0b7dZQIT+dE4Kj+D7PUk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.166.88]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1k3tvv2xBV-00jZbf; Fri, 16
 Oct 2020 12:13:02 +0200
Date:   Fri, 16 Oct 2020 12:13:00 +0200
From:   Helge Deller <deller@gmx.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: nfsroot: Default mount option should ask for built-in NFS version
Message-ID: <20201016101300.GA364@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:AlTZQWUaumXyJzzN41d431uYsCxjdUZ5t3Om5Lmt6bsPgYwjkEZ
 25cJPeu1FdA4XF25wU3U0uKoCewHCo3Fjxy2zMflq8ilTFj3pKKO7dB/0ryxRwQm/eRxcO3
 WsP3daEvD5r3jqatGoZ15duwLoQNems1XF88ocOvc3DssWXGtyH+R51Dqi4OeuFu9edb4K5
 o8CR/hr1fWBxNf7F0t3Dg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nZInG/kunyg=:ObGxnqK3YeQorDogqRtBi/
 D9LxOk7CkXKNcnFwDJXK/3JfBGZv6sw2MXge6cGXx/ii8tPycXHxgR4ST95MqlVx7AvjLS57Z
 6CW+zoiUy9NjifAKivAwtXOv+r8/MCQqbRX1F9bBdeaL4a256dUmqeumpAXo1f7BzyIsQ7IZI
 3ABlHHk5aPqZG3beBSQUheHXaEeFk8aW7H4FxcDZNjT790EMcebOYJ1bipj9+omTuB8YBiMif
 l+Aef6GdSmxHtIO8C+sggy+GiaNNHg0Iy/MXYzHTV+z9JDSvr3VW1bOIdXz6lUaKr3N7jwlhG
 41Thl0xqkiP+ybDK61dx97gPYZow9uDE39jVL4tFZ0rNIvSX6av8QimpzPqLDwr5IUQQrCd2V
 O69iobacj2n1NrQvb060dEFQOlAwO95JYEsNWtkq+cRMShlkbWuDnd3vIBBkKkT/3ii4n6Tvu
 0serhmZD5i6cVIHmKw5uLCIdQTbJyqNHagxS6InN6/HU8Tm+RBO/rCLZWweTDAipshEIAiP3y
 t7U1dYIgP74YNpTeUE4lqm2BrrrS8I5/hlMX0LSzDzzFfalKopUWDAlazYLU0JAmnr4gxkZ+E
 bVUZGRmX62vdIhwMumvHtPzI1NW5ykq2QlfyhLScwPYW6DQU2k5OpgG0fMBpxoZygqqmFjioB
 n+pugxPQ2T4KyRkrvnHjoa0z8n6+VL83yoAdg8j6DuJKiqGwuaCxJVMSzJ3g4E6ZVvmw0CrgV
 8zLjE3iuOJ93TATzINZsLvpUpqMrrPPfRdFd+8oFDMjbTzeaP8QX2yNyO+TewIk6cIYlPurZS
 +/k4su77qHwg0wVNYIkIAr7ehX9uWYmYoaa16ZLsHgynmEaR9SN/+tMyXB/8bgMRFipOi4Ahm
 Ncx+4dm4T1ZPIuxNn8xg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Change the nfsroot default mount option to ask for NFSv2 only *if* the
kernel was built with NFSv2 support.
If not, default to NFSv3 or as last choice to NFSv4, depending on actual
kernel config.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index 8d3278805602..fa148308822c 100644
=2D-- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -88,7 +88,13 @@
 #define NFS_ROOT		"/tftpboot/%s"

 /* Default NFSROOT mount options. */
+#if defined(CONFIG_NFS_V2)
 #define NFS_DEF_OPTIONS		"vers=3D2,tcp,rsize=3D4096,wsize=3D4096"
+#elif defined(CONFIG_NFS_V3)
+#define NFS_DEF_OPTIONS		"vers=3D3,tcp,rsize=3D4096,wsize=3D4096"
+#else
+#define NFS_DEF_OPTIONS		"vers=3D4,tcp,rsize=3D4096,wsize=3D4096"
+#endif

 /* Parameters passed from the kernel command line */
 static char nfs_root_parms[NFS_MAXPATHLEN + 1] __initdata =3D "";
