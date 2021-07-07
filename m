Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1893BF25F
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jul 2021 01:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhGGXVt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 19:21:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38180 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhGGXVs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jul 2021 19:21:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 479202218A;
        Wed,  7 Jul 2021 23:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625699940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOi6N9HLzqA6yFpmumrD0uLY4aONCxJ20wIMR1x8aBs=;
        b=ADCvoXrJzDGpXMnDQBjKmrWoDhghMSrDj1wW1Z+nTq/9hV2nW2FxkB8HGTC6nSdrXQPtsz
        ZExIP5R5PAQFLetGL0Mhy3vFTLAT/Hfs4rr5/f1keUkx3hiHAXT6/zdMTV5wglvDm37QSU
        qCPJfGduRxL0ATto88mYRUG83JR4wuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625699940;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOi6N9HLzqA6yFpmumrD0uLY4aONCxJ20wIMR1x8aBs=;
        b=CZLBfB85vooNs5tSkdCrQmtVvgabKQIX81b68JkWBX0Nc6kWzNqXqg9SPqXMGZEuIOwtsf
        vq6KZSyzKGuwGFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB37013AE6;
        Wed,  7 Jul 2021 23:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LYLCFmI25mC6KAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 07 Jul 2021 23:18:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Daire Byrne" <daire@dneg.com>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <Anna.Schumaker@netapp.com>,
        "linux-nfs" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/rfc v2] NFS: introduce NFS namespaces.
In-reply-to: <CAPt2mGPSeK6YHPQ8r6Z0UJv4mJnRAcEEc4VmLaENo91-K8P=fQ@mail.gmail.com>
References: <162458475606.28671.1835069742861755259@noble.neil.brown.name>,
 <162510089174.7211.449831430943803791@noble.neil.brown.name>,
 <CAPt2mGMgCHwvmy2MA4c2E316xVYPiRy4pRdcX4-1EAALfcxz+A@mail.gmail.com>,
 <162513954601.3001.5763461156445846045@noble.neil.brown.name>,
 <CAPt2mGNCV7Sh0uXA0ihpuSVcecXW=5cMUAfiS0tYr_cTQ0Du8w@mail.gmail.com>,
 <162535340922.16506.4184249866230493262@noble.neil.brown.name>,
 <CAPt2mGNOMh0uWozi=L5H6X7aKUuh_+-QxJ7OK9e6ELiKnSh1hg@mail.gmail.com>,
 <162562036711.12832.7541413783945987660@noble.neil.brown.name>,
 <CAPt2mGM6mcqM9orzHuyTVgX2pnG5Y7nLeM85tdZ5LoDO9XozBA@mail.gmail.com>,
 <162569314954.31036.11087071768390664533@noble.neil.brown.name>,
 <CAPt2mGPSeK6YHPQ8r6Z0UJv4mJnRAcEEc4VmLaENo91-K8P=fQ@mail.gmail.com>
Date:   Thu, 08 Jul 2021 09:18:55 +1000
Message-id: <162569993532.31036.942509527308749032@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 08 Jul 2021, Daire Byrne wrote:
> On Wed, 7 Jul 2021 at 22:25, NeilBrown <neilb@suse.de> wrote:
> >
> > That's pretty solid evidence!
> >
> > I just realized that the stack trace you reported mentions
> > "kfree_const()".
> > My latest patch doesn't include that, and nfs doesn't use it at all.
> > Might you still be using the older patch?
> >
> > NeilBrown
>=20
> Oh... the last stack trace, the readdir one? I don't see kfree_const
> myself but I may have a case of word blindness. The first one I
> reported definitely has kfree_const but after your latest patch, this
> last one around readdir doesn't seem to?
>=20
> I'm pretty sure I have your latest patch (with kfree instead of
> kfree_const) correctly applied. Though, I will double check that the
> correct kernel and modules were then installed properly on my test VM.

sorry - my bad..

I think I've found it.  Rather than sending the whole patch, here is the
incremental fix.  But not clearing this pointer, I risk the value in it
being freed twice.  That might lead to what you saw.

Thanks,
NeilBrown



diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 7c644a31d304..9e34af223ce6 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1451,6 +1451,7 @@ static int nfs_fs_context_dup(struct fs_context *fc, st=
ruct fs_context *src_fc)
 	ctx->nfs_server.export_path	=3D NULL;
 	ctx->nfs_server.hostname	=3D NULL;
 	ctx->fscache_uniq		=3D NULL;
+	ctx->namespace			=3D NULL;
 	ctx->clone_data.fattr		=3D NULL;
 	fc->fs_private =3D ctx;
 	return 0;

