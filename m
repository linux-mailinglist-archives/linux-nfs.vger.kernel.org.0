Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E8A13D910
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 12:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgAPLeE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 06:34:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgAPLeD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Jan 2020 06:34:03 -0500
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DAAF207E0;
        Thu, 16 Jan 2020 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579174443;
        bh=YN8j+7TwUOddatueYP+sV+PGeo3r1YYN2GmB54ztjPY=;
        h=From:Date:Subject:To:Cc:From;
        b=lwY7747UA0/Ad4hTnw3SuGpIbJLCbA9KszNs9fiwKdqyA8sf4ZzW4ey+ZCN8L4OwB
         CiynAfoRzY8dRVxv86yNAEu37zYMydSQVQRJFex1tw24c+0+hbPqSRvwZwpyO6k/sP
         DXhHRJTxjpbom+9Fo99N0g4h4i8TfA4cyGiCTRbs=
Received: by mail-lf1-f52.google.com with SMTP id 9so15319076lfq.10;
        Thu, 16 Jan 2020 03:34:02 -0800 (PST)
X-Gm-Message-State: APjAAAVv71VuHjIYvykVbzn5rYJxyB4OhvzNmORfxVdukcBdjROUYksK
        Z+of5szNtiFnp+nWByuW+ZfEccpJ33r7XXI4oaU=
X-Google-Smtp-Source: APXvYqz815lAbzRqNAw2pY9/fYiNRD+W0UE/cSdNWD7dLJrFmYug7V2XJAKoNgovEbrpV53MUMWcopTLiK8WGABLR3k=
X-Received: by 2002:a19:ca0f:: with SMTP id a15mr2219060lfg.198.1579174440744;
 Thu, 16 Jan 2020 03:34:00 -0800 (PST)
MIME-Version: 1.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 16 Jan 2020 12:33:49 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
Message-ID: <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
Subject: [BISECT BUG] NFS v4 root not working after 6d972518b821 ("NFS: Add
 fs_context support.")
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

Bisect pointed to 6d972518b821 ("NFS: Add fs_context support.") for
failures of mounting NFS v4 root on my boards:
mount.nfs4 -o vers=4,nolock 192.168.1.10:/srv/nfs/odroidhc1 /new_root
[ 24.980839] NFS4: Couldn't follow remote path
[ 24.986201] NFS: Value for 'minorversion' out of range
mount.nfs4: Numerical result out of range

https://krzk.eu/#/builders/21/builds/1692
Full console log:
https://krzk.eu/#/builders/21/builds/1692/steps/14/logs/serial0

Enabling NFS v4.1 in defconfig seems to help. I can send patches for
this (for defconfigs) but probably the root cause should be fixed as
well.

Environment:
1. Arch ARM Linux
2. exynos_defconfig
3. Exynos boards (Odroid XU3, etc), ARMv7, octa-core (Cortex-A7+A15),
Exynos5422 SoC
4. systemd, boot up with static IP set in kernel command line
5. No swap
6. Kernel, DTB and initramfs are downloaded with TFTP
7. NFS root from NFSv4 server

Let me know if you need more details.

Best regards,
Krzysztof
