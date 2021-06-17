Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0C3AA956
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jun 2021 05:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhFQDEr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 23:04:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58334 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhFQDEr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 23:04:47 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 670DD1FD47;
        Thu, 17 Jun 2021 03:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623898959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xUwyQqvQWRsR3cJZZvYaYfcD1G2BlV87Tl4RRiU7xo=;
        b=X+K9wVl1BkG1jHJA1fzE2pdH4rVLI+fqUEx6Vg7K9USkuvGk8wYaLQ8zQkp7XwGzXOemjK
        OdxBnwknd/oMG6vhhDlVTDuwHjn/aA7RbWZZk/wpELS7/KkP4GFjUJGET13bKyJQn0g/NT
        4xURHmzSRX4llD7ZDiXKuhiIAAbGnIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623898959;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xUwyQqvQWRsR3cJZZvYaYfcD1G2BlV87Tl4RRiU7xo=;
        b=2rHgVetQtt7/yYxdHO/kXpuky0ONh/8jc21pzZ/s+Z2PvtWQBD3VrVqkAmZD10f4xstGru
        l561Vof6X3X/KqBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 648D0118DD;
        Thu, 17 Jun 2021 03:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623898959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xUwyQqvQWRsR3cJZZvYaYfcD1G2BlV87Tl4RRiU7xo=;
        b=X+K9wVl1BkG1jHJA1fzE2pdH4rVLI+fqUEx6Vg7K9USkuvGk8wYaLQ8zQkp7XwGzXOemjK
        OdxBnwknd/oMG6vhhDlVTDuwHjn/aA7RbWZZk/wpELS7/KkP4GFjUJGET13bKyJQn0g/NT
        4xURHmzSRX4llD7ZDiXKuhiIAAbGnIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623898959;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xUwyQqvQWRsR3cJZZvYaYfcD1G2BlV87Tl4RRiU7xo=;
        b=2rHgVetQtt7/yYxdHO/kXpuky0ONh/8jc21pzZ/s+Z2PvtWQBD3VrVqkAmZD10f4xstGru
        l561Vof6X3X/KqBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id fK1dBU67ymDoHQAALh3uQQ
        (envelope-from <neilb@suse.de>); Thu, 17 Jun 2021 03:02:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <20210615231318.F40F.409509F4@e16-tech.com>
References: <20210613115313.BC59.409509F4@e16-tech.com>,
 <162371103543.23575.13662722966178222587@noble.neil.brown.name>,
 <20210615231318.F40F.409509F4@e16-tech.com>
Date:   Thu, 17 Jun 2021 13:02:35 +1000
Message-id: <162389895501.29912.12470238090250719500@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 16 Jun 2021, Wang Yugui wrote:
> Hi, NeilBrown
>=20
> > On Sun, 13 Jun 2021, Wang Yugui wrote:
> > > Hi,
> > >=20
> > > Any idea about auto export multiple btrfs snapshots?
> > >=20
> > > One related patch is yet not merged to nfs-utils 2.5.3.
> > > From:   "NeilBrown" <neilb@suse.de>
> > > Subject: [PATCH/RFC v2 nfs-utils] Fix NFSv4 export of tmpfs filesystems.
> > >=20
> > > In this patch, an UUID is auto generated when a tmpfs have no UUID.
> > >=20
> > > for btrfs, multiple subvolume snapshot have the same filesystem UUID.
> > > Could we generate an UUID for btrfs subvol with 'filesystem UUID' + 'su=
bvol ID'?
> >=20
> > You really need to ask this question of btrfs developers.  'mountd'
> > already has a special-case exception for btrfs, to prefer the uuid
> > provided by statfs64() rather than the uuid extracted from the block
> > device.  It would be quite easy to add another exception.
> > But it would only be reasonable to do that if the btrfs team told us how
> > that wanted us to generate a UUID for a given mount point, and promised
> > that would always provide a unique stable result.
> > This is completely separate from the tmpfs patch you identified.
>=20
> Thanks a lot for the replay.
>=20
> Now btrfs statfs64() return 8 byte unique/stable result.
>=20
> It is based on two parts.
> 1) 16 byte blkid of file system. this is uniq/stable between btrfs filesyst=
ems.
> 2) 8 byte of btrfs sub volume objectid. this is uniq/stable inside a
> btrfs filesystem.
>=20
> the code of linux/fs/btrfs
> static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>=20
>     /* We treat it as constant endianness (it doesn't matter _which_)
>        because we want the fsid to come out the same whether mounted
>        on a big-endian or little-endian host */
>     buf->f_fsid.val[0] =3D be32_to_cpu(fsid[0]) ^ be32_to_cpu(fsid[2]);
>     buf->f_fsid.val[1] =3D be32_to_cpu(fsid[1]) ^ be32_to_cpu(fsid[3]);
>     /* Mask in the root object ID too, to disambiguate subvols */
>     buf->f_fsid.val[0] ^=3D
>         BTRFS_I(d_inode(dentry))->root->root_key.objectid >> 32;
>     buf->f_fsid.val[1] ^=3D
>         BTRFS_I(d_inode(dentry))->root->root_key.objectid;
>=20
>=20
> for nfs, we need a 16 byte UUID now.
>=20
> The best way I though:
> 16 byte blkid , math add 8 byte btrfs sub volume objectid.
> but there is yet no a simple/easy way to get the raw value of 'btrfs sub
> volume objectid'.

I'm a bit confused now.  You started out talking about snapshots, but
now you are talking about sub volumes.  Are they the same thing?

NFS export of btrfs sub volumes has worked for the past 10 years I
believe.

Can we go back to the beginning.  What, exactly, is the problem you are
trying to solve?  How can you demonstrate the problem?

NeilBrown


>=20
> A simple but good enough way:
> 1) first 8 byte copy from blkid
> 2) second 8 byte copy from btrfs_statfs()
> 	the uniq/stable of multiple subvolume inside a btrfs filesystem is kept.
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/06/15
>=20
>=20
