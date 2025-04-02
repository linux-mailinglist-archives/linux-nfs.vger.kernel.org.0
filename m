Return-Path: <linux-nfs+bounces-10985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ADFA785BD
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 02:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B69337A478A
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A53FC0A;
	Wed,  2 Apr 2025 00:34:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80EEEB5
	for <linux-nfs@vger.kernel.org>; Wed,  2 Apr 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743554055; cv=none; b=YUukQLFOUUkRjo+LPDETn91a6lYJ1Pk4cilosgL3upxgmZ8Wb/U9kGhaRV/yFAhlvg49yNIafx9k3oqiGbHDxeiDe34Ad56pyl2dbqBglpPMG15t+lTFzY6tzOKhxovimNVK188GuTpVo6Rp3s016MuTiI96uRsK7NQDMeNwSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743554055; c=relaxed/simple;
	bh=vj4gufxvy/GyW4IzEn5L/BHxXgAAVZEjsQ4g+STdBo4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pmasyEzump8i31sAY40QkJeowH5ugDbBrpke0N1YZRPgn1AkcssmWk1r/W4S6p2PnAnlELST7ubAsjQ28jv/n+1mh0pLuy/t6WqR7aRuBatmQ9PgC0RiOXZVTwkAMF10xupyRlTn96fr9Rbxv1xMQ0hSZhACXSe0YpKxpcqp3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tzm3Q-004Xb7-EI;
	Wed, 02 Apr 2025 00:34:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: mvogt1@gmail.com
Cc: linux-nfs@vger.kernel.org
Subject: Re: vers=4.1 in nfsmount.conf.d with Server
In-reply-to:
 <CAOE8yMCHGQ682xnzVq4DuJ_-AVfJ=jYvgpaTThvXK-XDs2TGKQ@mail.gmail.com>
References:
 <CAOE8yMCHGQ682xnzVq4DuJ_-AVfJ=jYvgpaTThvXK-XDs2TGKQ@mail.gmail.com>
Date: Wed, 02 Apr 2025 11:34:04 +1100
Message-id: <174355404420.9342.4570020393392290467@noble.neil.brown.name>

On Wed, 02 Apr 2025, mvogt1@gmail.com wrote:
> Hello,
> 
> 
> I have a netapp NFS server, from which I need to mount the NFS export
> with the client option:
> vers=4.1.
> 
> The reason is, that the server exports 4.2, but this has some issue
> with SSC therefore we need  to downgrade the client, which uses
> userspace copy in 4.1
> 
> For example, the fs5 export should be mounted like this:
> 
> fs5.domain.de:/vol/fs5_m_scratch on /m/scratch/space type nfs4
> (rw,nosuid,nodev,relatime,vers=4.1,rsize=65536,wsize=65536,..)
> 
> My idea was to use ("man nfsmount.conf")
> 
> [root@v110it01 nfsmount.conf.d]# pwd
> /etc/nfsmount.conf.d
> [root@v110it01 nfsmount.conf.d]# cat netapp.conf
> 
> 
> [ NFSMount_Global_Options ]
> Defaultvers=4.2
> 
> [ Server "fs5.domain.de" ]
> rsize=32768
> vers=4.1
> 
> [ Server "fs6.domain.de" ]
> vers=4.1
> 
> 
> This does not work, it uses vers=4.2.
> The only thing which seems to work reliably is to use the
> NFSMount_Global_Options.
> If it works, I can reverse the entries and then it does not work anymore.
> This is a bit strange, but its harder to reproduce a working mount,
> than a non working.
> 
> I monitor the mount with and then edit the file in another terminal
> 
> while true ; do
> 
>    mount fs5.domain.de:/vol/fs5_m_scratch /mnt/
>    mount | grep /mnt
>    sleep 4
>    umount /mnt
>    sleep 1
> done
> 
> If I add rsize, for fs5 this is used, but not the vers=4.1.
> If I change the name from fs6 to fs5 and have two fs5 entries it works too,
> as soon I change it back to fs6 the mount is vers=4.2.
> 
> This is verified for :
> 
> - nfs-utils-2.5.4-27.el9.x86_64 (el9)
> - bookworm (debian)
> 
> best regards,

This bug was fixed upstream just a few months ago:

Commit 307a75f56b56 ("conffile: add 'arg' argument to conf_remove_now()")

The fix will be in 2.8.3 which is not yet released.

If you ask your vendor nicely they might include the fix in an update,
or you could build from source yourself...

NeilBrown

