Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA75C339A6E
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Mar 2021 01:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhCMAaQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 19:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhCMA3t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 19:29:49 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D34FC061574
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 16:29:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q2-20020a17090a2e02b02900bee668844dso11504804pjd.3
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 16:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4I3XaEZFrDQMej/rMbNooH3RuDCX+qLeL/xUfUf2+8U=;
        b=m8EsWre2E445fFG/hWdiw5vPOe9qid3mtdfjh53v0xBDqR5z44+O2FBWNEdDPyS7pb
         weG0iknx2Dpg6RNIAEXV0EJoqz1pBJLpb5fgL/CpjXYnMcQ1zGOBJdQXdlTRiuymv9Md
         f0/JzISVDkFytU/uV+Jv+mAHai2LcgbcZCDbr+tSXB0EFSBfcbATAqjmKQQkmg9W5UKz
         HEflrhVnrn8y94pY7rFHn+H/Te/eSoLC+cPl3XxYhvVwckOxWl7fNjJCqWvYImZcD0Uh
         UjTdTReX/k+r+nlQLcfbYXTc3ZjFteGuCK2GNf0C4aby6Ii1sKgmZxrb8N1pDCJiO/B4
         HkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4I3XaEZFrDQMej/rMbNooH3RuDCX+qLeL/xUfUf2+8U=;
        b=plunIJAlEMclafCG4FAfFy1tuK6Nh1uIUhjigOF4plCVOLmw+/GVDdzsTENvl6iuox
         XevGeVB9JC7i/iOC6Brh7hM2kNTGXUrBiTuQ5tP4hKDVsHh9xBWPw5igbPHqBC4fTfbu
         EKPeUjF/vrvJm6UJUfIaAkhBVUnxW1FnsfA1ZEEjUnAHI69eUkA4+n8GgV7JIR1eOja6
         6N6iuXwmDSH9LIrWgpWN19Zd2/M+9kvqIBK97bFL1vxRWHTPBjcP7ge5LiAf2W8QJylY
         ef3RtFUwkj01878U4YM3w0dQ+YRqZzSey0ds+iS3qQwan2cyIGXUOzN66SmTjmMdOjVd
         sYSg==
X-Gm-Message-State: AOAM532UUJ9Upot5zRWslP9VAraQ4ymdV71f+LktR7P26Cx2b3lRvrwh
        kn7LJ51/dDfMvUDIcICr4TRrMP4SJ6jHLSx0G5f0o+Ki4SRBsA==
X-Google-Smtp-Source: ABdhPJxrQj+ApG0f0TZSeBQoGXbmbA83U1YXYd+hhJ4MR8Wbp6xak9DP539zFArHNkvE1d8fnnfjCUhYHk/Qw7ShF8g=
X-Received: by 2002:a17:90a:540d:: with SMTP id z13mr870572pjh.150.1615595384799;
 Fri, 12 Mar 2021 16:29:44 -0800 (PST)
MIME-Version: 1.0
From:   Aboulfad <aboulfad69@gmail.com>
Date:   Fri, 12 Mar 2021 19:29:33 -0500
Message-ID: <CABzZvguFUUU7G6XR6aJCjKDxVt2R1mm9hTuAedLKYry+9UaLVQ@mail.gmail.com>
Subject: NFS support for exFAT
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

since exFAT is supported by Linux kernel > 5.7, I was hoping that NFS
can export an exFAT fs. Attempting to do so on exFAT mount yields the
following error:

      exportfs: /mnt/Movies does not support NFS export

I traced the above error to validate_export(nfs_export *exp) in
nfs-utils-1.3.4/utils/exportfs/exportfs.c

I have no knowledge of filesystem's but a I stumbled on a linux kernel
doc: nfs exporting.rst at
https://github.com/torvalds/linux/blob/927002ed29e2dda6dfacb87fe582d5495a03f096/Documentation/filesystems/nfs/exporting.rst

That page lists some conditions for making filesystems exportable, one
is to set s_export_op field in the struct super_block. Upon searching
in linux/fs/exfat/*, i couldn't find whether this condition was met.
Is there a technical reason why exFAT doesn't set that field and
others to announce it's an "exportable" filesystem ?

Thank you, Fadi
