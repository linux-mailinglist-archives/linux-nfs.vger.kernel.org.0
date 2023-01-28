Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B767F907
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Jan 2023 16:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjA1PUa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Jan 2023 10:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1PU3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 Jan 2023 10:20:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151253EFD7
        for <linux-nfs@vger.kernel.org>; Sat, 28 Jan 2023 07:20:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 969F9B80A72
        for <linux-nfs@vger.kernel.org>; Sat, 28 Jan 2023 15:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC73EC433EF;
        Sat, 28 Jan 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674919225;
        bh=SIcrpOSAD00nBJ6f6JEGBQmyTyEAl6clGqJehfLzbT0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UZu4AschWpMu6xjiaMjEepv5YKzekUVmpc2cfamx4XSgId0AnxN4w5U8QnQJooUGR
         KkRIKg0/+ZCDtdg3jeG1SqEKYbDhIfdLKfyNn4tNjO8uSAiezB/PhtCAcgytp8Z04I
         7z7TOFwQk0CLm1VagEbYvdzhAEp4os8o5F7pG2vxB+iXOBKiLAPrYGlxtd56AWBqg6
         CEyfcAEKwc6j0DVAdy+6gAD9p8fO2Owimqiw98jjJgZKsgH/gki+G44v0RHuEBdOf8
         ADNiFjNO1pXNC1WHXoRtgmDChhrbZYYk24DN+3GGXzTDG8HDL6jRiHkRTbUBPXY9+y
         zeSA6l9xqAKiw==
Message-ID: <e0e53e0299a62d4d2fef80b5811659b200053ae6.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix race to check ls_layouts
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Date:   Sat, 28 Jan 2023 10:20:23 -0500
In-Reply-To: <34272738-0EB5-471C-A978-66F763664B7E@oracle.com>
References: <979eebe94ef380af6a5fdb831e78fd4c0946a59e.1674836262.git.bcodding@redhat.com>
         <C9FA580A-52A6-4208-AFA2-91E8BCB36B9F@oracle.com>
         <49815925-FB60-456F-8633-79B4C203B782@redhat.com>
         <0412daf06541dfa71866be1efedef5456e524ece.camel@kernel.org>
         <A1324B12-C0FE-4A60-8116-4DCD98C92A8D@redhat.com>
         <4305a18844f395657ef0fd3af313d8e15c330499.camel@kernel.org>
         <34272738-0EB5-471C-A978-66F763664B7E@oracle.com>
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

On Sat, 2023-01-28 at 14:15 +0000, Chuck Lever III wrote:
> [ Cc'ing the original author of this code. ]
>=20
> Proposed patch is here:
>=20
> https://lore.kernel.org/linux-nfs/979eebe94ef380af6a5fdb831e78fd4c0946a59=
e.1674836262.git.bcodding@redhat.com/
>=20
> > On Jan 28, 2023, at 8:47 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Sat, 2023-01-28 at 08:31 -0500, Benjamin Coddington wrote:
> > > On 27 Jan 2023, at 13:03, Jeff Layton wrote:
> > >=20
> > > > On Fri, 2023-01-27 at 11:42 -0500, Benjamin Coddington wrote:
> > > > > On 27 Jan 2023, at 11:34, Chuck Lever III wrote:
> > > > >=20
> > > > > > > On Jan 27, 2023, at 11:18 AM, Benjamin Coddington <bcodding@r=
edhat.com> wrote:
> > > > > > >=20
> > > > > > > Its possible for __break_lease to find the layout's lease bef=
ore we've
> > > > > > > added the layout to the owner's ls_layouts list.  In that cas=
e, setting
> > > > > > > ls_recalled =3D true without actually recalling the layout wi=
ll cause the
> > > > > > > server to never send a recall callback.
> > > > > > >=20
> > > > > > > Move the check for ls_layouts before setting ls_recalled.
> > > > > > >=20
> > > > > > > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > > > > >=20
> > > > > > Did this start misbehaving recently, or has it always been brok=
en?
> > > > > > That is, does it need:
> > > > > >=20
> > > > > > Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls") ?
> > > > >=20
> > > > > I'm doing some new testing of racing LAYOUTGET and CB_LAYOUTRETUR=
N after
> > > > > running into a livelock, so I think it has always been broken and=
 the Fixes
> > > > > tag is probably appropriate.
> > > > >=20
> > > > > However, now I'm wondering if we'd run into trouble if ls_layouts=
 could be
> > > > > empty but the lease still exist..  but that seems like it would b=
e a
> > > > > different bug.
> > > > >=20
> > > >=20
> > > > Yeah, is that even possible? Surely once the last layout is gone, w=
e
> > > > drop the stateid? In any case, this patch looks fine. You can add:
> > > >=20
> > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > >=20
> > > Jeff pointed out that there's another problem here.  We can't just sk=
ip
> > > sending the callback if ls_layouts is empty, because then the process=
 trying
> > > to break the lease will end up spinning in __break_lease.
> > >=20
> > > I think we can drop the list_empty() check altogether - it must be th=
ere so
> > > that we don't race in and send a callback for a layout that's already=
 been
> > > returned, but I don't see any harm in that.  Clients should just retu=
rn
> > > NO_MATCHING_LAYOUT.
> > >=20
> >=20
> > The bigger worry (AFAICS) is that there is a potential race between
> > LAYOUTGET and CB_LAYOUTRECALL:
> >=20
> > The lease is set very early in the LAYOUTGET process, and it can be
> > broken at any time beyond that point, even before LAYOUTGET is done and
> > has populated the ls_layouts list. If __break_lease gets called before
> > the list is populated, then the recall won't be sent (because ls_layout=
s
> > is still empty), but the LAYOUTGET will still complete successfully.
> >=20
> > I think we need a check at the end of nfsd4_layoutget, after the
> > nfsd4_insert_layout call to see whether the lease has been broken. If i=
t
> > has, then we should unwind everything and return NFS4ERR_RECALLCONFLICT=
.
>=20
> Shall I drop this fix from nfsd-next, then?
>=20

No, I think Ben's fix is still valid. The problem I'm seeing is a
different issue in the same area of the code. A follow-on patch to
address that is appropriate.

--=20
Jeff Layton <jlayton@kernel.org>
