Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E6D64B9F7
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 17:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiLMQlY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Dec 2022 11:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiLMQlX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Dec 2022 11:41:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC7F2DEB
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 08:41:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77D5C61617
        for <linux-nfs@vger.kernel.org>; Tue, 13 Dec 2022 16:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A82C433EF;
        Tue, 13 Dec 2022 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670949680;
        bh=8Hbihz/CFBGMK+vWtxzM1rELbhbRE2ata6Y7A2RVafI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UkrrgOexbs06I7IB/BlH9jRhP67Ff8/mTmFIbdtEJpImRzqSajjdiBi90PwPyW2Pb
         f7pNsJJpfQJeoPv4M9u3qbJW2c8az+4vkSD9mYPehC4ot/4KIWBXeeO3l3lvzhBTrx
         ysdAI8cZRSnFRo/w46w7EaDNqx5N/12Hupp6AvSAZlnbdHW/BaxTGFV9xnVBXWJjxE
         BTiGwV6/hTAwXQJt9kf1zRLlIDbLInoljyqfEmutfQ98ZiLj5u7W+WFKzO9MEmi70X
         d4aFhJHTGj5QpOs2qhSL0Mx2Hm8mms61uz5F/QBTjGawh90pypag0DOhAayPXRfrja
         uO0nyuKaw8kzA==
Message-ID: <bf761c780a2c65907718a107e84bf1e5cfe6756f.camel@kernel.org>
Subject: Re: [nfs-utils PATCH] Don't allow junction tests to trigger
 automounts
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        JianHong Yin <jiyin@redhat.com>
Date:   Tue, 13 Dec 2022 11:41:18 -0500
In-Reply-To: <52DA8A58-FF23-4528-B094-D8849D1DE54A@oracle.com>
References: <20221213160104.198237-1-jlayton@kernel.org>
         <52DA8A58-FF23-4528-B094-D8849D1DE54A@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-12-13 at 16:25 +0000, Chuck Lever III wrote:
>=20
> > On Dec 13, 2022, at 11:01 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > JianHong reported some strange behavior with automounts on an nfs serve=
r
> > without an explicit pseudoroot. When clients issued a readdir in the
> > pseudoroot, automounted directories that were not yet mounted would sho=
w
> > up even if they weren't exported, though the clients wouldn't be able t=
o
> > do anything with them.
> >=20
> > The issue was that triggering the automount on a directory would cause
> > the mountd upcall to time out, which would cause nfsd to include the
> > automounted dentry in the readdir response. Eventually, the automount
> > would work and report that it wasn't exported and subsequent attempts t=
o
> > access the dentry would (properly) fail.
> >=20
> > We never want mountd to trigger an automount. The kernel should do that
> > if it wants to use it. Change the junction checks to do an O_PATH open
> > and use fstatat with AT_NO_AUTOMOUNT.
> >=20
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2148353
>=20
> And also https://bugzilla.kernel.org/show_bug.cgi?id=3D216777 ?
>=20

Yes indeed, thanks! Note too that I suspect there may also be a kernel
error handling bug related to this.

I know that nfsd_cross_mnt returned -ETIMEDOUT, but the READDIR response
still contained the dentry. The follow-on stat call failed, but it seems
like the readdir response shouldn't have included that dentry in the
first place.

I'm still looking at that bit, but we should probably aim to fix that
too.

>=20
> > Reported-by: JianHong Yin <jiyin@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > support/junction/junction.c | 10 +++++-----
> > 1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/support/junction/junction.c b/support/junction/junction.c
> > index 41cce261cb52..0628bb0ffffb 100644
> > --- a/support/junction/junction.c
> > +++ b/support/junction/junction.c
> > @@ -63,7 +63,7 @@ junction_open_path(const char *pathname, int *fd)
> > 	if (pathname =3D=3D NULL || fd =3D=3D NULL)
> > 		return FEDFS_ERR_INVAL;
> >=20
> > -	tmp =3D open(pathname, O_DIRECTORY);
> > +	tmp =3D open(pathname, O_PATH|O_DIRECTORY);
> > 	if (tmp =3D=3D -1) {
> > 		switch (errno) {
> > 		case EPERM:
> > @@ -93,7 +93,7 @@ junction_is_directory(int fd, const char *path)
> > {
> > 	struct stat stb;
> >=20
> > -	if (fstat(fd, &stb) =3D=3D -1) {
> > +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) =3D=3D -1) {
> > 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
> > 				__func__, path);
> > 		return FEDFS_ERR_ACCESS;
> > @@ -121,7 +121,7 @@ junction_is_sticky_bit_set(int fd, const char *path=
)
> > {
> > 	struct stat stb;
> >=20
> > -	if (fstat(fd, &stb) =3D=3D -1) {
> > +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) =3D=3D -1) {
> > 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
> > 				__func__, path);
> > 		return FEDFS_ERR_ACCESS;
> > @@ -155,7 +155,7 @@ junction_set_sticky_bit(int fd, const char *path)
> > {
> > 	struct stat stb;
> >=20
> > -	if (fstat(fd, &stb) =3D=3D -1) {
> > +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) =3D=3D -1) {
> > 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
> > 			__func__, path);
> > 		return FEDFS_ERR_ACCESS;
> > @@ -393,7 +393,7 @@ junction_get_mode(const char *pathname, mode_t *mod=
e)
> > 	if (retval !=3D FEDFS_OK)
> > 		return retval;
> >=20
> > -	if (fstat(fd, &stb) =3D=3D -1) {
> > +	if (fstatat(fd, "", &stb, AT_NO_AUTOMOUNT|AT_EMPTY_PATH) =3D=3D -1) {
> > 		xlog(D_GENERAL, "%s: failed to stat %s: %m",
> > 			__func__, pathname);
> > 		(void)close(fd);
> > --=20
> > 2.38.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
