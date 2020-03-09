Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E82017E147
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2020 14:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCINdr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Mar 2020 09:33:47 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42740 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgCINdq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Mar 2020 09:33:46 -0400
Received: by mail-oi1-f196.google.com with SMTP id l12so10105432oil.9;
        Mon, 09 Mar 2020 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ialzMb9unvo1blKnLREXVnt9D6XdD9BuSGr9u/eAjeE=;
        b=IHW6rpF93ev58libSB1Afl3/J/LVDIvD/tMa4UXKL3PyYR0I/Xu4u186tGquX7D4xt
         9GQaRt0/EreF41uU0VQtxCVaMldWwKRc8zugc2fnlsxp999xzL4fSMf8zqYYO92MXEMo
         jFI2Z4xLCTRqCxOGlxl7nY0NG4INdCE1fKxgcXLTZMqhZAqSgtjMo6f7Vuk8vVG3AO9+
         wCIZRcYfFpqqh8U1cJZlIV+iHu9r/4lhVheqE1+nojVvnh1j86GPRCVFrn4OQ+V5U1WO
         V9T2AWp5R6x54+JJl9FGTiIRTBNZqb4sY4Zx2S+AyD38Wp/vHW3IjiH3TreD35hglRRF
         qhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ialzMb9unvo1blKnLREXVnt9D6XdD9BuSGr9u/eAjeE=;
        b=oVCS2h83G87WQAUdw64Ly8/8KY/ZLXSaCsHnbOH3XzAfZxDybFiXDrBgppWqhDdMIo
         Hy1lM2OuFr8NRs84PwukrRXcZfwx1op38P/PYvJBmrxWG7NhxOTqvFIGNPMUUE9xrzvQ
         Ow4uGjJ4WDbYXKBVIc2dhFBvmLR5QZGSYHp7lYv+g4hG8EE8iioSfPtUm3GZQ3Crpvp1
         NB4LpPfyAjjZm+B6UpVn5zN0ttgxoUasPECL+5BimT8DmaEaQCtKwtZGOL7SA3SJ3OEs
         HYNrzocMCMnhs1OPl8hBJOMmfJMK50eaL5bHCq5D7x4oGKtIxkvGLrfW3SPcVYNQr9Wz
         z7FQ==
X-Gm-Message-State: ANhLgQ0SR1AMDNxoTJoWMosyTTCWU/LBePRqJhXPKbBXOvRnaRc33dta
        F9+3XfQ3BZuHmK+h6hRH1FjHgPwtbyYbZMhSB2I=
X-Google-Smtp-Source: ADFU+vvsjX0+xrIEhglXOyV1r2tonpOH5cAdpMu6kNvh/FJrMt+P+o3iU/hMmdxI0NML4mYoLN81a0JkvynVH10mA9o=
X-Received: by 2002:aca:ad54:: with SMTP id w81mr11596993oie.172.1583760825458;
 Mon, 09 Mar 2020 06:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200303225837.1557210-1-smayhew@redhat.com> <6bb287d1687dc87fe9abc11d475b3b9df061f775.camel@btinternet.com>
 <20200304143701.GB3175@aion.usersys.redhat.com> <CAEjxPJ7A1KRJ3+o0-edW3byYBSjGa7=KnU5QaYCiVt6Lq6ZfpA@mail.gmail.com>
 <20200306220132.GD3175@aion.usersys.redhat.com> <dc704637496883ac7c21c196aeae4e1ab37f76fa.camel@btinternet.com>
In-Reply-To: <dc704637496883ac7c21c196aeae4e1ab37f76fa.camel@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 9 Mar 2020 09:35:22 -0400
Message-ID: <CAEjxPJ6pLLGQ2ywfjkanDNZc1isVV8=6sJmoYFy8shaSGr972A@mail.gmail.com>
Subject: Re: [PATCH] NFS: Ensure security label is set for root inode
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Scott Mayhew <smayhew@redhat.com>, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, bfields@fieldses.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-nfs@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Mar 8, 2020 at 1:47 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Fri, 2020-03-06 at 17:01 -0500, Scott Mayhew wrote:
> > On Wed, 04 Mar 2020, Stephen Smalley wrote:
> > > I should note that we are getting similar errors though when trying
> > > to
> > > specify any context-related
> > > mount options on NFS via the new fsconfig(2) system call, see
> > > https://github.com/SELinuxProject/selinux-kernel/issues/49
> I've done further testing and found that with this patch the
> fsconfig(2) problem is also resolved for nfs (provided the rootcontext
> is not specified).

Excellent, two bugs fixed with one patch!

>>> It still needs some further
> > > enhancements as per
> > > https://github.com/SELinuxProject/selinux-testsuite/issues/32#issuecomment-582992492
> > > but it at least provides some degree of regression testing.
> Could you describe how I could test these, also are there any other
> SELinux tests that may be useful (with howto's). I'm almost ready to
> post another set of RFC test patches, but can add more.

The ones identified in that github issue comment would simply be
additional tests in tools/nfs.sh
unless they happen to already be covered by your fs/filesystem tests
once those are applied to the
host/native filesystem instead of just ext4.  The test cases are:

0. Test the bug fixed by this patch, i.e. perform mount of a
security_label exported filesystem, check the label of the mounted
directory to confirm it isn't unlabeled.
That's a NFS-specific test, goes in tools/nfs.sh.

1. Mount the same filesystem twice with two different sets of context
mount options, check that mount(2) fails with errno EINVAL.
Test cases might include a) mount first without any context mount
options, then try mounting a 2nd time with context mount options and
vice versa, b) mounting
with the same set of context options (e.g. both using context=) but
different context values, c) mounting with different sets of context
options (e.g. one uses
context=, the other uses fscontext=).  This test could be done in
fs/filesystem for any filesystem type, not NFS-specific.

2. Mount a security_label exported NFS filesystem twice, confirm that
NFS security labeling support isn't silently disabled by trying to
set a label on a file and confirm it is set (fixed by  kernel commit
3815a245b50124f0865415dcb606a034e97494d4).  This would go in
tools/nfs.sh
since it is NFS-specific.

3. Perform a context= mount of a security_label exported NFS
filesystem, check that pre-existing files within the mount show up
with the context= value
not the underlying xattr value (fixed by kernel commit
0b4d3452b8b4a5309b4445b900e3cec022cca95a). My original version of
tools/nfs.sh actually would have caught this because it was testing
the context of the nfs.sh script file itself within the context mount
but I dropped it back to only checking the top-level mount directory
when I moved tools/nfs.sh to avoid depending on a fixed location for
it, so it won't be caught currently. We could just change it back to
testing the context of a pre-existing file within the mount; any file
will do.  This would go in tools/nfs.sh, NFS-specific.

4. Ensuring that all of the tests/filesystem and tests/fs_filesystem
tests that make sense for NFS are being run on the labeled NFS mount
itself when run via tools/nfs.sh and not just on an ext4 mount created
by the test script.
