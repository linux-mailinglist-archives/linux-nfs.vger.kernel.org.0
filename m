Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1E270EAD2
	for <lists+linux-nfs@lfdr.de>; Wed, 24 May 2023 03:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbjEXBbM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 21:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbjEXBbI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 21:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8A2130;
        Tue, 23 May 2023 18:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0863637BC;
        Wed, 24 May 2023 01:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A080C433D2;
        Wed, 24 May 2023 01:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684891867;
        bh=DnxnRa2DTAmSigijJmg8NtBzYVswxdoupVCoK1aLSBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSemRJWd1W6GeA8KIUoAwvwygaMbcZvPbXxr//RRqJJsMkYAQtUfcx6pzfvjPNZZW
         6SCPAJH4MTpYIAOlIabc1M5/Gjf7CopeeC+Vmazfhk33Ahman7BMwM8ZqxKv8aHNB2
         qALhj9GUq/0Jc1OXwGlgGAxQH+wX1vdt4EQ/BlYiBmRaE4P1qMCRDqkDMEx7KdTY4H
         V/ljgjOouhKKjI/7gIksnRGGYSdkXZG6dH/FNWVo0otuFy+i+nlHoZwOgT29not+sv
         kvAXilJg8yes63L6YesBrqDY6/0nxrn0JtJJu/qqI1LQZ7/ZWt5JFDBMywBGGus0uZ
         +bPr7qybsHrVQ==
Date:   Tue, 23 May 2023 21:31:04 -0400
From:   Chuck Lever <cel@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        dai.ngo@oracle.com
Subject: Re: [PATCH][next] nfsd: Replace one-element array with
 flexible-array member
Message-ID: <ZG1o2LFiRekz/pMy@manet.1015granger.net>
References: <ZG1d51tGG4c97qqb@work>
 <ZG1iBLw85MxtysWI@manet.1015granger.net>
 <4b9c7386-c2b1-2eb7-d248-ddfdc3c2cd1f@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b9c7386-c2b1-2eb7-d248-ddfdc3c2cd1f@embeddedor.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 23, 2023 at 07:11:37PM -0600, Gustavo A. R. Silva wrote:
> 
> On 5/23/23 19:01, Chuck Lever wrote:
> > On Tue, May 23, 2023 at 06:44:23PM -0600, Gustavo A. R. Silva wrote:
> > > One-element arrays are deprecated, and we are replacing them with
> > > flexible array members instead. So, replace a one-element array
> > > with a flexible-arrayº member in struct vbi_anc_data and refactor
> > 
> > I don't know what "struct vbi_anc_data" is. Is the patch description
> > correct?
> 
> Oops, copy/paste error. I'll fix it up. :)
> 
> > 
> > 
> > > the rest of the code, accordingly.
> > > 
> > > This results in no differences in binary output.
> > > 
> > > Link: https://github.com/KSPP/linux/issues/79
> > > Link: https://github.com/KSPP/linux/issues/298
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > 
> > > ---
> > >   fs/nfsd/nfs4callback.c | 2 +-
> > >   fs/nfsd/xdr4.h         | 2 +-
> > >   2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index 4039ffcf90ba..2c688d51135d 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -353,7 +353,7 @@ encode_cb_recallany4args(struct xdr_stream *xdr,
> > >   {
> > >   	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
> > >   	encode_uint32(xdr, ra->ra_keep);
> > > -	encode_bitmap4(xdr, ra->ra_bmval, ARRAY_SIZE(ra->ra_bmval));
> > > +	encode_bitmap4(xdr, ra->ra_bmval, 1);
> > 
> > I find the new code less self-documenting.
> > 
> > 
> > >   	hdr->nops++;
> > >   }
> > > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > > index 510978e602da..68072170eac8 100644
> > > --- a/fs/nfsd/xdr4.h
> > > +++ b/fs/nfsd/xdr4.h
> > > @@ -899,7 +899,7 @@ struct nfsd4_operation {
> > >   struct nfsd4_cb_recall_any {
> > >   	struct nfsd4_callback	ra_cb;
> > >   	u32			ra_keep;
> > > -	u32			ra_bmval[1];
> > > +	u32			ra_bmval[];
> > 
> > This is not a placeholder for "1 or more elements". We actually want
> > just a single u32 element in this array. Doesn't this change the
> > sizeof(struct nfsd4_cb_recall_any) ?
> 
> I see. Yes, it does change the size. Can we replace it with a simple
> object of type u32? or do you actually need this to stay an array?

It's not impossible to make it a scalar u32, however...

In this area of code, *_bmval is always a bitmap -- an array of u32s.
Helpers like encode_bitmap4() assume an array. I think it would be
less confusing overall to human readers if it remained an array.

In this case, it is a single element array because CB_RECALL_ANY
doesn't happen to use bits above the first 32-bit word of the
bitmap.

We could make it a 2-element array, I think, without harm. Send a
patch for that, and Dai can test it to make sure there are no
unexpected interoperability consequences.

I hope that would avoid suspicious-looking array definitions.


> > >   };
> > >   #endif
> > > -- 
> > > 2.34.1
> > > 
