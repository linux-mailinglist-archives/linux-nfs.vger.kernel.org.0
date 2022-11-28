Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DF163AA99
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Nov 2022 15:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiK1ON1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Nov 2022 09:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiK1ON0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Nov 2022 09:13:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE466334
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 06:13:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43447611BE
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 14:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533C1C433C1;
        Mon, 28 Nov 2022 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669644803;
        bh=OIMIK6ZwTnCwLrF7bKpN9Lg0gHOkkqQNffBItNcbCXE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bMUfBGS9YH5SsTKMiGdGEJiL4RLqPoNxukUDT6SFOswM/FFaC9YLXjIdFpyl47NTk
         Q1PK/1sJyGpUeipvLOeSWt7crRHjR3rhh2tFbkD5Ll4RKcZt+XcuMqtYJZb2cnJZo5
         4AiwbSXYy9HL/C7dyzFFWtz90yRGcHsm4jFa0qWrjj6q4YjDk2deRaq7pVdEFDclhg
         PbhYoyWWf68nvtQbg8JQS0jxNtnBs6q7bftfT6VuN1/m0yugY8OvIl8r3hWqqSgQJE
         C5Bx19Hk6Jx/LUxrYjyFn5hYn8Ypb/qSpdIp1EKAJ6+fInIjpQtJ92whiYkTo2UYpe
         fy5oD3boxuSnA==
Message-ID: <3fb9efce2190c0ab511812a95543abb0d886545c.camel@kernel.org>
Subject: Re: [PATCH 1/4] SUNRPC: Don't leak netobj memory when
 gss_read_proxy_verf() fails
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 28 Nov 2022 09:13:21 -0500
In-Reply-To: <466F83EA-12E1-4C36-8F42-AE4F8578DDEB@oracle.com>
References: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
         <166949611830.106845.15345645610329421030.stgit@klimt.1015granger.net>
         <3e33c1ba057d39f145bb935b6f92f17dc9cbd207.camel@poochiereds.net>
         <466F83EA-12E1-4C36-8F42-AE4F8578DDEB@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-11-28 at 14:02 +0000, Chuck Lever III wrote:
>=20
> > On Nov 28, 2022, at 8:11 AM, Jeff Layton <jlayton@poochiereds.net> wrot=
e:
> >=20
> > On Sat, 2022-11-26 at 15:55 -0500, Chuck Lever wrote:
> > > Fixes: 030d794bf498 ("SUNRPC: Use gssproxy upcall for server RPCGSS a=
uthentication.")
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > Cc: <stable@vger.kernel.org>
> > > ---
> > > net/sunrpc/auth_gss/svcauth_gss.c |    9 +++++++--
> > > 1 file changed, 7 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/=
svcauth_gss.c
> > > index bcd74dddbe2d..9a5db285d4ae 100644
> > > --- a/net/sunrpc/auth_gss/svcauth_gss.c
> > > +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> > > @@ -1162,18 +1162,23 @@ static int gss_read_proxy_verf(struct svc_rqs=
t *rqstp,
> > > 		return res;
> > >=20
> > > 	inlen =3D svc_getnl(argv);
> > > -	if (inlen > (argv->iov_len + rqstp->rq_arg.page_len))
> > > +	if (inlen > (argv->iov_len + rqstp->rq_arg.page_len)) {
> > > +		kfree(in_handle->data);
> >=20
> > I wish this were more obvious in this code. It's not at all evident to
> > the casual reader that gss_read_common_verf calls dup_netobj here and
> > that you need to clean up after it. At a bare minimum, we ought to have
> > a comment to that effect over gss_read_common_verf. While you're in
> > there, that function is also pretty big to be marked static inline. Can
> > you change that too? Ditto for gss_read_verf.
>=20
> Agreed: I've done that clean up in subsequent patches that are part
> of the (yet to be posted) series to replace svc_get/putnl with
> xdr_stream.
>=20
> This seemed like a good fix to apply earlier rather than later. That
> should enable it to be backported cleanly.
>=20


Fair enough. You can add my Reviewed-by to the whole series. I'll look
forward to seeing the full cleanup.

>=20
> > > 		return SVC_DENIED;
> > > +	}
> > >=20
> > > 	pages =3D DIV_ROUND_UP(inlen, PAGE_SIZE);
> > > 	in_token->pages =3D kcalloc(pages, sizeof(struct page *), GFP_KERNEL=
);
> > > -	if (!in_token->pages)
> > > +	if (!in_token->pages) {
> > > +		kfree(in_handle->data);
> > > 		return SVC_DENIED;
> > > +	}
> > > 	in_token->page_base =3D 0;
> > > 	in_token->page_len =3D inlen;
> > > 	for (i =3D 0; i < pages; i++) {
> > > 		in_token->pages[i] =3D alloc_page(GFP_KERNEL);
> > > 		if (!in_token->pages[i]) {
> > > +			kfree(in_handle->data);
> > > 			gss_free_in_token_pages(in_token);
> > > 			return SVC_DENIED;
> > > 		}
> > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@poochiereds.net>
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
