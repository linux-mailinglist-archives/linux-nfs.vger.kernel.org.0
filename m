Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4E97745CC
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 20:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjHHSqf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjHHSqO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 14:46:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED011E92F
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 09:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1DA96259D
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 14:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895E5C433C9;
        Tue,  8 Aug 2023 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691504446;
        bh=QyGjQCt1JKDY8q5VBpdGkZyOmNX6t+/gtmfuPi5xneo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IaQND/kIAv8aEm5BtCmW+TavTSxvbuFMo/wG2fNlAgZWdvkZxmrinUKfIjncXvlAI
         WrSsHnMaXCeWYnoQLjUToGhsEpNrls7MIdLX0bCbc2RKn6ZKFcsbKmF4teHda8wRtB
         YnEYIF0RC9gciMKSv+NVggbTWXI7Aft3fD7cgIag5xe6s0gfeD+GNWdj83De254F9G
         dpxiOoyIF69pu1IWSj3JPaF5xLa5wxLw5tVvuCDZZxMe+y0lttbPFfdK1niVtZHSkC
         wkjFdHAbYjZmGMKfAjrT+fA5WagLnOQKcX4ZTTuO0N1mNFWGKglEwvTJ+8p1AxCp8R
         4OMrQEs+MImNQ==
Message-ID: <ed02b06f96eeeca4d499583f2bdf31a433921aa1.camel@kernel.org>
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     NeilBrown <neilb@suse.de>, Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com
Date:   Tue, 08 Aug 2023 10:20:44 -0400
In-Reply-To: <ZNJLQIxweTaEsu16@tissot.1015granger.net>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
         <169149440399.32308.1010201101079709026@noble.neil.brown.name>
         <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
         <ea598236b2da9f1aa9b587ca797afaa9de5545c7.camel@kernel.org>
         <ZNJLQIxweTaEsu16@tissot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-08-08 at 10:03 -0400, Chuck Lever wrote:
> On Tue, Aug 08, 2023 at 09:48:42AM -0400, Jeff Layton wrote:
> > On Tue, 2023-08-08 at 09:24 -0400, Chuck Lever wrote:
> > > On Tue, Aug 08, 2023 at 09:33:23PM +1000, NeilBrown wrote:
> > > > On Tue, 08 Aug 2023, Lorenzo Bianconi wrote:
> > > > > Introduce version field to nfsd_rpc_status handler in order to he=
lp
> > > > > the user to maintain backward compatibility.
> > > >=20
> > > > I wonder if this really helps.  What do I do if I see a version tha=
t I
> > > > don't understand?  Ignore the whole file?  That doesn't make for a =
good
> > > > user experience.
> > >=20
> > > There is no UX consideration here. A user browsing the file directly
> > > will not care about the version.
> > >=20
> > > This file is intended to be parsable by scripts and they have to
> > > keep up with the occasional changes in format. Scripts can handle an
> > > unrecogized version however they like.
> > >=20
> > > This is what we typically get with a made-up format that isn't .ini
> > > or JSON or XML. The file format isn't self-documenting. The final
> > > field on each row is a variable number of tokens, so it will be
> > > nearly impossible to simply add another field without breaking
> > > something.
> > >=20
> >=20
> > It shouldn't be a variable number of tokens per line.
>=20
> That's how NFSv4 COMPOUND operations are displayed. For example:
>=20
> 0x5d58666f 0x000000d1 0x000186a3 NFSv4 COMPOUND 0000062034739371 192.168.=
103.67 0 192.168.103.56 20049 OP_SEQUENCE OP_PUTFH OP_READ
>=20
> The list of operations in the displayed compound are currently
> blank-separated tokens at the end of each row.
>=20

Oh! That's a bug in missed in my latest review then. The operations
field was delimited by ':' chars at one point. Lorenzo, did you mean to
change that?

IMO, the list of operations should be one field, separated by a distinct
delimiter (like ':').

>=20
> > If there is, then that's a bug, IMO. We do want it to be simple to
> > just add a new field, published version info notwithstanding.
>=20
> They could be wrapped in curly braces, or separated by commas, to
> make them all one token.
>=20
> I haven't looked at NFSv3 output yet, but I expect those extra
> tokens won't even be there in that case.
>=20

That's probably another bug. Anything not a v4 COMPOUND should have
something as a placeholder. It could just be a single '-' character.

> JSON, yaml, or xml would all address the extensibility problem, just
> as an alternative thought.
>=20

It would probably be fairly simple to output well-formed yaml instead.
JSON and XML are a bit more of a pain.

For now, we can change the output. We do need to have this settled
before this goes to Linus' tree though.
--=20
Jeff Layton <jlayton@kernel.org>
