Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54987E8513
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 22:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjKJVcF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 16:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKJVcE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 16:32:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979864205
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 13:32:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACA63219B1;
        Fri, 10 Nov 2023 21:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699651919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXyG5uDLChD237NsUXX+2k/SyeNCA4ud8TUO89CgYAY=;
        b=uYsOedeAioAaOzz4I3j4jVF3Lim2P76Fc0hpvxmNAScDb4EtOmGKJKAvf6zTldzi7JiecT
        dmt4nr/ekFwl0wIQ7hJcLb2ttrHpchdo/yJe9recLCVygeBpE96tuId3AQfBUbQAYfA9cb
        kyzeWjMCZBrpNMO7fC5ykVAmbyjsNTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699651919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXyG5uDLChD237NsUXX+2k/SyeNCA4ud8TUO89CgYAY=;
        b=n2BQmdqbldBjPuMF697ocOsIeX5PFU9qZqbF+rvAos6khoat/IJviBVBtksTDoyKSsJmF7
        bSAAU03Q7DxvG+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 631A6138FC;
        Fri, 10 Nov 2023 21:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7o6uBk2hTmVfCwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 10 Nov 2023 21:31:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mahmoud Adam" <mngyadam@amazon.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
        "Mahmoud Adam" <mngyadam@amazon.com>
Subject: Re: [PATCH] nfsd: fix file memleak on client_opens_relaese
In-reply-to: <20231110182104.23039-1-mngyadam@amazon.com>
References: <20231110182104.23039-1-mngyadam@amazon.com>
Date:   Sat, 11 Nov 2023 08:31:52 +1100
Message-id: <169965191274.27227.708763777533834603@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 11 Nov 2023, Mahmoud Adam wrote:
> seq_release should be called to free the allocated seq_file
>=20
> Cc: stable@vger.kernel.org # v5.3+
> Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>

Fixes: 78599c42ae3c ("nfsd4: add file to display list of client's opens")
Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown
=20

> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4045c852a450..40415929e2ae 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2804,7 +2804,7 @@ static int client_opens_release(struct inode *inode, =
struct file *file)
>=20
>  	/* XXX: alternatively, we could get/drop in seq start/stop */
>  	drop_client(clp);
> -	return 0;
> +	return seq_release(inode, file);
>  }
>=20
>  static const struct file_operations client_states_fops =3D {
> --
> 2.40.1
>=20

