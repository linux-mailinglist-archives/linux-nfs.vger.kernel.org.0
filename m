Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F33B626243
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 20:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiKKTnF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 14:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiKKTnF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 14:43:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762DC7F560
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 11:43:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13BD8620BE
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 19:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E16C433D6;
        Fri, 11 Nov 2022 19:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195783;
        bh=Bw6Q+Je8nz4T63kSzhspcps0ZoF+DkI4047c4mdgSQ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CCF28P6PS01M3g64jb5/GPc0mVlso1xjomz1JLbI5FtT9rSTe2TmTlgQpnOQ3IvED
         molV/BZC7hGYNFR5vLVwb+UfmchU+Asf2O917JM74SDA346K7ciMJolmSbhhBM/RU4
         uMB+m70pGpmN+zS6qKDk4hKm/g1TnJQHGdyOTWAUORtZBq8fdlxKT0mmDds/t9ohQK
         B4MYtSO9p8Wl0VvuVfg3cIklLLB2qKosPcHf9znQNKzHdaPJMpSbMtO9xq4PI00Jax
         mOguoo+yA9tsYnMSoyB4LQU6fVDzvQ4jIdN0EQ5/lVLcINsUxLK2Tb8DvSfJw7Z1TW
         bs4G51bfdmAmw==
Message-ID: <e5782930e8aea3cfbb14d47989b0556cce17f137.camel@kernel.org>
Subject: Re: [PATCH 4/4] filelock: WARN_ON_ONCE when ->fl_file and filp
 don't match
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Fri, 11 Nov 2022 14:43:01 -0500
In-Reply-To: <20221111193639.346992-5-jlayton@kernel.org>
References: <20221111193639.346992-1-jlayton@kernel.org>
         <20221111193639.346992-5-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-11-11 at 14:36 -0500, Jeff Layton wrote:
> vfs_lock_file, vfs_test_lock and vfs_cancel_lock all take both a struct
> file argument and a file_lock. The file_lock has a fl_file field in it
> howevever and it _must_ match the file passed in.
>=20
> While most of the locks.c routines use the separately-passed file
> argument, some filesystems rely on fl_file being filled out correctly.
>=20
> I'm working on a patch series to remove the redundant argument from
> these routines, but for now, let's ensure that the callers always set
> this properly by issuing a WARN_ON_ONCE if they ever don't match.
>=20
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 607f94a0e789..5876c8ff0edc 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2146,6 +2146,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned i=
nt, cmd)
>   */
>  int vfs_test_lock(struct file *filp, struct file_lock *fl)
>  {
> +	WARN_ON_ONCE(filp !=3D fl->fl_file);
>  	if (filp->f_op->lock)
>  		return filp->f_op->lock(filp, F_GETLK, fl);
>  	posix_test_lock(filp, fl);
> @@ -2295,6 +2296,7 @@ int fcntl_getlk(struct file *filp, unsigned int cmd=
, struct flock *flock)
>   */
>  int vfs_lock_file(struct file *filp, unsigned int cmd, struct file_lock =
*fl, struct file_lock *conf)
>  {
> +	WARN_ON_ONCE(filp !=3D fl->fl_file);
>  	if (filp->f_op->lock)
>  		return filp->f_op->lock(filp, cmd, fl);
>  	else
> @@ -2663,6 +2665,7 @@ void locks_remove_file(struct file *filp)
>   */
>  int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
>  {
> +	WARN_ON_ONCE(filp !=3D fl->fl_file);
>  	if (filp->f_op->lock)
>  		return filp->f_op->lock(filp, F_CANCELLK, fl);
>  	return 0;

Oops, I meant to cc linux-fsdevel here too. I'll plan to do that on the
next posting (assuming that I need to do one).

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
