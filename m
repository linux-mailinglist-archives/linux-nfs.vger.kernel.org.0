Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F176D4587B4
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Nov 2021 02:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhKVBQU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Nov 2021 20:16:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44998 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhKVBQT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Nov 2021 20:16:19 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 80E1C1FD49;
        Mon, 22 Nov 2021 01:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637543593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdhGEh1C/3modt2Tj02yaFcGj2HkfoBi8gtS/2MX9VA=;
        b=VfhPuHDNxvq/JK73wCBXqPnZ8sLTvnogDEx1tAnUH9I2Rt1oH9M5fJj9NPAolFgfuIGzI4
        QGD1OR1kYBQUQnmonkias8T/JPK9tYL09rZzF4bNDn4mFCNoWbNEEUeBAF1o9ylTeO4RgE
        iCqKji9bOpy40ndf7ss/e6/u72ps+Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637543593;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdhGEh1C/3modt2Tj02yaFcGj2HkfoBi8gtS/2MX9VA=;
        b=2B2JMlAYt7IWkwsfuawSsxb/sBo4d/60KkqIXQM7sAqQhzksclXX7fU3Pc7JBP7vuim4cG
        9HF/xsQVJ2GjeADA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6114A13466;
        Mon, 22 Nov 2021 01:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S7YiB6jummFvPQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 22 Nov 2021 01:13:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 00/14] SUNRPC: clean up server thread management.
In-reply-to: <20211122005901.GB12035@fieldses.org>
References: <163710954700.5485.5622638225352156964.stgit@noble.brown>,
 <20211117141231.GA24762@fieldses.org>,
 <163753863448.13692.4142092237119935826@noble.neil.brown.name>,
 <20211122005639.GA12035@fieldses.org>, <20211122005901.GB12035@fieldses.org>
Date:   Mon, 22 Nov 2021 12:13:08 +1100
Message-id: <163754358887.13692.5665882865660886756@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 22 Nov 2021, J. Bruce Fields wrote:
> On Sun, Nov 21, 2021 at 07:56:39PM -0500, J. Bruce Fields wrote:
> > On Mon, Nov 22, 2021 at 10:50:34AM +1100, NeilBrown wrote:
> > > On Thu, 18 Nov 2021, J. Bruce Fields wrote:
> > > > On Wed, Nov 17, 2021 at 11:46:49AM +1100, NeilBrown wrote:
> > > > > I have a dream of making nfsd threads start and stop dynamically.
> > > >=20
> > > > It's a good dream!
> > > >=20
> > > > I haven't had a chance to look at these at all yet, I just kicked off
> > > > tests to run overnight, and woke up to the below.
> > > >=20
> > > > This happened on the client, probably the first time it attempted to =
do
> > > > an nfsv4 mount, so something went wrong with setup of the callback
> > > > server.
> > >=20
> > > I cannot reproduce this and cannot see any way it could possible happen.
> >=20
> > Huh.  Well, it's possible I mixed up the results somehow.  I'll see if I
> > can reproduce tonight or tomorrow.
> >=20
> > > Could you please confirm the patches were applied on a vanilla 5.1.6-rc1
> > > kernel, and that you don't have the "pool_mode" module parameter set.
> >=20
> > /sys/module/sunrpc/parameters/pool_mode is "global", the default.
>=20
> Oh, and yes, this is what I was testing, should just be 5.16-rc1 plus
> your 14 patches:
>=20
> 	http://git.linux-nfs.org/?p=3Dbfields/linux-topics.git;a=3Dshortlog;h=3D65=
9e13af1f8702776704676937932f332265d85e

Thanks!

I did find a possible problem.  Very first patch.
in fs/nfsd/nfsctl.c, in _write_ports_addfd()
  if (!err && !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))

should be "err >=3D 0" rather than "!err".  That could result in a
use-after free, which can make anything explode.
If not too much trouble, could you just tweek that line and see what
happens?

Thanks,
NeilBrown
