Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC177460B75
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 01:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhK2AQj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 19:16:39 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36376 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344051AbhK2AOj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 19:14:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BD361FCA1;
        Mon, 29 Nov 2021 00:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638144681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rBqmfRfplaAiY6rbQnl7diO7Ztk88TE2lFRdEo747I=;
        b=fZdpvdsKmNyGTypLdLR4IhyEvkcVcEaqRngHL1lbq1ak5WTmhgnZgbAxtSSBdxFBFNU5g+
        cEDEOPKYNEgIv5iJrnG2edbR9YEAKAoIZfcJ93+WJPgkkeCpMjWQXhZMH53t6xaNTgYm9C
        DTp8mFoVpAkQKfRgMlljTrn/tCD4upI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638144681;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rBqmfRfplaAiY6rbQnl7diO7Ztk88TE2lFRdEo747I=;
        b=FfXcm5soy02NA0PYewx0UCDr1/L+7r4Ji59OlcqZAMUp0hXrP8/jvXLDltrLdYWQagz0eY
        L5ZUyQjmKMWvu8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74266133FE;
        Mon, 29 Nov 2021 00:11:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X6yiDKgapGHmJwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Nov 2021 00:11:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 05/19] SUNRPC: use sv_lock to protect updates to sv_nrthreads.
In-reply-to: <3877F926-545B-41AF-8C0C-80582E83F1FE@oracle.com>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>,
 <163763097544.7284.15751243743215653521.stgit@noble.brown>,
 <3877F926-545B-41AF-8C0C-80582E83F1FE@oracle.com>
Date:   Mon, 29 Nov 2021 11:11:17 +1100
Message-id: <163814467728.26075.9969415181039584323@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 24 Nov 2021, Chuck Lever III wrote:
> > @@ -639,7 +639,10 @@ svc_prepare_thread(struct svc_serv *serv, struct svc=
_pool *pool, int node)
> > 		return ERR_PTR(-ENOMEM);
> >=20
> > 	svc_get(serv);
> > -	serv->sv_nrthreads++;
> > +	spin_lock_bh(&serv->sv_lock);
> > +	serv->sv_nrthreads +=3D 1;
> > +	spin_unlock_bh(&serv->sv_lock);
>=20
> atomic_t would be somewhat lighter weight. Can it be used here
> instead?
>=20

We could....  but sv_nrthreads is read-mostly.  There are 11 places
where we would need to call "atomic_read()", and just two where we
benefit from the simplicity of atomic_inc/dec.

And even if I did achieve dynamic threads count management, we would not
be changing sv_nrthreads often enough that any performance difference
would be noticeable.
So I'd rather stick with using the spinlock and keeping the read-side
simple.

Thanks,
NeilBrown
