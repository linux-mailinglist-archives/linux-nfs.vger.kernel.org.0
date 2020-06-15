Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0301F9FB0
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2020 20:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbgFOSxP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 14:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOSxO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jun 2020 14:53:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669A1C061A0E
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2020 11:53:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so18220033wru.6
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2020 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jFWR4GWMFwIjjeSDQ+KIpHiNpC5sqk3sNtM8x1vASuc=;
        b=UgFbJCq7jOjH3ijdZaqBLjm/94BWAgcamJk/3bpFJuv8YrXp42hh/4aA/yCzp/zaJk
         xdlbQx+oqtgD2ydz647yFEWMyDptPW5lvsc3sKx5pteoWuM7q8DqhGVrn5oHbEGkrZl8
         54w/V21t1cpKt63uF3ALgzpmRPcm2UnVcO+tUU2iQRpADPpeNfOmLuMzpUPyYdrV4e7d
         LZjv5YkreD8eZzZijvg5MWgQXgRWhiLKS4ALM6AZBX5O7cP1OOql/B9R54VvRam7GGvd
         f7KIygD+1R4VrkrodKDmX2i4GF44c1uP7Ns0eUYsGoOHFaLAP2Sl/OYXF48JdzEsqUoI
         I5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jFWR4GWMFwIjjeSDQ+KIpHiNpC5sqk3sNtM8x1vASuc=;
        b=TS3wDvAta8MvRzu06OMSfmynGfxPxpS54nALWgGjqlU4Iow4oyr1weqB5qE1D/BIoT
         dSqwBhmIFwFaXpWYVSxP7lbtlgxW4OTFlkd5DtRqD0JmbrWNZOr5DAwn/GyZSjOGu9h/
         dJHR1eLBP1+CJYuu3vQ65LTV67g7v7XYoCoNkybnZD8U9oVkCvTwgTo/GMGFpJXvwkh9
         1t9ARNrmOqhAL20gYwkDQQG1Xz5sCieBEpE4e6ESTKQ2ngDYlbeTpmf7Tcfi6QBGf+b8
         BmStSW3RvRHh8DQ17YXZTdv6lBbbr5DTnFp8cEi9CbzHjv/B6Jk4S/bdhL9i+NItUHf7
         QU2Q==
X-Gm-Message-State: AOAM531t7W0Z6385TvUIbFILkWHk4pfw3k/J5/Id7l77NofBrhq3W8ln
        S6I4vul3rjor7EfEp2JbKmMCV00FDf4=
X-Google-Smtp-Source: ABdhPJxI2wluavmydq5P9ZQXPNnrICM0EybzJ5wG6wocDeYgRLY5y7Cn2KASekrcPRLLu2A4mwmDJA==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr33194597wro.60.1592247193102;
        Mon, 15 Jun 2020 11:53:13 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id b19sm1182623wmj.0.2020.06.15.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:53:12 -0700 (PDT)
Date:   Mon, 15 Jun 2020 20:53:11 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200615185311.GA702681@eldamar.local>
References: <20200605051607.GA34405@mattapan.m5p.com>
 <20200605064426.GA1538868@eldamar.local>
 <20200605051607.GA34405@mattapan.m5p.com>
 <20200605174349.GA40135@mattapan.m5p.com>
 <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
 <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615145035.GA214986@pick.fieldses.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

On Mon, Jun 15, 2020 at 10:50:35AM -0400, J. Bruce Fields wrote:
> On Sat, Jun 13, 2020 at 11:45:27AM -0700, Elliott Mitchell wrote:
> > I disagree with this assessment.  All of the reporters have been using
> > ZFS, but this could indicate an absence of testers using other
> > filesystems.  We need someone with a NFS server which has a 4.15+ kernel
> > and uses a different filesystem which supports ACLs.
> 
> Honestly I don't think I currently have a regression test for this so
> it's possible I could have missed something upstream.  I haven't seen
> any reports, though....
> 
> ZFS's ACL implementation is very different from any in-tree
> filesystem's, and given limited time, a filesystem with no prospect of
> going upstream isn't going to get much attention, so, yes, I'd need to
> see a reproducer on xfs or ext4 or something.

I think the following is reproducible on a ext4 exported share (with
underlying filesystem mounted with noacl to mimic the suspect from the
reporter). I tested the same with an older kernel from Debian stretch
(running 4.9.210-1+deb9u1) but this does not show the same behaviour.

The current test system is running 5.6.14-2 Debian kernel (so 5.6.14).

1/ Create an ext4 filesystem:

# mkfs.ext4 /dev/vdb1

2/ Mount the filesystem with noacl (to mimic the situation):

/dev/vdb1 /srv/data ext4 defaults,noacl 0 0

root@nfs-test:~# mount | grep vdb1
/dev/vdb1 on /srv/data type ext4 (rw,relatime,noacl)

3/ Export with

/srv/data 192.168.122.1/24(rw,sync,no_subtree_check,no_root_squash)

4/ Reproduce the issue

root@nfs-test:~# mount -t nfs 192.168.122.150:/srv/data /mnt
root@nfs-test:~# mkdir /mnt/foo && ls -ld /mnt/foo && rmdir /mnt/foo
drwxrwxrwx 2 root root 4096 Jun 15 20:24 /mnt/foo
root@nfs-test:~# mount | grep data
/dev/vdb1 on /srv/data type ext4 (rw,relatime,noacl)
192.168.122.150:/srv/data on /mnt type nfs4 (rw,relatime,vers=4.2,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.122.150,local_lock=none,addr=192.168.122.150)
root@nfs-test:~# umount /mnt

Looking at a wireshark captured sniff, the situation was the same as in the
previous ZFS case, in the gettattr from the client and the server does indicate
support for the new mode_umask. Then later in the CREATE operation, the client
sets the mode_umask attribute, with mode part set to '0777' and umask to '022'.
The mode replied is then as well '0777'.

Notabene: if not mounting the filesystem with noacl, then there is no
observed behaviour change here.

Regards,
Salvatore
