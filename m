Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5475C71F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGUMsX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 08:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjGUMsW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 08:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F832D56;
        Fri, 21 Jul 2023 05:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E71C5619EB;
        Fri, 21 Jul 2023 12:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B1BC433C8;
        Fri, 21 Jul 2023 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689943699;
        bh=l5FOiFabwBLgQP9O9x3g50FQNGXz9ZF8gT0TyJn7fTo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aemxEATTCJhgwHUAgG/0mx1SxEUKbKNDmHHoMhGmIsEjqr0Bk/sLd4gkIg5sh/uvO
         ctpdUSiOaAGiAacyWt50GIUoYY2FghsiYb2BAMFeVF3HOUQGGflc7wK63bKHfNOiDp
         /7ubwBvwN0Vt4eUhHH1+wztDLpY4Ea2+z9l6qSGLn4xzN6hVVL0Ukz+z3wcpAoE4fo
         9q3DQKE5yXhfEGhgOmumWvDw3/Ex0WCdqkGQh8wuZSA5BRHGlQPZ8NaeOUU90MS2bE
         Vr+kDAehHsgzRMLrw23xGxQnPBMjCqn/1PMbIhcJnwMqFCT0IyNQHSbLEKucIMu9eF
         LbPzKCFHjk1dQ==
Message-ID: <11c799a6cb0bf073dda77f592d70d809fca9b030.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] nfsd: sanely handle inabilty to fetch pre/post
 attributes
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Boyang Xue <bxue@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Jul 2023 08:48:16 -0400
In-Reply-To: <168988936713.11078.5407820394334916284@noble.neil.brown.name>
References: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>
         <168988936713.11078.5407820394334916284@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-07-21 at 07:42 +1000, NeilBrown wrote:
> On Fri, 21 Jul 2023, Jeff Layton wrote:
> > Boyang reported tripping the BUG_ON in set_change_info. While we
> > couldn't confirm it, one way this could happen would be for nfsd_lookup
> > to succeed and then for fh_fill_both_attrs to fail.
> >=20
> > This patchset attempts to (sanely) fix this, usually by aborting the
> > operation if fetching the pre attributes fails. Post-op attribute fetch
> > handling is more difficult to deal with however since we've already don=
e
> > the operation, so this has it just fudge the change_info4 if that
> > occurs.
>=20
> I think both v3 and v4 allow a reply that says "the operation was a
> success but there are no post-op attrs".  With v4 you can say "there is
> no change-attr, but here are some other attrs".  I think.
>=20

v3 has this ability:

      union pre_op_attr switch (bool attributes_follow) {
      case TRUE:
           wcc_attr  attributes;
      case FALSE:
           void;
      };

...we can just set the attributes_follow flag to false there in that
case.

That's not possible with v4, AFAICT. Several of the *4resok structures
contain a change_info4, which just looks like this:

struct change_info4 {
        bool            atomic;
        changeid4       before;
        changeid4       after;
};

We can set "atomic" to false (and this patch does that in this
situation), but I don't believe there is any alternative to the change
attribute. If the underlying fs doesn't support native change attrs, the
server is expected to fake one up somehow (usually from the ctime).

We could (in principle) allow the operation to proceed on v3 even if
fh_fill_pre_attrs fails, but I don't think we can do the same thing with
v4. That said, if getattr is failing then it's somewhat likely that
other operations will fail too, so aborting the operation in this
situation doesn't seem too onerous.

--=20
Jeff Layton <jlayton@kernel.org>
