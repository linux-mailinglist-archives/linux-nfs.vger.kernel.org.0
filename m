Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0355570CE70
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 01:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjEVXHt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 May 2023 19:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjEVXHr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 May 2023 19:07:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A951F11A;
        Mon, 22 May 2023 16:07:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4EE5C2007D;
        Mon, 22 May 2023 23:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684796859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7hz+VLyYLZiSKJ1OVKSFd8L2NCNioFTMNx7Kd6MvZ0=;
        b=SOCCvWBrbhcKQrpvjcrirLCuRk1L57b63gO2/pADOXCnVPUDZrxX0yOvo9gRa93pMUMCbE
        jg45dyvX0DLMIYHQOjMdDVwd0lVDuO/JU1JBBtGm3L2ZbsMKK02BvpZAnl7iJJ1rM55uww
        J3ZApARkbp4mT268b4Q42e5oiDk4JBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684796859;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7hz+VLyYLZiSKJ1OVKSFd8L2NCNioFTMNx7Kd6MvZ0=;
        b=2r9piMn4xDTko8q0I1m/hnVg4C4nLw19R4kU2TQhQ+T9+aRU4xIWS8NryYZ9TxKQsIlIU8
        iKlrDp8+4dNRxGDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FD2213336;
        Mon, 22 May 2023 23:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EmM6Ern1a2TmCAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 22 May 2023 23:07:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Zhi Li" <yieli@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: make a copy of struct iattr before calling notify_change
In-reply-to: <20230517162645.254512-1-jlayton@kernel.org>
References: <20230517162645.254512-1-jlayton@kernel.org>
Date:   Mon, 22 May 2023 12:45:37 +1000
Message-id: <168472353748.5298.2381558773846767023@noble.neil.brown.name>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 18 May 2023, Jeff Layton wrote:
> notify_change can modify the iattr structure. In particular it can can
> end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causing a
> BUG() if the same iattr is passed to notify_change more than once.
>=20
> Make a copy of the struct iattr before calling notify_change.
>=20
> Fixes: 34b91dda7124 NFSD: Make nfsd4_setattr() wait before returning NFS4ER=
R_DELAY
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2207969
> Reported-by: Zhi Li <yieli@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index c4ef24c5ffd0..ad0c5cd900b1 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -538,7 +538,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> =20
>  	inode_lock(inode);
>  	for (retries =3D 1;;) {
> -		host_err =3D __nfsd_setattr(dentry, iap);
> +		struct iattr attrs =3D *iap;
> +
> +		host_err =3D __nfsd_setattr(dentry, &attrs);

I think this needs something to ensure a well meaning by-passer doesn't
try to "optimise" it back to the way it was.
Maybe make "iap" const?  Or add a comment?  Or both?

NeilBrown


>  		if (host_err !=3D -EAGAIN || !retries--)
>  			break;
>  		if (!nfsd_wait_for_delegreturn(rqstp, inode))
> --=20
> 2.40.1
>=20
>=20

