Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000D33B13F8
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jun 2021 08:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFWGcN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Jun 2021 02:32:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37192 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWGcN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Jun 2021 02:32:13 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A38C51FD66;
        Wed, 23 Jun 2021 06:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624429795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmAiskZd/vs0XSaJ9nAgthxFn+dUfAT5CpO6dhxYRcw=;
        b=K8sjMEZAP4iihYb1XLyOYx0ZwuXSP+QR6GmenPpABY5kAYT2bEio1GL+I0Tjkqi0xB3ZrY
        T6ZD3QY4Ok7KIV+6qw/P0DQKuaocchlg7IbFoIntfowMW3wvlZRZ0WKS7EqUXokWkgFdkd
        39MraQCpgoCauQA6UPfONECaoGPbenk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624429795;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmAiskZd/vs0XSaJ9nAgthxFn+dUfAT5CpO6dhxYRcw=;
        b=el8oDazQ78NQWW6wh32Sz/v3OZnWw298Fp5N1J5Q4AgNMK0AanstRHpirWugqqN922IXTy
        M/DUgOG4dbsHhsDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A514F11A97;
        Wed, 23 Jun 2021 06:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624429795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmAiskZd/vs0XSaJ9nAgthxFn+dUfAT5CpO6dhxYRcw=;
        b=K8sjMEZAP4iihYb1XLyOYx0ZwuXSP+QR6GmenPpABY5kAYT2bEio1GL+I0Tjkqi0xB3ZrY
        T6ZD3QY4Ok7KIV+6qw/P0DQKuaocchlg7IbFoIntfowMW3wvlZRZ0WKS7EqUXokWkgFdkd
        39MraQCpgoCauQA6UPfONECaoGPbenk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624429795;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmAiskZd/vs0XSaJ9nAgthxFn+dUfAT5CpO6dhxYRcw=;
        b=el8oDazQ78NQWW6wh32Sz/v3OZnWw298Fp5N1J5Q4AgNMK0AanstRHpirWugqqN922IXTy
        M/DUgOG4dbsHhsDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id szocFuLU0mCCZgAALh3uQQ
        (envelope-from <neilb@suse.de>); Wed, 23 Jun 2021 06:29:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <20210623141444.C4F2.409509F4@e16-tech.com>
References: <20210622151407.C002.409509F4@e16-tech.com>,
 <162440994038.28671.7338874000115610814@noble.neil.brown.name>,
 <20210623141444.C4F2.409509F4@e16-tech.com>
Date:   Wed, 23 Jun 2021 16:29:51 +1000
Message-id: <162442979121.28671.4357679695701460832@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 23 Jun 2021, Wang Yugui wrote:
> Hi,
>=20
> This patch works very well. Thanks a lot.
> -  crossmnt of btrfs subvol works as expected.
> -  nfs/umount subvol works well.
> -  pseudo mount point inode(255) is good.
>=20
> I test it in 5.10.45 with a few minor rebase.
> ( see 0001-any-idea-about-auto-export-multiple-btrfs-snapshots.patch,
> just fs/nfsd/nfs3xdr.c rebase)
>=20
> But when I tested it with another btrfs system without subvol but with
> more data, 'find /nfs/test' caused a OOPS .  and this OOPS will not
> happen just without this patch.
>=20
> The data in this filesystem is created/left by xfstest(FSTYP=3Dnfs,
> TEST_DEV).
>=20
> #nfs4 option: default mount.nfs4, nfs-utils-2.3.3
>=20
> # access btrfs directly
> $ find /mnt/test | wc -l
> 6612
>=20
> # access btrfs through nfs
> $ find /nfs/test | wc -l
>=20
> [  466.164329] BUG: kernel NULL pointer dereference, address: 0000000000000=
004
> [  466.172123] #PF: supervisor read access in kernel mode
> [  466.177857] #PF: error_code(0x0000) - not-present page
> [  466.183601] PGD 0 P4D 0
> [  466.186443] Oops: 0000 [#1] SMP NOPTI
> [  466.190536] CPU: 27 PID: 1819 Comm: nfsd Not tainted 5.10.45-7.el7.x86_6=
4 #1
> [  466.198418] Hardware name: Dell Inc. PowerEdge T620/02CD1V, BIOS 2.9.0 1=
2/06/2019
> [  466.206806] RIP: 0010:fsid_source+0x7/0x50 [nfsd]

in nfsd4_encode_fattr there is code:

	if ((bmval0 & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) && !fhp) {
		tempfh =3D kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
		status =3D nfserr_jukebox;
		if (!tempfh)
			goto out;
		fh_init(tempfh, NFS4_FHSIZE);
		status =3D fh_compose(tempfh, exp, dentry, NULL);
		if (status)
			goto out;
		fhp =3D tempfh;
	}

Change that to test for (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) as
well.

NeilBrown
