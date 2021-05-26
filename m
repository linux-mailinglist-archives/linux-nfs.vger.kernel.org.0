Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11D839103B
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 07:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhEZF60 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 May 2021 01:58:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:32992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232430AbhEZF6Z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 26 May 2021 01:58:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622008612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAzFFbJec2ShGzZjHO75IQKlhvpl4RmReDtGixaHjSE=;
        b=AQjUsvtirBoP7qvV6dJOlUtx+rQ3SJpRZt6VzW8Ho+30FLBvmeQB06t5gkBm7W3vRfgrD2
        d1khl6Xt2kLYGCiWcCWcHhSN4hEiJikq7N/FxAjgFfbXUhygQQ2dcMUr8fYPtLFCXOXTKi
        ycrCd0e9t3DqcBxyFioGjBzJcCBzyF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622008612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dAzFFbJec2ShGzZjHO75IQKlhvpl4RmReDtGixaHjSE=;
        b=ysuR2cL9INGaS0xPprhz9VvAh7i2z9OuSwL3M9RMxK3/cKLxQwZ7ZGR2kokBF4/TLOWF2m
        La0iK4G4ukc3CDAQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D9E1B1B1;
        Wed, 26 May 2021 05:56:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Scott Andrews" <scott.andrews@columbus.rr.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: mount.nfs: Stale file handle
In-reply-to: <82edf12a-a9fa-49a7-bdd0-1689c70a3a5f@columbus.rr.com>
References: <82edf12a-a9fa-49a7-bdd0-1689c70a3a5f@columbus.rr.com>
Date:   Wed, 26 May 2021 15:56:47 +1000
Message-id: <162200860728.22484.2002016024131091474@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 May 2021, Scott Andrews wrote:
>=20
> cat /proc/fs/nfs/exports
> # Version 1.1
> # Path Client(Flags) # IPs
> /=20
> *(ro,no_root_squash,sync,no_wdelay,no_subtree_check,v4root,fsid=3D0,uuid=3D=
6b179096:b8b5495a:873908b5:a2b35faa,sec=3D390003:390004:390005:1)
> /home=20
> *(rw,no_root_squash,sync,wdelay,uuid=3D6b179096:b8b5495a:873908b5:a2b35faa,=
sec=3D1)
>=20

Apart from the error, this is the only place that anything looks odd.
When / is exported a v4root, there doesn't need to be a uuid=3D.
It is the same uuid as for /home.
When I experiment I don't get a uuid=3D for /.

I don't know that this would cause a problem, but maybe it does.

Two extra pieces of debugging info that might be useful:

1/ Get a network trace for port 2049 traffic between client and server
 with tcpdump.
 Be sure to use "-s 0" and provide the binary packet capture - compress
 it and attach it to the email.

2/ Before attempting the mount, and after restarting rpc.mountd on the
server and running "exportfs -f", run "strace -s 1000 -o /tmp/somefile -p ...=
" on the
rpc.mountd process, then try the mount, then kill strace.
Then provide /tmp/somefile.

NeilBrown


>=20
> Can someone help with this issue?
>=20
> Thanks for any help/direction you may have
>=20
>=20
