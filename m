Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653C53983B3
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhFBIAT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 04:00:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFBIAT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 04:00:19 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D9B311FD32;
        Wed,  2 Jun 2021 07:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622620715;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UOVaXcIncPNxMyO0oVRv3igaflsZ+FOZ3+ni4HO/AUU=;
        b=kBdhJuTQRrGggFT+c1GzGCozlcXmtWVseIqFzob4Rt8scKhHdZNEaXirp1dpCTlUmvMOGg
        t90wSZfKeJtR7X4WwMc2mBga1F5WV924bMN7HwRag1Nv41v36SrHwiIjmPHiRA7SKb4h9W
        z9Fu1qIqpfumUAWjCe3dzYzaF64wPnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622620715;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UOVaXcIncPNxMyO0oVRv3igaflsZ+FOZ3+ni4HO/AUU=;
        b=JfjzfjJi7gyNJdSAJ4z6Z+o76SRp11SOkB9rTWD+AeBDdo7tob4vpFyd33AMKfBn4RjEXm
        i8tuyzRahk3zYhBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6230F118DD;
        Wed,  2 Jun 2021 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622620715;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UOVaXcIncPNxMyO0oVRv3igaflsZ+FOZ3+ni4HO/AUU=;
        b=kBdhJuTQRrGggFT+c1GzGCozlcXmtWVseIqFzob4Rt8scKhHdZNEaXirp1dpCTlUmvMOGg
        t90wSZfKeJtR7X4WwMc2mBga1F5WV924bMN7HwRag1Nv41v36SrHwiIjmPHiRA7SKb4h9W
        z9Fu1qIqpfumUAWjCe3dzYzaF64wPnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622620715;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UOVaXcIncPNxMyO0oVRv3igaflsZ+FOZ3+ni4HO/AUU=;
        b=JfjzfjJi7gyNJdSAJ4z6Z+o76SRp11SOkB9rTWD+AeBDdo7tob4vpFyd33AMKfBn4RjEXm
        i8tuyzRahk3zYhBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id JUelMCo6t2DBcAAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Wed, 02 Jun 2021 07:58:34 +0000
Date:   Wed, 2 Jun 2021 09:58:33 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Yong Sun <yosun@suse.com>
Subject: Re: pynfs: [NFS 4.0] SEC7, LOCK24 test failures
Message-ID: <YLc6KQA24xVkkvd5@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <YLY9pKu38lEWaXxE@pevik>
 <YLZS1iMJR59n4hue@pick.fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLZS1iMJR59n4hue@pick.fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

thanks a lot for valuable info.

> On Tue, Jun 01, 2021 at 04:01:08PM +0200, Petr Vorel wrote:
> > I've also find different failures on NFS 4.0:

> > SEC7     st_secinfo.testRPCSEC_GSS                                : FAILURE
> >            SECINFO returned mechanism list without RPCSEC_GSS

> That shouldn't be run by default; see patch, appended.

+1, thanks for a quick fix (disabling it for all).
I'll have a look into testd what needs to be enabled (I have
CONFIG_RPCSEC_GSS_KRB5=m and have changed the default sec to
sec=sys,krb5,krb5i,krb5p, but it didn't help).

> > LOCK24   st_lock.testOpenUpgradeLock                              : FAILURE
> >            OP_LOCK should return NFS4_OK, instead got
> >            NFS4ERR_BAD_SEQID

> I suspect the server's actually OK here, but I need to look more
> closely.

Thanks a lot!

> > They're on stable kernel 5.12.3-1-default (openSUSE). I saw them also on older
> > kernel 4.19.0-16-amd64 (Debian).

> > Any idea how to find whether are these are wrong setup or test bugs or real
> > kernel bugs?

> For what it's worth, this is what I do as part of my regular regression
> tests, for 4.0:

> 	http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-pynfs;h=4ed0f7942b9ff0907cbd3bb0ec1643dad02758f5;hb=HEAD

> and for 4.1:

> 	http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=bin/do-pynfs41;h=b3afc60dfab17aa5037d3f587d3d113bc772970e;hb=HEAD

> There are some known 4.0 failures that I skip:
> 	http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=data/pynfs-skip;h=44256bb26e3fae86572e7c7057b1889652fa014b;hb=HEAD

> (But LOCK24 isn't on that list because I keep saying I'm going to triage
> it....)

> And for 4.1:
> 	http://git.linux-nfs.org/?p=bfields/testd.git;a=blob;f=data/pynfs41-skip;h=c682bed97742cf799b94364872c7575ac9fc188c;hb=HEAD

Thank you, having scripts with comments is very much appreciated :).
Maybe some of the info or even setup could be moved to pynfs git repository
(to have some setup done by tests). Or testd could be mentioned in pynfs README
as testd is not pynfs specific (uses more testsuites - lock-tests, cthon04 and
even xfstests-dev)

...

Kind regards,
Petr
