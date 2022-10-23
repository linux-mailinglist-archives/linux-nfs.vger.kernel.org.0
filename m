Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA916096F5
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Oct 2022 00:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJWWLf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Oct 2022 18:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJWWLe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Oct 2022 18:11:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE3C5F9B9
        for <linux-nfs@vger.kernel.org>; Sun, 23 Oct 2022 15:11:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98C0521FCE;
        Sun, 23 Oct 2022 22:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666563091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=12hSpTlo9GK3v/aqOqEilAXf7PWrnUMftzxIi9+vcK8=;
        b=2Wf+8XR5PBQwRf2JbTI/TK/+udGupsKuISlbq/B5o/CPy5KG93KgecrF8WcI6OaYWbNaRo
        lXcHHWDkYnq6CGDE/lwmTGvwenXq4iSW0uaV9F+MciBgbFIxUghBVHCGJQFPuCTsxopVJG
        niQLRGNtQ/9IDVxDn+863CTJCDVjBnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666563091;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=12hSpTlo9GK3v/aqOqEilAXf7PWrnUMftzxIi9+vcK8=;
        b=NOPhB3rRNHpslNHHiZ9ZrPmN0EIJ+N0qEslFnf+m7QeSg0E5gX3TAg1z1oPSnwbTCPtoZu
        yXrbw2pCE4wQ2KBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E14613A3B;
        Sun, 23 Oct 2022 22:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8CfBABK8VWOtVgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 23 Oct 2022 22:11:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "David Disseldorp" <ddiss@suse.de>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "David Disseldorp" <ddiss@suse.de>
Subject: Re: [PATCH] exportfs: use pr_debug for unreachable debug statements
In-reply-to: <20221021122414.20555-1-ddiss@suse.de>
References: <20221021122414.20555-1-ddiss@suse.de>
Date:   Mon, 24 Oct 2022 09:11:27 +1100
Message-id: <166656308707.12462.9861114416829680469@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 21 Oct 2022, David Disseldorp wrote:
> expfs.c has a bunch of dprintk statements which are unusable due to:
>  #define dprintk(fmt, args...) do{}while(0)
> Use pr_debug so that they can be enabled dynamically.
> Also make some minor changes to the debug statements to fix some
> incorrect types, and remove __func__ which can be handled by dynamic
> debug separately.
>=20
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

> ---
>  fs/exportfs/expfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index c648a493faf23..3204bd33e4e8a 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -18,7 +18,7 @@
>  #include <linux/sched.h>
>  #include <linux/cred.h>
> =20
> -#define dprintk(fmt, args...) do{}while(0)
> +#define dprintk(fmt, args...) pr_debug(fmt, ##args)
> =20
> =20
>  static int get_name(const struct path *path, char *name, struct dentry *ch=
ild);
> @@ -132,8 +132,8 @@ static struct dentry *reconnect_one(struct vfsmount *mn=
t,
>  	inode_unlock(dentry->d_inode);
> =20
>  	if (IS_ERR(parent)) {
> -		dprintk("%s: get_parent of %ld failed, err %d\n",
> -			__func__, dentry->d_inode->i_ino, PTR_ERR(parent));
> +		dprintk("get_parent of %lu failed, err %ld\n",
> +			dentry->d_inode->i_ino, PTR_ERR(parent));
>  		return parent;
>  	}
> =20
> @@ -147,7 +147,7 @@ static struct dentry *reconnect_one(struct vfsmount *mn=
t,
>  	dprintk("%s: found name: %s\n", __func__, nbuf);
>  	tmp =3D lookup_one_unlocked(mnt_user_ns(mnt), nbuf, parent, strlen(nbuf));
>  	if (IS_ERR(tmp)) {
> -		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
> +		dprintk("lookup failed: %ld\n", PTR_ERR(tmp));
>  		err =3D PTR_ERR(tmp);
>  		goto out_err;
>  	}
> --=20
> 2.35.3
>=20
>=20
