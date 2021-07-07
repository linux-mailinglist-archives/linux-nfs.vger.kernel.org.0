Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20F93BE085
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jul 2021 03:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhGGBPd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Jul 2021 21:15:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38044 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGGBPc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Jul 2021 21:15:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9353222407;
        Wed,  7 Jul 2021 01:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625620372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJ3MYeiZ7vBNM9G1dca6G6Do8ryDRe4dtBUsBt43xbc=;
        b=h/fXRJMyCwzFSZH7k/5v9kKIHEdTVcQH+WViehd/4YzJ+CpUFBZCtjz71OAfWan5QaM5wp
        FxNSee6c+erYQ8uvVWmZzps2FGXWTzfvXnGOY3oEPCBlrJMVK9TCSmZ4OBIJHIdr3i+Gpy
        xW7BOueRFnUxKdCsnyZ76UmOyJ+TMRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625620372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJ3MYeiZ7vBNM9G1dca6G6Do8ryDRe4dtBUsBt43xbc=;
        b=2bC29GzXFIaTuZnkQlAX4l32a3bRsObdbnnhnQFQ0uAvI+p5d206v0NMhY6lUctP9eCFwK
        nK6ghK+aqBBfp3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0D9913A1B;
        Wed,  7 Jul 2021 01:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k+mnJ5L/5GDlYAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 07 Jul 2021 01:12:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Daire Byrne" <daire@dneg.com>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <Anna.Schumaker@netapp.com>,
        "linux-nfs" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/rfc v2] NFS: introduce NFS namespaces.
In-reply-to: <CAPt2mGNOMh0uWozi=L5H6X7aKUuh_+-QxJ7OK9e6ELiKnSh1hg@mail.gmail.com>
References: <162458475606.28671.1835069742861755259@noble.neil.brown.name>,
 <162510089174.7211.449831430943803791@noble.neil.brown.name>,
 <CAPt2mGMgCHwvmy2MA4c2E316xVYPiRy4pRdcX4-1EAALfcxz+A@mail.gmail.com>,
 <162513954601.3001.5763461156445846045@noble.neil.brown.name>,
 <CAPt2mGNCV7Sh0uXA0ihpuSVcecXW=5cMUAfiS0tYr_cTQ0Du8w@mail.gmail.com>,
 <162535340922.16506.4184249866230493262@noble.neil.brown.name>,
 <CAPt2mGNOMh0uWozi=L5H6X7aKUuh_+-QxJ7OK9e6ELiKnSh1hg@mail.gmail.com>
Date:   Wed, 07 Jul 2021 11:12:47 +1000
Message-id: <162562036711.12832.7541413783945987660@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 07 Jul 2021, Daire Byrne wrote:
> On Sun, 4 Jul 2021 at 00:03, NeilBrown <neilb@suse.de> wrote:
> > > [  360.481824] ------------[ cut here ]------------
> > > [  360.483141] kernel BUG at mm/slub.c:4205!
> >
> > Thanks for testing!
> >
> > It misunderstood the use of kfree_const().  It doesn't work for
> > constants in modules, only constants in vmlinux.  So I guess you built
> > nfs as a module.
> >
> > This version should fix that.
> >
> > Thanks,
> > NeilBrown
>=20
> Yep, that was the issue and the latest patch certainly helped. I ran a
> few load tests and everything seemed to be working fine.
>=20
> However, once I tried mounting the same server again using a different
> namespace, I got a different looking crash under moderate load. I am
> pretty sure I applied your latest patch correctly, but I'll double
> check. I should probably remove some of the other patches I have
> applied too.
>=20
> # mount -o vers=3D4.2 server:/srv/export /mnt/server1
> # mount -o vers=3D4.2,namespace=3Dserver2 server:/srv/export /mnt/server2
>=20
> [ 3626.638077] general protection fault, probably for non-canonical
> address 0x375f656c6966ff00: 0000 [#1] SMP PTI
> [ 3626.640538] CPU: 9 PID: 12053 Comm: ls Not tainted 5.13.0-1.dneg.x86_64 =
#1
> [ 3626.642270] Hardware name: Red Hat dneg, BIOS
> 1.11.1-4.module_el8.2.0+320+13f867d7 04/01/2014
> [ 3626.644443] RIP: 0010:__kmalloc_track_caller+0xfa/0x480
> [ 3626.646138] Code: 65 4c 03 05 28 4d d5 69 49 83 78 10 00 4d 8b 20
> 0f 84 4c 03 00 00 4d 85 e4 0f 84 43 03 00 00 41 8b 47 28 49 8b 3f 48
> 8d 4a 01 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 bb 41
> 8b 47
> [ 3626.650253] RSP: 0018:ffffaadecf2afb90 EFLAGS: 00010206
> [ 3626.651747] RAX: 0000000000000000 RBX: 0000000000000006 RCX: 00000000000=
03d41
> [ 3626.653479] RDX: 0000000000003d40 RSI: 0000000000000cc0 RDI: 00000000000=
2fbe0
> [ 3626.655293] RBP: ffffaadecf2afbd0 R08: ffff985aabc6fbe0 R09: ffff985689c=
76b20
> [ 3626.657034] R10: ffff9858408a0000 R11: ffff985966e69ec0 R12: 375f656c696=
6ff00
> [ 3626.658794] R13: 0000000000000000 R14: 0000000000000cc0 R15: ffff9856800=
42200

The above Code: shows the crash happens at

  2a:*	49 8b 1c 04          	mov    (%r12,%rax,1),%rbx		<-- trapping instruct=
ion

and %r12 (which should be a memory address) is 375f656c6966ff00, which
contains ASCII "file_7".
So my guess is that a file name was copied into a buffer that had
already been freed.
This could be caused by a malloc bug somewhere else, but as the crash
was in readdir code, and shows evidence of a file name, it seems likely
that the bug is near by.  Do you have patches to anything that works
with file names?

NeilBrown
