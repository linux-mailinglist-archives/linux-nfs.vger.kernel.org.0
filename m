Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453D86BF4EB
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 23:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCQWKX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 18:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCQWKW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 18:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555E73BDAA
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 15:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2E65B826E6
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 22:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D246C433D2;
        Fri, 17 Mar 2023 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679091017;
        bh=gDtpS7rOJFldYF17/5I64E+fM9RjEFyybgme9EhvJT4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y434WSpW+6BP/TKUwFHU059tGMmuyK+yvDcKJ+dgYcq3ToIfRrVDvljDaIiZAqBPF
         VZXFGFmTEiClHsTZfwCUatjJCHUl6ZoQS1xJccXxowNbdYA776vAKLuaOK6VhlwMid
         gJdiHXHAcQLGI33KAsi2yeBg7HR05iR9Q7VuTcxhrn0A2YzfAlu0tO5L3YvaCb5apQ
         21koXKrJrkv1Cm66CqhY0PkK8Cvz6f2lX3w8ocUisXv8y8N8DOzLFZcadSV+JBUYW0
         lrutwTOp2qyk0uX9/yuSZ6r07jHP40K4UUEnKbaqwyIM6JadU8FdGe30KXWfLgJSYY
         Pz1aqFnLztnow==
Message-ID: <b6d8a8b96581d4f468d9277237113cb7b9e7fb10.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] sunrpc: add bounds checking to
 svc_rqst_replace_page
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 17 Mar 2023 18:10:15 -0400
In-Reply-To: <27346F71-367D-42DF-85AB-D168012F5C41@oracle.com>
References: <20230317171309.73607-1-jlayton@kernel.org>
         <20230317171309.73607-2-jlayton@kernel.org>
         <6F8F3C24-A043-443A-BBB7-E4788FBE29C9@oracle.com>
         <827d46876b57bec309164d4c9513bac523ad5843.camel@kernel.org>
         <F6CE9F70-628B-44D3-A8B1-D4EEBBA28B87@oracle.com>
         <c78fff223129f289214ceada0d82f6952e0d3a82.camel@kernel.org>
         <27346F71-367D-42DF-85AB-D168012F5C41@oracle.com>
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

On Fri, 2023-03-17 at 20:55 +0000, Chuck Lever III wrote:
>=20
> > On Mar 17, 2023, at 2:59 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2023-03-17 at 18:08 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Mar 17, 2023, at 2:04 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > On Fri, 2023-03-17 at 17:51 +0000, Chuck Lever III wrote:
> > > > > > On Mar 17, 2023, at 1:13 PM, Jeff Layton <jlayton@kernel.org> w=
rote:
> > > > > >=20
> > > > > > If rq_next_page ends up pointing outside the array, then we can
> > > > > > corrupt
> > > > > > memory when we go to change its value. Ensure that it hasn't st=
rayed
> > > > > > outside the array, and have svc_rqst_replace_page return -EIO
> > > > > > without
> > > > > > changing anything if it has.
> > > > > >=20
> > > > > > Fix up nfsd_splice_actor (the only caller) to handle this case =
by
> > > > > > either
> > > > > > returning an error or a short splice when this happens.
> > > > >=20
> > > > > IMO it's not worth the extra complexity to return a short splice.
> > > > > This is a "should never happen" scenario in a hot I/O path. Let's
> > > > > keep this code as simple as possible, and use unlikely() for the
> > > > > error cases in both nfsd_splice_actor and svc_rqst_replace_page()=
.
> > > > >=20
> > > >=20
> > > > Are there any issues with just returning an error even though we ha=
ve
> > > > successfully spliced some of the data into the buffer? I guess the
> > > > caller will just see an EIO or whatever instead of the short read i=
n
> > > > that case?
> > >=20
> > > NFSv4 READ is probably going to truncate the XDR buffer. I'm not
> > > sure NFSv3 is so clever, so you should test it.
> >=20
> > Honestly, I don't have the cycles to do that sort of fault injection
> > testing for this.
>=20
> nfsd_splice_actor() has never returned an error, so IMO it is
> necessary to confirm that when svc_rqst_replace_page() returns
> an error, it doesn't create further problems. I don't see how
> we can avoid some kind of simple fault injection while developing
> the fix.
>=20
> Tell you what, I can take it from here if you'd like.
>=20

Sure! All yours!

>=20
> > If you think handling it as a short read is overblown,
> > then tell me what you would like see here.
>=20
> It's not the short reads that bugs me, it's the additional
> code in a hot path that is worrisome.
>=20

I wouldn't think tracking some extra stuff on the stack would show up
much in profiles, but it's your call.

--=20
Jeff Layton <jlayton@kernel.org>
