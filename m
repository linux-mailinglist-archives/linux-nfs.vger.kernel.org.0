Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEE6666089
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbjAKQcO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 11:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjAKQbm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 11:31:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11544E76
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 08:31:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FAD461D7F
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 16:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9242DC433EF;
        Wed, 11 Jan 2023 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673454666;
        bh=//xO8KlAvalILw2MrywtUVwHB1Cr/Cddh8z5+lnDcxw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qL6CC1VvQPyKQAz/56VhIcN4UVvaxBB6fOvlZu0+BcD836mPSjU5qipVfpEZSyY25
         3JtpO4JL90Sh6JySG6GKu97S4ESE5Wx3Psd7u2QHC+F3JRDnfbf2eRhsSqGaqZXw09
         fBcbuJcRXyiTl3ryI9Q8OZzPzaArq7Ah481jZesu1mL8UqOPgtfP4mPSeUuo6KRiFx
         R2O3noTN6Pyr0Od2qhgj0H5oAlIxiGt2xWjH8BPZ4pKpWtf9MDDMjq/GuFRils0cOF
         rL0fITviIXuj/TIaV9c0uMh0VVZyM53xue46sqxoIZK++smcsuhNCu5BNIDJ2uZk3b
         2xEjKPUSZ2i8Q==
Message-ID: <9153f947ee3fe7c7ab5d1ad2a6760c4485b82bea.camel@kernel.org>
Subject: Re: [PATCH] NFSD: fix use-after-free in nfsd4_ssc_setup_dul()
From:   Jeff Layton <jlayton@kernel.org>
To:     Xingyuan Mo <hdthky0@gmail.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, dai.ngo@oracle.com
Date:   Wed, 11 Jan 2023 11:31:04 -0500
In-Reply-To: <20230111162453.8295-1-hdthky0@gmail.com>
References: <20230111162453.8295-1-hdthky0@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-01-12 at 00:24 +0800, Xingyuan Mo wrote:
> If signal_pending() returns true, schedule_timeout() will not be executed=
,
> causing the waiting task to remain in the wait queue.
> Fixed by adding a call to finish_wait(), which ensures that the waiting
> task will always be removed from the wait queue.
>=20
> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
> ---
>  fs/nfsd/nfs4proc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index bd880d55f565..3fa819e29b3f 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1318,6 +1318,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *=
nn, char *ipaddr,
>  			/* allow 20secs for mount/unmount for now - revisit */
>  			if (signal_pending(current) ||
>  					(schedule_timeout(20*HZ) =3D=3D 0)) {
> +				finish_wait(&nn->nfsd_ssc_waitq, &wait);
>  				kfree(work);
>  				return nfserr_eagain;
>  			}

Nice catch.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
