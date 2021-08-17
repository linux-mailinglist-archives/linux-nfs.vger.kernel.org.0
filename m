Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AF63EEEE4
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Aug 2021 17:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbhHQPC1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Aug 2021 11:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhHQPC0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Aug 2021 11:02:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEC2C061764
        for <linux-nfs@vger.kernel.org>; Tue, 17 Aug 2021 08:01:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bo18so32608861pjb.0
        for <linux-nfs@vger.kernel.org>; Tue, 17 Aug 2021 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FC78Dlug5VsAxnSbqWT9hvHWm2LO4GPlLNixClGjllo=;
        b=HEfJusX2hdX6PsJpKZaOJg1lAk/6E8HJpQ5HL3P1sF3RGF0PuxV3seReOf4fJ/xeoj
         F0P6TMKCdV2R8XRNn78JDB8/vYE8RxaCR63p8teJ6TY1/RrGIZCdH+bNanBpwFgVZhCh
         iUcQSNW5CMcUCPRAe6EbQmRGIb0JgIu0cuQ0KaOeNW12BICvbjZX4aGK2IpggVWjNlx8
         9bLe/q/zSoEiTbhGodqVeEfhX1/ce50Zt1lZH6B9Dk0eNepgziKLgPiJ23yOEpt+ltfX
         5Lm2QpOwmBgj5jcIr+2q4rl/AXBivIP3P6AwYkixOo4BZHYFAJMBqJQ74Bq2Jwut/Zrc
         5+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FC78Dlug5VsAxnSbqWT9hvHWm2LO4GPlLNixClGjllo=;
        b=LvJSvddeMS6YbTP6TaZIdAuVw+SdGYwiHoTqZzjeA9KJioZKxD4O+3pz7FXpfeKx71
         6EzrRzeCDCrgehB64IsVv2g3UNaw7QP3+MkSsW7r6jYXjhE/Q+jVN2n1mChy1jHX7AlE
         T0NwFsKMqJoiT27ojiuTenRkdL/B3qu/Y0dFnjSbScTjX5JB9PmJj3st8nicV7bYqliE
         w8m3QNdevnboh3U8waBOXGQ8ctrc3+LMEdaHtDuNE96uDK+DpM/5FpfC/b1tI8nvQ7p9
         VIkxOg9Uis7HafaAGLPrY0B4L6zgt6Bw2B1PXZlcGZ913/g2GzV1yGskwU/3Prh0/whv
         FlmQ==
X-Gm-Message-State: AOAM532F6pHi5moApVMboQ6Y7TmdPqGRBI9jWpTWXafXV3TPDNCGgEen
        BxdvuRhMXfanaQ4DzRzVBxx2IwLe/tIOMceul6tAafodEkM=
X-Google-Smtp-Source: ABdhPJxXNnqPLtI8VjDNWJ5/QzQafT04uT5t2jbAoDVgA1kIhk0qxH829CCJYUdiuh2VSIaWAJ0NrmdzGtMkzPB8ULM=
X-Received: by 2002:a17:90b:194d:: with SMTP id nk13mr4160423pjb.179.1629212513029;
 Tue, 17 Aug 2021 08:01:53 -0700 (PDT)
MIME-Version: 1.0
From:   Mauricio Tavares <raubvogel@gmail.com>
Date:   Tue, 17 Aug 2021 11:01:42 -0400
Message-ID: <CAHEKYV4040skKv_pWEusmfzmiMZ00dJfqQBZHBJ_+9jdtpzcWA@mail.gmail.com>
Subject: Can write to my fileshare in one host but not the other
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Let's say I have two centos hosts, vmhost and vmhost2, which both have
the homedirs mounted using autofs:

[root@vmhost2 ~]# cat /etc/auto.home
/etc/auto.home
#
# File: /etc/auto.home
#
*   -fstype=nfs4,hard,intr,rsize=8192,wsize=8192 fileserver.in.example.com:/home
/&

[root@vmhost2 ~]#
[root@vmhost ~]$ cat /etc/auto.home
/etc/auto.home
#
# File: /etc/auto.home
#
*   -fstype=nfs4,hard,intr,rsize=8192,wsize=8192 fileserver.in.example.com:/home
/&

[root@vmhost ~]$

I am logged into both hosts and /rpoc/mount shows my homedir mounted.
Note the options listed are slightly different

[root@vmhost2 ~]# fgrep raub /proc/mounts
fileserver.in.example.com:/home/raub /home/raub nfs4 rw,relatime,vers=4.0,rsize=
8192,wsize=8192,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr
=192.168.15.20,local_lock=none,addr=192.168.1518 0 0
[root@vmhost2 ~]#

[root@vmhost ~]$ fgrep raub /proc/mounts
fileserver.in.example.com:/home/raub /home/raub nfs4 rw,relatime,vers=4,rsize=81
92,wsize=8192,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clien
taddr=192.168.15.19,minorversion=0,local_lock=none,addr=192.168.15.18 0 0
[root@vmhost ~]$

I am not able to write to my homedir in vmhost2. I do not see anything
in /var/log/messages, /var/log/audit/audit.log, or /var/log/secure

[raub@vmhost2 ~]$ touch me
touch: cannot touch 'me': Permission denied
[raub@vmhost2 ~]$

It does show the right uid/gid though

[raub@vmhost2 ~]$ ls -lh bogus
-rw-r--r--. 1 raub raub 408 Jun 23  2008 bogus
[raub@vmhost2 ~]$

Where else should I be looking for clues? It feels like I missed
something on vmhost2... but can't figure out what. Suggestions?
