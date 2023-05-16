Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B8705A91
	for <lists+linux-nfs@lfdr.de>; Wed, 17 May 2023 00:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjEPW2t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEPW2r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 18:28:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD195FC2
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 15:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 788546356D
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 22:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27549C433D2;
        Tue, 16 May 2023 22:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684276124;
        bh=C4h6P9q7km7Zkh/D942BYG/x1mGWQOUB7Gr3jH6PokY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nx8npiLYKesY7vTxZdOHBAa4keFSsdKxM3RCVYS01qCOT7lACQz5vMuvRn0V7wHVn
         X+O/J5/XbFQ+R+RR01iEYNtEllNnInMz0BHOAHWPdpxLIjLCEhoxUCgSw2f8zSvw/f
         0mdxdtsF3Ma1vXzf/5UahEBSzBi8yDPg7ibEtB6hWm+y+XwXMupiH+R4O9pJc4Y4tb
         vfbHmTD0vag4YBRGN7RevCF5+CtO5J89YHWDawQ+/PAdIKF9kBLh9H5GQvwA/tMEHw
         AO335RZU7APsyT6c+R1cyenKcYwg45Bijnx030qM7y4GRpGW2XTNgoJVJjqkM8lMW6
         s1kpJwYlb2crg==
Message-ID: <1636ee5e1299462b2d052f87f5167ce066f0414d.camel@kernel.org>
Subject: Re: [PATCH v1 26/27] SUNRPC: Set rq_accept_statp inside ->accept
 methods
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Steve Dickson <SteveD@redhat.com>,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        Alexander Ahring Oder Aring <aahringo@redhat.com>
Date:   Tue, 16 May 2023 18:28:42 -0400
In-Reply-To: <4C3DA96B-1FAA-4B80-A344-582BF213BCA8@oracle.com>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
         <167319546521.7490.43383592461162363.stgit@bazille.1015granger.net>
         <3e34a2dc-7d72-b719-248f-e78361db8a5b@kernel.org>
         <4AB1ED03-57C8-42C1-9A04-6C224E98EDCC@oracle.com>
         <569be8e6eff7af373e6baaf2170edb8a8c52f262.camel@kernel.org>
         <0DEDF045-8C95-463D-B5E7-D2A3DF3230FC@oracle.com>
         <08b1fc12a271688c908ad615c08f910c3ec19672.camel@kernel.org>
         <4C3DA96B-1FAA-4B80-A344-582BF213BCA8@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-05-16 at 21:27 +0000, Chuck Lever III wrote:
>=20
> > On May 16, 2023, at 5:25 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Tue, 2023-05-16 at 19:25 +0000, Chuck Lever III wrote:
> > >=20
> > > > On May 16, 2023, at 3:23 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > On Tue, 2023-05-02 at 14:14 +0000, Chuck Lever III wrote:
> > > > >=20
> > > > > > On May 2, 2023, at 7:01 AM, Jiri Slaby <jirislaby@kernel.org> w=
rote:
> > > > > >=20
> > > > > > On 08. 01. 23, 17:31, Chuck Lever wrote:
> > > > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > > > > To navigate around the space that svcauth_gss_accept() reserv=
es
> > > > > > > for the RPC payload body length and sequence number fields,
> > > > > > > svcauth_gss_release() does a little dance with the reply's
> > > > > > > accept_stat, moving the accept_stat value in the response buf=
fer
> > > > > > > down by two words.
> > > > > > > Instead, let's have the ->accept() methods each set the prope=
r
> > > > > > > final location of the accept_stat to avoid having to move
> > > > > > > things.
> > > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > I bisected to this (4bcf0343e8)
> > > > >=20
> > > > > Assuming you did the bisect on the NFS server's kernel?
> > > > >=20
> > > > >=20
> > > > > > as it breaks nfs3-only servers in 6.3. I.e. /etc/nfs.conf conta=
ining:
> > > > > > [nfsd]
> > > > > > vers4=3Dno
> > > > >=20
> > > > > Note: Changing the settings in /etc/nfs.conf had no effect
> > > > > on my server, so I effected the change by stopping the
> > > > > server and poking values into /proc/fs/nfsd/versions by
> > > > > hand.
> > > > >=20
> > > > > Steve?
> > > > >=20
> > > > >=20
> > > > > > The client sees:
> > > > > > mount("10.0.2.15:/tmp", "/mnt", "nfs", 0, "vers=3D4.2,addr=3D10=
.0.2.15,clientad"...) =3D -1 EIO (Input/output error)
> > > > > > write(2, "mount.nfs: mount system call fai"..., 45
> > > > > > mount.nfs: mount system call failed for /mnt
> > > > > >=20
> > > > > > And the kernel says:
> > > > > > nfs4_discover_server_trunking unhandled error -5. Exiting with =
error EIO
> > > > > >=20
> > > > > > I reported in downstream as:
> > > > > > https://bugzilla.suse.com/show_bug.cgi?id=3D1210995
> > > > > >=20
> > > > > > It cannot be reverted cleanly on the top of 6.3.
> > > > > >=20
> > > > > > Any ideas?
> > > > >=20
> > > > > I can reproduce a similar problem. Network capture shows
> > > > > that the server is responding with NFS4ERR_NOENT to the
> > > > > EXCHANGE_ID operation, and the client kernel log says:
> > > > >=20
> > > > > > nfs4_discover_server_trunking unhandled error -121. Exiting wit=
h error EIO
> > > > >=20
> > > > > That's not the failure mode I expected given the commit
> > > > > you bisected to, so it might not be the same problem you've
> > > > > hit. I'll troubleshoot this and send a fix for testing.
> > > > >=20
> > > >=20
> > > > Alex hit this problem in testing too, and I took a quick look.
> > > >=20
> > > > In the attached capture, the client should have gotten back a
> > > > RPC_PROG_MISMATCH error, but the server has recorded an extra succe=
ssful
> > > > accept state before encoding the RPC_PROG_MISMATCH error, leading t=
o a
> > > > malformed reply.
> > > >=20
> > > > I think that the problem is that encoding the accept status too ear=
ly
> > > > means that we can't properly handle failures from the pg_init_reque=
st
> > > > call.
> > > >=20
> > > > Chuck, any thoughts on how you'd like to handle this?
> > >=20
> > > With this:
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/=
?h=3Dnfsd-fixes&id=3D29cd2927fb914cc53b5ba4f67d2b74695c994ba4
> > >=20
> > > I plan to send the fix to Linus tomorrow.
> > >=20
> > >=20
> >=20
> > Oh! I hadn't seen that cross the list. Did I miss it?
>=20
> https://lore.kernel.org/linux-nfs/8cd5d041-77c3-51dd-a960-7fd8ce1d1271@ke=
rnel.org/T/#t
>=20
>=20

Ahh ok, it wasn't under its own title. LGTM. You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
