Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFB6705702
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjEPTXr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 15:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjEPTXq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 15:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C608B7AB8
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 12:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EBF8633A0
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 19:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35AEC433A0;
        Tue, 16 May 2023 19:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265023;
        bh=AHTGLkEWNe4FtI3CuaotSz2+Drt6D6081z2Ghjay72c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h95Ueo2WCtevQ0sq/r76jbswXptkLkWfG5v6s3fSxFC5mVADBSUWoQu04GJiYbled
         1uOWbIn7EPZTthgP0rmcxQE+qsm/EhIOQ18l0p/wgu/wNDe5JRLvDhlCMqGovJK+Q/
         bb2IlYFvyifXe5XhaG1VzvF8QvXS2cl6WG6KMdBzT1AiugOHXJKww/zHMSAWgfY2II
         ERBz7aGWU1pw5WketkPMaBU/CDJQAy1UpRsUUVUWWpk6FRNNYmmMmEpipqSHzV9mSa
         zYDrfOH/t/OAaJVNtYyTeiNMvxWfMfdeoXK8K58EN9MLch8QEqPMhW6vhMWvk0gKnx
         0S/vQ4Ky8vfAQ==
Message-ID: <569be8e6eff7af373e6baaf2170edb8a8c52f262.camel@kernel.org>
Subject: Re: [PATCH v1 26/27] SUNRPC: Set rq_accept_statp inside ->accept
 methods
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Steve Dickson <SteveD@redhat.com>
Cc:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        Alexander Ahring Oder Aring <aahringo@redhat.com>
Date:   Tue, 16 May 2023 15:23:41 -0400
In-Reply-To: <4AB1ED03-57C8-42C1-9A04-6C224E98EDCC@oracle.com>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
         <167319546521.7490.43383592461162363.stgit@bazille.1015granger.net>
         <3e34a2dc-7d72-b719-248f-e78361db8a5b@kernel.org>
         <4AB1ED03-57C8-42C1-9A04-6C224E98EDCC@oracle.com>
Content-Type: multipart/mixed; boundary="=-igvbfTe4pJo+y8GPA1bU"
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-igvbfTe4pJo+y8GPA1bU
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-05-02 at 14:14 +0000, Chuck Lever III wrote:
>=20
> > On May 2, 2023, at 7:01 AM, Jiri Slaby <jirislaby@kernel.org> wrote:
> >=20
> > On 08. 01. 23, 17:31, Chuck Lever wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > To navigate around the space that svcauth_gss_accept() reserves
> > > for the RPC payload body length and sequence number fields,
> > > svcauth_gss_release() does a little dance with the reply's
> > > accept_stat, moving the accept_stat value in the response buffer
> > > down by two words.
> > > Instead, let's have the ->accept() methods each set the proper
> > > final location of the accept_stat to avoid having to move
> > > things.
> >=20
> > Hi,
> >=20
> > I bisected to this (4bcf0343e8)
>=20
> Assuming you did the bisect on the NFS server's kernel?
>=20
>=20
> > as it breaks nfs3-only servers in 6.3. I.e. /etc/nfs.conf containing:
> > [nfsd]
> > vers4=3Dno
>=20
> Note: Changing the settings in /etc/nfs.conf had no effect
> on my server, so I effected the change by stopping the
> server and poking values into /proc/fs/nfsd/versions by
> hand.
>=20
> Steve?
>=20
>=20
> > The client sees:
> >  mount("10.0.2.15:/tmp", "/mnt", "nfs", 0, "vers=3D4.2,addr=3D10.0.2.15=
,clientad"...) =3D -1 EIO (Input/output error)
> >  write(2, "mount.nfs: mount system call fai"..., 45
> >  mount.nfs: mount system call failed for /mnt
> >=20
> > And the kernel says:
> >  nfs4_discover_server_trunking unhandled error -5. Exiting with error E=
IO
> >=20
> > I reported in downstream as:
> > https://bugzilla.suse.com/show_bug.cgi?id=3D1210995
> >=20
> > It cannot be reverted cleanly on the top of 6.3.
> >=20
> > Any ideas?
>=20
> I can reproduce a similar problem. Network capture shows
> that the server is responding with NFS4ERR_NOENT to the
> EXCHANGE_ID operation, and the client kernel log says:
>=20
> >  nfs4_discover_server_trunking unhandled error -121. Exiting with error=
 EIO
>=20
> That's not the failure mode I expected given the commit
> you bisected to, so it might not be the same problem you've
> hit. I'll troubleshoot this and send a fix for testing.
>=20

Alex hit this problem in testing too, and I took a quick look.

In the attached capture, the client should have gotten back a
RPC_PROG_MISMATCH error, but the server has recorded an extra successful
accept state before encoding the RPC_PROG_MISMATCH error, leading to a
malformed reply.

I think that the problem is that encoding the accept status too early
means that we can't properly handle failures from the pg_init_request
call.

Chuck, any thoughts on how you'd like to handle this?
--=20
Jeff Layton <jlayton@kernel.org>

--=-igvbfTe4pJo+y8GPA1bU
Content-Type: application/x-pcapng; name="bad-fallback.pcapng.gz"
Content-Disposition: attachment; filename="bad-fallback.pcapng.gz"
Content-Transfer-Encoding: base64

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
AGwAAAA=


--=-igvbfTe4pJo+y8GPA1bU--
