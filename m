Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA591376F15
	for <lists+linux-nfs@lfdr.de>; Sat,  8 May 2021 05:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhEHDOg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 23:14:36 -0400
Received: from server.atrad.com.au ([150.101.241.2]:47902 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhEHDOg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 23:14:36 -0400
X-Greylist: delayed 778 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 May 2021 23:14:36 EDT
Received: from marvin.atrad.com.au (IDENT:1008@marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.15.2/8.15.2) with ESMTPS id 14830ZW4009255
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-nfs@vger.kernel.org>; Sat, 8 May 2021 12:30:36 +0930
Date:   Sat, 8 May 2021 12:30:34 +0930
From:   Jonathan Woithe <jwoithe@just42.net>
To:     linux-nfs@vger.kernel.org
Subject: Umount fails for NFS mounts with "users" or "user" options
Message-ID: <20210508030034.GA30593@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.79 on 192.168.0.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all

When /etc/mtab is a symlink to /proc/mounts, users are still able to mount
NFS volumes listed in /etc/fstab with the "user" or "users" option. 
However, attempting to unmount the same volume fails:

  umount.nfs: You are not permitted to unmount <mount-point>

The /etc/fstab entry is

  nfssvr:/home/export  /home/export  nfs  users,noauto,hard,bg,intr

The kernel doesn't track the "user" or "users" options so they don't appear
in /proc/mounts, and thus in /etc/mtab when the latter is a link to the
former.  However, when /etc/mtab is an ordinary file nfs.mount adds the
"user" or "users" option to the entry (fix_opts_string() in
utils/mount/mount.c) so the flag is available when /etc/mtab is consulted at
unmount time.

The util-linux mount tools must track the "user" and "users" options in
their own way since mounts which use those tools with these flags work fine.
I haven't quite determined where it does this: I thought it might be
/run/mount/utab, but that file isn't created on my system (Slackware64
/current) and yet user mounts still generally work.

What is the recommended way to unmount NFS volumes which are permitted to be
mounted by users via the "user" and "users" options?  The only way I can
think of is a very careful sudo entry.  It would be good though if nfs
unmount could work with the "user" and "users" options just like mount does.

Regards
  jonathan
