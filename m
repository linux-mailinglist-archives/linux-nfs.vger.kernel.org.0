Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4117DDB21
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 03:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345140AbjKACuG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 22:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345105AbjKACuF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 22:50:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1AFA4
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 19:49:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4CE751F74A;
        Wed,  1 Nov 2023 02:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698806998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvQ2Wh6B6EcokJBMWdAQEi7dVx3oWf8LexKoaJWDdlQ=;
        b=HnmYFgmSF5oTpiSoQDyaweUTMeNU+XMIwaJcRbaoiq/8BGSpm7cu1/B86uHn2Mpe1dIua9
        lkXuoSIXHBZDv+fJgA0wwsJVoLZMAxTd5IrflxD5jU5xxnW0fJh6xnoQep9bYlGvtZROMo
        tYPrmgZqm8WzXbilZKG1mUTtLK/q8R8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698806998;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvQ2Wh6B6EcokJBMWdAQEi7dVx3oWf8LexKoaJWDdlQ=;
        b=CLd09mOQ2o7riD1L6r9I+q04waM1+KyR8m2tRkIOPp3p7Cjix4WbaoHB1Bq76LcNNpQ2XD
        s1EQlkbq9iD82mBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C048138EC;
        Wed,  1 Nov 2023 02:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n9OuONO8QWU1ZAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 01 Nov 2023 02:49:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of state
In-reply-to: <E8637B0D-B026-4835-A8D4-946B9542965B@oracle.com>
References: <20231101010049.27315-1-neilb@suse.de>,
 <20231101010049.27315-2-neilb@suse.de>,
 <E8637B0D-B026-4835-A8D4-946B9542965B@oracle.com>
Date:   Wed, 01 Nov 2023 13:49:52 +1100
Message-id: <169880699287.24305.9894523784673960041@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 01 Nov 2023, Chuck Lever III wrote:
> 
> > On Oct 31, 2023, at 5:57 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > The NFSv4 protocol allows state to be revoked by the admin and has error
> > codes which allow this to be communicated to the client.
> > 
> > This patch
> > - introduces 3 new state-id types for revoked open, lock, and
> >   delegation state.  This requires the bitmask to be 'short',
> >   not 'char'
> > - reports NFS4ERR_ADMIN_REVOKED when these are accessed
> > - introduces a per-client counter of these states and returns
> >   SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
> >   Decrement this when freeing any admin-revoked state.
> > - introduces stub code to find all interesting states for a given
> >   superblock so they can be revoked via the 'unlock_filesystem'
> >   file in /proc/fs/nfsd/
> >   No actual states are handled yet.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > fs/nfsd/nfs4layouts.c |  2 +-
> > fs/nfsd/nfs4state.c   | 93 +++++++++++++++++++++++++++++++++++++++----
> > fs/nfsd/nfsctl.c      |  1 +
> > fs/nfsd/nfsd.h        |  1 +
> > fs/nfsd/state.h       | 35 +++++++++++-----
> > fs/nfsd/trace.h       |  8 +++-
> > 6 files changed, 120 insertions(+), 20 deletions(-)
> 
>  ....
> 
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index f96eaa8e9413..3af5ab55c978 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -88,17 +88,23 @@ struct nfsd4_callback_ops {
> >  */
> > struct nfs4_stid {
> > refcount_t sc_count;
> > -#define NFS4_OPEN_STID 1
> > -#define NFS4_LOCK_STID 2
> > -#define NFS4_DELEG_STID 4
> > + struct list_head sc_cp_list;
> > + unsigned short sc_type;
> > +#define NFS4_OPEN_STID BIT(0)
> > +#define NFS4_LOCK_STID BIT(1)
> > +#define NFS4_DELEG_STID BIT(2)
> > /* For an open stateid kept around *only* to process close replays: */
> > -#define NFS4_CLOSED_STID 8
> > +#define NFS4_CLOSED_STID BIT(3)
> > /* For a deleg stateid kept around only to process free_stateid's: */
> > -#define NFS4_REVOKED_DELEG_STID 16
> > -#define NFS4_CLOSED_DELEG_STID 32
> > -#define NFS4_LAYOUT_STID 64
> > - struct list_head sc_cp_list;
> > - unsigned char sc_type;
> > +#define NFS4_REVOKED_DELEG_STID BIT(4)
> > +#define NFS4_CLOSED_DELEG_STID BIT(5)
> > +#define NFS4_LAYOUT_STID BIT(6)
> > +#define NFS4_ADMIN_REVOKED_STID BIT(7)
> > +#define NFS4_ADMIN_REVOKED_LOCK_STID BIT(8)
> > +#define NFS4_ADMIN_REVOKED_DELEG_STID BIT(9)
> > +#define NFS4_ALL_ADMIN_REVOKED_STIDS (NFS4_ADMIN_REVOKED_STID | \
> > +     NFS4_ADMIN_REVOKED_LOCK_STID | \
> > +     NFS4_ADMIN_REVOKED_DELEG_STID)
> > stateid_t sc_stateid;
> > spinlock_t sc_lock;
> > struct nfs4_client *sc_client;
> > 
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index fbc0ccb40424..e359d531402c 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -648,6 +648,9 @@ TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
> > TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
> > TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
> > TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> > +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_STID);
> > +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_LOCK_STID);
> > +TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_DELEG_STID);
> 
> This is a bug that pre-dates your change in this patch...
> 
> Since the NFS4_ flags are C macros and not enum symbols,
> TRACE_DEFINE_ENUM() is not necessary. All these can be
> removed, rather than adding three new ones.
> 
> I can fix this up when I apply the series, or if you
> happen to send a v3, you can fix it up first.

OK, thanks.  I guess this use of "ENUM" for things that aren't enums
should have been a red flags :-)

NeilBrown

> 
> 
> > #define show_stid_type(x) \
> > __print_flags(x, "|", \
> > @@ -657,7 +660,10 @@ TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> > { NFS4_CLOSED_STID, "CLOSED" }, \
> > { NFS4_REVOKED_DELEG_STID, "REVOKED" }, \
> > { NFS4_CLOSED_DELEG_STID, "CLOSED_DELEG" }, \
> > - { NFS4_LAYOUT_STID, "LAYOUT" })
> > + { NFS4_LAYOUT_STID, "LAYOUT" }, \
> > + { NFS4_ADMIN_REVOKED_STID, "ADMIN_REVOKED" }, \
> > + { NFS4_ADMIN_REVOKED_LOCK_STID, "ADMIN_REVOKED_LOCK" }, \
> > + { NFS4_ADMIN_REVOKED_DELEG_STID,"ADMIN_REVOKED_DELEG" })
> > 
> > DECLARE_EVENT_CLASS(nfsd_stid_class,
> > TP_PROTO(
> > -- 
> > 2.42.0
> > 
> 
> --
> Chuck Lever
> 
> 
> 

