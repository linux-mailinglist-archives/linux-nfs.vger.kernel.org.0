Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4BB6AD222
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Mar 2023 23:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCFW56 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Mar 2023 17:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCFW55 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Mar 2023 17:57:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2243C03
        for <linux-nfs@vger.kernel.org>; Mon,  6 Mar 2023 14:57:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A661A6101A
        for <linux-nfs@vger.kernel.org>; Mon,  6 Mar 2023 22:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A95FC433EF;
        Mon,  6 Mar 2023 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678143475;
        bh=UYT7P8hAn8Sox16YHsE1mSy4/NQN+tHDfPbCl2U8c2A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KLOeAZJZXgjeCZSYdc7q1tOll475a98RwfjCb753USnK9cA7vEyPAd7MDlPImLMLf
         hiSMcX06XdOSS3mQiqgpaBgoFSZ9MdpXMSs7xSYWo4DcahX038AYcy0oNGeGceE5fu
         ImDGgYsnKH637i04De4DfI7J9C3qy+Q51ckK6rQKXkEUB2jCQtgLzmbXRccf6z1RT8
         aAFb3AlargvspgAoA9sPMoq1Qj0DhiP1Wl3trngMJ1lU0Ih2U2FNEkRKiTvzLgUxFm
         gfk0HGwZ1NMVmugyJSyG43xzxSj6zNrvER1eB8xDbe8a76LP7Q1pF7CnfSNLuUq6eo
         /5fE2oV8H56Mg==
Message-ID: <ac05071a4a9dee6f249945d23e37812aa350fcc5.camel@kernel.org>
Subject: Re: [PATCH] NFSD: Protect against filesystem freezing
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     jack@suse.de, flole@flole.de
Date:   Mon, 06 Mar 2023 17:57:53 -0500
In-Reply-To: <167811742782.1909.380332356774647144.stgit@bazille.1015granger.net>
References: <167811742782.1909.380332356774647144.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-03-06 at 10:43 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Flole observes this WARNING on occasion:
>=20
> [1210423.486503] WARNING: CPU: 8 PID: 1524732 at fs/ext4/ext4_jbd2.c:75 e=
xt4_journal_check_start+0x68/0xb0
>=20
> Reported-by: <flole@flole.de>
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217123
> Fixes: 73da852e3831 ("nfsd: use vfs_iter_read/write")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 21d5209f6e04..ba34a31a7c70 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1104,7 +1104,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_f=
h *fhp, struct nfsd_file *nf,
>  	since =3D READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);
> +	file_start_write(file);
>  	host_err =3D vfs_iter_write(file, &iter, &pos, flags);
> +	file_end_write(file);
>  	if (host_err < 0) {
>  		nfsd_reset_write_verifier(nn);
>  		trace_nfsd_writeverf_reset(nn, rqstp, host_err);
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
