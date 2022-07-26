Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7212E580AA4
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 07:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiGZFCD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 01:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbiGZFCC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 01:02:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE35CE2A
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 22:02:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4758034B61;
        Tue, 26 Jul 2022 05:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658811720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0lJJLDRJACjPVVJ8KSa2Sgzh51LITR8rcE37QAxbNI=;
        b=nUqBPS93uaIg/sogXuMo2kUDdTmgdHUqjGty8XCw3/c76xXDyZTmfyIJVOD711i0E8YYF2
        3ZWNmFMT4Av357mjyvBqP2nGlz4YkV/MS0DECNhZx4aqB18NstICx0Shs2nFVZHByQ067j
        e/KAzFpHVWx+kHRE9d1jP0Up7qOreIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658811720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0lJJLDRJACjPVVJ8KSa2Sgzh51LITR8rcE37QAxbNI=;
        b=QguInsBaAbT+zGwovp8HuEjJvrLuUFQjyhPADO+ucAxGOPyYPDQ4G5DgVqfooh09J+WFZE
        PjxTy216CIN1kADw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E95113A12;
        Tue, 26 Jul 2022 05:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZrqsCkd132LoNAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Jul 2022 05:01:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Felipe Gasper" <felipe@felipegasper.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Supplementary GIDs?
In-reply-to: <4A964428-65EA-49D4-B7B4-35D22D89D418@felipegasper.com>
References: <4A964428-65EA-49D4-B7B4-35D22D89D418@felipegasper.com>
Date:   Tue, 26 Jul 2022 15:01:56 +1000
Message-id: <165881171619.4359.3075025793434550604@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 24 Jul 2022, Felipe Gasper wrote:
> Hello,
>=20
> 	I=E2=80=99m seeing two different behaviours between kernel NFS server vers=
ions in AlmaLinux 8 and Ubuntu 20. The following Perl demonstrates the issue:
>=20
> --------
> perl -MFile::Temp -Mautodie -Mstrict -e'my $fh =3D File::Temp::tempfile( DI=
R =3D> "/the/nfs/mount" ); my $mailgid =3D getgrnam "mail"; my ($uid, $gid) =
=3D (getpwnam "bin")[2,3]; chown $uid, $gid, $fh; $) =3D "$gid $mailgid"; $> =
=3D $uid; chown -1, $mailgid, $fh'
> --------
>=20
> 	What this does, as root, is:
>=20
> 1) Creates a file under /mnt, then deletes it, leaving the Linux file descr=
iptor open.
>=20
> 2) chowns the file to bin:bin.
>=20
> 3) Sets the process=E2=80=99s EUID & GUID to bin & bin/mail.
>=20
> 4) Does fchown( fd, -1, mailgid ).
>=20
> 	When the server is AlmaLinux 8, the above works. When the server is Ubuntu=
 20, it fails with EPERM. (The client is AlmaLinux 8 in both cases.) Both are=
 configured identically.
>=20
> 	Does anyone know of anything that changed fairly recently in the kernel=E2=
=80=99s NFS server that might affect this? I=E2=80=99ve done a packet capture=
 and confirmed that in both cases there=E2=80=99s an NFS SETATTR sent in an R=
PC 2.4 packet whose UID & GIDs match the process.
>=20

Is mountd on Ubuntu running with "--manage-gids"??  And is mountd on
AlmaLinux running without that flag?

That would explain the difference.

NeilBrown
