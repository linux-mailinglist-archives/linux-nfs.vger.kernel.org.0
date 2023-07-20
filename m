Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF47A75B9B4
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 23:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjGTVm4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 17:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjGTVmz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 17:42:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E11719;
        Thu, 20 Jul 2023 14:42:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1AE86224B7;
        Thu, 20 Jul 2023 21:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689889373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81OuUzF4A6RcuJi9Es3ThWlGwUbRgc9p9AMlF5AV7zM=;
        b=SueN0P8jaFKXg0XTgTNJmT4EP5Wl+CzUOsYsOVVmAvGzGPlSrlyuCMmObbURyNtJxH/xC7
        hvziDGLFYFSkFOost4PFKQrFlY0Z0WUTHnFDNMzhpGcWg7tnmVEmX9PbXE0pFfHrI6c7Ax
        h4xQf+xCLdRvjKNIr3FRfUn4WoXXveU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689889373;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81OuUzF4A6RcuJi9Es3ThWlGwUbRgc9p9AMlF5AV7zM=;
        b=MG3AE6zyegseBYJLaRSnXlNLblPfAeiAaNmiy6yjWOJfD+Y9bgLbv6rrS3SgTwiVtxe29x
        lpFnvF0kx9iAzaCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5029E138EC;
        Thu, 20 Jul 2023 21:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RGVgAVqquWSBPwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 20 Jul 2023 21:42:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        "Boyang Xue" <bxue@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v2 0/2] nfsd: sanely handle inabilty to fetch pre/post attributes
In-reply-to: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>
References: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>
Date:   Fri, 21 Jul 2023 07:42:47 +1000
Message-id: <168988936713.11078.5407820394334916284@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 21 Jul 2023, Jeff Layton wrote:
> Boyang reported tripping the BUG_ON in set_change_info. While we
> couldn't confirm it, one way this could happen would be for nfsd_lookup
> to succeed and then for fh_fill_both_attrs to fail.
>=20
> This patchset attempts to (sanely) fix this, usually by aborting the
> operation if fetching the pre attributes fails. Post-op attribute fetch
> handling is more difficult to deal with however since we've already done
> the operation, so this has it just fudge the change_info4 if that
> occurs.

I think both v3 and v4 allow a reply that says "the operation was a
success but there are no post-op attrs".  With v4 you can say "there is
no change-attr, but here are some other attrs".  I think.

Our xdr-encoding doesn't make that easy, but it is just a "simple matter
of coding".  If you think it is worth it.

NeilBrown


>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - make fh_fill_*_attrs return an error and have the callers handle it
> - rework of set_change_info, to better handle missing pre/post attrs
>=20
> ---
> Jeff Layton (2):
>       nfsd: handle failure to collect pre/post-op attrs more sanely
>       nfsd: remove unsafe BUG_ON from set_change_info
>=20
>  fs/nfsd/nfs3proc.c |  4 +++-
>  fs/nfsd/nfs4proc.c | 45 +++++++++++++++++++++++++++++++++------
>  fs/nfsd/nfsfh.c    | 26 ++++++++++++++---------
>  fs/nfsd/nfsfh.h    |  6 +++---
>  fs/nfsd/vfs.c      | 62 ++++++++++++++++++++++++++++++++++----------------=
----
>  fs/nfsd/xdr4.h     | 11 ----------
>  6 files changed, 100 insertions(+), 54 deletions(-)
> ---
> base-commit: 070f391ca4d48e1750ee6108eb44f751a9e9448e
> change-id: 20230720-bz2223560-9c4690a8217b
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20

