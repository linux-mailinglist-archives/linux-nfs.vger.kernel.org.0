Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F382FA825
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jan 2021 19:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407391AbhARR7P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jan 2021 12:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407386AbhARR7M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jan 2021 12:59:12 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07872C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jan 2021 09:58:32 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id m13so19106362ljo.11
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jan 2021 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XhgVXlb9kB87ntUQzqfOX3qX7Dwzh3dEBOLgNDUMlgk=;
        b=TM6eBvI3fHUMaaWIc8KXUxP0H/VXekFK54bgeQLsPQ1tuTduZJjoA351aolMBLbkFA
         Ru3cwzz2hhz/2KqO84BNOT7ZXNiZ35fIqsUSYMOlzWkydASwjSo3gSDet1AE/KMuk5B5
         zYRiapJEFPhZ9BrcM8rTactPy5t9gWUSmJolhsBqwdugnjaidCX5egGOAPxzNGox0Ywg
         RPogVhdW/II+UJOHyKtCueII6tRl6xDUuqKXvW1iHBD7zrTRT3i9cBgNXopmW4fQZz/x
         W+dJX2dUM0OXR0uBATlrN2OUv+5bj9gVf51XTCGi2p7tT8Tl8RNLtplyV20b8pC0uYYt
         r57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XhgVXlb9kB87ntUQzqfOX3qX7Dwzh3dEBOLgNDUMlgk=;
        b=Fpq0nxxMxVQaaR9Eb3jGN+Gpfy68bWOdXW0td48/6ldZ78JXJxTxe51fhOSXeMSnUy
         wHwqe8iPUSAV9DV97shpbFwfNm96svt7EZLKx332loYZKA54itBBZNH+24giEHZE7/XI
         +MZRRR6DsTE85NW2/QissPmCen0X6EwBfGqT8EAIAZ0aO5toLVEniHGYfu0wr5VcTwcS
         OeRu7pycTxDITc9Lyn51C+iyjk7sgZ9o6nRwX1XyliZV87zZ2lGi5FgMO/xjPs+VUoPl
         k4avJgq5Z+iveCu6b6BiCDvQNPvQ8c6F8zmKOAA9beabmSNiGf2z9BZrvyO01wvTCVZV
         Uznw==
X-Gm-Message-State: AOAM531ShykZD6ofiaw2vDz+2BYb/169GYi/kLPTHbR5cmTBKych8xT1
        Rb6RDamXagrNPglLNuIC8w1W7o4RWQa4XNFEPT71tfDtUgGdH+e5
X-Google-Smtp-Source: ABdhPJxq43x9JmgoGkKBEvoHJi8PBNfAVFnmYBRMCIm0rGcib0IW1budSOAmf52WfSC98u8/0xmtqSx4yHp1wOgOOZY=
X-Received: by 2002:a2e:b001:: with SMTP id y1mr342777ljk.257.1610992710181;
 Mon, 18 Jan 2021 09:58:30 -0800 (PST)
MIME-Version: 1.0
From:   Benjamin Maynard <benmaynard@google.com>
Date:   Mon, 18 Jan 2021 17:57:54 +0000
Message-ID: <CA+QRt4vb=DjgcOqGLtfdfKiDaqKED825xNpNyQaaK-df5tCSRQ@mail.gmail.com>
Subject: Linux 5.11 Kernel: NFS re-export errors with older nfs-utils package versions
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I was recently experimenting with NFS re-exporting using the new patch
set that is in the Linux 5.11 kernel
(https://patchwork.kernel.org/project/linux-nfs/list/?series=393561).

After applying these patches, I consistently faced an error when
trying to perform a previously working NFS re-export: "exportfs:
/files does not support NFS export".

I (with help from some other interested parties) began troubleshooting
and after stepping through each patch individually we identified that
the error only occurred when the following patch was applied:
https://patchwork.kernel.org/project/linux-nfs/patch/20201130220319.501064-3-trond.myklebust@hammerspace.com/.

This patch prevents re-exporting if subtree checking is enabled on the
originating NFS server. The strange thing was that no_subtree_check
export option was already set on the export from the originating NFS
Filer, but the error message persisted.

After lots of troubleshooting, eventually we tried updating NFS Utils
from 1.3.4 to 2.5.2 and we were able to successfully perform
re-export. It appears that the old version of the nfs-utils package
was the cause of the issue.

I appreciate that 1.3.4 is a very old version of nfs-utils, but it is
the default version that ships with Ubuntu and Debian and the error
message does not immediately point to the outdated version being the
cause of the problem.

I was wondering if it was possible to detail the requirement for a
more recent version of nfs-utils in the NFS Re-exporting section of
the Wiki (http://wiki.linux-nfs.org/wiki/index.php/NFS_re-export) to
help others who may encounter this problem in the future?


Kind Regards
Benjamin Maynard
