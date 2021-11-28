Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C35460B47
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 00:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhK1Xyr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 18:54:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36042 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbhK1Xwr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 18:52:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E09EE1FD35;
        Sun, 28 Nov 2021 23:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638143369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPLJArbSATc/ClnitFF2Q+dmK00FGz5w+OpX3kVPBb0=;
        b=LyVX1iqJFyBbOjgLN1/rYRwKuF3EAKuu4jEDr5jF2q/wTh56keQ9jbRTN1JOiFY/V/AB0Q
        JF4azeiP38zj04tOC87sbfCdFxldulNGCOLLjQbYdfGJ0L7yvlszvme71/TrEj+4jI0X93
        hRm3fTXWtYLB1jTWF8Xukl7wq3zH0HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638143369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPLJArbSATc/ClnitFF2Q+dmK00FGz5w+OpX3kVPBb0=;
        b=rYiQmQk+5HLb8P8jJuPEq7HE4H85SfjnC3HenQF/NICOID9NIQITONh2d0Akda/Q7hoUsB
        WpT27v9lRoRe/tBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA8A8133D1;
        Sun, 28 Nov 2021 23:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uMskGIgVpGGWIQAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 28 Nov 2021 23:49:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 02/19] NFSD: handle error better in write_ports_addfd()
In-reply-to: <3B93593B-861F-4816-9259-EBB20FDB4375@oracle.com>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>,
 <163763097543.7284.12067402792054742606.stgit@noble.brown>,
 <3B93593B-861F-4816-9259-EBB20FDB4375@oracle.com>
Date:   Mon, 29 Nov 2021 10:49:25 +1100
Message-id: <163814336542.26075.9044219405065931614@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 24 Nov 2021, Chuck Lever III wrote:
>=20
> > On Nov 22, 2021, at 8:29 PM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > If write_ports_add() fails, we shouldn't destroy the serv, unless we had
> > only just created it.  So if there are any permanent sockets already
> > attached, leave the serv in place.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> This needs to go at the front of the series, IMO, to make it
> more straightforward to backport if needed.

That's reasonable.

>=20
> Though ea068bad27ce ("NFSD: move lockd_up() before svc_addsock()")
> appears to have introduced "if (err < 0)" I'm not sure that's
> actually where problems were introduced. Is Cc: stable warranted?

I don't think Cc: stable is warranted.  I think far too much goes to
'stable', but also not enough....  So I'm selective.

The problem fixed is barely a bug - just a minor inconvenience.
In practice, svc_addsock() doesn't fail, because it is never asked to do
something that it cannot do.  So handling failure graceful will only be
noticed by someone who is doing strange things.
So while we should definitely fix it, I'm not inclined to backport the
fix.=20

BTW, I think the "bug" was introduced in Commit 0cd14a061e32 ("nfsd: fix
error handling in __write_ports_addxprt"), which fixed a different
(real) bug introduced by the patch you identified.

Thanks,
NeilBrown

>=20
>=20
> > ---
> > fs/nfsd/nfsctl.c |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 5eb564e58a9b..93d417871302 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -742,7 +742,7 @@ static ssize_t __write_ports_addfd(char *buf, struct =
net *net, const struct cred
> > 		return err;
> >=20
> > 	err =3D svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cr=
ed);
> > -	if (err < 0) {
> > +	if (err < 0 && list_empty(&nn->nfsd_serv->sv_permsocks)) {
> > 		nfsd_put(net);
> > 		return err;
> > 	}
> >=20
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
