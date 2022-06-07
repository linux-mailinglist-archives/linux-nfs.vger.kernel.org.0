Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B8653F484
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 05:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiFGDaF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 23:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiFGDaD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 23:30:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D36427E8
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 20:30:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15B931F935;
        Tue,  7 Jun 2022 03:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654572601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z17jXaZw6PMYA3MUMUTZTutboCGUl/XThYdDTayUkNg=;
        b=MIPU8+ZtK5Nob3Hm3eZIRt2WMHe3CQqHbzXjma3IklEt9KRgfNzM+wA5CxKJ0QqhMgvMlk
        QbWAFNSsLA1igxML4ckcF1BDZ5hpRim5p3klGEv6FKzF0z/F1a5OdLXg45I73K/9Jjmp3G
        Gcr3KPrPdbnC78EzOrse+MgvFMaxer0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654572601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z17jXaZw6PMYA3MUMUTZTutboCGUl/XThYdDTayUkNg=;
        b=7Ql5rHDqPr6esD500wF9zA7dtwokF9JFuZM/LGWH3vVNoPxV+pBaXy1eS1sn/ZSk1Eo3C0
        WDLL+Me4tBb3KHCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD89C13A5F;
        Tue,  7 Jun 2022 03:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qUzEJDfGnmJJOAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Jun 2022 03:29:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] SUNRPC: Fix the calculation of xdr->end in
 xdr_get_next_encode_buffer()
In-reply-to: <EA34A2F2-D80A-44B0-8AF3-2234069DDC29@oracle.com>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>,
 <165445910560.1664.5852151724543272982.stgit@bazille.1015granger.net>,
 <20220606220938.GE15057@fieldses.org>,
 <165456356541.22243.8883363674329684173@noble.neil.brown.name>,
 <D3608A6C-0CA9-434B-BF56-79AB33793AB4@oracle.com>,
 <EA34A2F2-D80A-44B0-8AF3-2234069DDC29@oracle.com>
Date:   Tue, 07 Jun 2022 13:29:56 +1000
Message-id: <165457259601.22243.4068338030298862634@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 07 Jun 2022, Chuck Lever III wrote:
> > On Jun 6, 2022, at 10:35 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
> >=20
> >> On Jun 6, 2022, at 8:59 PM, NeilBrown <neilb@suse.de> wrote:
> >> We then assign frag{1,2}bytes and have another chunk of code that looks
> >> wrong to me.  I'd like
> >>=20
> >>  if (xdr->iov) {
> >> 	xdr->iov->iov_len +=3D frag1bytes;
> >> 	xdr->iov =3D NULL;
> >>  } else {
> >>       xdr->buf->page_len +=3D frag1bytes;
> >>       xdr->page_ptr++;
> >>  }
> >>=20
> >> Note that this changes the code NOT to increment pagE_ptr if iov was not
> >> NULL.  I cannot see how it would be correct to do that.  Presumably this
> >> code is never called with iov !=3D NULL ???
> >=20
> > That strikes me as a good change. I will add it to this series as
> > another patch.
> >=20
> > Yes, this code is called by the server's READDIR encoder with iov =3D NUL=
L.
> > See nfsd3_init_dirlist_pages().
>=20
> This change breaks READDIR, looks like.

Thanks for testing...

I looked again, and I see that svcxdr_init_encode() initialises
->page_ptr to "buf->page - 1".  So we need a +1 when moving from the
'head' to the pages.

Commit 05638dc73af2 ("nfsd4: simplify server xdr->next_page use")

explains why.  I'm not sure I completely agree with the reasoning (head
really is a special case), but it probably isn't worth "fixing".

Thanks,
NeilBrown

>=20
> --
> Chuck Lever
>=20
>=20
>=20
>=20
