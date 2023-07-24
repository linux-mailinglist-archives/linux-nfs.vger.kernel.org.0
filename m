Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA4675F375
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 12:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGXKhF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 06:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjGXKhD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 06:37:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B30E6;
        Mon, 24 Jul 2023 03:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14E1061049;
        Mon, 24 Jul 2023 10:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCE9C433C7;
        Mon, 24 Jul 2023 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690195019;
        bh=erjTcGyG14w2Zi8fvEJFyZ49i/awkMiYG5EL4ynnBh0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=H/p3Ry3MKJm9ScMIauv5R4TtCh0tgbTEWXEToPVmvw69RtnluKXDl75pU0C+VC8Rh
         2dIkoSSefai9END6qHTf68ETtt4E3qJZpWlsK7ewQ08F4eCh+4tlY09q7ZZM8k3ulu
         thwzrsCX9to2RwSRCZidhdI9F/wLnWClrgj5QdQxjreMl08jSUJCI2RpnDl1FDAOuB
         /WCKhDwIuw8C/+r40C8Md0WnGGg1kluUv+dUhFP9Lch/7NCYuph6lr5H1Ypm5ndnIN
         tqZ2BuG6fLD72XzSKUDUT3ziHbZlkXi4MON4K9pN2JW1w6Q/cyhfhRqUE3szDNKvAm
         +U6pOn7mB0MtA==
Message-ID: <963cc8896ff6a6759c57f1d97e51f35972d4fc6d.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] nfsd: sanely handle inabilty to fetch pre/post
 attributes
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Boyang Xue <bxue@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jul 2023 06:36:57 -0400
In-Reply-To: <168998604179.11078.18238251274062077853@noble.neil.brown.name>
References: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>
        , <168988936713.11078.5407820394334916284@noble.neil.brown.name>
        , <11c799a6cb0bf073dda77f592d70d809fca9b030.camel@kernel.org>
         <168998604179.11078.18238251274062077853@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 2023-07-22 at 10:34 +1000, NeilBrown wrote:
> On Fri, 21 Jul 2023, Jeff Layton wrote:
> > On Fri, 2023-07-21 at 07:42 +1000, NeilBrown wrote:
> > >=20
> > > I think both v3 and v4 allow a reply that says "the operation was a
> > > success but there are no post-op attrs".  With v4 you can say "there =
is
> > > no change-attr, but here are some other attrs".  I think.
> > >=20
> >=20
> > v3 has this ability:
> >=20
> >       union pre_op_attr switch (bool attributes_follow) {
> >       case TRUE:
> >            wcc_attr  attributes;
> >       case FALSE:
> >            void;
> >       };
> >=20
> > ...we can just set the attributes_follow flag to false there in that
> > case.
> >=20
> > That's not possible with v4, AFAICT. Several of the *4resok structures
> > contain a change_info4, which just looks like this:
> >=20
> > struct change_info4 {
> >         bool            atomic;
> >         changeid4       before;
> >         changeid4       after;
> > };
>=20
> Yes...  I was thinking of GETATTR which reports a bitmap of all the
> attributes that it can return.  Though I'm not sure if the server is
> "allowed" to not return something that it has said is "supported".  And
> I think changeid has to be "supported".  I'm not sure.
>
> But anyway, that doesn't help change_info4 which comes with
> directory-modifying operation.
>=20
> >=20
> > We can set "atomic" to false (and this patch does that in this
> > situation), but I don't believe there is any alternative to the change
> > attribute. If the underlying fs doesn't support native change attrs, th=
e
> > server is expected to fake one up somehow (usually from the ctime).
>=20
> I had a look again at the current code and your patch, and I think that
> if the "post' vfs_getattr() fails, then the operation succeeds, the
> change_info is marked non-atomic (as you say) and the "after" changeid is
> set to an uninitialised value. =A0Is that right?  Did I miss something?
> Maybe we should set it to the pre value plus 1.
>=20
> It probably doesn't matter at all in practice, but if I'm right and it
> is using an uninitialized value, we should at least fix that.
>=20
> Thanks - your v3 patch looks good in general.  I like the must_check and
> the goto structure.
>=20
> Thanks,
> NeilBrown
>=20
>=20


The current patch sets the missing pre/post values to 0. I'm happy to
change that to pre-value+1 though if you think that'd be more correct.
The client already fudges the changeid like that in the CB_GETATTR case,
so I doubt that would break anything.
--=20
Jeff Layton <jlayton@kernel.org>
