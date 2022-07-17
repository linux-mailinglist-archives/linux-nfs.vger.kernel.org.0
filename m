Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7F15778DB
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 01:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiGQXn2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Jul 2022 19:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQXn2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Jul 2022 19:43:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB6DFD1D
        for <linux-nfs@vger.kernel.org>; Sun, 17 Jul 2022 16:43:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07BA520527;
        Sun, 17 Jul 2022 23:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658101404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60hnwigijFY6j6ZnJkmma7gV/Mat3FSM1juquE1vQEg=;
        b=lAnBy+DbafXOKLCIWbvVjEy+qi3hKWO4P1uh3PJeL/HV6GPiCUK5STD7AbzJuPnKtKKE/c
        T+akyIlemQSr/crz+8vcagVcZ5hBR2wcoU3VuWZ+MCmT4Tfzs+BUHL1bJJ9PsP2ORltiya
        LAsumZpLgcNKddT/D7vinopsZ5VKgF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658101404;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60hnwigijFY6j6ZnJkmma7gV/Mat3FSM1juquE1vQEg=;
        b=sVjxDKEXh2zKa69Mf9M8b8PIVKQxZ3svMAPclDqG+Mj2LPaTqQYtpQ3edMpQLJipLdMfj3
        aB1dEv0dIR5yCmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D501313A89;
        Sun, 17 Jul 2022 23:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nKYoI5qe1GIGawAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 17 Jul 2022 23:43:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/8] NFSD: use explicit lock/unlock for directory ops
In-reply-to: <ccc3c78c5a6b4b72f6160aeb38ffa36cec94595f.camel@kernel.org>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>,
 <165708109259.1940.685583862810495747.stgit@noble.brown>,
 <ccc3c78c5a6b4b72f6160aeb38ffa36cec94595f.camel@kernel.org>
Date:   Mon, 18 Jul 2022 09:43:16 +1000
Message-id: <165810139630.25184.17789001759725189604@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 16 Jul 2022, Jeff Layton wrote:
> On Wed, 2022-07-06 at 14:18 +1000, NeilBrown wrote:
> >  
> > +	fh_fill_pre_attrs(fhp);
> >  	status = nfsd4_vfs_create(fhp, child, open);
> >  	if (status != nfs_ok)
> >  		goto out;
> >  	open->op_created = true;
> > +	fh_fill_post_attrs(fhp);
> >  
> >  	/* A newly created file already has a file size of zero. */
> >  	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
> 
> Should the fh_fill_post_attrs call be done after nfsd_create_setattr
> instead in this function? It seems like we're filling out the post-op
> attr here before we're actually done changing things...

nfsd_create_setattr() only affects the newly created thing, so it should
not be changing any attributes of the directory that it was created in.
So it should not matter for correctness where fh_fill_post_attrs() is
called, as long as it is between nfsd4_vfs_create() and inode_unlock().

I preferred closer to the former.

Thanks,
NeilBrown
