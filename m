Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1748060C07A
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 03:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiJYBHu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 21:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJYBHg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 21:07:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5630C5DF38
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 17:15:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EEEC42201F;
        Tue, 25 Oct 2022 00:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666656945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfqZYOJsA0f2DXsKxdv8WYy2LHQDk8g1yX/QYm2l0w0=;
        b=siZ9WOZFLTtGc2eB7qHidF7ajz8CjLUDRTk08v8AiHokO0jnUvTC6tsnzp8a85c9Z0DZUZ
        vt6mqL0llE1k4SVJYSfTFUkOnv5fU9vAWCj+6FBU8lWB8dAVvhVDewufLglMYbfgZdluH5
        nbbg6tPmj+AK6vA9TYLTA/V/ZczM+TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666656945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfqZYOJsA0f2DXsKxdv8WYy2LHQDk8g1yX/QYm2l0w0=;
        b=7lAaE4Mi1V4lKwf0ptgwXvwQVDRQ6lRfPEpGTu1SXnp20AXRyWqJ++jp5s0zsT1GGQzBnT
        FUBD2ECT0Ai2+nAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4BF8134CA;
        Tue, 25 Oct 2022 00:15:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v5MDGrAqV2O0SgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 25 Oct 2022 00:15:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file
 garbage collection
In-reply-to: <07483E5C-D990-4D14-95C9-CE9CDF782CC5@oracle.com>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>,
 <166612311828.1291.6808456808715954510.stgit@manet.1015granger.net>,
 <166657883468.12462.7206160925496863213@noble.neil.brown.name>,
 <3d86628c75009a4feb3d20804e6f190dee8b83a3.camel@kernel.org>,
 <07483E5C-D990-4D14-95C9-CE9CDF782CC5@oracle.com>
Date:   Tue, 25 Oct 2022 11:15:40 +1100
Message-id: <166665694091.12462.14921454079429445634@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 25 Oct 2022, Chuck Lever III wrote:
>=20
> > On Oct 24, 2022, at 12:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Mon, 2022-10-24 at 13:33 +1100, NeilBrown wrote:
> >> On Wed, 19 Oct 2022, Chuck Lever wrote:
> >>> +		nfsd_file_lru_add(nf);
> >>> +	else if (refcount_read(&nf->nf_ref) =3D=3D 2)
> >>> +		nfsd_file_unhash_and_put(nf);
> >>=20
> >> Tests on the value of a refcount are almost always racy.
> >=20
> > Agreed, and there's a clear race above, now that I look more closely. If
> > nf_ref is 3 and two puts are racing then neither of them will call
> > nfsd_file_unhash_and_put. We really should be letting the outcome of the
> > decrement drive things (like you say below).
> >=20
> >> I suspect there is an implication that as NFSD_FILE_GC is not set, this
> >> *must* be hashed which implies there is guaranteed to be a refcount from
> >> the hashtable.  So this is really a test to see if the pre-biased
> >> refcount is one.  The safe way to test if a refcount is 1 is dec_and_tes=
t.
> >>=20
> >> i.e. linkage from the hash table should not count as a reference (in the
> >> not-GC case).  Lookup in the hash table should fail if the found entry
> >> cannot achieve an inc_not_zero.  When dec_and_test says the refcount is
> >> zero, we remove from the hash table (certain that no new references will
> >> be taken).
> >>=20
> >=20
> > This does seem a more sensible approach. That would go a long way toward
> > simplifying nfsd_file_put.
>=20
> So I cut-and-pasted the approach you used in the patch you sent a few
> weeks ago. I don't object to replacing that... but I don't see exactly
> where you guys are going with this.
>=20

Where I'm going with this is to suggest that this ref-counting oddity is
possibly the cause of the occasional refcounting problems that you
have had with nfsd.

I think that the hash table should never own a reference to the
nfsd_file.  If the refcount ever reaches zero, then it gets removed from
the hash table.

  if (refcount_dec_and_test())
      if (test_and_clear_bit(HASHED,...))
         delete from hash table

Transient references are counted.
For NFSv2,3 existence in the LRU is counted (I don't think they are at presen=
t).
For NFSv4, references from nfs4_file are counted.
But presence in the hash table is only indicated by the HASHED flag.

I think this would make the ref counting more robust.

NeilBrown
