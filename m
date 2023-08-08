Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0CD774267
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 19:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjHHRoX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 13:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjHHRoF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 13:44:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D006615
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 09:19:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F6DC2031C;
        Tue,  8 Aug 2023 11:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691494409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9KkIAPhcN2tN2/oybrV0lI9G9PMRD1NedhrfYYO7b4=;
        b=pt2g3eD0JUKHj0o6Y1hBY4zC4TDfK3X4jgvlru8+qazSqmID2rqn2xRazvZRus2HwgbLS6
        pd4PWTIkvCv7fd5Z92scqyJVzvIFKy6xBS9eKzZ/lG5qVjnxfIlhIi+KxbBJkjLYIIfqud
        DSLuGQnVf0Xfuv1JHSKSNStciY21Hwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691494409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9KkIAPhcN2tN2/oybrV0lI9G9PMRD1NedhrfYYO7b4=;
        b=SisjXbQjGtS0kgThutrcczwfLCZ7/f6TjWX8LWD5A7rKIdrTXv5orc1ual4pYl+wr1+Fd7
        ru3HGiaDyQf9ndDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CF5313451;
        Tue,  8 Aug 2023 11:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2k09DAco0mTjVgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 08 Aug 2023 11:33:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
In-reply-to: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
Date:   Tue, 08 Aug 2023 21:33:23 +1000
Message-id: <169149440399.32308.1010201101079709026@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 08 Aug 2023, Lorenzo Bianconi wrote:
> Introduce version field to nfsd_rpc_status handler in order to help
> the user to maintain backward compatibility.

I wonder if this really helps.  What do I do if I see a version that I
don't understand?  Ignore the whole file?  That doesn't make for a good
user experience.

I would suggest that the first step to promoting compatibility is to
document the format, including how you expect to extend it.  Jeff's
suggestion of a header line with field names makes a lot of sense for a
file with space-separated fields like this.  You should probably promise
not to remove fields, but to deprecate fields by replacing them with "X"
or whatever.

A tool really needs to be able to extract anything it can understand,
and know how to avoid what it doesn't understand.  A version number
doesn't help with that.

And if you really wanted to change the format so much that old tools
cannot use any of the content, it would likely make most sense to change
the name of the file...  or have two files - legacy file with old name
and new-improved file with new name.

So I'm not keen on a version number.

Thanks,
NeilBrown


>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/nfssvc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 33ad91dd3a2d..6d5feeeb09a7 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1117,6 +1117,9 @@ int nfsd_stats_release(struct inode *inode, struct fi=
le *file)
>  	return ret;
>  }
> =20
> +/* Increment NFSD_RPC_STATUS_VERSION adding new info to the handler */
> +#define NFSD_RPC_STATUS_VERSION		1
> +
>  static int nfsd_rpc_status_show(struct seq_file *m, void *v)
>  {
>  	struct inode *inode =3D file_inode(m->file);
> @@ -1125,6 +1128,8 @@ static int nfsd_rpc_status_show(struct seq_file *m, v=
oid *v)
> =20
>  	rcu_read_lock();
> =20
> +	seq_printf(m, "# version %u\n", NFSD_RPC_STATUS_VERSION);
> +
>  	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
>  		struct svc_rqst *rqstp;
> =20
> --=20
> 2.41.0
>=20
>=20

