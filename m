Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14BB6933C2
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Feb 2023 21:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBKUru (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 11 Feb 2023 15:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKUrt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 11 Feb 2023 15:47:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F6E17CE7
        for <linux-nfs@vger.kernel.org>; Sat, 11 Feb 2023 12:47:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03790B803F3
        for <linux-nfs@vger.kernel.org>; Sat, 11 Feb 2023 20:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6162AC433EF;
        Sat, 11 Feb 2023 20:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676148465;
        bh=A07F5A4HPZt5vf6OAxKgPd//8lak2estejFWc+T51i8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E6o9NFnyb4Lo3ytFmLQSS4LdyP61SL94PjZXc22ZVP5ZqChCkrvhX0+bNRUdHOzRZ
         26H+Ayn/5/31GbT5CerDcHmvu7dNgzdkk/tcXFQPJ6rZ8xEwZuiBiRWzZHuUdIQIVi
         QehPcffXwET4kjDSyKB53XKAMcdR8CCZ4yD7uA3/A81UrV6IGXMqcynWEdFBwjzYCm
         7xl6IQ3mJPeY55c3ayORfWSA8PVOaS0EIPoWccMHyNGNUjKh3V9AOvNud0LlcyzTJu
         FIDOD+R+Y3JxPza7vVzCH8J1XHyf1mG/F5uGchltNfY1kCUXn/nszGG2AfBRJDC6GV
         lDONJ8KcHNfAQ==
Message-ID: <11ac2dd02431095cb861bc4ea1ad7529fc79d3c5.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't destroy global nfs4_file table in per-net
 shutdown
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        JianHong Yin <jiyin@redhat.com>
Date:   Sat, 11 Feb 2023 15:47:43 -0500
In-Reply-To: <03EDD716-A995-49A4-B9AF-E1AA13AAD16E@oracle.com>
References: <20230211125008.21145-1-jlayton@kernel.org>
         <03EDD716-A995-49A4-B9AF-E1AA13AAD16E@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2023-02-11 at 20:31 +0000, Chuck Lever III wrote:
>=20
> > On Feb 11, 2023, at 7:50 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > The nfs4_file table is global, so shutting it down when a containerized
> > nfsd is shut down is wrong and can lead to double-frees. Tear down the
> > nfs4_file_rhltable in nfs4_state_shutdown instead of
> > nfs4_state_shutdown_net.
>=20
> D'oh!
>=20
>=20
> > Fixes: d47b295e8d76 (NFSD: Use rhashtable for managing nfs4_file object=
s)
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2169017
> > Reported-by: JianHong Yin <jiyin@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Thanks to you and JianHong. Applied to nfsd-fixes.
>=20

Thanks for grabbing it quickly. It'd be great to get this in before v6.2
ships...

>=20
> > ---
> > fs/nfsd/nfs4state.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index af22dfdc6fcc..a202be19f26f 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -8218,7 +8218,6 @@ nfs4_state_shutdown_net(struct net *net)
> >=20
> > 	nfsd4_client_tracking_exit(net);
> > 	nfs4_state_destroy_net(net);
> > -	rhltable_destroy(&nfs4_file_rhltable);
> > #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> > 	nfsd4_ssc_shutdown_umount(nn);
> > #endif
> > @@ -8228,6 +8227,7 @@ void
> > nfs4_state_shutdown(void)
> > {
> > 	nfsd4_destroy_callback_queue();
> > +	rhltable_destroy(&nfs4_file_rhltable);
> > }
> >=20
> > static void
> > --=20
> > 2.39.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
