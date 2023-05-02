Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701266F4988
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 20:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjEBSM7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 14:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjEBSMu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 14:12:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE35EE46
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 11:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22AEE626CD
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 18:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB8AC433EF;
        Tue,  2 May 2023 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683051160;
        bh=yzFnVMcQQRg5ZQeCa3m0bgZnOLJeEkxfYsH8Qb8u7qc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N3AgY4zg6WmDiuJBNNmhnrziuhe1W+/gf3OnKPtMDIr6GJXeebhrSPWJbOTxzDZRs
         Kew4JqtExsfh5MpPRDxFOG5Jc1YMQATiKD8+dYH/LUBhPQIYOGCK4CMnFVzQLAf+IY
         RpUQTqXh9bW8VTjKtCrS52Wok937s9uudYLsztBL65Nv8ZRNiPc9wVPRmDGe6/sn0J
         Ypxa21zpkMXbd9zL+3nc0fZggzt0WP4UnalW/hiPilgPlh7MhOgnBQd/hRtduVh7Au
         CoN3AF6PZaKAlLOKlAtF3lguS/IcClW21DO/5R/hpCSapXKKeSPK7L4hTRwFqbdrXi
         vL9t3EzNxfKew==
Message-ID: <cff1e67f29f96bb2bf7cc32efb94f9a87e2a233d.camel@kernel.org>
Subject: Re: [PATCH] nfsd: use vfs setgid helper
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Sherry Yang <sherry.yang@oracle.com>
Date:   Tue, 02 May 2023 14:12:38 -0400
In-Reply-To: <20230502-agenda-regeln-04d2573bd0fd@brauner>
References: <20230502-agenda-regeln-04d2573bd0fd@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-05-02 at 15:36 +0200, Christian Brauner wrote:
> We've aligned setgid behavior over multiple kernel releases. The details
> can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
> commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
> Consistent setgid stripping behavior is now encapsulated in the
> setattr_should_drop_sgid() helper which is used by all filesystems that
> strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
> raised in e.g., chown_common() and is subject to the
> setattr_should_drop_sgid() check to determine whether the setgid bit can
> be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
> will cause notify_change() to strip it even if the caller had the
> necessary privileges to retain it. Ensure that nfsd only raises
> ATR_KILL_SGID if the caller lacks the necessary privileges to retain the
> setgid bit.
>=20
> Without this patch the setgid stripping tests in LTP will fail:
>=20
> > As you can see, the problem is S_ISGID (0002000) was dropped on a
> > non-group-executable file while chown was invoked by super-user, while
>=20
> [...]
>=20
> > fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, expect=
ed 0102700
>=20
> [...]
>=20
> > chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, expecte=
d 0102700
>=20
> With this patch all tests pass.
>=20
> Reported-by: Sherry Yang <sherry.yang@oracle.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> ubuntu@imp1-vm:~/ltp-install$ sudo ./runltp -d /mnt -s chown02
> INFO: ltp-pan reported all tests PASS
> LTP Version: 20230127-112-gf41e8a2fa
>=20
> ubuntu@imp1-vm:~/ltp-install$ sudo ./runltp -d /mnt -s fchown02
> INFO: ltp-pan reported all tests PASS
> LTP Version: 20230127-112-gf41e8a2fa
>=20
> ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g perms
> FSTYP         -- nfs
> PLATFORM      -- Linux/x86_64 imp1-vm 6.3.0-nfs-setgid-3a3cfe624076 #20 S=
MP PREEMPT_DYNAMIC Tue May  2 12:35:51 UTC 2023
> MKFS_OPTIONS  -- 127.0.0.1:/nfsscratch
> MOUNT_OPTIONS -- -o vers=3D3,noacl 127.0.0.1:/nfsscratch /mnt/scratch
> Passed all 41 tests
> ---
>  fs/nfsd/vfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index bb9d47172162..c4ef24c5ffd0 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -388,7 +388,9 @@ nfsd_sanitize_attrs(struct inode *inode, struct iattr=
 *iap)
>  				iap->ia_mode &=3D ~S_ISGID;
>  		} else {
>  			/* set ATTR_KILL_* bits and let VFS handle it */
> -			iap->ia_valid |=3D (ATTR_KILL_SUID | ATTR_KILL_SGID);
> +			iap->ia_valid |=3D ATTR_KILL_SUID;
> +			iap->ia_valid |=3D
> +				setattr_should_drop_sgid(&nop_mnt_idmap, inode);
>  		}
>  	}
>  }

Looks good to me. The thread should have assumed the user's creds by
this point.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
