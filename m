Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCFE698591
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Feb 2023 21:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjBOUaW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 15:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBOUaV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 15:30:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C43A1F924
        for <linux-nfs@vger.kernel.org>; Wed, 15 Feb 2023 12:30:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49FAD1F88B;
        Wed, 15 Feb 2023 20:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1676493019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uTfbsBiCKxLLYfBu0TxvUi6I0BHwy0O0/rdEXT1NlP4=;
        b=C+wjHPTOBBzYf8v2OPzrjzw+IEjLQm0VmsYqq3WV50jjBrVnd3oIK9q3DNQqvLslC/B5iQ
        UhNQM+VhyuQ+1t4D/o2TWAZ5mSNHOUF30OAwX6z5XPVZnZxYtdlBOc0jN/NaNNKHL2wTC8
        V0KobNf9tUhsZxq+Y19neGA1kY57Jes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1676493019;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uTfbsBiCKxLLYfBu0TxvUi6I0BHwy0O0/rdEXT1NlP4=;
        b=A2kQuQ3b/3PrapguZRJ1JWJJJ1r27rH0dsPgXW/rdPfZDjqK5SYDPMkmALBXkL0U9Ty7Nw
        g96hbT2OKNkjBrCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51720134BA;
        Wed, 15 Feb 2023 20:30:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MP2kONhA7WNAHwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 15 Feb 2023 20:30:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Anna Schumaker" <anna@kernel.org>
Cc:     "Trond Myklebust" <trondmy@kernel.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3] NFSv3: handle out-of-order write replies.
In-reply-to: <CAFX2Jfnq6wcex_iwNP9gvpHLWbgSSkBDsy4cOLLHd3z5xiwq4w@mail.gmail.com>
References: <167633352764.1896.5445901294734308583@noble.neil.brown.name>,
 <167643799060.10099.2241433267195533803@noble.neil.brown.name>,
 <CAFX2Jfnq6wcex_iwNP9gvpHLWbgSSkBDsy4cOLLHd3z5xiwq4w@mail.gmail.com>
Date:   Thu, 16 Feb 2023 07:30:13 +1100
Message-id: <167649301340.15170.803705850078251758@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 16 Feb 2023, Anna Schumaker wrote:
> Hi Neil,
> 
> On Wed, Feb 15, 2023 at 12:13 AM NeilBrown <neilb@suse.de> wrote:
> >
> > +static void nfs_ooo_merge(struct nfs_inode *nfsi,
> > +                         u64 start, u64 end)
> > +{
> > +       int i, cnt;
> > +
> > +       if (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER)
> > +               /* No point merging anything */
> > +               return;
> > +       if (!S_ISREG(nfsi->vfs_inode.mode))
> 
> Um, should this be "vfs_inode.i_mode"? I'm also curious how you've
> tested this, since the code won't compile without this change?

I had removed this whole 'if' because I realised it wasn't really
needed.
The problem was that I hadn't refreshed that patch after final testing
:-(

I'll resend.

Thanks,
NeilBrown
